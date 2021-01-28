/*
 Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.

 Assume the environment does not allow you to store 64-bit integers (signed or unsigned).

 Example 1:

 Input: x = 123
 Output: 321
 
 Example 2:

 Input: x = -123
 Output: -321
 Example 3:

 Input: x = 120
 Output: 21
 Example 4:

 Input: x = 0
 Output: 0
  

 Constraints:

 -231 <= x <= 231 - 1
*/

class Solution {
    
    func reverse(_ x: Int) -> Int {
        var initialValue = x
        guard initialValue != 0 else { return initialValue }
        
        let allowedRange = Int(Int32.min) ... Int(Int32.max)
        
        var isNegative = false
        
        if initialValue < 0 {
            isNegative = true
            initialValue = abs(initialValue)
        }
        
        var stringValue = String(initialValue)
        if stringValue.last == "0" {
            stringValue.removeLast()
        }
        
        var characterArray = [Character]()
        for character in stringValue {
            characterArray.append(character)
        }
        characterArray.reverse()
        
        let preFinalString = String(characterArray)
        let finalInt = Int(preFinalString)!
        
        guard allowedRange.contains(finalInt) else { return 0 }
        
        return isNegative ? -finalInt : finalInt
    }
}
