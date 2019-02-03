fertig
Aufgabe 2
=========

Thema: Polymorphie und Typklassen

Aufgabenstellung
----------------

In dieser Aufgabe wollen wir uns mit polymorphen Typen, also Typen die
Typvariablen enthalten, und dem Überladen von Typen beschäftigen.


I.

Guckt euch die Haskell-Typhierarchie unter [1] an. In welchen Fällen
sollte man Typen (z.B. Int oder Char) nutzen und wo sollte man lieber
auf Typklassen (Eq, Ord etc.) zurückgreifen?

[1] https://www.haskell.org/onlinereport/basic.html#standard-classes

Um Methoden zu abstahieren, um diese auch auf bspw. Listen mit Elementen von unterschiedlichen Datentypen anwenden zu können.	



II.

Gegeben sind die beiden folgenden Funktionsdefinitionen (inkl. Typsignatur):

longList :: [Int] -> Bool

> longList :: [a] -> Bool
> longList l = length l > 10

smaller :: Int -> (Int -> Int)

> smaller :: Ord a => a -> a -> a
> smaller x y = if x <= y then x else y

isEq :: Double -> Double -> Double -> Bool

> isEq :: Eq a => a -> a -> a -> Bool
> isEq x y z = (x == y) && (y == z)

1) a) Was macht die Funktion "longList"?

	Guckt ob die Länge (Anzahl der Elemente in der Liste) der Liste > 10 ist.

   b) Wie müsste der Typ definiert
      werden, damit sie dies nicht mehr ausschließlich für Listen mit Elementen vom
      Typ Int, sondern mit beliebigen Listen (also z.B. auch String) berechnen kann?
      --> Probiert eure Lösung auch aus. Entfernt hierzu z.B. einfach oben die
          '> ' vor der Definition und definiert die Funktion hier neu.
      
      a - Typ is egal

2) Wie muss der Typ der Funktion "smaller" aussehen, damit sie nicht nur mit
   Int, sondern mit allen Typen funktioniert, auf denen eine Ordnung definiert
   ist?
   --> Probiert eure Lösung mit Zahlen und mit Zeichenketten aus (auf beiden
       Typen ist eine Ordnung definiert.
       
   Ord

3) Wie muss der Typ der Funktion "isEq" aussehen, damit sie nicht nur mit
   Double, sondern mit allen Typen funktioniert, auf denen ein Vergleich möglich
   ist?
   
   Eq


III.

Analog zu letzter Woche sind nun die Typen einiger Ausdrücke und Funktionen
zu bestimmen.

1.

[(+), (-), (*)] :: Num a => [a -> a -> a]


2.

[(+), (-), (*), mod] :: Integral a => [a -> a -> a]


3.

present :: (Show a, Show b) => a -> b -> String

> present x y = show x ++ ", " ++ show y


4.

showAdd :: Num a => a -> a -> [a]

> showAdd x y = [x, y] ++ [x + y]
