//
//  YBProtocol.m
//  YueBan
//
//  Created by nmhuang on 16/8/15.
//  Copyright © 2016年 com.tencent. All rights reserved.
//

#import "YBProtocol.h"

@implementation YBProtocol


//返回NSString数组,第一项为length,第二项为event type,其余项为数据,比如url
+ (NSArray *)decode:(NSData *)data
{
    if(data == nil){
        return nil;
    }
    
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *length = [text substringWithRange:NSMakeRange(0, 4)];
    NSString *type = [text substringWithRange:NSMakeRange(4, 2)];
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    [retArray addObject:length];
    [retArray addObject:type];
    
    int searchPos = 6;
    NSRange range = [text rangeOfString:@"|"];
    while(range.location != NSNotFound){
        NSString * tmp = [text substringWithRange:NSMakeRange(searchPos, range.location - searchPos)];
        [retArray addObject:tmp];
        searchPos = range.location + 1;
        range = [text rangeOfString:@"|"];
    }
    
    if(searchPos < [text length] - 2)
    {
        NSString * tmp = [text substringWithRange:NSMakeRange(searchPos, [text length]- 2 -searchPos)];
        [retArray addObject:tmp];
    }
    
    return retArray;
}

//输入项为NSString数组，数组第一项为event type,其余每一项为数据
+ (NSData *)encode:(NSArray *)data
{
    if(data == nil){
        return nil;
    }
    
    NSMutableString *text = [[NSMutableString alloc] initWithString:@"0000"];
    for(int i=0;i<[data count];i++)
    {
        [text appendString:data[1]];
        if(i < [data count]-1){
            [text appendString:@"|"];
        }else{
            [text appendString:@"@@"];
        }
    }
    int length = [text length] - 4;
    [text replaceCharactersInRange:NSMakeRange(0,4) withString:[NSString stringWithFormat:@"%0.4i",length]];
    
    NSData *byteArray = [text dataUsingEncoding:NSUTF8StringEncoding];
    return byteArray;
}

@end
