{- Aufgabe 1:
Gegeben seien folgende kleine Funktionen und Pradikate ¨-}

> toUpper :: Char -> Char
> toUpper c
>     | isLower c =
>         toEnum (fromEnum c - fromEnum 'a' + fromEnum 'A')
>     | otherwise = c

> isSpace :: Char -> Bool
> isSpace c =
>        c == ' ' -- blank
>     || c == '\n' -- linefeed
>     || c == '\t' -- tabulator

> isAlpha :: Char -> Bool
> isAlpha c = isUpper c || isLower c

> isUpper :: Char -> Bool
> isUpper c = c >= 'A' && c <= 'Z'

> isLower :: Char -> Bool
> isLower c = c >= 'a' && c <= 'z'

> isCL :: String -> Bool
> isCL ('_' : c1 : _) = isLower c1
> isCL cs = False

{- Entwickeln Sie die fogenden Funktionen mit Hilfe der hier vorgegebenen und der vordefinierten
Funktionen. Nutzen Sie, wenn moglich, anstatt expliziter Rekursion vordefinierte Funktionen ¨
fur das rekursive Verarbeiten von Listen. ¨
Entwickeln Sie eine Funktion wordToUpper, die in einem String alle Kleinbuchstaben in
Großbuchstaben transformiert.

    wordToUpper :: String -> String 
-}

> wordToUpper :: String -> String
> wordToUpper = map toUpper

{- Entwickeln Sie eine Funktion wordToCapital, die nur den Anfangsbuchstaben (erstes Zeichen) in einen Großbuchstaben transformiert.

    wordToCapital :: String -> String 
-}

> wordToCapital :: String -> String
> wordToCapital [] = []
> wordToCapital (c:cs) = (toUpper c) : cs

{- Entwickeln Sie eine Funktion wordsToUpper, die in allen Worter einer Liste alle Buchstaben ¨
in Großbuchstaben transformiert.

    wordsToUpper :: [String] -> [String]
-}

> wordsToUpper :: [String] -> [String]
> wordsToUpper = map wordToUpper

{- Entwickeln Sie eine Funktion wordsToCapital, die fur alle W ¨ orter in einer Liste den An- ¨
fangsbuchstaben zu einem Großbuchstaben macht.

    wordsToCapital :: [String] -> [String]
-}

> wordsToCapital :: [String] -> [String]
> wordsToCapital = map wordToCapital


{- Entwickeln Sie eine Funktion toCamelCase, die in einem String alle Zeichenkombinationen
aus einem Unterstrich und einem Kleinbuchstaben (siehe isCL) durch den entsprechenden
Großbuchstaben ersetzt:

    toCamelCase "get_money" == "getMoney"
    toCamelCase :: String -> String
-}

> toCamelCase :: String -> String
> toCamelCase [] = []
> toCamelCase word@(c:cs) 
>       | isCL word = toCamelCase (wordToCapital cs) -- ersten c abschneiden (_) und ersten buchstaben groß
>       | otherwise = c:(toCamelCase cs) -- ersten c beibehalten und rest in camcelCase transforieren

{- Aufgabe 2:
Gegeben sei die folgende Datenstruktur fur B ¨ aume, die vier Arten von Knoten besitzen. In ¨
allen Knotenarten wird ein Wert eines Typs a gespeichert. Bei der ersten Auspragung wird ¨
keine weitere Information gespeichert, bei der zweiten hangt zus ¨ atzlich links ein Teilbaum, bei ¨
der dritten rechts und bei der vierten auf beiden Seiten. -}

> data Tree a = TLeaf a
>             | TLeft (Tree a) a
>             | TRight a (Tree a)
>             | TBin (Tree a) a (Tree a)


{- Mit der Funktion flatten konnen die Elemente aus dem Baum extrahiert und in einer Liste ¨
gesammelt werden. Die Elemente sind in der Liste in der gleichen Reihenfolge wie im Baum
gespeichert. -}

> flatten :: Tree a -> [a]
> flatten (TLeaf x ) = [x]
> flatten (TLeft l x ) = flatten l ++ [x]
> flatten (TRight x r ) = x : flatten r
> flatten (TBin l x r ) = flatten l ++ [x] ++ flatten r

> smartFlatten :: Tree a -> [a]
> smartFlatten t = consTree t []

{- flatten ist ineffizient, da in dieser Funktion viel mit (++) gearbeitet wird. Die Laufzeit dieser Operation hangt linear von der L ¨ ange des linken Operanden ab. Die Funktion ¨ smartFlatten
versucht dieses besser zu machen. Sie ruft eine Funktion consTree mit dem Baum und einer
leeren Liste auf. Diese consTree-Funktion bestimmt also die Laufzeit von smartFlatten
Entwickeln Sie die Funktion consTree so, dass sie alle Elemente des Baumes (1. Argument)
vor die Liste (2. Argument) packt. smartFlatten soll immer das gleiche Ergebnis liefern
wie flatten, die Funktion soll aber in einer Rechenzeit proportional zur Anzahl der im Baum
gespeicherten Werte laufen. 

    consTree :: Tree a -> [a] -> [a]

-}

> consTree :: Tree a -> [a] -> [a]
> consTree (TLeaf x) xs = x:xs
> consTree (TLeft l x) xs = consTree l (x:xs)
> consTree (TRight x r) xs = x:(consTree r xs)
> consTree (TBin l x r) xs = consTree l (x:(consTree r xs))

{- Lauft ¨ smartFlatten in einer Zeit proportional zur Lange der Resultat-Liste? -}

Nein, da immer vorne an die Liste angehängt wird und das in konstanter Zeit geschiet.


{- Entwickeln Sie eine Funktion leftmost, die aus einem Baum das am weitesten links stehende
Element selektiert, es soll also gelten leftmost t = head (flatten t)

    leftmost :: Tree a -> a
-}

> leftmost :: Tree a -> a
> leftmost (TLeaf x) = x
> leftmost (TLeft l _) = leftmost l
> leftmost (TRight x _) = x
> leftmost (TBin l _ _) = leftmost l

{- Ist leftmost eine totale Funktion? -}

Ja, da für jeden Konstruktor ein "linkes" Element definiert ist und der Baum nicht leer sein kann. 

{- Aufgabe 3:
isPrefix sei ein Pradikat, das testet, ob eine Liste ¨ xs ein Anfangsstuck einer zweiten Liste ¨
ys ist, das heisst, alle Elemente der ersten Liste stehen am Anfang der zweiten Liste. Es muss
also gelten:

    xs == take (length xs) ys

Entwickeln Sie das Pradikat so, das es dieses Gesetz erf ¨ ullt. Dieses Gesetz bildet eine pr ¨ azise ¨
Spezifikation, ist als Implementierung aber aus Effizenzgrunden nicht sinnvoll. ¨

    isPrefix :: Eq a ⇒ [a] -> [a] -> Bool
-}

> isPrefix :: Eq a => [a] -> [a] -> Bool
> isPrefix (x:xs) [] = False
> isPrefix [] _ = True
> isPrefix (x:xs) (y:ys) = x == y && (isPrefix xs ys)

{- tails ist eine Funktion, die zu einer Liste xs alle Endstucke dieser Liste berechnet. Es ¨
gilt tails "abc" == ["abc","bc","c",""], Das Resultat ist also eine Liste deren
Lange um 1 gr ¨ oßer ist als die L ¨ ange der Argumentliste. ¨

    tails :: [a] -> [[a]]
-}

> tails :: [a] -> [[a]]
> tails [] = [[]]
> tails (x:xs) = (x:xs) : (tails xs)

{- or ist eine vordefinierte Funktion.

    or :: [Bool ] → Bool
    or xs = foldl ( || ) False xs
    
Entwickeln Sie ein Pradikat ¨ containsPrefix, mit dem getestet wird, ob eine Liste xs
Prefix eines Elementes einer Liste yss ist. Es gilt also:

    containsPrefix "abc" ["xabc", "a", ""] == False
und
    containsPrefix "a" ["xabc", "a", ""] == True.
    
Nutzen Sie dabei ausschließlich isPrefix, map und or.

    containsPrefix :: Eq a ⇒ [a ] → [[a ]] → Bool
-}














{- Testvariablen -}

> worte = ["Hallo", "mein", "Name", "ist", "Cedric"]
> wort = head worte

> myTree = (TBin (TBin (TLeft (TRight 1 (TLeaf 2)) 3) 4 (TRight 5 (TRight 6 (TLeaf 7)))) 8 (TLeaf 9))



{-





















-}
