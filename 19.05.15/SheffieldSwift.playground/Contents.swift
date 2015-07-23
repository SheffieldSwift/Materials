//: ![Sheffield Swift](Swift.png)
//: ## @SheffieldSwift 19 May 2015
//: [https://github.com/SheffieldSwift/FirstMeeting](https://github.com/SheffieldSwift/FirstMeeting)
//: ### Swift is a powerful new language with some interesting features.
//: I'll be discussing a few of those today
//: * Swift is strictly typed with type inference
//: * Mutability versus immutability
//: * Difference between Class, Struct and enum instances and why that is important
//: * Optionals
//: * Enums

//: ### Swift is strictly typed and does type inference
var str = "Hello, playground"

//: str is declared as a variable which means its value can be changed.
str = "@SheffieldSwift says hello back"

//: Variables can't have their type changed from the type determined when they were declared.
// str = 3

//: #### So what is going on here?
//: Swift is stricly typed so the compiler gives every variable or constant a specific type, the type cannot be changed after the variable is declared. This is different to ruby where a variable can be reassigned to an object of any type. If a type isn't specified but the type can be inferred from the assigned value when the variable or constant is declared then the compiler gives the variable or constant a type. If the type cannot be inferred the compiler will emit an error message.
//: So the type of str is determined by the compiler at the point of decleration at compile time and is determined to be a string. I use the dynamicType property of a class or struct instance to inform us what the type is.
println("str type is: \(str.dynamicType)")

//: #### We can specify the type in the decleration
let newString:String = "Hello lovely people"

//: #### The types of str and newString are the same
println("newString type is: \(newString.dynamicType)")

//: #### Type inference works for any type the compiler can reasonably determine at compile time.
let myNum = 2
println("\(myNum.dynamicType)")

//: We can modify str
let c = str.removeAtIndex(str.startIndex)
str.append(c)

//: but can we modify newString

// newString.append(c)
println(newString)

//: So newString is a constant. newString is also a struct instance, not an object instance and I'll explain about why that is important later on.

//: A variable or a constant does not have to have an initial value as long as the property is assigned a value before it is accessed. In this case though the decleration requires the type to be specified. The compiler will not attempt to look ahead to infer the type from later information.

let theString:String

if str == "Hello, playground" {
    theString = "Hello, playground"
}
else {
    theString = "Help me"
}

println(theString)

//: ##### I would recommend that you always prefer let over var.

//: ### What is the difference between instances of Structs and Classes?

class Person {
    var firstName = ""
    let lastName:String
    
    init(firstName:String, lastName:String = "Serious") {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func printName() {
        println("\(firstName) \(lastName)")
    }
}

let someone = Person(firstName: "Shayleen")

//: So what happens when we try to change the person's name:
someone.firstName = "Katerina"
// someone.lastName = "SemiSerious"
someone.printName()

//: ##### Hey! someone has been declared as a constant but we can change their name.

struct City {
    var name = ""
    let country:String
    var population:Int
    
    init(cityName:String, country:String = "UK", population:Int) {
        name = cityName
        self.country = country
        self.population = population
    }
    
    func printCity() {
        println("City: \(name) in \(country) has population: \(population)")
    }
}

let myCity = City(cityName: "Sheffield", population: 525000)
// myCity.name = "Chesterfield"

myCity.printCity()

//: So what is going on here. The difference is how Swift treats Struct or Class instances. Instances of structs are passed by value, whereas instances of classes are passed by reference.

//: ##### What do we mean by this:
//: When you assign a struct instance to another property the instance is copied. If the property is declared with a let then the value itself is constant. Whereas if you assign a class instance to a let property then what you are assigning is the reference to the class instance, not the class instance itself. What is constant is the reference to the instance, that reference can't refer to a different class instance. When declaring a new type deciding on whether that type should be a struct or class type is important. [Copy a class instance](http://t.co/KN34IMcqxj)

//: Enum types behave like struct types. Instances of enum types are passed by value.

//: You can't have sub structs or sub classes of a struct.

// class BigCity: City { }

//: The word 'instance' is a more general term used to refer to objects of classes or structs. What in 'C' would be considered to be a primitive type like integer or float in Swift has as their equivalent Int/Float which are types that are Structs and that you can call functions on. In this sense Swift is similar to Ruby. Not the same but similar.

//: ### Optionals - An important feature of Swift but initially painful
//: If a property can't be assigned when declared then its value will be either undefined or nil. Some APIs return an Optional value, in Objective-C this implies that the API could return nil. Swift formalizes how what are nil values in Objective-C are treated.

//: An optional value either contains a value or contains nil. Optional values work exactly the same if the optional is a struct instance or a class instance. To indicate that a value might be an optional write a question mark after the type to mark the value as optional.

//: You can create an optional value with an initial value, nil or Optional.None. The compiler will treat the property differently if the property has not been assigned.
var optionalString:String? = "a string"

let optionalString2:String?
println(optionalString2.dynamicType)

//: Optional.None is different to undefined. If you have not set a property prior to it being accessed it is not by default set to Optional.None. Instead the compiler reports an error.
// println("\(optionalString2)")

let optionalString3:String? = nil
println(optionalString3)
println(optionalString3.dynamicType)

let optionalString4:String? = .None
println(optionalString3)
println(optionalString3.dynamicType)

//: You can unwrap the optional to access its value using ```if let``` like so:
if let aString = optionalString {
    println(aString)
}

//: After an optional value has been assigned a value you can set it back to nil.

optionalString = nil

if let aString = optionalString {
    println(aString)
}
else {
    println("optionalString is nil")
}

//: And then back again.

optionalString = "A new string"

//: Optional is an enum, the enum value .Some has an associated value whilst the enum value .None does not. The value associated with .Some is the value returned from the optional value when the optional is unwrapped. Assigning an optional property with nil or .None does the same thing.

optionalString = Optional.None

//: You can abbreviate that to:

optionalString = .None

//: You can also assign using the Optional .Some value.

optionalString = Optional.Some("An even newer string")

//: You wouldn't normally do this but it demonstrates what an optional really is.

struct WellHello {
    let name:String?
    let greeting:String
    
    init(message:String = "Well Hello!", name:String? = .None) {
        greeting = message
        self.name = name
    }
    
    func printMessage() {
        let theName = name ?? "Dolly"
        println("\(greeting) \(theName)")
    }
}

let hello1:WellHello? = WellHello()

//: You can unwrap an optional using the ? operator.

let theGreeting = hello1?.greeting

hello1?.printMessage()

//: #### Did you notice in the printMessage function the use of ??

//: This is called the nil coalescing operator. Effectively what it does is it checks to see if the value is nil, if it is nil it returns the value after the operator, otherwise it returns the unwrapped optional value.

//: If you know that an optional value will be valid at a certain point then you can use the ! operator. This operator does a forced unwrap of the optional value and if the value is nil/Optional.None then it will cause a crash.
var hello2:WellHello? = Optional.None
// hello2!.printMessage()

println("Do we get here? - we shouldn't if the above line is uncommented as it causes a crash")

hello2 = WellHello(name: "Louis", message: "It is nice to see you back here where you belong")

//: Even though the following force unwraps the name property because hello2 is optionally unwrapped theName remains an optional.
let theName = hello2?.name!

println(theName)
println("theName type: \(theName.dynamicType)")

//: You can force unwrap both.
let theName2 = hello2!.name!
println(theName2)
println("theName2 type: \(theName2.dynamicType)")

//: You can add more than one optional unwrap in each if statement. See the printMessageFrom function.
class GreetingsFrom {
    let country:String
    let greetingMessage:WellHello?
    
    init(country:String = "UK", greetingMessage:WellHello? = .None) {
        self.country = country
        self.greetingMessage = greetingMessage
    }
    
    func printMessageFrom() {
        if let theMessage = self.greetingMessage,
            let theName = theMessage.name {
            println("\(theName) from \(country) says: \(theMessage.greeting)")
        }
        else if let theMessage = self.greetingMessage {
            println("\(country) says: \(theMessage.greeting)")
        }
        else {
            println("Greetings from \(country)")
        }
    }
}

let greetingsFromUK:GreetingsFrom? = GreetingsFrom(greetingMessage: hello2)

let greetingsFromUKName = greetingsFromUK?.greetingMessage?.name

//: Because either of ? results can be operating on an optional without a value the result is also an optional but an optional of the type of name: String.

println("Type of greetingsFromUKName: \(greetingsFromUKName.dynamicType)")

greetingsFromUK!.printMessageFrom()

//: ## What next
//: There are a few more fundamental Swift topics which I'd like to cover but this is enough for today.
//: * Functions as first class objects in Swift
//: * Enums and associated values
//:   * Pattern matching on the enum and associated values (switch statements)
//:   * The Result type
//: ## @SheffieldSwift thanks you
//: ![Sheffield Swift](Swift.png)

