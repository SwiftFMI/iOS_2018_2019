# Frameworks в iOS

Стандартните приложения разработени с iOS позволяват интегриранен на основни (iOS) и външни (open-source, но не само) библиотеки във вашия iOS App. Днес ще разгледаме няколко основни такива библиотеки, които позволяват да решим специфични задачи, като достъп до местоположението на потребител, достъп до снимките му и комуникация с облачни услуги.

## UserDefaults

За съхраняване на малък обем данни в iOS използваме [UserDefaults][1].

Когато искаме да съхраним малки по обем данни като потребителски настройки, някакъв статус или запис на приложението е по-удобно и лесно да използваме `UserDefaults` пред `CoreData`, което би изисвало повече усилия и по-голяма сложност за имплементиране.
С `UserDefaults` можем да съхраняваме данни от тип `Bool`, `Dictionary`, `Int`, `String`, `NSNumber`, `Data`, `Date` и `Array`.

Когато записваме данни в UserDefaults на приложението си, данните автоматично се зареждат при стартирането на апликацията, за да можем да ги прочетем. Това прави UserDefaults изключително удобен и лесен начин да запазваме данните на приложението, но трябва да запазваме малки по обем данни, защото в противен случай това би забавило стартирането му. Допустимия обем може да варира в зависимост от приложението, но ако съхранените данни в него ще бъдат над 100КБ, би било добре да обмислим друг вариант за съхраняването на данните.

Създаване на инстанция на класа:

		let defaults = UserDefaults.standard
		
След като създадем инстанция на класа или директно използваме `UserDefaults.standard` можем лесно да записваме стойности за различни уникални ключове:

		let defaults = UserDefaults.standard
		defaults.set(25, forKey: "Age") 
		defaults.set(true, forKey: "UseTouchID")
		defaults.set(CGFloat.pi, forKey: "Pi")

Също толкова лесно можем да записваме `String`, `Date`, `Array` и `Dictionary`.
 
Съхранение на `String` по ключ:
		
		UserDefaults.standard.set("SwiftFMI", forKey: "courseName")

Извличане на стойност по даден ключ:

		let name = UserDefaults.standard.string(forKey: “courseName”) ?? “”
		
Подобно на `Dictionary`, `UserDefaults` използва ключ-стойност.
В примера по-горе ключа е "courseName". Той се използва за съхраняване и извличане на данни, които се записват по този ключ и той е уникален в контекста на `UserDefaults`. Ако запишем стойност към даден ключ, каквато и да е била старата стойност тя се презаписва и заменя с новата.

Съхранение на `Bool` по даден ключ:
		
		UserDefaults.standard.set(true, forKey: “soundEnabled”)

Извличане на Bool по даден ключ:

		let status = UserDefaults.standard.bool(forKey: “soundEnabled”) ?? false


При извличане на стойности от UserDefaults трябва да правим проверка за типа им.

*  `integer(forKey:)` връща `Integer` ако ключа съществува иначе `0`.
*  `bool(forKey:)` връща `Bool` ако ключа съществува иначе `false`.
*  `float(forKey:)` връща `Float` ако ключа съществува иначе `0.0`.
*  `double(forKey:)` връща `Double` ако ключа съществува иначе `0.0`.
*  `object(forKey:)` връща тип `Any?` и трябва да направим проверка за типа на обекта и да го кастнем към конкретния тип.

Важно е да знаем какви стойности записваме, защото взимайки ги от UserDefaults трябва да сме наясно дали ключа не съществува или ние сме записали стойност също като тази по подразбиране.

Пример:

		bool(forKey:)
 
Има две възможни стойности, а може да е `false` защото ключа липсва в `UserDefaults` записите.
 
Когато използваме `object(forKey:)` получаваме `optional` обект. С това можем да се справим или като принудително кастнем (typecast) обекта към типа,който очакваме  чрез `as!` или да го кастнем опционално  чрез `as?`.
 
Използвайки as!, ако object(forKey:) върне nil, приложението ще крашне!!!.
Използвайки as?, трябва да направите unwrap или да му дадете стойност по подразбиране.
 
 
Възможно решение е да се използва оператора `??`. Той прави следното: ако обекта отляво е optional и съществува (различен е от nil) обекта се unwrap-ва с non-optional стойност, в противен случай ако не съществува използва стойността на обекта отдясно.
 
 Пример:
 
 		let defaultColorName = "red"	
		var userDefinedColorName: String?
		userDefinedColorName =  UserDefaults.standard.string(forKey: "userDefinedColor")
		var colorNameToUse = userDefinedColorName ?? defaultColorName
 		
		userDefinedColorName = "green"
		colorNameToUse = userDefinedColorName ?? defaultColorName
		
Пример за Array:
		
		let array = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()

Ако SavedArray съществува и съдържа String обекти, ще бъде записан в array константата.В противен случай ако не съществува или не съдържа String обекти, в array ще се запише нов инициализиран празен array.

Пример за `Dictionary`:

		let dict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()


### Съхраняване на обекти от наши класове

Както споменахме по горе има определен набор от класове, които директно могат да бъдат записвани и четени в `UserDefaults` без да се грижим за нищо допълнително.
Какво става обаче ако имаме необходимост да съхраняваме обект от друг клас, например User, Car или какъвто и да е друг различен от тези които се поддържат по подразбиране.

Вариант може да бъде да се напишат медоти (когато това е достатъчно и приложимо) за трансформиране (представяне) на класа в Dictionary. Така той вече може да бъде записан като Dictionary обект и при извличането му да бъде представен обратно като обект от класа. Често това е удобен и приложим вариант.

Пример: `(Objective-C)`

		- (id)initWithDictionary:(NSDictionary *)personDict {
		    self = [super init];
		    if (self) {
		        self.name = personDict[@"name"];
		        self.surname = personDict[@"surname"];
		    }
		    return self;
		}
		
		- (NSDictionary *)dictionaryRepresentation {
		    return @{
		        @"first_name": self.name,
		        @"last_name": self.surname
		    };
		}
		
Записване:

		[[NSUserDefaults standardUserDefaults] setObject:[person toDictionary]] forKey:@"personKey"];

Четене:

		[[NSUserDefaults standardUserDefaults] objectForKey:@"personKey"];
		
		
### NSCoding протокол

За да можете да записвате и четете директно ваш клас в UserDefaults трябва класа да имплементира [NSCoding][2] протокола. По този начин обекта ще се трансформира от и към Data и ще може да се записва като Data и да се прочита от Data към вашия клас.
Има много класове от iOS SDK които имплементират NSCoding, но вашите класове няма да го имплементират по подразбиране, освен ако не наследяват някой, който вече го прави. (UIColor, UIImage, UIView, UILabel, UIImageView, UITableView, SKSpriteNode)

	class MyClass: NSObject, NSCoding {
	     func encode(with aCoder: NSCoder)  {    // this method is required and used to encode data
	
	         aCoder.encode(name, forKey: “name“)	
	         aCoder.encode(image, forKey: “image“)
	     }

  	   required init?(coder aDecoder: NSCoder) {   // this method is required and used to decode data
        name = aDecoder.decodeObject(forKey: “name“) as! String
        image = aDecoder.decodeObject(forKey: “image“) as! String
	   }

		var name: String
   		var image: String

		init(name: String, image: String) {		
		         self.name = name		
		        self.image = image		
		   }		
		}
		let myObjects = [MyClass(name: "name1", image: "image1"), MyClass(name: "name2", image: "image2")]

Записване:

		var userDefaults = UserDefaults.standard
		let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: myObjects)
		userDefaults.set(encodedData, forKey: "myObjects")
		userDefaults.synchronize()

Четене: 
		
		let decoded = userDefaults.object(forKey: "myObjects") as! Data
		let decodedObjects = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [MyClass]
		

## Firebase (Core) + Database

### Регистграция на приложение

Трябва да имате готов проект във фаър бейз и вътре в него създавате iOS приложение.
[Firebase Console](https://console.firebase.google.com/)

### CocoaPod 


## Firebase Storage (Images)

Преди всичко трябва да подготвим приложението, като добавим необходимите библиотеки към проекта. Това става, като включим следния модул към нашия ```Podfile```.

		pod 'Firebase/Storage'

После трябва да инсталираме липсващите пакети през CocoaPods. Това става със следната команада.

		pod install
	
Добре е преди това да сте затворили проекта. След инсталирането пак трябва да отворим workspace файла.

За да изпозлваме Storage функционалността, трябва да конфигурираме правилните права за достъп. [Тук](https://firebase.google.com/docs/storage/security/start?authuser=0) може да прочетем повече за тях.


За предпочитане е да използвате правила, които позволяват качването на файлове само, ако потребителя се е логнал в приложението с потребителско име или парола. За целта на примера, ще позволим на анонимните акунти и те да могат да качват файлове със следните правила:


	// Grants a user access to a node matching their user ID
	service firebase.storage {
	  match /b/{bucket}/o {
	    // Files look like: "user/<UID>/path/to/file.txt"
	    match /user/{userId}/{allPaths=**} {
	      allow read, write: if request.auth.uid == userId;
	    }
	  }
	}

	
Ето и парче код което трябва да модифицираме да работи за логнати потребители в системата. Повече за различните видове на регистрация и активация, може да прочете [тук](https://firebase.google.com/docs/auth/ios/anonymous-auth?authuser=0). Не забравяйте да активирате съответните на следната [страница](https://console.firebase.google.com/u/0/project/fire-base-demo2018/authentication/providers). 

	Auth.auth().signInAnonymously() { [weak self] (user, error) in
            let isAnonymous = user!.isAnonymous  // true
            let uid = user!.uid
            
            print("UID: \(uid)")
            
            let storageRef = Storage.storage().reference()
            
            let imageRef = storageRef.child("user/\(uid)/image.jpg")
        
            // Create file metadata including the content type
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            
            if let image = self?.image {
                let data = UIImagePNGRepresentation(image)
                // Upload data and metadata
                let uploadTask = imageRef.putData(data!, metadata: metadata)

                
                uploadTask.observe(.progress) { snapshot in
                    // Upload reported progress
                    let complete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                        / Double(snapshot.progress!.totalUnitCount)
                    
                    print("Progress: \(complete)")
                }

                
                uploadTask.observe(.success) { snapshot in
                    // Upload completed successfully
                    print("File was uploaded.")
                    let url = snapshot.reference.downloadURL { url, error in
                        if let error = error {
                            print("Error: \(error)")
                        } else {
                            print("Public download URL: \(String(describing: url))")
                        }
                    }
                }


                
                uploadTask.observe(.failure) { snapshot in
                    if let error = snapshot.error as NSError? {
                        switch (StorageErrorCode(rawValue: error.code)!) {
                        case .objectNotFound:
                            // File doesn't exist
                            print("object not found")
                            break
                        case .unauthorized:
                            // User doesn't have permission to access file
                            print("user has no permissions")
                            break
                        case .cancelled:
                            // User canceled the upload
                            print("upload was cancelled")
                            break
                            
                            /* ... */
                            
                        case .unknown:
                            // Unknown error occurred, inspect the server response
                            break
                        default:
                            // A separate error occurred. This is a good place to retry the upload.
                            break
                        }
                    }
                }
            }
        }
        
Няколко са основните стъпки. Потребителя се логва в системата като анонимен. Това ни позволява да му създадем профил и да качване снимки в неговия анонимен профил. В бъдеще можем да свържем този анонимен профил с реален.

Създава се файл, който има специален адрес пасващ на правилата от по-горе. Картинката се кодира като PNG за да може да се изпрати. Можем да добавяме произволни записи към метаданните, които да изпозлваме и в правилата и в описанието на ресурса (картинката).

Обекта ```uploadTask``` ни позволява да следми прогреса на качване на ресурса в облака. Можем да паузираме процеса, да го откажем или да следим за успешното приключване. Различни грешки могат да се появят и е добре да ги обработим правилно. Когато ресурът е качен, можем да генерираме публичен URL, който да бъде иползван извън нашето приложение. Този URL може да бъде премахнат когато решим и през портала на Firebase. Това дава голяма свобода да свързваме тези ресурси с данните от базата.

Записките представят само начален поглед над `Firebase` облачните услуги предоставени от Google. За да постигнете повече с тях е добре да познвате пълния арсенал и какви стандартни задачи ви позволява. Ето няколко интересни точки:

* нотификации
* отдалечено конфигуриране
* крашлитикс (дoкладване на крашове)
* аналитикс (статистика)
* реклама, чрез AdWords 

## References
* [WatchOS Settigns][3]
* tvOS поддържа UserDefaults до 500 килобайта данни. Често това може да е единствения вариант за съхранение на данни,т.к. другите не поддържат съхранение между отделните жизнени цикли на приложението.

[1]: https://developer.apple.com/documentation/foundation/userdefaults
[2]: https://developer.apple.com/documentation/foundation/nscoding
[3]: [https://developer.apple.com/library/archive/documentation/General/Conceptual/WatchKitProgrammingGuide/Settings.html
