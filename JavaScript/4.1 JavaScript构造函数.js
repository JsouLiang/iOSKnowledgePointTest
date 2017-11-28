// 创建一个 Dog 构造函数

// 1. 构造函数命名时使用首字母大写
// 2. 函数并没有返回值, 除了返回 this
function Dog(name, breed, weight) {
    this.name = name
    this.breed = breed
    this.weight = weight
}

// 使用构造函数
// 使用 new 调用
var fido = new Dog('Fido', 'Mixed', 28)

构造函数工作原理
// var fido = new Dog('Fido', 'Mixed', 28)
先看赋值运算符右边
1. new 首先创建一个新的`空对象`
生成 = {}
2. new 设置 `this 指向这个新对象`
this -> {}  
3. 设置好 this 后，调用 Dog 函数, 并将调用函数传递的参数传如
4. 执行函数代码
5. Dog 函数执行结束后，new 返回 this，此时 this 指向创建的新对象，他会自动返回 this，无需在代码中显示返回
6. 将返回的引用赋值给变量 fido

在构造函数中定义方法
function Dog(name, breed, weight) {
    this.name = name
    this.breed = breed
    this.weight = weight
    this.bark = function() {
        if (this.weight > 25) { 
            alert(this.name + " says Woof!"); 
        } else { 
            alert(this.name + " says Yip!"); 
        }
    }
}

var cadiParams = {make: "GM",
                  model: "Cadillac", 
                  year: 1955, 
                  color: "tan", 
                  passengers: 5, 
                  convertible: false, 
                  mileage: 12892};
var cadi = new Car(cadiParams);

function Car(params) {
    this.make = params.make; 
    this.model = params.model; 
    this.year = params.year; 
    this.color = params.color; 
    this.passengers = params.passengers; 
    this.convertible = params.convertible; 
    this.mileage = params.mileage; 
    this.started = false;

    this.start = function() { 
        this.started = true; 
    }; 
    this.stop = function() { 
        this.started = false; 
    }; 
    this.drive = function() { 
        if (this.started) { 
            alert("Zoom zoom!"); 
        } else { 
            alert("You need to start the engine first."); 
        } 
    };
}
// instanceof
instanceof 来确定对象是由哪个构造函数创建的
创建对象时， 运算符 new 在幕后存储了一些信息， 让你随时都能确定对象 是由哪个构造函数创建的。
运算符 instanceof 就是根据这些信息来确定对象是否 是指定构造函数的实例。
console.log(cadi instanceof Car)

// 使用构造函数创建对象后，可对 其进行修改，因为使用构造函数创建的对象是可以修改的
function Dog(name, breed, weight) {
    this.name = name
    this.breed = breed
    this.weight = weight
}
var fido = new Dog('Fido', 'Mixed', 28)
fido.owner = "Bob"  // 添加新属性
delete fido.weight  // 删除属性
fido.trust = function(person) { // 添加方法
    return (person === 'Bob')
}
// 虽然对对象的属性进行过修改和删除，但还是个 Dog 对象
console.log(fido instanceof Dog)

// 属性的变化仅对调用的对象有效
var spot = new Dog('Spot', 'Chihuahua', 10)

console.log(fido, spot)