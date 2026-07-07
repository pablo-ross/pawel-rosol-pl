---
title: "Dane o kwarantannie w wyszukiwarce - czego uczy decyzja UODO wobec ośrodka pomocy społecznej (DKN.5131.27.2023)"
date: 2026-07-07T09:30:00.00Z
categories:
  - Urząd Ochrony Danych Osobowych
tags:
  - Analiza ryzyka
  - Naruszenie danych
  - Zgłoszenie naruszenia
  - Kara administracyjna
  - RODO
  - Dane szczególnej kategorii
  - Administrator danych
  - Sektor publiczny
  - COVID-19
description: "Ośrodek pomocy społecznej trafił do kar UODO, bo plik z danymi osób objętych kwarantanną COVID-19 zaindeksowała wyszukiwarka. Analiza decyzji DKN.5131.27.2023 i praktyczne wnioski dla administratorów."
faq:
  - question: "Jakie kary nałożył UODO w decyzji DKN.5131.27.2023?"
    answer: "UODO nałożył trzy kary na ośrodek pomocy społecznej: 15 000 zł za brak odpowiednich środków bezpieczeństwa (naruszenie art. 5, 25 i 32 RODO), 5 500 zł za niezgłoszenie naruszenia organowi nadzorczemu w ciągu 72 godzin (art. 33 ust. 1) oraz 13 200 zł za niezawiadomienie osób, których dane dotyczą (art. 34 ust. 1). Łącznie kary wyniosły 33 700 zł."
  - question: "Co doprowadziło do wycieku danych o kwarantannie?"
    answer: "Plik XLSX z danymi kilkuset mieszkańców, w tym informacją o objęciu kwarantanną lub izolacją COVID-19, trafił na prywatny serwer pracownika ośrodka pomocy społecznej. Katalog na tym serwerze był publicznie dostępny, więc jego zawartość zaindeksowała wyszukiwarka internetowa. O wycieku administrator dowiedział się nie z własnych zabezpieczeń, lecz z e-maila osoby postronnej."
  - question: "Dlaczego dane o kwarantannie są danymi szczególnej kategorii?"
    answer: "Informacja o objęciu obowiązkową kwarantanną lub izolacją w związku z COVID-19 to dane dotyczące stanu zdrowia, czyli dane szczególnej kategorii w rozumieniu art. 9 RODO. Ich przetwarzanie wymaga wyższego poziomu zabezpieczeń niż dane zwykłe, a naruszenie takich danych niesie większe ryzyko dla osób, których dotyczy."
---

**Plik w formacie XLSX z danymi kilkuset mieszkańców gminy, w tym informacją o tym, kto jest objęty kwarantanną i izolacją, wylądował na prywatnym serwerze pracownika. Katalog był publicznie dostępny, więc treść zaindeksowała wyszukiwarka i każdy mógł ją znaleźć. O wycieku administrator dowiedział się nie z własnych zabezpieczeń, lecz z e-maila osoby postronnej. Decyzja UODO o sygnaturze DKN.5131.27.2023 to podręcznikowy przykład tego, jak drobne zaniedbania organizacyjne prowadzą do naruszenia danych o stanie zdrowia.**

## Co się wydarzyło

Sprawa dotyczyła ośrodka pomocy społecznej, czyli jednostki publicznej realizującej zadania gminy. W czasie pandemii koordynator zatrudniony w ośrodku prowadził arkusz z danymi osób, którym udzielano wsparcia w związku z kwarantanną i izolacją. Plik powstał 30 października 2020 roku, a 23 listopada 2020 roku znalazł się na prywatnym serwerze pracownika. Katalog na tym serwerze był otwarty, więc jego zawartość zaindeksowała wyszukiwarka i stała się dostępna dla dowolnego użytkownika internetu.

Zakres danych był poważny: imiona i nazwiska, numery telefonów, adresy zamieszkania oraz informacja o objęciu obowiązkową kwarantanną lub izolacją. To ostatnie oznacza dane o stanie zdrowia, a więc dane szczególnej kategorii z art. 9 RODO. Wyciek dotyczył co najmniej kilkuset osób.

O wszystkim UODO dowiedział się 3 lutego 2021 roku, gdy postronna osoba przesłała wiadomość z bezpośrednim linkiem do pliku. Koordynator zorientował się dopiero 9 lutego 2021 roku i tego samego dnia plik usunął. Administrator nie wykrył incydentu sam. Zadziałał przypadek i czujność osoby z zewnątrz.

## Typowe błędy, które popełnił administrator

Decyzja jest o tyle pouczająca, że opisane błędy nie są egzotyczne. Powtarzają się w wielu organizacjach, także dużo lepiej wyposażonych niż gminny ośrodek.

### 1. Dane robocze na prywatnym sprzęcie

Punktem zapalnym było przeniesienie danych na prywatny serwer pracownika, poza kontrolą administratora. To klasyczny scenariusz "shadow IT": pracownik chce pracować wygodniej, więc kopiuje plik tam, gdzie ma do niego łatwy dostęp. Problem w tym, że taki serwer nie podlega żadnej polityce bezpieczeństwa organizacji. Nikt nie sprawdził, czy katalog jest zamknięty, czy dane są szyfrowane i kto ma do nich dostęp.

### 2. Analiza ryzyka istniała tylko na papierze

Ośrodek miał analizę ryzyka, ale UODO uznał ją za pozorną. Ryzyko oceniono jako "wysokie", po czym poprzestano na ogólnikowych zaleceniach, bez konkretnych działań, terminów wdrożenia i sposobu weryfikacji skuteczności. Charakterystyka procesu przetwarzania była niepełna, opis zakresu danych nieostry, a katalog zagrożeń zbyt wąski. Co istotne, ocena opierała się głównie na argumencie, że "wcześniej nic się nie wydarzyło", zamiast na obiektywnym badaniu prawdopodobieństwa i wagi skutków.

To ten sam mechanizm, który opisywałem przy okazji [kary dla McDonald's]({% post_url 2025-07-28-kara-mcdonalds %}) oraz [decyzji dotyczącej poczty e-mail]({% post_url 2026-06-16-ryzyko-danych-osobowych-poczta-email %}). Bez rzetelnej analizy ryzyka nie da się dobrać adekwatnych zabezpieczeń, bo nie wiadomo, przed czym właściwie chronimy dane.

### 3. Brak testowania i wykrywania incydentów

Skoro plik był publicznie dostępny od listopada do lutego, a organizacja dowiedziała się o tym od osoby postronnej, to znaczy, że nikt nie monitorował skuteczności zabezpieczeń. UODO wprost zarzucił brak regularnego testowania, mierzenia i oceny środków ochrony. Zabezpieczenia trzeba sprawdzać w praktyce, a nie zakładać, że działają.

### 4. Spór o to, kto jest administratorem

Ośrodek bronił się, twierdząc, że administratorem danych jest stacja sanitarno-epidemiologiczna albo straż pożarna, a nie on. UODO ten argument odrzucił. Skoro to ośrodek decydował o celach i sposobach przetwarzania w ramach organizowania pomocy, to on był administratorem, ze wszystkimi tego konsekwencjami. To ważna lekcja: roli administratora nie da się "oddać" innemu podmiotowi przez samo przekonanie, że ktoś inny się tym zajmuje. Podobny wątek pojawił się w [sprawie wyborów kopertowych]({% post_url 2025-03-28-rekordowa-kara-poczta-polska %}), gdzie również kluczowe było ustalenie, kto faktycznie decyduje o przetwarzaniu.

### 5. Brak zgłoszenia i brak zawiadomienia osób

Najpoważniejsza część decyzji dotyczy tego, co stało się po incydencie, a właściwie tego, co się nie stało. Ośrodek nie zgłosił naruszenia do UODO w ciągu 72 godzin, mimo że przetwarzał dane o stanie zdrowia. Nie zawiadomił też osób, których dane wyciekły, choć ryzyko dla ich praw i wolności było wysokie. Organ musiał nakazać zawiadomienie dopiero w samej decyzji.

## Ile to kosztowało

UODO nałożył trzy kary za trzy odrębne grupy naruszeń:

- **15 000 zł** za brak odpowiednich środków bezpieczeństwa oraz naruszenie zasad z art. 5, 25 i 32 RODO,
- **5 500 zł** za niezgłoszenie naruszenia organowi nadzorczemu (art. 33 ust. 1),
- **13 200 zł** za niezawiadomienie osób, których dane dotyczą (art. 34 ust. 1).

Łącznie **33 700 zł**. Dla gminnej jednostki to odczuwalna kwota, ale nie ona jest tu najważniejsza. Uderza proporcja: dwie z trzech kar wynikają nie z samego wycieku, lecz z tego, jak organizacja zachowała się po jego wykryciu. Gdyby ośrodek zgłosił naruszenie i zawiadomił mieszkańców, uniknąłby prawie 19 000 zł, czyli ponad połowy łącznej sankcji. O tym, jak w praktyce wygląda prawidłowe zgłaszanie naruszeń, pisałem szerzej przy okazji [poradnika UODO]({% post_url 2025-03-03-poradnik-uodo-naruszenia %}).

## Co organizacja powinna zrobić, zanim dojdzie do naruszenia

Najtańszy moment na uniknięcie takiej kary to moment, w którym nic złego jeszcze się nie stało. Poniższe działania nie wymagają dużego budżetu, a w opisanej sprawie w całości zmieniłyby jej przebieg.

1. **Trzymaj dane tam, gdzie masz nad nimi kontrolę.** Praca na prywatnym sprzęcie i w prywatnych chmurach pracowników powinna być jednoznacznie zakazana, a organizacja musi zapewnić wygodną alternatywę. Jeśli legalne narzędzie jest niewygodne, ludzie znajdą obejście.

2. **Zrób analizę ryzyka, która do czegoś prowadzi.** Ocena "ryzyko wysokie" bez konkretnych zabezpieczeń, terminów i osób odpowiedzialnych to strata czasu. Z analizy ma wynikać lista działań, a nie samo poczucie, że temat został odhaczony.

3. **Ogranicz zakres i czas przechowywania danych.** Arkusz z numerami telefonów, adresami i informacją o kwarantannie nie powinien istnieć w formie, którą łatwo skopiować w całości. Im mniej danych w jednym pliku i im krócej tam leżą, tym mniejsze skutki ewentualnego wycieku.

4. **Testuj zabezpieczenia i monitoruj dostępność danych.** Warto samodzielnie sprawdzać, czy zasoby nie są publicznie dostępne, na przykład przez okresowe skanowanie i kontrolę uprawnień. Lepiej, żeby otwarty katalog znalazł administrator niż wyszukiwarka.

5. **Ustal, kto jest administratorem, zanim zapyta o to UODO.** W procesach, w których uczestniczy kilka podmiotów, trzeba z góry rozstrzygnąć role i zapisać je w dokumentacji. Domysł, że "to pewnie inna instytucja odpowiada", nie jest podstawą prawną.

6. **Miej gotową procedurę na wypadek naruszenia.** Pracownik powinien wiedzieć, komu i jak szybko zgłosić incydent, a organizacja powinna umieć w ciągu 72 godzin ocenić ryzyko i podjąć decyzję o zgłoszeniu do UODO oraz zawiadomieniu osób. W tej sprawie właśnie brak tej rutyny kosztował najwięcej.

## Wnioski

Decyzja DKN.5131.27.2023 nie opowiada o wyrafinowanym ataku. Opowiada o zwykłych zaniedbaniach: plik na prywatnym serwerze, analiza ryzyka zrobiona dla formalności, brak kontroli nad tym, co jest dostępne w sieci, i milczenie po wykryciu problemu. Każdy z tych elementów da się wyeliminować bez wielkich nakładów.

Dla administratorów i inspektorów ochrony danych płynie z tego prosty przekaz. O wysokości kary często decyduje nie sam incydent, lecz reakcja na niego. Zgłoszenie naruszenia i uczciwe zawiadomienie osób to nie tylko obowiązek prawny, ale też najtańsza dostępna forma ograniczenia sankcji. W tej sprawie zabrakło jednego i drugiego.

## Najczęściej zadawane pytania

{% include post-faq.html %}

---

**Źródło:**

- Decyzja UODO DKN.5131.27.2023: [orzeczenia.uodo.gov.pl](https://orzeczenia.uodo.gov.pl/document/urn:ndoc:gov:pl:uodo:2023:dkn_5131_27/content)
