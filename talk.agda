module Talk where 

open import Agda.Builtin.IO using (IO)
open import Agda.Builtin.Unit using (⊤)
open import Agda.Builtin.String using (String)

open import Relation.Binary.PropositionalEquality 

postulate putStrLn : String → IO ⊤
{-# FOREIGN GHC import qualified Data.Text as T #-}
{-# COMPILE GHC putStrLn = putStrLn . T.unpack #-}

data Colour : Set where 
  green : Colour 
  blue : Colour 
  red : Colour 

colourname : (c : Colour) -> String
colourname green = "green"
colourname _ = "not green"

identity : (A : Set) -> A -> A 
identity _ a = a

data List (A : Set) : Set where 
  empty : List A 
  nonempty : A -> List A -> List A

concat : { A : Set } -> List A -> List A -> List A 
concat empty l = l 
concat (nonempty head tail) l = nonempty head (concat tail l )

data Natural : Set where 
   zero : Natural 
   next : Natural -> Natural 

one : Natural 
one = next zero 

_+_ : Natural -> Natural -> Natural 
zero + n = n 
(next n ) + m = next ( n + m )


length : { A : Set } -> List A -> Natural 
length empty = zero 
length (nonempty head tail) = next (length tail) 

-- Let's prove that length of concat of two lists is the sum of the length of the two lists , ie
-- length ( list1 ++ list2 ) = length (list) + length (list) 

-- Technique 1 : explicit. List is defined as before, tne the property is a new value 

proofConcat : { A : Set } -> (l : List A) -> (l2 : List A) -> length (concat l l2) ≡ (length l) +  (length l2) 
proofConcat empty _ = refl 
proofConcat (nonempty head tail) l = cong next (proofConcat tail l)

-- approach 2: by construction (ie, introduce SizedList which keeps track of the size of the list) 

data SizedList (A : Set) : Natural -> Set where
  empty1 : SizedList A zero 
  nonempty1 : {n : Natural} -> A -> SizedList A n -> SizedList A (next n)

concat2 : {A : Set} -> {n m : Natural} -> SizedList A n -> SizedList A m -> SizedList A (n + m) 
concat2 empty1 l = l 
concat2 (nonempty1 head tail) l = nonempty1 head (concat2 tail l) 

main : IO ⊤
main = putStrLn (identity String (colourname green))


