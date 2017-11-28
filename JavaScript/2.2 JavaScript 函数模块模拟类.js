模块可用于模拟类，强调的是对变量和函数的公共及私有访问。

var moduleName = function() {
    // 私有状态
    // 私有函数
    return {
        // 公共状态
        // 公共变量
    }
}

// 函数模块两个要求：
1. 必须要有个外围函数，至少需要执行一次
2. 外围函数必须返回至少一个内部函数（inner function）。
   这需要创建一个涵盖了私有状态 的闭包，否则无法访问私有状态。
var superModeule = (function() {
    var secret = 'superscretkey'
    var passcode = 'nuke'

    function getSecret() {
        return secret
    }

    function getPassCode() {
        return passcode
    }
    // 满足条件2，外围函数返回至少一个内部函数，方便访问私有状态
    return {
        getSecret,
        getPassCode
    }
})()    // 这里满足条件 1

// 上面我们使用 IIFE 函数创建了一个 superModeule 单例
console.log(superModeule.getSecret())
console.log(superModeule.getPassCode())