# nocov start
.onLoad <- function(libname, pkgname){
    cache_dir <- file.path(path.expand("~"), ".cache", pkgname)
    if (dir.exists(cache_dir)) {
        return(TRUE)
    }
    packageStartupMessage("creating cache directory ", cache_dir)
    dir.create(cache_dir, recursive = TRUE)
}
# nocov end
