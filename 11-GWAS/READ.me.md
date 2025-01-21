Wczytaj i załaduj poniższe pakiety:
# GWAS - Badanie asocjacji na poziomie całego genomu
## GWAS - Genome Wide Association 
- badania asocjacyjne na poziomie całe genomu, mają na celu analizę powiązań genotypów z fenotypami 
poprzez testowanie róznic w częstości alleli wariantów genetycznych miedzy osobnikami, które są podobne pod wzgledem pochodzenia ale odmienne fenotypowo.
Najcześciej badanymi wariantami genetycznymi w analizie GWAS są SNP, zazwyczaj badania raportują bloki skorelowanych SNP (polimorfizmy pojedynczych nukleotydów), gdzie wszystkie wykazują istotne statystycznie powiązania
z interesujacą cechą - tzw. loci ryzyka.

## Cel ćwiczeń
- przeprowadzenie analizy GWAS wykorzystując pliki **staivas.413**
- **staivas.413.ped** informacje genotypowe
- **staivas.413.fam** informacje o osobnikach
- **RiceDiversity_44K_Phenotypes_34traits_PLINK.txt** informacje fenotypowe
- **staivas.413.map** informacje o mapowaniu SNP

## Pakiety wykorzystane do analizy w środowisku R
**dplyr** – manipulacja danymi

**qqman** – wizualizacja wyników GWAS (np.Manhattan plot)

**poolr** – analizy statystyczne i obliczenia na danych genotypowych

**rrBLUP** – analiza związków genotyp-fenotyp

**BGLR** – analiza danych genotypowych

**SNPRelate** – analiza SNP

# Przebieg analizy 
## **1. Wczytanie i wstępna obróbka danych genotypowych oraz fenotypowych**
- Wczytanie danych genotypowych z pliku .ped, informacji o osobnikach z pliku .fam, informacji o mapowaniu SNP z pliku .map.
- Przekodowanie wartości ramek danych SNP (markerów) wg. schematu:
2 → NA (brakujące dane).
0 → 0 (homozygota dla allelu głównego).
1 → 1 (heterozygota).
3 → 2 (homozygota dla allelu mniejszościowego).
- Przekonwertowanie danych na macierz o wymiarach:413 osobników, 36901 markerów SNP
- transpozycja oraz sprawdzenie wymiarów
- wczytanie danych fenotypowych
  
## **2.Kontrola jakości danych markerów SNP i usuwanie markerów o częstości alleli mniejszej niż 5% (MAF < 0.05).**
- Dokonano kontroli jakości danych markerów.
- Braki danych (NA)  zastąpiono średnią dla danego markera.
- W wyniku filtracji zmniejszyła się liczba markerów SNP do 36542.
  
## **3.Analiza PCA**
Analiza PCA (ang. Principal Component Analysis) to metoda statystyczna używana do redukcji wymiarowości danych przy jednoczesnym zachowaniu jak największej części zmienności danych.
- analiza głównych składowych w celu przedstawienia róznic między populacjami
- na podstawie wykresów mozna zauważyć wyodrębnienie 3 grup, pomiędzy którymi osobniki były podobne genotypowo.
  
<img width="608" alt="Wykres PCA 2" src="https://github.com/user-attachments/assets/7f1a60dc-1217-437b-b365-3efd860aaa16" />

<img width="591" alt="Wykres PCA 1" src="https://github.com/user-attachments/assets/a7996183-13d3-4db3-9db2-6e58abe67536" />


## **4.Przygotowanie danych do analizy GWAS**
- Dane genotypowe oraz informacje o SNP połączono w jedna tabelę
- Dane fenotypowe przypisano do odpowiednich odczytów

## **5.Przeprowadzenie analizy GWAS i wyodrębnienie istotnych markerów SNP**
- w celu analizy powiązań genotypów z fenotypami przeprowadzono GWAS
  
## **7.Stworzenie wykresu Manhattan do wizualizacji wyników**
- analiza wyodrębniła 9 SNP na chromosomach 1,2,3,6,7,12 jako istotnie statystyczne (SNP o wartościach p < **10 -4**)
<img width="625" alt="Manhattan Plot" src="https://github.com/user-attachments/assets/b5457eba-d1a3-44e7-a9f5-7b2b38d1e26e" />
