//
//  HomeControlViewModel.m
//  ReactiveCocoa
//
//  Created by X-Liang on 2017/11/18.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "HomeControlViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>
#import "HomeRecommendItem.h"
#import <MJExtension/MJExtension.h>

static NSString *url = @"https://www.yunke.com/interface/main/home";
static NSString * const salt = @"gn1002015";

@interface HomeControlViewModel()
@property (nonatomic, strong) RACCommand *loadHomeDataCommand;
@end

@implementation HomeControlViewModel

- (RACCommand *)loadHomeDataCommand {
    if (!_loadHomeDataCommand) {
        // 请求 Home 页面数据
        _loadHomeDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                id param = [HomeControlViewModel paramWithHome];
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
                [manager GET:url
                  parameters:param
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         // 通过 subscriber 将 response 传递出去
                         [subscriber sendNext:[self parseData:responseObject]];
                         [subscriber sendCompleted];
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         [subscriber sendError:error];
                     }];
                return nil;
            }];
        }];
    }
    return _loadHomeDataCommand;
}
// 解析数据，字典转模型
- (NSArray *)parseData: (NSDictionary *)responseObject {
    // 数据处理
    // 获取推荐课程（栅栏广告）
    NSDictionary *result = responseObject[@"result"];
    
    NSDictionary *recommendsDict = result[@"recommends"];
    NSArray *recommends;
    
    // 字段转模型
    recommends =  [HomeRecommendItem mj_objectArrayWithKeyValuesArray: recommendsDict[@"courses"]];
    return recommends;
}

#pragma mark -
+ (NSDictionary *)paramWithHome
{
    NSDictionary * params = @{@"city":@"中国",
                              @"cityId":@0,
                              //                              @"condition":userDict[@"condition"],
                              @"condition":@"35,33,32,35,34",
                              //                              @"teacherSeach":userDict[@"teacherSeach"],
                              @"teacherSeach":@"1000,1000,1000"
                              };
    NSString *version = [self Version];
    
    //   获取当前的时间
    int liTime = [self getDateByInt];
    NSString *keymd5 = [self md5ForParamas:params time:liTime];
    NSDictionary *myparamses =@{
                                @"u":@"i",
                                @"v":version,
                                @"time":@(liTime),
                                @"params":params,
                                @"key":keymd5
                                //                                @"dinfo":[self getDinfo]
                                };
    //    NSLog(@"%@",myparamses);
    
    return myparamses;
}

// 获取当前时间
+ (int)getDateByInt
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormat dateFromString:[dateFormat stringFromDate:[NSDate date]]];
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    int liDate = (int) dateInterval;
    return liDate;
}

// 参数md5 key值
+ (NSString *)md5ForParamas:(NSDictionary *)paramas time:(int) aiTime
{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramas options:NSJSONReadingAllowFragments error:nil];
    // NSJSONReadingAllowFragments : 使用这个
    // NSJSONWritingPrettyPrinted 会有\n，不需要
    NSString *jsonParserString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSString *myString = [NSString stringWithFormat:@"%@%d%@",jsonParserString,aiTime, salt];
    
    NSString *keyMD5 = [self getMd5_32Bit_String:myString];
    NSString *keymd5 = [self getMd5_32Bit_String:keyMD5];
    
    return keymd5;
}

//  MD5
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString
{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

+ (NSString *)Version {
    
    NSString *string = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:string];
    NSString *version = [dic objectForKey:@"CFBundleVersion"];
    return version;
    
}


@end

