#### R-Skript zur 4. Sitzung zu PFadanalysen und SEM ####
# R Chunks wurden aus dem HTML exportiert und sind dort alle enthalten


#### Vorbereitung ----

<<<<<<< HEAD
library(corrplot) # Korrelationsmatrix grafisch darstellen
library(psych) # EFA durchführen
library(GPArotation) # EFA Lösung rotieren


# Datensatz laden 
data("Big5", package = "PsyMSc1") # shortend Big 5 Questionnaire Data Set
head(Big5, n = 10) # gebe die ersten 10 Zeilen aus


# Französische Stichprobe herausholen und Dimensionen des Datensatzes betrachten
data_France <- Big5[Big5$country == "FR", ]
dim(data_France)


# Weiter kürzen
dataFR <- data_France[, -c(1:4)] # entferne demografische Daten und speichere als "dataFR"

#### Visualisierte Korrelationsmatrix in dataFR
corrplot(corr = cor(dataFR), # Korrelationsmatrix (Datengrundlage)
         method = "color", # Zeichne die Ausprägung der Korrelation farblich kodiert
         addCoef.col = "black", # schreibe die Korrelationskoeffizienten in schwarz in die Grafik
         number.cex = 0.7) # Stelle die Schriftgröße der Koeffizienten ein




##### 2-faktorieller Subdatensatz -----
dataFR2 <- dataFR[,1:6] # Zunächst wählen wir die ersten 6 Items: E1 bis E3 und N1 bis N3
head(dataFR2)

# Visualisierte Korrelationsmatrix
corrplot(corr = cor(dataFR2), # Korrelationsmatrix (Datengrundlage)
         method = "color", # Zeichne die Ausprägung der Korrelation farblich kodiert
         addCoef.col = "black", # schreibe die Korrelationskoeffizienten in schwarz in die Grafik
         number.cex = 1) # Stelle die Schriftgröße der Koeffizienten ein




## Parallelanalysen
fa.parallel(dataFR2)
fa.parallel(dataFR2, fa = "fa")



## Orthogonale EFA ---
fa(dataFR2, nfactors = 2, rotate = "varimax")
two_factor <- fa(dataFR2, nfactors = 2, rotate = "varimax")
names(two_factor)

# Faktorladungen
two_factor$loadings

# Strukturmatrix
two_factor$Structure 



## Oblique EFA ---
two_factor_oblimin <- fa(dataFR2, nfactors = 2, rotate = "oblimin")

# Faktorladungen
two_factor_oblimin$loadings # Ladungsmatrix

# Phi
two_factor_oblimin$Phi # Korrelationsmatrix der Faktoren

# Strukturmatrix
two_factor_oblimin$Structure 


### ML-EFA ---
two_factor_ML <- fa(dataFR2, nfactors = 2, rotate = "oblimin", fm = "ml")
two_factor_ML

two_factor_ML$STATISTIC # Likelihood basierter Chi^2-Wert
two_factor_ML$PVAL # p-Wert


# Passt auch eines mit 1 Faktor?
one_factor_ML <- fa(dataFR2, nfactors = 1, rotate = "oblimin", fm = "ml")
one_factor_ML$STATISTIC # Chi-Quadratwert 
one_factor_ML$PVAL # p-Wert

anova(one_factor_ML, two_factor_ML)


# Passt auch eines mit 3 Faktor?
three_factor_ML <- fa(dataFR2, nfactors = 3, rotate = "oblimin", fm = "ml")
three_factor_ML$STATISTIC # Chi-Quadratwert 
three_factor_ML$PVAL # p-Wert

anova(two_factor_ML, three_factor_ML)



##### ML-EFA für den gesamten (gekürtzten) Datensatz -----

# Parallelanalyse
fa.parallel(x = dataFR)

## ML-EFA
five_factor_ML <- fa(dataFR, nfactors = 5, rotate = "oblimin", fm = "ml")
five_factor_ML$STATISTIC
five_factor_ML$PVAL # Modell wird durch die Daten nicht verworfen

# Faktorladungen
five_factor_ML$loadings

# Orthogonale Lösung
fa(dataFR, nfactors = 5, rotate = "varimax", fm = "ml")$loadings

round(five_factor_ML$Phi, 2) # runde auf 2 Nachkommastellen
fa(dataFR, nfactors = 5, rotate = "varimax", fm = "ml")$Phi
diag(5) # Einheitsmatrix der Dimension 5x5 (Phi der orthognalen Lsg)


### ML-EFA Modellverlgeiche
# Passen auch 4 Faktoren?
four_factor_ML <- fa(dataFR, nfactors = 4, rotate = "oblimin", fm = "ml")
four_factor_ML$STATISTIC
four_factor_ML$PVAL 

anova(four_factor_ML, five_factor_ML) 


# Passen auch 6 Faktoren?
six_factor_ML <- fa(dataFR, nfactors = 6, rotate = "oblimin", fm = "ml")
six_factor_ML$STATISTIC
six_factor_ML$PVAL # Modell wird durch die Daten nicht verworfen

anova(five_factor_ML, six_factor_ML) 
=======
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
# Pfadmodell mit indirektem und totalem Effekt:
model_paths_IE_TE <- '
BOEEs ~ a*ZDs
BFs ~  b*BOEEs + c*ZDs

# Neue Parameter
IE := a*b
TE := IE + c
'
# Schätzen und Summary des Pfadmodells mit indirektem und totalem Effekt
fit_paths_IE_TE <- sem(model_paths_IE_TE, data = StressAtWork)
summary(fit_paths_IE_TE) # Achtung! 
# Leider können wir den angezeigten Standardfehlern und dem zugehörigen p-Wert nicht unbedingt vertrauen,
# da einige Studien gezeigt haben, dass der indirekte Effekt asymptotisch nicht immer normalverteilt bzw. 
# symmetrisch verteilt ist, weswegen ein einfach Teilen des Estimates durch SE und der Vergleich mit der 
# z-Verteilung (so wie wir dies eigentlich immer tun; also die einfache Parametersignifikanzentscheidung
# in komplexen Modellen) in diesem Fall nicht sinnvoll erscheint. Aus diesem Grund möchten wir dieser 
# Problematik entgehen, indem wir die Bootstrapp-Methode verwenden.

## Bootstrapping ---
set.seed(1234)
fit_paths_IE_TE_boot  <- sem(model_paths_IE_TE, data = StressAtWork, se = "boot", bootstrap = 1000)
parameterEstimates(fit_paths_IE_TE_boot, ci = TRUE)
parameterEstimates(fit_paths_IE_TE_boot, ci = TRUE)[7:8,] # Zeilen im Output von Interesse


##### Strukturgleichungsmodelle -----
## Das Modell ---
model_sem_IE_TE <- '
# Messmodelle
ZD =~ zd1 + zd2 + zd6
BOEE =~ bo1 + bo6 + bo12 + bo19

# Strukturmodell
BOEE ~ a*ZD
BFs ~  b*BOEE + c*ZD

# Neue Parameter
IE := a*b
TE := IE + c
'

fit_sem_IE_TE <- sem(model_sem_IE_TE, StressAtWork)
summary(fit_sem_IE_TE, fit.measures = T, rsq = T)


## Berechnen und Testen des indirekten Effektes von Zeitdruck über Emotionale Erschöpfung auf Psychosomatische Beschwerden im SEM ---
set.seed(12345)
fit_sem_IE_TE_boot  <- sem(model_sem_IE_TE, data = StressAtWork, se = "boot", bootstrap = 1000)
parameterEstimates(fit_sem_IE_TE_boot, ci = TRUE)
parameterEstimates(fit_sem_IE_TE_boot, ci = TRUE)[21:22,] # Parameter von Interesse

## Grafische Repräsentation ---
semPaths(object = fit_sem_IE_TE,  what = "model", layout = "tree2", 
         rotation = 2, curve = T, col = list(man = "skyblue", lat = "yellow"),
         curvePivot = T,  edge.label.cex=1.2, sizeMan = 5, sizeLat = 8)

semPaths(object = fit_sem_IE_TE, what = "est", layout = "tree2", 
         rotation = 2, curve = T, col = list(man = "skyblue", lat = "yellow"),
         curvePivot = T,  edge.label.cex=1.2, sizeMan = 5, sizeLat = 8)


##### MSA -----
# Modell mit 2 Gruppen: Sex
fit_sem_IE_TE_MSA <- sem(model_sem_IE_TE, data = StressAtWork, group = "sex")
summary(fit_sem_IE_TE_MSA)

# Vollständig benanntes Modell mit 2 indirekten und 2 totalen Effekten:
model_sem_IE_TE_MSA_abc <- '
# Messmodelle
ZD =~ zd1 + zd2 + zd6
BOEE =~ bo1 + bo6 + bo12 + bo19

# Strukturmodell
BOEE ~ c(a1, a2)*ZD
BFs ~  c(b1, b2)*BOEE + c(c1,c2)*ZD

# Neue Parameter
IE1 := a1*b1
TE1 := IE1 + c1

IE2 := a2*b2
TE2 := IE2 + c2
'
fit_sem_IE_TE_MSA_abc <- sem(model_sem_IE_TE_MSA_abc, StressAtWork, group = "sex")
summary(fit_sem_IE_TE_MSA_abc)

## Invarianztestung über das Geschlecht ---
# entfernen der a,b,c Benennung - dieses Modell wird für die Invarianztestung verwendet!
model_sem <- '
# Messmodelle
ZD =~ zd1 + zd2 + zd6
BOEE =~ bo1 + bo6 + bo12 + bo19

# Strukturmodell
BOEE ~ ZD
BFs ~  BOEE + ZD
'

## konfigurale Invarianz
fit_sem_sex_konfigural <- sem(model_sem, data = StressAtWork, group = "sex", 
                              group.equal = c(""), group.partial = c("BFs ~ 1", "BFs ~~*BFs"))
summary(fit_sem_sex_konfigural, fit.measures = T)



## metrische Invarianz
fit_sem_sex_metrisch <- sem(model_sem, data = StressAtWork, group = "sex",
                            group.equal = c("loadings"), group.partial = c("BFs ~ 1", "BFs ~~BFs"))
summary(fit_sem_sex_metrisch, fit.measures = T)

# Modellvergleich (metrisch vs. konfigural):
lavTestLRT(fit_sem_sex_metrisch, fit_sem_sex_konfigural) # --> metrisch wird NICHT verworfen


## Skalare Invarianz
fit_sem_sex_skalar <- sem(model_sem, data = StressAtWork, group = "sex",
                          group.equal = c("loadings", "intercepts"), group.partial = c("BFs ~ 1", "BFs ~~BFs"))
summary(fit_sem_sex_skalar, fit.measures = T)

# Modellvergleich (skalar vs. metrisch):
lavTestLRT(fit_sem_sex_skalar, fit_sem_sex_metrisch) # --> skalar wird NICHT verworfen


## Strikte Invarianz
fit_sem_sex_strikt <- sem(model_sem, data = StressAtWork, group = "sex",
                          group.equal = c("loadings", "intercepts", "residuals"), group.partial = c("BFs ~ 1", "BFs ~~BFs"))

# Modellvergleich (strikt vs. skalar):
lavTestLRT(fit_sem_sex_strikt, fit_sem_sex_skalar) # --> strikt wird NICHT verworfen


## Vollständige Invarianz
fit_sem_sex_voll <- sem(model_sem, data = StressAtWork, group = "sex",
                        group.equal = c("loadings", "intercepts", "residuals",
                                        "means", "lv.variances", "lv.covariances", "regressions"))

# Modellvergleich (vollständig vs. strikt):
lavTestLRT(fit_sem_sex_voll, fit_sem_sex_strikt) # --> vollständig WIRD verworfen (keine vollständige Invarianz über das Geschlecht)
# suchen des Effekts im strikt-invarianten Modell:
summary(fit_sem_sex_strikt)








#### Appendix A -----------
# Populationsmodell zur Simulation
pop_model_H0 <- '
# Messmodelle
Xi1 =~ x1 + 0.7*x2 + 0.6*x3
Eta1 =~ y1 + 0.8*y2
Eta2 =~ y3 + 0.9*y4

# Strukturmodell
Eta1 ~ 0.5*Xi1 
Eta2 ~ 0.54*Xi1 + 0.4*Eta1

# Fehlerkovarianzen
x1 ~~ 0.4*x2
'

set.seed(123456)
data <- simulateData(model = pop_model_H0, meanstructure = F, sample.nobs = 200)

head(data)


# Modelle zum Schätzen
model_H0 <- '
# Messmodelle
Xi1 =~ x1 + x2 + x3
Eta1 =~ y1 + y2
Eta2 =~ y3 + y4

# Strukturmodell
Eta1 ~ Xi1 
Eta2 ~ Xi1 + Eta1

# Fehlerkovarianzen
x1 ~~ x2
'

fit_H0 <- sem(model = model_H0, data = data)
summary(fit_H0)
semPaths(fit_H0, curve = T, curvePivot = T)

fitmeasures(fit_H0, c("chisq", 'df', "pvalue"))

# H1 Modell: keine Fehlerkovarianz
model_H1_kov <- '
# Messmodelle
Xi1 =~ x1 + x2 + x3
Eta1 =~ y1 + y2
Eta2 =~ y3 + y4

# Strukturmodell
Eta1 ~ Xi1 
Eta2 ~ Xi1 + Eta1
'
semPaths(sem(model_H1_kov, data))

# H1 Modell: keine direkte Beziehung
model_H1_Struk <- '
# Messmodelle
Xi1 =~ x1 + x2 + x3
Eta1 =~ y1 + y2
Eta2 =~ y3 + y4

# Strukturmodell
Eta1 ~ Xi1 
Eta2 ~ Eta1

# Fehlerkovarianzen
x1 ~~ x2
'
semPaths(sem(model_H1_Struk, data))


# Modellvergleich:
fit_H1_kov <- sem(model_H1_kov, data)
fit_H1_Struk <- sem(model_H1_Struk, data)

fitmeasures(fit_H0, c("chisq", 'df', "pvalue"))
fitmeasures(fit_H1_kov, c("chisq", 'df', "pvalue"))
fitmeasures(fit_H1_Struk, c("chisq", 'df', "pvalue"))


# Neuer Versuch für N = 1000
set.seed(123456)
data <- simulateData(model = pop_model_H0, meanstructure = F, sample.nobs = 1000)
fit_H0 <- sem(model = model_H0, data = data)
fit_H1_kov <- sem(model_H1_kov, data)
fit_H1_Struk <- sem(model_H1_Struk, data)
fitmeasures(fit_H0, c("chisq", 'df', "pvalue"))
fitmeasures(fit_H1_kov, c("chisq", 'df', "pvalue"))
fitmeasures(fit_H1_Struk, c("chisq", 'df', "pvalue"))


## ezCutoffs:
library(ezCutoffs)
ezCutoffs(model = model_sem, data = StressAtWork)

>>>>>>> Sitzung4




#### Appendix B -----------
<<<<<<< HEAD
# Orthogonaler Fall
two_factor$loadings[1, 1] # volle Formel für ersten Eintrag in Strukutrmatrix, da Kovarianz der Faktoren = 0
two_factor$Structure[1, 1] # erster Eintrag in der Strukturmatrix

# Obliquer Fall
two_factor_oblimin$loadings[1, 1] # erste Faktorladung im obliquen Modell (unterscheidet sich von dem ersten Eintrag der Strukturmatrix)
two_factor_oblimin$loadings[1, 1] + two_factor_oblimin$loadings[1, 2]*two_factor_oblimin$Phi[2, 1] # volle Formel für ersten Eintrag in Strukutrmatrix
two_factor_oblimin$Structure[1, 1] # erster Eintrag in der Strukturmatrix


# in Matrixnotation
two_factor_oblimin$loadings[1:6, 1:2] %*% two_factor_oblimin$Phi[1:2, 1:2] # Matrixprodukt
two_factor_oblimin$Structure[1:6, 1:2] # Strukturmatrix


## Mehrdimensionale Fall
five_factor_ML$loadings[1:15,1:5] %*% five_factor_ML$Phi[1:5,1:5] # Matrixprodukt
five_factor_ML$Structure[1:15,1:5] # Strukturmatrix
five_factor_ML$loadings[1:15,1:5] %*% five_factor_ML$Phi[1:5,1:5] - five_factor_ML$Structure[1:15,1:5]



=======
# MSA zu Fuß
model_sem <- '
# Messmodelle
ZD =~ zd1 + zd2 + zd6
BOEE =~ bo1 + bo6 + bo12 + bo19

# Strukturmodell
BOEE ~ ZD
BFs ~  BOEE + ZD
'

# Vergleiche händische Modelle mit jenen zuvor!
## Konfigural ---
fit_sem_sex_konfigural <- sem(model_sem, data = StressAtWork, group = "sex", 
                              group.equal = c(""), group.partial = c("BFs ~ 1", "BFs ~~*BFs"))
fit_sem_sex_konfigural2 <- sem(model_sem, data = StressAtWork,  group = "sex")

# chi^2, df, p-Wert
fitmeasures(fit_sem_sex_konfigural, c("chisq", 'df', "pvalue"))
fitmeasures(fit_sem_sex_konfigural2, c("chisq", 'df', "pvalue")) # --> gleich


## Metrisch ---
model_sem_metrisch <- '
# Messmodelle
ZD =~ zd1 + c(l1, l1)*zd2 + c(l2, l2)*zd6
BOEE =~ bo1 + c(l3,l3)*bo6 + c(l4, l4)*bo12 + c(l5, l5)*bo19

# Strukturmodell
BOEE ~ ZD
BFs ~  BOEE + ZD'

fit_sem_sex_metrisch <- sem(model_sem, data = StressAtWork, group = "sex",
                            group.equal = c("loadings"), group.partial = c("BFs ~ 1", "BFs ~~BFs"))
fit_sem_sex_metrisch2 <- sem(model_sem_metrisch, data = StressAtWork,  group = "sex")

# chi^2, df, p-Wert
fitmeasures(fit_sem_sex_metrisch, c("chisq", 'df', "pvalue"))
fitmeasures(fit_sem_sex_metrisch2, c("chisq", 'df', "pvalue")) # --> gleich



## Skalar ---
model_sem_skalar <- '
# Messmodelle
ZD =~ zd1 + c(l1, l1)*zd2 + c(l2, l2)*zd6
BOEE =~ bo1 + c(l3,l3)*bo6 + c(l4, l4)*bo12 + c(l5, l5)*bo19

zd1 ~ c(tau1, tau1)*1
zd2 ~ c(tau2, tau2)*1
zd6 ~ c(tau3, tau3)*1

bo1 ~ c(tau4, tau4)*1
bo6 ~ c(tau5, tau5)*1
bo12 ~ c(tau6, tau6)*1
bo19 ~ c(tau7, tau7)*1

# Strukturmodell
BOEE ~ ZD
BFs ~  BOEE + ZD

BOEE ~ c(0, NA)*1
ZD ~ c(0, NA)*1
'

fit_sem_sex_skalar <- sem(model_sem, data = StressAtWork, group = "sex",
                          group.equal = c("loadings", "intercepts"), group.partial = c("BFs ~ 1", "BFs ~~BFs"))
fit_sem_sex_skalar2 <- sem(model_sem_skalar, data = StressAtWork,  group = "sex")

# chi^2, df, p-Wert
fitmeasures(fit_sem_sex_skalar, c("chisq", 'df', "pvalue"))
fitmeasures(fit_sem_sex_skalar2, c("chisq", 'df', "pvalue")) # --> gleich



## Strikt ---
model_sem_strikt <- '
# Messmodelle
ZD =~ zd1 + c(l1, l1)*zd2 + c(l2, l2)*zd6
BOEE =~ bo1 + c(l3,l3)*bo6 + c(l4, l4)*bo12 + c(l5, l5)*bo19

zd1 ~ c(tau1, tau1)*1
zd2 ~ c(tau2, tau2)*1
zd6 ~ c(tau3, tau3)*1

bo1 ~ c(tau4, tau4)*1
bo6 ~ c(tau5, tau5)*1
bo12 ~ c(tau6, tau6)*1
bo19 ~ c(tau7, tau7)*1

zd1 ~~ c(t1, t1)*zd1
zd2 ~~ c(t2, t2)*zd2
zd6 ~~ c(t3, t3)*zd6

bo1 ~~ c(t4, t4)*bo1
bo6 ~~ c(t5, t5)*bo6
bo12 ~~ c(t6, t6)*bo12
bo19 ~~ c(t7, t7)*bo19

# Strukturmodell
BOEE ~ ZD
BFs ~  BOEE + ZD

BOEE ~ c(0, NA)*1
ZD ~ c(0, NA)*1
'

fit_sem_sex_strikt <- sem(model_sem, data = StressAtWork, group = "sex",
                          group.equal = c("loadings", "intercepts", "residuals"), group.partial = c("BFs ~ 1", "BFs ~~BFs"))
fit_sem_sex_strikt2 <- sem(model_sem_strikt, data = StressAtWork,  group = "sex")

# chi^2, df, p-Wert
fitmeasures(fit_sem_sex_strikt, c("chisq", 'df', "pvalue"))
fitmeasures(fit_sem_sex_strikt2, c("chisq", 'df', "pvalue")) # --> gleich 


## Vollständig ---
model_sem_voll <- '
# Messmodelle
ZD =~ zd1 + c(l1, l1)*zd2 + c(l2, l2)*zd6
BOEE =~ bo1 + c(l3,l3)*bo6 + c(l4, l4)*bo12 + c(l5, l5)*bo19

zd1 ~ c(tau1, tau1)*1
zd2 ~ c(tau2, tau2)*1
zd6 ~ c(tau3, tau3)*1

bo1 ~ c(tau4, tau4)*1
bo6 ~ c(tau5, tau5)*1
bo12 ~ c(tau6, tau6)*1
bo19 ~ c(tau7, tau7)*1

zd1 ~~ c(t1, t1)*zd1
zd2 ~~ c(t2, t2)*zd2
zd6 ~~ c(t3, t3)*zd6

bo1 ~~ c(t4, t4)*bo1
bo6 ~~ c(t5, t5)*bo6
bo12 ~~ c(t6, t6)*bo12
bo19 ~~ c(t7, t7)*bo19

# Strukturmodell
BOEE ~ c(a, a)*ZD
BFs ~  c(b, b)*BOEE + c(c, c)*ZD

BOEE ~ c(0, 0)*1
ZD ~ c(0, 0)*1
BFs ~ c(kappa, kappa)*1

ZD ~~ c(phi, phi)*ZD
BOEE ~~ c(psi1, psi1)*BOEE
BFs ~~ c(psi2, psi2)*BFs
'

fit_sem_sex_voll <- sem(model_sem, data = StressAtWork, group = "sex",
                        group.equal = c("loadings", "intercepts", "residuals",
                                        "means", "lv.variances", "lv.covariances", "regressions"))
fit_sem_sex_voll2 <- sem(model_sem_voll, data = StressAtWork,  group = "sex")

# chi^2, df, p-Wert
fitmeasures(fit_sem_sex_voll, c("chisq", 'df', "pvalue"))
fitmeasures(fit_sem_sex_voll2, c("chisq", 'df', "pvalue")) # --> gleich


>>>>>>> Sitzung4



#### Appendix C -----------
<<<<<<< HEAD
# Mahalanobisdistanz
Mahalanobis_Distanz <- mahalanobis(x = dataFR, cov = cov(dataFR), center = apply(X = dataFR, MARGIN = 2, FUN = mean)) # Berechnen der Mahalanobisdistanz
hist(Mahalanobis_Distanz, col = "skyblue", border = "blue", freq = F, breaks = 15) # Histogramm
lines(x = seq(0, max(Mahalanobis_Distanz), 0.01), y = dchisq(x = seq(0, max(Mahalanobis_Distanz), 0.01), df = 15), col = "darkblue", lwd = 4) # Einzeichnen der Dichte

# Mittelwerte
apply(X = dataFR, MARGIN = 2, FUN = mean)

=======
model_sem_IE_TE <- '
# Messmodelle
ZD =~ zd1 + zd2 + zd6
BOEE =~ bo1 + bo6 + bo12 + bo19

# Strukturmodell
BOEE ~ a*ZD
BFs ~  b*BOEE + c*ZD

# Neue Parameter
IE := a*b
TE := IE + c
'


model_sem_IE_TE_tau <- '
# Messmodelle
ZD =~ l1*zd1 + l1*zd2 + l1*zd6
BOEE =~ l2*bo1 + l2*bo6 + l2*bo12 + l2*bo19

# Strukturmodell
BOEE ~ a*ZD
BFs ~  b*BOEE + c*ZD

# Neue Parameter
IE := a*b
TE := IE + c
'

fit_sem_IE_TE_tau <- sem(model_sem_IE_TE_tau, StressAtWork)
summary(fit_sem_IE_TE_tau, fit.measures = T, rsq = T)

# Modellvergleich
lavTestLRT(fit_sem_IE_TE_tau, fit_sem_IE_TE) # essentielle Tau-Äquivalenz wird verworfen!
>>>>>>> Sitzung4


