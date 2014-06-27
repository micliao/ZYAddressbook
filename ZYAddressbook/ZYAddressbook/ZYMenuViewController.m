//
//  ZYMenuViewController.m
//  ZYAddressbook
//
//  Created by elemeNT on 14-6-26.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYMenuViewController.h"

@interface ZYMenuViewController ()

@end

@implementation ZYMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *menuSec1 = [[NSArray alloc] initWithObjects:@"s1-0",@"s1-1",nil];
    NSArray *menuSec2 = [[NSArray alloc] initWithObjects:@"s2-0",@"s2-1",nil];
    NSArray *menuSec3 = [[NSArray alloc] initWithObjects:@"s3-0",@"s3-1",nil];
    NSArray *menuSec4 = [[NSArray alloc] initWithObjects:@"s4-0",nil];
    
    self.menus = [[NSArray alloc] initWithObjects:menuSec1,menuSec2,menuSec3,menuSec4,nil];
    
    
	// Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.menus[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifer = @"menuCollectionCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.menus count];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
