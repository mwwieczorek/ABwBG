---
title: "Ćw 6"
output: html_document
date: "2024-11-12"
editor_options: 
  markdown: 
    wrap: 72
---

# Trimming&filtering

### Zainstalowanie odpowiednich pakietów przez BiocManager --\> ShortRead

#### Wczytanie plików FASTQ do R

```{r}
library(ShortRead) 
fq_reads1 \<- readFastq("C:/Users/s203097/Desktop/Nowy folder/ecoli_simulated1_with_adapters.fq") 
fq_reads2 \<- readFastq("C:/Users/s203097/Desktop/Nowy folder/ecoli_simulated2_with_adapters.fq")

```

### 1.Trimming

#### Przycinanie odczytów na podstawie jakości

```{r}
 # Przycinanie odczytów forward

forward trimmed_reads1 <- trimTailw(fq_reads1, k = 2, a = "B", halfwidth = 1)

# Przycinanie odczytów revers

reverse trimmed_reads2 <- trimTailw(fq_reads2, k = 2, a = "B", halfwidth = 1)
```

#### Ile odczytów został przyciętych?

```{r}
length(fq_reads1) #długość sekwencji w nuklotydach
length(trimmed_reads1) #długość sekewncji w nuklotydach po trymerowaniu

length(fq_reads2) 
length(trimmed_reads2)

#czy długość odczytów przyciętych jest < długości odczytów nieprzyciętych 
#jeżeli width(trimmed_reads) < width(fq_reads) to funkcja zwaca argument TRUE,a sama suma jest sumą wszystkich odczytów dla których uzyskano argument TRUE 
#tzn.WYNIK = ZMODYFIKOWANA LICZBA ODCZYTÓW

sum(width(trimmed_reads1) < width(fq_reads1)) 
sum(width(trimmed_reads2) < width(fq_reads2))
```

#### Wynik:

length(fq_reads1) 309440

length(trimmed_reads1) 284123

length(fq_reads2) 309440

length(trimmed_reads2) 273668

sum(width(trimmed_reads1) \< width(fq_reads1)) = 232479
sum(width(trimmed_reads2) \< width(fq_reads2)) = 265053

**Trymowanie** - przycinanie konkretnych nuklotydów

**Filtracja** - usuwanie całych odczytów

```{r}
#jaki procent sekwencji nie uległ zmodyfikowaniu?
(length(trimmed_reads1)/length(fq_reads1))* 100
```

## 2. Filtracja

```{r}
#minimalną akceptowalną długość odczytu -> 50 bp.
# Filtrowanie odczytów forward
filtered_reads1 <- trimmed_reads1[width(trimmed_reads1) >= 50]

# Filtrowanie odczytów reverse
filtered_reads2 <- trimmed_reads2[width(trimmed_reads2) >= 50]

# Odczyty forward
length(trimmed_reads1)       # Po przycinaniu
length(filtered_reads1)      # Po filtracji

# Odczyty reverse
length(trimmed_reads2)
length(filtered_reads2)

#jaki procent odczytów został odrzucony podczas filtracji?
#dla odczytów forward
(length(filtered_reads1)/length(trimmed_reads1))*100
# wynik 87.485
 100 - ((length(filtered_reads1)/length(trimmed_reads1))*100) #Wynik 12.515
#odrzucono 12.515 % odczytów po filtracji
```

### **Ponowna kontrola jakości po przycinaniu i filtracji**

```{r}
#zapisanie przetworzonych odczytów do nowych plików FASTQ:
writeFastq(filtered_reads1, "C:/Users/s203097/Desktop/Nowy folder/ecoli_simulated1_processed.fq")

writeFastq(filtered_reads2, "C:/Users/s203097/Desktop/Nowy folder/ecoli_simulated2_processed.fq")

#Generowanie raportów QC dla przetworzonych danych
qa_results1 <- qa("C:/Users/s203097/Desktop/Nowy folder/ecoli_simulated1_with_adapters.fq", type = "fastq") 

qa_results1_processed <- qa( "C:/Users/s203097/Desktop/Nowy folder/ecoli_simulated1_prossed.fq", type = "fastq")

report(qa_results1, dest = "C:/Users/s203097/Desktop/Nowy folder/QA_report_read1")

report(qa_results1_processed, dest = "C:/Users/s203097/Desktop/Nowy folder/QA_report_read1_processed")

qa_results2 <- qa("C:/Users/s203097/Desktop/Nowy folder/ecoli_simulated2_with_adapters.fq", type = "fastq") 

qa_results2_processed <- qa("C:/Users/s203097/Desktop/Nowy folder/ecoli_simulated2_prossed.fq", type = "fastq")

report(qa_results2, dest = "C:/Users/s203097/Desktop/Nowy folder/QA_report_read2")

report(qa_results2_processed, dest = "C:/Users/s203097/Desktop/Nowy folder/QA_report_read2_processed")

```

### **Analiza rozkładu długości odczytów**

```{r}

# Przed przycinaniem (odczyty forward)
hist(width(fq_reads1), breaks = 50, main = "Długość odczytów forward przed przycinaniem", xlab = "Długość (bp)")
   
# Po przycinaniu (odczyty forward)
hist(width(filtered_reads1), breaks = 50, main = "Długość odczytów forward po przycinaniu", xlab = "Długość (bp)")
   
# Przed przycinaniem (odczyty reverse)
hist(width(fq_reads2), breaks = 50, main = "Długość odczytów reverse przed przycinaniem", xlab = "Długość (bp)")
   
# Po przycinaniu (odczyty forward)
hist(width(filtered_reads2), breaks = 50, main = "Długość odczytów reverse po przycinaniu", xlab = "Długość (bp)")
   
```

### Generowanie pliku pdf z histogramami

```{r}
pdf("ścieżka do folderu / nazwa wykresu-wykres1.pdf") 
#nadanie histogramowi wartości wykres1
wykres1<- hist(width(fq_reads1), breaks = 50, main = "Długość odczytów forward przed przycinaniem", xlab = "Długość (bp)") 
#zamknięcie pliku pdf
dev.off
```

**Odpowiedź:** Przycinanie spowodowało skrócenie odczytów z długości
wyjściowej 150bp do długości w zakresie 50bp-150bp

### **Wykrywanie i usuwanie sekwencji adapterów**

```{r}
#Zdefiniowanie sekwencji adaptera (np. dla Illumina):
library(Biostrings)
   adapter_seq <- DNAString("AGATCGGAAGAGC")
   
# Przycinanie adapterów z odczytów forward:
trimmed_reads1_adapt <- trimLRPatterns(
  Lpattern = adapter_seq,
  subject = filtered_reads1
)

# Defuniujemy odczyty po przycięciu adapterów:
filtered_reads1 <- trimmed_reads1_adapt

# Przycinanie adapterów z odczytów reverse:
trimmed_reads2_adapt <- trimLRPatterns(
  Lpattern = adapter_seq,
  subject = filtered_reads2
)

# Defuniujemy odczyty po przycięciu adapterów:
filtered_reads2 <- trimmed_reads2_adapt

```

### Sprawdzanie efektów przycinania

```{r}
# Porównanie długości przed i po przycięciu adapterów
length(filtered_reads1)
length(trimmed_reads1)

length(filtered_reads2)
length(trimmed_reads2)

# Sprawdzenie ile odczytów zostało zmodyfikowanych
   sum(width(filtered_reads1) < width(trimmed_reads1))
   sum(width(filtered_reads2) < width(trimmed_reads2))
```
