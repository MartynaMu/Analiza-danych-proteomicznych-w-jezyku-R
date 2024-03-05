Analiza danych proteomicznych w języku R
================
Martyna Muszczek
2024-03-05

- <a href="#zagadnienia" id="toc-zagadnienia">Zagadnienia</a>
- <a href="#materiały-pomocnicze" id="toc-materiały-pomocnicze">Materiały
  pomocnicze</a>
- <a href="#uwagi-wstępne" id="toc-uwagi-wstępne">Uwagi wstępne</a>
- <a href="#przebieg-ćwiczenia" id="toc-przebieg-ćwiczenia">Przebieg
  ćwiczenia</a>
- <a href="#przygotowanie-środowiska"
  id="toc-przygotowanie-środowiska">Przygotowanie środowiska</a>
- <a href="#załadowanie-bibliotek"
  id="toc-załadowanie-bibliotek">Załadowanie bibliotek</a>
- <a href="#ustawienie-globalnego-motywu-wykresów"
  id="toc-ustawienie-globalnego-motywu-wykresów">*Ustawienie globalnego
  motywu wykresów</a>
- <a href="#i-przygotowanie-danych-pod-analizę"
  id="toc-i-przygotowanie-danych-pod-analizę">I. Przygotowanie danych pod
  analizę</a>
  - <a href="#załadowanie-danych-z-maxquanta---proteingroupstxt"
    id="toc-załadowanie-danych-z-maxquanta---proteingroupstxt">Załadowanie
    danych z MaxQuanta - ‘proteinGroups.txt’</a>
  - <a href="#selekcja-kolumn-istotnych-dla-dalszej-analizy"
    id="toc-selekcja-kolumn-istotnych-dla-dalszej-analizy">Selekcja kolumn
    istotnych dla dalszej analizy</a>
  - <a href="#podstawienie-na-zamiast-0"
    id="toc-podstawienie-na-zamiast-0">Podstawienie ‘NA’ zamiast ‘0’</a>
  - <a href="#sprawdzenie-sum-na-w-każdej-kolumnie"
    id="toc-sprawdzenie-sum-na-w-każdej-kolumnie">Sprawdzenie sum NA w
    każdej kolumnie</a>
  - <a href="#filtrowanie-rzędów-z-niekompletnymi-obserwacjami"
    id="toc-filtrowanie-rzędów-z-niekompletnymi-obserwacjami">Filtrowanie
    rzędów z niekompletnymi obserwacjami</a>
  - <a href="#sprawdzenie-czy-kolumna-id-może-służyć-za-indeks"
    id="toc-sprawdzenie-czy-kolumna-id-może-służyć-za-indeks">Sprawdzenie,
    czy kolumna ‘ID’ może służyć za indeks</a>
  - <a href="#konwertowanie-kolumny-id-do-indeksu"
    id="toc-konwertowanie-kolumny-id-do-indeksu">Konwertowanie kolumny ‘ID’
    do indeksu</a>
  - <a href="#zmiana-nazw-kolumn" id="toc-zmiana-nazw-kolumn">Zmiana nazw
    kolumn</a>
  - <a href="#transformacja-danych-liczbowych"
    id="toc-transformacja-danych-liczbowych">Transformacja danych
    liczbowych</a>
- <a href="#ii-eksploracja-danych" id="toc-ii-eksploracja-danych">II.
  Eksploracja danych</a>
  - <a
    href="#sprawdzenie-normalizacji-między-próbami-i-grupami-eksperymentalnymi-rozkład-danych"
    id="toc-sprawdzenie-normalizacji-między-próbami-i-grupami-eksperymentalnymi-rozkład-danych">Sprawdzenie
    normalizacji między próbami i grupami eksperymentalnymi (rozkład
    danych)</a>
  - <a href="#globalna-heatmapa---profile-ekspresji-białek"
    id="toc-globalna-heatmapa---profile-ekspresji-białek">Globalna heatmapa
    - profile ekspresji białek</a>
- <a href="#iii-analiza-ekspresji-różnicowej-białek"
  id="toc-iii-analiza-ekspresji-różnicowej-białek">III. Analiza ekspresji
  różnicowej białek</a>
  - <a href="#volcano-plot" id="toc-volcano-plot">Volcano plot</a>
  - <a href="#gene-ontology-enrichment"
    id="toc-gene-ontology-enrichment">Gene Ontology enrichment</a>
  - <a href="#session-info" id="toc-session-info">Session info</a>

## Zagadnienia

- import danych z ‘proteinGroups.txt’ (MaxQuant)

- porządkowanie danych

- usuwanie niekompletnych obserwacji

- przygotowanie macierzy liczbowej pod analizę

- eksploracja rozkładu danych, normalizacja

- klastrowanie i korelacja prób eksperymentalnych

- analiza ekspresji różnicowej białek (differential expression
  analysis):

  - statystyka: parowany test t Studenta, fold change, multiple testing
    correction

  - analiza funkcyjna białek o zmienionej ekspresji: Gene Ontology
    Over-Representation Analysis (ORA)

  - wizualizacja: volcano plot, goplot, barplot

- zastosowanie pakietów ggplot2, pheatmap, i enrichplot w wizualizacji

## Materiały pomocnicze

- ggplot2-cheatsheet.pdf

- base-r-cheatsheet.pdf

## Uwagi wstępne

W trakcie ćwiczeń w celu objaśnienia używanych funkcji można skorzystać
z wbudowanego w RStudio Helpera - w konsoli wpisz “?nazwaFunkcji()” lub
“??nazwaFunkcji()”, jeśli jest to funkcja z poza podstawowych pakietów
R. Jest to wygodny sposób na podejrzenie używanych argumentów.

By zapisać wykres, najłatwiej jest w panelu “Plots” kliknąć “Export”,
“Save as image”, następnie dostosować wielkość wykresu przeciągając
prawym dolnym rogiem, nadać nazwę i wybrać folder zapisu.

Jeśli nie jesteś pewien jakiego elementu wykresu użyć, lub jak go użyć.
Zajrzyj do pliku “ggplot2_cheatsheet.pdf”.

## Przebieg ćwiczenia

## Przygotowanie środowiska

1.  Skopiuj pliki z danymi do nowego folderu.

2.  Uruchom RStudio i stwórz nowy projekt. Stwórz podfoldery “data” i
    inne, np. “scripts”, “figures” itp. Do folderu “data” skopiuj pliki
    z danymi - proteinGroups.txt i statistics.txt - a do folderu
    “scripts” plik install_packages.R.

3.  Poprzez RStudio otwórz skopiowany plik skryptowy R i uruchom go -
    trwa instalacja pakietów potrzebnych do ćwiczeń.

4.  Po udanej instalacji stwórz nowy, pusty plik R i kontynuuj.

## Załadowanie bibliotek

Na ten moment, użyj funkcji <code>library()</code>, by załadować tylko
pakiet ‘tidyverse’.

``` r
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ## ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
    ## ✔ purrr     1.0.2     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

## \*Ustawienie globalnego motywu wykresów

``` r
theme_set(theme_bw()+theme(legend.position = "top"))
```

## I. Przygotowanie danych pod analizę

### Załadowanie danych z MaxQuanta - ‘proteinGroups.txt’

1.  Załaduj dane z pliku proteinGroups.txt funkcją
    <code>read.table()</code>. Wyświetl wczytaną tabelę i przyjrzyj się
    jej. Czy została ona wczytana poprawnie? Szczególnie zwróć uwagę na
    interpretację punktu dziesiętnego.
2.  Czy typy kolumn zostały poprawnie przypisane? Użyj funkcji
    <code>str()</code>, by zobaczyć strukturę data.frame’u.
3.  Usuń rzędy danych, które zawierają informacje o białkach
    zawierających odwrócone sekwencje lub mogą być potencjalnymi
    zanieczyszczeniami - kolumny ‘Reverse’ i ‘Potential.contaminant’ -
    funkcją <code>filter()</code>. Sprawdź, jak zmieniła się liczba
    rzędów - funkcja <code>nrow()</code>.

``` r
df <-read.table("data/proteinGroups.txt", sep = "\t", header = TRUE, quote = "", 
                comment.char = "") %>% select(!contains(c("2h", "4h")))
nrow(df)
```

    ## [1] 4467

``` r
df <- filter(df, Reverse != "+" & Potential.contaminant != "+")
nrow(df)
```

    ## [1] 4334

### Selekcja kolumn istotnych dla dalszej analizy

Na tym etapie możemy podzielić dane na dwie części. Jedna będzie służyła
do zachowania informacji biologicznych, jak np. zmapowanie białek do ich
Uniprot ID, pełna nazwa białka, nazwa genu itp. Czasem, tak jak w naszym
przypadku, nie jest możliwa konwersja tych informacji poprzez funkcje
pakietów, dlatego chcemy je zachować, by posłużyły one później za
etykiety czytelne dla człowieka. Druga część posłuży do zbudowania
matrycy intensywności białek, którą będziemy poddawać analizie.

4.  Użyj funkcji <code>colnames()</code>, by zapoznać się z kolumnami.

``` r
colnames(df)
```

5.  Następnie określ i wyselekcjonuj kolumny zawierające informacje o
    zmapowaniu białek do nowej zmiennej. Do obecnego lub nowego
    data.frame’u wyselekcjonuj tylko kolumnę ‘Protein.IDs’ i kolumny
    zawierające wyrażenie ‘LFQ.intensity’. Użyj funkcji
    <code>select()</code>, a wewnątrz niej <code>contains()</code> z
    szukanymi wyrażeniami. Sprawdź, czy selekcja była udana - kolumn
    powinno być razem 9.

``` r
prot_info <- select(df, contains(c("Protein.", "protein.", "Gene")))
df <- select(df, contains(c("Protein.IDs", "LFQ.intensity"), ignore.case = FALSE))
colnames(df)
```

    ## [1] "Protein.IDs"             "LFQ.intensity.RPN4_0h_1"
    ## [3] "LFQ.intensity.RPN4_0h_2" "LFQ.intensity.RPN4_0h_3"
    ## [5] "LFQ.intensity.RPN4_0h_4" "LFQ.intensity.wt_0h_1"  
    ## [7] "LFQ.intensity.wt_0h_2"   "LFQ.intensity.wt_0h_3"  
    ## [9] "LFQ.intensity.wt_0h_4"

### Podstawienie ‘NA’ zamiast ‘0’

W tabeli znajdują się zera. W spektrometrii mas jak i w ogóle data
science, jeśli pomiar jest równy 0, nie oznacza to wcale, że dane
białko/cecha nie znajduje się w próbce. Dlatego należy skonwertować 0 na
‘NA’ - ‘not assigned’ - inaczej określa się taką wartość ‘missing
value’. Temat ‘missing values’ w spektrometrii mas jest obszerny, lecz w
praktyce albo się je pomija przy dalszej analizie, albo imputuje -
przypisuje wartość, np. z rozkładu normalnego, pod warunkiem, że nie
stanowią one dużej części danych.

5.  Zamień ‘0’ na ‘NA’ i potwierdź zamianę.

``` r
df[df == 0] <- NA
head(df)
```

    ## # A tibble: 6 × 9
    ##   Protein.IDs       LFQ.intensity.RPN4_0h_1 LFQ.intensity.RPN4_0h_2
    ##   <chr>                               <dbl>                   <dbl>
    ## 1 Q3E7Y4;A0A023PXF5                      NA                      NA
    ## 2 A0A023PXH9                             NA                      NA
    ## 3 A5Z2X5                          918550000               876050000
    ## 4 D6VTK4                          178840000               143970000
    ## 5 D6W196                           13385000                19517000
    ## 6 O13297                          332550000               258360000
    ## # ℹ 6 more variables: LFQ.intensity.RPN4_0h_3 <dbl>,
    ## #   LFQ.intensity.RPN4_0h_4 <dbl>, LFQ.intensity.wt_0h_1 <dbl>,
    ## #   LFQ.intensity.wt_0h_2 <dbl>, LFQ.intensity.wt_0h_3 <dbl>,
    ## #   LFQ.intensity.wt_0h_4 <dbl>

### Sprawdzenie sum NA w każdej kolumnie

6.  Następnie sprawdź, ile w każdej kolumnie znajduje się ‘missing
    values’.

    \*Dodając ‘!’ przed <code>is.na()</code> możemy policzyć, ile białek
    zostało zidentyfikowanych w każdej próbce.

``` r
colSums(is.na(df))
```

    ##             Protein.IDs LFQ.intensity.RPN4_0h_1 LFQ.intensity.RPN4_0h_2 
    ##                       0                     607                     513 
    ## LFQ.intensity.RPN4_0h_3 LFQ.intensity.RPN4_0h_4   LFQ.intensity.wt_0h_1 
    ##                     572                     531                     715 
    ##   LFQ.intensity.wt_0h_2   LFQ.intensity.wt_0h_3   LFQ.intensity.wt_0h_4 
    ##                     705                     672                     674

### Filtrowanie rzędów z niekompletnymi obserwacjami

7.  Usuń rzędy, które w którejkolwiek kolumnie zawierają ‘missing
    values’ - ‘NA’. Użyj <code>drop_na()</code>. Potwierdź zmianę.

``` r
df <- drop_na(df)
nrow(df)
```

    ## [1] 3134

### Sprawdzenie, czy kolumna ‘ID’ może służyć za indeks

Bardzo ułatwi nam pracę, jeśli każde białko będziemy wyszukiwać po ich
nazwie, a nie automatycznym numerze w indeksie. Żeby symbol białka mógł
stać się indeksem, trzeba sprawdzić, czy żaden symbol się nie powtarza -
tj. czy kolumna ‘Protein.IDs’ zawiera tylko unikalne, niezduplikowane
wartości.

8.  Użyj funkcji <code>duplicated()</code> wewnątrz funkcji
    <code>any()</code>, by sprawdzić, czy którakolwiek wartość w
    kolumnie ‘Protein.IDs’ jest zduplikowana.

    \*Analogicznie możemy sprawdzić, czy wszystkie wartości są unikalne.

``` r
any(duplicated(df$Protein.IDs))
```

    ## [1] FALSE

``` r
all(!duplicated(df$Protein.IDs))
```

    ## [1] TRUE

### Konwertowanie kolumny ‘ID’ do indeksu

9.  Jeśli nie ma zduplikowanych wartości, zamień kolumnę na indeks -
    <code>column_to_rownames()</code>. Potwierdź zmianę.

``` r
df <- column_to_rownames(df, "Protein.IDs")
head(df)
```

    ## # A tibble: 6 × 8
    ##   LFQ.intensity.RPN4_0h_1 LFQ.intensity.RPN4_0h_2 LFQ.intensity.RPN4_0h_3
    ##                     <dbl>                   <dbl>                   <dbl>
    ## 1               918550000               876050000               787760000
    ## 2               178840000               143970000               112940000
    ## 3                13385000                19517000                20219000
    ## 4               332550000               258360000               351480000
    ## 5                69829000                75441000                88134000
    ## 6               174340000               119900000               145970000
    ## # ℹ 5 more variables: LFQ.intensity.RPN4_0h_4 <dbl>,
    ## #   LFQ.intensity.wt_0h_1 <dbl>, LFQ.intensity.wt_0h_2 <dbl>,
    ## #   LFQ.intensity.wt_0h_3 <dbl>, LFQ.intensity.wt_0h_4 <dbl>

### Zmiana nazw kolumn

10. Nazwy kolumn, czyli de facto nazw prób, są za długie. Skróć
    <code>colnames(df)</code> o wyrażenie “LFQ.intensity” używając
    <code>str_replace_all()</code>. Potwierdź zmianę.

``` r
colnames(df) <- colnames(df) |> str_replace_all(pattern = "LFQ.intensity.", replacement = "")
colnames(df)
```

    ## [1] "RPN4_0h_1" "RPN4_0h_2" "RPN4_0h_3" "RPN4_0h_4" "wt_0h_1"   "wt_0h_2"  
    ## [7] "wt_0h_3"   "wt_0h_4"

### Transformacja danych liczbowych

11. Zauważ, że intensywności mają szeroki zakres liczbowy. Możemy
    podejrzeć rozkład danych poprzez histogram.

``` r
df %>%
  pivot_longer(cols=1:8,
               names_to = "Sample",
               values_to = "Log2.Intensity") %>%
  ggplot(aes(x=Log2.Intensity))+
  geom_histogram()+ 
  facet_wrap(~Sample)
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](whole_workflow_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

12. Typowo dane proteomiczne zawierają dużo białek o niższej ekspresji,
    a mało o wyższej. Dlatego, by poddać je m.in. testom statystycznym,
    należy je zeskalować, przetransformować - np. poprzez logarytmizację
    o podstawie 2 lub 10. Jeszcze raz sprawdź rozkład danych.

``` r
df <- mutate(df, log2(df))

df %>%
  pivot_longer(cols=1:8,
               names_to = "Sample",
               values_to = "Log2.Intensity") %>%
  ggplot(aes(x=Log2.Intensity))+
  geom_histogram()+ 
  facet_wrap(~Sample)
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](whole_workflow_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

## II. Eksploracja danych

### Sprawdzenie normalizacji między próbami i grupami eksperymentalnymi (rozkład danych)

1.  Dane są gotowe do analizy. Wpierw sprawdź rozkład danych i ich
    kwantyle pomiędzy próbami. Dobrym sposobem jest tradycyjny ‘box
    plot’, ale jeszcze lepszym ‘violin plot’ z ‘box plotem’. Określ, czy
    dane z różnych prób są znormalizowane - tj. mają podobny rozkład
    danych.

``` r
df %>%
  pivot_longer(cols=1:8,
               names_to = "Sample",
               values_to = "Log2.Intensity") %>%
  ggplot(aes(x=Sample,y=Log2.Intensity))+
  geom_violin(trim = FALSE)+
  geom_boxplot(width=0.1)
```

![](whole_workflow_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

2.  To samo możemy sprawdzić poprzez ‘density plot’. Dobrą praktyką jest
    wizualizacja danych na różne sposoby, by ocenić je jakościowo.

``` r
df %>%
  pivot_longer(cols=1:8,
               names_to = "Sample",
               values_to = "Log2.Intensity") %>%
  ggplot(aes(x=Log2.Intensity, color=Sample))+
  geom_density()
```

![](whole_workflow_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

### Globalna heatmapa - profile ekspresji białek

Stwórz heatmapę, by odkryć profile ekspresji próbek i jak one wpływają
na klastrowanie się w grupy eksperymentalne. Globalna heatmapa
(wszystkie zidentyfikowane białka) może dostarczyć informacji, czy
istnieją duże zmiany wpływające na podobieństwo grup. W praktyce
heatmapy używane są w publikacjach do wizualizacji zmiany ekspresji
interesujących, konkretnych grup białek.

3.  Załaduj bibliotekę ‘pheatmap’ i użyj funkcji
    <code>pheatmap()</code>. Ponieważ interesują nas zmiany w ekspresji
    białek pod wpływem zmiennej niezależnej (tutaj knock-out genu RPN4),
    czyli między próbami, należy ustawić argument <code>scale =
    “row”</code>.

``` r
library(pheatmap)
pheatmap(df, 
         scale = "row", 
         show_rownames = FALSE, # nieczytelne przy globalnej hm
         treeheight_row = 0, # j.w.
         main = "Simple heatmap")
```

![](whole_workflow_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

4.  Stwórz adnotację kolumn heatmapy, żeby lepiej uwidocznić
    klastrowanie się w grupy eksperymentalne. Należy stworzyć nowy
    data.frame z jedną kolumną typu ‘factor’ zawierającą wartości z
    nazwą grupy eksperymentalnej, powtórzoną tyle razy, ile należy do
    niej prób. Następnie jako <code>rownames()</code> należy przypisać
    nazwy prób (są one zawarte w kolumnach ‘df’). Potwierdź poprawną
    adnotację wyświetlając stworzony data.frame, a następnie podstaw go
    pod argument <code>pheatmap(…, annotation_col = …)</code> . Czy
    biorąc pod uwagę globalne profile ekspresji, próby klastrują się w
    swoje grupy?

``` r
annot_col <- data.frame(Condition = as.factor(
  c(rep("RPN4_KO", 4), rep("WT", 4))),
  row.names = colnames(df))

pheatmap(df,
         scale = "row",
         annotation_col = annot_col,
         show_rownames = FALSE,
         treeheight_row = 0,
         main = "Heatmap with column annotation")
```

![](whole_workflow_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

5.  Jeśli nie odpowiadają nam automatyczne kolory adnotacji, możemy je
    zmienić argumentem <code>pheatmap(…, annotation_colors = …)</code>.
    W tym celu należy stworzyć nowy obiekt - listę z nazwanym wektorem -
    zawierającym wartości nowych kolorów. Następnie, za pomocą
    <code>names()</code> należy przypisać każdej wartości nazwę grupy
    eksperymentalnej.

    \*Jeśli chcemy mieć więcej adnotacji kolumn, należy do data.frame’u
    dodać nową kolumnę z nową adnotacją, a do istniejącej listy dodać
    nowy nazwany wektor i analogicznie zmapować wartości kolorów do grup
    adnotacyjnych.

``` r
annot_colors <- list(Condition = c("red", "blue"))
names(annot_colors$Condition) <- levels(annot_col$Condition)

pheatmap(df,
         scale = "row",
         annotation_col = annot_col,
         annotation_colors = annot_colors,
         show_rownames = FALSE,
         treeheight_row = 0,
         main = "Heatmap with column annotation")
```

![](whole_workflow_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

Analogicznie tworzy się adnotacje rzędów heatmapy - np. wg. wspólnych
cech białek, ich funkcji, czy po prostu po ich profilu ekspresji.

6.  Można też podstawić kolory z gotowych palet, np. pakietu
    “RColorBrewer”. Wyświetł palety przez
    <code>display.brewer.all()</code>. Podstaw za wartości
    <code>brewer.pal(liczba.kolorów, nazwa.palety)</code>.

``` r
library(RColorBrewer)
annot_colors <- list(Condition = brewer.pal(2, "Dark2")) # nr of picked colors, name of palette
```

    ## Warning in brewer.pal(2, "Dark2"): minimal value for n is 3, returning requested palette with 3 different levels

``` r
names(annot_colors$Condition) <- levels(annot_col$Condition)

pheatmap(df,
         scale = "row",
         annotation_col = annot_col,
         annotation_colors = annot_colors,
         show_rownames = FALSE,
         treeheight_row = 0,
         main = "Heatmap with column annotation")
```

![](whole_workflow_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

## III. Analiza ekspresji różnicowej białek

Po upewnieniu się, że mamy znormalizowane dane, można przystąpić do
analizy różnicowej ekspresji białek (differential expression analysis -
DEA). Można ją przeprowadzić poprzez samodzielne kodowanie od zera, albo
poprzez wiele dedykowanych do tego celu narzędzi, np. pakiety limma,
MSstats, DESeq2 itp. Większość tych narzędzi została zaprojektowana z
myślą o analizie danych pochodzących z sekwencjonowania lub
mikromacierzy, ale mogą być również użyte do danych proteomicznych. W
skrócie, analiza DEA opiera się na teście istotności pomiędzy średnimi
ekspresji dwóch - t-test studenta - lub wielu grup eksperymentalnych -
ANOVA - dla każdego białka.

W tym ćwiczeniu skupimy się na znalezieniu i wizualizacji wyników DEA.
Nie zważając na to, które narzędzie wybraliśmy, na końcu wyniki zawsze
zawierają przynajmniej 3 kolumny: log2 fold change, p-value testu
istotności i adjusted p-value/q-value/fdr z korekty dla wielokrotnego
testowania.

Plik ‘statistics.txt’ zawiera wyniki analizy DEA danych, na których do
tej pory pracowaliśmy.

1.  Wczytaj plik ‘statistics.txt’ funkcją <code>read.delim()</code>
    wybierając odpowiedni separator. Sprawdź poprawność importu.

``` r
deps <- read.delim("data/statistics.txt", sep = "\t")
head(deps)
```

    ## # A tibble: 6 × 7
    ##   ID     logFC AveExpr     t      P.Value adj.P.Val     B
    ##   <chr>  <dbl>   <dbl> <dbl>        <dbl>     <dbl> <dbl>
    ## 1 P22202  5.45    30.0  8.00 0.0000424    0.000714   2.32
    ## 2 P32590  4.48    28.7 20.6  0.0000000304 0.0000119  9.84
    ## 3 P33327  4.45    27.1 11.2  0.00000345   0.000150   5.01
    ## 4 P11986  3.96    29.4 12.8  0.00000128   0.0000910  6.06
    ## 5 Q03148  3.91    27.4 18.3  0.0000000779 0.0000168  8.92
    ## 6 P22943  3.73    31.9 16.1  0.000000206  0.0000340  7.94

### Volcano plot

‘Volcano plot’ jest powszechną metodą wizualizacji wyników DEA po
t-teście studenta. Na osi x przedstawiane są wartości log2 fold change
(krotność zmiany). a na osi y adjusted p-value/FDR/q-value.

1.  By stworzyć podstawowy wykres typu ‘volcano plot’, użyj warstwy
    <code>geom_point()</code>.

``` r
ggplot(deps, aes(x=logFC, y=adj.P.Val))+
  geom_point()
```

![](whole_workflow_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

2.  Jak widać, jest wiele punktów o Q-value bliskim 0 (istotność \<
    0.05). Żeby lepiej zwizualizować dane, musimy
    przeskalować/transformować wartości przez logarytmizację o podstawie
    10 i zmienić ich kierunek.

``` r
ggplot(deps, aes(x=logFC, y=-(log10(adj.P.Val))))+
  geom_point()
```

![](whole_workflow_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

3.  Dodajmy punkty odcięcia dla obu zmiennych dodając warstwy
    <code>geom_hline(), geom_vline()</code>. Statystyczną istotność
    (oś y) przyjmujemy jak powszechnie - \< 0.05. Odcięcie dla log2 fold
    change jest mocno umowne i zazwyczaj ustawia się go pod wielkość
    ogólnych zmian - minimum i maksimum log2 FC. Przyjmijmy -0.5 i 0.5
    za odcięcie log2 FC.

Uwaga: Poziom istotności dla q-value to 0.05, ale po transformacji jest
to około 1.3.

``` r
ggplot(deps, aes(x=logFC, y=-(log10(adj.P.Val))))+
  geom_point()+
  geom_hline(yintercept = 1.3, lty = 2)+ # q-value treshold - horizontal line
  geom_vline(xintercept = c(0.5, -0.5), lty = 2) # logFC cutoff - vertical line
```

![](whole_workflow_files/figure-gfm/unnamed-chunk-22-1.png)<!-- -->

4.  Pokolorujmy białka według ich istotności w zmianie ekspresji. Na
    początek, trzeba dodać nową pustą kolumnę do tabeli z wynikami DEA.
    Następnie dodać wartość do kolumny na podstawie wartości w kolumnach
    ‘logFC’ i ‘adj.P.Val’. W ten sposób skategoryzujemy białka jako
    “Up-” (pozytywny FC) albo “Down-regulated” (negatywny FC) lub “Not
    significant” (nieistotny). Użyj <code>case_when()</code>

``` r
deps$Expression <- NA
deps$Expression <- case_when(
  deps$logFC <= -0.5 & deps$adj.P.Val <= 0.05 ~"Down-regulated",
  deps$logFC >= 0.5 & deps$adj.P.Val <= 0.05 ~"Up-regulated",
  .default = "Not significant")
tail(deps)
```

    ## # A tibble: 6 × 8
    ##   ID     logFC AveExpr     t   P.Value adj.P.Val      B Expression     
    ##   <chr>  <dbl>   <dbl> <dbl>     <dbl>     <dbl>  <dbl> <chr>          
    ## 1 P53899 -1.58    26.5 -7.90 0.0000463  0.000745  2.22  Down-regulated 
    ## 2 P40018 -1.64    29.1 -2.11 0.0679     0.132    -5.50  Not significant
    ## 3 P03872 -1.97    26.6 -5.79 0.000402   0.00292  -0.113 Down-regulated 
    ## 4 P43558 -2.51    26.5 -6.13 0.000274   0.00230   0.301 Down-regulated 
    ## 5 P11972 -2.98    27.3 -8.26 0.0000335  0.000633  2.57  Down-regulated 
    ## 6 P38737 -3.14    27.7 -6.56 0.000172   0.00172   0.806 Down-regulated

5.  Następnie, by zmapować nazwy istotnych białek do punktów na
    wykresie, stwórz kolejną kolumnę, która będzie zawierała ID, ale
    tylko przy białkach “Up-regulated” i “Down-regulated”, reszta rzędów
    pozostanie pusta. Użyj <code>if_else()</code>

``` r
deps$Label <- NA # empty vector
deps$Label <- if_else(deps$Expression %in% c("Up-regulated", "Down-regulated"), deps$ID, NA)
tail(deps)
```

    ## # A tibble: 6 × 9
    ##   ID     logFC AveExpr     t   P.Value adj.P.Val      B Expression      Label 
    ##   <chr>  <dbl>   <dbl> <dbl>     <dbl>     <dbl>  <dbl> <chr>           <chr> 
    ## 1 P53899 -1.58    26.5 -7.90 0.0000463  0.000745  2.22  Down-regulated  P53899
    ## 2 P40018 -1.64    29.1 -2.11 0.0679     0.132    -5.50  Not significant <NA>  
    ## 3 P03872 -1.97    26.6 -5.79 0.000402   0.00292  -0.113 Down-regulated  P03872
    ## 4 P43558 -2.51    26.5 -6.13 0.000274   0.00230   0.301 Down-regulated  P43558
    ## 5 P11972 -2.98    27.3 -8.26 0.0000335  0.000633  2.57  Down-regulated  P11972
    ## 6 P38737 -3.14    27.7 -6.56 0.000172   0.00172   0.806 Down-regulated  P38737

6.  Użyj nowych kolumn i zmapuj je do argumentów <code>aes(label = …,
    color = …)</code>. Dodaj jeszcze warstwę <code>geom_text()</code>.

``` r
v <- ggplot(deps, aes(x=logFC, 
                     y=-(log10(adj.P.Val)), 
                     label = Label, 
                     color = Expression))+
      geom_point(alpha = 0.2)+
      geom_hline(yintercept = 1.3, lty = 2)+ # q-value treshold
      geom_vline(xintercept = c(0.5, -0.5), lty = 2)+ # logFC cutoff
      geom_text(check_overlap = TRUE) # ensure labels won't overlap
v
```

    ## Warning: Removed 2614 rows containing missing values (`geom_text()`).

![](whole_workflow_files/figure-gfm/unnamed-chunk-25-1.png)<!-- -->

7.  Teraz dodajmy wybrane przez nas kolory - funkcja/warstwa
    <code>scale_color_manual()</code>.

``` r
v <- v+ 
      scale_color_manual(values=c("Down-regulated" = "blue", 
                                  "Not significant" = "grey", 
                                  "Up-regulated" = "red"))
v
```

    ## Warning: Removed 2614 rows containing missing values (`geom_text()`).

![](whole_workflow_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

8.  Podszlifujmy elementy wykresu - zmieńmy nazwy osi, tytuł i podtytuł
    wykresu, adnotację - funkcja/warstwa <code>labs()</code>.

``` r
v <- v+
      labs(title = "Differential expression",
           subtitle = "RPN4 knock out",
           x = "Log2 FC (RPN4 KO/WT)",
           y = "-log10 Q-value",
           caption = "This is a caption")
v
```

    ## Warning: Removed 2614 rows containing missing values (`geom_text()`).

![](whole_workflow_files/figure-gfm/unnamed-chunk-27-1.png)<!-- -->

9.  Jeśli tworzymy wykresy tego samego typu, porównując ze sobą różne
    dane, dobrą praktyką jest ustawienie tej samej skali osi, co ułatwia
    porównanie - funkcja/warstwa <code>scale_x\_continuous(),
    scale_y\_continuous()</code>.

``` r
v+
  scale_x_continuous(limits = c(-6, 6))+
  scale_y_continuous(limits = c(0, 7))
```

    ## Warning: Removed 2614 rows containing missing values (`geom_text()`).

![](whole_workflow_files/figure-gfm/unnamed-chunk-28-1.png)<!-- -->

10. By zmienić rozmiar czcionki elementów, zmodyfikuj np.
    <code>theme(text=…, axis.title.x=…, axis.title.y=…)</code>.

``` r
v+
  theme(text = element_text(size = 15), # change all text elements size
        axis.title.x = element_text(size = 20), # change x axis title size
        axis.title.y = element_text(size = 5)) # change y axis title size
```

    ## Warning: Removed 2614 rows containing missing values (`geom_text()`).

![](whole_workflow_files/figure-gfm/unnamed-chunk-29-1.png)<!-- -->

Można modyfikować każdy element osobno, zobacz dokumentację poprzez
<code>?ggplot2::theme()</code>.

### Gene Ontology enrichment

Mając listę białek o istotnie zmienionej ekspresji (DEP - differentially
expressed proteins), kolejnym krokiem może być analiza funkcyjna, która
dostarczy odpowiedzi nt. tego, jakie biologiczne lub molekularne procesy
i szlaki metaboliczne uległy zmianie pod wpływem zmiennej niezależnej.

Używa się w tym celu baz np. Gene Ontology (z podziałem na Biological
Process, Molecular Function i Cellular Compartment), KEGG pathways,
Reactome itp.

**Uwaga:** W przypadku małej liczby białek o zmienionej ekspresji może
nie być możliwa analiza statystyczna typu “over-representation analysis”
lub “gene set enrichment analysis” - FDR \> 0.05. W takim razie należy
posłużyć się tylko adnotacją funkcjonalną białek.

Przeprowadźmy Over-Representation Analysis (ORA) w oparciu o gene
ontology, przy użyciu pakietu clusterProfiler i enrichplot do
wizualizacji wyników.

1.  Załaduj biblioteki. ‘org.Sc.sgd.db’ to baza danych adnotacji genomu
    <i>S. cerevisiae</i>.

``` r
library(clusterProfiler)
library(org.Sc.sgd.db)
library(enrichplot)
```

2.  Utwórz zmienne zawierające ID białek o podwyższonej i obniżonej
    ekspresji z obiektu ‘df’. Utwórz również zmienną ‘ref’ zawierającą
    wszystkie ID zidentyfikowanych białek - będzie stanowić tło dla
    obliczanej statystyki wzbogacenia danego term’u.

``` r
upreg <- filter(deps, Expression == "Up-regulated")$ID

downreg <- filter(deps, Expression == "Down-regulated")$ID

ref <- deps$ID
```

3.  Za pomocą funkcji <code>enrichGO</code> przeprowadź GO ORA dla
    Biological process najpierw dla up-regulated proteins, a potem dla
    down-regulated. Wyświetlając <code><go_bp_up@result></code> możesz
    zobaczyć wyniki analizy.

``` r
go_bp_up <- enrichGO(gene = upreg, # wektor białek poddawanych ORA
               universe = ref, # tło statystyczne
               ont = "BP", # która ontologia
               OrgDb = org.Sc.sgd.db, # baza danych danego organizmu
               pAdjustMethod = "BH", # korekta dla wielokrotnego testowania
               keyType = "UNIPROT") # jaki typ ID jest wprowadzany
go_bp_up@result %>% head()
```

    ## # A tibble: 6 × 9
    ##   ID        Description GeneRatio BgRatio   pvalue p.adjust  qvalue geneID Count
    ##   <chr>     <chr>       <chr>     <chr>      <dbl>    <dbl>   <dbl> <chr>  <int>
    ## 1 GO:00420… protein re… 15/290    24/3039 2.08e-10  2.01e-7 1.83e-7 P2220…    15
    ## 2 GO:00059… carbohydra… 36/290    129/30… 8.45e-10  4.08e-7 3.72e-7 P5307…    36
    ## 3 GO:00064… 'de novo' … 13/290    22/3039 9.51e- 9  3.06e-6 2.79e-6 P2220…    13
    ## 4 GO:00090… aerobic re… 21/290    62/3039 9.11e- 8  1.70e-5 1.55e-5 Q0434…    21
    ## 5 GO:00510… 'de novo' … 10/290    15/3039 1.05e- 7  1.70e-5 1.55e-5 P2220…    10
    ## 6 GO:00510… chaperone … 10/290    15/3039 1.05e- 7  1.70e-5 1.55e-5 P2220…    10

4.  Cechą charakterystyczną tego typu analiz, jest to, że otrzymuje się
    długą listę term’ów, które często są blisko ze sobą spokrewnione.
    clusterProfiler posiada funkcję do usunięcia
    powtarzalnych/identycznych term’ów na podstawie semantyki. Użyj
    funkcji <code>simplify</code> na utworzonym obiekcie i porównaj
    ilość rzędów tabeli z wynikami.

``` r
go_bp_up_sim <- clusterProfiler::simplify(go_bp_up)
nrow(go_bp_up@result)
```

    ## [1] 967

``` r
nrow(go_bp_up_sim@result)
```

    ## [1] 31

5.  By zwizualizować najbardziej istotne statystycznie wyniki, użyj
    funkcji <code>barplot()</code>, lub <code>goplot()</code>.

``` r
barplot(go_bp_up_sim)
```

![](whole_workflow_files/figure-gfm/unnamed-chunk-34-1.png)<!-- -->

``` r
goplot(go_bp_up_sim)
```

    ## Warning: ggrepel: 26 unlabeled data points (too many overlaps). Consider
    ## increasing max.overlaps

![](whole_workflow_files/figure-gfm/unnamed-chunk-34-2.png)<!-- -->

6.  Na podstawie wyników określ, jakie zmiany prawdopodobnie zaszły pod
    wpływem knock-out’u genu RPN4 w drożdżach?

### Session info

``` r
sessionInfo()
```

    ## R version 4.3.2 (2023-10-31 ucrt)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 10 x64 (build 19045)
    ## 
    ## Matrix products: default
    ## 
    ## 
    ## locale:
    ## [1] LC_COLLATE=Polish_Poland.utf8  LC_CTYPE=Polish_Poland.utf8   
    ## [3] LC_MONETARY=Polish_Poland.utf8 LC_NUMERIC=C                  
    ## [5] LC_TIME=Polish_Poland.utf8    
    ## 
    ## time zone: Europe/Warsaw
    ## tzcode source: internal
    ## 
    ## attached base packages:
    ## [1] stats4    stats     graphics  grDevices utils     datasets  methods  
    ## [8] base     
    ## 
    ## other attached packages:
    ##  [1] enrichplot_1.22.0          org.Sc.sgd.db_3.18.0      
    ##  [3] AnnotationDbi_1.64.1       IRanges_2.36.0            
    ##  [5] S4Vectors_0.40.2           Biobase_2.62.0            
    ##  [7] BiocGenerics_0.48.1        clusterProfiler_4.11.0.001
    ##  [9] RColorBrewer_1.1-3         pheatmap_1.0.12           
    ## [11] lubridate_1.9.3            forcats_1.0.0             
    ## [13] stringr_1.5.1              dplyr_1.1.4               
    ## [15] purrr_1.0.2                readr_2.1.5               
    ## [17] tidyr_1.3.1                tibble_3.2.1              
    ## [19] ggplot2_3.4.4              tidyverse_2.0.0           
    ## 
    ## loaded via a namespace (and not attached):
    ##   [1] DBI_1.2.2               bitops_1.0-7            gson_0.1.0             
    ##   [4] shadowtext_0.1.3        gridExtra_2.3           rlang_1.1.3            
    ##   [7] magrittr_2.0.3          DOSE_3.28.2             compiler_4.3.2         
    ##  [10] RSQLite_2.3.5           png_0.1-8               vctrs_0.6.5            
    ##  [13] reshape2_1.4.4          pkgconfig_2.0.3         crayon_1.5.2           
    ##  [16] fastmap_1.1.1           XVector_0.42.0          labeling_0.4.3         
    ##  [19] ggraph_2.1.0            utf8_1.2.4              HDO.db_0.99.1          
    ##  [22] rmarkdown_2.25          tzdb_0.4.0              bit_4.0.5              
    ##  [25] xfun_0.42               zlibbioc_1.48.0         cachem_1.0.8           
    ##  [28] aplot_0.2.2             jsonlite_1.8.8          GenomeInfoDb_1.38.6    
    ##  [31] blob_1.2.4              highr_0.10              BiocParallel_1.36.0    
    ##  [34] tweenr_2.0.2            parallel_4.3.2          R6_2.5.1               
    ##  [37] stringi_1.8.3           GOSemSim_2.28.1         Rcpp_1.0.12            
    ##  [40] knitr_1.45              Matrix_1.6-5            splines_4.3.2          
    ##  [43] igraph_2.0.2            timechange_0.3.0        tidyselect_1.2.0       
    ##  [46] qvalue_2.34.0           rstudioapi_0.15.0       yaml_2.3.8             
    ##  [49] viridis_0.6.5           codetools_0.2-19        lattice_0.22-5         
    ##  [52] plyr_1.8.9              treeio_1.26.0           withr_3.0.0            
    ##  [55] KEGGREST_1.42.0         evaluate_0.23           gridGraphics_0.5-1     
    ##  [58] scatterpie_0.2.1        polyclip_1.10-6         Biostrings_2.70.2      
    ##  [61] ggtree_3.10.0           pillar_1.9.0            ggfun_0.1.4            
    ##  [64] generics_0.1.3          RCurl_1.98-1.14         hms_1.1.3              
    ##  [67] tidytree_0.4.6          munsell_0.5.0           scales_1.3.0           
    ##  [70] glue_1.7.0              lazyeval_0.2.2          tools_4.3.2            
    ##  [73] data.table_1.15.0       fgsea_1.28.0            fs_1.6.3               
    ##  [76] graphlayouts_1.1.0      fastmatch_1.1-4         tidygraph_1.3.1        
    ##  [79] cowplot_1.1.3           grid_4.3.2              ape_5.7-1              
    ##  [82] colorspace_2.1-0        nlme_3.1-164            patchwork_1.2.0        
    ##  [85] GenomeInfoDbData_1.2.11 ggforce_0.4.2           cli_3.6.2              
    ##  [88] fansi_1.0.6             viridisLite_0.4.2       gtable_0.3.4           
    ##  [91] yulab.utils_0.1.4       digest_0.6.34           ggplotify_0.1.2        
    ##  [94] ggrepel_0.9.5           farver_2.1.1            memoise_2.0.1          
    ##  [97] htmltools_0.5.7         lifecycle_1.0.4         httr_1.4.7             
    ## [100] GO.db_3.18.0            bit64_4.0.5             MASS_7.3-60.0.1
