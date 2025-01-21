---
title: "Untitled"
author: "MW"
date: "2025-01-21"
output: html_document
---

### Instalowanie i załadowanie pakietów

### Zdefiniowanie wektora packages:

```{r}
packages <- c("rrBLUP", "BGLR", "DT", "SNPRelate", "dplyr", "qqman", "poolr")
```

### 1.Instalacja pakietów:

```{r}
{for (pkg in packages) {
  if(!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    }
  }
}
```

#### Załadowanie pakietów:

```{r}
library(pkg, character.only = TRUE)
```

### 2. Wczytanie danych genotypowych z pliku

```{r}
#setwd("C:/Users/Sensumart/Desktop/daneR") w konsoli

#Wczytanie pliku ped
Geno <- read_ped("C:/Users/Sensumart/Desktop/daneR/sativas413.ped")

#Wczytanie zmiennych jako osobne wartości
p = Geno$p
n = Geno$n
Geno = Geno$x
```

#### Podglądanie danych genotypowych:

```{r}
head(Geno)
Geno
```

#### Informacje o subpopulacjach:

```{r}
#Informacje o subpopulacjach 
FAM <- read.table("C:/Users/Sensumart/Desktop/daneR/sativas413.fam")
head(FAM)
```

#### Informacje o położeniu **SNP(V4)**:

```{r}
# Infomracje o położeniu danego SNP
MAP <- read.table("C:/Users/Sensumart/Desktop/daneR/sativas413.map")
head(MAP)
```

#### Przekodowanie wartości markerów

```{r}
Geno[Geno == 2] <- NA
Geno[Geno == 0] <- 0
Geno[Geno == 1] <- 1
Geno[Geno == 3] <- 2
```

#### Przekonwertowanie danych na macierz

```{r}
Geno <- matrix(Geno, nrow = p, ncol = n, byrow = TRUE)
```

#### Transpozycja:

```{r}
Geno <- t(Geno)
```

#### Sprawdzanie wymiarów:

```{r}
dim(Geno)
```

### 3. Wczytanie danych fenotypowych

```{r}
rice.pheno <- read.table("C:/Users/Sensumart/Desktop/daneR/RiceDiversity_44K_Phenotypes_34traits_PLINK.txt", header = TRUE, stringsAsFactors = FALSE, sep = "\t")
```

#### Podejrzenie tabeli:

```{r}
head(rice.pheno)
```

#### Sprawdzenie zgodności z pozostałymi plikami

```{r}
#wymiary
dim(rice.pheno)
```

#### Przypisanie nazwy wierszy dla macierzy Geno:

```{r}
# przypisujemy nazwy wierszy dla macierzy Geno na podstawie drugiej kolumny (V2) z ramki FAM, zawierającej identyfikatory próbek
rownames(Geno) <- FAM$V2
```

#### Sprawdzanie zgodności:

```{r}
# sprawdzenie zgodności
table(rownames(Geno) == rice.pheno$NSFTVID)
```

#### Wyodrębnienie pierwszej cechy

```{r}
y <- matrix(rice.pheno$Flowering.time.at.Arkansas)
rownames(y) <- rice.pheno$NSFTVID
index <- !is.na(y)
y <- y[index, 1, drop = FALSE]
Geno <- Geno[index, ]
table(rownames(Geno) == rownames(y))
```

### 4.Przeprowadzenie kontroli jakości (QC) danych markerowych

```{r}
for (j in 1:ncol(Geno)) {
  Geno[, j] <- ifelse(is.na(Geno[, j]), mean(Geno[, j], na.rm = TRUE), Geno)
}
```

#### Odfiltrowanie markerów z MAF \< 5% (o niskiej frekwencji)

```{r}
p <- colSums(Geno)/(2 * nrow(Geno))
maf <- ifelse(p > 0.5, 1-p, p)
maf.index <- which(maf < 0.05)
Geno1 <- Geno[, -maf.index]
```

#### Sprawdzenie wymiarów nowej macierzy:

```{r}
dim(Geno1)
```

#### Aktualizacja pliku ".map" i podanie nowych wymiarów danych genotypowych oraz informacji o markerach

```{r}
MAP <- read.table("C:/Users/Sensumart/Desktop/daneR/sativas413.map")
dim(MAP)
MAP1 <- MAP[-maf.index, ]
dim(MAP1)
```

### 5.Wykonanie analizy PCA

```{r}
Geno1 <- as.matrix(Geno1)
sample <- row.names(Geno1)
length(sample)

colnames(Geno1) <- MAP1$V2
snp.id <- colnames(Geno1)
length(snp.id)
```

#### Utworzenie pliku GDS:

```{r}
snpgdsCreateGeno("44k.gds", genmat = Geno1, sample.id = sample, snp.id = snp.id, 
                 snp.chromosome = MAP1$V1, snp.position = MAP1$V4, snpfirstdim = FALSE)

geno_44k <- snpgdsOpen("C:/Users/Sensumart/Desktop/R/44k.gds")
snpgdsSummary("C:/Users/Sensumart/Desktop/R/44k.gds")
```

#### Przeprowadzenie PCA:

```{r}
pca <- snpgdsPCA(geno_44k, snp.id = colnames(Geno1))
pca <- data.frame(sample.id = row.names(Geno1), 
                  EV1 = pca$eigenvect[, 1], 
                  EV2 = pca$eigenvect[, 2], 
                  EV3 = pca$eigenvect[, 3], 
                  EV4 = pca$eigenvect[, 4], 
                  stringsAsFactors = FALSE)

plot(pca$EV2, pca$EV1, xlab = "PC2", ylab = "PC1")
```

#### Wczytanie dodatkowych informacji o próbkach z pliku gerplasm.csv:

```{r}
pca_1 <- read.csv("RiceDiversity.44K.germplasm.csv", 
                  header = TRUE, skip = 1, stringsAsFactors = FALSE)
pca_2 <- pca_1[match(pca$sample.id, pca_1$NSFTV.ID), ]

pca_population <- cbind(pca_2$Sub.population, pca)
colnames(pca_population)[1] <- "population"

plot(pca_population$EV1, pca_population$EV2, xlab = "PC1", ylab = "PC2", 
     col = c(1:6)[factor(pca_population$population)])
legend(x = "topright", legend = levels(factor(pca_population$population)), 
       col = c(1:6), pch = 1, cex = 0.6)
```

### 6.Przygotowanie danych do analizy GWAS

```{r}
geno_final <- data.frame(marker = MAP1[, 2], chrom = MAP1[, 1], pos = MAP1[, 4], 
                         t(Geno1 - 1), check.names = FALSE)

pheno_final <- data.frame(NSFTV_ID = rownames(y), y = y)
```

#### Wykonanie analizy GWAS

```{r}
GWAS <- GWAS(pheno_final, geno_final, min.MAF = 0.05, P3D = TRUE, plot = FALSE)
```

### 7.Wyodrębnienie istotnych markerów SNP

```{r}
GWAS_1 <- GWAS %>% filter(y != "0")
GWAS_1 %>% filter(y < 1e-04)
```

#### Lista markerów SNP spełniających ustalone kryterium p-wartości:

```{r}
head(GWAS_1)
```

### 8.Stworzenie wykresu Manhattan

\`\`\`{r} manhattan(x = GWAS_1, chr = "chrom", bp = "pos", p = "y", snp = "marker", col = c("blue4", "orange3"), suggestiveline = -log10(1e-04), logp = TRUE)
