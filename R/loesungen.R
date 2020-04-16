#' @name Lösungen
#' @aliases Lösungen_1
#' @aliases Lösungen_2
#' 
#' @title R-Skripte zur Lösung der Aufgaben im PsyMSc 1 Seminar, Sommersemester 2020
#'
#' Mit diesen Funktionen können Sie die Lösungen zu den Übungen in den einzelnen Sitzungen aufrufen. Die Passwörter werden nach dem Abgabetermin im OLAT bekannt gegeben.
#'

#### Kernfunktionen: Aufruf der einzelnen Sitzungen ####
Loesungen_1 <- function(password) {
  if (digest::digest(password) != 'c979e33e1fdd5a1b5a3f5d7d0330a362') {
    stop('Leider haben Sie nicht das richtige Passwort eingegeben.', call. = FALSE)
  }  else {
    learnr::run_tutorial('intro_lo', package = 'PsyMSc1')
  }
}

Loesungen_2 <- function(password) {
     if (digest::digest(password) != "6adb4894cab39c7d479b5284a1a907b2") {
          stop('Leider haben Sie nicht das richtige Passwort eingegeben.', call. = FALSE)
     }  else {
          learnr::run_tutorial('EFA_lo', package = 'PsyMSc1')
     }
}