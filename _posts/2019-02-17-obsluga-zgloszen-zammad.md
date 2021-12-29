---
title: Obsługa zgłoszeń w Zammad
date: "2019-02-17T16:14:37.31Z"
categories:
  - Narzędzia
tags:
  - "Zammad"
  - "Obsługa zgłoszeń"
  - "System wsparcia"
description: "W pracy Inspektora Ochrony Danych nieodzowne są odpowiednie narzędzia do zarządzania przepływem informacji. W mojej codziennej praktyce, obsługując kilku klientów i otrzymując zgłoszenia od kilkuset osób w miesiącu, trudno jest mi wyobrazić sobie aby sensownie zarządzać całą korespondencją bez zaawansowanego narzędzia do tego celu."
---

W pracy Inspektora Ochrony Danych nieodzowne są odpowiednie narzędzia do **zarządzania przepływem informacji**. W mojej codziennej praktyce, obsługując kilku klientów i otrzymując zgłoszenia od kilkuset osób w miesiącu, trudno jest mi wyobrazić sobie aby sensownie zarządzać całą korespondencją bez zaawansowanego narzędzia do tego celu.

Mając na uwadze zasadę **rozliczalności**, o której mówi art. 5 RODO, a także mając na uwadze ograniczony czas na podjęcie decyzji w przypadku **naruszenia** (art. 33 RODO), bardzo istotne jest odpowiednie zarządzanie zgłoszeniami spływającymi do Inspektora Ochrony Danych.

Od ponad roku wszystkie kanały komunikacji w mojej pracy Inspektora Ochrony Danych (a wcześniej ABI) są obsługiwane przez system obsługi zgłoszeń [**Zammad**](https://zammad.org). Ogólnie rzecz ujmując Zammad to system typu **helpdesk** z dużą liczbą konfigurowalnych opcji, który agreguje informacje spływające przez wiele kanałów, w tym telefon, poczta e-mail, chat, twitter i wiele innych.

![Przykładowy ekran Dashboard Zammad](/media/2019-02-17/zammad-dashboard.png)

Podstawą pracy z tego typu systemem jest zgłoszenie (**ticket**). Może to być nie tylko problem, ale też zapytanie, zgłoszenie błędu, a w praktyce – dowolna interakcja z użytkownikiem. Każde zgłoszenie otrzymuje swój unikalny numer oraz status. Osoba lub osoby obsługujące system mogą odpowiednio przypisywać zgłoszenia do osób odpowiedzialnych w zależności od typu zgłoszenia czy kompetencji.

![Przykładowy ekran Dashboard Ticket](/media/2019-02-17/zammad-ticket.png)

Szybki dostęp do zgłoszeń ułatwia w pełni konfigurowalny system kategoryzacji, nadawanie statusów, tagowanie, automatyzacja (triggers), a także narzędzie wspomagające wyszukiwanie **Elasticsearch**.

Kod źródłowy Zammad jest otwarty i można go stosować bez opłat ([github](https://github.com/zammad/zammad)). Wymagane jest posiadanie serwera VPS obsługującego cały system, a także instalacja, konfiguracja czy kopie bezpieczeństwa. Pomocna okazuje się rozbudowana dokumentacja ([docs.zammad.org](https://docs.zammad.org/en/latest/)). Można także skorzystać z pełnej opcji gotowej usługi w chmurze ([cennik](https://zammad.com/pricing)).