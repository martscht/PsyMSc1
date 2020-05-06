#' fairplayer Daten (2009)
#' 
#' Selbstberichte zur relationalen Aggression, Empathie und sozialen Intelligenz aus einer Studie zur Prävention von Bullying bei Jugendlichen.
#' 
#' @format Verhaltensbezogene Selbstberichte auf jeweils drei Items zur relationalen Aggression (`ra`), Empathie (`em`) und sozialen Intelligenz (`si`). Diese insgesamt 9 Indikatoren liegen zu drei Messzeitpunkten (`t1`, `t2` und `t3`) vor.  Über die Items hinaus sind vier weitere Variablen im Datensatz enthalten, die den Personenidentifikator (`id`), die Klasse (`class`), die Interventionsgruppe (`grp`) und das Geschlecht (`sex`) der Jugendlichen kodieren.
#' 
#' @source Bull, H., Schultze, M., Scheithauer, H. (2009) School-based prevention of bullying and relational aggression: The fairplayer.manual. European Journal of Developmental Science, 3:313-317.
#' 
"fairplayer"

#' Big5 Daten (2014)
#' 
#' Selbstberichte zu Persönlichkeitseigenschaften. Gekürzter Datensatz, der nur jeweils die ersten 3 Items zu den fünf Persönlichkeitseigenschaften "Extraversion", "Neurotizismus", "Offenheit", "Verträglichkeit" und "Gewissenhaftigkeit".
#' 
#'  @format Zu den demografischen Daten gehören Alter (`age`), Englisch als Muttersprache (`engant`, 1=yes, 2=no, 0=missed), Geschlecht (`gender`, 1=Male, 2=Female, 3=Other, 0=missed) und Herkunftsland (`country`, ISO-kodiert, bspw. "DE" = Deutschland, "FR" = Frankreich, "EM" = Vereinigte Arabische Emirate, "US" = Vereinigten Staaten von Amerika). Die Persönlichkeitseigeschaften sind: Extraversion (engl. *extraversion*, Items: `E1`, `E2`, `E3`), Neurotizismus (engl. *neuroticism*, Items: `N1`, `N2`, `N3`),  Verträglichkeit (engl. *agreeableness*, Items: `A1`, `A2`, `A3`),  Gewissenhaftigkeit  (engl. *conscientiousness*, Items: `C1`, `C2`, `C3`) und  Offenheit für Erfahrungen (engl. *openness*, Items: `O1`, `O2`, `O3`).
#' 
#' @source Der Originaldatensatz ist ein Onlinedatensatz, wird seit 2012 erfasst und ist auf [openpsychometrics.org](https://openpsychometrics.org/_rawdata/) als *.zip* downloadbar.
"Big5"

