module MaybeAgda where 

data Natural : Set where
  zero : Natural
  next : Natural → Natural

one : Natural
one = next zero

two : Natural
two = next one

_+_ : Natural → Natural → Natural
_+_ zero k = k 
_+_ k zero = k
_+_ (next k1) k2 = next (k1 + k2)

_*_ : Natural -> Natural -> Natural
_*_ zero _ = zero
_*_ _ zero = zero
_*_ (next zero) k = k
_*_ k (next zero) = k 
_*_ (next k1) k2 = k1 + (k1 * k2) 

factorial : Natural → Natural
factorial zero = one
factorial (next k) = (next k) * (factorial (next k)) 

