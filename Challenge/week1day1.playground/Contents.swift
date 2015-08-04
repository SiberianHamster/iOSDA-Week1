
//CODING CHALLENGE: Write a function that reverses an array
import UIKit

//long way
var testArray=["Bob","Sam","Dude","hi"]

func reverseTheArray(anArray:[String])->[String]{
  let maxElementsInArray = anArray.count
  var i = 0
  var tempArray=[String]()
  while(i<maxElementsInArray){
    tempArray.append(anArray[maxElementsInArray-1-i])
    i++
  }
  return tempArray
}
testArray = reverseTheArray(testArray)



//short way
testArray=["Bob","Sam","Dude","hi"]

func easyReverse(anArray:[String])->([String]){
  var temparray = anArray
  temparray = anArray.reverse()
  return temparray
}

easyReverse(testArray)


