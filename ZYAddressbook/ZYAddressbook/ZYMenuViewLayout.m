//
//  ZYMenuViewLayout.m
//  ZYAddressbook
//
//  Created by elemeNT on 14-6-30.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYMenuViewLayout.h"

@implementation ZYMenuViewLayout


-(void)prepareLayout{
    [super prepareLayout];
    self.itemBaseWidth = self.itemBaseHeight = 100;
    self.itemWidth = 1.4 - 0.2 * self.numberOfItemsInSection;
    self.itemHeight = 1.4 - 0.2 * self.numberOfSections;
    self.collectionViewSize = self.collectionView.frame.size;
    self.numberOfSections = self.collectionView.numberOfSections;
    self.widthSpacing = (self.collectionViewSize.width/self.numberOfItemsInSection-self.itemWidth)/2;
    self.heightSpacing = (self.collectionViewSize.height/self.numberOfSections-self.itemHeight)/2;
    
}

- (CGSize)collectionViewContentSize{
    return self.collectionViewSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* attributesList = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.numberOfItems; i++) {
        //这里利用了-layoutAttributesForItemAtIndexPath:来获取attributes
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributesList addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributesList;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes =  [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = CGSizeMake(self.itemWidth, self.itemHeight);
    attributes.center = CGPointMake((indexPath.item%self.numberOfItemsInSection)*(3*self.widthSpacing+self.itemWidth) + self.itemWidth/2, (indexPath.item/self.numberOfItemsInSection)*(3*self.heightSpacing+self.itemHeight) + self.itemHeight/2);
    return attributes;
}




@end
