
> import Test.HUnit
> import Prelude hiding (map)
> import qualified Prelude


{- Aufgabe 1: 
Ganze Zahlen werden in einer Maschine als Bitstrings reprasentiert. Diese Bitreprasentation
kann man auch explizit berechnen, indem man eine Funktion toBitstring entwickelt, die
eine Liste von Wahrheitswerten als Resultat besitzt. -}

> toBitstring :: Int -> [Bool]
> toBitstring 0 = [ ]
> toBitstring i = (i `mod` 2 /= 0) : toBitstring (i `div` 2)

{- Zum Beispiel liefert toBitstring 13 das Resultat [True,False,True,True].
Entwickeln sie eine Funktion fromBitstring, die die Umkehrfunktion zu toBitstring
ist. Es muss also das folgende Gesetz gelten:

    fromBitstring . toBitstring = id

In fromBitstring kann die folgende Hilfsfunktion genutzt werden:

    fromEnum :: Enum a ⇒ a -> Int -}

{- Die Funktion fromBitstring als rekursive Funktion: -}

> fromBitstring'        :: [Bool] -> Int
> fromBitstring' []     = 0
> fromBitstring' (x:xs) = fromEnum x + 2 * fromBitstring' xs

{- Diese Funktion besitzt eine haufig wiederkehrende Struktur, so dass sie mit einerfold-Funktion
implementiert werden kann. Redefinieren sie fromBitstring so, dass sie mit einem fold
arbeitet: -}

> fromBitstring :: [Bool] -> Int
> fromBitstring = foldr (\a b -> fromEnum a + 2 * b) 0


> testFromBitstring = "fromBitstring" ~:
>           [ fromBitstring []          ~?= 0
>            ,fromBitstring [True]      ~?= 1 
>            ,fromBitstring [False]     ~?= 0 
>            ,fromBitstring sechs       ~?= 6 
>            ,fromBitstring dreizehn    ~?= 13 ]
>           where dreizehn =  toBitstring 13
>                 sechs    = toBitstring 6


> testFromBitstring' = "fromBitstring' ~?= fromBitstring" ~:
>           [ fromBitstring' xs ~?= fromBitstring xs
>               | xs <- [[], [False], [True], [True, False, True, True]]]

{- Aufgabe 2:
Die map-Funktion dient zur elementweisen Verarbeitung von Listen. Sie besitzt folgenden Typ

    map :: (a -> b) -> [a ] -> [b ]

Implementieren Sie map mit Hilfe einer rekursiven Funktion -}

> map          :: (a -> b) -> [a] -> [b]
> map f []     = []
> map f (x:xs) = (f x):(map f xs)

{- Implementieren Sie map mit Hilfe von foldr -}

> map' :: (a -> b) -> [a] -> [b]
> map' f = foldr ((:).f) [] 

-- Auch möglich
-- map' f = foldr (\a b -> (f a):b) []

> testMap = "map = Prelude.map" ~: 
>       [map show xs ~?= Prelude.map show xs
>        | xs <- [[], [1], [1,2,3], [1,1,1]]]

> testMap' = "map' = Prelude.map" ~: 
>       [map' show xs ~?= Prelude.map show xs
>        | xs <- [[], [1], [1,2,3], [1,1,1]]]

{- Aufgabe 3:
Gegeben sei die folgende Datenstruktur fur einen binären Baum. Dieses ist eine Erweiterung
der Baumstruktur aus der Vorlesung. Der Fork-Konstruktor besitzt eine 3. Komponente vom
Typ Int. In dieser wird gespeichert, wie viele Elemente der Baum enthalt.

Invariante: Wie in der Vorlesung auch, soll hier mit Baumen gearbeitet werden, die Nil nie als
Kind eines Fork-Knotens enthalten. -}

> data Tree a = Nil
>             | Leaf a
>             | Fork Int (Tree a) (Tree a)
>               deriving Show

{- Weiter seien die folgenden Funktionen vorgegeben: -}

> size                 :: Tree a -> Int
> size Nil             = 0
> size (Leaf x )       = 1
> size (Fork n t1 t2 ) = n

> conc        :: Tree a -> Tree a -> Tree a
> conc Nil t2 = t2
> conc t1 Nil = t1
> conc t1 t2  = Fork (size t1 + size t2 ) t1 t2

> fromList      :: [a ] -> Tree a
> fromList []   = Nil
> fromList [x]  = Leaf x
> fromList xs   = fromList ys `conc` fromList zs
>   where 
>       (ys, zs) = splitAt (length xs `div` 2) xs

{- size berechnet die Anzahl Elemente im Baum, conc konkateniert 2 Baume so, dass die Inva-
riante eingehalten wird und dass im Fork-Knoten die Anzahl Elemente im Baum gespeichert
wird, fromList konvertiert eine Liste in einen Baum -}

> testList = fromList [1,2,3,4,5,6,7,8,9,10]

{- Entwickeln Sie als erstes die Funktion toList, die die inverse Funktion zu fromList sein
soll, es muss also das Gesetz gelten
toList ◦ fromList = id
toList: -}

> toList                :: Tree a -> [a]
> toList Nil            = []
> toList (Leaf x)       = [x]
> toList (Fork _ t1 t2) = toList t1 ++ toList t2

{- Entwickeln Sie die Funktionen cons und snoc, die ein Element vorne bzw. hinten im Baum
einfugen. Achten Sie darauf, dass beide Funktionen in konstanter Zeit laufen. -}

{- cons :: a -> Tree a -> Tree a -}

> cons       :: a -> Tree a -> Tree a
> cons a Nil = error "invariant violation"
> cons a t   = (Leaf a) `conc` t

{- snoc :: Tree a -> a -> Tree a -}

> snoc       :: Tree a -> a -> Tree a
> snoc Nil a = error "invariant violation"
> snoc t a   = t `conc` (Leaf a)


{- Entwickeln Sie eine Funktion safeHead, die das erste Element eines Baumes berechnet.
safeHead ist eine totale Funktion. -}

{- safeHead :: Tree a -> Maybe a -}

> safeHead               :: Tree a -> Maybe a
> safeHead Nil            = Nothing
> safeHead (Leaf a)       = Just a
> safeHead (Fork _ t1 _) = safeHead t1

{- Fur¨ safeHead und cons muss das folgende Gesetz gelten
    safeHead (cons x t) = Just x -}

{- Der indizierte Zugriff auf Elemente einer Liste ist sehr ineffizient. Die Zeit hangt linar ab
von der Große des Index. Man erkennt dieses an der folgenden Beispiel-Implementierung
(drop(i-1) in atList). -}

> atList :: [a ] -> Int -> Maybe a
> atList xs i
>       | 0 <= i && i < length xs = Just (head (drop i xs))
>       | otherwise = Nothing 

{- Fur indizierte Zugriffe gilt die Konvention, dass das erste Element einer Liste oder eines Bau-
mes den Index 0 besitzt.
Auf Baumen kann man ebenfalls einen indizierten Zugriff implementieren (atTree), der dann
aber noch ineffizienter wird, als der Zugiff auf die Listen. -}

> atTree :: Tree a -> Int -> Maybe a
> atTree t i = atList (toList t) i

{- Die Speicherung der Anzahl der Elemente in den Fork-Knoten ermoglicht es, die size- 
Funktion in konstanter Zeit zu implementieren. Zusatzlich kann diese Speicherung auch Ge-
winn bringend fur einen effizienteren indizierten Zugriff genutzt werden. Möchte man an einem
Fork-Knoten auf das i-te Element zugreifen, so kann man an Hand der Anzahl der Elemente
im linken Teilbaum entscheiden, ob der Index in den linken oder den rechten Teilbaum zeigt.

Implementieren Sie die Funktion at, so dass diese immer das gleiche Resultat liefert wie
atTree, nur viel effizienter arbeitet.

    at :: Tree a -> Int -> Maybe a
-}


> at :: Tree a -> Int -> Maybe a
> at Nil _ = Nothing
> at t n | 0 > n || n >= (size t) = Nothing
> at (Leaf a) 0 = Just a
> at (Fork _ l r) i 
>       | i < sizeL = at l i
>       | otherwise = at r (i - sizeL)
>       where sizeL = size l

> testAt = "at ~?= atTree" ~: 
>       [ at tree i ~?= atTree tree i
>       | tree <- [Nil, Leaf 10 , fromList [0..1], fromList [0..2], fromList [0..9]],
>         i <- [0..size tree] ]

{- Entwickeln Sie eine map-Funktion fur¨ Tree, die analog zur map-Funktion fur Listen arbeitet. -}

> mapTree :: (a -> b) -> Tree a -> Tree b
> mapTree _ Nil = Nil
> mapTree f (Leaf a) = Leaf (f a)
> mapTree f (Fork s l r ) = Fork s (mapTree f l) (mapTree f r)

{- Wie bei Listen kann man auch auf Baumen eine ¨ filter-Funktion implementieren: -}

{- Hilffunktion zum Trimmen von Bäumen -}

> prune :: Tree a -> Tree a
> prune (Fork _ Nil Nil) = Nil
> prune (Fork _ Nil r) = r
> prune (Fork _ l Nil) = l
> prune x = x



> filterTree :: (a -> Bool) -> Tree a -> Tree a 
> filterTree _ Nil = Nil
> filterTree p node@(Leaf a) 
>           | p a = node
>           | otherwise = Nil
> filterTree p (Fork n l r) = prune (Fork (size filteredL + size filteredR) filteredL filteredR)
>           where filteredL = (filterTree p l)
>                 filteredR = (filterTree p r)




