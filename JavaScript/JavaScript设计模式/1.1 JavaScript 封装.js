// 1 .封装数据
var myObject = (function() {
    var _name = 'private Name'
    return {
        getName: function() {
            return _name
        }
    }
})()