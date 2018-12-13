# Семинар 13.12.2018

Днес ще използваме познанията си по:

* `cocoapods`
* `Firebase`

и ще реализираме малко приложение, което има за целта да използва `backend` услугите за да съхранява данните в облака.


## Задачи

1. Създайте свой firebase проект [тук](https://firebase.google.com/docs/reference/swift/firebasedatabase/api/reference/Classes).
2. Интегрирайте го в `MyCompany` проекта
3. Предложете подходящ формат на данните, които ще съхранявате в `firebase database`.
	
	Така можем да четем данни от `firebase`:
	
	```swift
	// /items/*
	ref = Database.database().reference(withPath: "items")
        
    _ = ref.observe(.value, with: {  [weak self] (snapshot) in
        let items = snapshot.value as? [String : Bool] ?? [:]
        // ...
        print("\(items)")
    })
	```
	
	Добре е да погледнете [API](https://firebase.google.com/docs/reference/swift/firebasedatabase/api/reference/Classes) за работа с базата данни. 
4. Имплементирайте го.
5. Крайното приложение трябва да може да показва потребители добавени от различни устройства.
6. Може да погледнете как се записват 