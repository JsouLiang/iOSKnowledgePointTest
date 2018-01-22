
#### 1. 通过 Person 类验证 KVV 功能  KVVTest.m

当外界调用对象的`-validateValue: forKey: error:`方法时，如果对象实现了 `-validate<key>...`方法，会自动调用该方法，检查具体对应的 key-value

如：

```objective-c
@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *love;
@end
-(BOOL)validateName:(id *)value error:(out NSError * _Nullable __autoreleasing *)outError{  //在implementation里面加这个方法，它会验证是否设了非法的value
NSString *inputValue = *value;
NSLog(@"validateName: %@", inputValue);
return YES;
}

-(BOOL)validateLove:(id *)value error:(out NSError * _Nullable __autoreleasing *)outError{  //在implementation里面加这个方法，它会验证是否设了非法的value
NSString *inputValue = *value;
NSLog(@"validateLove: %@", inputValue);
return YES;
}
Person *person = [Person new];
NSString *nameKey = @"name";
NSString *nameValue = @"name";
NSString *loveKey = @"love";
NSString *loveValue = @"love";
[person validateValue:&nameValue forKey:nameKey error:nil];        // 调用 validateName
[person validateValue:&loveValue forKey:loveKey error:nil];        // 调用 validateLove
```

如果即实现了`validateValue...` 有实现了单独的`-validate<key>..` 那么会调用`validateValue` 方法

如：

```objective-c
- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError * _Nullable __autoreleasing *)outError {
...
return YES;
}

-(BOOL)validateName:(id *)value error:(out NSError * _Nullable __autoreleasing *)outError{  //在implementation里面加这个方法，它会验证是否设了非法的value
...
return YES;
}

-(BOOL)validateLove:(id *)value error:(out NSError * _Nullable __autoreleasing *)outError{  //在implementation里面加这个方法，它会验证是否设了非法的value
...
return YES;
}
[person validateValue:&nameValue forKey:nameKey error:nil];        // 调用 validateValue
[person validateValue:&loveValue forKey:loveKey error:nil];        // 调用 validateValue
```



