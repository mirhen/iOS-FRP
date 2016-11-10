//: [Next](@next)
/*:
 
 ### Challenges
 
 Write the following functions: 
 
 1. `makeAllUppercase` that takes an array of `String`s and returns an array of `String`s; all the strings in the returned array should only contain uppercase characters
 2. `convertAllToString` that takes an array of `Int`s and returns an array of `String`s where every `Int` was transformed to a `String`
 3. `keepOnlyOdds` that takes an array of `Int`s and returns an array of `Int`s that only has odd numbers
 4. `startingWithA` that takes an array of `String`s and returns an array of `String`s that only contains `String`s that start with the (uppercase) letter `A`
 5. `computeProduct` that takes an array of `Int`s and returns a single `Int` that is the product of all the elements in the array
 6. `concatenateAll` that takes an array of `String`s and returns a `String` that is concatenates all the elements in the array
 
 */

func toUpperCase(s: String) -> String {
    return s.uppercased()
}

func makeAllUppercase(stringArray: [String]) -> [String] {
//    var uppercaseString: [String] = []
//    stringArray.forEach {uppercaseString.append($0.uppercased()) }
    
    let uppercaseString = stringArray.map { $0.uppercased() }
//    var uppercaseString = stringArray.map(toUpperCase)

    return uppercaseString
}
var stringArray = ["a","b","c","d","e"]
makeAllUppercase(stringArray: stringArray)

func convertAllToString(intArray: [Int]) -> [String] {
    let stringArray = intArray.map{(String($0))}
    return stringArray
}

var intArray = [1,2,3,4,5,]
convertAllToString(intArray: intArray)

func keepOnlyOdds(intArray: [Int]) -> [Int] {
    let oddArray = intArray.filter { $0 % 2 != 0 }
    return oddArray
}

keepOnlyOdds(intArray: intArray)

func startingWithA(stringArray: [String]) -> [String] {
    let aStringArray = stringArray.filter { $0.characters.first == "A"}
    return aStringArray
}
 let wordsArray = ["Yo", "awesome", "Apple", "bye", "Artichoke"]
startingWithA(stringArray: wordsArray)

func computeProduct(intArray: [Int]) -> Int {
    let stringedNums = intArray.reduce("") {($0 + String($1))}
    let combinedNum = Int(stringedNums)!
    return combinedNum
}

computeProduct(intArray: intArray)

func concatenateAll(stringArray: [String]) -> String {
    let concatenatedString = stringArray.reduce("") {$0 + $1}
    return concatenatedString
}

concatenateAll(stringArray: wordsArray)



