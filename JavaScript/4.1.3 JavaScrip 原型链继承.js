// 创建的原型链的终点都是 Object
// 创建的每个对象都有原型，该原型默认为 Object，可以将对象的原型设置为其他对象，但所有原型的终点都是 Object

function Dog(name, breed, weight) {
    this.name = name
    this.breed = breed
    this.weight = weight
}
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
// 1. 创建继承小狗原型的对象，
// 只需要结合使用 new 和 Dog 构造函数即可
// var aDog = new Dog()
function ShowDog(name, breed, weight, handler) {
    // 既然构造函数Dog已经知道如何完成这些工 作， 为何不让它去做呢
    // this.name = name
    // this.breed = breed
    // this.weight = weight

    // 调用了方法Dog.call， 以此替换了那些重复的代码。
    // call是一个内置方法， 可对任何函数调用它（别忘了， Dog是一个函数）。
    // Dog.call调用函 数Dog，将一个用作this的对象以及函数Dog的所有实参传递给它。
    Dog.call(this, name, breed, weight)
    this.handler = handler
}
// ShowDog 原型继承于 Dog 原型
ShowDog.prototype = new Dog()
// 为修复属性constructor不正确的问题，需要在表演犬原型中正确地设 置它。
ShowDog.prototype.constructor = ShowDog
ShowDog.prototype.stack = function() {
    console.log('Stack')
}
ShowDog.prototype.bait = function() {
    console.log('Bait')
}
ShowDog.prototype.gait = function(kind) {
    console.log(kind + 'ing')
}
ShowDog.prototype.groom = function() {
    console.log('Groom')
}

var fido = new Dog('Fido', 'Mixed', 28)
if (fido instanceof Dog) {
    console.log('Fido is a Dog')
}
if (fido instanceof ShowDog) {
    console.log('Fido is a ShowDog')
}
// 因为instanceof不仅考虑当前对象的类型， 还考虑它继承 的所有对象。
// Scotty虽然是作为表演犬创建的， 但表演犬继承了小狗， 因此 Scotty也是小狗。
// Scotty is a Dog
// Scotty is a ShowDog
var scotty = new ShowDog("Scotty", "Scottish Terrier", 15, "Cookie"); 
if (scotty instanceof Dog) {
    console.log("Scotty is a Dog"); 
} 
if (scotty instanceof ShowDog) {    
    console.log("Scotty is a ShowDog"); 
} 
console.log("Fido constructor is " + fido.constructor); 
/**
 *
 *  Scotty constructor is function Dog(name, breed, weight) {
 *  this.name = name
 *  this.breed = breed
 *  this.weight = weight
 * }
 * 查看属性 scotty.constructor。
 * 由于我们没有显式地为表演犬设置这个属性，它将 从小狗原型那里继承该属性。
 */
console.log("Scotty constructor is " + scotty.constructor);