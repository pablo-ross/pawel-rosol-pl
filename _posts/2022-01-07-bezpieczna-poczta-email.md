---
title: 'Bezpieczna poczta e-mail - co to oznacza?'
date: '2022-01-07T11:42:13.27Z'
categories:
  - Poczta e-mail
tags:
  - Szyfrowanie poczty
  - Bezpieczna poczta
  - Klucz Yubikey
  - Uwierzytelnianie dwuskładnikowe
  - Weryfikacja dwuetapowa
description: 'Bezpieczna poczta e-mail. Ryzyko naruszeń jest wysokie jeśli chodzi o obszar związany z nieuporządkowanym zbiorem informacji - a takim są skrzynki pocztowe.'
---

**Mimo, że e-mail w sensie technicznym jest już leciwym wynalazkiem „wczesnego internetu”, to nadal jest to wiodące narzędzie komunikacji w praktycznie każdej dziedzinie życia. W obszarze ochrony danych osobowych jest to jednocześnie to miejsce, gdzie należy szczególnie zadbać o bezpieczeństwo dostępu do danych.**

Przykładów na incydenty i zagrożenia nie brakuje. Codziennie słyszymy o przejęciu kont pocztowych i uzyskiwania dzięki temu dostępu do całego szeregu innych zasobów. Można też z dużym prawdopodobieństwem zakładać, że o większości naruszeń nigdy się nie dowiemy, a bezpośrednie i pośrednie skutki mogą być dotkliwe i długotrwałe.

Dlatego w kontekście bezpieczeństwa informacji nie da się ukryć, że ryzyko naruszeń jest wysokie jeśli chodzi o obszar związany z nieuporządkowanym zbiorem informacji – a takim są skrzynki pocztowe. Coraz częściej pracownicy firm i instytucji posiadają w skrzynkach pocztowych coraz szybciej przyrastające zbiory danych, zawierające ogromne ilości danych osobowych, w tym ogromne możliwości uzyskiwania korelacji i łączenia zbiorów metadanych w kolejne zbiory informacji.

## Jak się zabezpieczać?

Poradników organizacyjnych i technicznych jest mnóstwo, więc pomijam temat wyboru konkretnego narzędzia czy konkretnej strategii. Ale skupiłbym się właśnie na tym ostatnim, czyli ciągłym udoskonalaniu wewnętrznych procedur pod kątem podnoszenia poziomu bezpieczeństwa.

Dostępne środki techniczne i organizacyjne zmieniają się praktycznie z dnia na dzień. Nie jest łatwo śledzić wszystkie dokonujące się zmiany, ale jednocześnie nie można polegać na rozwiązaniu raz wdrożonym, które domyślnie będzie przez lata tak samo dobre jak w momencie wdrożenia.

## Przede wszystkim klucz fizyczny U2F

O tym, że dostęp do skrzynki pocztowej (a coraz częściej także do pozostałych zasobów w chmurze) powinien być dwuskładnikowy, nie muszę szerzej pisać (weryfikacja dwuetapowa 2FA). Logowanie się za pomocą loginu i hasła – nawet zakładając wysoki stopień skomplikowania hasła – w dzisiejszych czasach jest niewystarczające.

Pewną formą minimalizacji ryzyka nieuprawnionego dostępu będzie dodanie kolejnej warstwy np. kodu przesłanego przez SMS czy aplikację typu TOTP. Ale to nadal nie daje odpowiednio wysokiego poziomu bezpieczeństwa, gdyż istnieje możliwość skutecznej formy phishingu.

Tak jak większość specjalistów od bezpieczeństwa, również moim zdaniem na chwilę obecną najpewniejszą metodą autoryzacji jest - poza loginem i skomplikowanym hasłem – dodanie drugiej warstwy w postaci fizycznego klucza U2F. Wiodącym rozwiązaniem są klucze np. **Yubikey**, z których sam od lat korzystam. Takim kluczem można zabezpieczyć nie tylko dostęp do poczty czy zasobów w chmurze, ale także dostęp do kont w popularnych platformach społecznościowych, które są także masowo wykorzystywanym wektorem ataku.

## A może szyfrowanie poczty?

Co to znaczy, że poczta e-mail jest szyfrowana? To pojęcie jest tak ogólne i szerokie jednocześnie, że najprawdopodobniej dla każdego może to oznaczać coś innego. Na pewno czym innym jest szyfrowanie transmisji w trakcie wysyłania wiadomości, a czym innym jest szyfrowanie danych bezpośrednio na serwerze.

Już od dość dawna można korzystać z szyfrowania poczty poprzez np. klucze prywatne i publiczne PGP. Jednak dla typowego użytkownika jest to dość skomplikowane. Na szczęście na rynku jest coraz więcej rozwiązań, które wdrażają metodą „out of the box” wiele tego typu dodatków minimalizujących ryzyko naruszenia danych.

Jeśli w skrzynkach pocztowych Twojej organizacji znajdują się np. dane szczególnej kategorii, tym bardziej warto wdrożyć takie systemy, które nawet w przypadku nieuprawnionego dostępu do zasobów, nie pozwolą na łatwy dostęp do danych wrażliwych.

## Z jakich narzędzi korzystać?

Mimo tak wielu zagrożeń, wybór narzędzi dostępnych na rynku jest dość mocno ograniczony. Co ważne, większość krajowych (polskich) rozwiązań dostarczających usługi typu e-mail, nie spełnia podstawowych wymogów bezpieczeństwa. Wielu dostawców oferuje nadal prehistoryczną wersję poczty e-mail, gdzie jedyną formą zabezpieczenia jest login i hasło. I to właśnie tam mamy największy wysyp nieuprawnionych dostępów i incydentów o wysokim ryzyku naruszenia praw i wolności osób fizycznych.

W kręgu naszych zainteresowań w zakresie wyboru odpowiedniego dostawcy znajdują się w zasadzie duzi globalni gracze, tacy jak Google, Microsoft, Yahoo itd. Istnieje też wiele innych rozwiązań globalnych i zdecydowana większość takich rozwiązań są to rozwiązania płatne, zazwyczaj w modelu płatności rzędu od kilku do kilkudziesięciu euro za jednego użytkownika miesięcznie.

Pojawiają się też rozwiązania wyspecjalizowane takie jak poczta obsługiwana przez **ProtonMail** czy **Tutanota**. Można je brać pod uwagę, gdy zależy nam szczególnie na zachowaniu prywatności korespondencji.

## Bezpieczna poczta e-mail w organizacji

Jeszcze mniejszy wybór dostawców pojawia się w momencie, gdy chcemy utrzymywać system względnie bezpiecznej poczty e-mail w organizacji, przy jednoczesnej potrzebie efektywnego i sprawnego administrowania kontami dziesiątek czy setek pracowników.

W takim przypadku pozostaje wybór w zasadzie pomiędzy **Google Workspace** i **Microsoft Office365**. Koszty takiej poczty są wielokrotnie wyższe, np. w porównaniu z popularnymi polskimi platformami typu **Home.pl** czy **Nazwa.pl**, jednak kwestie rozwiązań bezpieczeństwa oraz ilość innych funkcji są kompletnie poza porównaniem.

Jeszcze inną formą zachowania wysokiego poziomu bezpieczeństwa, jest wybór rozwiązań wewnętrznych, realizowanych na własnej infrastrukturze. Są to jednak rozwiązania obarczone wysokimi kosztami wdrożenia i utrzymania, na które mogą sobie pozwolić najczęściej duże podmioty o wysokiej kulturze organizacyjnej.

## Minimalizuj ryzyko już teraz

Jeśli zależy Ci na zmniejszeniu ryzyka naruszeń, nie możesz czekać **moment pojawienia się incydentu, który prawdopodobnie prędzej czy później nastąpi**. Bezpieczna poczta e-mail to sprawa kluczowa dla każdego: dla pojedynczej osoby prywatnej, dla małej firmy i dla wielkiej korporacji. Nadal bowiem w oparciu o skrzynkę e-mail realizowane są ogromne ilości usług.

**Można powiedzieć, że ten kto uzyska dostęp do naszej skrzynki e-mail, otrzyma dostęp do większości informacji o nas i o naszej działalności, w tym danych innych osób i firm, z którymi na co dzień utrzymujemy kontakt.**