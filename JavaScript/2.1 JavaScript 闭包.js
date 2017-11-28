闭包是在函数声明时所创建的作用域，它使得函数能够访问并处理函数的外部变量
闭包可以让函数访问到在函数声明时处于作用域中的所有变量以及其他函数

var outer = 'I am outer'
function outerFun() {   
    console.log(outer)
}
函数outerFn()的外围作用域就是一个闭包，其中的变量和函数总是可为其所用。


var outer = 'Outer'; // 全局变量 
var copy; 
function outerFn(){ // 全局函数3
    var inner = 'Inner'; // 该变量只有函数作用域，无法从外部访问
    function innerFn() { // outerFn()中的innerFn() 
                        // 全局上下文和外围上下文都可以在这里使用， 
                        // 因此可以访问到outer和inner 
        console.log(outer); 
        console.log(inner); 
    } 
    copy=innerFn; // 保存innerFn()的引用
    // 因为copy是在全局上下文中声明的，所以在外部可以使用

} 
outerFn(); 
copy(); // 不能直接调用innerFn()，但是可以通过在全局作用域中声明的变量来调用


闭包与私有变量
function privatePrams() {
    var points = 0          // 函数作用域中的points ，成为 privatePrams 对象的私有变量
    this.getPoints = function() {
        return points
    }
    this.score = function() {
        points++
    }
}

var private = new privatePrams()
private.score()
console.log(private.points)         // undefined
console.log(private.getPoints())    // 1

循环与闭包
for (var i = 1; i <= 5; i++) {
    // setTimeout的回调函数是在循环结束后才执行的
    setTimeout(function() {
        console.log(i)  // 变量i的值在函数被绑定后更新，
                        // 这就意味着每一个被绑定的函数打印出的总 是变量i中保存的最后那个值。
    }, i * 100)
}

可以引入一个函数作用域，并在该作用域中建立变量i的本地副 本
将变量i作为参数传入，
并将其复制到IIFE的局部变量j中。
IIFE会针对每次迭代创建一新的 作用域，使用正确的值来更新局部变量。
for (var i = 1; i <= 5; i++) {
    (function(j) {
        setTimeout(function() {
            console.log(j)
        })
    })(i)
}