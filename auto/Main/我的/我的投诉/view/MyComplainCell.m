//
//  TheComplainCell.m
//  auto
//
//  Created by bangong on 15/6/17.
//  Copyright (c) 2015年 车质网. All rights reserved.
//

#import "MyComplainCell.h"

@implementation MyComplainCell
{
    UILabel *titleLabel;
    UILabel *stateLabel;//状态描述
    UILabel *timeLabel;
    UIImageView *imageView;
    UIView *lineView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //创建UI
        [self makeUI];
    }
    return self;
}


-(void)makeUI{
    
    CGFloat B = 17;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, WIDTH-20, 20)];
    titleLabel.font = [UIFont systemFontOfSize:B];
    titleLabel.textColor = colorBlack;
    
    stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 18)];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.textColor = RGB_color(237, 27, 36, 1);
    stateLabel.font = [UIFont systemFontOfSize:B-5];
    stateLabel.layer.cornerRadius = 4;
    stateLabel.layer.masksToBounds = YES;
    stateLabel.layer.borderColor = RGB_color(237, 27, 36, 1).CGColor;
    stateLabel.layer.borderWidth = 1;
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 150, 20)];
    timeLabel.font = [UIFont systemFontOfSize:B-5];
    timeLabel.textColor = colorLightGray;
    
    imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"top"];
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = colorLineGray;
    
    [self.contentView addSubview:titleLabel];
    [self.contentView addSubview:stateLabel];
    [self.contentView addSubview:timeLabel];
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:lineView];
    
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(15);
        make.right.equalTo(-40);
    }];
    
    [stateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(titleLabel.bottom).offset(10);
        make.size.equalTo(CGSizeMake(60, 18));
    }];
    
    [timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stateLabel.right).offset(10);
        make.centerY.equalTo(stateLabel);
    }];
    
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.centerY.equalTo(0);
    }];
    
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(0);
        make.top.equalTo(stateLabel.bottom).offset(15);
        make.height.equalTo(1);
    }];
}

-(void)setModel:(MyComplainModel *)model{
    if (_model != model) {
        _model = model;
    }
    if (!_model.isOpen) {
    
        imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }else{

        imageView.transform = CGAffineTransformIdentity;
    }
    titleLabel.text = _model.title;
    stateLabel.text = _model.status;
    timeLabel.text = _model.date;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
