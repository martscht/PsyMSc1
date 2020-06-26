#### R-Skript zur 4. Sitzung zu PFadanalysen und SEM ####
# R Chunks wurden aus dem HTML exportiert und sind dort alle enthalten


#### Vorbereitung ----

library(lavaan)
library(semPlot) # grafische Darstellung von Pfadanalyse- und Strukturgleichungsmodellen


# Datensatz laden 
data("StressAtWork", package = "PsyMSc1")
head(StressAtWork) # gebe die ersten 6 Zeilen aus
names(StressAtWork) # Spalten Namen des Datensatzes

# Skalenmittelwerte bestimmen und dem Datensatz anhängen
StressAtWork$ZDs <- rowMeans(StressAtWork[,paste0("zd",c(1, 2, 6))])
StressAtWork$BOEEs <- rowMeans(StressAtWork[,paste0("bo",c(1, 6, 12, 19))])
StressAtWork$BFs <- rowMeans(StressAtWork[,paste0("bf",1:20)])





##### Pfadanalyse -----
# Model für Skalenmittelwerte (fitte mit sem):
model_paths <- '
BOEEs ~ ZDs
BFs ~  BOEEs + ZDs
'

# So sähe das Modell in lavaan aus (fitte mit lavaan): 
model_paths_lavaan <- '
BOEEs ~ ZDs
BFs ~  BOEEs + ZDs
BOEEs ~~ BOEEs
BFs ~~ BFs
'

# Fit und summary mit sem
fit_paths <- sem(model_paths, data = StressAtWork)
summary(fit_paths, rsq = T, fit.measures = T)


## Grafische Veranschaulichung des Modells und der Ergebnisse ---
# Defaults: Modellstruktur:
semPaths(fit_paths)

# Ergebnisse zeichnen:
semPaths(fit_paths, what = "est")

# weitere Ploteinstellungen:
semPaths(object = fit_paths, what = "model", layout = "tree2", rotation = 2,
         col = list(man = "skyblue"),  edge.label.cex=1, sizeMan = 5)

semPaths(object = fit_paths, what = "est", layout = "tree2", rotation = 2, 
         col = list(man = "skyblue"),  edge.label.cex=1, sizeMan = 5)


## Berechnen und Testen des indirekten Effektes von Zeitdruck über Emotionale Erschöpfung auf Psychosomatische Beschwerden ---


#### Appendix C -----------
# Mahalanobisdistanz
Mahalanobis_Distanz <- mahalanobis(x = dataFR, cov = cov(dataFR), center = apply(X = dataFR, MARGIN = 2, FUN = mean)) # Berechnen der Mahalanobisdistanz
hist(Mahalanobis_Distanz, col = "skyblue", border = "blue", freq = F, breaks = 15) # Histogramm
lines(x = seq(0, max(Mahalanobis_Distanz), 0.01), y = dchisq(x = seq(0, max(Mahalanobis_Distanz), 0.01), df = 15), col = "darkblue", lwd = 4) # Einzeichnen der Dichte

# Mittelwerte
apply(X = dataFR, MARGIN = 2, FUN = mean)



