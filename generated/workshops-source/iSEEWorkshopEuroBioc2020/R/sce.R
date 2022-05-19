#' Demonstration Data Sets
#'
#' @param x A `SingleCellExperiment` object.
#' @param name Data set identifier.
#'
#' @return 
#' `load_demo_sce()` returns a `SingleCellExperiment` object.
#' 
#' `path_demo_sce()` returns the path to the cached RDS file.
#' 
#' `cache_demo_sce()` returns `NULL`; it is called for its side effect of writing a cache file.
#' 
#' @export
#'
#' @examples
#' library(SingleCellExperiment)
#' 
#' x <- SingleCellExperiment()
#' cache_demo_sce(x, "empty")
#' 
#' sce <- load_demo_sce("empty")
#' 
#' path_demo_sce("empty")
load_demo_sce <- function(name = c("pbmc3k")) {
    file_sce <- path_demo_sce(name)
    sce <- readRDS(file_sce)
    sce
}

#' @rdname load_demo_sce
#' @export
#' 
#' @importFrom methods getPackageName
path_demo_sce <- function(name) {
    cache_dir <- file.path(path.expand("~"), ".cache", getPackageName())
    base_file <- sprintf("%s.rds", name)
    file_sce <- file.path(cache_dir, base_file)
    file_sce
}

#' @rdname load_demo_sce
#' @export
cache_demo_sce <- function(x, name) {
    file_sce <- path_demo_sce(name)
    message("Saving object to ", file_sce)
    saveRDS(x, file_sce)
}