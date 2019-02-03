Übung: Grundlagen der Funktionalen Programmierung
Autor: Malte Heins
Datum: 2018-11-07
Thema: ein paar Beispielfunktionen

> two = 1 + 1

> add x y = x + y

> double x = 2 * x
> three = 3


Eine einfache Definition der Fakultätsfunktion, die
mit Hilfe der "product"-Funktion implementiert ist:

> factorial n = product [1..n]


Der Quicksort-Algorithmus:

> qsort [] = []
> qsort (x:xs) = qsort lt ++ [x] ++ qsort ge
>       where lt = [y | y <- xs, y < x]
>             ge = [y | y <- xs, y >= x]
