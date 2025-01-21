

### Instalowanie i ładowanie pakietów:
**VariantAnnotation** - do analizy plików VCF

**GenomicRanges** - do pracy z zakresami genetycznymi

**AnnotationHub** - do uzyskiwania danych adnotacyjnych


### plik wykorzystany na zajęciach --> chr22.vcf.gz, zawiera dane o wariantach genetycznych z chromosomu 22
- plik został przypisany do wartości vcf


### Analiza jakości:
- Funkcja `qual(vcf)` zwraca jakość wariantów w pliku VCF, 
- uzyskane statystyki dotyczące jakości wariantów:

  
  ![image](https://github.com/user-attachments/assets/bc26cb41-391e-401b-aad7-0a21d52a2caa)


### Filtrowanie wariantów:
- Warianty, które mają wartość jakości większą niż 99 i nie mają wartości NA (brak jakości), są zachowywane w obiekcie `vcf_filtered`
- Następnie dokonano analizy jakości przefiltrowanych wariantów.

### Instalowanie i ładowanie pakietu do adnotacji: "TxDb.Hsapiens.UCSC.hg19.knownGene"
- Ten pakiet zawiera dane dotyczące genomu ludzkiego (hg19) i pozwala na adnotację wariantów z pliku VCF względem znanych genów.

### Adnotacja wariantów:
 **Funkcja `rowRanges(vcf_filtered)`** zwraca zakresy chromosomowe z wariantów w przefiltrowanym pliku VCF (`gr`) 
 **Funkcja`locateVariants`** znajduje, gdzie te warianty pasują do elementów w bazie danych genów (`txdb`). 
 - Adnotacja ta jest przechowywana w zmiennej `loc_anno`.

### PROBLEM 
![image](https://github.com/user-attachments/assets/1e09b301-cf96-494d-aed4-910648ca4ee7)

- problem z niedopasowaniem nazw chromosomów i poziomów sekwencji pomiędzy obiektem `gr` (pochodzącym z `vcf_filtered`) a bazą danych `txdb` (TxDb.Hsapiens.UCSC.hg19.knownGene)
- został rozwiązany w następujący sposób:

1. **Dopasowanie nazw chromosomów:**
   ### Sprawdzanie i dopasowywanie stylów sekwencji:
```r
seqlevelsStyle(gr)
seqlevelsStyle(txdb)
```
- **Sprawdzanie stylów sekwencji**:
**Funkcja `seqlevelsStyle()`** sprawdza styl nazw sekwencji w obiektach `gr` i `txdb`. Styl ten odnosi się do sposobu, w jaki nazywane są chromosomy (np. "chr1" vs "1").

### Dopasowanie poziomów sekwencji:
```r
setdiff(seqlevels(gr), seqlevels(txdb))
seqlevels(gr)
seqlevels(gr) <- paste0("chr", seqlevels(gr))
setdiff(seqlevels(gr), seqlevels(txdb))
```
- **Dopasowanie poziomów sekwencji**:
**Funkcja `setdiff(seqlevels(gr), seqlevels(txdb))`** sprawdza, które poziomy sekwencji (chromosomy) występują w `gr`, ale nie w `txdb`.
- ponieważ różnice istnieją, dostosowano poziomy sekwencji za pomocą `seqlevels(gr) <- paste0("chr", seqlevels(gr))`, aby dopasować je do formatu używanego przez `txdb`.
- Zmieniono nazwy chromosomów w obiekcie `gr`, dodając prefiks "chr", aby pasowały do nazw w pliku VCF. Użyto do tego funkcji:

   ```r
   seqlevels(gr) <- paste0("chr", seqlevels(gr))
   ```
   - Ta linia kodu dodaje prefiks "chr" do każdej nazwy chromosomu w `gr`, co zapewnia zgodność z nazwami chromosomów w pliku VCF (np. "chr22" zamiast "22").

3. **Zachowanie tylko kompatybilnych poziomów sekwencji:**
- Aby zapewnić, że obiekt `gr` ma te same poziomy sekwencji co `txdb`, zastosowano funkcję `keepSeqlevels`, która usuwa niekompatybilne poziomy sekwencji z obiektu `gr`:

   ```r
   gr <- keepSeqlevels(gr, seqlevels(txdb), pruning.mode = "coarse")
   ```
- Ta linia usuwa poziomy sekwencji, które występują w `gr`, ale nie są obecne w `txdb`.

4. **Ponowne wyświetlenie wyników**
  ![image](https://github.com/user-attachments/assets/50a8848f-2073-48c4-b837-ae766012425f)


5. **Sprawdzenie zgodności poziomów sekwencji:**
- Aby upewnić się, że `gr` zawiera tylko sekwencje, które są również w `txdb`, użyto funkcji `intersect` do znalezienia wspólnych poziomów sekwencji:

   ```r
   valid_seqlevels <- intersect(seqlevels(gr), seqlevels(txdb))
   gr <- keepSeqlevels(gr, valid_seqlevels, pruning.mode = "coarse")
   ```

  - Dzięki temu pozostają tylko te poziomy sekwencji, które występują zarówno w `gr`, jak i w `txdb`.
6. **Ponowna próba wyśiwetlenia wyników**
    ![image](https://github.com/user-attachments/assets/c330cfd0-af13-462f-8c31-ee634e364b5b)
    ![image](https://github.com/user-attachments/assets/59564d58-2115-4619-9b2f-844c14408fa7)
- problemy:
1. **Out-of-bound ranges**: zakresy znajdują się poza dozwolonymi granicami chromosomów

2. **Brak długości sekwencji (` no seqlengths`)**:


7. **Trymowanie obiektu GRanges:**
- użyto funkcji `trim`, która obcina zakresy, które znajdują się poza dozwolonymi granicami:

   ```r
   gr <- trim(gr)
   ```
**Funkcja `trim()`** usuwa zakresy, które wychodzą poza granice dostępnych sekwencji w obiekcie `gr`.

### Dodawanie długości sekwencji:
```r
seqlengths(gr) <- seqlengths(txdb)[seqlevels(gr)]
```
- **Dodawanie długości sekwencji**:
  **Funkcja `seqlengths()`** przypisuje do obiektu `gr` długości sekwencji, które pochodzą z obiektu `txdb`
  - **`seqlevels(gr)`** aby zapewnić, że tylko sekwencje obecne w `gr` mają przypisane odpowiednie długości
 
### Ponowna próba gennerowania wyników
![image](https://github.com/user-attachments/assets/3041a344-8300-4ce2-9749-bf2bfdad9cdb)


### Ponowne trymowanie:
```r
gr <- trim(gr)
```
- **Ponowne trimowanie**:
- Ponownie używamy funkcji `trim()` po przypisaniu długości sekwencji, aby upewnić się, że wszystkie zakresy są poprawnie przycięte do długości dostępnych sekwencji.

### Wynik końcowy:
```r
head(loc_anno)
```
![image](https://github.com/user-attachments/assets/d5baa1f5-5a85-4da3-ac62-0ac816a4055c)

## **Wynik pokazuje zawartość obiektu `GRanges` z 6 zakresami i 9 kolumnami metadanych**

- Obiekt zawiera warianty znajdujące się na chromosomie `chr22`, głównie w regionach kodujących (`coding`), z jednym wariantem (`rs188399257`) znajdującym się w miejscu splicingowym (`spliceSite`).


