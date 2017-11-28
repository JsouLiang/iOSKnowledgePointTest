function Player() {
    // 使用关键字this在构造函数中初始化属性
    this.isAvailable = function() {
        return "Instance method says - he is hired";
    }
}

// 将属性附着在原型上
Player.prototype.isAvailable = function() {
    return "Prototype method says - he is Not hired";
}

// 除了将属性附着在原型上之外，也可以使用关键字this在构造函数中初始化属性。
// 如果相同的函数同时 被定义为实例属性和原型属性，则实例属性的优先级更高。

在JavaScript中，this的值是由函数的调用上下文（invocation context）以及调用位置所决定 的。
// 1. 全局上下文：如果是在全局上下文中使用this，它就会被绑定在全局上下中
function globalAlias() {
    return this
}
console.log(globalAlias)

// 2. 当this用于对象方法中: 在这种情况下，this被赋值或绑定到包含对象（enclosing object） 上。
// 如果对象存在嵌套的话，包含对象就是那个直接的父对象
var f = { 
    name: "f", 
    func: function () { 
        return this; 
    } 
}; 
console.log(f.func());

// 3. 如果不存在上下文: 当一个函数不跟随任何对象调用的时候，就不会有上下文。默认情 况下，它会被绑定到全局上下文。如果在这种函数中使用this，它也会被绑定到全局上 下文。
// 4. 当this用于构造函数中：我们之前已经看到过，当函数使用关键字new来调用时，它就 会被作为构造函数使用。
// 在构造函数中，this指向被构造的对象
var member = "global"; 
function f() { 
    this.member = "f"; 
} 
var o= new f(); 
console.log(o.member); // f

function Player() {
    aaa = false
}
Player.prototype.isAvailable = function() {
    return aaa
}
var crazyBob = new Player()

console.log(crazyBob.isAvailable(), aaa) // false, 由于 aaa 并没有使用 var 来声明，所有被提升到全局作用域

// ****************** OOP设计指南**********************
// 1. 在函数中使用关键字var来声明私有变量，它们可以由私有函数或特权方法访问
// 2. 在对象的构造函数中声明私有函数，并由特权方法调用
// 3. 特权方法可以使用this.method = function() {}来声明
// 4. 公共方法可以使用Class.prototype.method = function() {}来声明。
// 5. 公共属性可以使用this.property来声明，能够在对象外部访问。

function Player(name, sport, age, country) {
    this.constructor.noOfPlayers++
    // 私有属性和函数
    // 只能由特权对象浏览、编辑或调用
    var retirementAge = 40
    var available = true
    var playerAge = age?age:18
    var playerName = name? name: 'Unknow'
    var playerSport = sport? sport: "Unknow"

    function isAvailable() {
        return available && (playerAge<retirementAge);
    }

    // 特权方法，可以从外部调用，也可以有成员访问，可以替换成对应的公共方法
    this.book = function() {
        if (!isAvailable()) {
            this.available = false
        } else {
            console.log("Player is unavailable");
        }
    }
    this.getSport=function(){ return playerSport; }
    // 公共属性，可以在任何地方对齐做出修改
    this.batPreference="Lefty"; 
    this.hasCelebGirlfriend=false; 
    this.endorses="Super Brand";
}
// 公共方法，任何人都可以读取或写入
// 只能访问公共属性和原型属性
Player.prototype.switchHands = function(){ this.batPreference="righty"; };
Player.prototype.dateCeleb = function(){ this.hasCelebGirlfriend=true; } ;
Player.prototype.fixEyes = function(){ this.wearGlasses=false; };
// 原型属性——任何人都可以读取或写入（或覆盖） 
Player.prototype.wearsGlasses=true;
// 静态属性——任何人都可以读取或写入
// 静态属性被放入到 对象的 constructor 属性中，例如函数中使用 this.constructor.noOfPlayers 来获取
Player.noOfPlayers = 0;

(function PlayerTest(){
    // 创建Player对象的新实例 
    var cricketer=new Player("Vivian","Cricket",23,"England"); 
    var golfer =new Player("Pete","Golf",32,"USA"); 
    console.log("So far there are " + Player.noOfPlayers + " in the guild");
    // 两个函数共享公共的Player.prototype.wearsGlasses变量 
    cricketer.fixEyes(); 
    golfer.fixEyes();

    cricketer.endorses="Other Brand";// 可以更新公有变量

    // 通过Player的原型来改变其公共方法 
    Player.prototype.fixEyes=function(){ this.wearGlasses=true; }; 
    // 只改变了Cricketer的函数 
    cricketer.switchHands=function(){ this.batPreference="undecided"; }
})();