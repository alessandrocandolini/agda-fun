module Colour where 

open import Agda.Builtin.IO 
open import Agda.Builtin.Unit 
open import Agda.Builtin.String using (String)

open import Relation.Binary.PropositionalEquality

postulate putStrLn : String → IO ⊤
{-# FOREIGN GHC import qualified Data.Text as T #-}
{-# COMPILE GHC putStrLn = putStrLn . T.unpack #-}

data Colour : Set where 
   Green Blue Red : Colour

colourName : Colour -> String 
colourName Green = "Green"
colourName Red = "Green"
colourName Blue = "Green"

data Maybe (A : Set) : Set where 
    none : Maybe A 
    some : A -> Maybe A 

x : Maybe Colour 
x = some Green 

y : Maybe Colour 
y = none 

data List (A : Set) : Set where 
    empty : List A 
    nonempty : A -> List A -> List A 

concat : {A : Set} -> List A -> List A -> List A 
concat empty l = l 
concat (nonempty h t) l = nonempty h (concat t l) 

data Natural : Set where 
   zero : Natural 
   next : Natural -> Natural 

one : Natural 
one = next zero   

_+_ : Natural -> Natural -> Natural 
zero + n = n 
(next n) + m = next (n + m)

length : {A : Set} -> List A -> Natural 
length empty = zero 
length (nonempty h t) = next (length t)

check : {A : Set} -> (l1 : List A) -> (l2 : List A) -> length (concat l1 l2) ≡ (length l1) + (length l2) 
check empty _ = refl
check (nonempty h l) l' = cong next (check l l')

data SizedList (A : Set) : Natural -> Set where
  empty1 : SizedList A zero 
  nonempty1 : {n : Natural} -> A -> SizedList A n -> SizedList A (next n) 

concat1 : {A : Set} -> {n m : Natural} -> (l : SizedList A n) -> (l' : SizedList A m) -> SizedList A (n + m)
concat1 empty1 l = l 
concat1 (nonempty1 h t) l = nonempty1 h (concat1 t l)


identity : {A : Set} -> A -> A
identity a = a

main : IO ⊤
main = putStrLn (colourName Green)
