
import UIKit


class fifo{
  var theQueue:[String]=[]
  
  func enqueue(itemToAdd: String){
    theQueue.append(itemToAdd)
  }
  
  func dequeue(){
    theQueue.removeAtIndex(0)
  }
}

var temp = fifo()

temp.enqueue("first item")
temp.enqueue("second item")
temp.theQueue
temp.dequeue()
temp.theQueue




