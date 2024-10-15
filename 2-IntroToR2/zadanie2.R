## Zadanie 2: Instalacja i użycie pakietów

**Cel:** Nauka instalowania i używania pakietów w R

### Instrukcje i rozwiązanie:

1.  **Zainstaluj pakiet `ggplot2`.**
  
  ``` r
install.packages("ggplot2")
```

2.  **Załaduj pakiet.**
  
  ``` r
library(ggplot2)
```

3.  **Sprawdź dokumentację pakietu.**
  
  ``` r
?ggplot2
```

4.  **Zainstaluj i załaduj** dodatkowy pakiet, który Cię zainteresuje. Listę pakietów w repozytorium CRAN wraz z opisami znajdziesz tutaj: <https://cran.r-project.org/web/packages/available_packages_by_name.html>
  
  ``` r
install.packages("plotly")
library(plotly)
```

5.  **Napisz krótki opis** w komentarzu.

#AntibodyTiters [Package AntibodyTiters version 0.1.24]
#Pakiet słuyzy do wizualizacji wyników miana przeciwciał w badaniach efektów szczepień, pozwala na wizualizację miana 
#przeciwciał wszystkich lub wybranych pacjentów. 
#Pakiet ten tworzy również puste pliki Excel w określonym formacie, w których użytkownicy mogą wypełniać dane eksperymentalne do wizualizacji. 
#Pliki Excel z surowymi danymi mogą być również tworzone, aby użytkownicy mogli zobaczyć, jak są wizualizowane przed uzyskaniem rzeczywistych danych. 
#Dane powinny zawierać wyniki miana przed szczepieniem, po pierwszym szczepieniu, po drugim szczepieniu i co najmniej jeden dodatkowy punkt próbkowania. 
#Zainteresował mnie, ze względu na swoje praktyczne wykorzystanie w badaniach nad szczepieniami.


``` r
# Pakiet 'plotly' służy do tworzenia interaktywnych wykresów.
# Zainteresował mnie, ponieważ umożliwia tworzenie dynamicznych wizualizacji danych.
```

6.  **Zapisz skrypt** jako `zadanie2.R` i prześlij go do swojego repozytorium.
