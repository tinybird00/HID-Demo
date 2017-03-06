//
//  ViewController.m
//  HID Demo
//
//  Created by mark on 2017/3/6.
//  Copyright © 2017年 mark. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UITextFieldDelegate, AVAudioPlayerDelegate>

@property (nonatomic, strong)UITextField *testField;

@property (nonatomic, strong)AVAudioPlayer *audioPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.audioPlayer play];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}
//远程控制回调
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    
    NSLog(@"eventType ============== %ld", (long)event.type);
    NSLog(@"eventSubType ============== %ld", (long)event.subtype);
    
}

#pragma mark - 懒加载

- (AVAudioPlayer *)audioPlayer {
    if (!_audioPlayer) {
        NSString *urlStr=[[NSBundle mainBundle]pathForResource:@"music.mp3" ofType:nil];
        NSURL *url=[NSURL fileURLWithPath:urlStr];
        NSError *error=nil;
        //初始化播放器，注意这里的Url参数只能是文件路径，不支持HTTP Url
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        //设置播放器属性
        _audioPlayer.numberOfLoops=0;//设置为0不循环
        _audioPlayer.delegate=self;
        [_audioPlayer prepareToPlay];//加载音频文件到缓存
        if(error){
            NSLog(@"初始化播放器过程发生错误,错误信息:%@",error.localizedDescription);
            return nil;
        }
        AVAudioSession *audioSession=[AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];
    }
    
    return _audioPlayer;
}

@end
