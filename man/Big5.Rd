% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{Big5}
\alias{Big5}
\title{Big5 Daten (2014)}
\format{
An object of class \code{data.frame} with 19711 rows and 19 columns.
}
\source{
Der Originaldatensatz ist ein Onlinedatensatz, wird seit 2012 erfasst und ist auf [openpsychometrics.org](https://openpsychometrics.org/_rawdata/) als *.zip* downloadbar.
}
\usage{
Big5
}
\description{
Selbstberichte zu Persönlichkeitseigenschaften. Gekürzter Datensatz, der nur jeweils die ersten 3 Items zu den fünf Persönlichkeitseigenschaften "Extraversion", "Neurotizismus", "Offenheit", "Verträglichkeit" und "Gewissenhaftigkeit".
}
\details{
@format Zu den demografischen Daten gehören Alter (`age`), Englisch als Muttersprache (`engant`, 1=yes, 2=no, 0=missed), Geschlecht (`gender`, 1=Male, 2=Female, 3=Other, 0=missed) und Herkunftsland (`country`, ISO-kodiert, bspw. "DE" = Deutschland, "FR" = Frankreich, "EM" = Vereinigte Arabische Emirate, "US" = Vereinigten Staaten von Amerika). Die Persönlichkeitseigeschaften sind: Extraversion (engl. *extraversion*, Items: `E1`, `E2`, `E3`), Neurotizismus (engl. *neuroticism*, Items: `N1`, `N2`, `N3`),  Verträglichkeit (engl. *agreeableness*, Items: `A1`, `A2`, `A3`),  Gewissenhaftigkeit  (engl. *conscientiousness*, Items: `C1`, `C2`, `C3`) und  Offenheit für Erfahrungen (engl. *openness*, Items: `O1`, `O2`, `O3`).
}
\keyword{datasets}
