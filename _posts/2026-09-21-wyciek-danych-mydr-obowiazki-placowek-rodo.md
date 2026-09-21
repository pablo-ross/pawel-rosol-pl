---
title: "Wyciek danych z MyDr - co on oznacza dla przychodni, lekarzy i pacjentów"
date: 2026-09-21T10:00:00.00Z
categories:
  - Bezpieczeństwo
tags:
  - Naruszenie ochrony danych
  - Zgłoszenie naruszenia
  - Powierzenie przetwarzania
  - Administrator danych
  - Dane szczególnej kategorii
  - Analiza ryzyka
  - Cyberbezpieczeństwo
  - RODO
description: "Wyciek z systemu MyDr objął dane nawet 18,8 mln osób i ponad 12 tysięcy placówek. Kto odpowiada za naruszenie, jakie obowiązki ma przychodnia i czym to grozi w świetle RODO."
legal: true
faq:
  - question: "Kto odpowiada za wyciek danych z systemu MyDr - dostawca czy przychodnia?"
    answer: "Administratorem danych pacjenta jest placówka medyczna albo lekarz prowadzący praktykę, a MyDr jest podmiotem przetwarzającym, któremu powierzono dane. To administrator zgłasza naruszenie do UODO, zawiadamia pacjentów i odpowiada wobec nich za skutki. Powierzenie przetwarzania nie przenosi odpowiedzialności na dostawcę oprogramowania, choć procesor odpowiada za własne uchybienia z art. 32 RODO i może zostać ukarany osobno."
  - question: "Jaki jest termin na zgłoszenie naruszenia po informacji od dostawcy?"
    answer: "72 godziny od stwierdzenia naruszenia, czyli od momentu, w którym administrator z rozsądną dozą pewności wie, że incydent objął jego dane. UODO wskazał, że placówka powinna najpierw uzyskać od MyDr potwierdzenie, że wyciek dotyczył jej zbioru, a następnie przeprowadzić własną ocenę ryzyka. Jeśli pełnych informacji nie ma, art. 33 ust. 4 RODO pozwala zgłosić naruszenie etapami i uzupełnić je później."
  - question: "Czy przychodnia może wymagać osobistej wizyty, żeby przekazać informacje o naruszeniu?"
    answer: "Nie. Art. 34 RODO wymaga zawiadomienia jasnego, prostego i łatwo dostępnego, a art. 12 nakazuje przekazać je w zwięzłej i przejrzystej formie. Uzależnienie podstawowych informacji o naruszeniu od przyjazdu do placówki utrudnia realizację tego obowiązku, zwłaszcza wobec pacjentów, którzy dawno zmienili miejsce zamieszkania. Tożsamość można zweryfikować zdalnie."
  - question: "Czy pacjent może żądać odszkodowania za wyciek danych medycznych?"
    answer: "Tak, na podstawie art. 82 RODO. Trzeba wykazać naruszenie przepisów, szkodę majątkową lub niemajątkową oraz związek przyczynowy między nimi. TSUE w sprawie C-340/21 uznał, że sama obawa przed niewłaściwym wykorzystaniem danych może być szkodą niemajątkową, ale musi zostać udowodniona. Polskie sądy zasądzają zwykle kwoty rzędu kilku tysięcy złotych."
  - question: "Co powinien zrobić pacjent, którego dane wyciekły z MyDr?"
    answer: "Zastrzec numer PESEL w aplikacji mObywatel lub w urzędzie, sprawdzić swój status na bezpiecznedane.gov.pl, zachować ostrożność wobec SMS-ów i e-maili nawiązujących do leczenia oraz wystąpić do placówki z pytaniem o zakres naruszenia. Lekarze korzystający z systemu powinni dodatkowo unieważnić i wygenerować na nowo certyfikaty używane do wystawiania e-recept."
---

**Wyciek danych z systemu MyDr to najpoważniejsze naruszenie ochrony danych w polskiej ochronie zdrowia i prawdopodobnie największy wyciek danych osobowych w historii Polski. Objął dane nawet 18,8 mln osób i ponad 12 tysięcy podmiotów leczniczych. Najciekawsze jest to, co dzieje się dalej: ciężar prawny incydentu spadł nie na dostawcę oprogramowania, lecz na tysiące przychodni i indywidualnych praktyk lekarskich, które w większości nie były przygotowane na taką sytuację.**

## Co się wydarzyło?

MyDr to jeden z największych polskich dostawców systemów gabinetowych i elektronicznej dokumentacji medycznej. Przez jego oprogramowanie przechodzi obsługa wizyt, recept, skierowań i rejestracji w tysiącach placówek.

Pierwszy opisał sprawę serwis [Zaufana Trzecia Strona](https://zaufanatrzeciastrona.pl/post/hakerzy-twierdza-ze-ukradli-dane-ponad-18-milionow-polek-i-polakow-z-firmy-mydr/), który dotarł do sprawców i zweryfikował część ich twierdzeń. Atakujący deklarowali 2,5 TB danych i 18 814 422 unikalne numery PESEL. Opisali też drogę ataku: podatność XXE w obsłudze certyfikatów PKCS#12, zdalne wykonanie kodu, przejęcie kluczy API do GitHuba, dostęp do kodu źródłowego, a następnie do infrastruktury w AWS. Redakcja sprawdziła próbkę i znalazła poprawne numery PESEL osób publicznych, prawidłowe oddziały NFZ oraz działające numery telefonów. Spośród czterech testowanych osób rekordy dotyczyły trzech.

12 sierpnia 2026 roku sprawą zajęło się [Połączone Centrum Operacyjne Cyberbezpieczeństwa](https://www.gov.pl/web/cyfryzacja/komunikat-po-spotkaniu-polaczonego-centrum-operacyjnego-cyberbezpieczenstwa). Spółka potwierdziła nieuprawniony dostęp do danych historycznych, zgromadzonych do kwietnia 2024 roku. Skala: około 18,8 mln osób i ponad 12 tysięcy podmiotów leczniczych. Zakres danych obejmował imiona i nazwiska, numery PESEL, adresy e-mail, numery telefonów, a także e-zwolnienia, e-skierowania i opisy wizyt lekarskich. Sprawą zajęło się Centralne Biuro Zwalczania Cyberprzestępczości pod nadzorem prokuratury okręgowej w Warszawie. Do włamania doszło najpóźniej 6 sierpnia 2026 roku.

Dzień później Prezes UODO ogłosił [kontrolę w spółce MyDr](https://uodo.gov.pl/pl/138/4540). Kontrolerzy sprawdzają środki techniczne i organizacyjne, regularność testowania zabezpieczeń wobec zmieniających się zagrożeń oraz to, czy analiza ryzyka uwzględniała realne zagrożenia dla przetwarzanych danych.

## Kto tu właściwie jest administratorem?

To jest sedno całej sprawy i źródło większości nieporozumień.

Administratorem danych pacjenta jest podmiot leczniczy: przychodnia, szpital, gabinet, lekarz prowadzący praktykę. MyDr jest podmiotem przetwarzającym, czyli procesorem, któremu te dane powierzono na podstawie umowy z art. 28 RODO. Z punktu widzenia RODO nic się nie zmienia przez to, że dane fizycznie leżą w chmurze dostawcy. Obowiązki z art. 33 i 34 RODO ciążą na administratorze.

Konsekwencje tego układu są dwie i obie są niewygodne.

Pierwsza dotyczy placówek. To one muszą zgłosić naruszenie, zawiadomić pacjentów i odpowiadać na ich pytania, choć nie mają dostępu do infrastruktury, w której doszło do włamania, i często nie wiedzą, jakie dokładnie rekordy wypłynęły. UODO w [komunikacie z 12 sierpnia](https://uodo.gov.pl/pl/138/4538) przypomniał, że administrator powinien uzyskać od procesora pisemne potwierdzenie, że naruszenie objęło jego dane, a potem samodzielnie ocenić ryzyko.

Druga dotyczy pacjentów. MyDr, jako procesor, nie ma podstawy prawnej, żeby przekazać dane ofiar do NASK i serwisu bezpiecznedane.gov.pl. Zaufana Trzecia Strona zwróciła uwagę, że przez pierwsze dni po ujawnieniu wycieku nikt nie mógł sprawdzić, czy jego dane wypłynęły. Sytuacja, w której konstrukcja ról z RODO utrudnia poinformowanie ofiar o naruszeniu ich danych, jest dla mnie jednym z najbardziej gorzkich wniosków z tej sprawy.

## Obowiązki placówki krok po kroku

Jeśli prowadzisz placówkę korzystającą z MyDr albo jesteś w niej IOD, kolejność działań wygląda tak:

1. **Ustal fakty.** Sprawdź, czy i w jakim okresie placówka korzystała z systemu, jakie moduły i jaki zakres danych powierzono. Wystąp do MyDr o pisemne potwierdzenie, czy naruszenie objęło Twój zbiór, i o informacje, które są Ci potrzebne do oceny ryzyka. Art. 28 ust. 3 lit. f RODO daje Ci do tego podstawę umowną.
2. **Przeprowadź własną ocenę ryzyka.** Dane o stanie zdrowia to dane szczególnej kategorii z art. 9 RODO. Przy połączeniu PESEL, danych kontaktowych i informacji o leczeniu ryzyko dla praw i wolności będzie w praktyce wysokie.
3. **Zgłoś naruszenie do UODO w 72 godziny** od stwierdzenia naruszenia. Jeśli nie masz pełnych informacji, skorzystaj z art. 33 ust. 4 RODO i zgłoś naruszenie etapami, uzupełniając je w miarę ustaleń. Pisałem o tym szerzej przy okazji [poradnika UODO o naruszeniach]({% post_url 2025-03-03-poradnik-uodo-naruszenia %}).
4. **Zawiadom pacjentów** na podstawie art. 34 RODO. Zawiadomienie ma opisywać charakter naruszenia, możliwe konsekwencje, środki zaradcze i dane kontaktowe IOD.
5. **Udokumentuj wszystko** w rejestrze naruszeń z art. 33 ust. 5, łącznie z uzasadnieniem decyzji o zgłoszeniu lub jego braku.

Przy punkcie czwartym pojawił się już praktyczny spór. Część placówek ograniczyła zawiadomienie do krótkiego SMS-a, a szczegóły obiecała przekazać dopiero podczas osobistej wizyty. Serwis Prawo.pl opisał [przypadek pacjenta mieszkającego kilkaset kilometrów od dawnej przychodni](https://www.prawo.pl/zdrowie/czy-przychodnia-moze-uzaleznic-uzyskanie-danych-od-wizyty-w-placowce-po-wycieku-mydr,1552520.html). Art. 12 RODO wymaga formy zwięzłej, przejrzystej i łatwo dostępnej, a tożsamość da się zweryfikować zdalnie. Wymaganie fizycznej wizyty trudno pogodzić z celem tego przepisu.

## Dlaczego „to wina dostawcy" nie jest linią obrony?

Najczęstsza reakcja placówek brzmi: przecież włamano się do MyDr, nie do nas. To prawda faktyczna, która nie przekłada się na zwolnienie z odpowiedzialności.

Art. 24 [RODO](https://eur-lex.europa.eu/eli/reg/2016/679/oj) nakłada na administratora obowiązek wdrożenia odpowiednich środków i wykazania zgodności. Art. 28 ust. 1 pozwala korzystać wyłącznie z takich procesorów, którzy dają wystarczające gwarancje bezpieczeństwa. Jak organ rozumie „wystarczające gwarancje" i czego oczekuje od nadzoru nad powierzeniem, najlepiej widać w [decyzji wobec McDonald's Polska]({% post_url 2025-07-28-kara-mcdonalds %}) - kanonicznej polskiej sprawie o odpowiedzialność za wybór i kontrolę procesora. Jeśli placówka podpisała umowę powierzenia, nigdy nie zweryfikowała dostawcy, nie miała w umowie zapisów o zgłaszaniu incydentów i nie uwzględniła tego ryzyka w analizie, to ma własne zaniedbanie, niezależne od cudzego włamania.

Kierunek orzecznictwa też nie sprzyja administratorom. W wyroku z 14 grudnia 2023 roku w sprawie C-340/21 TSUE stwierdził, że sam fakt ataku hakerskiego nie zwalnia administratora z odpowiedzialności, a to na nim spoczywa ciężar wykazania, że zastosowane środki były odpowiednie. Trybunał uznał też, że obawa przed niewłaściwym wykorzystaniem danych może stanowić szkodę niemajątkową, jeśli zostanie wykazana.

Proporcje kar widać po wcześniejszych decyzjach UODO. W sprawie Fortum administrator zapłacił blisko 5 mln zł, a podmiot przetwarzający 250 tys. zł, choć naruszenie dotyczyło około 90 tysięcy osób. Przy MyDr mówimy o skali dwieście razy większej, tyle że rozproszonej na tysiące administratorów.

Mechanizm, który się tu powtarza, opisywałem już w kontekście [decyzji wobec ośrodka pomocy społecznej]({% post_url 2026-07-07-decyzja-uodo-ops-dane-o-kwarantannie %}) i [kary dla McDonald's]({% post_url 2025-07-28-kara-mcdonalds %}). Analiza ryzyka istniejąca wyłącznie na papierze jest dla UODO okolicznością obciążającą, a nie dowodem staranności.

## Możliwe konsekwencje

**Kontrole sektorowe.** UODO zmienił plan kontroli na 2026 rok. Jak podało [Prawo.pl](https://www.prawo.pl/zdrowie/kontrole-w-ochronie-zdrowia-uodo-reaguje-na-wyciek-z-mydr,1552913.html), Prezes Mirosław Wróblewski zapowiedział dodatkowe, zaostrzone kontrole w kolejnych podmiotach ochrony zdrowia jeszcze przed końcem roku. Zaplanowane wcześniej kontrole platform zakupowych przesunięto na 2027 rok. Kontrola może więc trafić do placówki, która nawet nie korzystała z MyDr.

**Kary administracyjne.** Naruszenie art. 32 RODO zagrożone jest karą do 10 mln euro lub 2% obrotu, a naruszenie zasad z art. 5 i praw osób do 20 mln euro lub 4%. Dla małej praktyki realne kwoty będą rzędu kilkunastu czy kilkudziesięciu tysięcy złotych, co i tak bywa dotkliwe. Osobną podstawą kary jest samo niezgłoszenie naruszenia albo niezawiadomienie pacjentów, co UODO regularnie karze niezależnie od kary za brak zabezpieczeń.

**Roszczenia pacjentów.** Art. 82 RODO daje prawo do odszkodowania. Pojedyncze wyroki opiewają zwykle na kilka tysięcy złotych, ale przy pozwach grupowych suma robi się poważna. Kancelarie już zbierają zgłoszenia.

**Skutki dla pacjentów.** Połączenie numeru PESEL z danymi kontaktowymi i informacją o leczeniu jest materiałem na phishing dużo skuteczniejszy niż zwykły. Wiadomość odwołująca się do konkretnego skierowania albo leku wygląda wiarygodnie. Do tego dochodzi ryzyko kredytów na cudze dane oraz osobna kategoria szkód związana z ujawnieniem diagnoz: leczenia psychiatrycznego, uzależnień, chorób przewlekłych czy zdrowia reprodukcyjnego. Tych danych nie da się zmienić jak hasła.

**Skutki dla lekarzy.** Zaufana Trzecia Strona zaleciła lekarzom korzystającym z MyDr unieważnienie i wygenerowanie na nowo certyfikatów używanych do wystawiania e-recept. To zalecenie warto potraktować poważnie, bo przejęcie takiego certyfikatu otwiera drogę do wystawiania recept na leki kontrolowane w czyimś imieniu.

## Co zrobić teraz jako IOD?

Lista minimum dla placówki, która korzystała z systemu:

- Zweryfikuj umowę powierzenia: czy jest, czy zawiera obowiązek zgłaszania incydentów, w jakim terminie, czy dopuszcza podpowierzenia i czy wiesz, komu. Brak zawartej umowy podpowierzenia był jednym z zarzutów wobec procesora w [sprawie McDonald's]({% post_url 2025-07-28-kara-mcdonalds %}).
- Sprawdź, gdzie fizycznie są dane. W sprawie MyDr pojawił się wątek korzystania z infrastruktury chmurowej dostawców spoza EOG, co oznacza osobne pytanie o rozdział V RODO.
- Zaktualizuj analizę ryzyka i ocenę skutków. Scenariusz „kompromitacja systemu dostawcy" powinien się w niej pojawić z realnym prawdopodobieństwem, a nie jako teoretyczna możliwość.
- Przygotuj gotowy szablon zawiadomienia pacjentów i kanał zdalnej weryfikacji tożsamości, zanim będzie potrzebny.
- Sprawdź, czy placówka ma retencję danych zgodną z ustawą o prawach pacjenta. Część wycieku stanowią dane historyczne, więc pytanie, dlaczego wciąż były w systemie, jest zasadne.
- Przy kolejnym przetargu na system gabinetowy zażądaj wykazania zabezpieczeń, wyników testów i procedury notyfikacji. To jedyny moment, w którym administrator ma realną siłę negocjacyjną.

## Co może zrobić pacjent?

UODO w komunikacie [„Wyciek danych - co dalej?"](https://uodo.gov.pl/pl/138/4539) zalecił zastrzeżenie numeru PESEL i zwiększoną ostrożność wobec wiadomości przychodzących SMS-em i e-mailem. Do tego dochodzi sprawdzenie swojego numeru w serwisie bezpiecznedane.gov.pl po zalogowaniu Profilem Zaufanym lub przez mObywatel, a także wystąpienie do placówki z żądaniem informacji o zakresie naruszenia. Jeśli placówka nie odpowiada albo odsyła do osobistej wizyty, zostaje skarga do Prezesa UODO.

Zastrzeżenie PESEL blokuje zaciągnięcie kredytu i zawarcie części umów na cudze dane. Nie pomoże natomiast wobec danych o stanie zdrowia, bo tu żadnego mechanizmu odwracającego skutki wycieku po prostu nie ma.

## Moje trzy grosze jako IOD

Ta sprawa dobrze pokazuje, jak wygląda ryzyko koncentracji. Tysiące administratorów kupiło ten sam system, bo był dobry i powszechny, i tym samym zbudowało jeden punkt awarii dla dziewiętnastu milionów kartotek. Żadna pojedyncza przychodnia nie miała możliwości zaudytowania dostawcy o takiej skali, a mimo to każda z osobna odpowiada teraz za skutki.

Trochę uwiera mnie asymetria między odpowiedzialnością a wpływem. Placówka ma obowiązek „wystarczających gwarancji" z art. 28 ust. 1, ale w praktyce dostaje umowę powierzenia do podpisania bez możliwości negocjacji jednego przecinka. Formalnie to jej wybór, faktycznie wybór jest między tym systemem a pracą na papierze. Nie mam na to dobrej odpowiedzi. Wiem tylko, że tłumaczenie „nie mieliśmy wyjścia" nie przekonuje organu nadzorczego i nie powinno przekonywać nas samych, skoro alternatywą jest przynajmniej udokumentowana próba weryfikacji dostawcy.

Druga rzecz to obowiązek zawiadomienia. Kilkanaście tysięcy podmiotów zawiadamia niezależnie, w różnym czasie, różnymi kanałami i z różną jakością treści. Pacjent, który przez lata zmieniał przychodnie, dostaje sprzeczne komunikaty albo żadnego. Rozwiązanie systemowe wymagałoby albo zmiany przepisów, albo wcześniejszego wpisania do umów powierzenia obowiązku prowadzenia notyfikacji przez procesora w imieniu administratorów. Drugie da się zrobić już dziś, przy najbliższej aktualizacji umowy.

Na koniec rzecz najmniej wygodna. Wyciek objął dane historyczne, zgromadzone do kwietnia 2024 roku. Pytanie, ile z tych rekordów musiało w ogóle pozostawać w systemie gabinetowym w sierpniu 2026, nie pojawiło się jeszcze w żadnym komunikacie, a jest to pytanie o zasadę minimalizacji i o retencję. Podejrzewam, że wróci przy okazji pierwszych decyzji UODO.

## Najczęściej zadawane pytania

{% include post-faq.html %}

*Jeśli prowadzisz placówkę i mierzysz się z tą sprawą, a coś w powyższym opisie wygląda inaczej niż w Twojej praktyce, napisz do mnie. Sprawa jest rozwojowa i wpis będę aktualizował.*
