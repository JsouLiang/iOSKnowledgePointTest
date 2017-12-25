// 命名空间的思路是为应用程序或库创建一个全局对象，将所有的其他对象和函 数全部添加到该对象中，而不是去污染全局作用域。

//: 单一全局对象
// 全局命名空间对象大写
var CARFACTORY = CARFACTORY || {}   // 为了确保仅在该命名空间不存在的 前提下才进行创建，应该坚持通过短路操作符||来保证安全性。
CARFACTORY.Car = function() {}
CARFACTORY.BMW = function() {}
CARFACTORY.engines = 1;
CARFACTORY.features = {
    seats: 6,
    airbags: 6
}

//: 模块模式
// 模块可以将较大的程序分隔成较小的部分，赋予其各自的命名空间。
// 函数作用域有助于 创建模块内部使用的命名空间，对象可以用来保存导出的值。
// 在JavaScript中，模块模式的使用率很高。
// 模块可以帮助模拟类的概念。
// 它使得我们能够在对 象中加入公共/私有方法和变量，但最重要的是，模块能够将它们同全局作用域隔离开。
// 变量和函 数都被限制在了模块作用域中，因而也就自动避免了与使用相同名称的其他脚本产生命名冲突

// 此时 basicServerConfig 在全局模块上
var basicServerConfig = (function() {
    // 私有成员
    var environment = "production";
    startupParams = {
        cacheTimeOut: 30,
        local: "en_US"
    };

    // 共有成员
    return {
        init: function () {
            console.log("Initial the server")
        },
        updateStartUp: function(params) {
            this.startupParams = params;
            console.log( this.startupParams.cacheTimeout ); 
            console.log( this.startupParams.locale );
        }
    }
})();

// 为了确保basicServerConfig 不会全局污染，配合使用 单一全局对象
var SERVER = SERVER || {}
SERVER.basicServerConfig = (function() {
    // 私有成员
    var environment = "production";
    startupParams = {
        cacheTimeOut: 30,
        local: "en_US"
    };

    // 共有成员
    return {
        init: function () {
            console.log("Initial the server")
        },
        updateStartUp: function(params) {
            this.startupParams = params;
            console.log( this.startupParams.cacheTimeout ); 
            console.log( this.startupParams.locale );
        }
    }
})();
SERVER.basicServerConfig.init();

var modulePattern = function() {
    var privateOne = 1
    function privateFn() {
        console.log('privateFn called')
    }

    return {
        publicTwo: 2,
        publicFn: function() {
            modulePattern.publicFnTwo();        // 在这里需要使用 定义的模块来调用函数
        },
        publicFnTwo: function() {
            privateFn()
        }
    }
}();
modulePattern.publicFn();

var modulePatternRMP = function() {
    var privateOne = 1
    function privateFn() {
        console.log('privateFn called')
    }
    function publicFun() {
        publicFuncTwo()
    }

    function publicFuncTwo() {
        console.log('publicFuncTwo called')
        privateFn()
    }

    // 函数和变量是在私有作用域中定义的，返回的匿名对象中带有指针，指向那些希望作为公共性质的私有变量和函数。
    return {
        count: privateOne,      // 通过分配共有指针来暴露私有变量
        publicFun: publicFun,
        publicFuncTwo: publicFuncTwo
    }
}()
console.log(modulePatternRMP.count)
modulePatternRMP.publicFun()

