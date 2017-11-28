// 创建一个 Dog 构造函数

// 1. 构造函数命名时使用首字母大写
// 2. 函数并没有返回值
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
