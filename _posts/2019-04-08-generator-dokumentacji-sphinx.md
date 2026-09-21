---
title: Generator dokumentacji Sphinx
date: "2019-04-08T15:33:39.11Z"
categories:
  - Narzędzia
tags:
  - Narzędzia IOD
  - Dokumentacja RODO
  - Analiza ryzyka
description: "Tytuł może być nieco mylący. Nie jest to bowiem narzędzie, które stworzy za Inspektora Ochrony Danych całą niezbędną dokumentację. Jest to system tworzenia i generowania dokumentacji, w oparciu o konwersję tekstowych plików w formacie reST (reStructuredText)."
---

Tytuł może być nieco mylący 🙂 Nie jest to bowiem narzędzie, które stworzy za Inspektora Ochrony Danych całą niezbędną dokumentację. Jest to system tworzenia i generowania dokumentacji, w oparciu o konwersję tekstowych plików w formacie **reST** ([reStructuredText](https://en.wikipedia.org/wiki/ReStructuredText)). W mojej codziennej pracy Inspektora jest to absolutny numer jeden jeśli chodzi o narzędzia wspomagające zarządzanie dokumentacją.

Dawniej, jeszcze jako Administrator Bezpieczeństwa Informacji (ABI) zazwyczaj niezbędną dokumentację przygotowywałem w ramach pracy z pakietem MS Office, czyli głównie w oparciu o edytor tekstu Word i arkusz kalkulacyjny Excel. W początkowej fazie wydawało się to wystarczające, ale z czasem, w miarę jak rosła ilość zmian i poprawek, okazało się to zdecydowanie niewystarczające i czasochłonne.

Ponieważ już dużo wcześniej zajmowałem się programowaniem i przygotowywaniem dokumentacji technicznej, z pomocą przyszły sposoby i metody stosowane powszechnie w środowisku deweloperskim. Szczególnie ważne w codziennej pracy jest wersjonowanie treści czyli **kontrola wersji** (git). Zastosowanie zwykłego tekstu podczas tworzenia dokumentacji umożliwia nie tylko łatwe dostosowanie formatu wyjściowego, ale staje się szczególnie przydatne w przypadku korzystania z systemu kontroli wersji, który umożliwia śledzenie zmian w plikach źródłowych pisanych w języku znaczników reST (reStructuredText), w odróżnieniu od sytuacji, kiedy dokumentacja pisana jest w plikach binarnych, takich jak np. format .doc (Microsoft Word). Dodatkowo zwykły tekst może być z łatwością przenoszony między różnymi platformami i systemami operacyjnymi, dzięki czemu praca nad dokumentacją nie jest uzależniona od systemów operacyjnych czy środowisk, w których przyjdzie nam pracować.

![Przykładowy ekran startowy dokumentacji online Sphinx w szablonie Read The Docs](/media/2019-04-08/readthedocs-sphinx.png)

Mając powyższe na uwadze wybór był oczywisty czyli [**Sphinx**](https://www.sphinx-doc.org/en/master/index.html). W dużym uproszczeniu praca z jakąkolwiek dokumentacją polega na utrzymywaniu repozytorium wersji plików źródłowych reST, natomiast Sphinx konwertuje te pliki źródłowe najczęściej do dokumentu HTML, ale możliwe jest również określenie innych formatów wyjściowych, np.: LaTeX, PDF, ePUB, man. Tym samym otwiera się prosta droga do posiadania **tej samej dokumentacji w wielu formatach**. W mojej pracy Inspektora Ochrony Danych pozwala to na posiadanie najnowszej wersji dokumentacji dostępnej w wersji HTML np. w lokalnej sieci **intranet**, co umożliwia dostęp do niezbędnej dokumentacji przez osoby zainteresowane i jednocześnie udaje się uniknąć zbędnego drukowania na papierze ciągle zmienianej dokumentacji. W razie potrzeby przygotowanie wyjściowego dokumentu do druku w wersji PDF zajmuje kilka sekund, w oparciu o ten sam kod źródłowy.

System Sphinx jest rozwijany w oparciu o licencję BSD. Posiada wiele rozszerzeń i możliwości konfiguracji. W celu łatwiejszego zarządzania stworzoną dokumentacją używam także rozwiązania [Read the Docs](https://readthedocs.org/){:target="_blank"} (RTD). Projekt sponsorowany jest m.in. przez: Python Software Foundation, Django Software Foundation, Mozilla Webdev.

Integralną częścią dokumentacji związanej z ochroną danych osobowych, co wynika z ogólnie obowiązujących przepisów prawa oraz dobryk praktyk, są m.in. takie elementy jak:
* polityki i instrukcje,
* wzory dokumentów (umowy, klauzule itd.),
* rejestr czynności przetwarzania danych osobowych,
* ewidencja upoważnień do przetwarzania danych osobowych,
* rejestr incydentów,
* zarządzanie szkoleniami dla pracowników,
* analiza ryzyka i plan postępowania z ryzykiem.

W celu łatwego zarządzania często zmieniającymi się powyższymi elementami, stosuję dodatkowo swój **autorski system bazodanowy**, który w efekcie ciągłej pracy generuje wynikowe pliki reST (reStructuredText), które z kolei stają się integralną częścią całego źródłowego repozytorium dokumentacji. W efekcie udaje się stosunkowo łatwo i pewnie pracować oraz zarządzać kolejnymi wersjami dokumentacji, a następnie w formie online jest ona udostępniana do wglądu w sposób automatyczny. Na chwilę obecną nie wyobrażam sobie powrotu do plików typu Word. Gorąco zachęcam do korzystania ze Sphinx-a 🙂