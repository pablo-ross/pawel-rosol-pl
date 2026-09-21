---
title: 'Ustawa o KSC w przedsiębiorstwie wodociągowo-kanalizacyjnym - obowiązki, terminy i wnioski z ataków na OT'
date: '2024-11-20T11:22:22.22Z'
categories:
  - Bezpieczeństwo
tags:
  - KSC
  - NIS2
  - Cyberbezpieczeństwo
  - Wodociągi
  - Analiza ryzyka
  - Incydent bezpieczeństwa
  - Infrastruktura krytyczna
description: 'Po serii ataków na stacje uzdatniania wody i oczyszczalnie ścieków Pełnomocnik Rządu ds. Cyberbezpieczeństwa zalecił odseparowanie systemów OT od internetu. Co z ustawy o KSC wynika dla spółki wod-kan: wykaz i terminy, reżim z art. 8 ust. 1 albo z załącznika nr 4, trzy oceny ryzyka, łańcuch zgłoszeń do CSIRT sektorowego i kto za to odpowiada.'
legal: true
faq:
  - question: "Czy przedsiębiorstwo wodociągowo-kanalizacyjne podlega ustawie o KSC?"
    answer: "Sektor zaopatrzenia w wodę pitną i jej dystrybucji oraz sektor ścieków są objęte ustawą, ale samo działanie w sektorze nie przesądza sprawy. O statusie podmiotu kluczowego albo ważnego decydują dodatkowo rodzaj świadczonej usługi oraz wielkość podmiotu. Kwalifikację przeprowadza i dokumentuje sam podmiot; nikt nie nadaje tego statusu z urzędu."
  - question: "Do kiedy trzeba złożyć wniosek o wpis do wykazu podmiotów kluczowych i ważnych?"
    answer: "Art. 7c ust. 1 uksc daje 6 miesięcy od dnia spełnienia przesłanek uznania za podmiot kluczowy lub ważny. Dla podmiotów, które spełniały je już w dniu wejścia w życie nowelizacji, termin ten upływa 3 października 2026 r. Samorejestracja ruszyła 7 maja 2026 r., a wykaz jest aplikacją w ramach Systemu S46. Umowę z dostawcą usług zarządzanych w zakresie cyberbezpieczeństwa ujawnia się w wykazie wraz z danymi dostawcy (art. 7 ust. 2 pkt 16 uksc), a zmianę danych zgłasza w terminie 14 dni (art. 7c ust. 3 uksc)."
  - question: "Czy rekomendacje Pełnomocnika Rządu ds. Cyberbezpieczeństwa są obowiązkowe?"
    answer: "Nie, zostały wydane jako zalecenie, a nie akt prawa powszechnie obowiązującego. W praktyce i tak trudno je pominąć: ustawa o KSC wymaga środków adekwatnych do ryzyka, a od sierpnia 2026 r. istnieje publiczny, sektorowy dokument opisujący to ryzyko i sposób jego ograniczenia. Odstępstwo od zalecenia wymaga uzasadnienia w analizie ryzyka, a nie przemilczenia."
  - question: "Ile ocen ryzyka musi mieć przedsiębiorstwo wodociągowo-kanalizacyjne?"
    answer: "Trzy, z dwóch różnych ustaw. Ustawa o KSC wymaga systematycznego szacowania ryzyka wystąpienia incydentu w systemie informacyjnym wspierającym usługę (art. 8 ust. 1 pkt 1 uksc). Art. 4e ust. 1 ustawy o zbiorowym zaopatrzeniu w wodę nakłada dwie odrębne oceny: ryzyka w obszarze zasilania ujęcia wody oraz ryzyka w systemie zaopatrzenia w wodę, przeglądane w odstępach wynikających z tych ocen, nie dłuższych niż 6 lat. To trzy odrębne dokumenty, które powinny znać wspólne scenariusze."
  - question: "Jakie są terminy zgłoszenia incydentu poważnego do CSIRT?"
    answer: "Do właściwego CSIRT sektorowego: wczesne ostrzeżenie nie później niż w ciągu 24 godzin od wykrycia (art. 11 ust. 1 pkt 4 uksc), zgłoszenie incydentu poważnego nie później niż w ciągu 72 godzin od wykrycia (pkt 4a), sprawozdanie okresowe na wniosek CSIRT (pkt 4b) oraz sprawozdanie końcowe nie później niż w ciągu miesiąca od dnia zgłoszenia, a nie od wykrycia (pkt 4c). Podmiot ważny będący podmiotem publicznym składa samo zgłoszenie: art. 12c uksc wyłącza wobec niego wczesne ostrzeżenie i sprawozdania. Terminy te biegną niezależnie od 72-godzinnego terminu zgłoszenia naruszenia ochrony danych osobowych do UODO."
  - question: "Czy można zlecić obowiązki z ustawy o KSC firmie zewnętrznej?"
    answer: "Zadania można realizować przez wewnętrzne struktury albo na podstawie umowy z podmiotem zewnętrznym (art. 14 uksc). Odpowiedzialność za ich wykonanie pozostaje przy kierowniku podmiotu również wtedy, gdy obowiązki powierzono innej osobie (art. 8c ust. 3 uksc). Umowa przenosi pracę, nie odpowiedzialność."
---

> **W skrócie:** w 2025 r. doszło do serii ataków na stacje uzdatniania wody i oczyszczalnie ścieków w Polsce, a NIK w sierpniu 2026 r. ocenił dotychczasowe zabezpieczenia operatorów jako niewystarczające. Pełnomocnik Rządu ds. Cyberbezpieczeństwa zalecił sektorowi wod-kan przede wszystkim odseparowanie urządzeń OT od internetu. Zalecenia nie są wiążące, ale ustawa o KSC wymaga środków adekwatnych do ryzyka, więc od ich publikacji milczenie w analizie ryzyka przestało być bezpieczną opcją. Jeżeli spółka jest podmiotem kluczowym albo ważnym, a przesłanki spełniała już w dniu wejścia w życie nowelizacji, wniosek o wpis do wykazu składa się **do 3 października 2026 r.**
{: .prompt-info }

Wpis powstał w listopadzie 2024 r. i dotyczył samej dyrektywy NIS2. Napisałem go na nowo we wrześniu 2026 r., po wdrożeniu dyrektywy do prawa polskiego i po serii ataków na infrastrukturę wodociągową, zawężając temat do sektora, w którym te dwa wątki spotykają się najostrzej.

Podstawa prawna: [ustawa z 5 lipca 2018 r. o krajowym systemie cyberbezpieczeństwa](https://eli.gov.pl/eli/DU/2018/1560/ogl) (dalej „uksc"; tekst jednolity ogłoszony [obwieszczeniem Marszałka Sejmu z 29 grudnia 2025 r.](https://eli.gov.pl/eli/DU/2026/20/ogl), Dz.U. 2026 poz. 20, ze zmianami), znowelizowana [ustawą z 23 stycznia 2026 r.](https://eli.gov.pl/eli/DU/2026/252/ogl) (Dz.U. 2026 poz. 252, obowiązującą od 3 kwietnia 2026 r.), która wdraża [dyrektywę (UE) 2022/2555](https://eur-lex.europa.eu/eli/dir/2022/2555/oj).

## Co się wydarzyło w wodociągach?

W 2025 r. celem ataków były kolejno stacje uzdatniania wody w Tolkmicku, Małdytach i Sierakowie (luty), oczyszczalnia ścieków w Witkowie (maj), stacja uzdatniania w Jabłonnej Lackiej (wrzesień) i oczyszczalnia w Chodaczowie (październik). Pełnomocnik Rządu ds. Cyberbezpieczeństwa Krzysztof Gawkowski podał w marcu 2026 r., że w sektorze wodno-kanalizacyjnym odnotowano w poprzednim roku 94 cyberataki, czyli blisko dwa razy więcej niż rok wcześniej.

W sierpniu 2026 r. Najwyższa Izba Kontroli opublikowała raport z kontroli operatorów usług kluczowych dostarczających między innymi wodę pitną. Wniosek za lata 2021-2025 brzmiał, że stosowane środki cyberbezpieczeństwa „były niewystarczające i nieadekwatne do obecnego charakteru zagrożeń oraz ich skali".

Uderza w tym jedno. To nie były ataki na wyrafinowane systemy sterowania przez łańcuch dostaw, tylko w znacznej części sięganie po panele sterownicze wystawione wprost do internetu, często z domyślnymi hasłami. Trudno o lepszą ilustrację tego, że rozdźwięk między dokumentacją a rzeczywistością jest w tym sektorze realnym ryzykiem sanitarnym, a nie problemem formalnym.

## Co dokładnie zalecił Pełnomocnik Rządu?

We wrześniu 2026 r. Pełnomocnik Rządu ds. Cyberbezpieczeństwa, wspólnie z Ministerstwem Cyfryzacji i CSIRT Infrastruktura, skierował do podmiotów krajowego systemu cyberbezpieczeństwa z sektora wodno-kanalizacyjnego zestaw zaleceń. W skrócie:

1. odseparowanie od internetu urządzeń OT (*Operational Technology*),
2. wydzielenie sieci OT od sieci korporacyjnej,
3. zabezpieczenie zdalnego dostępu szyfrowanymi kanałami komunikacji,
4. stosowanie uwierzytelniania wieloskładnikowego i zarządzania uprawnieniami pracowników,
5. bieżące aktualizacje oprogramowania systemów OT,
6. stosowanie mechanizmów audytu, w tym monitorowanie zdarzeń bezpieczeństwa.

Całość ma być objęta systemem zarządzania bezpieczeństwem informacji. Uzasadnienie pierwszego punktu jest sformułowane wprost: „bezpośrednia dostępność systemów OT i ich paneli administracyjnych z sieci Internet zwiększa ryzyko nieuprawnionego dostępu".

## Skoro zalecenia nie są wiążące, to po co je czytać?

Bo brak obowiązku stosowania konkretnego środka nie oznacza braku obowiązku uzasadnienia, dlaczego się go nie stosuje.

Ustawa o KSC nie wymienia produktów ani konfiguracji. Wymaga systemu zarządzania bezpieczeństwem informacji, w którym środki są dobrane do ryzyka i sprawdzane. Dopóki nie istniał publiczny dokument sektorowy opisujący konkretne ryzyko, spór o adekwatność środków był sporem o oceny. Od września 2026 r. istnieje taki dokument, opracowany przez organ, po serii incydentów opisanych z nazwy i po krytycznym raporcie NIK.

Praktycznie oznacza to, że w analizie ryzyka spółki wod-kan powinien znaleźć się ślad po tych zaleceniach: albo wdrożenie, albo opis środka równoważnego wraz z uzasadnieniem, dlaczego daje porównywalny poziom bezpieczeństwa. Pominięcie milczeniem jest najgorszym z trzech wyjść, bo w razie kontroli albo incydentu nie da się go obronić.

Zdaję sobie sprawę, że punkt pierwszy bywa w praktyce najtrudniejszy. Odcięcie OT od internetu w spółce, która przez ten sam kanał serwisuje przepompownie w kilkunastu miejscowościach, nie jest zmianą konfiguracji na jedno popołudnie. Ale to jest właśnie ta rozmowa, którą trzeba odbyć z dostawcą automatyki i zapisać jej wynik, zamiast odkładać ją do następnego audytu.

## Czy moja spółka w ogóle podlega ustawie?

Sektor zaopatrzenia w wodę pitną i jej dystrybucji oraz sektor ścieków są objęte ustawą. Samo działanie w sektorze niczego jednak nie przesądza: o przypisaniu do kategorii **podmiotu kluczowego** albo **podmiotu ważnego** decydują dodatkowo rodzaj świadczonej usługi i wielkość podmiotu.

Dwie rzeczy warto zapamiętać.

Kwalifikację przeprowadza sam podmiot i sam ją dokumentuje. Nikt nie nadaje tego statusu z urzędu, a notatka z uzasadnieniem przydaje się również wtedy, gdy wynik jest negatywny.

Termin na wniosek o wpis do wykazu to zgodnie z art. 7c ust. 1 uksc **6 miesięcy od dnia spełnienia przesłanek** uznania za podmiot kluczowy lub ważny. Dla podmiotów, które spełniały je już w dniu wejścia w życie nowelizacji, wypada on **3 października 2026 r.** Samorejestracja ruszyła 7 maja 2026 r., a wykaz działa jako aplikacja w ramach Systemu S46. Procedurę opisuje Ministerstwo Cyfryzacji w komunikacie o [uruchomieniu samorejestracji](https://samorzad.gov.pl/web/gov/nowelizacja-ustawy-o-krajowym-systemie-cyberbezpieczenstwa-ksc---uruchamiamy-samorejestracje-w-wykazie-podmiotow-kluczowych-i-podmiotow-waznych-sprawdz-jak-dokonac-wpisu).

Wniosek zawiera oświadczenie kierownika podmiotu składane pod rygorem odpowiedzialności karnej za złożenie fałszywego oświadczenia (art. 7c ust. 5 uksc), więc kwalifikacja opisana wyżej nie jest ćwiczeniem wewnętrznym.

Jeżeli spółka korzysta z zewnętrznego dostawcy usług zarządzanych w zakresie cyberbezpieczeństwa do realizacji zadań z art. 8 i art. 11, informację o zawarciu takiej umowy wraz z danymi dostawcy ujawnia się w wykazie (art. 7 ust. 2 pkt 16 uksc). Zmianę danych zgłasza się w terminie 14 dni (art. 7c ust. 3 uksc). To drobiazg, o którym łatwo zapomnieć przy podpisywaniu umowy.

## Pełny czy uproszczony reżim SZBI?

To pytanie decyduje o nakładzie pracy bardziej niż jakiekolwiek inne, a bywa zadawane dopiero na etapie pisania dokumentacji. W spółce komunalnej jest przy tym trudniejsze, niż się wydaje, bo ta sama spółka potrafi pasować do dwóch sektorów naraz.

Zasadą jest art. 8 ust. 1 uksc: podmiot kluczowy lub ważny wdraża system zarządzania bezpieczeństwem informacji w systemie informacyjnym wykorzystywanym w procesach wpływających na świadczenie usługi. Wyjątek z art. 8 ust. 3 jest wąski i adresowany imiennie: przepisu ust. 1 nie stosuje **podmiot ważny będący podmiotem publicznym** (oraz wskazane tam podmioty ze sfery szkolnictwa wyższego i nauki). Taki podmiot buduje SZBI spełniający wymagania załącznika nr 4 do ustawy.

| | Art. 8 ust. 1 uksc | Art. 8 ust. 3 uksc i załącznik nr 4 |
|---|---|---|
| Kogo dotyczy | Zasada: każdy podmiot kluczowy i każdy podmiot ważny | Wyjątek: podmiot **ważny** będący **podmiotem publicznym** |
| Zakres | Pełne wymagania SZBI z art. 8 ust. 1 | Wymagania z załącznika nr 4 |
| Audyt z art. 15 | Co najmniej raz na 3 lata, ale tylko dla podmiotu kluczowego | Nie dotyczy podmiotu ważnego |

Cała trudność siedzi w definicji. „Podmiot publiczny" to według art. 2 pkt 11b uksc podmiot wskazany w załączniku nr 1 lub 2 **w sektorze podmioty publiczne**, a nie każdy podmiot z kapitałem samorządowym. W sektorze tym wymieniono między innymi spółki wykonujące zadania o charakterze użyteczności publicznej w rozumieniu art. 1 ust. 2 ustawy o gospodarce komunalnej. Gminna spółka wod-kan mieści się w tym opisie, a jednocześnie jest przedsiębiorstwem wodociągowo-kanalizacyjnym wymienionym w sektorach zbiorowego zaopatrzenia w wodę pitną i zbiorowego odprowadzania ścieków.

Rozstrzyga więc podstawa wpisu do wykazu: w jakim sektorze i jako jaki podmiot spółka została ujęta. Od tego zależy nie tylko zakres dokumentacji, ale też obowiązek audytu i zakres obowiązków incydentalnych opisanych niżej. Dlatego kopia zawiadomienia o wpisie, a jeżeli zostało doręczone, także wezwania organu, to pierwszy dokument, o który proszę, zanim ustalę zakres prac. Jeżeli podstawa wpisu zmieni się albo zostanie sprostowana, zmienia się również zakres obowiązków, i to w obie strony.

## Ile ocen ryzyka musi mieć spółka wod-kan?

Trzy, i to wynikające z dwóch różnych ustaw.

Ustawa o KSC wymaga systematycznego szacowania ryzyka wystąpienia incydentu i zarządzania tym ryzykiem (art. 8 ust. 1 pkt 1). Przedmiotem jest system informacyjny wykorzystywany w procesach wpływających na świadczenie usługi.

Art. 4e ustawy o zbiorowym zaopatrzeniu w wodę nakłada na dostawcę wody dwie odrębne oceny: ocenę ryzyka w obszarze zasilania ujęcia wody wykorzystywanego do poboru wody przeznaczonej do spożycia przez ludzi oraz ocenę ryzyka w systemie zaopatrzenia w wodę. Obie podlegają udokumentowanym przeglądom w regularnych odstępach wynikających z tych ocen, nie dłuższych niż 6 lat, i w razie potrzeby aktualizacji. Ustawa wymaga przy tym oparcia ich na obowiązujących normach dotyczących bezpieczeństwa zaopatrzenia w wodę.

| Ocena | Podstawa | Czego dotyczy | Przegląd |
|---|---|---|---|
| Szacowanie ryzyka wystąpienia incydentu | art. 8 ust. 1 pkt 1 uksc | Systemy informacyjne wspierające usługę | Zgodnie z przyjętym cyklem SZBI |
| Ocena ryzyka w obszarze zasilania ujęcia | art. 4e ust. 1 pkt 1 uzzw | Zlewnia i samo ujęcie | Nie rzadziej niż co 6 lat |
| Ocena ryzyka w systemie zaopatrzenia w wodę | art. 4e ust. 1 pkt 2 uzzw | Układ od ujęcia do kranu | Nie rzadziej niż co 6 lat |

Obowiązki z art. 4e wprowadziła [ustawa z 13 marca 2026 r. o zmianie ustawy o zbiorowym zaopatrzeniu w wodę i zbiorowym odprowadzaniu ścieków oraz niektórych innych ustaw](https://eli.gov.pl/eli/DU/2026/605/ogl) (Dz.U. 2026 poz. 605).

To trzy odrębne dokumenty i nie należy ich zlewać w jeden. Powinny się natomiast widzieć nawzajem, bo scenariusz „utrata kontroli nad dozowaniem reagentów wskutek nieuprawnionego dostępu do OT" jest jednocześnie ryzykiem cyber i ryzykiem sanitarnym. Ataki z 2025 r. pokazały, że to nie jest ćwiczenie z korelacji rejestrów.

## Jak zgłasza się incydent?

Najpierw trzeba zaklasyfikować incydent jako poważny na podstawie progów uznawania incydentu za poważny (art. 11 ust. 1 pkt 3 uksc). Dopiero wtedy uruchamia się łańcuch zgłoszeń do **właściwego CSIRT sektorowego**, przekazywanych przez system teleinformatyczny z art. 46 ust. 1 uksc.

| Krok | Termin | Podstawa |
|---|---|---|
| Wczesne ostrzeżenie | niezwłocznie, nie później niż 24 godziny od wykrycia | art. 11 ust. 1 pkt 4 |
| Zgłoszenie incydentu poważnego | niezwłocznie, nie później niż 72 godziny od wykrycia | art. 11 ust. 1 pkt 4a |
| Sprawozdanie okresowe | na wniosek CSIRT sektorowego | art. 11 ust. 1 pkt 4b |
| Sprawozdanie końcowe | nie później niż miesiąc **od dnia zgłoszenia**, nie od wykrycia | art. 11 ust. 1 pkt 4c |

Termin sprawozdania końcowego liczy się od zgłoszenia z pkt 4a, a nie od wykrycia incydentu. To drobna różnica, która w kalendarzu potrafi przesunąć się o kilka dni w jedną albo drugą stronę, więc lepiej zapisać ją w procedurze niż odtwarzać z pamięci pod presją.

Jest tu wyjątek istotny właśnie dla spółek komunalnych. Zgodnie z art. 12c uksc do **podmiotu ważnego będącego podmiotem publicznym** stosuje się art. 11 i art. 12 z wyłączeniem przepisów o wczesnym ostrzeżeniu, sprawozdaniu okresowym, sprawozdaniu z postępu obsługi incydentu i sprawozdaniu końcowym. Taki podmiot składa więc samo zgłoszenie w ciągu 72 godzin. Czy spółka mieści się w tym wyjątku, zależy znów od podstawy wpisu do wykazu, a nie od tego, kto ma w niej udziały.

Ten zegar biegnie niezależnie od terminów z RODO. Jeżeli incydent objął dane osobowe, a w spółce komunalnej obejmie je niemal zawsze, administrator ma równolegle 72 godziny od stwierdzenia naruszenia na zgłoszenie do UODO oraz obowiązek zawiadomienia osób przy wysokim ryzyku. Rozpisałem to w [przewodniku po obowiązkach przy naruszeniu ochrony danych]({% post_url 2026-09-21-naruszenie-ochrony-danych-przewodnik %}).

Jedna procedura, dwie ścieżki, jedna osoba pilnująca obu zegarów. Rozdzielenie tego na „sprawę automatyki" i „sprawę IOD" kończy się tym, że jeden z terminów przepada. Jak taki incydent wygląda w spółce komunalnej, opisywałem na przykładzie [ataku na MPK Kraków]({% post_url 2024-12-06-atak-mpk-krakow %}).

Kilka dni po incydencie pojawia się osobne pytanie: co wolno powiedzieć mediom i wnioskodawcom. Odpowiada na nie art. 37 ust. 1 uksc, a rozwijam je w [poradniku o udostępnianiu informacji po incydencie]({% post_url 2025-10-21-udostepnianie-informacji %}).

## Kto za to odpowiada?

Kierownik podmiotu, czyli w spółce z o.o. zarząd. Art. 8c ust. 3 uksc przesądza, że odpowiedzialność za wykonywanie obowiązków spoczywa na nim również wtedy, gdy ich realizację powierzono innej osobie. Art. 8d wskazuje, że to kierownik podmiotu podejmuje decyzje w zakresie przygotowania, wdrażania, stosowania, przeglądu i nadzoru systemu zarządzania bezpieczeństwem informacji. Art. 8e nakłada obowiązek jego cyklicznego szkolenia.

Art. 14 uksc pozwala realizować zadania z zakresu cyberbezpieczeństwa przez wewnętrzne struktury albo na podstawie umowy z podmiotem zewnętrznym. Stąd wzięła się praktyczna nazwa „pełnomocnik ds. cyberbezpieczeństwa", która w ustawie nie występuje i która nie oznacza pełnomocnictwa w rozumieniu Kodeksu cywilnego. Rola jest realna, ale polega na doradztwie i koordynacji. Zakres, w jakim ją pełnię, opisałem na stronie [O mnie](/about "O mnie - IOD i pełnomocnik ds. cyberbezpieczeństwa").

Warto powiedzieć to wprost przy podpisywaniu umowy, bo oczekiwanie bywa odwrotne. Zarząd, który kupuje usługę, czasem słyszy, że „firma zewnętrzna bierze to na siebie". Ustawa mówi co innego i to zarząd poniesie konsekwencje.

Osobna rzecz, która zaskakuje przy pierwszym wdrożeniu: art. 8f uksc wymaga, by osoby realizujące zadania z art. 8 i art. 11 uksc przedstawiły informację z Krajowego Rejestru Karnego. Dotyczy to także osób po stronie wykonawcy zewnętrznego, więc lepiej uwzględnić to w harmonogramie, zanim okaże się, że prace stoją.

## Od czego zacząć?

1. Ustal i zapisz, czy spółka jest podmiotem kluczowym, ważnym, czy żadnym z nich. Uzasadnienie zachowaj także przy wyniku negatywnym.
2. Jeżeli podlegasz ustawie, złóż wniosek o wpis do wykazu w terminie do 3 października 2026 r. i wskaż realne osoby kontaktowe.
3. Weź zawiadomienie o wpisie i ustal na jego podstawie, czy stosujesz art. 8 ust. 1, czy art. 8 ust. 3 i załącznik nr 4. Od tego zależy wszystko dalej.
4. Przejdź zalecenia z sekcji wyżej punkt po punkcie i dla każdego zapisz jedno z trzech: wdrożone, wdrażane do daty, zastąpione środkiem równoważnym z uzasadnieniem.
5. Zinwentaryzuj OT: sterowniki, panele, modemy, zdalne dostępy serwisowe dostawcy automatyki. Sprawdź, co z tego jest osiągalne z internetu, a nie co według dokumentacji powinno być.
6. Napisz jedną procedurę obsługi incydentu z dwiema ścieżkami zgłoszeniowymi, do CSIRT i do UODO, i przetestuj ją na ćwiczeniu.
7. Sprawdź, czy ocena ryzyka z art. 4e ustawy wodociągowej i szacowanie ryzyka z ustawy o KSC znają wspólne scenariusze.
8. Zaplanuj szkolenie kierownika podmiotu i szkolenia z cyberhigieny dla pracowników, w tym dla obsługi obiektów.

Punkt piąty daje zwykle najwięcej do myślenia, bo jego wynik rzadko zgadza się z tym, co ludzie sądzili przed jego wykonaniem. Od niego bym zaczął, gdyby trzeba było wybrać tylko jeden.

## Najczęściej zadawane pytania

{% include post-faq.html %}
