---
title: "Xandr ukarany w Norwegii na 92 mln NOK: czy współadministrator może polegać na zgodzie zebranej przez partnera?"
date: 2026-10-29T06:00:00.00Z
categories:
  - Administrator danych osobowych
tags:
  - RODO
  - Kara administracyjna
  - Współadministrowanie
  - Zgoda
  - Dane szczególnej kategorii
  - Administrator danych
description: "Norweski Datatilsynet nałożył na Xandr, spółkę reklamową Microsoftu, 92 mln NOK (ok. 8,6 mln euro) za przetwarzanie danych użytkowników Grindra w real time bidding bez podstawy prawnej. Organ uznał Xandr za współadministratora, który nie sprawdził, czy zgoda zebrana przez Grindra jest ważna. Piszę, co z tego wynika dla administratorów w Polsce."
legal: true
legal_status_date: 2026-10-29
faq:
  - question: "Dlaczego ukarano Xandr, skoro zgodę od użytkowników zbierał Grindr?"
    answer: "Bo Datatilsynet uznał Xandr za współadministratora, a każdy współadministrator musi mieć własną podstawę prawną i umieć wykazać, że ją ma (art. 5 ust. 2 i art. 24 RODO, a przy zgodzie także art. 7 ust. 1). Zgodę może w praktyce zbierać jeden z nich, ale tylko wtedy, gdy obaj upewnią się, że spełnia ona warunki z art. 4 pkt 11 i art. 7 RODO i obejmuje przetwarzanie każdego z nich. Zgody zebrane przez Grindra były nieważne, a Xandr nie podjął żadnych kroków, żeby to sprawdzić."
  - question: "Czy sama informacja, że ktoś korzysta z aplikacji, może być daną szczególnej kategorii?"
    answer: "W tej sprawie tak. Xandr otrzymywał co najmniej nazwę aplikacji, identyfikator reklamowy i adres IP. Ponieważ Grindr jest aplikacją randkową dla osób LGBTQ, sam fakt korzystania z niej organ uznał za dane dotyczące orientacji seksualnej w rozumieniu art. 9 ust. 1 RODO. Tę samą ocenę w sprawie Grindra utrzymały wcześniej norweska komisja odwoławcza i sądy. Organ powołał się też na wyrok TSUE C-252/21 (Meta Platforms), według którego nie ma znaczenia, czy administrator chciał pozyskać dane wrażliwe."
  - question: "Czy zapis w umowie, że partner odpowiada za zebranie zgody, chroni współadministratora?"
    answer: "Nie chronił Xandra. Spółka wskazywała, że w umowie ramowej zakazała Grindrowi przekazywania danych szczególnej kategorii, a za ważność zgód miał odpowiadać Grindr. Datatilsynet odpowiedział, że taka formalna klauzula nie zwalnia z odpowiedzialności administratora, który faktycznie przetwarzał dane wrażliwe, i że zasady rozliczalności nie da się przenieść na partnera umową."
  - question: "Czy kara dla Xandr jest ostateczna?"
    answer: "Decyzja z 2 października 2026 r. przewiduje odwołanie w terminie trzech tygodni od jej doręczenia. Odwołanie składa się do Datatilsynet, a jeśli organ podtrzyma decyzję, sprawę rozpatruje norweska komisja odwoławcza ds. ochrony prywatności (Personvernnemnda). W chwili pisania nie znalazłem informacji, czy Xandr się odwołał."
sources:
  - name: "EROD, „Norwegian DPA fines Xandr EUR 8 600 000 for unlawful processing of personal data” (16 października 2026 r.)"
    url: https://www.edpb.europa.eu/news/norwegian-dpa-fines-xandr-eur-8-600-000-for-unlawful-processing-of-personal-data_en
  - name: "Datatilsynet, decyzja w sprawie Xandr Inc., sygn. 20/03541-37 (2 października 2026 r.), wersja publiczna w języku angielskim"
    url: https://www.datatilsynet.no/contentassets/213ea490834f4fc2a796aa495cb72fb8/administrative-fine---unlawful-processing-of-personal-data_redacted-public-version.pdf
  - name: "Datatilsynet, „Microsoft company fined NOK 92 million for unlawfully sharing personal data” (12 października 2026 r.)"
    url: https://www.datatilsynet.no/en/news/news-2026/microsoft-company-fined-nok-92-million-for-unlawfully-sharing-personal-data/
  - name: "Forbrukerrådet, skargi przeciwko Grindrowi i pięciu podmiotom trzecim (2020 r.)"
    url: https://www.forbrukerradet.no/side/complaints-against-grindr-and-five-third-party-companies/
  - name: "Wyrok TSUE z 7 marca 2024 r., C-604/22, IAB Europe"
    url: https://eur-lex.europa.eu/legal-content/PL/TXT/?uri=CELEX:62022CJ0604
  - name: "Rozporządzenie (UE) 2016/679 (RODO)"
    url: https://eur-lex.europa.eu/eli/reg/2016/679/oj
---

**Norweski organ ochrony danych, Datatilsynet, nałożył na spółkę Xandr Inc. karę 92 mln koron norweskich, czyli według EROD ok. 8,6 mln euro. To najwyższa kara w historii tego organu. Sprawa wraca do aplikacji randkowej Grindr, ale tym razem ukarany został nie twórca aplikacji, tylko pośrednik reklamowy, przez którego platformę dane jej użytkowników przez prawie dwa lata trafiały do aukcji real time bidding. Organ zgodził się, że zgodę zbierał Grindr, i mimo to uznał, że Xandr przetwarzał dane bez podstawy prawnej, bo rozliczalności nie da się zlecić partnerowi.**

## Co się stało?

W 2020 r. norweska Rada Konsumentów (Forbrukerrådet) złożyła skargi na Grindra i pięć firm z branży reklamy internetowej, w tym na AppNexus, który w 2019 r. zmienił nazwę na Xandr, a w czerwcu 2022 r. został przejęty przez Microsoft. Grindr dostał swoją karę już w grudniu 2021 r.: 65 mln NOK za udostępnianie danych partnerom reklamowym bez ważnej zgody. Tę decyzję utrzymała norweska komisja odwoławcza, a potem sąd rejonowy w Oslo i sąd apelacyjny Borgarting.

Decyzja wobec Xandr nosi datę 2 października 2026 r. i dotyczy okresu od 20 lipca 2018 r. (od tego dnia RODO obowiązuje w Norwegii) do 7 kwietnia 2020 r., kiedy Grindr wdrożył nowy system zbierania zgód. Xandr działał w aukcjach po obu stronach: jako platforma sprzedażowa (SSP), która wystawia powierzchnię reklamową w aplikacji, i jako platforma zakupowa (DSP), która w imieniu reklamodawców składa oferty. Każde wyświetlenie reklamy w Grindrze uruchamiało zapytanie ofertowe, które trafiało do potencjalnie tysięcy podmiotów. Organ uznał za udowodnione, że Xandr przetwarzał w ten sposób co najmniej trzy rzeczy: informację, że dana osoba korzysta z Grindra, jej identyfikator reklamowy i adres IP.

Datatilsynet stwierdził naruszenie dwóch przepisów: art. 6 ust. 1 RODO, bo Xandr nie miał podstawy prawnej, i art. 9 ust. 1 RODO, bo przetwarzał dane dotyczące orientacji seksualnej bez żadnego z wyjątków z art. 9 ust. 2.

## Skąd w tej sprawie dane o orientacji seksualnej?

Z samej nazwy aplikacji. Grindr jest aplikacją randkową dla gejów, osób biseksualnych, transpłciowych i queer, więc identyfikator reklamowy połączony z informacją „ten użytkownik jest teraz w Grindrze” mówi o tej osobie coś, co art. 9 RODO chroni najmocniej. Taką samą ocenę przyjęto w sprawie samego Grindra i utrzymały ją sądy.

Xandr bronił się, że nie wiedział o przetwarzaniu danych szczególnej kategorii i że w umowie ramowej zakazał Grindrowi ich przekazywania. Organ odpowiedział, że przy art. 9 liczy się to, co administrator faktycznie przetwarza, a nie to, co zapisał w umowie. Powołał się przy tym na wyrok TSUE C-252/21 (Meta Platforms), zgodnie z którym nie ma znaczenia, czy administrator działa w celu pozyskania danych wrażliwych.

## Dlaczego zgoda zebrana przez Grindra nie wystarczyła?

Bo Xandr był współadministratorem, a nie biernym odbiorcą danych. Datatilsynet oparł się tu na wyroku TSUE C-604/22 (IAB Europe): współadministrowanie może wynikać z decyzji podejmowanych osobno, jeśli każda z nich ma realny wpływ na cele i sposoby przetwarzania. Xandr dostarczał Grindrowi konsolę z domyślnymi ustawieniami, a jeśli Grindr ich nie zmienił, zapytania ofertowe trafiały do partnerów wybranych przez Xandr według jego standardów. To wystarczyło, żeby uznać go za współadministratora zarówno w roli SSP, jak i DSP.

Przy danych szczególnej kategorii jedyną możliwą podstawą była wyraźna zgoda z art. 9 ust. 2 lit. a RODO. Xandr nie zbierał jej sam, tylko polegał na zgodach Grindra. Te zgody były nieważne: już w sprawie Grindra organ ustalił, że nie były dobrowolne, konkretne, świadome ani jednoznaczne i że nie dało się ich wycofać tak łatwo, jak wyrazić (art. 4 pkt 11 i art. 7 RODO).

Organ nie wymaga, żeby każdy współadministrator sam zbierał zgodę. Pisze wprost, że można umówić się, że zgodę zbiera jeden z nich, ale tylko wtedy, gdy obaj upewnią się, że spełnia ona wymagania RODO, jest udokumentowana i obejmuje przetwarzanie każdego z nich. Zasada rozliczalności z art. 5 ust. 2 i obowiązki z art. 24 dotyczą obu współadministratorów, a art. 7 ust. 1 wymaga, żeby administrator umiał wykazać, że osoba wyraziła zgodę. Xandr niczego nie sprawdzał. Organ zauważył przy tym, że skoro spółka nie miała żadnego bezpośredniego kontaktu z użytkownikami i była „dalej w łańcuchu”, tym bardziej powinna była zweryfikować legalność przetwarzania.

Dyrektor Datatilsynet Line Coll podsumowała to w komunikacie tak, że odpowiedzialności za ochronę danych nie można przerzucić na innych, a każda firma musi zapewnić i umieć wykazać, że ma prawo korzystać z danych.

## Jak policzono karę?

Organ uznał naruszenia za co najmniej niedbałe i o wysokim stopniu wagi, bo dotyczą podstawowych przepisów RODO i danych wrażliwych. Jako okoliczności obciążające wskazał czas trwania naruszenia i to, że Xandr bezpośrednio na nim zarabiał. Karę policzono od obrotu samego Xandr za 2025 r., a nie od obrotu Microsoftu, bo w okresie naruszenia Xandr do Microsoftu nie należał. Xandr kwestionował wybór roku obrotowego, ale organ odpowiedział, że liczy się moment wydania decyzji.

W samej decyzji kwota 92 mln NOK jest przeliczona na ok. 8,5 mln euro według kursu Norges Bank z 15 września 2026 r.; EROD w swoim komunikacie podaje 8,6 mln euro. Organ zaznacza, że kwota mieści się w przedziale od 4 do 20 mln euro, który wytyczne EROD 04/2022 przewidują dla naruszeń o wysokim stopniu wagi.

## Czy decyzja jest ostateczna?

Jeszcze nie musi być. Xandr ma trzy tygodnie od doręczenia decyzji na odwołanie. Składa je do Datatilsynet, a jeśli organ podtrzyma swoje stanowisko, sprawa trafi do komisji odwoławczej Personvernnemnda. Do dnia publikacji tego wpisu nie znalazłem informacji, czy Xandr z tej drogi skorzystał. Przy Grindrze organ wygrał we wszystkich instancjach, ale to inna spółka i inny zarzut, więc nie przesądza wyniku.

## Co z tego wynika dla administratora w Polsce?

Norwegia nie należy do UE, ale RODO obowiązuje tam przez umowę o EOG, a wytyczne EROD i wyroki TSUE, na których oparto decyzję, są te same co u nas. Prezes UODO nie jest tą decyzją związany, tylko że jej rozumowanie wynika wprost z RODO i z orzecznictwa TSUE, więc trudno mi sobie wyobrazić, żeby polski organ ocenił taką sprawę inaczej.

Najczęściej spotykam ten problem w dwóch odsłonach. Pierwsza to wydawca strony albo aplikacji, który wpina zestaw narzędzi reklamowych i analitycznych, a baner zgód dostaje od dostawcy w pakiecie. Druga to podmiot „dalej w łańcuchu”: agencja, sieć reklamowa, dostawca narzędzia marketingowego, który dostaje dane z cudzych formularzy i zakłada, że skoro partner obiecał w umowie zebrać zgodę, sprawa jest załatwiona. Decyzja w sprawie Xandr mówi, że to drugie założenie nie wystarczy.

Jeśli opierasz przetwarzanie na zgodzie, którą zbiera ktoś inny, sprawdziłbym trzy rzeczy, zanim zrobi to organ:

1. **Ustal, czy jesteś współadministratorem.** Decyduje to, czy realnie wpływasz na cele i sposoby przetwarzania, a nie nazwa w umowie. Jeśli tak, potrzebne jest uzgodnienie z art. 26 RODO, a nie sama klauzula o tym, że partner „odpowiada za zgody”.
2. **Zobacz zgodę na własne oczy.** Jak wygląda formularz albo baner, czy wymienia cię z nazwy i cel, w jakim przetwarzasz dane, czy odmowa jest równie łatwa jak akceptacja i czy zgodę da się wycofać. Zachowaj z tego ślad: zrzut ekranu, wersję tekstu, datę.
3. **Upewnij się, że umiesz wykazać zgodę konkretnej osoby.** Art. 7 ust. 1 RODO wymaga tego od każdego administratora, który na zgodzie się opiera, więc potrzebujesz od partnera dostępu do rejestru zgód albo przynajmniej sygnału zgody przekazywanego razem z danymi.

Osobna sprawa to dane, które na pierwszy rzut oka nie są wrażliwe. Identyfikator reklamowy i adres IP same w sobie nic nie mówią o zdrowiu ani o orientacji seksualnej, ale w połączeniu z nazwą aplikacji, profilem strony albo kategorią sklepu już mogą. Jeśli Twoja usługa jest skierowana do określonej grupy, na przykład pacjentów, osób w kryzysie albo członków konkretnej społeczności, załóż, że sam fakt korzystania z niej może być daną szczególnej kategorii, i oceń reklamę oraz analitykę właśnie pod tym kątem.

## Najczęściej zadawane pytania

{% include post-faq.html %}
