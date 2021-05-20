//
//  NewsCell.m
//  YFTabBar
//
//  Created by yangfan on 2018/3/27.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface NewsCell()

@property (weak, nonatomic)  UIImageView *cover;
@property (weak, nonatomic)  UILabel *title;

@end

@implementation NewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        label.numberOfLines = 0;
        
        [self.contentView addSubview:imageView];
        [self.contentView addSubview:label];
        
        self.cover = imageView;
        self.title = label;
        
        
        //Masonry自动布局
        [self.cover makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView).offset(8);
            make.left.equalTo(self.contentView).offset(8);
            make.width.equalTo(90);
            make.height.equalTo(60);
            
        }];
        
        [self.title makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView).offset(8);
            make.left.equalTo(self.cover.right).offset(8);
            make.right.equalTo(self.contentView).offset(-8);
            make.bottom.equalTo(self.contentView).offset(-8);
            
            //当文字不多的时候 高度和图片一样 否则图片显示不全
            make.height.mas_greaterThanOrEqualTo(self.cover.height);
            
        }];
        
        
    }
    
    return self;
    
}


-(void)setNews:(News *)news{
    
    _news = news;
    
    self.title.text = news.title;
    
    [self.cover sd_setImageWithURL:[NSURL URLWithString:news.cover] placeholderImage:[UIImage imageNamed:@"img"]];
    
    
}
@end
