# Архивиране и Сериализация:

## JSON
JSON, или JavaScript Object Notation, е текстово базиран отворен стандарт създаден за човешки четим обмен на данни. Произлиза от скриптовия език JavaScript, за да представя прости структури от данни и асоциативни масиви, наречени обекти. Въпреки своята връзка с JavaScript, това е езиково независима спецификация, с анализатори, които могат да преобразуват много други езици в JSON.

Форматът на JSON често е използван за сериализация и предаване на структурирани данни през Интернет връзка. Използва се главно, за да предаде данни между сървър и Интернет приложение, изпълнявайки функциите на алтернатива на XML.

Базовите типове данни на JSON са Number(число), String(символен низ), Boolean (true/false), Array(списък, записва се с квадратни скоби, елементите са разделени със запетая), Object (записва се с къдрави скоби, неопределена колекция от двойки ключ-стойност, които се разделят с ":", елементите са разделени със запетая) и null (празна стойност).

### JSON примери
```json
{
    "name": "Ivancho",
    "id": 1,
    "favoriteToy": {
        "name":"Robot"
    }
}
```

```json
{
    "firstName": "John",
    "lastName": "Smith",
    "age": 25,
    "address": {
        "streetAddress": "21 2nd Street",
        "city": "New York",
        "state": "NY",
        "postalCode": "10021"
    },
    "phoneNumber": [
        {
            "type": "home",
            "number": "212 555-1234"
        },
        {
            "type": "fax",
            "number": "646 555-4567"
        }
    ]
}
```

## Codable
Преди Swift 4, за да сериализираме някой обект, той трябваше да е наследник на `NSObject` (Objective-C клас) и да имплементира `NSCoding` протокола, а за типове като `struct` и `enum` се използваха различни хакове.
В Swift 4 е добавена сериализация на всички наименовани типове - структури, изборени типове и класове.

```swift
struct FoodLog: Codable {
    enum Food: String, Codable {
        case doner, pizza, tarator
    }
    
    var day: Int
    var eaten: [Food]
}

// Съставяме си дневник от храни
let log = FoodLog(day: 1, eaten: [.doner, .tarator])
```

От горния пример виждаме, че за да имплементираме `Encodable` и `Decoadable` протоколите е нужно всички член данни на типа да имплементират тези два протокола. Именно чрез тези два протокола можем да архивираме и сериализираме нашите типове. Самата сериализация се извършва от обект от тип `JSONEncoder`. Той автоматично сериализира нашата инстнация в JSON обект.


```swift
import Foundation 

let jsonEncoder = JSONEncoder() // Един от вградените сериализатори

// Сериализираме данните
let jsonData = try jsonEncoder.encode(log)
// Създаваме символен низ от сериализираните данни
let jsonString = String(data: jsonData, encoding: .utf8) // "{"day":1,"eaten":["doner","tarator"]}"
```

Обратния процес - десериализация се извършва от `JSONDecoder` класа.

```swift
let jsonDecoder = JSONDecoder() // Противоположният поцес на JSONEncoder

// Опитваме се да десериализираме данните от по-горе
let decodedLog = try jsonDecoder.decode(FoodLog.self, from: jsonData)
decodedLog.day         // 1
decodedLog.eaten // [doner, tarator]
```
