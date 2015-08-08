//: Playground - noun: a place where people can play

import UIKit

var someRandomString : String
var outputString = ""
var temparray : [Character] = []

func magicX (theString:String)->String{
  var numberOfX = 0
  var indexNumberOfCharacters = -1
  
  for characters in theString{
    indexNumberOfCharacters++
    if characters == "x" {
      numberOfX++
    }
  temparray.append(characters) 
  }
  
  var whichXAreWeOn = 1
  var whereInIndex = 0
  
  for element in temparray{
    
    if element == "x" {
      switch whichXAreWeOn {
      case 1:
        println("first x")
      case numberOfX:
        println("last x")
      default:
      temparray.removeAtIndex(whereInIndex)
      println("removing x")

        whereInIndex--
        indexNumberOfCharacters--
      }
      whichXAreWeOn++
    }
    whereInIndex++
  }
  for element in temparray{
    outputString.append(element)
  }
  println("returning a string ' \(outputString)'")
  return outputString
}

someRandomString = "ax xxvx sx##@axxhsxh"
magicX(someRandomString)



