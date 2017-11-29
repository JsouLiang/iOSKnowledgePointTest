基于类：
基于类的面向对象语言，是构建在类和实例上的
> 类定义了具有一组特征对象的属性。类是抽象的事物，不是所描述全部对象中任何特定的个体。例如 Animal 类代表所有动物集合
> 一个实例是一个类的实例化。Dog 可以是 Animal 类的一个实例

基于实例:
它只有对象。基于原型的语言具有所谓`原型对象的概念`。原型对象可以作为一个模板，新对象可以从中获得原始的属性。
任何对象都可以指定其自身的属性，既可以是创建时也可以在运行时创建。
而且，任何对象都可以作为另一个对象的原型，从而允许后者共享前者的属性。

// 构造函数:
在 JavaScript 中你只需要`定义构造函数来创建具有一组特定的初始属性和属性值的对象。`
任何 JavaScript 函数都可以用作构造器。 也可以使用 new 操作符和构造函数来创建一个新对象。

function Employee() {
    this.name = ''
    this.dept = 'general'
}

/**
 * public class Emploee {
 *  public String name = "";
 *  public String dept = "general"
 * }
 */

 function Manager() {
     Employee.call(this)
     this.reports = []
 }
 // 指定 Manager 父类，添加一个原型实例作为构造器函数prototype 属性的值，而这一动作可以在构造器函数定义后的任意时刻执行。
 Manager.prototype = Object.create(Employee.prototype)

 function WorkerBee() {
     Employee.call(this)
     this.projects = []
 }
 WorkerBee.prototype = Object.create(Employee.prototype)
 /**
  * Java 中，则需要在类定义中指定父类，且不能在类定义之外改变父类。
  * public class Manager extends Employee {
  *     public Employee[] reports = new Employee[0];
  * }
  * public class WorkerBee extends Employee {
  *     public String[] projects = new String[0];
  * }
  */
function SalesPerson() {
   WorkerBee.call(this);
   this.dept = 'sales';
   this.quota = 100;
}
SalesPerson.prototype = Object.create(WorkerBee.prototype);

function Engineer() {
   WorkerBee.call(this);
   this.dept = 'engineering';
   this.machine = '';
}
Engineer.prototype = Object.create(WorkerBee.prototype);

/**
 * public class SalesPerson extends WorkerBee {
 *    public String dept = "sales";
 *    public double quota = 100.0;
 * }
 * public class Engineer extends WorkerBee {
 *    public String dept = "engineering";
 *    public String machine = "";
 * }
 */
var jim = new Employee; // parentheses can be omitted if the constructor takes no arguments
// jim.name is ''
// jim.dept is 'general'
console.log(jim)

var sally = new Manager;
// sally.name is ''
// sally.dept is 'general'
// sally.reports is []

var fred = new SalesPerson;
// fred.name is ''
// fred.dept is 'sales'
// fred.projects is []
// fred.quota is 100

var jane = new Engineer;
// jane.name is ''
// jane.dept is 'engineering'
// jane.projects is []
// jane.machine is ''

var mark = new WorkerBee;
// mark.name is ''
// mark.dept is 'general'
// mark.projects is []
当 JavaScript 发现 new 操作符时，它会创建一个通用对象，并将其作为关键字 this 的值传递给 WorkerBee 的构造器函数。
`该构造器函数显式地设置 WorkeBee.projects 属性的值，然后``隐式地将其内部的 [[Prototype]] 属性设置为 WorkerBee.prototype 的值```
内置的 [[Prototype]] 属性决定了用于返回属性值的原型链。一旦这些属性设置完成，JavaScript 返回新创建的对象，然后赋值语句会将变量 mark 的值指向该对象。
这个过程不会显式的将 mark所继承的原型链中的属性值作为本地变量存放在 mark 对象中
当请求属性的值时，JavaScript 将首先检查对象自身中是否存在属性的值，
如果有，则返回该值。
如果不存在，JavaScript会检查原型链（使用内置的 [[Prototype]] 属性）。
如果原型链中的某个对象包含该属性的值，则返回这个值。
如果没有找到该属性，JavaScript 则认为对象中不存在该属性。
`mark 对象从 mark.__proto__ 中保存的原型对象中继承了 name 和 dept 属性的值`
并由 WorkerBee 构造器函数为 projects 属性设置了本地值。

// 添加属性
// 在 JavaScript 中，您可以在运行时为任何对象添加属性
mark.bounds = 3000  // 这样 mark 对象就有了 bonus 属性，而其它 WorkerBee 则没有该属性。

// 向某个构造器函数的原型对象中添加新的属性，那么该属性将添加到从这个原型中继承属性的所有对象的中。
Employee.prototype.specialty = "none";  // 向原型中添加属性，继承于该原型的对象都有该属性


// 具有默认值的构造函数
function Employee(name, dept) {
    this.name = name || ""
    this.dept = dept || ""
}
/**
public class Employee {
   public String name;
   public String dept;
   public Employee () {
      this("", "general");
   }
   public Employee (String name) {
      this(name, "general");
   }
   public Employee (String name, String dept) {
      this.name = name;
      this.dept = dept;
   }
}
*/
function WorkerBee (projs) {
  this.projects = projs || [];
}
WorkerBee.prototype = new Employee;
/**
public class WorkerBee extends Employee {
   public String[] projects;
   public WorkerBee () {
      this(new String[0]);
   }
   public WorkerBee (String[] projs) {
      projects = projs;
   }
}
*/
function Engineer (mach) {
   this.dept = "engineering";
   this.machine = mach || "";
}
Engineer.prototype = new WorkerBee;
/**
public class Engineer extends WorkerBee {
   public String machine;
   public Engineer () {
      dept = "engineering";
      machine = "";
   }
   public Engineer (String mach) {
      dept = "engineering";
      machine = mach;
   }
}
 */

如果我想在 Engineer 中设置继承来的 name 等属性，上面的方法是没法设置的，改进如下：
function Engineer(name, projs, mact) {
    this.base = WorkerBee
    this.base(name, "engineering", projs)
    this.machine = mach || ""
}
// 等价于：
function Engineer (name, projs, mach) {
  WorkerBee.call(this, name, "engineering", projs);
  this.machine = mach || "";
}

function Employee() {
    this.name = ""
    this.dept = "general"
}
function WorkerBee() {
    this.projects = []
}
WorkerBee.prototype = new Employee
var amy = new WorkerBee;
Employee.prototype.name = "Unknow"
console.log (amy)

WorkerBee {projects: Array(0)}
    projects:[]
    __proto__ : Employee
        dept: "general"
        name:""
        __proto__:
            name:"Unknow"
            constructor:ƒ Employee()
            __proto__:Object


function Employee () {
  this.dept = "general";
}
Employee.prototype.name = "";

function WorkerBee () {
  this.projects = [];
}
WorkerBee.prototype = new Employee;

var amy = new WorkerBee;

Employee.prototype.name = "Unknown";
console.log(amy)

WorkerBee {projects: Array(0)}
    projects:[]
    __proto__ : Employee
        dept: "general"
        __proto__:
            name:"Unknown"
            constructor: ƒ Employee()
            __proto__:Object