Aufgabe 1
=========

Thema: Ausdrücke und Typen

Aufgabenstellung
----------------

In dieser ersten Aufgabe wollen wir uns mit einfachen Ausdrücken und deren Typen
beschäftigen.
Hierfür sind ein paar Werte vorgegeben, für die ihr die Typen bestimmen sollt.


I. Einfache Ausdrücke
---------------------

Überlegt euch für die folgenden 15 Ausdrücke, welchen Typ sie jeweils besitzen.

Tipp: Zwei der Ausdrücke sind ungültig.
Welche sind das und wieso sind sie ungültig?

Beispiel:

   -  '7' :: Char

Aufgaben:

   1. True                       :: Bool
   2. (False, True)              :: (Bool, Bool)
   3. [False, True]              :: [Bool]
   4. "True"                     :: [Char] <=> String
   5. ['4', '2']                 :: [Char] <=> String
   6. ["4", "2"]                 :: [[Char]] <=> [String]
   7. ([True], "True")           :: ([Bool], [Char])
   8. [("a", 'b'), ("A", 'B')]   :: [(String, Char)]
   9. [1, 2, 3]                  :: [Integer]
  10. ['O', '0', 0]              :: ungültig: unterschiedliche Datentypen
  11. [[], ['0'], ['1', '2']]    :: [[Char]]
  12. ["foo", ['b', 'a', 'r']]   :: [String]
  13. ("head", head)             :: (String, [a] -> a)
  14. [head, length]             :: [[Int] -> Int]
  15. blub                       :: Funktion "blub" nicht definiert

Kontrolliert anschließend eure Ergebnisse mit dem ghci.
Dies ist mit dem Befehl :type (oder :t) möglich.


II. Funktionen
--------------

Analog zur vorherigen Aufgabe sind nun die Typen einiger Funktionen zu
bestimmen.

Beispiel:

    head :: [a] -> a
    head (x:xs) = x

Funktionsdefinitionen:

  1. copyMe xs       = xs ++ xs
     copyMe :: [a] -> [a]
  2. boxIt (x, y)    = ([x], [y])
	 boxIt :: (a, b) -> ([a], [b]) 
  3. isSmall n       = n < 10
     isSmall :: (Num a, Ord a) => a  -> Bool
  4. pair x y        = (x, y)
	 pair :: a -> b -> (a, b) 
  5. toList (x, y)   = [x, y]
	 toList :: (a, a) -> [a]
  6. blp x           = toList (pair x True)
	 blp :: Bool -> [Bool]  
  7. apply f x       = f x
	 apply :: (t1 -> t) -> t1 -> t 
  8. plus1 n         = 1 + n
	 plus1 :: Num a -> a -> a
  9. splitAtPos n xs = (take n xs, drop n xs)  
	 splitAtPos :: Int -> [a] -> ([a], [a])



III. Beweise
------------

Die Funktionen "summe" und "produkt" seien wie folgt definiert:

> summe []     = 0
> summe (x:xs) = x + summe xs

> produkt []     = 1
> produkt (x:xs) = x * produkt xs


Mithilfe von Äquivalenzumformungen kann man beispielsweise zeigen,
dass "produkt [6,7] = 42" gilt:

        produkt [6,7]
    <=> produkt (6:7:[])     Liste nur anders aufgeschrieben
    <=> 6 * produkt (7:[])   Definition von "produkt" angewendet
    <=> 6 * 7 * produkt []   Definition von "produkt" angewendet
    <=> 42 * produkt []      Definition von "*" angewendet
    <=> 42 * 1               Definition von "produkt" angewendet
    <=> 42                   Definition von "*" angewendet

Zeigt nun mithilfe von Äquivalenzumformungen, dass folgende Aussagen gelten.
Dokumentiert dabei jeweils wie im Beispiel gezeigt, welche Umformungen ihr
vorgenommen habt.

  1. summe [3,4,5] = 12
  <=> summe (3:4:5:[])
  <=> 3 + summe (4:5:[])
  <=> 3 + 4 + summe (5:[])
  <=> 3 + 4 + 5 + summe ([])
  <=> 3 + 4 + 5 + 0
  <=> 12

  2. produkt [x] = x   -- für alle Zahlen x 
  <=> produkt(x:[])
  <=> x * produkt ([])
  <=> x * 1
  <=> x


gilt.


IV. Syntaxfehler
----------------

Der folgende Ausschnitt enthält drei syntaktische Fehler.
Findet heraus welche dies sind und behebt sie.

N = a 'div' length xs
    where
       a = 10
      xs = [1..5]
      
1. Name von Variable groß geschrieben
2. falsche quotation bei div `
3. Einrückung von letzter Zeile falsch

