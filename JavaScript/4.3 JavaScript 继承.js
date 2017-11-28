/*
在类继承中，实例从类模板（class blueprint）中继承并创建子类关系。
你无法在类定义上调 用实例方法，只能先创建出实例，然后在该实例上调用方法。
在原型继承中，实例从其他实例中 继承。
就继承而言，JavaScript只使用对象。
每个对象都有一个链接，指向另一个 叫作原型的对象。
这个原型对象也有自己的原型，以此类推，直到出现一个原型为null的对象。
当然，null没有原型，它作为原型链中的最后一环。*/
function Person() {}
Person.prototype.cry = function() {
    // console.log('Crying')
}
function Child() {}
// 将Person 的cry属性复制到了Child的cry属性。
Child.prototype = {
    cry: Person.prototype.cry
}
var child = new Child()
// console.log(child.cry())
console.log(child instanceof Child)     // true
console.log(child instanceof Person)    // false
console.log(child instanceof Object)    // true


function Person() {}
Person.prototype.cry = function() {
    console.log('Crying')
}
function Child() {}
// SubClass.prototype = new SuperClass()
// 使用Person的实例作为Child的原型
Child.prototype = new Person()
var child = new Child()
console.log(child instanceof Child)     // true
console.log(child instanceof Person)    // true
console.log(child instanceof Object)    // true


function Employee() {
    this.name = ''
    this.dept = 'None'
    this.salary = 0.0
}
function Manager() {
    Employee.call(this)     // 调用父类构造函数，来初始化自身
    this.reports = []
}
/**
 * 使用 Object.create() 创建 原型的原因是：
 * 执行 new SuperClass() 会调用对应的 SuperClass 函数，
 * 但是大多数情况下我们仅仅是希望 Child.prototype 是一个能够通过其原型链连接到 SupClass.prototype 上的对象
 * 但是如果 SuperClass 构造函数包含其他针对 SuperClass 类的逻辑，而我们并不想
 * 在创建 Child 对象时执行他们，
 * 所以使用 Object.create 可以在不调用 SuperClass 构造函数的情况下，在父子之间创建和使用 new 操作符时一样的原型链
 */
Manager.prototype = Object.create(Employee.prototype)

function IndividualContributor() {
    Employee.call(this)
    this.active_projects = []
}
IndividualContributor.prototype = Object.create(Employee.prototype)

function TeamLeader() {
    Manager.call(this)
    this.dept = "Software"; 
    this.salary = 100000;
}
TeamLeader.prototype = Object.create(Manager.prototype)

function Engineer() { 
    TeamLead.call(this); 
    this.dept = "JavaScript"; 
    this.desktop_id = "8822" ; 
    this.salary = 80000; 
} 
Engineer.prototype = Object.create(TeamLead.prototype);


