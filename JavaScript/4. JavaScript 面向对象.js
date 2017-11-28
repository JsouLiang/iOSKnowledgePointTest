JavaScript 对象行为

var autor = {
    firstname: 'Douglas',
    lastname: 'Crockford',
    book: {
        title: 'JavaScript',
        pages: '172'
    }
}

访问对象属性两种方式
1、使用. 语法 
autor.firstname
2、使用[]  
autor['firstname']

let firstName = 'firstName'
autor[firstName]

技巧：当访问一个不存在的属性时会返回 undifine，此时可以使用 || 来设置默认值
console.log(autor.age || "No age found")

给属性赋值更新对象
autor.book.pages = 190

为对象添加方法
var meetingRoom = {}
meetingRoom.book = function(roomId) {
    console.log('book meeting room - '+ roomId)
}
meetingRoom.book("VL")

