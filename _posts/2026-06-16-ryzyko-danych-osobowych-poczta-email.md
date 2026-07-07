---
title: "Poczta e-mail jako źródło ryzyka dla danych osobowych - czego uczy decyzja UODO (DKN.5131.34.2023)"
date: 2026-06-16T13:30:00.00Z
categories:
  - Poczta e-mail
tags:
  - Analiza ryzyka
  - Naruszenie danych
  - Bezpieczeństwo danych
  - RODO
  - Phishing
  - Przejęcie konta
  - Szyfrowanie poczty
  - Kara administracyjna
description: "Skrzynka e-mail to jeden z najpoważniejszych obszarów ryzyka dla danych osobowych. Analiza decyzji UODO (DKN.5131.34.2023), przykłady z innych krajów UE oraz aktualne metody ochrony poczty."
faq:
  - question: "Jaką karę nałożył UODO w decyzji DKN.5131.34.2023 dotyczącej poczty e-mail?"
    answer: "UODO nałożył na przedsiębiorcę prowadzącego działalność rachunkowo-księgową karę w wysokości 11 594 zł (ok. 2 760 euro) za brak analizy ryzyka dla poczty elektronicznej, brak adekwatnych zabezpieczeń technicznych i organizacyjnych oraz brak testowania i przeglądu tych zabezpieczeń, po tym jak nieuprawniony podmiot przejął konto e-mail pracownika z danymi klientów."
  - question: "Jakie nowe metody ochrony poczty e-mail warto wdrożyć oprócz 2FA?"
    answer: "Oprócz uwierzytelniania dwuskładnikowego warto wdrożyć uwierzytelnianie odporne na phishing (klucze FIDO2, passkeys), skonfigurować SPF, DKIM i DMARC w trybie egzekwowania (p=reject), włączyć MTA-STS wymuszające szyfrowanie transmisji TLS między serwerami oraz stosować zasady dostępu warunkowego i krótsze sesje logowania."
  - question: "Dlaczego pomyłka w polu CC zamiast BCC może być poważnym naruszeniem RODO?"
    answer: "Wpisanie adresów odbiorców w polu CC zamiast BCC ujawnia wszystkim adresatom listę pozostałych odbiorców. Jeśli lista dotyczy np. uczestników programu wsparcia dla osób z określonym schorzeniem, ujawnienie adresów (często zawierających imię i nazwisko) może zdradzić informację o stanie zdrowia tych osób, czyli dane szczególnej kategorii z art. 9 RODO - tak jak w przypadku kary brytyjskiego ICO dla Central YMCA."
---

**Poczta elektroniczna pozostaje najczęściej wykorzystywanym narzędziem komunikacji w organizacjach, a jednocześnie jednym z najsłabiej zabezpieczonych zbiorów danych osobowych. Skrzynka pocztowa przeciętnego pracownika to dziś nieuporządkowany, latami narastający zbiór zawierający imiona, nazwiska, numery PESEL, dane kontaktowe, skany dokumentów, a niejednokrotnie także dane szczególnej kategorii. Decyzja UODO o sygnaturze DKN.5131.34.2023 dobrze pokazuje, jak kosztowne bywa zlekceważenie tego obszaru.**

Kilka lat temu pisałem już o tym, [czym jest bezpieczna poczta e-mail]({% post_url 2022-01-07-bezpieczna-poczta-email %}). Od tamtego czasu zmieniło się sporo - zarówno po stronie zagrożeń, jak i dostępnych mechanizmów ochrony. Warto więc wrócić do tematu, tym razem od strony konkretnych rozstrzygnięć organów nadzorczych i realnych scenariuszy naruszeń.

## Decyzja UODO DKN.5131.34.2023 - przejęcie konta e-mail

Sprawa dotyczyła przedsiębiorcy prowadzącego działalność rachunkowo-księgową i doradztwo podatkowe. Na początku 2021 roku nieuprawniony podmiot uzyskał dostęp do konta poczty elektronicznej pracownika. W skrzynce przechowywane były dane osobowe klientów, pracowników oraz ich dzieci.

Zakres danych, które znalazły się w rękach osoby nieuprawnionej, był bardzo szeroki: imiona i nazwiska, daty urodzenia, numery PESEL, numery rachunków bankowych, adresy zamieszkania, numery telefonów, a także wizerunek oraz dokumenty takie jak paszporty i świadectwa pracy. Innymi słowy - komplet informacji wystarczający do kradzieży tożsamości czy oszustw finansowych.

### Co zarzucił administratorowi organ nadzorczy

UODO nie skupił się na samym fakcie włamania - te zdarzają się nawet w dobrze zabezpieczonych organizacjach. Istotą decyzji były **zaniedbania po stronie administratora**, które sprowadzały się do trzech kluczowych błędów:

1. **Brak analizy ryzyka.** Do listopada 2022 roku administrator w ogóle nie przeprowadził oceny zagrożeń związanych z przetwarzaniem danych w systemie poczty elektronicznej. Nie wiedział więc, jakie ryzyka wiążą się z tym kanałem i jakich zabezpieczeń potrzebuje.
2. **Brak adekwatnych środków technicznych i organizacyjnych.** W konsekwencji braku analizy nie wdrożono zabezpieczeń odpowiadających rzeczywistemu poziomowi ryzyka.
3. **Brak testowania i przeglądu zabezpieczeń.** Administrator nie testował regularnie, nie mierzył ani nie oceniał skuteczności wdrożonych rozwiązań.

Organ nałożył karę w wysokości **11 594 zł** (równowartość ok. 2 760 euro). Kwota nie jest wysoka, ale nie o nią tu chodzi. Istotny jest przekaz: **zarządzanie ryzykiem to proces ciągły, a odpowiedzialność za wdrożenie i monitorowanie zabezpieczeń spoczywa na administratorze niezależnie od tego, z jakich usług dostawców korzysta.** Nie można zasłaniać się tym, że pocztę „obsługuje zewnętrzny dostawca".

## To nie jest wyłącznie polski problem

Poczta e-mail jest źródłem naruszeń w całej Unii Europejskiej, a organy nadzorcze innych państw członkowskich publikują na ten temat obszerne wytyczne i decyzje. Warto spojrzeć na kilka wiarygodnych przykładów.

### Wielka Brytania - ICO i klasyczny błąd „CC zamiast BCC"

Brytyjski organ nadzorczy (ICO) od lat traktuje niewłaściwe adresowanie masowej korespondencji jako odrębną, powtarzalną kategorię incydentów. Między 2019 a 2025 rokiem zgłoszono do ICO **ponad 2 000 tego typu zdarzeń** - polegających na ujawnieniu adresów e-mail wszystkich odbiorców przez wpisanie ich w polu „Do" lub „DW" (CC) zamiast „UDW" (BCC).

Sztandarowym przykładem jest kara dla **Central YMCA w Londynie**. Pracownik wysłał zaproszenie do uczestników programu wsparcia dla osób żyjących z HIV, wpisując 264 adresy w polu CC zamiast BCC. Odbiorcy mogli wywnioskować, że osoby, których adresy (często zawierające imię i nazwisko) zostały ujawnione, prawdopodobnie żyją z HIV - a to oznacza ujawnienie **danych o stanie zdrowia**, czyli danych szczególnej kategorii z art. 9 RODO. Pierwotnie rekomendowano karę 300 000 funtów, ostatecznie obniżoną do **7 500 funtów** w ramach polityki ICO wobec podmiotów sektora non-profit i publicznego. Wniosek jest jednak jednoznaczny: prozaiczny błąd w polu adresata może stanowić naruszenie danych wrażliwych.

### Irlandia - DPC o „mail wraca do nadawcy"

Irlandzka Komisja Ochrony Danych (DPC) poświęciła temu problemowi osobne opracowanie („Return to Sender: Data Breaches and Email Correspondence"). Wskazuje w nim, że błędne zaadresowanie wiadomości (misdirected email) należy do **najczęściej zgłaszanych typów naruszeń** i zaleca konkretne środki: opóźnione wysyłanie wiadomości, ostrzeżenia przy adresatach zewnętrznych, wyłączenie autouzupełniania adresów oraz korzystanie z dedykowanych platform do masowej wysyłki zamiast zwykłego klienta pocztowego.

### Wspólny mianownik

Niezależnie od kraju powtarzają się te same wnioski: poczta e-mail jest kanałem podwyższonego ryzyka, a większość naruszeń wynika nie z zaawansowanych ataków, lecz z **braku procedur, zabezpieczeń technicznych i podstawowej analizy ryzyka**. Dokładnie to, co UODO zarzucił administratorowi w opisanej wyżej sprawie.

## Katalog realnych zagrożeń

Zbierając doświadczenia organów nadzorczych, ryzyka związane z pocztą e-mail można pogrupować następująco:

- **Przejęcie konta (account takeover)** - najczęściej w wyniku phishingu, wycieku hasła lub ataku na słabe uwierzytelnianie. Skutkuje dostępem do całej historii korespondencji.
- **Phishing i Business Email Compromise (BEC)** - podszywanie się pod znane adresy w celu wyłudzenia danych lub środków. Według raportu Verizon DBIR 2025 ataki typu „MFA fatigue" (zmęczenie powiadomieniami) pojawiają się w 14% analizowanych incydentów.
- **Błędne zaadresowanie** - wysyłka do niewłaściwej osoby lub ujawnienie listy odbiorców (CC/BCC).
- **Brak szyfrowania transmisji** - przechwycenie wiadomości w drodze między serwerami.
- **Nadmiarowe gromadzenie danych** - skrzynka jako nieuporządkowane, latami narastające archiwum danych osobowych, wbrew zasadzie minimalizacji i ograniczenia przechowywania.

## Co zmieniło się od czasu poprzedniego wpisu - nowe metody ochrony

W [poprzednim artykule]({% post_url 2022-01-07-bezpieczna-poczta-email %}) pisałem przede wszystkim o uwierzytelnianiu dwuskładnikowym, kluczach U2F (Yubikey) i szyfrowaniu PGP. Wszystko to pozostaje aktualne, ale w ostatnich latach standardem stały się kolejne rozwiązania, które warto dziś traktować jako minimum.

### Uwierzytelnianie odporne na phishing (FIDO2 / passkeys)

Kody SMS i aplikacje TOTP nadal można przechwycić w ataku phishingowym. Dlatego branża przechodzi na **uwierzytelnianie odporne na phishing**: klucze FIDO2 oraz **passkeys**. W odróżnieniu od kodów jednorazowych nie przekazują one żadnego „sekretu", który dałoby się przejąć - logowanie jest kryptograficznie powiązane z właściwą domeną. Dostęp do poczty administratorów, działu finansów i kont uprzywilejowanych powinien być zabezpieczony w pierwszej kolejności właśnie tak.

### DMARC, SPF i DKIM - obowiązkowy standard

Od 2024 roku Google, Microsoft i Yahoo **wymagają wdrożenia DMARC** od nadawców masowej korespondencji, a w 2026 roku jest to już powszechny standard. Poprawnie skonfigurowane SPF, DKIM oraz DMARC w trybie egzekwowania (`p=reject`) blokują podszywanie się pod domenę organizacji - a więc jeden z głównych wektorów phishingu i BEC.

### MTA-STS - wymuszone szyfrowanie transmisji

**MTA-STS** (Mail Transfer Agent Strict Transport Security) wymusza szyfrowaną transmisję TLS między serwerami pocztowymi i uniemożliwia „downgrade" połączenia do wersji nieszyfrowanej. To odpowiedź na ryzyko przechwycenia wiadomości w drodze między dostawcami.

### Zasady dostępu warunkowego i krótsze sesje

Nowoczesne środowiska (Microsoft 365, Google Workspace) pozwalają na **dostęp warunkowy**: weryfikację zgodności urządzenia, ograniczenia geograficzne oraz skracanie czasu życia sesji. Utrudnia to wykorzystanie skradzionych tokenów i plików cookie, które coraz częściej są celem ataków obchodzących MFA.

### Szyfrowanie treści i minimalizacja zawartości skrzynki

Warto rozważyć rozwiązania szyfrujące treść (S/MIME, PGP „out of the box", usługi typu ProtonMail dla korespondencji wymagającej szczególnej poufności), a przede wszystkim - **ograniczyć to, co w skrzynce w ogóle się gromadzi**. Dane szczególnej kategorii i skany dokumentów nie powinny bezterminowo zalegać w skrzynkach odbiorczych. Polityka retencji i przenoszenie danych do właściwych, zabezpieczonych systemów to element, o którym łatwo zapomnieć, a który znacząco obniża skutki ewentualnego naruszenia.

## Wnioski dla administratorów i IOD

Decyzja UODO oraz doświadczenia zagranicznych organów nadzorczych układają się w spójną listę zaleceń:

1. **Przeprowadź analizę ryzyka dla poczty e-mail** - to nie formalność, lecz podstawa doboru zabezpieczeń. Jej brak był głównym zarzutem w sprawie DKN.5131.34.2023.
2. **Wdróż uwierzytelnianie odporne na phishing** - klucze FIDO2 / passkeys tam, gdzie ryzyko jest najwyższe.
3. **Skonfiguruj SPF, DKIM, DMARC (`p=reject`) i MTA-STS** - to dziś standard, a nie opcja.
4. **Ogranicz i porządkuj dane w skrzynkach** - stosuj politykę retencji i zasadę minimalizacji.
5. **Zadbaj o procedury masowej wysyłki** - BCC, opóźnione wysyłanie, ostrzeżenia o adresatach zewnętrznych, dedykowane platformy mailingowe.
6. **Testuj i przeglądaj zabezpieczenia** - brak regularnej weryfikacji skuteczności również był przedmiotem zarzutu UODO.

Poczta e-mail to obszar, w którym najprostsze zaniedbania kosztują najwięcej. Jak przypomina UODO - **kto uzyska dostęp do skrzynki, uzyskuje dostęp do większości informacji o nas, naszej działalności oraz o osobach i podmiotach, z którymi się kontaktujemy.**

## Najczęściej zadawane pytania

{% include post-faq.html %}

---

**Źródła:**

- Decyzja UODO DKN.5131.34.2023: [orzeczenia.uodo.gov.pl](https://orzeczenia.uodo.gov.pl/document/urn:ndoc:gov:pl:uodo:2023:dkn_5131_34)
- ICO - kara dla Central YMCA za ujawnienie danych osób żyjących z HIV: [ico.org.uk](https://ico.org.uk/about-the-ico/media-centre/news-and-blogs/2024/04/information-commissioner-persistent-sensitive-information-breaches-failing-people-living-with-hiv/)
- Irish DPC - „Return to Sender: Data Breaches and Email Correspondence": [dataprotection.ie](https://www.dataprotection.ie/en/dpc-guidance/blogs/return-sender-data-breaches-and-email-correspondence)
- ICO - Personal data breaches: a guide: [ico.org.uk](https://ico.org.uk/for-organisations/report-a-breach/personal-data-breach/personal-data-breaches-a-guide/)
