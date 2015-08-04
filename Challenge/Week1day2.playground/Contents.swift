//CODING CHALLENGE: FIZZ BUZZ!! :
//Print the numbers 1..100
//For multiples of 3, print "Fizz" instead of the number
//For multiples of 5, print "Buzz" instead of the number
//For multiples of 3 and 5, print "FizzBuzz" instead of the number


import UIKit

var i = 1

while (i<101){
  if (i % 3 == 0 && i % 5 == 0){println("FizzBuzz")}
  else if (i % 3 == 0 && i % 5 != 0){println("Fizz")}
  else if (i % 5 == 0 && i % 3 != 0){println("Buzz")}
  else {println(i)}
  i++
}
