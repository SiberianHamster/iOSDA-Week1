//: Playground - noun: a place where people can play

import UIKit

var someRandomString : String

func magicX (theString:String){
  var numberOfX = 0
  var indexNumberOfCharacters = -1
  
  for characters in theString{
    indexNumberOfCharacters++
    if characters == "x" {
      numberOfX++
    }
  }
  
  
  var whichXAreWeOn = 1
  var whereInIndex = 0
  
  for characters in theString{
    
    
    if characters == "x" {
      switch whichXAreWeOn {
      case 1:
        println("first x")
      case numberOfX:
        println("last x")
      default:
        someRandomString.removeAtIndex(whereInIndex)
        whereInIndex--
        numberOfX--
        indexNumberOfCharacters--
      }
      whichXAreWeOn++
    }
  whereInIndex++
  }

}
someRandomString = "hixxhixxxhix"

magicX(someRandomString)