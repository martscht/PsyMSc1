#' @name Loesungen
#' @aliases Loesungen_1
#' @aliases Loesungen_2
#' @aliases Loesungen_3
#' @aliases Loesungen_4
#' 
#' @title R-Skripte zur Lösung der Aufgaben im PsyMSc 1 Seminar, Sommersemester 2020
#'
#' @description Mit diesen Funktionen können Sie die Lösungen zu den Übungen in den einzelnen Sitzungen aufrufen. Die Passwörter werden nach dem Abgabetermin im OLAT bekannt gegeben.
#' 
#' @param password Ein \code{character} mit dem Passwort für die jeweilige Sitzung.
#'
#' @seealso Sitzungen

#### Kernfunktionen: Aufruf der einzelnen Sitzungen ####
#' @rdname Loesungen
#' @export
Loesungen_1 <- function(password) {
  if (digest::digest(password) != 'c979e33e1fdd5a1b5a3f5d7d0330a362') {
    stop('Leider haben Sie nicht das richtige Passwort eingegeben.', call. = FALSE)
  }  else {
    compile('intro_lo')
  }
}

#' @rdname Loesungen
#' @export
Loesungen_2 <- function(password) {
     if (digest::digest(password) != "6adb4894cab39c7d479b5284a1a907b2") {
       stop('Leider haben Sie nicht das richtige Passwort eingegeben.', call. = FALSE)
     }  else {
       compile('EFA_lo')
     }
}

#' @rdname Loesungen
#' @export
Loesungen_3 <- function(password) {
  if (digest::digest(password) != "41f1470ac9d55f8f55254f21ec63fb71") {
    stop('Leider haben Sie nicht das richtige Passwort eingegeben.', call. = FALSE)
  }  else {
    compile('CFA_lo')
  }
}

#' @rdname Loesungen
#' @export
Loesungen_4 <- function(password) {
  if (digest::digest(password) != "8907a926ba43ceb87047b0055529250c") {
    stop('Leider haben Sie nicht das richtige Passwort eingegeben.', call. = FALSE)
  }  else {
    compile('SEM_lo')
  }
}

