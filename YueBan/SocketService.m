//
//  SocketService.m
//  Yueban
//
//  Created by looperwang on 16/8/15.
//  Copyright © 2016年 looperwang. All rights reserved.
//

#import "SocketService.h"
#import "AsyncSocket.h"
#import "SocketRequestPackage.h"
#import "SocketresponsePackage.h"
#import <stdio.h>

typedef  NS_ENUM(NSUInteger, SocketConnectionState)
{
    SS_CONNECTED,
    SS_CONNECT_SUC,
    SS_CONNECT_FAIL
};

@interface SocketService ()

@property (nonatomic) SocketConnectionState state;

@property (nonatomic, strong) AsyncSocket *client;

@property (nonatomic, strong) NSMutableArray *willSentPackagePool;
@property (nonatomic, strong) NSMutableArray *sendingPackagePool;
@property (nonatomic, strong) NSMutableArray *failedPackagePool;

@property (nonatomic, strong) NSThread *sendThread;
@property (nonatomic, strong) NSLock *lock;

//@property (nonatomic, strong) NSMutableDictionary<SocketRequestPackage *, SocketresponsePackage *> *dic;

@property (nonatomic) NSUInteger needReceiveByteCount;

@property (nonatomic, assign) NSInteger currentCmd;

//@property (nonatomic, strong) NSMutableData *tempBuffer;
@property (nonatomic, strong) SocketRequestPackage *currentRequest;
@property (nonatomic, strong) SocketresponsePackage *currentResponse;

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, strong) NSMutableDictionary *dic;

@end

@implementation SocketService

+ (SocketService *)getInstance
{
    static SocketService *ss = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        ss = [[SocketService alloc] init];
        
        ss.serverAddr = @"10.67.55.60";
        ss.serverPort = 20000;
        
        ss.state = -1;
        
        ss.willSentPackagePool = [[NSMutableArray alloc] init];
        ss.sendingPackagePool  = [[NSMutableArray alloc] init];
        ss.failedPackagePool   = [[NSMutableArray alloc] init];
        //ss.dic = [[NSMutableDictionary alloc] init];
        ss.dic = [[NSMutableDictionary alloc] init];
        ss.needReceiveByteCount = 0;
        ss.lock = [[NSLock alloc] init];
        
        ss.sendThread = [[NSThread alloc] initWithTarget:ss selector:@selector(myThread) object:nil];
        [ss.sendThread start];
    });
    
    return ss;
}

- (void)connectToServer
{
    //NSLog(@"11111");
    if (self.client) {
        
        [self.client readDataWithTimeout:-1 tag:0];
        self.state = SS_CONNECT_SUC;
    } else
    {
        self.client = [[AsyncSocket alloc] initWithDelegate:self];
        
        NSError *err = nil;
        
        if (![self.client connectToHost:self.serverAddr onPort:self.serverPort error:&err]) {
            
            //NSLog(@"connect fail with error code : %@,   %ld", err.description, err.code);
            self.state = SS_CONNECT_FAIL;
        } else
        {
            //NSLog(@"connect success.");
            self.state = SS_CONNECT_SUC;
        }
    }
}

#pragma mark - AsyncSocketDelegate

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"Error");
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"did connect to host.");
    [self.client readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *aStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Hava received datas is :%@", aStr);
    
    [self.currentResponse.data appendData:data];
    
    NSInteger length = self.currentResponse.data.length;
    
    if (length >= 6)
    {
        [self.currentResponse.data getBytes:&_needReceiveByteCount length:4];
        [self.currentResponse.data getBytes:&_currentCmd range:NSMakeRange(4, 2)];
    } else if (length >= 4)
    {
        [self.currentResponse.data getBytes:&_needReceiveByteCount length:4];
    }
    
    if (self.needReceiveByteCount == length - 4)
    {
        //回调
        
        self.currentRequest = nil;
        self.currentResponse = nil;
        self.currentCmd = 0;
        self.needReceiveByteCount = 0;
        self.flag = NO;
    }
    
    [self.client readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"hava send data.");
//    [self.client disconnect];
//    [self.client setDelegate:nil];
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"did disconnect.");
    self.client = nil;
    self.client.delegate = nil;
}

#pragma mark -

- (void)addRequestToQueue:(SocketRequestPackage *)request
{
    [self.lock lock];
    
    [self.willSentPackagePool addObject:request];
    
    [self.lock unlock];
}

- (void)myThread
{
    while (true) {
        
        [self.lock lock];
        
        if (self.willSentPackagePool.count && !self.flag)
        {
            SocketRequestPackage *req = self.willSentPackagePool[0];
            
            [self.client writeData:req.data withTimeout:-1 tag:0];
            self.flag = YES;
            self.currentRequest = req;
            self.currentResponse = [[SocketresponsePackage alloc] init];
            
            [self.willSentPackagePool removeObject:req];
            [self.sendingPackagePool addObject:req];
        }
        
        [self.lock unlock];
        
        [NSThread sleepForTimeInterval:100.5];
    }
}

#pragma mark - interface

- (void)getAllSongsInfoWithBlockWithBlock:(void (^)(NSArray *, NSError *))block
{
    SocketRequestPackage *req = [[SocketRequestPackage alloc] init];
    
    req.cmdID = 0;
    req.data = [@"abcde" dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [self addRequestToQueue:req];
}

- (void)writeTest
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(test) object:nil];
    
    [thread start];
}

- (void)test
{
    NSArray *arr = @[@"abcde", @"abcde", @"abcde", @"abcde", @"abcde"];
    
    [self connectToServer];
    
    for (int i = 0; i < 5; i++) {
        [self.client writeData:[arr[i] dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:i];
        [NSThread sleepForTimeInterval:1];
        //NSLog(@"%d", i);
    }
}

//- (NSData *)convertToJavaUTF8(NSString *)str
//{
//    
//}

@end
