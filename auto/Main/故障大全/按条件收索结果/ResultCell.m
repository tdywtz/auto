//
//  ResultCell.m
//  auto
//
//  Created by bangong on 15/6/9.
//  Copyright (c) 2015年 车质网. All rights reserved.
//

#import "ResultCell.h"
#include <stdarg.h>
@implementation ResultCell
{
    UIImageView *imageView;
    UILabel *nameLalbel;
    UILabel *modelLabel;
    UILabel *label1;
    UILabel *label2;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //创建UI
        [self makeUI];
        
    }
    return self;
}

-(void)makeUI{
   
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 80, 60)];
    [self.contentView addSubview:imageView];
    
    nameLalbel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 140, 20)];
    nameLalbel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:nameLalbel];
    
    modelLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-80, 10, 70, 20)];
    modelLabel.font = [UIFont systemFontOfSize:15];
    modelLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:modelLabel];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 74, WIDTH, 1)];
    view.backgroundColor = colorLineGray;
    [self.contentView addSubview:view];
    
   // point = CGPointMake(100, 30);
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, WIDTH-110, 20)];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = colorLightGray;
    [self.contentView addSubview:label1];
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, WIDTH-110, 20)];
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = colorLightGray;
    [self.contentView addSubview:label2];
}

-(void)setModel:(ResultModel *)model{
    if (_model != model) {
        _model = model;
    }

    [imageView sd_setImageWithURL:[NSURL URLWithString:_model.Logo] placeholderImage:[CZWManager defaultIconImage]];
    nameLalbel.text = _model.name;
    modelLabel.text = _model.attribute;
    label1.attributedText = model.attribut1;
    label2.attributedText = model.attribut2;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
