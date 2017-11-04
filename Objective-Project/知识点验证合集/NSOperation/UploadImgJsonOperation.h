//
//  UploadImgJsonOperation.h
//  知识点验证合集
//
//  Created by X-Liang on 2017/11/2.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadImgJsonOperation : NSOperation
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *JSON;
@end
