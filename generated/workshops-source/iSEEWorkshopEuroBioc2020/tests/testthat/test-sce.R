
test_that("demo_sce throws error if file doesn't exist", {
    
    # assumes the file does not exist at this point
    # make sure all other tests clean up after themselves
    
    expect_error(
        suppressWarnings(load_demo_sce("missing")),
        "cannot open the connection"
    )
    
})

test_that("path to cache works", {
    
    expect_match(
        path_demo_sce("dummy"),
        ".cache/iSEEWorkshopEuroBioc2020/dummy.rds"
    )
    
})

test_that("saving to cache works", {
    
    expect_null(
        cache_demo_sce(SingleCellExperiment(), "dummy")
    )
    
    unlink(path_demo_sce("dummy"))
    
})

test_that("demo_sce works if file does exist", {
    
    cache_demo_sce(SingleCellExperiment(), "dummy")
    
    expect_s4_class(
        load_demo_sce("dummy"),
        "SingleCellExperiment"
    )
    
    unlink(path_demo_sce("dummy"))
    
})
