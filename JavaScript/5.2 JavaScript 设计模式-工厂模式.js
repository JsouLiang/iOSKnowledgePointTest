
function CarFactory() {}
CarFactory.prototype.info = function() {
    console.log("This car has "+this.doors+" doors and a "+this.engine_capacity+" liter engine");
}

// 静态工厂方法
// 通过 CarFactory.**** 的方法，变量都直接添加到 constructor 方法内部
CarFactory.make = function(type) {
    var constr = type
    var car;
    // 修改 constructor 方法使其指向 CarFactory 函数，及 CarFactory 对象
    CarFactory[constr].prototype = new CarFactory()

    car = new CarFactory[constr]()
    return car
}

CarFactory.Compact = function() {
    this.doors = 4
    this.engine_capacity = 2
};

CarFactory.Sedan = function () {
    this.doors = 2;
    this.engine_capacity = 2; 
}; 

CarFactory.SUV = function () {
    this.doors = 4;
    this.engine_capacity = 6; 
};



var golf = CarFactory.make('Compact');
var vento = CarFactory.make('Sedan'); 
var touareg = CarFactory.make('SUV'); 
golf.info(); //"This car has 4 doors and a 2 liter engine"