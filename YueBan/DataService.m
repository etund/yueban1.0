//
//  DataService.m
//  Yueban
//
//  Created by looperwang on 16/8/16.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import "DataService.h"

#import "AFNetworking.h"
#import "SongInfo.h"

#define SERVER_INFO @"http://10.67.55.60:8080/Foundation/yueban!"

@implementation DataService

+ (DataService *)getInstance
{
    static DataService *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[DataService alloc] init];
    });
    
    return instance;
}

- (void)getSongListWithBlock:(void (^)(NSArray *, NSArray *, NSArray *, NSError *))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager GET:[SERVER_INFO stringByAppendingString:@"querySongList.do"]
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              dispatch_queue_t globalDispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
              
              dispatch_async(globalDispatchQueue, ^{
                  
                  NSArray *responseArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                  
                  NSMutableArray *songArr = [[NSMutableArray alloc] init];
                  NSMutableArray *songNameArr = [[NSMutableArray alloc] init];
                  NSMutableArray *singerArr = [[NSMutableArray alloc] init];
                  
                  for (NSInteger i = 0; i < responseArr.count; i++) {
                      SongInfo *temp = [[SongInfo alloc] init];
                      
                      temp.songName = [[responseArr[i] objectForKey:@"songName"] isMemberOfClass:[NSNull class]] ? @"" : [responseArr[i] objectForKey:@"songName"];
                      temp.singer = [[responseArr[i] objectForKey:@"songSinger"] isMemberOfClass:[NSNull class]] ? @"" : [responseArr[i] objectForKey:@"songSinger"];
                      temp.songID = [[responseArr[i] objectForKey:@"songId"] isMemberOfClass:[NSNull class]] ? -1 : [[responseArr[i] objectForKey:@"songId"] integerValue];
                      temp.songSize = [responseArr[i][@"songSize"] isMemberOfClass:[NSNull class]] ? -1 : [responseArr[i][@"songSize"] integerValue];
                      temp.songURL = [responseArr[i][@"songUrl"] isMemberOfClass:[NSNull class]] ? @"" : responseArr[i][@"songUrl"];
                      
                      [songArr addObject:temp];
                      [songNameArr addObject:temp.songName];
                      
                      if (![singerArr containsObject:temp.singer]) [singerArr addObject:temp.singer];
                  }
                  
                  dispatch_async(dispatch_get_main_queue(), ^{
                      
                      if (block) {
                          block(songArr, songNameArr, singerArr, nil);
                      }
                  });
              });
              
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block) {
                  block(nil, nil, nil, error);
              }
          }];
}

//- (void)createBubbleWithUser:(NSInteger)uid songList:(NSArray *)songs tags:(NSArray *)tags callBack:(void (^)(BOOL, NSError *))block
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    //manager.responseSerializer= [AFHTTPResponseSerializer serializer];
//    //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    
//    NSDictionary *params = @{@"uid" : [NSNumber numberWithInteger:uid],
//                             @"songsId" : songs,
//                             @"tags" : tags};
//    
//    [manager POST:[SERVER_INFO stringByAppendingString:@"djStart.do"]
//       parameters:params
//          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//              NSLog(@"%@", str);
//              
//              if (block)
//              {
//                  block(YES, nil);
//              }
//       }  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//           if (block)
//           {
//               block(NO, error);
//           }
//       }];
//}
- (void)createBubbleWithUser:(NSString *)uid songList:(NSString *)songs tags:(NSString *)tags callBack:(void (^)(BOOL, NSError *))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    NSDictionary *params = @{@"uid" : uid,
                             @"songsId" : songs,
                             @"tags" : tags};
    
    [manager POST:[SERVER_INFO stringByAppendingString:@"djStart.do"]
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//              NSLog(@"%@", str);
              
              if (block)
              {
                  block(YES, nil);
              }
          }  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (block)
              {
                  block(NO, error);
              }
          }];
}



@end
