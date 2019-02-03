fertig
Aufgabe 3
=========

Thema: Funktionen, Guards, Muster


Benennung des Moduls für diese Aufgabe:

> module Ueb03 where

Das Standard Modul Prelude importieren und dabei die bereits vordefinierte
Funktion splitAt verstecken, um sie selbst implementieren zu können:

> import Prelude hiding (splitAt)


I. Definition einfacher Funktionen
----------------------------------

1) a) Was macht die Funktion "splitAt"?

> splitAt :: Int -> [a] -> ([a], [a])
> splitAt n xs  = (take n xs, drop n xs)

Spaltet die Liste in 2 Listen an Position n.


   b) Definiert eine Funktion "splitHalf", die eine Liste
      mit einer geraden Länge in ein Paar mit zwei gleichlangen Listen aufteilt.
      Bei einer Liste mit ungerader Länger soll die erste Ergebnisliste um ein
      Element kürzer sein als die zweite (siehe Beispiel).
      Nutzt für die Definition die Funktion "splitAt" und weitere passende
      Funktionen aus dem Prelude-Modul und keine Muster.
      Beispiele:
        splitHalf [1,2,3,4]   ergibt   ([1,2], [3,4])
        splitHalf [1,2,3]     ergibt   ([1],   [2,3])
        
> splitHalf :: [a] -> ([a], [a])
> splitHalf xs = splitAt (length xs `div` 2) xs



2) Gesucht ist eine Funktion "evenLength", die entscheiden soll ob die Länge
   einer Liste (mit beliebigem Elementtyp) gerade ist oder nicht.
   Beispiele:
     evenLength [1,2,3]   ergibt   False
     evenLength [True, False]   ergibt   True

   a) Überlegt euch zunächst einen Typ für diese Funktion

> evenLength :: [a] -> Bool

   b) Definiert nun die Funktion "evenLength" unter Verwendung der Funktionen
      "length", "mod" und "(==)".
      Diese sind bereits im Standard Modul "Prelude" definiert und können daher
      einfach verwendet werden.
      (siehe auch https://hackage.haskell.org/package/base-4.8.1.0/docs/Prelude.html)
 evenLength xs = even (length xs)
 
> evenLength xs = length xs `mod` 2 == 0


3) a) Schreibt eine Funktion "sndSnd :: (a, (b, c)) -> c", die aus zwei
      geschachtelten Paaren die zweite Komponente der zweiten Komponente
      zurückgibt. Nutzt hierfür nur Funktionen aus der Prelude.
      Beispiele:
        sndSnd (1, (2, 3))   ergibt   3
        sndSnd ((3,4.5,6), ('x', [True]))   ergibt   [True]
        
> sndSnd :: (a, (b, c)) -> c
> sndSnd a = snd (snd a)


 sndSnd (_, (_, a)) = a


   b) Ist diese Funktion total oder partiell?
      Begründet eure Antwort.
      
Total, da es keinen Fall gibt, der nicht gültig ist.
Per Funktionstyp: Tupel hat immer 2 Komponenten. 2te Komponente hat auch immer genau 2 Komponenten



4) Entwickelt eine Funktion "firstIndex", die das erste Element einer Liste
   nimmt und damit das n-te Element (bei 0 angefangen zu zählen) der selben
   Liste auswählt.
   Fehlerhafte Aufrufe (leere Listen) müssen (noch) nicht abgefangen werden.
   Beispiele:
     firstIndex [2,3,4,5,6]   ergibt   4
     firstIndex [0,3,4,5,6]   ergibt   0

   a) Welchen Elementtyp darf die Liste nur besitzen?
   
Int, da wir indexbasiert auf die Liste zugreifen müssen

> firstIndex :: [Int] -> Int



   b) Definiert nun die Funktion firstIndex.
      Verwendet auch hier nur Funktionen aus der Prelude.

> firstIndex (x:xs) = (x:xs) !! x


   c) Was passiert, wenn firstIndex mit einer leeren Liste aufgerufen wird (und warum)?
      (Solltet ihr diesen Fall in eurer Implementierung schon berücksichtigt
      haben, beschreibt was passiert, wenn ihr dies nicht getan hättet.)

Exception: kein Muster passt

   d) Was passiert, wenn firstIndex mit der Liste [1] aufgerufen wird (und warum)?
   
Index out of range:

	firstIndex [1]
<=> firstIndex [1:[]]
<=> [1] !! 1
<=> Index out of range



II. Guards (Wächter)
--------------------

Die Funktion "splitHalf" aus der ersten Aufgabe produziert bei Listen mit einer
ungerader Länge zwei unterschiedlich lange Teillisten.
Es kann hilfreich sein diesen Fall abzufangen:

> splitHalf'    :: [a] -> ([a], [a])


 splitHalf' xs = if even (length xs)
                    then splitHalf xs
                    else error "Listenlaenge ist ungerade!"

1) a) Schreibt die Funktion splitHalf' so um, dass sie mit Wächtern/Guards
      arbeitet und nicht mit einer Verzweigung (if ... then ... else)
      Ihr könnt diese neue Funktion splitHalf'' nennen.
      
> splitHalf' xs
> 	| evenLength xs = splitHalf xs
> 	| otherwise = error "Listenlaenge ist ungerade!"
      
      
   b) Entwickelt eine weitere Funktion splitHalf2, die bei Listen mit ungerader
      Länge das mittlere Element in beide Teillisten packt.
      Ihr könnt diese Funktion entweder mit einer Verzweigung oder mit Guards
      implementieren.
      Beispiele:
        splitHalf2 [1,2,3,4]  ergibt  ([1,2],[3,4])
        splitHalf2 [1,2,3]    ergibt  ([1,2],[2,3])
        splitHalf2 "hallo"    ergibt  ("hal","llo")
        
> splitHalf2    :: [a] -> ([a], [a])
> splitHalf2 xs
> 		| evenLength xs = splitHalf' xs
>		| otherwise = (take (middle+1) xs, drop middle xs)
> 		where middle = length xs `div` 2




III. Verzweigungen und Muster
-----------------------------

1) a) Disjunktion:
      Schreibt (analog zur Funktion (&&) aus der Vorlesung) mindestens 2
      Definitionen der Funktion für die Disjunktion:
      "(||) :: Bool -> Bool -> Bool"
      Nutzt hierfür bei einer Definition eine Verzweigung
      (if ... then ... else ...) und bei mindestens einer weiteren den
      Mustervergleich (Pattern matching).

      Da die Funktion (||) bereits im Prelude-Modul definiert ist, solltet ihr
      diese nicht mit importieren. Fügt hierzu einfach den Funktionsnamen oben
      beim Import von Prelude im "hiding"-Bereich mit an:
      > import Prelude hiding (splitAt, (||))

      Um keinen Namenskonflikt zu bekommen, wenn ihr die Funktion selbst
      mehrmals definieren wollt, könnt ihr die Funktionen einfach (||), (|||),
      usw. nennen.

	  
> (|||) :: Bool -> Bool -> Bool	  
> (|||) a b = if a 
>			then a 
>			else b 

> (||||) ::  Bool -> Bool -> Bool
> False |||| False = False
> _ |||| _ = True


   b) Definiert (ebenfalls mit Hilfe eines Mustervergleichs) eine Funktion
      "lst3", die nur 3-elementige Listen (mit beliebigem Elementtyp)
      verarbeiten kann und diese in ein Tupel mit den gleichen Elementen
      konvertiert.
      Beispiele:
        lst3 [1,2,3]   ergibt   (1,2,3)
        lst3 "abc"   ergibt   ('a','b','c')

      Überlegt Euch hierfür zunächst den Typ dieser Funktion.

> lst3 :: [a] -> (a, a, a)


      Für Listen mit mehr oder weniger als drei Elementen muss die Funktion
      nicht definiert sein, sie ist also partiell.

> lst3 [x, y, z] = (x, y, z)


   c) Schreibt eine Funktion "sndLst :: [a] -> a", die mit Hilfe eines
      Mustervergleichs (analog zur Funktion "snd") das zweite Element einer
      beliebig langen Liste ausgibt.
      Beispiel:
        sndLst [1,2,3,4]   ergibt   2

      Für Listen mit weniger als zwei Elementen muss die Funktion nicht
      definiert sein.
	  
> sndLst :: [a] -> a
> sndLst [x,x2,xs] = x2



IV. freiwillige Zusatzaufgabe: curry-Funktion
---------------------------------------------

Aus der Vorlesung sollte bereits bekannt sein:

> add :: (Int, Int) -> Int
> add (x, y) = x + y

> add' :: Int -> Int -> Int
> add' x y   = x + y

1) Wie muss die funktionsverarbeitende Funktion "curry" definiert werden,
   damit sie aus der Funktion "add" die Funktion "add'" macht?
   Es muss also "add' = curry add" gelten.
   --> Denkt auch hier daran, die Funktion "curry" beim import der Prelude im
       "hiding"-Bereich mit anzugeben, um einen Namenskonflikt zu vermeiden.
	   
> my_curry :: ((a, b) -> c) -> (a -> b -> c)
> my_curry f = \x y -> f(x, y)
