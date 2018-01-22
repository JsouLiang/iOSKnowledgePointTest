//
//  CTView.m
//  CoreText
//
//  Created by X-Liang on 2017/11/10.
//  Copyright © 2017年 X-Liang. All rights reserved.
//

#import "CTView.h"
#import <CoreText/CoreText.h>
@implementation CTView


static CGFloat ascentCallBack(void *ref) {
    return [[(__bridge NSDictionary *)ref valueForKey:@"height"] floatValue];
}

static CGFloat descentCallBack(void *ref) {
    return 0;
}

static CGFloat widthCallBack(void *ref) {
    return [[(__bridge NSDictionary *)ref valueForKey:@"width"] floatValue];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //获取当前绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 翻转坐标系，指定初始值，向上移动 y 轴，按 x 轴上下翻转
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"\n这里在测试图文混排，\n我是一个富文本"];
    
    CTRunDelegateCallbacks callbacks;
    // memset将已开辟内存空间 callbacks 的首 n 个字节的值设为值 0, 相当于对CTRunDelegateCallbacks内存空间初始化
    memset(&callbacks, 0, sizeof(callbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallBack;
    callbacks.getDescent = descentCallBack;
    callbacks.getWidth = widthCallBack;
    
    NSDictionary * dicPic = @{@"height":@129,@"width":@400};
    // 创建回调，绑定的对象既是回调方法中的参数ref
    CTRunDelegateRef delelgate = CTRunDelegateCreate(&callbacks, (__bridge void *)dicPic);
    unichar placeholder = 0xFFFC; //创建空白字符
    NSString *placeholderStr = [NSString stringWithCharacters:&placeholder length:1];
    NSMutableAttributedString *placeholderAttrStr = [[NSMutableAttributedString alloc] initWithString:placeholderStr];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeholderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delelgate);    //给字符串中的范围中字符串设置代理
    CFRelease(delelgate);
    [attributeStr insertAttributedString:placeholderAttrStr atIndex:12];    //将占位符插入原富文本
    
    // 绘制文本。。。。。。。
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeStr);
    // 创建绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    NSInteger length =  attributeStr.length;
    // 根据绘制区域及富文本（可选范围，多次设置）设置frame
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path, NULL);
    CTFrameDraw(frame, context);
    // 绘制图片。。。。。。。
    UIImage * image = [UIImage imageNamed:@"image.png"];
    CGRect imgFrm = [self calculateImageRectWithFrame:frame];
    CGContextDrawImage(context,imgFrm, image.CGImage);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);

}


-(CGRect)calculateImageRectWithFrame:(CTFrameRef)frame {
    //根据frame获取需要绘制的线的数组
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    NSInteger count = lines.count;  //获取行数
    CGPoint points[count];  //建立存储每行起点的数组（cgpoint类型为结构体，故用C语言的数组）
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);//获取每行起点，Range(0,0) 表示获取所有行
    
    for (int index = 0; index < count; index++) {
        CTLineRef line = (__bridge CTLineRef)lines[index];
        // 获取 CTRun
        NSArray *runs = (__bridge NSArray *)CTLineGetGlyphRuns(line);
        for (int j = 0; j < runs.count; j++) {
            CTRunRef run = (__bridge CTRunRef)runs[j];
            NSDictionary *attributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef rundelegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (rundelegate == nil) {
                continue;
            }
            NSDictionary * dic = CTRunDelegateGetRefCon(rundelegate);//判断代理字典
            if (![dic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            CGPoint point = points[index];
            CGFloat ascent;//获取上距
            CGFloat descent;//获取下距
            CGRect boundsRun;//创建一个frame
            // 通过CTRunGetTypographicBounds取得宽，ascent和descent。
            boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            boundsRun.size.height = ascent + descent;   // 行高
            CGFloat offsetx = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL); // 获取当前 Run x 的偏移
            boundsRun.origin.x = point.x + offsetx;     // point是行起点位置，加上每个字的偏移量得到每个字的x
            boundsRun.origin.y = point.y - descent;     // 起点y 是行的 y 值减去下距
            CGPathRef path = CTFrameGetPath(frame);     // 获取绘制区域
            CGRect colRect = CGPathGetBoundingBox(path);// 获取剪裁区域边框
            CGRect imageBound = CGRectOffset(boundsRun, colRect.origin.x, colRect.origin.y);
            return imageBound;
        }
    }
    return CGRectZero;
}

@end
