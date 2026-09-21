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
description: 'Po serii ataków na stacje uzdatniania wody i oczyszczalnie ścieków Pełnomocnik Rządu ds. Cyberbezpieczeństwa zalecił odseparowanie systemów OT od internetu. Co z ustawy o KSC wynika dla spółki wod-kan: wykaz, reżim pełny czy uproszczony, dwie oceny ryzyka, terminy zgłoszenia incydentu i kto za to odpowiada.'
legal: true
faq:
  - question: "Czy przedsiębiorstwo wodociągowo-kanalizacyjne podlega ustawie o KSC?"
    answer: "Sektor zaopatrzenia w wodę pitną i jej dystrybucji oraz sektor ścieków są objęte ustawą, ale samo działanie w sektorze nie przesądza sprawy. O statusie podmiotu kluczowego albo ważnego decydują dodatkowo rodzaj świadczonej usługi oraz wielkość podmiotu. Kwalifikację przeprowadza i dokumentuje sam podmiot; nikt nie nadaje tego statusu z urzędu."
  - question: "Do kiedy trzeba złożyć wniosek o wpis do wykazu podmiotów kluczowych i ważnych?"
    answer: "Do 3 października 2026 r. Samorejestracja ruszyła 7 maja 2026 r., a wykaz jest aplikacją działającą w ramach Systemu S46. Jeżeli spółka zawarła umowę z dostawcą usług zarządzanych w zakresie cyberbezpieczeństwa, informację o tym ujawnia się w wykazie i aktualizuje wpis w terminie wynikającym z art. 7c uksc."
  - question: "Czy rekomendacje Pełnomocnika Rządu ds. Cyberbezpieczeństwa są obowiązkowe?"
    answer: "Nie, zostały wydane jako zalecenie, a nie akt prawa powszechnie obowiązującego. W praktyce i tak trudno je pominąć: ustawa o KSC wymaga środków adekwatnych do ryzyka, a od sierpnia 2026 r. istnieje publiczny, sektorowy dokument opisujący to ryzyko i sposób jego ograniczenia. Odstępstwo od zalecenia wymaga uzasadnienia w analizie ryzyka, a nie przemilczenia."
  - question: "Czy ocena ryzyka z ustawy o KSC to to samo co ocena ryzyka z ustawy wodociągowej?"
    answer: "Nie. Szacowanie ryzyka z ustawy o KSC dotyczy bezpieczeństwa systemów informacyjnych wykorzystywanych do świadczenia usługi. Ocena ryzyka z art. 4e ustawy o zbiorowym zaopatrzeniu w wodę dotyczy obszaru zasilania ujęć wody przeznaczonej do spożycia i jest przeglądana w odstępach wynikających z tej oceny, nie rzadszych niż co 6 lat. To dwa odrębne obowiązki o różnych przedmiotach, choć w spółce wod-kan powinny się widzieć nawzajem."
  - question: "Jakie są terminy zgłoszenia incydentu poważnego do CSIRT?"
    answer: "Trzy, liczone od wykrycia: wczesne ostrzeżenie w ciągu 24 godzin, zgłoszenie w ciągu 72 godzin i sprawozdanie końcowe w ciągu miesiąca. Zakres stosowania tych obowiązków zależy od podstawy wpisu podmiotu do wykazu. Biegną niezależnie od 72-godzinnego terminu zgłoszenia naruszenia ochrony danych osobowych do UODO."
  - question: "Czy można zlecić obowiązki z ustawy o KSC firmie zewnętrznej?"
    answer: "Zadania można realizować przez wewnętrzne struktury albo na podstawie umowy z podmiotem zewnętrznym (art. 14 uksc). Odpowiedzialność za ich wykonanie pozostaje przy kierowniku podmiotu również wtedy, gdy obowiązki powierzono innej osobie (art. 8c ust. 3 uksc). Umowa przenosi pracę, nie odpowiedzialność."
---

> **W skrócie:** w 2025 r. doszło do serii ataków na stacje uzdatniania wody i oczyszczalnie ścieków w Polsce, a NIK w sierpniu 2026 r. ocenił dotychczasowe zabezpieczenia operatorów jako niewystarczające. Pełnomocnik Rządu ds. Cyberbezpieczeństwa zalecił sektorowi wod-kan przede wszystkim odseparowanie urządzeń OT od internetu. Zalecenia nie są wiążące, ale ustawa o KSC wymaga środków adekwatnych do ryzyka, więc od ich publikacji milczenie w analizie ryzyka przestało być bezpieczną opcją. Jeżeli spółka jest podmiotem kluczowym albo ważnym, wniosek o wpis do wykazu składa się **do 3 października 2026 r.**
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

Wniosek o wpis do wykazu podmiotów kluczowych i podmiotów ważnych składa się **do 3 października 2026 r.** Samorejestracja ruszyła 7 maja 2026 r., a wykaz działa jako aplikacja w ramach Systemu S46. Procedurę opisuje Ministerstwo Cyfryzacji w komunikacie o [uruchomieniu samorejestracji](https://samorzad.gov.pl/web/gov/nowelizacja-ustawy-o-krajowym-systemie-cyberbezpieczenstwa-ksc---uruchamiamy-samorejestracje-w-wykazie-podmiotow-kluczowych-i-podmiotow-waznych-sprawdz-jak-dokonac-wpisu).

Jeżeli spółka korzysta z zewnętrznego dostawcy usług zarządzanych w zakresie cyberbezpieczeństwa, informację o zawarciu takiej umowy ujawnia się w wykazie (art. 7 ust. 2 pkt 16 uksc), a wpis aktualizuje w terminie wynikającym z art. 7c uksc. To drobiazg, o którym łatwo zapomnieć przy podpisywaniu umowy.

## Pełny czy uproszczony reżim SZBI?

To pytanie decyduje o nakładzie pracy bardziej niż jakiekolwiek inne, a bywa zadawane dopiero na etapie pisania dokumentacji.

| | Reżim z art. 8 ust. 1 uksc | Reżim z art. 8 ust. 3 uksc i załącznika nr 4 |
|---|---|---|
| Kogo dotyczy | Zależy od podstawy wpisu do wykazu oraz zakresu zadań, usług i systemów informacyjnych | Jak wyżej, przy węższym zakresie stosowania |
| Zakres dokumentacji | Pełny katalog wymagań rozdziału 3 uksc | Wymagania wskazane w załączniku nr 4 |
| Praktyczny skutek | Rozbudowany SZBI, pełny cykl przeglądów | Węższy, ale nadal udokumentowany system |

Odpowiedź wynika z podstawy wpisu do wykazu, sektora oraz zakresu zadań, usług i systemów informacyjnych podmiotu. Dlatego kopia zawiadomienia o wpisie i ewentualnego wezwania organu to pierwszy dokument, o który pytam, zanim ustalę zakres prac. Jeżeli podstawa wpisu zmieni się albo zostanie sprostowana później, zmienia się również zakres obowiązków, i to w obie strony.

## Dwie oceny ryzyka, nie jedna

Spółka wod-kan jest w nietypowej sytuacji, bo ciążą na niej dwa niezależne obowiązki oceny ryzyka, wynikające z różnych ustaw i dotyczące różnych rzeczy.

| | Ustawa o KSC | Ustawa o zbiorowym zaopatrzeniu w wodę |
|---|---|---|
| Czego dotyczy | Bezpieczeństwa systemów informacyjnych wykorzystywanych do świadczenia usługi | Obszaru zasilania ujęć wody przeznaczonej do spożycia (art. 4e) |
| Cel | Ciągłość i bezpieczeństwo usługi | Bezpieczeństwo sanitarne wody |
| Przegląd | Zgodnie z przyjętym cyklem SZBI | W odstępach wynikających z oceny, nie rzadziej niż co 6 lat |

Obowiązek z art. 4e wprowadziła [ustawa z 13 marca 2026 r. o zmianie ustawy o zbiorowym zaopatrzeniu w wodę i zbiorowym odprowadzaniu ścieków oraz niektórych innych ustaw](https://eli.gov.pl/eli/DU/2026/605/ogl) (Dz.U. 2026 poz. 605).

To dwa odrębne dokumenty i nie należy ich łączyć w jeden. Powinny się natomiast widzieć nawzajem, bo scenariusz „utrata kontroli nad dozowaniem reagentów wskutek nieuprawnionego dostępu do OT" jest jednocześnie ryzykiem cyber i ryzykiem sanitarnym. Ataki z 2025 r. pokazały, że to nie jest teoretyczne ćwiczenie z korelacji rejestrów.

## Jak zgłasza się incydent?

Zgłoszenie incydentu poważnego do właściwego CSIRT przebiega w trzech krokach.

| Krok | Termin od wykrycia | Co zawiera |
|---|---|---|
| Wczesne ostrzeżenie | 24 godziny | Sygnał, że incydent wystąpił, wraz ze wstępną oceną charakteru |
| Zgłoszenie | 72 godziny | Ocena incydentu, wskaźniki, dotychczasowe działania |
| Sprawozdanie końcowe | miesiąc | Przebieg, przyczyna źródłowa, zastosowane środki |

Zakres stosowania tych obowiązków zależy od podstawy wpisu podmiotu do wykazu (art. 12c uksc), więc również i tu punktem wyjścia jest zawiadomienie o wpisie.

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
