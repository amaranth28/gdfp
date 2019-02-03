{- Aufgabe 1:
elem und filter sind zwei haufig verwendete, vordefinierte Funktionen zum Suchen in und ¨
Selektieren aus Listen.

    elem :: Eq a ⇒ a → [a ] → Bool
    elem x [ ] = False
    elem x (y : ys) = x == y || elem x ys
    
    filter :: (a → Bool) → [a ] → [a ]
    filter p [ ] = [ ]
    filter p (x : xs)
        | p x = x : filter p xs
        | otherwise = filter p xs

Entwickeln Sie eine Funktion elem1 mit gleicher Funktionalitat wie ¨ elem, die aber die Berechnung mit Hilfe von filter durchfuhrt. Nutzen Sie bei der Definition, wenn m ¨ oglich, die ¨
Funltionskomposition (.) aus. -}

> testList = [1,2,3,4]

> elem1 :: Eq a => a -> [a] -> Bool
> elem1 x = not.null.(filter (\y -> x == y))

{- Entwickeln Sie eine Funktion elem2 mit gleicher Funktionalitat wie ¨ elem, die aber mit
foldr arbeitet.

    foldr :: (a → b → b) → b → [a ] → b
    
Der Code fur¨ elem2 -}

> elem2 x = foldl (\a b -> b || a == x) False

{- Entwickeln Sie eine Funktion elem3 mit gleicher Funktionalitat wie ¨ elem, die aber mit
foldl arbeitet.

    foldl :: (b → a → b) → b → [a ] → b
    
Der Code fur¨ elem3 -}

> elem3 x = foldl (\b a -> b || a == x) False


