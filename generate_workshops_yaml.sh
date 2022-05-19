set -xe

rm -rf old-generated/ && mkdir -p generated && mv generated/ old-generated/

mkdir -p generated/errors
mkdir -p generated/warnings
mkdir -p generated/workshops-source/

cat << "EOF" > generated/workshop-values.yaml
extraFileMappings:
EOF

cat << "EOF" > generated/workshop-toolconf-values.yaml
configs:
  tool_conf_bioc.xml: |
    <?xml version='1.0' encoding='utf-8'?>
      <toolbox monitor="true">
          <tool file="interactive/bioconductor_rstudio.xml" />
          <tool file="interactive/bioconductor_jupyter.xml" />
EOF


function create_manifest {

  LONG_NAME=$(grep -m 1 "Title:" "generated/workshops-source/$SHORT_NAME/DESCRIPTION" | awk -F 'Title: ' '{print $2}')

  PACKAGE_NAME=$(grep -m 1 "Package:" "generated/workshops-source/$SHORT_NAME/DESCRIPTION" | awk -F 'Package: ' '{print $2}')

  MEDIUM_NAME=$(echo "RStudio - $PACKAGE_NAME")

  cat << EOF >> "generated/workshop-values.yaml"
  /galaxy/server/tools/interactive/biocworkshop_${SHORT_NAME}.xml:
    useSecret: false
    applyToJob: true
    applyToWeb: true
    applyToWorkflow: true
    applyToNginx: true
    tpl: false
    content: |
  $(sed """s@##PLACEHOLDERNAME##@${SHORT_NAME}@g
            s@##PLACEHOLDERLONGNAME##@${LONG_NAME}@g
            s@##PLACEHOLDERCONTAINER##@${FULL_CONTAINER}@g
            s@##PLACEHOLDERMEDIUMNAME##@${MEDIUM_NAME}@g
            s@^@      @g""" workshop-wrapper-template.yaml)
EOF

  cat << EOF >> generated/workshop-toolconf-values.yaml
          <tool file="interactive/biocworkshop_${SHORT_NAME}.xml" />
EOF

}

while IFS="" read -r url
do
  SHORT_NAME=$(echo "$url" | awk -F'/' '{print $5}')

  ( cd generated/workshops-source/ && git clone "$url" --depth 1 && rm -rf $SHORT_NAME/.git/ )

  CONTAINER_IMAGE=$(grep -rh "repository:" "generated/workshops-source/$SHORT_NAME/.github/workflows" | 
head -n 1 | awk -F'repository: ' '{print $2}')

  # handle ${{ env.repo-name }}
  if [[ -n $(echo "$CONTAINER_IMAGE" | grep "env.repo-name") ]];
  then 
    CONTAINER_IMAGE=$(grep -rh "repo-name:" "generated/workshops-source/$SHORT_NAME/.github/workflows" | 
head -n 1 | awk -F'repo-name: ' '{print $2}')
  fi

  # handle others by looking in readme
  if [[ -n $(echo "$CONTAINER_IMAGE" | grep '${{') || -z "$CONTAINER_IMAGE" ]];
  then 
    CONTAINER_IMAGE=$(awk '/docker run/{x=1}x&&/\//{print;exit}' "generated/workshops-source/$SHORT_NAME/README.md" | grep -oh "\w*/\w*" | tail -n 1 | awk -F' ' '{print $NF}')
  fi

  # Check if container repo name complies
  REPO_PATTERN="[a-z0-9_\-]+/[a-z0-9_\-]+"
  if ! [[ $CONTAINER_IMAGE =~ $REPO_PATTERN ]];
  then
    echo "$CONTAINER_IMAGE" > "generated/errors/$SHORT_NAME.reponame-pattern"
    # default to repo name if not
    CONTAINER_IMAGE=$(echo $url | awk -F'github.com/' '{print tolower($2)}')
  fi


  TAG=$(grep -rh "tags:" "generated/workshops-source/$SHORT_NAME/.github/workflows" | head -n 1 | awk -F 'tags: ' '{print $2}')

  # Check if container tag name is correct
  TAG_PATTERN="[a-z0-9_\-]+"
  if ! [[ $TAG =~ $TAG_PATTERN ]];
  then
    README_CONTAINER_IMAGE=$(awk '/docker run/{x=1}x&&/\//{print;exit}' "generated/workshops-source/$SHORT_NAME/README.md" | grep -Eoh "\w*/\w*(:[^\s]+)?" | tail -n 1 | awk -F' ' '{print $NF}')
    if [[ -n $(echo "$README_CONTAINER_IMAGE" | grep ':') ]];
    then
      TAG=$(echo "$README_CONTAINER_IMAGE" | awk -F':' '{print $2}')
    else
      TAG=""
    fi
  fi

  CONTAINER_TAG=${TAG:-latest}

  # Check if container tag name is correct
  if ! [[ $CONTAINER_TAG =~ $TAG_PATTERN ]];
  then
    echo "$CONTAINER_TAG" > "generated/error/$SHORT_NAME.tagname-pattern"
    # default to latest
    CONTAINER_TAG="latest"
  fi
  # remove trailing whitespaces (came up to handle \r from windows)
  FULL_CONTAINER=$(echo "$(echo $CONTAINER_IMAGE | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'):$(echo $CONTAINER_TAG | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')")

  # Check if container name is correct
  NAME_PATTERN="[a-z0-9_\-]+/[a-z0-9_\-]+:[a-z0-9_\-]+"
  if ! [[ $FULL_CONTAINER =~ $NAME_PATTERN ]];
  then
    echo "$FULL_CONTAINER" > "generated/errors/$SHORT_NAME.wrongname"
  fi

  AUTO_CONTAINER="almahmoud/workshops-auto-$(echo $url | awk -F'/' '{print tolower($NF)}'):latest"
  # Check if container exists
  bash -c "docker manifest inspect \"$FULL_CONTAINER\" || docker manifest inspect \"$AUTO_CONTAINER\"" || bash -c "echo \"$FULL_CONTAINER\" > \"generated/errors/$SHORT_NAME.missing\" && docker build \"generated/workshops-source/$SHORT_NAME\" -t \"$AUTO_CONTAINER\" && docker push \"$AUTO_CONTAINER\"" && create_manifest

done < workshoplist

cat << "EOF" >> generated/workshop-toolconf-values.yaml
      </toolbox>
EOF
