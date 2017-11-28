// *********** 函数基本 ********
// 1. 函数创建
// 函数创建时，名称可以省略；函数名如果省略就是匿名函数
// 1.1 函数语句
function add(a, b) {
    return a + b
}
// 创建名为 add 的函数
c = add(1, 2)
console.log(c)

// 1.2 函数表达式
// 创建了一个匿名函数并将其赋给变量add，该变量随后可用于调用函数。
// 函数表达式无法递归
var add = function(a,b) {
    return a + b
}
c = add(1, 2)
console.log(c)

var facto = function factorial(n) {
    if (n <= 1) { return 1}
    return n * factorial(n - 1)
}
console.log(facto(6))

// 1.3 调用自身函数
(function sayHello() {
    console.log('hello')
})()

// 1.4 将函数作为参数传递给函数
function changeCase(val) {
    return val.toUpperCase()
}

function demofunction(a, passFunction) {
    console.log(passFunction(a))
}
demofunction("small", changeCase)

// 2.1 函数作为数据
// 函数可以赋值给变量
var say = console.log
say("Hello")

var validateDataForAge = function(data) {
    person = data()
    console.log(parson)
    if (person.age < 1 || person.age > 99) {
        return true
    } else {
        return false
    }
}
var errorHandlerForAge = function(error) {
    console.log("Error")
}
function parseRequest(data, validateData, errorHandler) {
    var error = validateData(data)
    if (!error) {
        console.log("no error")
    } else {
        errorHandler()
    }
}
var generateDataForScientist = function() {
    return {
        name: "JS Bach", 
        age : Math.floor(Math.random() * (100 - 1)) + 1,
    }
}
// 解析请求
// 函数作为参数传递给 parseRequest
parseRequest(generateDataForScientist, validateDataForAge, errorHandlerForAge)

// ******* 作用域 *********
// 1. 全局作用域
// 1.1 在函数外部声明的变量都属于全局作用域
var a = 1
function test() {
    console.log(a)  // 1
}
test()
console.log(a)
// 1.2 声明变量时忽略 var，会生成隐式全局变量
var a = 1
function test() {
    a = 2   // 忽略 var，全局变量被覆盖
    b = 2   // 全局作用域
    console.log(a)
}
console.log(a)
test()
console.log(a)
console.log(b)

// 局部作用域
// 在函数内声明的变量就是局部变量，只能在函数内使用
var name = "Global"
function test() {
    var name = "local"
    console.log(name)       // local
}
console.log(name)           // Global
test()

// IIFE 立即调用函数表达式
var a = 1;
(function foo(val) {
    var a = 2
    console.log(val + a)
})(3)
// foo(2)  foo 只能在函数内使用

console.log(a)
var a = 1
// js 编译后，声明提升
// 👆代码编译后如下
var a
console.log(a)
a = 1
///////////////
a = 1
var a
console.log(a)
// 👆编译后
var a
a = 1
console.log(a)
//: 注意  🙋
// 只有函数声明才能被提升

// 函数
foo()
function foo() {
    console.log(a)
    var a = 1
}
// 因为函数foo()的声明会被提升，所以我们可以在其定义之前就调用该函数。
// 提升之后foo 函数中的变量会提升到函数作用域顶部
function foo() {
    var a
    console.log(a)
    a = 1
}


// ********** 函数声明和函数表达式 **********
// 函数表达式
// Error functionOne is not a function
functionOne()
var functionOne = function() {
    console.log("function ONE")
}

// 函数声明
functionTwo()       // function TWO
function functionTwo() {
    console.log("function TWO")
}

// 函数表达式必须要在调用前声明，但funtionOne()是一个匿名函数表达式，它是在代码执行到其所在位置时进行求值的（也 称为运行期执行），必须在调用前声明。
// 函数声明：对于带有函数名的函数（在上面的例子中是functionTwo()），其名称会被保存在函数 声明所在的作用域中。 该过程是在作用域中代码被执行前完成的， 因此在定义前调用 functioTwo()不会产生错误。
// functionTwo()的函数声明会被提升，而functionOne()的函数表达式会在执行 流逐行到达其位置时执行。
注意：🙋 
函数声明和变量声明都会被提升，但是函数声明在前，变量在后

🙅在条件块中条件选择函数声明，如下
if (true) {
    function sayMoo() {
        return 'true'
    }
} else {
    function sayMoo() {
        return 'fasle'
    }
}

// 使用函数表达式来解决上面的问题
var sayMoo
if (true) {
    sayMoo = function() {
        return 'true'
    }
} else {
    sayMoo = function() {
        return 'false'
    }
}

// ********** arguments 参数 **********
// arguments参数是传递给函数的所有参数的集合, 有一个名为length的属性，它包 含了参数的个数

// ********** this 参数 **********
当函数被调用时，有个叫 this 的隐式参数也会被传入函数。
他指向一个与`此次函数调用` 相关联的对象，该对象就是 `函数上下文`

### 1.作为函数调用
// 注意：✍🏻 如果函数不是以方法、构造函数或通过apply()、call()调用，那么它只是作为一个函数 被调用
function add() {
    console.log(this)
}
var substract = function() {
    console.log(this)
}
只是作为函数调用，函数中 this 指向全局对象
add()       
substract()

### 2. 作为方法调用
方法是作为对象属性的函数；这样 this 就被绑定在调用时所在的对象上
var person = {
    name: 'Person',
    age: 60,
    greet: function() {
        console.log(this, this.name)    // this 指向 person 对象
    }
}
// this被绑定在greet被调用时所在的person对象上，因为greet是person的一个 方法
person.greet()

### 3. 作为构造函数
要使用构造函数方法调用函数需要在函数前面使用关键字 `new` , 这样 this 就绑定到新创建的对象上了

var Person = function(name) {
    this.name = name
    console.log(this)
}
Person.prototype.greet = function() {
    return this.name
}
var person = new Person("Person")

### 4. 通过 apply 和 call 调用
apply() 方法调用函数，需要传入两个参数：作为函数上下文的对象以及作为调用参数的`数组。`
call() 方法的用法也差不多，除了调用参数不能作为数组传入，而是要直接写成`参数列表`的形式传入。

// ****** 匿名函数******
var santa = {
    say: function() {   // say 属性是个匿名函数，这种情况下，这种函数成为方法
        console.log("ho ho")
    }
}
santa.say()

#### 将匿名函数放到列表中
var things = [
    function() {console.log('one')},
    function() {console.log('two')},
]
for (var x = 0; x < things.length; x++) {
    things[x]()
}

#### 匿名函数作为函数参数
function eventHandle(event) {
    event()
}

eventHandle(function() {
    console.log('hello')
})


#### 条件逻辑中的匿名函数
var shape; if(shape_name === "SQUARE") {
    shape = function() {
        return "drawing square";
    } 
} else {
    shape = function() {
        return "drawing square";
    } 
} alert(shape());