func sum(a a1:Int, b z:Int ) -> Int {
    return a1 + z
}

sum(a: 5, b: 5)

func printAllNames(names nn: [String], printFunc: (String) -> Void) {
    for name in nn {
        printFunc(name)
    }
}

var f: ([String], (String) -> Void)->Void = printAllNames(names:printFunc:)

func createVeryFancyPrintFunction() -> (String)-> Void {
    
    func fancyPrint(name: String)   {
        print("@****************************@")
        print("@$$$$$$$$$$ \(name) $$$$$$$$$@")
        print("@****************************@")
    }
    
    
    return fancyPrint
}

//printAllNames(names: ["Иван", "Гошо"], printFunc: createVeryFancyPrintFunction())

//f(["Иван", "Гошо"], createVeryFancyPrintFunction())


var d: ([String], (String) -> Void)->Void
d = { (names, f) -> () in
    for name in names {
        f(name)
    }
}

d(["Иван", "Гошо"]) { (name) in
    print("@$$$$$$$$$$ \(name) $$$$$$$$$@")
}
