---
title: "Publiczne API do CRU (Centralny Rejestr Umów) - jak pobrać dane automatycznie?"
date: 2026-07-01T10:30:00.00Z
categories:
  - Jednostki samorządu terytorialnego
tags:
  - CRU
  - Centralny Rejestr Umów
  - API
  - Otwarte dane
  - Jawność
  - REST
  - JSON
  - curl
  - rejestrumow.gov.pl
description: "Od 1 lipca 2026 r. działa Centralny Rejestr Umów (CRU). Sprawdziłem, jak wygląda publiczne API do CRU na rejestrumow.gov.pl - jest dostępny endpoint JSON, z którego można pobrać dane bez logowania. Pokazuję gotowe przykłady w curl oraz drugie, oficjalne API Ministerstwa Finansów z autoryzacją X-API-KEY."
---

Od 1 lipca 2026 r. tysiące urzędów mają obowiązek publikować swoje umowy w [Centralnym Rejestrze Umów](https://rejestrumow.gov.pl/). Sieć Obywatelska Watchdog Polska od miesięcy apeluje o to, żeby dane były dostępne przez **publiczne API**, a nie tylko do ręcznego przeglądania po jednej umowie. I słusznie - z klikania po pojedynczych rekordach nikt nie zrobi żadnej analizy.

Postanowiłem sprawdzić, jak to naprawdę wygląda pod maską. Okazało się, że **publiczne API do CRU już istnieje** - tylko nikt o nim głośno nie mówi. Poniżej pokazuję, jak z niego skorzystać, oraz jak wygląda drugie, oficjalne API Ministerstwa Finansów.

## Co to jest CRU i dlaczego nagle wszyscy o nim mówią

W dużym skrócie: [od 1 lipca 2026 r. do rejestru trafiają wszystkie umowy](https://www.prawo.pl/samorzad/cru-od-1-lipca-wszystkie-umowy-do-rejestru,1547632.html) zawierane przez jednostki sektora finansów publicznych. Kilka faktów, które warto znać:

- Obowiązek dotyczy **ponad 65 tysięcy jednostek** - od ministerstw, przez samorządy, po szkoły i szpitale.
- **Nie ma progu kwotowego.** Do rejestru idzie zarówno umowa za milion, jak i za kilkaset złotych (o ile ma formę pisemną, elektroniczną lub dokumentową - zakupy „w sklepie" na słowo są wyłączone).
- Umowę trzeba opublikować **w ciągu 30 dni** od jej zawarcia lub od zmiany danych.
- Publiczne przeglądanie działa pod adresem [rejestrumow.gov.pl](https://rejestrumow.gov.pl/) - na razie pojawiają się w nim tylko umowy zawarte od 1 lipca.

To potencjalnie ogromna baza danych o wydatkach publicznych. Pytanie tylko, jak się do niej dostać w sposób, który pozwoli cokolwiek policzyć.

## Dlaczego samo przeglądanie to za mało

[Sieć Obywatelska Watchdog Polska i Instytut Finansów Publicznych zwracają uwagę](https://siecobywatelska.pl/cru-i-otwarte-api/) na rzecz oczywistą: rejestr, w którym można tylko ręcznie wyszukać pojedynczą umowę, **nie pozwala porównać instytucji ani prześledzić wydatków w czasie**. Żeby obywatelska kontrola miała sens, dane muszą być:

- dostępne masowo (hurtowo, a nie po jednym rekordzie),
- w otwartych formatach do maszynowego przetwarzania (CSV, JSON, XML),
- z pełną historią zmian każdej umowy.

Pod petycją #TAKdlaCRU podpisało się ponad 1250 osób. Postulat jest prosty: **dajcie publiczne API**.

I tu zaczyna się ciekawa część.

## Publiczne API do CRU już działa (choć nieoficjalnie)

Strona `rejestrumow.gov.pl` to aplikacja napisana w Angular. A takie aplikacje nie mają danych „w sobie" - pobierają je z jakiegoś API w tle. Wystarczyło otworzyć narzędzia deweloperskie w przeglądarce (klawisz `F12`, zakładka *Network*), żeby zobaczyć, skąd strona bierze umowy.

Odpowiedź: z endpointu JSON pod adresem `rejestrumow.gov.pl/api-dp/v1/...`. **Nie wymaga on żadnego logowania ani klucza.** Można z niego korzystać zwykłym `curl`-em z terminala albo dowolnym językiem programowania.

### Jak pobrać listę umów

Najważniejsza pułapka: wyszukiwarka umów działa metodą **POST**, a nie GET. Jeśli spróbujesz wejść na ten adres zwykłym GET-em, dostaniesz błąd `401`. Trzeba wysłać żądanie POST z ciałem w formacie JSON (na początek wystarczy puste `{}`):

```bash
curl -s -X POST \
  'https://rejestrumow.gov.pl/api-dp/v1/agreements/search?offset=0&limit=10' \
  -H 'Content-Type: application/json' \
  -d '{}'
```

W odpowiedzi dostajemy listę umów w JSON-ie. Każda umowa to m.in.: identyfikator (`idUmowy`), nazwa jednostki (`nazwa`), REGON, data zawarcia, wartość przedmiotu umowy i jej przedmiot. Do stronicowania służą parametry `offset` (od którego rekordu) i `limit` (ile rekordów naraz).

### Jak filtrować wyniki (np. po REGON-ie)

Tu jest druga pułapka, na którą sam się na początku nabrałem. Filtry **działają**, ale nie można ich wysyłać jako pól najwyższego poziomu w ciele żądania. Jeśli wyślesz `{"regon": "001262860"}`, API zignoruje filtr i zwróci wszystkie umowy. Kryteria trzeba zagnieździć w obiekcie `menuGlowne`:

```bash
curl -s -X POST \
  'https://rejestrumow.gov.pl/api-dp/v1/agreements/search?offset=0&limit=10' \
  -H 'Content-Type: application/json' \
  -d '{"menuGlowne": {"regon": "001262860"}}'
```

Tak zbudowane żądanie zwraca już tylko umowy danej jednostki (u mnie dla REGON-u `001262860` - jedną umowę zamiast całego kompletu). To dokładnie ten sam sposób, w jaki filtruje oficjalna wyszukiwarka na stronie - wystarczyło podejrzeć jej żądanie w zakładce *Network*.

### Jak pobrać szczegóły jednej umowy

Mając `idUmowy` z listy, pełne szczegóły umowy pobieramy zwykłym GET-em:

```bash
curl -s \
  'https://rejestrumow.gov.pl/api-dp/v1/agreement/TU-WSTAW-IDUMOWY'
```

Tutaj dostajemy już komplet: strony umowy, okres obowiązywania, wartość, podstawę prawną ewentualnych wyłączeń jawności i tak dalej.

### Jedno ważne zastrzeżenie

To nieudokumentowany endpoint. Skoro nie jest oficjalnie opisany, nikt nie obiecuje, że jutro będzie działał tak samo - Ministerstwo może w każdej chwili zmienić strukturę żądania (choćby nazwę `menuGlowne`) albo cały endpoint przebudować. Jeśli więc oprzesz na nim jakiś skrypt czy analizę, licz się z tym, że trzeba go będzie od czasu do czasu poprawić.

## Drugie, oficjalne API - z autoryzacją X-API-KEY

Powyższe API służy do **czytania** danych publicznych. Ale Ministerstwo Finansów udostępniło też [oficjalne, udokumentowane API integracyjne](https://www.gov.pl/web/finanse/ministerstwo-finansow-udostepnia-api-do-systemu-centralny-rejestr-umow-jsfp) - przeznaczone dla jednostek i firm, które chcą **automatycznie publikować** umowy ze swoich systemów (np. z systemu obiegu dokumentów), zamiast wklepywać je ręcznie.

To zupełnie inny serwer i inne zasady:

- **Środowisko testowe:** `https://jsfp-cru-test.mf.gov.pl`
- **Dokumentacja:** `https://jsfp-cru-test.mf.gov.pl/api-gw/docs/int/api.html`
- **Autoryzacja:** klucz przekazywany w nagłówku `X-API-KEY`.

Najważniejsze funkcje tego API to: publikacja i aktualizacja umów, wycofywanie umów z publikacji, pobieranie szczegółów umowy oraz listy streszczeń i statusów wgranych dokumentów. Lista streszczeń (`/v1/api/publish/summary`) pozwala już filtrować po numerze umowy, przedmiocie i zakresie dat.

Żeby dostać klucz do środowiska testowego, trzeba napisać do Ministerstwa i podać REGON, nazwę integrowanego systemu oraz szacowaną liczbę użytkowników:

- integratorzy zewnętrzni → `pomoc.cru@mf.gov.pl`
- jednostki sektora finansów publicznych → `wsparcie.cru.jsfp@mf.gov.pl`

## Które API wybrać

Zasada jest prosta:

- **Chcesz tylko czytać i analizować publiczne dane o umowach?** Użyj pierwszego API (`rejestrumow.gov.pl/api-dp/v1`). Nie potrzebujesz żadnego klucza, działa od ręki - pamiętaj tylko o metodzie POST przy wyszukiwaniu i o tym, że filtry trzeba zagnieżdżać w obiekcie `menuGlowne`.
- **Chcesz automatycznie wysyłać umowy swojej jednostki do rejestru?** Załatw klucz `X-API-KEY` i korzystaj z oficjalnego API integracyjnego.

## Moje trzy grosze jako IOD

Cieszy mnie, że publiczny endpoint w ogóle jest - to znaczy, że dane da się pobrać maszynowo, a nie tylko przeklikać. To dokładnie ta „obywatelska kontrola", o którą upomina się Watchdog. Podobnie zresztą [zautomatyzowałem sobie kiedyś monitoring decyzji UODO]({% post_url 2025-11-08-automatyzacja-monitoring-uodo %}) - dane publiczne najbardziej cieszą wtedy, gdy można je pobrać jednym poleceniem.

Mam jednak dwa zastrzeżenia. Po pierwsze - to nieoficjalny, nieudokumentowany endpoint. Skoro nie jest opisany, nikt nie obiecuje, że jutro będzie działał tak samo. Dopóki Ministerstwo nie opublikuje **oficjalnego, stabilnego, publicznego API z otwartymi danymi** (najlepiej wpiętego w [dane.gov.pl](https://dane.gov.pl)), postulat Sieci Obywatelskiej pozostaje aktualny.

Po drugie - pamiętajmy, że w rejestrze lądują też **dane osobowe** (np. imiona i nazwiska osób fizycznych będących stronami umów). Jawność finansów publicznych i RODO nie są ze sobą sprzeczne, ale masowe pobieranie takich danych to już przetwarzanie, które trzeba robić z głową i w konkretnym, uzasadnionym celu. O tym jednak napiszę osobno.

*A jeśli sam bawisz się API do CRU i zauważysz, że coś działa inaczej niż opisałem - daj znać, zaktualizuję wpis.*
