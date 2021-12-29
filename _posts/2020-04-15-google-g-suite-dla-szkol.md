---
title: G Suite dla szkół - ochrona prywatności i bezpieczeństwo
date: '2020-04-15T13:38:16.17Z'
categories:
  - Nauka zdalna w szkołach
tags:
  - Koronawirus
  - COVID-19
  - SARS-CoV-2
  - Ochrona danych w fazie projektowania
  - Domyślna ochrona danych
  - Google Classroom
  - Homeschool
description: Ze względu na światową pandemię zakaźnej choroby COVID-19 wywoływanej przez koronawirusa SARS-CoV-2 wprowadzono w wielu krajach różnego rodzaju środki bezpieczeństwa. Jednym z nich jest okresowe zamknięcie szkół i wprowadzenie obowiązku nauki zdalnej z wykorzystaniem narzędzi online. Przy tej okazji ważny temat to ochrona prywatności i bezpieczeństwo użytkowników korzystających z narzędzi ułatwiających zdalne nauczanie.
---

Ze względu na światową **pandemię** zakaźnej choroby **COVID-19** wywoływanej przez koronawirusa **SARS-CoV-2** wprowadzono w wielu krajach różnego rodzaju środki bezpieczeństwa. Jednym z nich jest **okresowe zamknięcie szkół** i wprowadzenie obowiązku **nauki zdalnej** z wykorzystaniem narzędzi online.

W Polsce nie stosowano wcześniej na większą skalę takich metod nauczania, stąd w większości jednostek oświatowych wdrożenie odpowiednich rozwiązań odbywało się i nadal odbywa się szybko i bez wcześniej opracowanego planu. Minister Edukacji wskazał jedynie ogólne wskazówki, jednak z braku odpowiednich procedur i rozwiązań, szkoły samodzielnie wdrażają metody i narzędzia związane ze zdalnym nauczaniem w okresie pandemii koronawirusa.

Mając na uwadze kwestię dostępności, przepustowości, użyteczności i stopnia zaawansowania, w wielu szkołach używa się rozwiązań dwóch światowych potentatów w zakresie rozwiązań chmurowych, czyli **Google** i **Microsoft**. Ponieważ wspomniane rozwiązania są uniwersalne dla wielu zastosowań na całym świecie, **każde z nich można i trzeba dostosować do wymogów obowiązujących przepisów lokalnych, a przede wszystkim dopasować do obecnie funkcjonujących zasad nauczania w danej szkole**.

Ponieważ biorę udział w pracach związanych bezpośrednio z takimi wdrożeniami oraz świadczę usługi konsultacji w tego typu projektach, poniżej postanowiłem przedstawić najważniejsze wybrane kwestie związane z **ochroną prywatności i bezpieczeństwem użytkowników** na przykładzie środowiska **Google G Suite** dla szkół i uczelni.

## „Privacy by design” oraz „privacy by default”

Poniższe krótkie rozważania można traktować jako **wstęp do analizy _„privacy by design”_ oraz _„privacy by default”_**. W ogromnym skrócie zasada _„privacy by design”_ oznacza, że administrator – zarówno przy określaniu sposobów przetwarzania, jak i w czasie samego przetwarzania – wdraża odpowiednie środki techniczne i organizacyjne w celu nadania przetwarzaniu niezbędnych zabezpieczeń, tak by spełnić wymogi RODO (art. 25) oraz chronić prawa osób, których dane dotyczą. Zasada _„privacy by default”_ oznacza z kolei wdrożenie odpowiednich środków technicznych i organizacyjnych, aby domyślnie przetwarzane były wyłącznie te dane osobowe, które są niezbędne dla osiągnięcia każdego konkretnego celu przetwarzania.

## Czym jest G Suite dla szkół?

Najważniejsza i pierwsza informacja jest taka, że pakiet „Google G Suite dla szkół i uczelni” to **usługa dostępna bezpłatnie**. Przynajmniej tak jest w chwili pisania tego tekstu. Ze względu na światową pandemię koronawirusa, na dzień dzisiejszy procedury otrzymania licencji EDU zostały przyspieszone co oznacza, że w zasadzie w kilka godzin po rejestracji szkoły można mieć już dostęp do całego pakietu G Suite.

Nie zamierzam opisywać procedury rejestracji, składników pakietu i jego możliwości, gdyż te informacje są dokładnie opisane na stronach Google. Ponadto niedawno ukazał się ciekawy polskojęzyczny opis środowiska na blogu **marketinglab.pl** autorstwa Przemysława Modrzewskiego pt. _„Jak prowadzić zdalną edukację przy pomocy Google Suite dla szkół – poradnik”_, do którego odsyłam ([link](https://www.marketinglab.pl/jak-prowadzic-zdalna-edukacje-przy-pomocy-google-suite-dla-szkol-poradnik/)).

## Jak skonfigurować środowisko G Suite dla szkół?

Trzeba mieć na uwadze, że pakiet G Suite to przede wszystkim środowisko komercyjne sprzedawane przez firmę Google jako rozwiązanie dla firm na całym świecie. Pakiet jest stale rozwijany i udoskonalany, jednak głównym jego celem jest zaspokojenie potrzeb użytkowników końcowych, którzy ponoszą opłaty za korzystanie z każdego konta swojego pracownika.

Bezpłatna wersja dla szkół jest przeniesieniem tego środowiska wraz z kilkoma modyfikacjami ułatwiającymi proces kształcenia na odległość (tzw. „nauka zdalna”). Podstawową różnicą w stosunku do wersji komercyjnych G Suite jest dodanie nowego elementu pakietu pod nazwą **Google Classroom**.

Istotna informacja jest taka, że w momencie uruchomienia pakietu, większość ustawień jest domyślnie włączona podobnie jak to wygląda w środowiskach komercyjnych nastawionych na działalność w Internecie.

![Widok konsoli administracyjnej Google G Suite dla szkół](/media/2020-04-15/google_admin.jpg)

Ponieważ działalność organizacji typu szkoła różni się w wielu aspektach od firm komercyjnych, **niezbędne jest wprowadzenie odpowiednich modyfikacji do ustawień** w przypadku świadczenia usługi polegającej na zarządzaniu środowiskiem uczniów i nauczycieli w procesie nauki zdalnej. Co równie istotne, należy dostosować ustawienia środowiska mając na uwadze przepisy RODO (np. wspomniana na początku ochrona danych „w fazie projektowania” oraz „domyślna” ochrona danych) oraz wewnętrzne polityki ochrony danych osobowych obowiązujące w szkole.

### ▶️ Określenie ogólnej strategii wdrożenia i dalszego działania w G Suite

W pierwszej kolejności osoby decyzyjne w szkołach powinny określić ogólną strategię wdrożenia Google G Suite. Moja osobista rekomendacja to **strategia „małych kroków”** polegająca na skonfigurowaniu środowiska w minimalnym zakresie poprzez włączenie jedynie kluczowych elementów pakietu, a następnie w miarę potrzeb i zdobywania doświadczenia przez środowisko szkolne, włączanie kolejnych.

Domyślnie w środowisku G Suite włączonych jest wiele elementów niepotrzebnych na początkowym etapie. Zatem zasadne wydaje się wyłączenie tych składników, a pozostawienie jedynie tych niezbędnych np. Gmail, Classroom, Dokumenty, Dysk, Kalendarz, Meet, Hangouts.

### ▶️ Przeszkolenie grupy administracyjnej i nauczycieli

To jeden z ważniejszych elementów. Zwłaszcza w szkołach dużych, posiadających nierzadko kilkaset kont. W trakcie swojej pracy wdrażałem G Suite w szkołach posiadających powyżej tysiąca użytkowników. Zarówno dla szkół małych, jak i dużych odpowiednie przeszkolenie grupy nauczycieli, którzy będą zarządzać środowiskiem jest kluczowe i ma **ogromny wpływ na dalsze działanie całej organizacji**. W kolejnym etapie istotne jest przeszkolenie wszystkich nauczycieli, którzy z kolei będą uczyć także swoich uczniów jak właściwie i efektywnie korzystać ze środowiska pracy zdalnej.

### ▶️ Zakładanie kont, tworzenie jednostek organizacyjnych i grup

Na początkowym etapie bardzo ważne jest **utworzenie kont użytkowników**, nadanie im odpowiednich praw zgodnie z przypisaniem do jednostek organizacyjnych i grup. Jest to bardzo istotny etap, gdyż właściwe jego zaprojektowanie na początku znacznie ułatwia dalszy proces wdrażania zmian i usprawnień.

W mojej ocenie administrator konta G Suite powinien tworzyć konta dla wszystkich uczestników środowiska, czyli zarówno dla nauczycieli, jak i uczniów. Może to się wydawać początkowo zadaniem dość trudnym, jednak ze względu na mechanizmy automatycznego importowania i masowego zarządzania kontami, zadanie to w gruncie rzeczy jest stosunkowo łatwe.

Podstawowa zaleta posiadania odrębnych kont uczniów i nauczycieli w jednej lub kilku zarządzanych przez szkołę domen jest taka, że daje znacznie **większe możliwości kontroli** nad całym środowiskiem niż dzieje się to w sytuacji, gdy do nauki zdalnej zezwolimy na dostęp przez konta spoza domeny (a tak to jest ustawione domyślnie).

![Importowanie dużej ilości użytkowników w domenie szkolnej](/media/2020-04-15/google_admin_users.jpg)

Ponadto zarządzając optymalnie procesem tworzenia kont i nadawania uprawnień mamy pewność, że każde konto jest unikalne i przypisane danej osobie, co ma ogromne znaczenie w przypadku jakichkolwiek problemów w przyszłości. Oprócz tego osoba lub osoby posiadające uprawnienia administracyjne mogą łatwiej konta zawieszać (np. w okresie wakacji), dodawać je do kolejnych grup związanych z pojawiającymi się zajęciami dodatkowymi, projektami, warsztatami itd.

### ▶️ Poczta Gmail jako poczta wewnętrzna

Wyobraźmy sobie, że każdy nauczyciel i uczeń posiada w G Suite konto w postaci _imie.nazwisko@szkolnadomena.pl_. **Nie zmieniając ustawień domyślnych, tworzymy w tej sytuacji w pełni funkcjonujące konta e-mail**, z którymi można kontaktować się z zewnątrz oraz można z niego wysyłać wiadomości do jakichkolwiek innych kont e-mail.

Z poziomu konta administratora jest jednak możliwe takie ustawienie poczty, które pozwala na korzystanie z niego jedynie w sposób umożliwiający np. kontaktowanie się jedynie z innymi użytkownikami w danej domenie, bez możliwości komunikacji ze światem zewnętrznym. Jest to moja podstawowa rekomendacja, ponieważ nie powinno być takiej sytuacji, że osoba postronna znająca imię i nazwisko dziecka może się z nim kontaktować przez e-mail szkolny służący do nauki zdalnej.

Przy zastosowaniu odpowiednich zmian poczta Gmail służy zatem jedynie do kontaktu ucznia z nauczycielem, otrzymywania powiadomień o zajęciach Google Classroom, zaproszeń do lekcji Google Meet itd. bez możliwości korzystania z konta jako pełnoprawnego konta e-mail.

![Ustawienia Gmail jako poczty wewnętrznej](/media/2020-04-15/google_gmail.jpg)

Oczywiście ze względu na to, że organizację w G Suite możemy podzielić na różne jednostki organizacyjne, nie będzie problemem wydzielenia grupy osób mającej uprawnienia do korzystania z kont Gmail w pełnej formie, np. dla pracowników administracyjnych, dyrektora czy innych określonych osób.

Warto też nadmienić, że procesie konfiguracji technicznej poczty można włączyć **dodatkowe opcje** związane z ochroną przed podszywaniem się pod inne osoby w e-mailach wychodzących z domeny szkolnej. Służą do tego odpowiednie konfiguracje ustawień takich jak: DKIM (DomainKeys Identified Mail), SPF (Sender Policy Framework) oraz DMARC (Domain-based Message Authentication, Reporting and Conformance).

### ▶️ Udostępnianie zasobów jedynie użytkownikom w domenie

W codziennej pracy szkoły tworzy się duża ilość zasobów, które są używane w procesie nauczania. Mowa tu o materiałach dydaktycznych nauczycieli czy pracach oddawanych przez uczniów. W domyślnej konfiguracji możliwe jest udostępnianie zasobów osobom spoza szkoły, co nie powinno mieć miejsca.

![Ustawienia Dysku Drive w zakresie udostępniania zasobów](/media/2020-04-15/google_drive.jpg)

Podobnie jak z korzystaniem z Gmail jedynie w formie poczty wewnętrznej, także w procesie nadawania praw dostępu powinniśmy tak skonfigurować środowisko, aby **precyzyjnie określić możliwości udostępniania** posługując się wspomnianym wcześniej sposobem przypisywania użytkowników do jednostek organizacyjnych i grup.

### ▶️ Odpowiednie ustawienia Google Meet

Korzystając z elementu pakietu G Suite jakim jest Meet, nauczyciele mogą z łatwością organizować **lekcje online z wykorzystaniem obrazu wideo i dźwięku**. Jednak podobnie jak przy ustawieniach Gmail czy udostępnianiem zasobów z dysku, także Meet wymaga odpowiednich zmian w konfiguracji, aby nauczyciele mieli kontrolę nad prowadzeniem lekcji.

Jednocześnie zastosowanie odpowiednich zmian w konfiguracji w Meet pozwoli na uniknięcie zjawisk podobnych do tych relacjonowanych w artykule pt. _„Wbijajcie do nas na lekcje. Nauczyciele bezradni wobec patostreamerów i uczniów”_:

> „Na lekcji ktoś wyświetlił uczniom film porno, w innej wirtualnej klasie nauczycielka musiała słuchać brutalnych wyzwisk, a jeszcze innej ktoś dla żartu ustawił obraźliwy nick.”
>
— **tvn24.pl** ([źródło](https://tvn24.pl/najnowsze/edukacja-online-nauczyciele-bezradni-wobec-patostreamerow-i-uczniow-4554596))

![Ustawienia dla jednostki organizacyjnej szkoły z uprawnieniami ograniczonymi](/media/2020-04-15/google_meet.jpg)

Zwrócę uwagę, że po odpowiednich zmianach w Meet **jedynie nauczyciele** powinni mieć możliwość inicjowania spotkań wideo, natomiast uczniowie mogą tylko dołączać do spotkań. Inaczej mówiąc, uczeń nie może zainicjować sam spotkania wideo np. z kolegami z klasy. Oprócz tego, jedynie nauczyciele mogą mieć uprawnienie do **nagrywania zajęć wideo**.

## Na co zwracać uwagę podczas codziennej pracy ze środowiskiem G Suite dla szkół?

**Proces początkowego skonfigurowania środowiska nie jest procesem trudnym** przy założeniu, że osoba lub podmiot wdrażający będzie mieć wstępnie określone wymagania wynikające z ogólnej strategii wypracowanej przez osoby zarządzające daną jednostką oświatową.

Jednak początkowy etap nie kończy prac związanych z dostosowaniem środowiska do wymagań danej szkoły. Jest to bowiem **proces ciągły**. Im większa jest dana szkoła, tym częściej będzie pojawiać się **konieczność przeprowadzania analiz i wdrażania zmian**.

W kwestii organizacyjnej powinien niewątpliwie zostać opracowany **regulamin usługi** obowiązujący w szkole, z którego będzie wynikać m.in. z kim i w jaki sposób należy się kontaktować w razie problemów technicznych. Odpowiednio przeszkolone osoby w jednostce szkolnej będą z pewnością mierzyć się z dodatkową pracą związaną z obsługą całego środowiska.

Do niemal codziennych obowiązków osób administrujących będzie należało m.in. przeglądanie **dzienników zdarzeń i raportów**. Z analizy tych informacji będą pojawić się kolejne wnioski wymagające dalszych zmian i usprawnień.

___
> W razie potrzeby dalszego skonsultowania kwestii związanych z wdrażaniem narzędzi do prowadzenia zdalnego trybu nauczania, zapraszam serdecznie do [kontaktu ze mną](/about).
___

<blockquote class="twitter-tweet"><p lang="pl" dir="ltr">Przyspieszone wdrożenie <a href="https://twitter.com/hashtag/cyfrowaszko%C5%82a?src=hash&amp;ref_src=twsrc%5Etfw">#cyfrowaszkoła</a> w efekcie pandemii <a href="https://twitter.com/hashtag/Covid_19?src=hash&amp;ref_src=twsrc%5Etfw">#Covid_19</a> niesie za sobą konieczność analizy ochrony prywatności i bezpieczeństwa nauczycieli i uczniów w narzędziach <a href="https://twitter.com/hashtag/zdalnaedukacja?src=hash&amp;ref_src=twsrc%5Etfw">#zdalnaedukacja</a>. Kilka słów z własnych obserwacji 👇<a href="https://t.co/nFAM0jxLd0">https://t.co/nFAM0jxLd0</a></p>&mdash; Paweł IOD (@pawel_iod) <a href="https://twitter.com/pawel_iod/status/1250406500448813057?ref_src=twsrc%5Etfw">April 15, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
