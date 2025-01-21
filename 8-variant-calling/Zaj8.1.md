---
title: "Untitled"
author: "MW"
date: "2025-01-21"
output: html_document
---

## Variant calling

### Zad1. instalacja pakietów

```{r}

BiocManager::install(c("VariantTools", "Rsamtools", "GenomicRanges", "GenomicFeatures", "VariantAnnotation", "BiocParallel", force = TRUE))

```

```{r}
### załadowanie pakietów 
library(VariantTools)
library(Rsamtools)
library(GenomicRanges)
library(GenomicFeatures)
library(VariantAnnotation)
library(BiocParallel)
```

## Zad2. Zapoznanie się z pakietami do wykrywania wariantów

1.  Wyświetl pomoc dla pakietu `VariantTools`:

    ```{r}
    #wyświetlanie pdf z opisem 
    ??VariantTools
    vignette("VariantTools")

    ```

2.  Funkcje innych pakietów

-   `Rsamtools`: funkcje do pracy z plikami BAM/SAM.
-   `GenomicRanges`: operacje na zakresach genomowych.
-   `GenomicFeatures`: tworzenie obiektów opisujących cechy genomu.
-   `VariantAnnotation`: funkcje do anotacji i manipulacji wariantami.

### Zad.3 Konfiguracja środowiska pracy

```{r}
#Ustawianie katalogu roboczego:

#setwd("C:/Users/s203097/Desktop/alignment") - w konsoli ;P
```

**Czy pliki są dostępne ?**

```{r}
#w katalogu znajdują się pliki 
list.files()

#wynik
#[1] "aligned_sample.BAM"    "ecoli_reference.fasta"
```

### Zad.4 Wczytanie danych

```{r}
#Wczytanie pliku BAM:

bamfile <- "C:/Users/s203097/Desktop/alignment/aligned_sample.BAM"
bam <- BamFile(bamfile)
```

```{r}
#Wczytanie genomu refrerncyjnego E.coli
ref_genome <- "C:/Users/s203097/Desktop/alignment/ecoli_reference.fasta"
fa <- FaFile(ref_genome)
```

```{r}
#sortowanie pliku BAM według współrzędnych 
# Zdefiniuj ścieżkę wejściową input i wyjściową output

input_bam <- "C:/Users/s203097/Desktop/alignment/aligned_sample.BAM"
output_bam <- "C:/Users/s203097/Desktop/alignment/sorted_aligned_sample.BAM" #to będzie nowy przesortowany plik
```

```{r}
# Wykonaj sortowanie
sortBam(file = input_bam, destination = output_bam, overwrite = TRUE)
```

```{r}
#Zdefiniowanie przesortowanego pliku jako sorted_bam
sorted_bam <- "C:/Users/s203097/Desktop/alignment/sorted_aligned_sample.BAM.bam" 
```

```{r}
#Indeksowanie pliku FASTA, jeśli indeks nie istnieje, oraz przesortowanego plik BAM:
indexFa(ref_genome)
indexBam(sorted_bam)
```

### Zad 5. Kontrola jakości danych sekwencyjnych

#### Przeprowadzenie kontroli jakości danych sekwencyjnych przed wykrywaniem wariantów

```{r}
#Sprtawdzanie nagłówka pliku BAM

scanBamHeader(bam)
```

```{r}
#Podstawowe statystyki pliku BAM
idxstats <- idxstatsBam(sorted_bam)
print(idxstats)

```

```{r}
#Obliczenike i wizualizacja pokrycia genomu:
coverage_data <- coverage(sorted_bam)
summary(coverage_data[[1]]) # dla genomów prokariota
#wykes pokrycia 
plot(coverage_data[[1]], main="Pokrycie genomu dla sekwencji U00096.3", ylab="Pokrycie", xlab="Pozycja w genomie") # uwaga: zajmuje dużo czasu
```

### Zad6. Wykrywanie wariantów

Wykrywanie wariantów za pomoca funkcji `callVariants()`.

```{r}
#Zdefiniowanie parametrów sortowania-pileup()` z pakietu `Rsamtools`

# Ustawienie parametró pileup
pileup_param <- PileupParam(
    distinguish_strands = FALSE,
    distinguish_nucleotides = TRUE,
    min_base_quality = 20
)

# Wykonanie pileup
pile <- pileup(sorted_bam, scanBamParam = ScanBamParam(), pileupParam = pileup_param)

```

```{r}
#Konwert  pileup  do ramki danych z uzgodnieniem nazw sekwencji
install.packages("dplyr")
library(dplyr)

pile_df<-as.data.frame(pile)
class(pile_df)
pile_df <- pile_df %>%
    mutate(seqnames = as.character(seqnames)) %>%
    mutate(seqnames = ifelse(seqnames == "U00096.3", "NC_000913.3", seqnames))
```

```{r}
#Pogrupuowanie danych według pozycji 
variant_candidates <- pile_df %>%
    group_by(seqnames, pos) %>%
    summarise(
        total = sum(count),
        A = sum(count[nucleotide == "A"]),
        C = sum(count[nucleotide == "C"]),
        G = sum(count[nucleotide == "G"]),
        T = sum(count[nucleotide == "T"]),
        .groups = 'drop'
    ) %>%
    mutate(
        ref = as.character(getSeq(fa, GRanges(seqnames, IRanges(pos, pos))))
    ) %>%
    rowwise() %>%
    mutate(
        # Obliczanie alternatywnych alleli
        alt_alleles = list(setdiff(c("A", "C", "G", "T"), ref)),
        # Liczenie odczytów dla referencyjnego i alternatywnych alleli
        ref_count = sum(c_across(c("A", "C", "G", "T"))[ref]),
        alt_count = sum(c_across(c("A", "C", "G", "T"))[alt_alleles])
    ) %>%
    ungroup() %>%
    # Filtracja na podstawie minimalnej liczby odczytów dla wariantu
    filter(alt_count >= 5) %>%
    # Opcjonalne filtrowanie na podstawie proporcji
    filter((alt_count / total) >= 0.2)
```

```{r}
# Przykład wyświetlenia wariantów
head(variant_candidates)
```

### Zad.7 Filtracja i eksportowanie wyników do pliku

```{r}
# Filtracja wariantów na podstawie jakości i głębokości pokrycia
filtered_variants <- variant_candidates %>%
    filter(total >= 10, alt_count / total >= 0.2, alt_count >= 5)

# Wyświetlenie liczby wariantów przed i po filtrowaniu
cat("Liczba wariantów przed filtrowaniem:", nrow(variant_candidates), "\n")
cat("Liczba wariantów po filtrowaniu:", nrow(filtered_variants), "\n")

# Konwersja do data.frame dla eksportu
df_variants <- as.data.frame(filtered_variants)

# Eksport do pliku CSV
write.csv(df_variants, "C:/Users/s203097/Desktop/alignment/wyniki_wariantow.csv", row.names = FALSE)
```
