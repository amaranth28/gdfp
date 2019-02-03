Aufgabe 6
=========

Thema: Rekursive Funktionen, Testen mit HUnit

> module Uebung6 where

> -- Prelude importieren und dabei die Funktionen
> -- take, (!!), concat und elem verstecken (für Aufgabenteil I)
> import Prelude hiding (take, (!!), concat, elem)

> -- Prelude "eingeschränkt" importieren, um etwa mit "Prelude.take"
> -- oder "Prelude.!!" die entsprechenden Funktionen doch nutzen zu können.
> import qualified Prelude

> -- Testing framework für Haskell importieren (für Aufgabenteil II):
> -- http://www.haskell.org/haskellwiki/HUnit_1.0_User's_Guide
> import Test.HUnit


I: Rekursive Funktionen
-----------------------

1) Definiert die folgenden Funktionen rekursiv.
   Geht dabei nach dem in der Vorlesung behandelten "Rezept" vor, wobei die
   einzelnen Schritte alle anzugeben sind (Schritte 2-4 als Kommentar, da diese
   ja noch nicht vollständig sind und Schritt 5 als Codeabschnitt).
   Die Funktionen sollen sich genauso verhalten, wie die aus der Prelude.
   Probiert ggf. mit diesen ein wenig herum um zu sehen, wie sie sich in
   Sonderfällen (wie etwa der leeren Liste oder negativen Indizes) verhalten.

a) take :: Int -> [a] -> [a]
-------------------------

(1) Definition des Typs

> take :: Int -> [a] -> [a]

(2) Aufzählen der Fallunterscheidungen


take n []     | n < 0
              | n == 0
              | n > 0

take n (x:xs) | n < 0
			  | n == 0
			  | n > 0


(3) Definition der einfachen Fälle


take n []     | n < 0 = []
		      | n == 0 = []
		      | n > 0

take n (x:xs) | n < 0 = []
			  | n == 0 = []
			  | n > 0


(4) Definition der rekursiven Fälle


take n []     | n < 0 = []
		      | n == 0 = []
		      | n > 0 = []

take n (x:xs) | n < 0 = []
			  | n == 0 = []
			  | n > 0 = x:(take n-1 xs)


(5) Zusammenfassen und verallgemeinern


> take n [] = []
> take n (x:xs) | n <= 0 = []
>				| otherwise = x:(take (n-1) xs)



b) concat :: [[a]] -> [a]
-------------------------

(1) Definition des Typs

> concat :: [[a]] -> [a]

(2) Aufzählen der Fallunterscheidungen

concat []           =
concat (x:[])      	=
concat (x:xs)		=


(3) Definition der einfachen Fälle

concat []           = []
concat (x:[])      	= x
concat (x:xs) 		=


(4) Definition der rekursiven Fälle

concat []           = []
concat (x:[])      	= x
concat (x:xs) 		= x++(concat xs)

(5) Zusammenfassen und verallgemeinern


> concat [] 	= []
> concat (x:[]) = x
> concat (x:xs) = x++(concat xs)



c) elem :: Eq a => a -> [a] -> Bool
-----------------------------------

(1) Definition des Typs

> elem :: Eq a => a -> [a] -> Bool

(2) Aufzählen der Fallunterscheidungen

elem a []     =
elem a [b]    =
elem a (x:xs) =


(3) Definition der einfachen Fälle

elem a []     = False
elem a [b]    = a == b
elem a (x:xs) =

(4) Definition der rekursiven Fälle

elem a []     = False
elem a [b]    = a == b
elem a (x:xs) = a == x || (elem a xs)

(5) Zusammenfassen und verallgemeinern

> elem a []     = False
> elem a (x:xs) = a == x || (elem a xs)


d) (!!) :: [a] -> Int -> a
--------------------------

(1) Definition des Typs

> (!!) :: [a] -> Int -> a

(2) Aufzählen der Fallunterscheidungen

_ !! n | n < 0 =
[] !! _        =
(x:_) !! 0     =
(_:xs) !! n    =


(3) Definition der einfachen Fälle

_ !! n | n < 0 = error "negative index"
[] !! _        = error "index too large"
(x:_) !! 0     = x
(_:xs) !! n    =


(4) Definition der rekursiven Fälle

_ !! n | n < 0 = error "negative index"
[] !! _        = error "index too large"
(x:_) !! 0     = x
(_:xs) !! n    = xs !! (n-1)

(5) Zusammenfassen und verallgemeinern

> _ !! n | n < 0 = error "negative index"
> [] !! _        = error "index too large"
> (x:_) !! 0     = x
> (_:xs) !! n    = xs !! (n-1)


2) Die folgende Funktion "reduce" reduziert eine natürliche Zahl n nach den
   Regeln:
     - Wenn n gerade ist, so wird n halbiert und
     - wenn n ungerade ist, so wird n verdreifacht und um 1 erhöht.

> reduce :: Integer -> Integer
> reduce n | even n    = n `div` 2
>          | otherwise = n * 3 + 1

   Wendet man nun die Funktion wiederholt auf ihr Resultat an, erhält man bei
   einem Startwert von beispielsweise 5 die Folge:
     5, 16, 8, 4, 2, 1, 4, 2, 1, 4, 2, 1, ...

   a) Definiert nun eine rekursive Funktion "collatz :: Integer -> Integer", die
      zählt wieviele Schritte benötigt werden, um eine Zahl n mit der gegebenen
      Funktion "reduce" zum ersten Mal auf 1 zu reduzieren.
      Beispiele:
        collatz  5  =  5
        collatz 16  =  4
        collatz  8  =  3
        collatz  4  =  2
		
> collatz :: Integer -> Integer
> collatz n 
> 		| n == 2 = 1
> 		| otherwise = 1 + collatz (reduce n)


   b) Ist eure collatz-Funktion linearrekursiv? Und woran erkennt man dies?

Bei jedem Aufruf von collatz kann es maximal zu einem weiteren Aufruf von collatz kommen.


3) Gegeben sind zwei Funktionen zur Berechnung der Fibonacci-Zahlen:

> fib   :: Integer -> Integer
> fib 0 = 0
> fib 1 = 1
> fib n = fib (n-1) + fib (n-2)

> fib2 :: Integer -> Integer
> fib2 x = fst (fib2' x)
>          where fib2' 0 = (0, 0)
>                fib2' 1 = (1, 0)
>                fib2' n = (l + p, l)
>                          where (l, p) = fib2' (n-1)

   a) Was für Arten von Rekursion verwenden die beiden Funktionen?
      (mehrfache Rekursion, wechselseitige Rekursion, Linearrekursion, ...)
      Und woran erkennt man dies?
	  
	  fib = mehrfache Rekursion, da jeder Aufruf von fib zu 1+n weiteren Aufrufen von fib führt.
	  fib2 = linear rekursiv, da jeder Aufruf von fib2 zu genau 1 weiteren Aufruf von fib2' führt.

   b) Welche Funktion ist effizienter? Und wieso?

		fib2 da linearrekursiv

   c) Wie oft wird die Funktion fib rekursiv aufgerufen, wenn "fib 4" berechnet
      werden soll?
	  
	  => fib(4)												| 1
	  => fib(3) + fib(2)									| 3
	  => (fib(2) + fib(1)) + (fib(1) + fib(0)) 				| 7
	  => ((fib(1) + fib(0)) + fib(1)) + (fib(1) + fib(0)) 	| 9
	  
	  -> 9x Aufruf von fib


   d) Wie sieht der genaue Funktionstyp der rekursiven Hilfsfunktion fib2' aus?
      Überlegt Euch dies anhand des Aufrufs in fib2 und des gegebenen Typs.

		fib2 :: Num -> (Num, Num)


   e) Wie funktioniert fib2 und wozu dient hierbei die Hilfsfunktion fib2'?
      (Welche Bedeutung haben die beiden Komponenten des Tupels?)

		Die Funktion fib2' errechnet die n-te und die n-1-te Fibonacci-Zahl,
		die dann dazu verwendet werden die n+1-te Fibonacci-Zahl zu errechnen.
		Somit muss nur jede Fibonacci-Zahl 1 mal errechnet werden (im Gegensatz zu fib)


II: Testen mit HUnit
--------------------

1) Mit der Testumgebung HUnit können leicht Tests erstellt werden um
   automatisiert prüfen zu können, ob sich bestimmte Funktionen wie geplant
   verhalten.

   Die folgenden Zeilen definieren eine Liste mit Testfällen, die bei einem
   Aufruf von "runTest" alle ausgeführt werden.
   Ein Testfall besteht dabei jeweils aus einer kurzen Beschreibung sowie zwei
   Ausdrücken, die erst ausgewertet und dann miteinander verglichen werden:
     testbeschreibung  ~:  zu_testender_ausdruck  ~?=  erwarteter_ausdruck

   Die Operatoren ~: und ~?= sind in HUnit definiert und dienen der einfacheren
   Erzeugung von Testfällen. Es gibt auch noch weitere Möglichkeiten, schaut
   hierfür ggf. auch mal in die Dokumentation von HUnit:
     http://www.haskell.org/haskellwiki/HUnit_1.0_User's_Guide

   Auf dem eigenen Rechner muss die sogenannte "haskell-platform" installiert sein,
   um HUnit nutzen zu können. Im Rechenzentrum ist dies bereits der Fall.

> runTest = runTestTT (test testListe)
>   where testListe =
>           [
>           -- Tests für die take-Funktion aus der Prelude (zur Demonstration von HUnit)
>             "take mit  0 und leerer Liste"  ~:  Prelude.take 0 ""        ~?=  ""
>           , "take mit  0 und voller Liste"  ~:  Prelude.take 0 "123"     ~?=  ""
>           , "take mit  2 und leerer Liste"  ~:  Prelude.take 2 ""        ~?=  ""
>           , "take mit  2 und voller Liste"  ~:  Prelude.take 2 "123"     ~?=  "12"
>           , "take mit  4 und voller Liste"  ~:  Prelude.take 4 "123"     ~?=  "123"
>           , "take mit -1 und leerer Liste"  ~:  Prelude.take (-1) ""     ~?=  ""
>           , "take mit -1 und voller Liste"  ~:  Prelude.take (-1) "123"  ~?=  ""
>
>           -- ...
>
>           ]
>           where leereIntListe :: [Int]
>                 leereIntListe = []

   a) Überlegt Euch sinvolle Testfälle für die vier Funktionen aus Aufgabe I.1)
      und erweitert den HUnit Test entsprechend. Achtet dabei auch auf
      Sonderfälle, wie leere Listen, negativen Indizes, usw.

> testTake = "testTake " ~: TestList [
>             "take mit  0 und leerer Liste"  ~:  take 0 ""        ~?=  ""
>           , "take mit  0 und voller Liste"  ~:  take 0 "123"     ~?=  ""
>           , "take mit  2 und leerer Liste"  ~:  take 2 ""        ~?=  ""
>           , "take mit  2 und voller Liste"  ~:  take 2 "123"     ~?=  "12"
>           , "take mit  4 und voller Liste"  ~:  take 4 "123"     ~?=  "123"
>           , "take mit -1 und leerer Liste"  ~:  take (-1) ""     ~?=  ""
>           , "take mit -1 und voller Liste"  ~:  take (-1) "123"  ~?=  ""
> 			]
>           where emptyList :: [Int]
>                 emptyList = []

> testConcat = "testConcat" ~: TestList [
> 				"concat mit []"				~: concat []				~?= emptyList
> 			,	"concat mit [1]"			~: concat ["1"] 			~?= "1"
> 			,	"concat mit [1, 2]"			~: concat ["1", "2"]		~?= "12"
> 			,	"concat mit [1, 2, 3]"		~: concat ["1", "2", "3"]	~?= "123"
> 			]
>           where emptyList :: [Char]
>                 emptyList = []


> testElem = "testConcat" ~: TestList [
> 				"elem mit 1 und []" 			~: elem 1 [] 			~?= False
> 			,	"elem mit 1 und [1]" 			~: elem 1 [1] 			~?= True
> 			,	"elem mit 1 und [2]" 			~: elem 1 [2] 			~?= False
> 			,	"elem mit 2 und [1,2,3]" 		~: elem 2 [1,2,3] 		~?= True
> 			,	"elem mit 4 und [1,2,3]" 		~: elem 4 [1,2,3] 		~?= False
> 			]

> testIndex = "testIndex" ~: TestList [
> 				"1234 !! 2" 	~: "1234" !! 2 		~?= '3'
> 			, 	"1234 !! 0" 	~: "1234" !! 0 		~?= '1'
> 				]

-- Wie tests mit errors ?

> runTests = runTestTT (test [testTake, testConcat, testElem, testIndex])

   b) Korrigiert eure Implementierungen, falls sich diese nicht immer wie
      erwartet verhalten.

   c) Optional:
      Versucht (beispielsweise mit Hilfe von Listkomprehensions) kombinatorisch
      Testfälle für eine Funktion zu generieren.
