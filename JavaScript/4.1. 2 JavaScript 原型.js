上一节使用构造函数创建的 Dog 函数
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
var fido = new Dog("Fido", "Mixed", 38); 
var fluffy = new Dog("Fluffy", "Poodle", 30); 
var spot = new Dog("Spot", "Chihuahua", 10);
// 上面三个对象，每个对象都有个 bark 方法，而且每个 bark 方法在内存中并不是同一函数
// fido -> bark()
// fluffy -> bark()
// spot -> bark()
// 当 Dog 对象足够多时，就会分配足够多的 dark 函数，导致内存消耗巨大
// 通过使用 构造函数，我们只需将bark方法放在构造函数Dog中，这样每次实例化对象时， 
// 都将重用方法bark的代码， 从而在代码层面实现重用行为的目的。 
// 但在运行阶段， 这种解决方案的效果并不好， 因为每个小狗对象都将获得 自己的bark方法副本。

JavaScript 可以从其他对象那里继承属性和行为
JavaScript 使用原型式继承，其中`被继承的对象成为原型`
function Dog(name, breed, weight) {
    this.name = name
    this.breed = breed
    this.weight = weight
}
// 在 JavaScript 中几乎所有的对象都有一个 prototype 的默认属性
Dog.prototype.species = "Canine"
Dog.prototype.bark = function() {
    if (this.weight > 25) { 
        console.log(this.name + " says Woof!"); 
    } else { 
        console.log(this.name + " says Yip!"); 
    }
}
Dog.prototype.run = function() {
    console.log('run')
}
Dog.prototype.wag = function() {
    console.log('Wag')
}
var fido = new Dog("Fido", "Mixed", 38); 
var fluffy = new Dog("Fluffy", "Poodle", 30); 
var spot = new Dog("Spot", "Chihuahua", 10);
spot.bark = function() {
    console.log(this.name + "say woof")
}
fido.bark(); fido.run(); fido.wag();
fluffy.bark(); fluffy.run(); fluffy.wag();
spot.bark(); spot.run(); spot.wag();


// 使用原型后，可以为原型添加方法，使所有继承于该原型的对象拥有该方法
Dog.prototype.sit = function() { 
    console.log(this.name + " is now sitting"); 
}

// 如果对象中没有查找的属性，JavaScript 回去原型中查找
Object.getPrototypeOf() // 这个方法会返回对象的原型

// 原型是定义能够被对象实例所使用的属性和函数的一种方式
// 原型的属性最终会成为对象实 例的属性
// 原型可视为对象创建的模板，它类似于面向对象语言中的类。

// 使用`hasOwnProperty` 来判断属性是在实例中还是原型中，如果在实例中返回 true ，否则在原型中
spot.hasOwnProperty('species')

// 一个什么都不返回，也什么都不创建的函数
function Player() {}
// 向该函数的prototype属性中添加一个函数
Player.prototype.usesBat = function() {
    return true
}

// 以函数的形式调用Player()，以证明什么都不会发生
var crazyBob = Player()
if (crazyBob === undefined) {
    console.log('crazyBob is not undefine')
}

// new操作符是应用于构造函数的
// 显示使用new，以构造函数的形式调用player() 
// 1. 创建实例
// 2. 从函数的原型中得到方法usesBat()
var swingJay = new Player() 
if (swingJay && swingJay.usesBat && swingJay.usesBat()) {
    console.log("SwingJay exists and can use bat");
}