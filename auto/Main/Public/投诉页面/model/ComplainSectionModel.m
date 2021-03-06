//
//  ComplainSectionModel.m
//  chezhiwang
//
//  Created by bangong on 16/11/9.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import "ComplainSectionModel.h"

#pragma mark - ComplainBasicModel
@implementation ComplainBasicModel

/**设置提交数据*/
- (void)setDictionaryKeyValueWithDictionary:(NSMutableDictionary *)dictionary{
    
}
/**设置显示数据*/
- (void)setValueWithDictionary:(NSDictionary *)dictionary{
    
}

@end


#pragma mark - 模型一
@implementation ComplainModel

- (instancetype)initWithKey:(NSString *)key placeholder:(NSString *)placeholder text:(NSString *)value name:(NSString *)name style:(ComplainCellStyle)style{
    if (self = [super init]) {
        self.cellHeight = 50;
        _key = key;
        _placeholder = placeholder;
        _value = value;
        _name = name;
        _style = style;
    }
    return self;
}

- (NSString *)assertString{
    return nil;
}

/**设置提交数据*/
- (void)setDictionaryKeyValueWithDictionary:(NSMutableDictionary *)dictionary{
    dictionary[self.key] = self.value;
}

@end

#pragma mark - 图片
@implementation ComplainImageModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"上传图片";
        _key = @"Image";
        _imageArray = [[NSMutableArray alloc] init];
        self.cellHeight = (WIDTH-110 - 10)/3 + 30;
    }
    return self;
}
/**设置提交数据*/
- (void)setDictionaryKeyValueWithDictionary:(NSMutableDictionary *)dictionary{
   // dictionary[self.key] = self.value;
}

- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    if (imageArray.count > 2) {
        self.cellHeight = (WIDTH-110 - 10)/3 * 2 + 5 + 30;
    }else{
        self.cellHeight = (WIDTH-110 - 10)/3 + 30;
    }
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray{
    _imageUrlArray = imageUrlArray;
    NSMutableArray *images = [NSMutableArray array];
    __block  int count = 0;
    __weak __typeof(self)weakSelf = self;
    for (int i = 0; i < _imageUrlArray.count; i ++) {
        NSString *url = _imageUrlArray[i];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {

        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            count ++;
            if (image) {

                [images addObject:image];

            }
            if (count == imageUrlArray.count) {
                weakSelf.imageArray = images;
                [[NSNotificationCenter defaultCenter] postNotificationName:ComplainImageModelNotification object:nil];
            }
        }];
    }

}

@end

#pragma mark - 经销商
@implementation ComplainBusinessModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 150;
        _businessKey = @"Disname";
        _businessIdKey = @"Disid";
        _businessCustomKey = @"Buyname";
        _proPlaceholder = @"请选择省份、市区";
        _businessPlaceholder = @"请选择经销商";
    }
    return self;
}

/**设置提交数据*/
- (void)setDictionaryKeyValueWithDictionary:(NSMutableDictionary *)dictionary{

        if (self.custom == NO) {
            dictionary[self.businessIdKey] = self.lid;
            dictionary[self.businessKey] = self.businessValue;
        }else{
            dictionary[self.businessCustomKey] = self.businessValue;
        }
}

- (CGFloat)cellHeight{
    if (_custom) {
        return 102;
    }else{
        return 153;
    }
}

- (NSString *)province{
    if (_province == nil) {
        _province = @"";
    }
    return _province;
}

- (NSString *)city{
    if (!_city) {
        _city = @"";
    }
    return _city;
}

@end

#pragma mark -选择车型模型
@implementation ComplainBrandModel
- (instancetype)init
{
    self = [super init];
    if (self) {

        _brandIdKey = @"BrandId";
        _seriesIdKey = @"SeriesId";
        _modelIdKey = @"ModelId";

        _brandNameKey = @"Autoname";
        _seriesNameKey = @"Autopart";
        _modelNameKey  = @"Autostyle";

        self.cellHeight = 205;
    }
    return self;
}

- (void)resetSelected{

    NSInteger mMnt = _ModelId?[_ModelId integerValue]:0;
    NSInteger sMnt = _ModelId?[_SeriesId integerValue]:0;
    NSInteger bMnt = _ModelId?[_BrandId integerValue]:0;

    _brandSelected = NO;
    _seriesSelected = NO;
    _modelSelected = NO;

    if (bMnt == 0) {
        _brandSelected = YES;
        return;
    }

    if (sMnt == 0) {
        _seriesSelected = YES;
        return;
    }

    if (mMnt == 0) {
        _modelSelected = YES;
    }
}

/**设置提交数据*/
- (void)setDictionaryKeyValueWithDictionary:(NSMutableDictionary *)dictionary{
    if (self.brandSelected) {

    }else if (self.seriesSelected){
        dictionary[self.brandIdKey] = self.BrandId;
    }else if (self.modelSelected){
        dictionary[self.brandIdKey] = self.BrandId;
        dictionary[self.seriesIdKey] = self.SeriesId;
    }else{
       dictionary[self.brandIdKey] = self.BrandId;
       dictionary[self.seriesIdKey] = self.SeriesId;
       dictionary[self.modelIdKey] = self.ModelId;
    }

    dictionary[self.brandNameKey] = self.brandName;
    dictionary[self.seriesNameKey] = self.seriesName;
    dictionary[self.modelNameKey] = self.modelName;
}
@end


#pragma mark - 投诉类型
@implementation ComplainTypeModel

- (instancetype)initWithKey:(NSString *)key type:(NSString *)type{
    if (self = [super init]) {
        self.cellHeight = 190;
        _type = @"质量问题";
        _key = @"C_Tslx";
        _qualityKey = @"C_Tsbw";
        _servekey = @"C_Tsfw";
    }
    return self;
}

- (void)setDictionaryKeyValueWithDictionary:(NSMutableDictionary *)dictionary{
    dictionary[self.key] = self.type;
    dictionary[self.qualityKey] = self.qualityValue;
    dictionary[self.servekey] = self.serveValue;
}


@end

#pragma mark - section
@implementation ComplainSectionModel

+ (NSArray *)dataArray{

    ComplainSectionModel *section1 = [[ComplainSectionModel alloc] init];
    section1.image = [UIImage imageNamed:@"tss_07.gif"];
    section1.name = @"车主信息";
    section1.describe = @"您填写的信息我们会严格保密，敬请放心！";
    section1.viewHeight = 60;
    section1.rowModels = [section1 rowModelsOne];

    ComplainSectionModel *section2 = [[ComplainSectionModel alloc] init];
    section2.name = @"(选填)";
    section2.viewHeight = 50;
    section2.rowModels = [section2 rowModelsTwo];

    ComplainSectionModel *section3 = [[ComplainSectionModel alloc] init];
    section3.image = [UIImage imageNamed:@"tss_13.gif"];
    section3.name = @"车辆信息";
    section3.describe = @"请如实填写您要投诉的车辆信息。";
    section3.viewHeight = 60;
    section3.rowModels = [section3 rowModelsThree];

    ComplainSectionModel *section4 = [[ComplainSectionModel alloc] init];
    section4.image = [UIImage imageNamed:@"tss_10.gif"];
    section4.name = @"投诉内容";
    section4.describe = @"请务必如实、详细地描述完整的投诉信息。";
    section4.viewHeight = 60;
    section4.rowModels = [section4 rowModelsFourQuality];

    return @[section1,section2,section3,section4];
}

- (NSArray *)rowModelsOne{
    NSArray *array = @[
                       [[ComplainModel alloc] initWithKey:@"Name" placeholder:@"请输入您的真实姓名，否则无法与厂家根进协调" text:@"" name:@"姓名" style:ComplainCellStyleNomal],
                       [[ComplainModel alloc] initWithKey:@"Age" placeholder:@"请输入您的真实年龄" text:@"" name:@"年龄" style:ComplainCellStyleAge],
                       [[ComplainModel alloc] initWithKey:@"Sex" placeholder:@"选择您的性别" text:@"" name:@"性别" style:ComplainCellStyleSex],
                       [[ComplainModel alloc] initWithKey:@"Mobile" placeholder:@"请输入您的手机号" text:@"" name:@"移动电话" style:ComplainCellStylePhone]
                       ];

    
    return array;
}

- (NSArray *)rowModelsTwo{
    NSArray *array = @[
                       [[ComplainModel alloc] initWithKey:@"Email" placeholder:@"请输入您的电子邮箱" text:@"" name:@"电子邮箱" style:ComplainCellStyleEmail],
                       [[ComplainModel alloc] initWithKey:@"Telephone" placeholder:@"请输入您的固定电话" text:@"" name:@"固定电话" style:ComplainCellStylePhone],
                       [[ComplainModel alloc] initWithKey:@"Address" placeholder:@"请输入您的通讯地址" text:@"" name:@"通讯地址" style:ComplainCellStyleNomal],
                       [[ComplainModel alloc] initWithKey:@"Occupation" placeholder:@"请输入您的职业" text:@"" name:@"车主职业" style:ComplainCellStyleNomal]
                       ];
    return array;
}


- (NSArray *)rowModelsThree{
    NSArray *array = @[
                       [[ComplainBrandModel alloc] init],
                       [[ComplainModel alloc] initWithKey:@"Engine_Number" placeholder:@"请输入您的发动机号，可以在您的行驶本上查找" text:@"" name:@"发动机号" style:ComplainCellStyleNomal],
                       [[ComplainModel alloc] initWithKey:@"Carriage_Number" placeholder:@"请输入您的车架号，可以在您的行驶本上查找" text:@"" name:@"车架号" style:ComplainCellStyleNomal],
                       [[ComplainModel alloc] initWithKey:@"AutoSign" placeholder:@"请输入你的车牌号" text:@"" name:@"车牌号" style:ComplainCellStyleNomal],
                       [[ComplainModel alloc] initWithKey:@"Buyautotime" placeholder:@"选择购车日期" text:@"" name:@"购车日期" style:ComplainCellStyleBeginDate],
                       [[ComplainModel alloc] initWithKey:@"Questiontime" placeholder:@"选择出现问题日期" text:@"" name:@"出现问题日期" style:ComplainCellStyleEndDate],
                       [[ComplainModel alloc] initWithKey:@"mileage" placeholder:@"输入行驶里程" text:@"" name:@"已行驶里程(km)" style:ComplainCellStyleNomal],
                       [[ComplainBusinessModel alloc] init],
                       [[ComplainImageModel alloc] init]
                       ];
    
    return array;

}


- (NSArray *)rowModelsFourQuality{
    NSArray *array = @[
                       [[ComplainTypeModel alloc] initWithKey:@"C_Tslx" type:@"质量问题"],
                       [[ComplainModel alloc] initWithKey:@"Question" placeholder:@"控制在24个汉子以内，仅限于汉子、数字、字母" text:@"" name:@"问题简述" style:0],
                       [[ComplainModel alloc] initWithKey:@"Content" placeholder:@"输入投诉详情" text:@"" name:@"投诉详情" style:0]
                       ];

    ComplainModel *model = array[1];
    model.cellHeight = 80;
    model.desOrDetail = 0;

    model = array[2];
    model.cellHeight = 100;
    model.desOrDetail = 1;


    return array;
}



@end
