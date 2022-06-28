test_that("multiplication works", {
  expect_identical(
      get_bib_file(),
      system.file(
        package='iSEEWorkshopEuroBioc2020',
        'vignettes', 'bib', 'iSEEWorkshopEuroBioc2020.bib')
  )
})
