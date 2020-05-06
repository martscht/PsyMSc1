#' @name Sitzungen
#' @aliases Sitzung_1
#' @aliases Sitzung_2
#' @aliases Sitzung_3
#' @aliases Sitzung_4
#'  
#' @title Übungen im PsyMSc 1 Seminar, Sommersemester 2020
#'
#' @description Mit diesen Funktionen können Sie die Übungen zu den einzelnen Sitzungen aufrufen. Die Funktionen nehmen keine Argumente entgegen.
#'
#' @details Durch die verschiedenen Funktionen können unterschiedliche Sitzungen aufgerufen werden. Dabei ist das Suffix _* immer die Nummer der jeweiligen Sitzung (z.B. Sitzung_1 für die 1. Sitzung). Die Inhalte wurden in \code{learnr} umgesetzt und das Kompilieren der Dateien findet anhand dieses Pakets statt.
#' 
#' @seealso Loesungen

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
  compile('intro')
}

#' @rdname Sitzungen
#' @export
Sitzung_2 <- function() {
  library(learnr)
  if (!('fontawesome' %in% rownames(installed.packages()))) {
    devtools::install_github("rstudio/fontawesome", upgrade = 'never')
  }
  if (!('gradethis' %in% rownames(installed.packages()))) {
    devtools::install_github('rstudio-education/gradethis', upgrade = 'never')
  }
  library(gradethis)
  compile('EFA')
}

#' @rdname Sitzungen
#' @export
Sitzung_3 <- function() {
  library(learnr)
  if (!('fontawesome' %in% rownames(installed.packages()))) {
    devtools::install_github("rstudio/fontawesome", upgrade = 'never')
  }
  if (!('gradethis' %in% rownames(installed.packages()))) {
    devtools::install_github('rstudio-education/gradethis', upgrade = 'never')
  }
  library(gradethis)
  message('Leider ist die Sitzung noch nicht fertig :(.')
}

#' @rdname Sitzungen
#' @export
Sitzung_4 <- function() {
  library(learnr)
  if (!('fontawesome' %in% rownames(installed.packages()))) {
    devtools::install_github("rstudio/fontawesome", upgrade = 'never')
  }
  if (!('gradethis' %in% rownames(installed.packages()))) {
    devtools::install_github('rstudio-education/gradethis', upgrade = 'never')
  }
  library(gradethis)
  message('Leider ist die Sitzung noch nicht fertig :(.')
}