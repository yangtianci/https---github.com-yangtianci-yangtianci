//
//  Socket_ShortLink_Controller.m
//  杨天赐的个人项目
//
//  Created by yang on 17/1/13.
//  Copyright © 2017年 yangtianci. All rights reserved.
//

#import "Socket_ShortLink_Controller.h"

#import <arpa/inet.h>

////http://blog.csdn.net/yi_zz32/article/details/50023299

@interface Socket_ShortLink_Controller ()

@property (strong, nonatomic) UIWebView *webView;

@property (nonatomic) NSSocketNativeHandle clientSocket;

@end

@implementation Socket_ShortLink_Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    [self Connection];
    
    self.DetialInformation = @"自定义socket(C语言接口),抓取京东商品接口数据";
    
}

#pragma mark - ---------- 启动通信方法 ----------
-(void)Connection{
    
    if ([self ConnectionToHost:@"111.13.28.23" Port:80]) {
        
        //拼接请求
        NSString *request = @"GET / HTTP/1.1\r\n"
        "Host:m.jd.com\r\n"
        "User-Agent:iPhone AppleWebKit\r\n"
        "Connection:Close\r\n\r\n";
        
        NSString *ResultStr = [self SendMsgAndReciveMsg:request];
        //CLog(ResultStr);
        
        NSRange range = [ResultStr rangeOfString:@"\r\n\r\n"];
        if (range.location != NSNotFound) {
            NSString *html = [ResultStr substringFromIndex:range.location];
            NSLog(@"接收到的内容html = %@",html);
            [self.webView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://m.jd.com"]];
        }
    }
}

#pragma mark - ---------- 创建socket并连接至服务端 ----------
//根据约定的ip以及端口 传输方式在socket中设置
//执行connect函数时线程属于停止状态
-(BOOL)ConnectionToHost:(NSString*)host Port:(int)port{
    
    //创建socket client端
    self.clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    /**
     参数
     domain:    协议域/协议族，AF_INET(IPV4的网络开发)
     type:      Socket 类型，SOCK_STREAM(TCP)/SOCK_DGRAM(UDP,报文)
     protocol:  IPPROTO_TCP，协议，如果输入0，可以根据第二个参数自动选择协议
     
     返回值
     clientSocket，如果>0 就表示成功
     */
    
    //创建连接
    struct sockaddr_in socketServer;
    socketServer.sin_family = AF_INET;
    socketServer.sin_addr.s_addr = inet_addr(host.UTF8String);//传递本机ip
    socketServer.sin_port = htons(port);//传递端口
    /**
     参数
     1> 客户端socket
     2> 指向数据结构sockaddr的指针,其中包括目的端口和IP地址。即服务器的“结构体”地址
     3> 结构体数据长度
     返回值
     0 成功/其他 错误代号,非0即真
     */
    
    
    //准备连接,返回连接结果
    
    BOOL isConnectSuccess = connect(self.clientSocket, (const struct sockaddr *)&socketServer, sizeof(socketServer) == 0);
    /**
     socket
     服务器地址
     服务器地址长度
     */

    return (connect(self.clientSocket, (const struct sockaddr *)&socketServer, sizeof(socketServer)) == 0);
}


#pragma mark - ---------- 与服务端进行通信 ----------

-(NSString*)SendMsgAndReciveMsg:(NSString*)Request{
    
    //通过socket发送请求
    ssize_t sendLength = send(self.clientSocket, Request.UTF8String, strlen(Request.UTF8String), 0);
    NSLog(@"已发送%ld字节 %zd-%zd",sendLength,Request.length,strlen(Request.UTF8String));
    /**
     参数
     1> 客户端socket
     2> 发送内容地址 void * == id
     3> 发送内容长度,是指字节的长度。
     4> 发送方式标志，一般为0
     返回值
     如果成功，则返回发送的字节数，失败则返回SOCKET_ERROR
     */
    
    
    
    //接受socket返回数据
    uint8_t buffer[1024];//定义了返回数据大小
    
    NSMutableData *Result = [NSMutableData data];
    ssize_t recivelength = -1;
    while (recivelength != 0) {
        
        recivelength = recv(self.clientSocket, buffer, sizeof(buffer), 0);
        NSLog(@"已经接收%zd字节",recivelength);
        [Result appendBytes:buffer length:recivelength];
        
    }
    //recv函数接受数据,本身方法返回响应信息长度.具体的响应信息放置在申请好的二进制数组中
    /**
     参数1：客户端的socket
     参数2：接收内容的地址容器
     参数3：接收内容的长度,告诉服务器一次只能接收多少字节的内容
     参数4：接收方式标志，一般为0 表示阻塞式等待服务器响应
     
     返回
     — 接收的字节数
     */
    
    
    NSString *StrResult = [[NSString alloc]initWithData:Result encoding:NSUTF8StringEncoding];
    
    return StrResult;
}



#pragma mark - ---------- 断开连接方法 ----------

-(void)CloseConnection{
    close(self.clientSocket);
}






@end
