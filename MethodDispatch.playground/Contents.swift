import UIKit

var greeting = "Hello, playground"
 //MARK: NON-REQUIRED METHOD IN PROTOCOL - METHOD DISPATCH
//protocol Animal {
//    func makeSound()
//}
//
//extension Animal {
//    func makeSound() {
//        print("Generic animal sound")
//    }
//    
//    func eat() {
//        print("Animal eating")
//    }
//}
//
//struct Dog: Animal {
//    func makeSound() {
//        print("Woof")
//    }
//    
//    func eat() {
//        print("Dog eating")
//    }
//}
//
//let animal: Animal = Dog()
//animal.makeSound()
//animal.eat()

// MARK: when there's no override, the static dispatch is used. If there's override for the method, then the dynamic dispatch is used. 

//protocol A {
//    func fly()
//}
//
//extension A {
//    func fly() {
//        print("default fly")
//    }
//}
//
//class B: A {
//}
//
//class C: B {
//    func fly() {
//        print("c fly")
//    }
//}
//
//
//var c: A = C()
//c.fly()
//


//protocol Movable {
//    func walk()
//    func crawl()
//}
//
//
//extension Movable {
//    func crawl() {
//       print("Default crawling")
//    }
//}
//
//class Animal: Movable {
//    func walk() {
//        print("Animal Walking")
//    }
//    func crawl() {
//       print("Animal crawling")
//    }
//}
//
//class Dog: Animal {
//    override func crawl() {
//        print("Dog Crawling")
//    }
//}
//
//let wolf: Movable = Dog()
//wolf.walk()
//wolf.crawl()

// MARK: protocol has required method, class conforming to the protocol gives custom implementation, so that is used.

//protocol Animal {
//    func speak()
//}
//
//extension Animal {
//    func speak() {
//        print("Animal makes a sound")
//    }
//}
//
//class Dog: Animal {
//    func speak() {
//        print("furtttt sound")
//    }
//}
//
//let myAnimal: Animal = Dog()
//myAnimal.speak()


// MARK: when there's no override, the static dispatch is used. If there's override for the method, then the dynamic dispatch is used.
// since object is of type Hi, which uses the protocol default implementation of hello
//protocol Hello {
//  func hello()
//}
//
//extension Hello {
//    func hello() {
//    print("hiiiii")
//  }
//
//}
//
//
//class Hi: Hello {
//
//}
//
//class Hi2: Hi {
//    func hello() {
//    print("hi4443")
//  }
//}
//
//class Hi3: Hi2{
//    override func hello() {
//    print("hi3")
//  }
//}
//
//
//let a: Hi = Hi3()
//a.hello()
//let a: Hi2 = Hi3()
//a.hello()


//protocol FirstProtocol {
//    func doSomething()
//}
//
//extension FirstProtocol {
//    func doSomething() {
//        print("FirstProtocol default implementation")
//    }
//}
//
//protocol SecondProtocol: FirstProtocol {
//    func doSomethingElse()
//}
//
//extension SecondProtocol {
//    func doSomethingElse() {
//        print("SecondProtocol default implementation")
//    }
//}
//
//class MyClass: SecondProtocol {
//    func doSomething() {
//        print("MyClass implementation of doSomething")
//    }
//
//    func doSomethingElse() {
//        print("MyClass implementation of doSomethingElse")
//    }
//}
//
//let obj: FirstProtocol = MyClass()
//obj.doSomething() // MyClass implementation of doSomething

//protocol Fighter{
//   func fight() //Requirement
////    func punch() // Play by making it as requirement and non-requirement
//}
//
//extension Fighter{
//   //Requirement
//   func fight(){
//      self.punch()
//   }
//   //Static method (it is not required in the protocol)
//   func punch(){
//      print("Fighter punch")
//   }
//}
//
//class F: Fighter {
//    func fight(){
//       self.punch()
//    }
//    
//    func punch(){
//       print("Fightjjjer punch")
//    }
//}
//
////let f:Fighter = F()
////f.punch()
////f.fight()
//
//
//protocol MagicalFighter : Fighter{
//   func castSpell() //Requirement
//}
//extension MagicalFighter{
//   //Requirement
//   func castSpell(){
//      print("MagicalFighter casted a spell")
//   }
//   //Static
//   func punch(){
//      self.castSpell()
//      print("Magical fighter punch")
//  }
//}
//
//struct Hero : MagicalFighter{
//   func castSpell(){
//      print("Hero casted special spell")
//   }
//}
//
//let gordo = Hero()
//gordo.fight()

//protocol Animal {
//    func cry() -> String
//}
//
//extension Animal {
//    func cry() -> String {
//        return "..."
//    }
//
//    func sayHello() -> String {
//        return "Hello"
//    }
//}
//
//class Cat: Animal {
//    func cry() -> String {
//        return "Meow"
//    }
//    
//    func sayHello() -> String {
//        return "Purr"
//    }
//}
//
//var animal: Animal?
//animal = Cat()
//// 2
//// Witness table dispatch - class conforming to protocol with type as protocol
//animal?.cry() // meow
//// 3
//// this is statically dispatched to the protocol extension’s implementation because non-requirement methods don’t use a witness table, and the type is known to be an Animal.
//animal?.sayHello() // hello
//
//// 4
//var cat: Cat = Cat()
//// 5 VTable Dispatch
//cat.cry() // meow
//// 6 VTable Dispatch
//cat.sayHello() // purr

//protocol MyProtocol {
//    func foo(i1: Int, i2: Int)  // Protocol requirement
//}
//
//extension MyProtocol {
//    func foo(i1: Int = 0, i2: Int = 0) {
//        print("Protocol Extension")
//        foo(i1: i1, i2: i2)  // 🚨 Calls itself, leading to infinite recursion!, if concrete implementation is hidden
//    }
//}
//
//struct MyStruct: MyProtocol {
////    func foo(i1: Int, i2: Int) {
////        print("Concrete Implementation")
////    }
//}
//
//let obj: MyProtocol = MyStruct()
//obj.foo()  // 🚨 Calls the extension method, not MyStruct’s!
