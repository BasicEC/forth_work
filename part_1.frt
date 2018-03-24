( is_even, is_prime, concat, Collatz )

( num -- answer )
: is_even 2 % if 0 else 1 then ;

: inc 1 + ;
: dec 1 - ;

: check_321 2 < if 0 else 1 then ;

: check_4_and_greater
dup 2 1 >r
do
dup r@ % not 
if r> r> r> drop 0 >r >r r@ >r drop then
loop drop r> ;

( num -- addr )
: is_prime 
dup 4 < if check_321 
else check_4_and_greater 
then 1 allot dup rot swap ! ;

( buf addr -- buf )
: str-move ( buf addr )
dup count ( buf addr len )
>r dec r>
inc 0
do ( buf addr )
inc
>r dup r@  ( buf buf addr ) ( max i addr )
c@ swap r> r@ rot + swap >r c! r> ( buf addr )
loop heap-free ;

( addr1 addr2 -- buf )
: concat 
swap ( addr2 addr1 )
dup count >r ( addr2 addr1 ) ( len1 )
swap dup count ( addr1 addr2 len2 )
r@ + inc heap-alloc ( addr1 addr2 buf ) ( len1 )
rot str-move ( addr2 buf ) ( len1 )
dup r> + rot ( buf buf+len1 addr2 )
str-move drop ( buf ) ;

: p_stack dup . ."  " ;

: Collatz
dup 1 = not if 
repeat
p_stack
dup 2 %
if 3 * inc
else 2 /
then dup 1 = until . ;