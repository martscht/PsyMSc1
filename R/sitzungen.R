#' @name Sitzungen
#' @aliases Sitzung_1
#' @aliases Sitzung_2
#' 
#' @title Übungen im PsyMSc 1 Seminar, Sommersemester 2020
#'
#' Mit diesen Funktionen können Sie die Übungen zu den einzelnen Sitzungen aufrufen. Die Funktionen nehmen keine Argumente entgegen.
#'

#### Kernfunktionen: Aufruf der einzelnen Sitzungen ####

#' @rdname Sitzungen
#' @export
Sitzung_1 <- function() {
  library(learnr)
  if (!('fontawesome' %in% rownames(installed.packages()))) {
    devtools::install_github("rstudio/fontawesome", upgrade = 'never')
  }
  if (!('gradethis' %in% rownames(installed.packages()))) {
    devtools::install_github('rstudio-education/gradethis', upgrade = 'never')
  }
  library(gradethis)
  learnr::run_tutorial('intro', package = 'PsyMSc1')
}
