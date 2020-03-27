#' Übungen im PsyMSc 1 Seminar, Sommersemester 2020
#'
#' Mit diesen Funktionen können Sie die Übungen zu den einzelnen Sitzungen aufrufen.
#'
#' @export

#### Kernfunktionen: Aufruf der einzelnen Sitzungen ####
Sitzung_1 <- function() {
  library(learnr)
  if (!('fontawesome' %in% rownames(installed.packages()))) {
    devtools::install_github("rstudio/fontawesome", upgrade = 'never')
  }
  learnr::run_tutorial('intro', package = 'PsyMSc1')
}
