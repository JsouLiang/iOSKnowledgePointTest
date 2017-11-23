// JavaScript call、apply  实现继承
function Animal(name) {
    this.name = name
    this.showName = function() {
        console.log(this)
        console.log(this.name)
    }
    
}

function Cat(name) {
    // 将 Animal 内 this 指向 Cat，这样 Cat 就有了 name属性，和 showName函数
    Animal.call(this, name)
}
var cat = new Cat('Cat')
cat.showName()

// JavaScript call、apply  实现多重继承
function Class10() {
    this.showSub = function(a, b) {
        console.log(a - b)
    }
}

function Class11() {
    this.showAdd = function(a, b) {
        console.log(a + b)
    }
}

function Class12() {
    Class10.apply(this)
    Class11.apply(this)
}

var c2 = new Class12()
c2.showAdd(3,1)