#  Block

ARC
ARC 下 block 默认 strong (ARC下自动执行copy操作)
ARC 下 block 在不使用局部变量的情况下 存放于内存全局区


block 不copy (使用weak属性) 且 不使用局部变量 __NSGlobalBlock__ (NSConcreteGlobalBlock)
block 不copy (使用weak属性) 且 使用局部变量 __NSStackBlock__ (NSConcreteStackBlock)

block copy (使用strong或copy属性) 且 不使用局部变量 __NSGlobalBlock__ (NSConcreteGlobalBlock)
block copy (使用strong或copy属性) 且 使用局部变量 __NSMallocBlock__ (NSConcreteMallocBlock)




MRC
同上，区别仅是
ARC property属性会自动copy
MRC property属性不会自动copy，必须调用[xxx copy]




根据不同的思考习惯，换种方式总结
__NSGlobalBlock__ (NSConcreteGlobalBlock)全局区的block，编译器会将**未使用局部变量**的block放在**全局区**，这时就算copy也不会放在堆上
__NSStackBlock__ (NSConcreteStackBlock)栈区的block，编译器会将**使用局部变量**的block放在**栈区**，这时copy一下，就会放在堆上
__NSMallocBlock__ (NSConcreteMallocBlock)堆区的block，如果同时满足**copy**和**使用局部变量**就会放在这上面，这也印证了上面苹果所解释的内容

[参考](http://www.cocoachina.com/bbs/read.php?tid-1713528-page-1.html)