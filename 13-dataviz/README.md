# Wizualizacja danych - instalacja i wykorzystanie pakietów w celu analizy możliwości graficznych danych z zakresu genomiki 
### Wykorzystywane pakiety 
- ggplot2
- waffle
- maftools
- EnhancedVolcano
- pheatmap
- Rtsne
- qqman
- VennDiagram
- UpSetR
- pathview
- ape
- genoPlotR
- circlize
- karyoploteR
#### **W załaczonym w repozytorium pliku ćw 13 dołączono kod z podstawowymi funkcjami pakietów pozwalających na generowanie różnego rodzaju wykresów oraz funkcji wprowadzania przykładowych danych do wykresów.**
## Krótkie omówienie powyższych pakietów w kontekście wykorzystania w genomice 

---

### **1. ggplot2**
- **Zastosowanie**: Uniwersalny pakiet do wizualizacji danych oparty na koncepcji "Grammar of Graphics". Znajduje szerokie zastosowanie w analizie danych genomowych, w tym wizualizacji wyników różnicowej ekspresji genów oraz analiz statystycznych.
- **Możliwości graficzne**: Tworzenie różnorodnych wykresów, takich jak wykresy punktowe, słupkowe, liniowe, boxploty, histogramy czy wykresy gęstości, z pełną możliwością dostosowywania estetyki i układu graficznego.
- **Przykładowy graficzne**
  ![image](https://github.com/user-attachments/assets/7cb2caf2-bf0b-4199-b3da-066cc4d4e858)
  ![image](https://github.com/user-attachments/assets/707dc8e9-4c40-47d7-b825-04dc37ffd033)
  ![image](https://github.com/user-attachments/assets/f7ae830e-3576-4569-840a-514cefd3aae5)
  ![image](https://github.com/user-attachments/assets/137beb08-ac37-4cf4-90f0-0bd15a6588f1)
  ![image](https://github.com/user-attachments/assets/f07b8739-6757-4777-9981-dceba8da198d)




  

---

### **2. waffle**
- **Zastosowanie**: Wizualizacja proporcji lub udziałów danych w postaci wykresów mozaikowych (tzw. "waffle charts"). Szczególnie przydatny w przedstawianiu udziałów genów w określonych procesach biologicznych lub kategoriach funkcjonalnych.
- **Możliwości graficzne**: Generowanie czytelnych i atrakcyjnych graficznie wykresów mozaikowych, umożliwiających intuicyjną interpretację danych.
- **Przykłady graficzne**
![image](https://github.com/user-attachments/assets/61636045-874d-41e1-8106-ecc35dc90b3d)


---

### **3. maftools**
- **Zastosowanie**: Analiza i wizualizacja danych o mutacjach genomowych zapisanych w formacie MAF (Mutation Annotation Format). Szczególnie przydatny w badaniach nowotworowych do analizy profili mutacyjnych.
- **Możliwości graficzne**: Tworzenie zaawansowanych wizualizacji, takich jak oncoplots (profile mutacyjne), wykresy wodospadowe (waterfall plots) czy statystyczne zestawienia mutacji w podgrupach próbek.
- ***Przykłady graficzne**
![image](https://github.com/user-attachments/assets/f1a24018-a47d-415c-92c2-5c9bfafd67ca)


---

### **4. EnhancedVolcano**
- **Zastosowanie**: Tworzenie wykresów wulkanowych (volcano plots) wykorzystywanych do wizualizacji wyników analiz różnicowej ekspresji genów.
- **Możliwości graficzne**: Generowanie przejrzystych i estetycznych wykresów wulkanowych, z możliwością dynamicznego ustawiania progów istotności statystycznej (p-wartości) i wielkości efektu (log2FC).
- **Przykłady graficzne**
![image](https://github.com/user-attachments/assets/1e6e2ee4-875f-4873-8537-afa87e4b444d)

---

### **5. pheatmap**
- **Zastosowanie**: Tworzenie heatmap w celu wizualizacji danych wielowymiarowych, takich jak macierze ekspresji genów, z opcją klasteryzacji.
- **Możliwości graficzne**: Generowanie map cieplnych z automatycznym lub manualnym grupowaniem wierszy i kolumn oraz możliwością dodania dodatkowych adnotacji.
- **Przykłady graficzne**
![image](https://github.com/user-attachments/assets/c1b0d3d0-6586-4442-aee1-666e347b91d5)


---

### **6. Rtsne**
- **Zastosowanie**: Redukcja wymiarowości danych za pomocą algorytmu t-SNE, stosowanego do analizy klastrów i wizualizacji danych o dużej liczbie wymiarów, np. danych pojedynczych komórek (single-cell RNA-seq).
- **Możliwości graficzne**: Wizualizacja danych w zredukowanej przestrzeni wymiarów w postaci wykresów punktowych.
- **Przykłady graficzne**
![image](https://github.com/user-attachments/assets/4c780e30-1e42-4b5c-84a0-be5ba4fd92a4)

---

### **7. qqman**
- **Zastosowanie**: Wizualizacja wyników analizy asocjacji genetycznych (GWAS) w postaci wykresów Manhattan i wykresów kwantylowo-kwantylowych (QQ plots).
- **Możliwości graficzne**: Generowanie czytelnych wykresów Manhattan oraz analiz QQ, co umożliwia identyfikację istotnych loci genomowych.
- **Przykłady graficzne**
![image](https://github.com/user-attachments/assets/82da0e97-c4e5-4968-ac23-aee59230a6ad)


---

### **8. VennDiagram**
- **Zastosowanie**: Wizualizacja zbiorów danych w postaci diagramów Venna, wykorzystywana do identyfikacji i przedstawienia wspólnych elementów między różnymi grupami danych (np. zestawami genów).
- **Możliwości graficzne**: Tworzenie diagramów Venna z możliwością dostosowywania kolorystyki, liczby zbiorów oraz opisu.
- **Przykłady graficzne**
![image](https://github.com/user-attachments/assets/940ccc28-4254-4ece-b5aa-8bdde9c3dba4)

---

### **9. UpSetR**
- **Zastosowanie**: Analiza i wizualizacja przecięć zbiorów danych w bardziej zaawansowany sposób niż tradycyjne diagramy Venna.
- **Możliwości graficzne**: Generowanie wykresów UpSet, które przedstawiają relacje między zbiorami w formie tabelaryczno-graficznej, ułatwiając interpretację skomplikowanych zależności.
- **Przykłady graficzne**
![image](https://github.com/user-attachments/assets/e5db01cb-ac26-4f26-84d2-bc4979d2a5b4)

---

### **10. pathview**
- **Zastosowanie**: Wizualizacja ścieżek biologicznych (np. KEGG pathways) w połączeniu z wynikami analiz danych genomowych, takich jak ekspresja genów czy analiza metabolomiczna.
- **Możliwości graficzne**: Tworzenie schematów ścieżek biologicznych, na które mapowane są dane ilościowe, z możliwością szczegółowej analizy aktywności genów.
- **Przykłady graficzne**
![image](https://github.com/user-attachments/assets/8f8eb597-aea2-467c-a37f-f918afc19d4e)

---

### **11. ape**
- **Zastosowanie**: Analiza filogenetyczna i wizualizacja drzew filogenetycznych, wykorzystywana do badania pokrewieństwa genów, gatunków czy próbek.
- **Możliwości graficzne**: Tworzenie drzew filogenetycznych w różnych formatach (prostokątnych, radialnych, skośnych), z opcją ich edycji i adnotacji.
- **Przykłady graficzne**
  ![image](https://github.com/user-attachments/assets/06fcf3a1-5938-421f-827e-81c0bb3ced3e)

---

### **12. genoPlotR**
- **Zastosowanie**: Wizualizacja homologii genów oraz układów genów w genomach porównawczych.
- **Możliwości graficzne**: Generowanie schematów syntenii i porównawczych genomów z uwzględnieniem lokalizacji genów oraz regionów homologicznych.
- **Przykłady graficzne**
- ![image](https://github.com/user-attachments/assets/e5f38007-2f48-439b-9f6f-a23577f1e3e2)

---

### **13. circlize**
- **Zastosowanie**: Wizualizacja danych w formie diagramów kołowych (circular plots), szeroko stosowanych w genomice, np. do przedstawiania interakcji między chromosomami.
- **Możliwości graficzne**: Tworzenie zaawansowanych diagramów kołowych z warstwami danych, takich jak regiony genów, mutacje czy relacje między elementami genomu.
- **Przykłady graficzne**
![image](https://github.com/user-attachments/assets/65c05b03-10f7-4c80-ac3b-62aa9f1ebe0e)

---

### **14. karyoploteR**
- **Zastosowanie**: Wizualizacja danych genomowych w postaci ideogramów chromosomowych, umożliwiająca mapowanie danych genomowych na układ chromosomów.
- **Możliwości graficzne**: Generowanie ideogramów chromosomów z naniesionymi danymi, takimi jak SNP, loci genów czy wyniki analiz eksperymentalnych.
- **Przykłady graficzne**
![image](https://github.com/user-attachments/assets/7fdfb74a-ffec-4a8d-9a1f-584233ae363c)

---

