---
title: Claude Code w pracy IOD, czyli jak używam dużego modelu AI bez wysyłania danych osobowych
date: 2026-06-11T09:17:00.00Z
categories:
  - Sztuczna inteligencja
tags:
  - Claude Code
  - AI
  - LLM
  - Automatyzacja
  - Anonimizacja
  - Pseudonimizacja
  - RODO
  - Inspektor ochrony danych
  - AI Act
  - CLI
description: Lokalne modele językowe sprawdzają się w prostych zadaniach IOD, ale przy analizie umów powierzenia czy ocenie naruszeń modele frontierowe są o klasę lepsze. Problem w tym, że działają w chmurze. Opisuję, jak połączyłem własny CRM z warstwą anonimizacji i Claude Code, dzięki czemu korzystam z najlepszego dostępnego AI, a dane osobowe moich klientów nie opuszczają mojej infrastruktury.
faq:
  - question: "Jak autor korzysta z Claude Code, nie wysyłając danych osobowych klientów do chmury?"
    answer: "Autor zbudował endpoint eksportu we własnym CRM, który przed wysłaniem dokumentu do Claude Code automatycznie anonimizuje treść: zamienia imiona i nazwiska na tokeny, usuwa numery PESEL i dokumentów, uogólnia adresy, a nazwy kontrahentów i e-maile zastępuje identyfikatorami. Słownik podmian pozostaje wyłącznie w bazie CRM na własnym serwerze, a wynik z modelu jest lokalnie podstawiany z powrotem na prawdziwe dane."
  - question: "Czym różni się anonimizacja od pseudonimizacji w tym rozwiązaniu?"
    answer: "Ściśle rzecz biorąc to pseudonimizacja, bo słownik podmian istnieje i pozwala odtworzyć tożsamość - autor otwarcie to przyznaje i nadal traktuje te dane w CRM jako dane osobowe podlegające pełnemu rygorowi RODO. Kluczowe jest jednak to, że klucz (słownik) nigdy nie opuszcza jego infrastruktury, więc dostawca modelu (Anthropic) otrzymuje tekst, którego nie da się powiązać z konkretną osobą."
  - question: "Do jakich zadań IOD autor wykorzystuje Claude Code?"
    answer: "Głównie do weryfikacji umów powierzenia pod kątem art. 28 ust. 3 RODO, oceny naruszeń według wytycznych EROD 9/2022 i metodyki ENISA, sprawdzania klauzul informacyjnych pod kątem art. 13 i 14 RODO, kontroli spójności rejestru czynności przetwarzania oraz do pisania i utrzymywania własnych automatyzacji, np. workflow w n8n do monitoringu decyzji UODO."
---

W październiku pisałem, że [komercyjne modele AI odpadają w pracy IOD]({% post_url 2025-10-30-ai-w-pracy-iod %}), bo dane osobowe nie mogą lecieć na serwery OpenAI czy Anthropic. Potem pokazałem, jak [lokalny model streszcza mi decyzje UODO]({% post_url 2025-11-08-automatyzacja-monitoring-uodo %}). Oba teksty bronią się do dziś. Ale od tamtej pory moje podejście wyewoluowało.

Lokalne modele mają sufit. Streszczenie publicznie dostępnej decyzji UODO? Qwen na moim serwerze robi to bez zająknięcia. Ale gdy podrzucałem mu trzydziestostronicową umowę powierzenia z prośbą o analizę prawną, zaczynał gubić wątek, a czasem po prostu zmyślał przepisy. Modele frontierowe radzą sobie z takim zadaniem o klasę lepiej. Tylko że działają w chmurze, a ja jako IOD nie mogę tam wysyłać danych klientów.

Przez dłuższy czas uznawałem temat za zamknięty. Aż poukładałem sobie infrastrukturę tak, że dziś korzystam z Claude Code codziennie, a żadne dane osobowe nie wychodzą poza mój serwer.

## Czym jest Claude Code i po co to inspektorowi

Claude Code to agent od Anthropic działający w terminalu. Nie czat w przeglądarce, do którego wkleja się tekst, tylko narzędzie, które samo czyta pliki z dysku, uruchamia polecenia, odpytuje API i zapisuje wyniki. Powstał dla programistów, ale od jakiegoś czasu widać wyraźny trend używania go do pracy biurowej: analizy dokumentów, raportów, compliance. Anthropic poszedł za ciosem i wypuścił Cowork, czyli wersję tego samego pomysłu dla ludzi, którzy terminala wolą nie dotykać. Ja akurat terminal lubię, więc zostałem przy Claude Code.

Dla mnie najważniejszy jest tryb skryptowy. Polecenie `claude -p "zadanie"` przyjmuje tekst na wejściu, zwraca wynik i kończy działanie. To znaczy, że mogę wpiąć duży model językowy w zwykły potok w bashu, tak samo jak `grep` czy `jq` (tak, traktuję AI jak kolejne narzędzie uniksowe i bardzo mi z tym dobrze). A skoro tak, to mogę też kontrolować, co dokładnie do niego trafia.

Drugi istotny element: plik `CLAUDE.md` w katalogu projektu. Trzymam w nim swój warsztat, czyli metodykę oceny ryzyka naruszeń, listę typowych błędów w umowach powierzenia, preferowane sformułowania. Claude Code czyta to przy każdym uruchomieniu, więc nie muszę za każdym razem tłumaczyć od zera, czego oczekuję.

## Mój CRM i warstwa anonimizacji

Od lat prowadzę własny, wewnętrzny CRM, w którym siedzą wszystkie dane moich klientów: umowy, rejestry czynności, korespondencja, zgłoszenia naruszeń. Działa na moim serwerze, nigdzie indziej. I to on jest sercem całego rozwiązania.

Dopisałem do niego endpoint eksportu, który zanim cokolwiek zwróci, przepuszcza dokument przez warstwę anonimizacji. Imiona i nazwiska zamienia na tokeny, numery PESEL i dokumentów usuwa, adresy uogólnia do miejscowości, adresy e-mail i nazwy kontrahentów zastępuje identyfikatorami. Słownik podmian ląduje w bazie CRM i nigdy jej nie opuszcza.

W praktyce wygląda to tak. Fragment zgłoszenia naruszenia przed eksportem:

> Pani Anna N. (PESEL 850423xxxxx), kadrowa w XYZ Logistics Sp. z o.o., zgłosiła, że 14 maja 2026 r. omyłkowo wysłała listę płac na prywatny adres jan.k…@gmail.com.

I to samo zgłoszenie w wersji, którą widzi model:

> [OSOBA_1] (PESEL usunięty), kadrowa w [PODMIOT_3], zgłosiła, że 14 maja 2026 r. omyłkowo wysłała listę płac na prywatny adres [EMAIL_2].

Data zostaje, bo bez niej nie policzę terminu 72 godzin na zgłoszenie do UODO. Stanowisko też, bo ma znaczenie dla oceny ryzyka. To zawsze jest decyzja: co model musi wiedzieć, żeby analiza miała sens, a co może zniknąć. Reguły eksportu mam zapisane per typ dokumentu i co jakiś czas je przeglądam.

Cały przepływ spina kilka linijek:

```bash
# eksport zanonimizowanego dokumentu z CRM
curl -s -H "Authorization: Bearer $CRM_TOKEN" \
  "https://crm.lan/api/dokumenty/1542/eksport?tryb=anon" -o /tmp/umowa-1542.md

# analiza w Claude Code
claude -p "Zweryfikuj tę umowę powierzenia pod kątem art. 28 ust. 3 RODO. \
Wypisz brakujące elementy obowiązkowe i klauzule, które negocjowałbym \
jako IOD administratora." < /tmp/umowa-1542.md
```

Wynik wraca do mnie z tokenami w treści, a lokalny skrypt podstawia z powrotem prawdziwe nazwy ze słownika w CRM. Anthropic przez cały ten czas widział tekst o [OSOBIE_1] z [PODMIOTU_3].

## Anonimizacja czy pseudonimizacja? Bądźmy uczciwi

Purysta powie: skoro słownik podmian istnieje, to żadna anonimizacja, tylko pseudonimizacja. I z mojej perspektywy ma rację. U mnie, w CRM, te dane pozostają danymi osobowymi i traktuję je z pełnym rygorem RODO. Klucz jednak nie opuszcza mojej infrastruktury, a odbiorca po drugiej stronie API dostaje tekst, którego nie ma jak powiązać z konkretną osobą.

Czy to wystarczy? Motyw 26 RODO każe oceniać możliwość identyfikacji przez pryzmat środków, "których zastosowania można racjonalnie się spodziewać". TSUE w wyroku z września 2025 r. w sprawie C-413/23 P (EIOD przeciwko SRB) potwierdził podejście relatywne: dane spseudonimizowane mogą nie być danymi osobowymi dla odbiorcy, który nie dysponuje środkami pozwalającymi na reidentyfikację. EROD patrzy na to ostrożniej, co widać i w wytycznych 01/2025 o pseudonimizacji, i w opinii 28/2024 o modelach AI, gdzie ocena anonimowości zawsze odbywa się przypadek po przypadku. Śledzę ten spór na bieżąco, bo on się jeszcze nie skończył.

Dlatego nie opieram się na jednym filarze. Po stronie umownej korzystam z API na warunkach komercyjnych: Anthropic nie trenuje modeli na danych z API i podpisuje DPA zgodne z art. 28 RODO. Ale projektuję całość tak, jakby tych gwarancji nie było. Skoro w treści zapytania nie ma danych osobowych, to nawet incydent po stronie dostawcy nie wywołuje u mnie naruszenia. Wolę takie założenie niż wiarę w cudze regulaminy.

## Co konkretnie robię w Claude Code

Umowy powierzenia to najczęstszy przypadek. Mam w `.claude/commands` własną komendę `/umowa-powierzenia`, która sprawdza kompletność względem art. 28 ust. 3, wyłapuje klauzule przerzucające odpowiedzialność na administratora i porównuje dokument z moim wzorcem. To, co kiedyś zajmowało dwie godziny, teraz schodzi do pół godziny, z czego większość to moja weryfikacja uwag modelu.

Ocena naruszeń wygląda podobnie. Zanonimizowane zgłoszenie z CRM trafia do komendy `/ocena-naruszenia`, która prowadzi analizę według wytycznych EROD 9/2022 i metodyki ENISA, a na końcu wypluwa szkic oceny ryzyka i, jeśli ryzyko tego wymaga, projekt zgłoszenia do UODO. Przy terminie 72 godzin każda zaoszczędzona godzina ma znaczenie. Szkic to szkic, decyzję podejmuję ja, ale zaczynanie od gotowej struktury zamiast pustej kartki robi różnicę.

Klauzule informacyjne sprawdzam pod kątem art. 13 i 14, głównie kompletności i języka. Tu akurat model błyszczy w upraszczaniu prawniczego żargonu, bo klauzula, której nikt nie rozumie, nie spełnia swojej funkcji.

Rejestr czynności przetwarzania eksportuję z CRM jako JSON i proszę o kontrolę spójności: czy każda czynność z odbiorcą będącym procesorem ma swoją umowę powierzenia, czy okresy retencji nie gryzą się między rejestrem a polityką. Takie krzyżowe sprawdzenie ręcznie jest żmudne i łatwo coś przeoczyć. Model się nie nudzi.

No i rzecz, która domyka koło: Claude Code pisze i utrzymuje moje automatyzacje. Workflow n8n do monitoringu decyzji UODO, o którym pisałem w listopadzie, od tamtej pory rozbudowałem właśnie z jego pomocą. Skrypty eksportu z CRM też w dużej części powstały w ten sposób.

## Stan prawny na czerwiec 2026

Za niecałe dwa miesiące, 2 sierpnia 2026 r., zaczyna obowiązywać zasadnicza część wymogów AI Act dla systemów wysokiego ryzyka. Moje zastosowanie do tej kategorii nie należy, bo wspomaganie analizy dokumentów przez człowieka, który podejmuje decyzje, to nie jest rekrutacja ani scoring kredytowy. Ale art. 4 AI Act, czyli obowiązek zapewnienia kompetencji w zakresie AI, dotyczy każdej organizacji używającej takich systemów już od lutego 2025 r. IOD, który sam korzysta z AI i rozumie, jak ona działa, ma tu zresztą przewagę: trudno doradzać klientom w sprawie narzędzi, których się nie zna od środka.

Swoje wykorzystanie AI dokumentuję: jakie narzędzie, jaki model, jakie dane wchodzą, jakie reguły anonimizacji, gdzie logi. Częściowo z zawodowej ostrożności, częściowo dlatego, że sam bym tego wymagał od każdego audytowanego podmiotu. Wypadałoby zaczynać od siebie.

## Zasady, których się trzymam

Każdy wynik weryfikuję. Model bywa przekonujący i jednocześnie w błędzie, a w tej pracy odpowiedzialność za treść opinii zawsze jest moja. AI skraca drogę do szkicu, nie zastępuje oceny.

Eksporty z warstwy anonimizacji kontroluję wyrywkowo. Reguły oparte na wzorcach potrafią przepuścić nietypowo zapisany numer telefonu albo nazwisko w odmianie, dlatego raz na jakiś czas siadam i czytam surowe eksporty, zanim cokolwiek poleci dalej. Znalazłem w ten sposób już kilka dziur i pewnie znajdę kolejne.

Koszty trzymam pod kontrolą. Subskrypcja plus rozliczenie API to realny wydatek, więc cięższe analizy puszczam na dużym modelu, a drobnicę nadal mieli lokalny Qwen. Ta hybryda wychodzi taniej niż sztywne trzymanie się jednego rozwiązania.

## Na koniec

Pół roku temu napisałbym, że IOD ma do wyboru: lokalny model albo nic. Dziś uważam, że jest trzecia droga, tylko trzeba ją sobie zbudować. Własna baza danych klientów, warstwa anonimizacji przed API i agent w terminalu składają się na zestaw, w którym dostaję jakość modelu frontierowego bez wysyłania komukolwiek danych osobowych. Nie jest to rozwiązanie z pudełka i wymaga trochę dłubania, ale dla kogoś, kto obsługuje wielu klientów jako IOD, inwestycja zwraca się szybko. A satysfakcja z systemu, który zbudowało się samemu i którego nie trzeba się wstydzić przed własnym audytem, to miły bonus.

## Najczęściej zadawane pytania

{% include post-faq.html %}
