// 原型模式
// 原型模式实现的关键就是语言是否实现了clone方法
var Plane = function() {
    this.blood = 100
    this.attackLevel = 1
    this.defenseLevel = 1
}

var plane = new Plane()
plane.blood = 500
plane.attackLevel = 10
plane.defenseLevel = 7

// ES5 提供了Object.create 方法来克隆对象
var clonePlane = Object.create(plane)
console.log(clonePlane.blood)        // 500
console.log(clonePlane.attackLevel)  // 10
console.log(clonePlane.defenseLevel) // 7

// 在不支持Object.create 浏览器中，我们可以这样
Object.create = Object.create || function(object) {
    var F = function() {}
    F.prototype = object
    return new F()
}

// 