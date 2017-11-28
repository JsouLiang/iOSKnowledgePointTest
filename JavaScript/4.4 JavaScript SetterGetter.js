接收器（getter）是一种很方便的方法，可以用来获取特定属性的值；
设置器 （setter）是可以用来设置属性值的方法。

var Person = {
    firstName: "Albert",
    lastName: "Einstein",
    setLastName: function(_lastName) {
        this.lastName = _lastName
    },
    setFirstName: function(_firstName) {
        this.firstName = _firstName
    },
    getFullName: function() {
        return `${this.firstName} ${this.lastName}`
    }
}


var Person = {
    firstName: "Albert",
    lastName: "Einstein",
    set fullName(_name) {
        var words = _name.toString().split(' '); 
        this.firstname = words[0]; 
        this.lastname = words[1];
    }
    get fullName: function() {
        return `${this.firstName} ${this.lastName}`
    }
}

console.log(Person.firstName)
console.log(person.firstname); //"Issac" 
console.log(person.lastname);  //"Newton" 
console.log(person.fullname);  //"Issac Newton"
var person = { 
    firstname: "Albert", 
    lastname: "Einstein", 
}; 
Object.defineProperty(person, 'fullname', { 
    get: function() { 
        return this.firstname + ' ' + this.lastname; 
    }, 
    set: function(name) { 
        var words = name.split(' '); 
        this.firstname = words[0]; this.lastname = words[1]; 
    } 
}); 
person.fullname = "Issac Newton"; 
console.log(person.firstname); //"Issac" 
console.log(person.lastname);  //"Newton" 
console.log(person.fullname);  //"Issac Newton"