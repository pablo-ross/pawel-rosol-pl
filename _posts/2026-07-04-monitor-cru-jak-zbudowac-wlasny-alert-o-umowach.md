---
title: "Monitor CRU na Telegramie - jak zbudować własny alert o nowych umowach"
date: 2026-07-04T07:16:18.00Z
categories:
  - Jednostki samorządu terytorialnego
tags:
  - CRU
  - Centralny Rejestr Umów
  - API
  - Automatyzacja
  - Python
  - Telegram
  - Open Source
  - GitHub
  - Monitoring
  - rejestrumow.gov.pl
description: "Napisałem prosty monitor Centralnego Rejestru Umów (CRU), który sam przegląda rejestr i wysyła na Telegram powiadomienie, gdy pojawi się nowa umowa pasująca do moich filtrów (NIP, REGON, przedmiot umowy). Kod jest na GitHubie, na otwartej licencji. Pokazuję, jak to działa i jak uruchomić własną wersję."
faq:
  - question: "Co robi CRU Monitor i jak działa?"
    answer: "CRU Monitor to skrypt w Pythonie, który cyklicznie odpytuje publiczne API Centralnego Rejestru Umów, sprawdza, czy pojawiły się nowe umowy pasujące do zdefiniowanych filtrów (np. NIP, REGON, fraza z przedmiotu umowy), zapisuje je do pliku CSV i wysyła powiadomienie na Telegram."
  - question: "Gdzie znaleźć kod CRU Monitor i na jakiej licencji jest udostępniony?"
    answer: "Kod jest dostępny na GitHubie pod adresem github.com/pablo-ross/centralny-rejestr-umow-monitor na otwartej licencji - każdy może go pobrać, uruchomić u siebie i zmodyfikować pod własne potrzeby."
  - question: "Jak często CRU Monitor sprawdza rejestr i czy działa całą dobę?"
    answer: "Domyślnie program sprawdza rejestr co pół godziny, ale tylko w typowych godzinach pracy urzędów, czyli od poniedziałku do piątku, mniej więcej między 8 a 18. Skrypt automatycznie pomija weekendy i polskie święta, w tym ruchome, żeby niepotrzebnie nie odpytywać cudzego API."
---

Kilka dni temu [opisałem publiczne API do Centralnego Rejestru Umów]({% post_url 2026-07-01-publiczne-api-do-cru-centralny-rejestr-umow %}). Skoro dane da się pobrać jednym poleceniem, to naturalne pytanie brzmi: po co robić to ręcznie? Nie chcę codziennie wchodzić na `rejestrumow.gov.pl` i sprawdzać, czy interesujący mnie urząd albo kontrahent podpisał coś nowego. Wolę, żeby program zrobił to za mnie i dał mi znać, kiedy faktycznie jest co czytać.

Tak powstał **CRU Monitor** - mały skrypt, który co jakiś czas sam przegląda rejestr, wyłapuje umowy pasujące do moich filtrów i wysyła powiadomienie na Telegram. Kod wrzuciłem na GitHuba na otwartej licencji, więc każdy może go u siebie uruchomić, przerobić pod swoje potrzeby albo dorzucić coś od siebie.

> Repozytorium: [github.com/pablo-ross/centralny-rejestr-umow-monitor](https://github.com/pablo-ross/centralny-rejestr-umow-monitor)
{: .prompt-info }

## Co ten program właściwie robi

Pomysł jest banalnie prosty i sprowadza się do trzech kroków, które powtarzają się w kółko:

1. Odpytuje publiczne API CRU o umowy pasujące do zdefiniowanych filtrów.
2. Sprawdza, czy wśród nich jest coś, czego wcześniej nie widział.
3. Jeśli tak, zapisuje nową umowę do pliku CSV i wysyła powiadomienie na Telegram.

Filtry ustawiam sam. Mogę śledzić konkretny NIP (na przykład ministerstwa, urzędu, szpitala itd.), konkretny REGON, nazwę strony umowy albo frazę z przedmiotu umowy. W moim przypadku śledzę między innymi umowy, w których przedmiocie pojawia się „NIS2" albo „Cyberbezpieczny Samorząd", bo to tematy, którymi zajmuję się na co dzień. Kiedy jakiś urząd podpisze umowę na wdrożenie NIS2, dostaję o tym informację na Telegramie.

Powiadomienie na Telegramie wygląda mniej więcej tak:

```text
📄 Przedmiot umowy: NIS2 — nowe umowy: 1

Gmina Przykładowa
  Przedmiot: Wdrożenie wymogów dyrektywy NIS2
  Wartość: 48000 PLN
  Data zawarcia: 2026-07-03
```

Nic wyszukanego. Dokładnie tyle, ile potrzeba, żeby zdecydować, czy warto zajrzeć głębiej.

## Dlaczego akurat Telegram i CSV

Telegram wybrałem, bo postawienie bota zajmuje pięć minut i nie trzeba do tego żadnego serwera pocztowego ani zewnętrznej usługi. Piszesz do [@BotFather](https://t.me/BotFather), dostajesz token, i tyle. Powiadomienia lądują na telefonie od razu. Jeśli ktoś woli e-mail albo Slacka, podmiana tego fragmentu to kwestia jednego pliku. Wrócę do tego niżej.

CSV z kolei jest najnudniejszym formatem świata i właśnie o to chodzi. Każdy filtr ma swój plik, do którego dopisują się kolejne umowy. Otwierasz to w Excelu albo w LibreOffice, sortujesz po wartości, robisz sobie tabelę przestawną i już masz materiał do analizy. Bez bazy danych, bez kombinowania.

## Dwa drobiazgi, które okazały się ważne

Pisząc ten skrypt, wpadłem na kilka rzeczy, których nie było widać na pierwszy rzut oka. Opisuję je, bo jeśli będziesz budować coś podobnego, oszczędzą ci trochę nerwów.

**Program nie odpytuje API bez przerwy.** Za każdym razem pyta tylko o umowy zmienione od ostatniego udanego sprawdzenia (służy do tego parametr `dataZmianyOd` z API). Dzięki temu nie pobiera w kółko całego rejestru, tylko to, co faktycznie przybyło. Do tego dokłada niewielki zapas czasu, na wypadek gdyby jakaś umowa została opublikowana z opóźnieniem.

**Domyślnie sprawdza tylko w godzinach pracy urzędów.** Umowy do CRU trafiają wtedy, gdy ktoś w urzędzie siedzi przy komputerze, czyli od poniedziałku do piątku, mniej więcej między 8 a 18. Nie ma sensu odpytywać API o trzeciej w nocy ani w niedzielę. Skrypt sam pomija weekendy i polskie święta (łącznie z ruchomymi, jak Poniedziałek Wielkanocny czy Boże Ciało). To zwykła uprzejmość wobec cudzego serwera, a przy okazji mniejsze ryzyko, że nas zablokuje.

Jest jeszcze trzecia rzecz, o której warto pamiętać. To API jest nieoficjalne i nieudokumentowane, o czym pisałem w poprzednim wpisie. Jeśli więc pewnego dnia powiadomienia przestaną przychodzić, pierwsze podejrzenie powinno paść na to, że Ministerstwo coś w tym API zmieniło. Taki urok budowania na czymś, czego nikt oficjalnie nie obiecał.

## Jak to uruchomić u siebie

Nie trzeba być programistą. Wystarczy umieć skopiować kilka poleceń do terminala i zmienić parę linijek w pliku konfiguracyjnym. Zakładam, że masz Pythona (wersja 3) i Gita.

Najpierw pobierasz kod i instalujesz zależności:

```bash
git clone https://github.com/pablo-ross/centralny-rejestr-umow-monitor.git
cd centralny-rejestr-umow-monitor
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

Potem kopiujesz dwa pliki z przykładami i dostosowujesz je do siebie:

```bash
cp config.ini.example config.ini
cp filters.yaml.example filters.yaml
```

W `config.ini` wpisujesz token swojego bota Telegram oraz swój identyfikator czatu (w repozytorium jest krótka instrukcja, jak jedno i drugie zdobyć). W `filters.yaml` definiujesz, czego szukasz. Plik jest czytelny i wygląda tak:

```yaml
filters:
  - name: przedmiot_nis2
    label: "Przedmiot umowy: NIS2"
    criteria:
      przedmiotUmowy: "NIS2"

  - name: kontrahent_acme
    label: "Umowy firmy ACME"
    criteria:
      nip: "1234567890"
```

Każdy filtr ma swoją nazwę, etykietę (to ona pojawia się w powiadomieniu) i kryteria. Kryteria w obrębie jednego filtra łączą się przez „i" (możesz na przykład szukać umów danego NIP-u dotyczących akurat NIS2), a różne filtry działają niezależnie. Możesz mieć ich tyle, ile chcesz.

Na koniec odpalasz pierwsze, próbne sprawdzenie:

```bash
python periodic_checker.py --once --verbose
```

Jeśli wszystko gra, uruchamiasz program na stałe. Będzie sprawdzał rejestr co pół godziny:

```bash
python periodic_checker.py
```

Na serwerze najwygodniej zostawić to jako usługę systemd albo wpis w cronie. Oba warianty są opisane w README. Wtedy monitor chodzi sobie w tle i odzywa się tylko wtedy, gdy naprawdę ma coś do powiedzenia.

## To jest otwarte i chętnie przyjmę pomoc

Wrzuciłem ten projekt na GitHuba nie po to, żeby się pochwalić, tylko dlatego, że sam korzystam z cudzych narzędzi i wypada się zrewanżować. Jeśli ci się przyda, bierz i używaj.

A jeśli czegoś w nim brakuje, tu zaczyna się najfajniejsza część open source. Może chciałbyś powiadomienia na e-mail zamiast na Telegram? Eksport do arkusza Google zamiast CSV? Filtrowanie po wartości umowy, żeby drobne zakupy nie zaśmiecały powiadomień? Każda z tych rzeczy to zmiana w jednym, małym kawałku kodu.

Możesz to zrobić na dwa sposoby:

- **Masz pomysł albo znalazłeś błąd?** Załóż [zgłoszenie (issue)](https://github.com/pablo-ross/centralny-rejestr-umow-monitor/issues). Nie musisz umieć programować. Wystarczy, że opiszesz, co nie działa albo czego byś potrzebował. Sam opis problemu jest już dużą pomocą.
- **Potrafisz coś dorzucić?** Prześlij Pull Request. Do kodu dołączyłem testy, więc łatwo sprawdzić, czy zmiana niczego nie psuje.

Nie obiecuję, że przyklepię każdą propozycję, bo chcę, żeby to narzędzie zostało proste. Ale każde sensowne zgłoszenie przeczytam i na każde odpowiem.

## Po co mi to wszystko jako IOD

Wracam do myśli z poprzedniego wpisu. Dane publiczne najbardziej cieszą wtedy, gdy można je pobrać jednym poleceniem, i jeszcze bardziej, gdy nie trzeba pobierać ich samemu. Podobnie [zautomatyzowałem sobie kiedyś monitoring decyzji UODO]({% post_url 2025-11-08-automatyzacja-monitoring-uodo %}). Zasada jest ta sama: nudną, powtarzalną robotę oddaj maszynie, a sobie zostaw myślenie.

Zostaje jedno przypomnienie, o którym pisałem poprzednio i które powtórzę, bo jest ważne. W rejestrze siedzą też dane osobowe, choćby imiona i nazwiska osób fizycznych będących stronami umów. Automat, który masowo zbiera takie dane, przetwarza dane osobowe, i musi mieć do tego konkretny, uzasadniony cel. Śledzenie, jak wydawane są publiczne pieniądze, taki cel spełnia. Budowanie sobie prywatnej bazy o konkretnych ludziach już niekoniecznie. Warto mieć to z tyłu głowy, zanim odpali się pierwsze filtry.

## Najczęściej zadawane pytania

{% include post-faq.html %}
