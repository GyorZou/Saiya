

#import "XWHelper.h"
#import "BaseViewController.h"

@implementation XWHelper

+(NSString *)documentPathOfFilename:(NSString *)name atFolder:(NSString *)folder
{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // EWJLog(@"paths====%@",paths);
        NSString *docspath = [paths objectAtIndex:0];
    
        if (folder ) {
            docspath =  [docspath stringByAppendingPathComponent:folder];
        }
        return [docspath stringByAppendingPathComponent:name];
    
}
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                              image:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView;
}

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  textColor:(UIColor *)color
              textAlignment:(NSTextAlignment)alignment
                       font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.textAlignment = alignment;
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                               text:(NSString *)text
                    placeholderText:(NSString *)placeholdertext
                          textColor:(UIColor *)color
                      textAlignment:(NSTextAlignment)alignment
               textContentAlignment:(UIControlContentHorizontalAlignment)contentalignment
                               font:(UIFont *)font
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.text = text;
    textField.placeholder = placeholdertext;
    textField.textColor = color;
    textField.textAlignment = alignment;
    textField.contentHorizontalAlignment = contentalignment;
    textField.font = font;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    return textField;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        nfile:(NSString *)nfileName
                        sfile:(NSString *)sfileName
                          tag:(NSInteger)buttonTag
                       action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:nfileName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:sfileName] forState:UIControlStateHighlighted];
    [button setFrame:frame];
    [button setTag:buttonTag];
    button.exclusiveTouch = YES;
    [button addTarget:nil action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//扩展设置setImage的Button （而不是setBackgroundImage)
+ (UIButton *)buttonsetIamgeWithFrame:(CGRect)frame
                                nfile:(NSString *)nfileName
                                sfile:(NSString *)sfileName
                                  tag:(NSInteger)buttonTag
                               action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:[UIImage imageNamed:nfileName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:sfileName] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:sfileName] forState:UIControlStateSelected];
    [button setTag:buttonTag];
    button.exclusiveTouch = YES;
    [button addTarget:nil action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                         file:(NSString *)fileName
                        title:(NSString *)title
                          tag:(NSInteger)buttonTag
                       action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:fileName] forState:UIControlStateNormal];
	[button.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [button setFrame:frame];
    [button setTag:buttonTag];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.exclusiveTouch = YES;
    [button addTarget:nil action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                    nfileName:(NSString *)nfileName
                    sfileName:(NSString *)sfileName
                       ntitle:(NSString *)ntitle
                       stitle:(NSString *)stitle
                  ntitleColor:(UIColor *)ntitleColor
                  stitleColor:(UIColor *)stitleColor
                         font:(UIFont *)font
                    alignment:(NSTextAlignment)alignment
                          tag:(NSInteger)tag
                     delegate:(id)delegate
                       action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTag:tag];
    
    UIImage *stateImage = [[UIImage imageNamed:nfileName] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    UIImage *highlightImage = [[UIImage imageNamed:sfileName] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    [button setBackgroundImage:stateImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateSelected];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    [button setTitle:ntitle forState:UIControlStateNormal];
    [button setTitle:stitle forState:UIControlStateSelected];
    [button setTitle:stitle forState:UIControlStateHighlighted];
    
    [button setTitleColor:ntitleColor forState:UIControlStateNormal];
    [button setTitleColor:stitleColor forState:UIControlStateSelected];
    [button setTitleColor:stitleColor forState:UIControlStateHighlighted];
    
    [button.titleLabel setFont:font];
    [button.titleLabel setTextAlignment:alignment];
    button.exclusiveTouch = YES;
    [button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)buttonsetImageAndTitleWithFrame:(CGRect)frame
                                    nfileName:(NSString *)nfileName
                                    sfileName:(NSString *)sfileName
                                       ntitle:(NSString *)ntitle
                                       stitle:(NSString *)stitle
                                  ntitleColor:(UIColor *)ntitleColor
                                  stitleColor:(UIColor *)stitleColor
                   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontaolAlignment
                                         font:(UIFont *)font
                                    alignment:(NSTextAlignment)alignment
                                          tag:(NSInteger)tag
                                     delegate:(id)delegate
                                       action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTag:tag];
    
    UIImage *stateImage = [[UIImage imageNamed:nfileName] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    UIImage *highlightImage = [[UIImage imageNamed:sfileName] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    [button setImage:stateImage forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button setImage:highlightImage forState:UIControlStateSelected];
    
    [button setTitle:ntitle forState:UIControlStateNormal];
    [button setTitle:stitle forState:UIControlStateHighlighted];
    [button setTitle:stitle forState:UIControlStateSelected];
    
    [button setTitleColor:ntitleColor forState:UIControlStateNormal];
    [button setTitleColor:stitleColor forState:UIControlStateSelected];
    [button setTitleColor:stitleColor forState:UIControlStateHighlighted];
    
    [button.titleLabel setFont:font];
    [button.titleLabel setTextAlignment:alignment];
    [button setContentHorizontalAlignment:contentHorizontaolAlignment];
    button.exclusiveTouch = YES;
    [button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

//chj 添加不能点击状态
+ (UIButton *)buttonsetIamgeWithFrame:(CGRect)frame
                                stateImg:(NSString *)stateImg
                                highlightImg:(NSString *)highlightImg
                                disableImg:(NSString *)disableImg
                                  tag:(NSInteger)tag
                               target:(SEL)target
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    
    UIImage *stateImage = [[UIImage imageNamed:stateImg] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    UIImage *highlightImage = [[UIImage imageNamed:highlightImg] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    UIImage *disableImage = [[UIImage imageNamed:disableImg] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    [button setBackgroundImage:stateImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:disableImage forState:UIControlStateDisabled];
    [button setTag:tag];
    button.exclusiveTouch = YES;
    [button addTarget:nil action:target forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonsetIamgeWithFrame:(CGRect)frame
                           disableImg:(NSString *)disableImg
                            normalImg:(NSString *)normalImg
                         highlightImg:(NSString *)highlightImg
                                title:(NSString *)title
                        distitleColor:(UIColor *)distitleColor
                          ntitleColor:(UIColor *)ntitleColor
                                 font:(UIFont *)font
                                  tag:(NSInteger)tag
                               target:(SEL)target;
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    UIImage *nImg = [[UIImage imageNamed:normalImg] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    UIImage *highlightImage = [[UIImage imageNamed:highlightImg] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    UIImage *disableImage = [[UIImage imageNamed:disableImg] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    [button setBackgroundImage:nImg forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:disableImage forState:UIControlStateDisabled];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:distitleColor forState:UIControlStateDisabled];
    [button setTitleColor:ntitleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button setTag:tag];
    button.exclusiveTouch = YES;
    [button addTarget:nil action:target forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonsetIamgeWithFrame:(CGRect)frame
                          normalBgImg:(NSString *)normalbBgImg
                          selectBgImg:(NSString *)selectBgImg
                                title:(NSString *)title
                          nTitleColor:(UIColor *)ntitleColor
                          sTitleColor:(UIColor *)stitleColor
                                 font:(UIFont *)font
                                  tag:(NSInteger)tag
                               target:(SEL)target
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    UIImage *normalImg = [[UIImage imageNamed:normalbBgImg] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    UIImage *selectImage = [[UIImage imageNamed:selectBgImg] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [button setBackgroundImage:normalImg forState:UIControlStateNormal];
    [button setBackgroundImage:selectImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:selectImage forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:ntitleColor forState:UIControlStateNormal];
    [button setTitleColor:stitleColor forState:UIControlStateSelected];
    [button setTitleColor:stitleColor forState:UIControlStateHighlighted];
    [button.titleLabel setFont:font];
    [button setTag:tag];
    button.exclusiveTouch = YES;
    [button addTarget:nil action:target forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIButton *)initBtnWithFrame:(CGRect)frame
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font
                          tag:(NSInteger)tag
                       action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setBackgroundImage:[[UIImage imageNamed:@"job_content_s.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateHighlighted];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
    lineView.backgroundColor = RGBColor(210, 210, 210);
    [button addSubview:lineView];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-6, frame.size.height-5-6, 6, 6)];
    iconImageView.image = [UIImage imageNamed:@"job_detail_triangle"];
    [button addSubview:iconImageView];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 14)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button setTag:tag];
    button.exclusiveTouch = YES;
    [button addTarget:nil action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


+(BOOL)isIOS7{
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if (currSysVer.floatValue >= 7.0) {
        return YES;
    }
    
    return NO;
}

+(NSString *)thumbnailFromImageString:(NSString *)imageUrlString imageWithWidth:(NSInteger)imageWidth  imageWithHeight:(NSInteger)imageHeight
{
    NSString *subStr = @"sta.pupuwang.cn";
    NSString *subStr1 = @"e-img.pupuwang.cn";
    if (imageUrlString.length==1 || [imageUrlString isEqualToString:@""]) {
        return imageUrlString;
    }else {
        NSArray *SeparatedArray =[imageUrlString componentsSeparatedByString:@"/"];
        if ([[SeparatedArray objectAtIndex:2] isEqualToString:subStr] || [[SeparatedArray objectAtIndex:2] isEqualToString:subStr1]) {
            NSString *suffStr = nil;
            if ([imageUrlString hasSuffix:@".gif"]) {
                suffStr = [NSString stringWithFormat:@".gif"];
            }else if ([imageUrlString hasSuffix:@".png"]){
                suffStr = [NSString stringWithFormat:@".png"];
            }else if ([imageUrlString hasSuffix:@".jpg"]){
                suffStr = [NSString stringWithFormat:@".jpg"];
            }else if ([imageUrlString hasSuffix:@".jpeg"]){
                suffStr = [NSString stringWithFormat:@".jpeg"];
            }else if ([imageUrlString hasSuffix:@".JPG"]){
                suffStr = [NSString stringWithFormat:@".JPG"];
            }else if ([imageUrlString hasSuffix:@".GIF"]){
                suffStr = [NSString stringWithFormat:@".GIF"];
            }else if ([imageUrlString hasSuffix:@".PNG"]){
                suffStr = [NSString stringWithFormat:@".PNG"];
            }else if ([imageUrlString hasSuffix:@".JPEG"]){
                suffStr = [NSString stringWithFormat:@".JPEG"];
            }
            NSArray *components =  [imageUrlString componentsSeparatedByString:suffStr];
            NSString *thumbnailName = [NSString stringWithFormat:@"%@_%ldx%ld%@", [components objectAtIndex:0],(long)imageWidth,(long)imageHeight, suffStr];
            return thumbnailName;
        }else{
            return imageUrlString;
        }
    }
}

+ (NSString *)cutWhiteSpaceCharacter:(NSString *)sourceString //保留一个空白
{
    NSError *err = nil;
    NSString *destiString = nil ;
    NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:@"\\s+" options:NSRegularExpressionCaseInsensitive error:&err] ;
    if (sourceString) {
        destiString = [regx stringByReplacingMatchesInString:sourceString options:NSMatchingReportProgress range:NSMakeRange(0, [sourceString length]) withTemplate:@" "] ;
    }
    return destiString ;
}

+(NSString *)removeWhiteSpaceCharacter:(NSString *)sourceString
{
    return [sourceString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (NSMutableArray *) changeArray:(NSMutableArray *)dicArray orderWithKey:(NSString *)key ascending:(BOOL)yesOrNo{
    NSSortDescriptor *distanceDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:yesOrNo];
    NSArray *descriptors = [NSArray arrayWithObjects:distanceDescriptor,nil];
    [dicArray sortUsingDescriptors:descriptors];
    return dicArray;
}

+ (NSString *)sortNumArray:(NSMutableArray *)array
{
    //block比较方法，数组中可以是NSInteger，NSString（需要转换）
    NSComparator finderSort = ^(id string1,id string2){
        if ([string1 integerValue] > [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if ([string1 integerValue] < [string2 integerValue]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
            return (NSComparisonResult)NSOrderedSame;
    };
    //数组排序：
    NSArray *resultArray = [array sortedArrayUsingComparator:finderSort];
    return [resultArray objectAtIndex:[array count]-1];
}

+ (BOOL)isTellPhoneNumber:(NSString *)tellPhoneNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[02-5-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSString * PHS = @"^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$";//by - jp007 - 区号电话0755-23454334
    
    NSString * PHS1 = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$";//by - jp007 - 区号电话075523455435
    
    NSString * IPH = @"^\\+861(3|5|8)\\d{9}$";//+86 国际长途
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    NSPredicate *regextextphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    NSPredicate *regextextphs1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS1];
    
    NSPredicate *regextextiph = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IPH];
    
    if (([regextestmobile evaluateWithObject:tellPhoneNum] == YES)
        || ([regextestcm evaluateWithObject:tellPhoneNum] == YES)
        || ([regextestct evaluateWithObject:tellPhoneNum] == YES)
        || ([regextestcu evaluateWithObject:tellPhoneNum] == YES)
        || ([regextextphs evaluateWithObject:tellPhoneNum]) == YES
        || ([regextextiph evaluateWithObject:tellPhoneNum]) == YES
        || ([regextextphs1 evaluateWithObject:tellPhoneNum]) == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    //    mobileNum = [NSString stringWithFormat:@"%@",mobileNum]

    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    //EWJLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobileNum];
    
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[02-5-9])\\d{8}$";
//    
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    
//    NSString * IPH = @"^\\+861(3|5|8)\\d{9}$";//+86 国际长途
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    NSPredicate *regextextiph = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IPH];
//    
//    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
//        || ([regextestcm evaluateWithObject:mobileNum] == YES)
//        || ([regextestct evaluateWithObject:mobileNum] == YES)
//        || ([regextestcu evaluateWithObject:mobileNum] == YES)
//        || ([regextextiph evaluateWithObject:mobileNum]) == YES)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
}

+(BOOL) isEmailAddress:(NSString*)email {
    
    NSString *emailRegex = @"^\\w+((\\-\\w+)|(\\.\\w+))*@[A-Za-z0-9]+((\\.|\\-)[A-Za-z0-9]+)*.[A-Za-z0-9]+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

+(BOOL)isIncludeSpecialCharact: (NSString *)str {
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

+ (BOOL)isIncludeChineseInString:(NSString*)str {
    for (int i=0; i<str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}

+ (void)setTableViewSeperetLineHidden:(UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

+ (NSString *)getMobileNSString:(NSString *)mobileNum{
    NSString *mobile1 = [mobileNum substringToIndex:3];
    NSString *mobile2 = [mobileNum substringFromIndex:7];
    NSString *reMobile = [NSString stringWithFormat:@"%@****%@",mobile1,mobile2];
    return reMobile;
}

+ (void)setButtonBackGroundImg:(UIButton *)button{
    UIImage *normal = [UIImage imageNamed:@"blue_button_normal.png"];
    normal = [normal stretchableImageWithLeftCapWidth:5 topCapHeight:5  ];
    [button setBackgroundImage:normal forState:UIControlStateNormal];
    UIImage *selected = [UIImage imageNamed:@"blue_button_selected.png"];
    selected = [selected stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [button setBackgroundImage:selected forState:UIControlStateHighlighted];
}

+ (void)setSearchBarBackgroud:(UISearchBar *)searchBar
{
    float version = [[[ UIDevice currentDevice ] systemVersion ] floatValue ];
    
    if ([searchBar respondsToSelector : @selector (barTintColor)]) {
        float  iosversion7_1 = 7.1 ;
        if (version >= iosversion7_1){
            //iOS7.1
            [[[[searchBar.subviews objectAtIndex : 0 ] subviews ] objectAtIndex : 0 ] removeFromSuperview ];
            [searchBar setBackgroundColor :[ UIColor clearColor ]];
        }else{
            //iOS7.0
            [searchBar setBarTintColor :[ UIColor clearColor ]];
            [searchBar setBackgroundColor :[ UIColor clearColor ]];
        }
    }else {
        
        //iOS7.0 以下
        
        [[searchBar.subviews objectAtIndex : 0 ] removeFromSuperview ];
        
        [searchBar setBackgroundColor :[ UIColor clearColor ]];
        
    }
    
}

+ (void)setCaptchButton:(UIButton *)button{
    //    [button setBackgroundImage:[UIImage imageNamed:@"send_code_edit.png"] forState:UIControlStateNormal];
    //    button.backgroundColor = RGBColor(200, 200, 200);
//    [button setTitleColor:RGBColor(180, 180, 180) forState:UIControlStateNormal];
    button.enabled = NO;
    
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.enabled = YES;
//                [button setTitle:@"重发验证码" forState:UIControlStateNormal];
                //                [button setBackgroundImage:[UIImage imageNamed:@"mine_oriange"] forState:UIControlStateNormal];
            });
        }else{
            NSString *strTime = [NSString stringWithFormat:@"(%dS)",timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [button setTitle:[NSString stringWithFormat:@"%@重新获取",strTime] forState:UIControlStateDisabled];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
//是否是纯数字

+ (BOOL)isNumText:(NSString *)str{
    
    //判断是不是纯数字
    
    [NSCharacterSet decimalDigitCharacterSet];
    
    if ([[str stringByTrimmingCharactersInSet: [NSCharacterSet decimalDigitCharacterSet]] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]].length >0) {
        
        return NO;
        
    }else{
        
        return YES;
        
    }
    
    NSString * regex        = @"(/^[0-9]*$/)";
    
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch            = [pred evaluateWithObject:str];
    
    if (isMatch) {
        
        return YES;
        
    }else{
        
        return NO;
        
    }
    
    
}

+ (NSString *)getTimeStyleWith:(NSString *)time subStringToIndex:(int)index{
    NSString *timeString;
    if (time && [time isKindOfClass:[NSString class]]) {
        //获得当前应用程序默认的时区
        NSTimeZone *zone = [NSTimeZone defaultTimeZone];
        //以秒为单位返回当前应用程序与世界标准时间（格林威尼时间）的时差
        NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
        //时间戳转化成时间
        NSDate * dateBegin = [[NSDate dateWithTimeIntervalSince1970:[time doubleValue]] dateByAddingTimeInterval:interval];
        //EWJLog(@"%@",dateBegin);
        if (index != 0) {
            timeString = [[NSString stringWithFormat:@"%@",dateBegin] substringToIndex:index];// if index == 10 只取到日
        }else{//为0 不需要 截取
            timeString = [NSString stringWithFormat:@"%@",dateBegin];
        }
        
        
    }
    return timeString;
}

+ (NSString *)getCurrentSystemTime{
    // 获取系统当前时间
    NSDate * date = [NSDate date];
    
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    //目标日期与本地时区的偏移量 2014-03-14 10:29:33 +0000
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* currentDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    //    //EWJLog(@"时间：%@",currentDate);
    
    return [NSString stringWithFormat:@"%@",currentDate];
}

//当前时间到1970的时间戳
+ (NSString *)getCurrentTimeIntervalSince1970
{
    NSDate *data = [[NSDate alloc] init];
    double longtime = [data timeIntervalSince1970];
    return [NSString stringWithFormat:@"%0.0f",longtime];
}


+ (CGSize)getContentLableSize:(NSString *)contentString withLabelWith:(CGFloat)labelWith withFont:(UIFont *)font{
    CGSize size;
    size = [contentString  sizeWithFont:font
                      constrainedToSize:CGSizeMake(labelWith, 9999)
                          lineBreakMode:NSLineBreakByWordWrapping];
    return size;
}

+ (NSString *)getURLOrderStringWithDictionary:(NSMutableDictionary *)prams{
    //加密 参数排序
    NSArray* allkeys = [prams allKeys];
    allkeys = [allkeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    //
    NSMutableString *url = [NSMutableString string];
    for (int i=0; i<allkeys.count; i++) {
        NSString *key = [allkeys objectAtIndex:i];
        NSString *value = [prams objectForKey:key];
        
        [url appendFormat:@"%@=%@",key,value];
        
        if (i<allkeys.count-1) {
            [url appendString:@"&"];
        }
    }
    return url;
}

+ (NSMutableArray *)exchangeArrayItem:(NSMutableArray *)array{
    for (int i = 0; i < array.count/2; i++) {
        [array exchangeObjectAtIndex:i withObjectAtIndex:array.count -1 - i];
    }
    return array;
}

+ (UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize{
    
    UIGraphicsBeginImageContext(itemSize);
    
    CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    
    [img drawInRect:imageRect];
    
    UIImage *scaleImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaleImg;
    
}

+ (UIImage *)stretchableImage:(NSString *)imgName{
    UIImage *img = [UIImage imageNamed:imgName];
    img = [img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    return img;
}

+ (void)setViewLayerBordWithView:(UIView *)view{
//    view.layer.borderWidth = 1;
//    view.layer.borderColor = RGBColor(255, 255, 255).CGColor;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
}

+ (BOOL)checkDevice:(NSString*)name
{
    NSString* deviceType = [UIDevice currentDevice].model;
    NSRange range = [deviceType rangeOfString:name];
    return range.location != NSNotFound;
}

/**
 * 返回值为label的属性attributedText
 */
+ (NSMutableAttributedString *)setNbLabelTextProperty:(NSString *)text
                                               string:(NSString *)string
                                            textColor:(UIColor *)color
                                             textFont:(UIFont *)font
{
    NSRange range;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    
    if (string != nil && ![string isEqualToString:@""]) {
        range = [text rangeOfString:string];
    }else{
        range = NSMakeRange(0, 0);
    }

    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    return str;
}


+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (NSNumber *)numberConvertInString:(NSString *)string
{
    return [NSNumber numberWithInteger:[string integerValue]];
}

+ (UIView *)viewForColor:(UIColor *)color
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = color;
    return view;
}

#pragma mark-千分号化数字
+ (NSString *)separateNumbersWithSemicolon:(NSNumber *)number isKeepDot:(BOOL)isKeepDot;
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    if (isKeepDot) {
        
        [numberFormatter setPositiveFormat:@"###,##0.00;"];
    }
    else
    {
        [numberFormatter setPositiveFormat:@"###,##0;"];
    }
    NSString *formattedNumberString = [numberFormatter stringFromNumber:number];
    return formattedNumberString;
}

#pragma mark-设置时间


//将字符串格式化成日期对象
+ (double)toTimeStampString:(NSString *)dateString
{
    NSString *formate = @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSDate *date = [dateFormatter dateFromString:dateString];
    double time = [date timeIntervalSince1970];
    return time;
}

+ (BOOL)imageSizeBeyondScope:(UIImage *)image
{
    return ((image.size.width*image.size.height)/(1024*1024) > 2);
}



#pragma mark-图片压缩
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the contex
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

+(BOOL)isContainsEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         
         // surrogate pair
         
         if (0xd800 <= hs && hs <= 0xdbff) {
             
             if (substring.length > 1) {
                 
                 const unichar ls = [substring characterAtIndex:1];
                 
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     
                     isEomji = YES;
                     
                 }
                 
             }
             
         } else if (substring.length > 1) {
             
             const unichar ls = [substring characterAtIndex:1];
             
             if (ls == 0x20e3) {
                 
                 isEomji = YES;
                 
             }
             
         } else {
             
             // non surrogate
             
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 
                 isEomji = YES;
                 
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 
                 isEomji = YES;
                 
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 
                 isEomji = YES;
                 
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 
                 isEomji = YES;
                 
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 
                 isEomji = YES;
                 
             }
             
         }
         
     }];
    
    return isEomji;
}

+(NSString *)returnActualFormatNumber:(float)number
{
    //最多保留两位小数
    NSArray *numArray =[[NSString stringWithFormat:@"%.2f",number] componentsSeparatedByString:@"."];

    NSString *firstNum =[numArray firstObject];
    NSString *secondNum =[numArray lastObject];
    
    if ([secondNum floatValue] == 0) {
        
        return firstNum;
    }
    else
    {
        if ([[secondNum substringFromIndex:1] floatValue] != 0) {
            
            return [NSString stringWithFormat:@"%.2f",number];
        }
        else{
        
            return [NSString stringWithFormat:@"%.1f",number];
        }
    }
    return nil;
}
+(NSString *)getJSESSIONIDValue:(NSString *)isid1
{
    
    NSArray *a= [isid1 componentsSeparatedByString:@";"];
    NSString *jid;
    NSString *oJid;
    for (NSString *s in a) {
        if ([s hasPrefix:@"JSESSIONID"]) {
            jid =   [[s componentsSeparatedByString:@"="] lastObject];
            oJid=jid;
        }
    }
    return oJid;

}
+(NSString *)getISISValue:(NSString *)isid1
{
    
    NSArray *a= [isid1 componentsSeparatedByString:@";"];
    NSString *isid;
    NSString *oIsid;
    for (NSString *s in a) {
        if ([s hasPrefix:@"isid"]) {
            isid =   [[s componentsSeparatedByString:@"="] lastObject];
            oIsid=isid;
        }else if ([s rangeOfString:@"isid"].location !=NSNotFound){
            NSArray *temp = [s componentsSeparatedByString:@","];
            for (NSString * t in temp) {
            
                NSString * newT = [t stringByReplacingOccurrencesOfString:@" " withString:@""];
                if ([newT hasPrefix:@"isid"]) {
                    isid =   [[newT componentsSeparatedByString:@"="] lastObject];
                    oIsid=isid;
                }
            }
        }
    }

    return oIsid;
}

@end

