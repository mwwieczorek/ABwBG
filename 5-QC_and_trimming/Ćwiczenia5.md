---
title: "Ćwiczenia 5"
output: html_document
date: "2024-11-11"
---

#### Kontrola jakości (QC) danych NGS z wykorzystaniem pakietów Bioconductor

Znalezienie sekwencji E.coli WGS - **(SRR31303920)**, pobranie sekwencji jako plik fastq

##### Załadowanie pakietów

```{r}
library(ShortRead)
library(Rqc)
library(Biostrings)
```

### Wczytanie danych FASTQ do R

```{r}
fq_file <- "C:/Users/Sensumart/Desktop/Nowy folder/SRR31303920.fastq.gz" 
fq_reads <- readFastq(fq_file)
```

#### Sprawdzenie liczby odczytów

```{r}
length(fq_reads)
```

![](images/clipboard-1474694343.png)

#### Podgląd pierwszych odczytów

```{r}
fq_reads[1:5]
```

![](images/clipboard-3284793029.png)

#### **Generowanie raportu QC za pomocą ShortRead**

##### Generowanie obiektu z wynikami kontroli jakości

```{r}
qa_results <- qa(fq_file, type = "fastq")
```

##### Utworzenie raportu QC

```{r}
report(qa_results, dest = "C:/Users/Sensumart/Desktop/Nowy folder")
```

-   Przejrzyj raport QC i zanotuj kluczowe obserwacje dotyczące jakości danych.

    ![](images/clipboard-2234074829.png)

    -   na podstawie powyższego wykresu można zauważyć, że częstotliwość wszystkich nukleotydów jest zbliżona do 0.25, brak niedopasowanych nukleotydów

        ![](images/clipboard-1912480780.png)

    -   Z raportu wynika, że przebieg sekwencjonowania uzyskał około 1,8 miliona odczytów. To znacząco mniej niż 25-30 milionów odczytów, które są uważane za wskaźnik wysokiej jakości dla analizatora genomu. Niska liczba odczytów może wskazywać na ograniczoną efektywność sekwencjonowania.

        ![](images/clipboard-2802316745.png)

    -   na podstawie powyższego wykresu

        -   większość odczytów osiąga wysokie wartości jakości (około 40), co wskazuje na dobrą jakość danych

        -   proporcja odczytów gwałtownie wzrasta przy wyższych wartościach jakości (okolice 35-40) sugeruje to, że duża liczba odczytów posiada wysoką jakość, co jest pozytywnym wskaźnikiem i sugeruje brak zanieczyszczeń lub artefaktów obniżających jakość

        -   mała liczba odczytów o niskiej jakości

        ```         
        ![](images/clipboard-85095514.png)
        ```

    -   na podstswie powyższego wykresu

        -   duża część odczytów występuje jednokrotnie lub kilkukrotnie, co sugeruje równomierny rozkład sekwencji i brak nadreprezentacji konkretnych odczytów.

        -   Brak nadreprezentacji specyficznych sekwencji i równomierne rozłożenie odczytów sugerują niskie ryzyko błędów związanych z artefaktami lub kontaminacją, co świadczy o wiarygodności wyników

#### generowanie raportu Rqc

```{r}
rqc_results <- rqc(path = "C:/Users/Sensumart/Desktop/Nowy folder", pattern = "SRR31303920.fastq.gz", sample = TRUE)

rqcReport(rqc_results, outdir = "Rqc_report")
```

#### Problemy.....

![](images/clipboard-4220388734.png)

### Analiza zawartości GC

```{r}
gc_content <- letterFrequency(sread(fq_reads), letters = "GC", as.prob = TRUE)

#Wyświetlenie histogramu %GC

hist(gc_content, breaks = 50, main = "Zawartość GC w oryginalnych odczytach", xlab = "Procent GC")
```

![](images/clipboard-2995252593.png)
