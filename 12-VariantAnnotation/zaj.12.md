# Instalowanie pakietów:

```{r}
packages <- c("VariantAnnotation", "GenomicRanges", "AnnotationHub")
BiocManager::install(packages)
```

# Ładowanie pakietów:

```{r}
library(VariantAnnotation)
library(GenomicRanges)
library(AnnotationHub)
```

# Wczytanie i eksploracja danych

```{r}

#wczytanie ścieżki do pliku
fl <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")

#wczytanie pliku
vcf <- readVcf(fl, "hg19")

#podstawowe informacje o pliku
vcf
```

# Analiza jakości

```{r}
summary(qual(vcf))
```

# Filtrowanie wariantów

```{r}
vcf_filtered <- vcf[!is.na(qual(vcf)) & qual(vcf) >99, ]
vcf_filtered
summary(qual(vcf_filtered))
```

# Anotacja wiarantów

```{r}
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")
```

```{r}
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
```

```{r}
gr <- rowRanges(vcf_filtered)
loc_anno <- locateVariants(gr, txdb, AllVariants())
head(loc_anno)
```

# Sprawdzanie i dopasowywanie stylów sekwencji

```{r}
seqlevelsStyle(gr)
seqlevelsStyle(txdb)
#sprawdza styl nazw sekwencji w obiektach gr i txdb. Styl ten odnosi się do sposobu, w jaki nazywane są chromosomy (np. "chr1" vs "1").
```

# Dopasowanie poziomów sekwencji

```{r}
setdiff(seqlevels(gr), seqlevels(txdb))

```

```{r}
seqlevels(gr)

```

```{r}
seqlevels(gr) <- paste0("chr", seqlevels(gr)) #Zmieniono nazwy chromosomów w obiekcie gr, dodając prefiks "chr", aby pasowały do nazw w pliku VCF

```

```{r}
setdiff(seqlevels(gr), seqlevels(txdb))  # Powinno zwrócić pustą wartość

```

# Zachowanie tylko kompatybilnych poziomów sekwencji:

```{r}
gr <- keepSeqlevels(gr, seqlevels(txdb), pruning.mode = "coarse") #usuwa poziomy sekwencji, które występują w gr, ale nie są obecne w txdb.
loc_anno <- locateVariants(gr, txdb, AllVariants())
head(loc_anno)

```

# Sprawdzenie zgodności poziomów sekwencji:

```{r}
valid_seqlevels <- intersect(seqlevels(gr), seqlevels(txdb))

```

```{r}
gr <- keepSeqlevels(gr, valid_seqlevels, pruning.mode = "coarse")

```

```{r}
loc_anno <- locateVariants(gr, txdb, AllVariants())
head(loc_anno)

```

# Trymowanie obiektu GRanges

```{r}
gr <- trim(gr)

```

# Nadanie długości sekwencji

```{r}
seqlengths(gr) <- seqlengths(txdb)[seqlevels(gr)]
```

```{r}
loc_anno <- locateVariants(gr, txdb, AllVariants())
head(loc_anno)

```

# Ponowne trymowanie po nadaniu długości

```{r}
gr <- trim(gr)

```

```{r}
head(loc_anno)

```
