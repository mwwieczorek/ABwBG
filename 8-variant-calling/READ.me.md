### Ćwiczenia 8 
### Variant calling

Podczas ćwiczeń wykorzystano następujące **pakiety** w celu przeprowadzenia Variant calling(wykrywanie wariantów)

**VariantTools** -

**Rsamtools** - funkcje do pracy z plikami BAM/SAM.

**GenomicRanges** - operacje na zakresach genomowych.

**GenomicFeatures** -  tworzenie obiektów opisujących cechy genomu.

**VariantAnnotation** -  funkcje do anotacji i manipulacji wariantami

**BiocParallel**- 



### Wykorzystane pliki do pracy 

 **"aligned_sample.BAM"**  plik BAm z odczytami 
 **"ecoli_reference.fasta"** - genom referencyjny 


### Obróbka plików polegała na:
- wczytaniu obu plików (genomu ref i odczytów) i przypisaniu im wartośći BamFile i FaFile (genom ref)
- indeksowanie pliku fasta z genomem ref
- sortowanie pliku BAM według współrzędnych (utorzenie pliku po stortowaniu i zdefiniowaniu jako sorted_BAM)
- indeksowaniu obu plików - BAm i fasta

### Następnie dokonano Kontroli jakości danych sekwencyjnych przxed wykrywaniem wariantów 
- sprawdzanie nagłówków pliku BAm
- podstawowe statystyki pliku BAM - o długości odczytów, liczby odczytów zmapowanych i niezmapowanych 
![image](https://github.com/user-attachments/assets/97713a10-d778-4ea0-a4f3-ad1fb9d6a0b9)

### Obliczanie pokrycia genomu 
![image](https://github.com/user-attachments/assets/f4fc2cc4-66e7-4e14-a376-b9ba9ba59de4)
- Region o największym pokryciu - obejmował 393 odczyty
- średnie pokrycie 32.02 
![image](https://github.com/user-attachments/assets/54e75cd7-a2a3-4f46-a106-49cada9e2df7)

### Wykrywanie wariantów za pomoca funkcji `callVariants()`
- parametry skanowania: ustalenie jakości odczytów (minimalna jakość baz = 20), funkcja ma rozróżniać nici oraz nukleotydy
- konwersja danych do ramki danych za pomoca pakiety **dplyr** 


**alt count** - ile razy dany odczyt alternatywny musi wystąpić aby był uzanany za prawidłowy np. 5 razy

**filter(total \>= 10** : ten argument oznacza liczbe odczytów - szukamy pozycji gdzie jest conajmniej 10 odczytów (minimalne pokrycie) - na podstawie podsumowania min/ kwartyl

**alt_count / total \>= 0.2** : proporcja odczytów alternatywnych dla genomu ref do wszystkich odczytów

 **Czynniki. które mogą wpływać na dokładność wykrywania wariantów**

    -   Jakość danych sekwencyjnych.
    -   Głębokość pokrycia.
    -   Użyte parametry w procesie variant calling.
    -   Błędy w mapowaniu odczytów do genomu referencyjnego.

 **Filtrowanie wariantów jest istotne, ponieważ**
    -   Usuwa fałszywie pozytywne warianty.
    -   Poprawia wiarygodność wyników.
    -   Skupia analizę na najbardziej istotnych biologicznie wariantach.

**Potencjalne źródła błędów w procesie variant calling**

    -   Błędy sekwencjonowania.
    -   Niewłaściwe mapowanie odczytów.
    -   Artefakty PCR.
    -   Zanieczyszczenia próbek.

**Kolejne kroki po wykryciu wariantów?**

    -   Anotacja wariantów (będzie tematem kolejnych zajęć).
    -   Analiza funkcjonalna.
    -   Interpretacja kliniczna (jeśli dotyczy).
