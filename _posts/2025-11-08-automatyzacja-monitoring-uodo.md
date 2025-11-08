---
title: Jak zautomatyzowałem monitoring decyzji UODO w swojej pracy?
date: 2025-11-08T07:07:00.00Z
categories:
  - Sztuczna inteligencja
tags:
  - AI
  - LLM
  - Automatyzacja
  - UODO
  - n8n
description: Pracuję jako inspektor ochrony danych i wiem, że powinienem mieć oko na świeże decyzje UODO. Problem? Codzienne sprawdzanie portalu orzeczenia.uodo.gov.pl to czysta strata czasu. No i zawsze jest to nieprzyjemne uczucie, że mogłem coś przegapić. W końcu postanowiłem — skoro i tak to wszystko można zrobić automatycznie, to po co się męczyć?
---

## Jak to działa?

Workflow uruchamia się sam co poniedziałek o 7:07 rano (lubię takie ładne godziny). Przeszukuje decyzje z ostatnich 30 dni i dostarcza mi gotowe streszczenia na maila. Brzmi prosto, ale w środku dzieje się całkiem sporo.

Zaczynam od pobrania danych w formacie CSV z API UODO. Dostaje sygnaturę sprawy, tytuł, daty wydania i publikacji oraz link do pełnej decyzji. Konfiguracja wygląda tak:

```yaml
URL: https://orzeczenia.uodo.gov.pl/search/export/csv

Parametry:
- dcr: rodo
- dtps: data początkowa (ostatnie 30 dni)
- dtpe: data końcowa (dzisiaj)
- targetUrl: https://orzeczenia.uodo.gov.pl
- download: true
```

Parametry `dtps` i `dtpe` to daty start i end - n8n sam podstawia za mnie aktualne daty. Można to zmienić na inny zakres, np. ostatnie 7 dni zamiast 30, albo konkretny miesiąc.

Parsuję CSV do JSONa (trzeba uważać na cudzysłowy i polskie znaki, bo mogą namieszać). Każda decyzja ląduje w osobnym obiekcie. Teraz mam już listę decyzji, ale jeszcze bez treści.

Kolejny krok? Pobieram pełny HTML każdej decyzji ze strony UODO. Wyciągam z niego czysty tekst, wyrzucam wszystkie tagi, skrypty i CSS. Na końcu przytniałem to do mniej więcej 16 000 znaków, żeby model językowy sobie poradził (żaden LLM nie przetnie kilkudziesięciu tysięcy znaków za jednym zamachem).

## Magia LLM, czyli jak streszczam decyzje

Tutaj wchodzi lokalny model językowy. Używam Qwen3-Coder-30B-A3B-Instruct, bo działa u mnie na serwerze (nie chcę wysyłać danych do OpenAI czy Claude, a poza tym szkoda kasy). Pełna kontrola nad danymi i zero kosztów API? Idealnie.

Model dostaje od razu dwie rzeczy: prompt systemowy z instrukcją, co ma robić, oraz prompt użytkownika z konkretną decyzją.

**Prompt systemowy:**

```text
Jesteś ekspertem ds. ochrony danych osobowych i RODO. Twoim zadaniem jest tworzenie zwięzłych,
ale treściwych streszczeń decyzji UODO (Urząd Ochrony Danych Osobowych).

Dla każdej decyzji utwórz streszczenie zawierające:

1. Sygnatura sprawy i data - podaj na początku
2. Główny problem - jakie naruszenie RODO zostało stwierdzone (1-2 zdania)
3. Kluczowe fakty - najważniejsze okoliczności sprawy (2-3 zdania)
4. Decyzja UODO - jaką sankcję nałożono (kara, upomnienie, nakaz) i w jakiej wysokości jeśli dotyczy
5. Wnioski praktyczne - czego można się nauczyć z tej decyzji (1-2 zdania)

Streszczenie powinno być:
- W języku polskim
- Długość: 150-250 słów
- Profesjonalne, ale zrozumiałe
- Skupione na praktycznych aspektach
- Bez niepotrzebnych detali prawnych

Format odpowiedzi: tylko tekst streszczenia, bez nagłówków sekcji.
```

**Prompt użytkownika (dla każdej decyzji):**

```text
Utwórz streszczenie następującej decyzji UODO:

Sygnatura: [sygnatura sprawy]
Tytuł: [tytuł decyzji]
Data wydania: [data]

Treść decyzji:
[pełna treść decyzji]
```

Dla każdej decyzji n8n automatycznie podstawia konkretne wartości. Model czyta, analizuje i wypluwa streszczenie zgodne z tym, czego od niego chcę. I działa naprawdę nieźle.

## Co dostaję na końcu?

Wszystkie streszczenia pakuję w jeden ładny raport HTML. Każda decyzja ma swoją sekcję z metadanymi, streszczeniem i linkiem do pełnej treści na stronie UODO. Dodałem trochę CSS-a, żeby nie wyglądało jak prosto z lat 90. Mail ląduje u mnie w skrzynce w każdy poniedziałek rano. Rano kawa, szybkie przejrzenie raportu i wiem, co się działo w UODO przez ostatni miesiąc.

## Co mi to daje?

Oszczędność czasu? Ogromna. Zamiast co tydzień sprawdzać portal UODO, dostaję gotowy raport. Streszczenia od razu pokazują, która decyzja jest ciekawa, a którą mogę spokojnie pominąć.

System chodzi sam, nie muszę o niczym pamiętać. Wszystko przetwarzam lokalnie, więc dane nie wychodzą na zewnątrz (a to zawsze dobry feeling, jak się pracuje z danymi osobowymi). Mogę sobie dostosować wszystko pod siebie: częstotliwość, okres monitoringu, styl streszczeń. Jak będę chciał, zmienię prompt i model zacznie pisać inaczej.

![Workflow n8n do cylicznego pobierania orzeczeń UODO i wysyłania streszczeń e-mailem](/media/2025-11-08/n8n-uodo-scrapper.webp)

## Na koniec

To rozwiązanie naprawdę działa. Automatyzacja plus lokalny LLM to połączenie, które w mojej codziennej pracy jako IOD sprawdza się wyśmienicie. Nie tracę czasu na rutynowe sprawdzanie portalu, a za to mam więcej czasu na rzeczy, które naprawdę wymagają mojej uwagi. Jeśli też jesteś IOD i spędzasz za dużo czasu na przeglądaniu decyzji UODO, to może warto coś takiego u siebie postawić? n8n jest darmowy, modele można odpalić lokalnie, a efekt naprawdę robi robotę.
