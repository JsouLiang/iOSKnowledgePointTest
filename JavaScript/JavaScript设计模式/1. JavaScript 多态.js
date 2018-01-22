// 1. 对象多态
var makeSound = function(animal) {
    animal.sound()
}

var Duck = function() {}
Duck.prototype.sound = function() {
    console.log("嘎嘎嘎")
}

var Chicken = function() {}
Chicken.prototype.sound = function() {
    console.log("咯咯咯")
}

makeSound(new Duck())
makeSound(new Chicken())

// 添加Dog
var Dog = function() {}
Dog.prototype.sound = function() {
    console.log("汪汪汪")
}
makeSound(new Dog())

var googleMap = {
    show: function() {
        console.log("使用谷歌地图")
    }
}

var baiduMap = {
    show: function() {
        console.log("使用百度地图")
    }
}

// 调用方式1. 脆弱的分支判断
var renderMap = function(type) {
    if (type === 'google') {
        googleMap.show()
    } else if (type === 'baidu') {
        baiduMap.show()
    }
    // 添加搜狗地图，就要拓展分支😭
    else if (type === 'sougo') {
        sougo.show()
    }
}

renderMap('google')
renderMap('baidu')

// 多态方式调用
renderMap = function(map) {
    if (map.show instanceof Function) {
        map.show()
    }
}
renderMap(googleMap)
renderMap(baiduMap)

// 添加sougo地图
var sougo = {
    show: function() {
        console.log("使用百度地图")
    }
}
renderMap(sougo)