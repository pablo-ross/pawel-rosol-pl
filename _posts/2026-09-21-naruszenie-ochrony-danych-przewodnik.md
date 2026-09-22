---
title: "Naruszenie ochrony danych osobowych - przewodnik dla administratora"
date: 2026-09-21T12:00:00.00Z
pin: true
categories:
  - Urząd Ochrony Danych Osobowych
tags:
  - Naruszenie ochrony danych
  - Zgłoszenie naruszenia
  - RODO
  - UODO
  - Administrator danych
  - Analiza ryzyka
  - Dokumentacja RODO
description: "Kiedy zaczynają biec 72 godziny, czy trzeba zgłosić naruszenie do UODO, kiedy zawiadomić osoby, co musi zawierać zgłoszenie i jak wygląda rejestr naruszeń. Przewodnik dla administratora, z odwołaniami do decyzji UODO."
legal: true
faq:
  - question: "Od kiedy liczy się 72 godziny na zgłoszenie naruszenia do UODO?"
    answer: "Od stwierdzenia naruszenia, a nie od jego wystąpienia. Administrator stwierdza naruszenie wtedy, gdy ma wystarczający stopień pewności, że doszło do zdarzenia dotyczącego bezpieczeństwa danych osobowych. Krótka weryfikacja sygnału mieści się w tym pojęciu, ale odwlekanie jej nie zatrzymuje biegu terminu. Zgłoszenie po 72 godzinach jest dopuszczalne, trzeba jednak dołączyć wyjaśnienie przyczyn opóźnienia (art. 33 ust. 1 RODO)."
  - question: "Czy każde naruszenie ochrony danych trzeba zgłosić do UODO?"
    answer: "Nie. Zgłoszenia nie wymaga naruszenie, co do którego jest mało prawdopodobne, by skutkowało ryzykiem naruszenia praw lub wolności osób fizycznych. Ocenę tę przeprowadza i dokumentuje administrator. Decyzja o niezgłaszaniu nie zwalnia z obowiązku wpisania zdarzenia do wewnętrznego rejestru naruszeń z art. 33 ust. 5 RODO."
  - question: "Kiedy trzeba zawiadomić osoby, których dane dotyczą?"
    answer: "Gdy naruszenie może powodować wysokie ryzyko naruszenia praw lub wolności tych osób (art. 34 ust. 1 RODO). RODO przewiduje trzy sytuacje, w których zawiadomienie nie jest wymagane: dane były zabezpieczone środkami uniemożliwiającymi odczyt, na przykład szyfrowaniem; administrator zastosował później środki eliminujące prawdopodobieństwo wysokiego ryzyka; albo zawiadomienie indywidualne wymagałoby niewspółmiernie dużego wysiłku, co zastępuje się publicznym komunikatem."
  - question: "Co zrobić, gdy naruszenie wystąpiło u dostawcy systemu?"
    answer: "Obowiązki wobec UODO i wobec osób pozostają przy administratorze. Podmiot przetwarzający zgłasza naruszenie administratorowi bez zbędnej zwłoki (art. 33 ust. 2 RODO), a administrator ocenia ryzyko i decyduje o zgłoszeniu. Warto wystąpić do dostawcy o pisemne potwierdzenie, czy naruszenie objęło dane tego konkretnego administratora; podstawę daje art. 28 ust. 3 lit. f RODO."
  - question: "Czy samo wystąpienie naruszenia oznacza karę od UODO?"
    answer: "Nie. Samo wystąpienie naruszenia nie stanowi naruszenia przepisów RODO. Karane jest niewykonanie obowiązków, które się z naruszeniem wiążą: brak adekwatnych zabezpieczeń dobranych na podstawie analizy ryzyka, brak zgłoszenia, brak zawiadomienia osób lub brak dokumentacji. W decyzjach UODO kara pada zwykle za to, co poprzedzało incydent, a nie za sam incydent."
  - question: "Czy zgłoszenie do CSIRT zastępuje zgłoszenie do UODO?"
    answer: "Nie. To dwa niezależne obowiązki wynikające z różnych ustaw, o różnych terminach i różnym zakresie. Podmiot kluczowy lub ważny w rozumieniu ustawy o krajowym systemie cyberbezpieczeństwa zgłasza incydent do właściwego CSIRT, a jako administrator danych osobowych zgłasza naruszenie do UODO. Jedno zdarzenie może uruchomić oba tryby naraz."
sources:
  - name: "Rozporządzenie (UE) 2016/679 (RODO)"
    url: https://eur-lex.europa.eu/eli/reg/2016/679/oj
  - name: "Poradnik UODO dotyczący naruszeń ochrony danych osobowych"
    url: https://uodo.gov.pl/pl/file/5686
  - name: "UODO: W jaki sposób zgłosić Prezesowi UODO naruszenie ochrony danych osobowych"
    url: https://uodo.gov.pl/pl/525/2582
  - name: "Ustawa z 5 lipca 2018 r. o krajowym systemie cyberbezpieczeństwa"
    url: https://eli.gov.pl/eli/DU/2018/1560/ogl
  - name: "Ustawa z 23 stycznia 2026 r. o zmianie ustawy o krajowym systemie cyberbezpieczeństwa (Dz.U. 2026 poz. 252)"
    url: https://eli.gov.pl/eli/DU/2026/252/ogl
  - name: "Dyrektywa (UE) 2022/2555 (NIS2)"
    url: https://eur-lex.europa.eu/eli/dir/2022/2555/oj
---

> **W skrócie:** 72 godziny liczą się od **stwierdzenia** naruszenia, nie od jego wystąpienia. Zgłoszenie do UODO jest obowiązkowe zawsze, gdy nie da się uznać za mało prawdopodobne, że naruszenie będzie skutkować ryzykiem dla osób. Zawiadomienie samych osób jest obowiązkowe dopiero przy **wysokim** ryzyku. Każde naruszenie, także to niezgłoszone, trafia do wewnętrznego rejestru z art. 33 ust. 5 RODO. UODO w swoich decyzjach karze nie za incydent, tylko za brak analizy ryzyka, zabezpieczeń, zgłoszenia lub dokumentacji.
{: .prompt-info }

Ten wpis zbiera w jednym miejscu to, o co najczęściej pytają mnie administratorzy w pierwszych godzinach po incydencie. Kolejne sekcje odsyłają do konkretnych decyzji UODO, w których dany obowiązek został przez organ zbadany.

Podstawa prawna: [rozporządzenie 2016/679 (RODO)](https://eur-lex.europa.eu/eli/reg/2016/679/oj), przede wszystkim art. 4 pkt 12 oraz art. 33 i 34. Dwa dokumenty, które warto mieć pod ręką, to [poradnik UODO dotyczący naruszeń](https://uodo.gov.pl/pl/file/5686) oraz [wytyczne EDPB 9/2022](https://www.edpb.europa.eu/documents/guideline/guidelines-92022-on-personal-data-breach-notification-under-gdpr_en) w wersji 2.0 z marca 2023 r.

## Czym jest naruszenie ochrony danych osobowych?

Art. 4 pkt 12 RODO definiuje je jako naruszenie bezpieczeństwa prowadzące do przypadkowego lub niezgodnego z prawem zniszczenia, utracenia, zmodyfikowania, nieuprawnionego ujawnienia lub nieuprawnionego dostępu do danych osobowych. Definicja obejmuje więc znacznie więcej niż wyciek.

| Typ naruszenia | Na czym polega | Przykład z decyzji lub sprawy |
|---|---|---|
| Poufności | Nieuprawnione ujawnienie danych albo dostęp do nich | [Plik z danymi o kwarantannie zaindeksowany przez wyszukiwarkę]({% post_url 2026-07-07-decyzja-uodo-ops-dane-o-kwarantannie %}) |
| Integralności | Nieuprawniona zmiana danych | Modyfikacja rekordów przez osobę, która przejęła konto |
| Dostępności | Utrata dostępu do danych lub ich zniszczenie | [Atak ransomware na spółkę komunalną]({% post_url 2024-12-06-atak-mpk-krakow %}) |

Utrata dostępu też jest naruszeniem. To najczęściej pomijana część definicji: zaszyfrowanie serwera przez ransomware jest naruszeniem nawet wtedy, gdy nic nie wypłynęło na zewnątrz, a kopia zapasowa pozwoliła odtworzyć dane po dwóch dniach.

## Od kiedy liczy się 72 godziny?

Od **stwierdzenia** naruszenia. Administrator stwierdza naruszenie wtedy, gdy ma wystarczający stopień pewności, że doszło do zdarzenia dotyczącego bezpieczeństwa danych osobowych. Nie musi wtedy znać jeszcze skali ani listy poszkodowanych.

Z tego wynikają dwie rzeczy, które w praktyce sprawiają najwięcej kłopotu.

Pierwsza: krótka weryfikacja sygnału mieści się w pojęciu stwierdzenia, ale zwlekanie z nią nie zatrzymuje biegu terminu. Jeżeli zgłoszenie od pracownika leży trzy dni w skrzynce, zegar i tak ruszył wtedy, gdy przy zachowaniu należytej staranności można było zdarzenie potwierdzić.

Druga: zgłoszenie po 72 godzinach nie jest niedopuszczalne. Art. 33 ust. 1 RODO wymaga wtedy dołączenia wyjaśnienia przyczyn opóźnienia. Spóźnione zgłoszenie z wyjaśnieniem jest lepsze niż brak zgłoszenia.

Nie trzeba też czekać z zgłoszeniem na komplet informacji. Art. 33 ust. 4 pozwala udzielać ich sukcesywnie, bez zbędnej zwłoki.

## Czy to naruszenie trzeba zgłosić do UODO?

Obowiązek zgłoszenia jest regułą, a jego brak wyjątkiem. Art. 33 ust. 1 RODO zwalnia ze zgłoszenia wtedy, gdy jest **mało prawdopodobne**, by naruszenie skutkowało ryzykiem naruszenia praw lub wolności osób fizycznych. Ciężar tej oceny i jej udokumentowania spoczywa na administratorze.

W ocenie ryzyka liczą się przede wszystkim: rodzaj naruszenia, charakter i wrażliwość danych, łatwość identyfikacji osób, waga możliwych skutków, szczególne cechy osób, których dane dotyczą, oraz ich liczba. Dane o stanie zdrowia, numer PESEL w komplecie z innymi danymi identyfikacyjnymi czy dane dzieci przesuwają ocenę w górę niemal automatycznie.

Dwie sytuacje, w których administratorzy najczęściej mylą się w tę samą stronę:

Zaszyfrowany nośnik. Utrata laptopa z prawidłowo zaszyfrowanym dyskiem zwykle nie rodzi ryzyka dla osób. Utrata takiego samego laptopa bez szyfrowania jest zupełnie inną sprawą, co pokazuje [decyzja DKN.5131.9.2024]({% post_url 2024-11-13-decyzja-uodo %}) i kara 24 555 zł.

Naruszenie „wewnętrzne". Wysłanie listy pracowników do niewłaściwego adresata wewnątrz organizacji bywa traktowane jako drobiazg. Kryterium nie jest jednak to, czy odbiorca był obcy, tylko czy dostęp był nieuprawniony i jakie dane obejmował.

## Kiedy trzeba zawiadomić osoby, których dane dotyczą?

Próg jest wyższy niż przy zgłoszeniu do organu: art. 34 ust. 1 RODO wymaga zawiadomienia, gdy naruszenie może powodować **wysokie** ryzyko naruszenia praw lub wolności osób. Zawiadomienie ma być sformułowane jasnym i prostym językiem i zawierać opis charakteru naruszenia oraz te same informacje, które trafiają do organu w zakresie punktu kontaktowego, możliwych konsekwencji i podjętych środków.

Art. 34 ust. 3 przewiduje trzy sytuacje, w których zawiadomienie nie jest wymagane:

1. administrator wdrożył środki ochrony uniemożliwiające odczyt danych, w szczególności szyfrowanie, i zastosował je do danych objętych naruszeniem;
2. administrator zastosował następnie środki, które eliminują prawdopodobieństwo wysokiego ryzyka;
3. zawiadomienie indywidualne wymagałoby niewspółmiernie dużego wysiłku, co zastępuje się publicznym komunikatem lub podobnym środkiem o porównywalnej skuteczności.

Trzeci wyjątek bywa nadużywany. „Mamy dużo klientów" nie jest niewspółmiernie dużym wysiłkiem, jeżeli organizacja ma ich adresy e-mail i wysyła do nich newsletter. Prezes UODO może zresztą nakazać zawiadomienie, jeżeli uzna, że administrator ocenił ryzyko za nisko (art. 34 ust. 4).

## Co musi zawierać zgłoszenie i jak je złożyć?

Art. 33 ust. 3 RODO wymienia cztery elementy:

1. charakter naruszenia, w tym kategorie i przybliżoną liczbę osób oraz wpisów danych, których dotyczy;
2. imię i nazwisko oraz dane kontaktowe inspektora ochrony danych lub innego punktu kontaktowego;
3. możliwe konsekwencje naruszenia;
4. środki zastosowane lub proponowane w celu zaradzenia naruszeniu, w tym minimalizacji jego negatywnych skutków.

Zgłoszenia dokonuje się przez [dedykowany formularz elektroniczny na biznes.gov.pl](https://www.biznes.gov.pl/pl/portal/ou889), podpisany kwalifikowanym podpisem elektronicznym albo profilem zaufanym. UODO opisuje tę ścieżkę na stronie [W jaki sposób zgłosić Prezesowi UODO naruszenie ochrony danych osobowych](https://uodo.gov.pl/pl/525/2582).

Punkt kontaktowy z punktu 2 to w praktyce test, czy organizacja ma IOD i czy jego dane są aktualne. Warto sprawdzić to przed incydentem, a nie w siedemdziesiątej godzinie.

## Co, gdy naruszenie wystąpiło u dostawcy?

Powierzenie przetwarzania nie przenosi obowiązków. Podmiot przetwarzający zgłasza naruszenie administratorowi bez zbędnej zwłoki (art. 33 ust. 2 RODO), ale to administrator ocenia ryzyko, zgłasza do UODO i zawiadamia osoby.

Dwie rzeczy, które trzeba zrobić od razu. Po pierwsze, wystąpić do dostawcy o pisemne potwierdzenie, czy naruszenie objęło dane tej konkretnej organizacji i w jakim zakresie; podstawę daje art. 28 ust. 3 lit. f RODO. Po drugie, sprawdzić w umowie powierzenia, w jakim terminie dostawca miał obowiązek poinformować i czy dopuszczalne były podpowierzenia.

Jak wygląda to w skali, widać na przykładzie [wycieku danych z systemu MyDr]({% post_url 2026-09-21-wyciek-danych-mydr-obowiazki-placowek-rodo %}), gdzie jedno włamanie u dostawcy przełożyło się na obowiązki tysięcy niezależnych administratorów. Jak organ ocenia wybór i nadzór nad procesorem, pokazuje z kolei [decyzja wobec McDonald's Polska]({% post_url 2025-07-28-kara-mcdonalds %}), w której kara spadła i na administratora, i na podmiot przetwarzający.

## Dwa zegary: UODO i CSIRT

Jeżeli organizacja jest podmiotem kluczowym albo ważnym w rozumieniu [ustawy o krajowym systemie cyberbezpieczeństwa](https://eli.gov.pl/eli/DU/2018/1560/ogl), znowelizowanej [ustawą z 23 stycznia 2026 r.](https://eli.gov.pl/eli/DU/2026/252/ogl) wdrażającą [dyrektywę NIS2](https://eur-lex.europa.eu/eli/dir/2022/2555/oj), jeden incydent uruchamia dwa niezależne tryby.

| | RODO (UODO) | Ustawa o KSC (CSIRT) |
|---|---|---|
| Co zgłaszasz | Naruszenie ochrony danych osobowych | Incydent dotyczący świadczonej usługi |
| Kto zgłasza | Administrator danych | Podmiot kluczowy lub ważny |
| Pierwszy termin | 72 h od stwierdzenia | Wczesne ostrzeżenie w 24 h |
| Kolejne terminy | Informacje sukcesywnie (art. 33 ust. 4) | Zgłoszenie w 72 h, sprawozdanie końcowe w ciągu miesiąca |
| Zawiadomienie osób | Przy wysokim ryzyku (art. 34) | Odbiorcy usługi, gdy incydent na nich wpływa |

Jedno zgłoszenie nie zastępuje drugiego. Zdarzenie może być incydentem bez naruszenia danych osobowych, naruszeniem bez wpływu na usługę, albo jednym i drugim naraz. O tym, jak później odpowiadać na wnioski o dokumenty dotyczące takiego zdarzenia, piszę w osobnym wpisie o [udostępnianiu informacji po incydencie]({% post_url 2025-10-21-udostepnianie-informacji %}).

## Rejestr naruszeń, czyli to, o czym zapomina się najczęściej

Art. 33 ust. 5 RODO nakazuje dokumentować **wszelkie** naruszenia: okoliczności, skutki i podjęte działania zaradcze. Wszelkie, a więc także te, których administrator świadomie nie zgłosił, bo uznał ryzyko za mało prawdopodobne.

Rejestr pełni dwie funkcje. Pozwala organowi zweryfikować przestrzeganie art. 33, a administratorowi wykazać, że ocena została przeprowadzona, a nie pominięta. Wpis z dwóch zdań („wysłano e-mail do niewłaściwego adresata, brak danych szczególnej kategorii, odbiorca potwierdził usunięcie, uznano za mało prawdopodobne") jest wystarczający i wielokrotnie lepszy niż brak wpisu.

[Zaktualizowany poradnik UODO]({% post_url 2025-03-03-poradnik-uodo-naruszenia %}) kładzie na to wyraźny nacisk i wylicza, co może stanowić taką dokumentację: notatki, korespondencję, wyciągi z systemów, raporty z audytów i testów.

## Czego uczą decyzje UODO?

Kara rzadko pada za sam incydent. Pada za to, czego zabrakło wcześniej albo później.

| Czego zabrakło | Decyzja |
|---|---|
| Analizy ryzyka i testowania zabezpieczeń | [DKN.5131.9.2024 - niezaszyfrowany laptop]({% post_url 2024-11-13-decyzja-uodo %}) |
| Weryfikacji i nadzoru nad procesorem | [DKN.5130.4179.2020 - McDonald's Polska]({% post_url 2025-07-28-kara-mcdonalds %}) |
| Podstawy prawnej przetwarzania | [DKN.5131.1.2025 - wybory kopertowe]({% post_url 2025-03-28-rekordowa-kara-poczta-polska %}) |
| Zgłoszenia i zawiadomienia osób | [DKN.5131.27.2023 - dane o kwarantannie]({% post_url 2026-07-07-decyzja-uodo-ops-dane-o-kwarantannie %}) |
| Zabezpieczenia skrzynki pocztowej | [DKN.5131.34.2023 - poczta e-mail]({% post_url 2026-06-16-ryzyko-danych-osobowych-poczta-email %}) |

Za każdą z tych pozycji stoi ten sam wniosek: obowiązki z art. 24 i 32 RODO wykonuje się przed incydentem. Po incydencie można już tylko ograniczać skutki i wykazywać, że wcześniej zrobiło się, co trzeba.

## Co zrobić w pierwszej dobie?

1. Zapisz moment i sposób, w jaki dowiedziałeś się o zdarzeniu. To od tego punktu będzie liczony termin i o to organ zapyta w pierwszej kolejności.
2. Ogranicz skutki: odetnij dostęp, zmień hasła, wycofaj publikację, uruchom odtwarzanie z kopii.
3. Ustal zakres: jakie kategorie danych, ilu osób, przez jaki czas i dla kogo były dostępne. Jeżeli dane przetwarzał dostawca, wystąp do niego na piśmie.
4. Oceń ryzyko i zapisz tę ocenę wraz z uzasadnieniem, niezależnie od tego, jaki będzie wynik.
5. Zgłoś do UODO, jeżeli nie da się uznać ryzyka za mało prawdopodobne. Jeżeli miną 72 godziny, zgłoś z wyjaśnieniem opóźnienia.
6. Zawiadom osoby, jeżeli ryzyko jest wysokie i nie zachodzi żaden z wyjątków z art. 34 ust. 3.
7. Wpisz zdarzenie do rejestru naruszeń, również gdy zdecydowałeś o niezgłaszaniu.
8. Sprawdź, czy równolegle biegnie termin zgłoszenia incydentu do CSIRT.
9. Wróć do analizy ryzyka i uzupełnij ją o scenariusz, który właśnie się zrealizował.

Punkt dziewiąty jest tym, który odróżnia organizacje uczące się od tych, które za dwa lata przeczytają o sobie w uzasadnieniu decyzji.

## Najczęściej zadawane pytania

{% include post-faq.html %}
