#' Bibliography File Path
#'
#' @return A character value representing the path to the bibliography
#' @export
#'
#' @examples
#' get_bib_file()
get_bib_file <- function() {
    system.file(
        package='iSEEWorkshopEuroBioc2020',
        'vignettes', 'bib', 'iSEEWorkshopEuroBioc2020.bib')
}
