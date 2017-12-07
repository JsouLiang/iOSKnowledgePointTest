#  自己实现 KVO

#### 知识点 1. 动态创建指定类的子类

```objective-c
Class newClass = objc_allocateClassPair(superClassName, className, 0);		// 创建一个名为 superClassName 的子类，名为 className

class_addMethod(newClass, @selector(***), (IMP)function, "v@:");
objc_registerClassPair(newClass);
```



[参考](http://tech.glowing.com/cn/implement-kvo/)
