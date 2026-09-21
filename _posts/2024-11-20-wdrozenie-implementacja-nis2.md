---
title: 'Ustawa o KSC po wdrożeniu NIS2 - obowiązki podmiotu kluczowego i ważnego'
date: '2024-11-20T11:22:22.22Z'
categories:
  - Bezpieczeństwo
tags:
  - NIS2
  - KSC
  - Cyberbezpieczeństwo
  - Analiza ryzyka
  - Incydent bezpieczeństwa
  - Infrastruktura krytyczna
description: 'Dyrektywę NIS2 wdrożyła w Polsce nowelizacja ustawy o KSC (Dz.U. 2026 poz. 252). Kto jest podmiotem kluczowym, a kto ważnym, do kiedy trzeba złożyć wniosek o wpis do wykazu, jakie są terminy zgłoszenia incydentu do CSIRT i kto za to wszystko odpowiada.'
legal: true
faq:
  - question: "Czy dyrektywa NIS2 obowiązuje w Polsce bezpośrednio?"
    answer: "Nie. Dyrektywa wiąże państwo członkowskie co do celu, a obowiązki podmiotu wynikają z przepisów krajowych. W Polsce wdrożyła ją ustawa z 23 stycznia 2026 r. o zmianie ustawy o krajowym systemie cyberbezpieczeństwa oraz niektórych innych ustaw (Dz.U. 2026 poz. 252), obowiązująca od 3 kwietnia 2026 r. To do ustawy o KSC, a nie do dyrektywy, sięga się przy ustalaniu własnych obowiązków."
  - question: "Do kiedy trzeba złożyć wniosek o wpis do wykazu podmiotów kluczowych i ważnych?"
    answer: "Do 3 października 2026 r. Samorejestracja ruszyła 7 maja 2026 r., a wykaz jest aplikacją działającą w ramach Systemu S46. Obowiązek dotyczy podmiotów, które same ustaliły, że spełniają kryteria uznania za podmiot kluczowy albo ważny - ustawa nie przewiduje tu wezwania z urzędu."
  - question: "Jakie są terminy zgłoszenia incydentu do CSIRT?"
    answer: "Trzy, liczone od wykrycia incydentu poważnego: wczesne ostrzeżenie w ciągu 24 godzin, właściwe zgłoszenie w ciągu 72 godzin oraz sprawozdanie końcowe w ciągu miesiąca. Są niezależne od 72-godzinnego terminu zgłoszenia naruszenia ochrony danych osobowych do UODO; jedno zdarzenie może uruchomić oba tryby naraz."
  - question: "Czy pełnomocnik ds. cyberbezpieczeństwa jest funkcją wymaganą przez ustawę?"
    answer: "Nie. Ustawa nie przewiduje takiej funkcji; to przyjęta w praktyce nazwa roli koordynującej wykonywanie obowiązków. Art. 14 pozwala realizować zadania z zakresu cyberbezpieczeństwa przez wewnętrzne struktury albo na podstawie umowy z podmiotem zewnętrznym. Odpowiedzialność i tak pozostaje przy kierowniku podmiotu (art. 8c ust. 3)."
  - question: "Czy wdrożenie RODO wystarczy, żeby spełnić wymagania ustawy o KSC?"
    answer: "Nie, choć oba systemy mocno się pokrywają. RODO chroni osoby fizyczne w związku z przetwarzaniem ich danych, ustawa o KSC chroni ciągłość i bezpieczeństwo świadczonej usługi. Analiza ryzyka, zarządzanie dostępem, kopie zapasowe czy ocena dostawców robią robotę dla obu reżimów, ale zakres podmiotowy, terminy zgłoszeń i organy są różne."
---

> **W skrócie:** dyrektywy NIS2 nie stosuje się bezpośrednio. W Polsce wdrożyła ją nowelizacja ustawy o krajowym systemie cyberbezpieczeństwa (Dz.U. 2026 poz. 252), obowiązująca od 3 kwietnia 2026 r. Jeżeli organizacja działa w objętym ustawą sektorze i spełnia kryteria podmiotu kluczowego albo ważnego, sama ustala swój status i składa wniosek o wpis do wykazu **do 3 października 2026 r.** Incydent poważny zgłasza się do właściwego CSIRT w trzech krokach: 24 godziny, 72 godziny, miesiąc. Odpowiedzialność za całość spoczywa na kierowniku podmiotu i nie da się jej scedować umową.
{: .prompt-info }

Wpis powstał w listopadzie 2024 r., gdy obowiązywała sama dyrektywa, a Polska nie miała jeszcze przepisów wdrażających. Został napisany na nowo we wrześniu 2026 r. na podstawie ustawy w brzmieniu obowiązującym.

Podstawa prawna: [ustawa z 5 lipca 2018 r. o krajowym systemie cyberbezpieczeństwa](https://eli.gov.pl/eli/DU/2018/1560/ogl) w brzmieniu nadanym [ustawą z 23 stycznia 2026 r.](https://eli.gov.pl/eli/DU/2026/252/ogl) (Dz.U. 2026 poz. 252, ogłoszona 2 marca 2026 r., obowiązująca od 3 kwietnia 2026 r.), która wdraża [dyrektywę (UE) 2022/2555](https://eur-lex.europa.eu/eli/dir/2022/2555/oj).

## Czy ustawa w ogóle dotyczy mojej organizacji?

To pierwsze pytanie i jedyne, od którego można zacząć. Ustawa posługuje się dwiema kategoriami: **podmiot kluczowy** i **podmiot ważny**. O przypisaniu decyduje sektor, w którym organizacja działa, rodzaj świadczonej usługi oraz wielkość mierzona liczbą zatrudnionych i danymi finansowymi.

Dwie rzeczy zaskakują najczęściej.

Po pierwsze, zakres podmiotowy jest znacznie szerszy niż w poprzednim stanie prawnym. Obok energetyki, transportu czy ochrony zdrowia znalazły się w nim między innymi gospodarka odpadami, produkcja, usługi pocztowe i kurierskie, a także znaczna część administracji publicznej i spółek komunalnych. Organizacja, która nigdy nie uważała się za część „infrastruktury krytycznej", może dziś być podmiotem ważnym.

Po drugie, nikt tego statusu nie nadaje z urzędu. Ustalenie własnej kwalifikacji jest obowiązkiem podmiotu, a wynik tego ustalenia trzeba udokumentować także wtedy, gdy wychodzi negatywny. Notatka z uzasadnieniem, dlaczego organizacja nie spełnia kryteriów, jest tanim zabezpieczeniem na wypadek pytania organu.

## Do kiedy trzeba się wpisać do wykazu?

Wykaz podmiotów kluczowych i podmiotów ważnych działa jako aplikacja w ramach Systemu S46. Samorejestracja ruszyła **7 maja 2026 r.**, a termin złożenia wniosku upływa **3 października 2026 r.** Szczegóły procedury opisuje Ministerstwo Cyfryzacji w komunikacie o [uruchomieniu samorejestracji w wykazie](https://samorzad.gov.pl/web/gov/nowelizacja-ustawy-o-krajowym-systemie-cyberbezpieczenstwa-ksc---uruchamiamy-samorejestracje-w-wykazie-podmiotow-kluczowych-i-podmiotow-waznych-sprawdz-jak-dokonac-wpisu).

Przy wpisie podaje się też osoby do kontaktu. Warto potraktować to poważnie: to na ten adres przyjdzie korespondencja od organu właściwego i to ta osoba będzie w praktyce uruchamiać procedurę zgłoszenia incydentu.

## Co trzeba mieć wdrożone?

Ustawa nie wylicza konkretnych produktów ani technologii. Wymaga systemu zarządzania bezpieczeństwem informacji, w którym środki są dobrane do ryzyka i regularnie sprawdzane. W praktyce sprowadza się to do kilku elementów, które muszą istnieć w dokumentacji i w rzeczywistości jednocześnie.

Inwentaryzacja aktywów oraz mapa świadczonej usługi. Bez wiedzy, co składa się na usługę i od czego zależy jej ciągłość, analiza ryzyka jest zgadywaniem.

Metodyka i przeprowadzona analiza ryzyka wraz z planem postępowania z ryzykiem. To ten sam mechanizm, którego brak UODO wytyka administratorom w decyzjach na gruncie RODO, na przykład w [sprawie niezaszyfrowanego laptopa]({% post_url 2024-11-13-decyzja-uodo %}).

Polityki i procedury, które opisują to, co organizacja faktycznie robi. Dokument opisujący stan pożądany, a nie rzeczywisty, jest gorszy od jego braku, bo tworzy pozór zgodności.

Bezpieczeństwo łańcucha dostaw: ocena dostawców ICT i odpowiednie zapisy umowne. Tu ustawa i RODO spotykają się najwyraźniej, bo ten sam dostawca bywa jednocześnie podmiotem przetwarzającym dane osobowe.

Plany ciągłości działania i odtwarzania, wraz z testami odtworzenia kopii zapasowych. Kopia, której nigdy nie odtwarzano, jest założeniem, nie zabezpieczeniem.

Szkolenia dla pracowników oraz wymagane ustawą coroczne szkolenie kierownika podmiotu (art. 8e).

## Jak zgłasza się incydent?

Zgłoszenie incydentu poważnego do właściwego CSIRT przebiega w trzech krokach.

| Krok | Termin od wykrycia | Co zawiera |
|---|---|---|
| Wczesne ostrzeżenie | 24 godziny | Sygnał, że incydent wystąpił, wraz z wstępną oceną charakteru |
| Zgłoszenie | 72 godziny | Ocena incydentu, wskaźniki, dotychczasowe działania |
| Sprawozdanie końcowe | miesiąc | Opis przebiegu, przyczyna źródłowa, zastosowane środki |

Ten zegar biegnie niezależnie od terminów z RODO. Jeżeli incydent objął dane osobowe, administrator ma równolegle 72 godziny od stwierdzenia naruszenia na zgłoszenie do UODO oraz obowiązek zawiadomienia osób przy wysokim ryzyku. Rozpisałem to w [przewodniku po obowiązkach przy naruszeniu ochrony danych]({% post_url 2026-09-21-naruszenie-ochrony-danych-przewodnik %}).

Praktycznie oznacza to jedną procedurę z dwiema ścieżkami i jedną osobą, która pilnuje obu zegarów. Rozdzielenie tego na „sprawę IT" i „sprawę IOD" kończy się tym, że jeden z terminów przepada. Jak taki incydent wygląda w spółce komunalnej, opisywałem na przykładzie [ataku na MPK Kraków]({% post_url 2024-12-06-atak-mpk-krakow %}).

Osobne pytanie, które pojawia się kilka dni później, to co wolno ujawnić mediom i wnioskodawcom. Odpowiada na nie art. 37 ust. 1 ustawy o KSC; rozwijam to w [poradniku o udostępnianiu informacji po incydencie]({% post_url 2025-10-21-udostepnianie-informacji %}).

## Kto za to odpowiada?

Kierownik podmiotu. Art. 8c ust. 3 ustawy przesądza, że odpowiedzialność za wykonywanie obowiązków spoczywa na nim również wtedy, gdy ich realizację powierzono innej osobie lub podmiotowi zewnętrznemu.

Art. 14 pozwala realizować zadania z zakresu cyberbezpieczeństwa albo przez wewnętrzne struktury, albo na podstawie umowy z podmiotem zewnętrznym. Stąd wzięła się praktyczna nazwa „pełnomocnik ds. cyberbezpieczeństwa", która w ustawie nie występuje. Rola jest realna, ale polega na koordynacji i doradztwie, a nie na przejęciu odpowiedzialności. Opisałem jej zakres na stronie [O mnie](/about "O mnie - IOD i pełnomocnik ds. cyberbezpieczeństwa").

Warto to powiedzieć wprost przy podpisywaniu umowy, bo oczekiwanie bywa odwrotne. Zarząd, który kupuje usługę, czasem słyszy, że „firma zewnętrzna bierze to na siebie". Ustawa mówi co innego i to zarząd poniesie konsekwencje.

## Czym to się różni od RODO?

Oba reżimy wymagają analizy ryzyka, adekwatnych zabezpieczeń, zarządzania dostępem, kopii zapasowych i oceny dostawców. Różni je to, co chronią i przed kim odpowiadają.

| | RODO | Ustawa o KSC |
|---|---|---|
| Przedmiot ochrony | Prawa i wolności osób fizycznych | Ciągłość i bezpieczeństwo świadczonej usługi |
| Kto ma obowiązki | Administrator i podmiot przetwarzający | Podmiot kluczowy albo ważny |
| Organ | Prezes UODO | Organ właściwy i CSIRT |
| Pierwszy termin zgłoszenia | 72 h od stwierdzenia naruszenia | 24 h od wykrycia incydentu |
| Kogo się zawiadamia | Osoby, których dane dotyczą, przy wysokim ryzyku | Odbiorców usługi, gdy incydent na nich wpływa |

Dobrze zaprojektowany system zarządzania bezpieczeństwem informacji obsługuje oba naraz. Zły obsługuje jeden i generuje drugą, równoległą dokumentację, której nikt nie czyta.

## Od czego zacząć?

1. Ustal i zapisz, czy organizacja jest podmiotem kluczowym, ważnym, czy żadnym z nich. Uzasadnienie zachowaj także przy wyniku negatywnym.
2. Jeżeli podlegasz ustawie, złóż wniosek o wpis do wykazu w terminie do 3 października 2026 r. i wyznacz realne osoby kontaktowe.
3. Zrób analizę luk: co z wymagań ustawy już masz, co masz tylko na papierze, czego nie masz wcale.
4. Ustal harmonogram dojścia do zgodności z przypisaną odpowiedzialnością i terminami, zatwierdzony przez kierownika podmiotu.
5. Napisz jedną procedurę obsługi incydentu z dwiema ścieżkami zgłoszeniowymi, do CSIRT i do UODO, i przetestuj ją na ćwiczeniu.
6. Przejrzyj umowy z dostawcami ICT pod kątem zgłaszania incydentów i podpowierzeń.
7. Zaplanuj coroczne szkolenie kierownika podmiotu i szkolenia z cyberhigieny dla pracowników.

Najtrudniejszy jest punkt pierwszy, bo wymaga decyzji, a nie zakupu. Reszta to praca, którą da się rozłożyć na miesiące.

## Najczęściej zadawane pytania

{% include post-faq.html %}
