//
//  KGWelcomeViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 neuedu. All rights reserved.
//

#import "KGWelcomeViewController.h"
#import "KGHomePageViewController.h"

#define kStartbuttonCenterYRatio 550.f/667.f
#define kPageControlCenterYRatio 637.f/667.f

@interface KGWelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation KGWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // scrollView填充屏幕
    _scrollView.frame=[UIScreen mainScreen].bounds;
    //让pageControl处于屏幕的637.f/667.f比例的位置
    _pageControl.center=CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, kPageControlCenterYRatio*[UIScreen mainScreen].bounds.size.height);
    
    
    // 设置scrollView 包括显示的图片以及contentSize等
    [self setUpScrollView];
    
    // 设置pageControl的数量
    _pageControl.numberOfPages=5;
    
    

}


#pragma mark - 设置scrollView 包括显示的图片以及contentSize等
-(void)setUpScrollView{
    for (int i=0; i<5; i++) {
        UIImageView *imageView=[[UIImageView alloc]init];
        NSString *imageName=[NSString stringWithFormat:@"introduction_%d",i+1];
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.frame=CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        
        if (i==4) {
            //添加开启音乐之旅按钮
            [self addStartButton:imageView];
            imageView.userInteractionEnabled = YES;
        }
        [_scrollView addSubview:imageView];
    }

    _scrollView.contentSize=CGSizeMake(5*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _scrollView.bounces=NO;
    _scrollView.pagingEnabled=YES;
    

}

#pragma mark - 添加开启音乐之旅按钮
-(void)addStartButton:(UIImageView *)imageView{
    UIButton *startbutton=[[UIButton alloc]init];
    //startbutton.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-122.f)*0.5,550, 122, 32);
    startbutton.bounds=CGRectMake(0, 0,122, 32);
    startbutton.center=CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*kStartbuttonCenterYRatio );
    [startbutton setImage:[UIImage imageNamed:@"introduction_enter_nomal"] forState:UIControlStateNormal];
    [startbutton setImage:[UIImage imageNamed:@"introduction_enter_press"] forState:UIControlStateHighlighted];
    
    [imageView addSubview:startbutton];
    [startbutton addTarget:self action:@selector(clickeStartButton)  forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 进入音乐之旅
-(void)clickeStartButton{

    
    //直接讲主页设置为window的RootViewController  这样就不会再回到欢迎页了
    UIStoryboard  *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    KGHomePageViewController* homeVC=[storyboard instantiateViewControllerWithIdentifier:@"homePage"];
    
    [UIApplication sharedApplication].keyWindow.rootViewController=homeVC;
    
 
}

//scrollView减速的时候调用这个函数
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger number=(NSUInteger)_scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    _pageControl.currentPage=number;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
