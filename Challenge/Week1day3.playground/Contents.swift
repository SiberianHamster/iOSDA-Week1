//CODING CHALLENGE: Return the number of times that the string "hi" appears anywhere in the given string.

import UIKit


var someRandomString = "hijhih iHiHIhIhi"
var isLetterH = false
var count = 0

for character in someRandomString {
  println(character)
  
  switch character {
  case "h":
    isLetterH = true
  case "i":
    if isLetterH == true{
      count++}
    isLetterH = false
  default:
    isLetterH = false
  }
}
println(count)

