//
//  MenuViewController.m
//  WKCircleMenu
//
//  Created by 吴珂 on 16/1/29.
//  Copyright © 2016年 MyCompany. All rights reserved.
//

#import "MenuViewController.h"
#import "WKCircleMenuView.h"

#define KBigWH 300

@interface MenuViewController ()<WKCircleMenuViewDelegate>

@property (nonatomic, strong) WKCircleMenuView *menuView;
- (IBAction)showCircleMenu:(id)sender;

@property (nonatomic, assign) BOOL showMenu;

@end

@implementation MenuViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _showMenu = NO;
    
    [self addCircleMenu];
    
    self.view.backgroundColor = [UIColor purpleColor];
}

- (void)addCircleMenu
{
    _menuView = [[WKCircleMenuView alloc] initWithFrame:CGRectMake(0, 0, KBigWH, KBigWH) images:@[@"download",@"more",@"homeschool",@"location",@"more",@"homeschool"]];
    
    _menuView.center = self.view.center;
    _menuView.backgroundColor = [UIColor whiteColor];
    _menuView.layer.cornerRadius = _menuView.bounds.size.width / 2;
    _menuView.layer.masksToBounds = YES;
    _menuView.layer.borderWidth = 1.f;
    _menuView.hidden = YES;
    _menuView.delegate = self;
    _menuView.transform = CGAffineTransformMakeScale(0.0, 0.0);
    
    [self.view addSubview:_menuView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - WKCircleMenuViewDelegate
- (void)menuView:(WKCircleMenuView *)menuView didSelectAtIndex:(NSInteger)index
{
    UIViewController *detailController = [[UIViewController alloc] init];
    detailController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailController animated:YES];
}

- (IBAction)showCircleMenu:(id)sender {
    
    _showMenu = !_showMenu;
    
    if (_showMenu) {
        _menuView.hidden = NO;
        [_menuView removeBtnAnimation];
        [_menuView.layer removeAllAnimations];
        [UIView animateWithDuration:0.3f animations:^{
            _menuView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            [_menuView showMenuItem];
        }];
        
        
        
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            _menuView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        } completion:^(BOOL finished) {
            if (finished) {
                _menuView.hidden = YES;
                [_menuView hideMenuItem];
            }
            
        }];
    }
    
    
    
    
}
@end
