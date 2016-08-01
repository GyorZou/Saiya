
#define VALUEOF(attributes,KEY) [attributes isKindOfClass:[NSDictionary class]]?[attributes[KEY] NSNullProcess]:nil


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
@interface XWHelper : NSObject

+(NSString*)documentPathOfFilename:(NSString*)name atFolder:(NSString*)folder;
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                              image:(UIImage *)image;

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  textColor:(UIColor *)color
              textAlignment:(NSTextAlignment)alignment
                       font:(UIFont *)font;

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                               text:(NSString *)text
                    placeholderText:(NSString *)placeholdertext
                          textColor:(UIColor *)color
                      textAlignment:(NSTextAlignment)alignment
               textContentAlignment:(UIControlContentHorizontalAlignment)contentalignment
                               font:(UIFont *)font;

+ (UIButton *)buttonWithFrame:(CGRect)frame
                         file:(NSString *)fileName
                        title:(NSString *)title
                          tag:(NSInteger)buttonTag
                       action:(SEL)action;

/**
 *  @author HLM, 14-12-09 15:12:28
 *
 *  创建button setBackgroundImage
 *
 *  @param frame       位置大小
 *  @param nfileName   正常的图片名称
 *  @param sfileName   选中和高亮的图片名称
 *  @param ntitle      正常的标题
 *  @param stitle      选中和高亮的标题
 *  @param ntitleColor 正常的标题颜色
 *  @param stitleColor 选中和高亮的标题颜色
 *  @param font        文本字体
 *  @param alignment   对齐方式
 *  @param tag         tag
 *  @param delegate    代理
 *  @param action      响应
 *
 *  @return 设置好的button
 */
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
                       action:(SEL)action;

/**
 *  @author HLM, 14-12-09 15:12:32
 *
 *  创建button setImage
 *
 *  @param frame                       位置大小
 *  @param nfileName                   正常的图片名称
 *  @param sfileName                   选中和高亮的图片名称
 *  @param ntitle                      正常的标题
 *  @param stitle                      选中和高亮的标题
 *  @param ntitleColor                 正常的标题颜色
 *  @param stitleColor                 选中和高亮的标题颜色
 *  @param contentHorizontaolAlignment 内容水平的对齐方式
 *  @param font                        文本字体
 *  @param alignment                   文本对齐方式
 *  @param tag                         tag
 *  @param delegate                    代理
 *  @param action                      响应
 *
 *  @return 设置好的button
 */
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
                                       action:(SEL)action;

//扩展设置setImage的Button （而不是setBackgroundImage)
+ (UIButton *)buttonsetIamgeWithFrame:(CGRect)frame
                                nfile:(NSString *)nfileName
                                sfile:(NSString *)sfileName
                                  tag:(NSInteger)buttonTag
                               action:(SEL)action;

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        nfile:(NSString *)nfileName
                        sfile:(NSString *)sfileName
                          tag:(NSInteger)buttonTag
                       action:(SEL)action;

//chj 添加不能点击状态
+ (UIButton *)buttonsetIamgeWithFrame:(CGRect)frame
                             stateImg:(NSString *)stateImg
                         highlightImg:(NSString *)highlightImg
                           disableImg:(NSString *)disableImg
                                  tag:(NSInteger)tag
                               target:(SEL)target;


//andy add 2014-9-20
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

//andy add  2014-9-20
+ (UIButton *)buttonsetIamgeWithFrame:(CGRect)frame
                          normalBgImg:(NSString *)normalbBgImg
                          selectBgImg:(NSString *)selectBgImg
                                title:(NSString *)title
                          nTitleColor:(UIColor *)ntitleColor
                          sTitleColor:(UIColor *)stitleColor
                                 font:(UIFont *)font
                                  tag:(NSInteger)tag
                               target:(SEL)target;

//andy add  2014-9-24 带小三角的按钮
+(UIButton *)initBtnWithFrame:(CGRect)frame
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
                         font:(UIFont *)font
                          tag:(NSInteger)tag
                       action:(SEL)action;


+(BOOL)isIOS7;

+ (NSString *)thumbnailFromImageString:(NSString *)imageUrlString imageWithWidth:(NSInteger)imageWidth  imageWithHeight:(NSInteger)imageHeight;

+ (NSString *)cutWhiteSpaceCharacter:(NSString *)sourceString;

+ (NSString *)removeWhiteSpaceCharacter:(NSString *)sourceString;

+ (NSMutableArray *) changeArray:(NSMutableArray *)dicArray orderWithKey:(NSString *)key ascending:(BOOL)yesOrNo;

+ (NSString *)sortNumArray:(NSMutableArray *)array; //获取数组中最大值

+ (BOOL)isTellPhoneNumber:(NSString *)tellPhoneNum;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (BOOL) isEmailAddress:(NSString*)email;
+ (BOOL) isIncludeSpecialCharact:(NSString *)str;
+ (BOOL) isIncludeChineseInString:(NSString*)str;

//隐藏UITableView多余的线
+ (void) setTableViewSeperetLineHidden:(UITableView *)tableView;

+ (NSString *) getMobileNSString:(NSString *)mobileNum;

+ (void) setButtonBackGroundImg:(UIButton *)button;

+ (void)setSearchBarBackgroud:(UISearchBar *)searchBar;

+ (void)setCaptchButton:(UIButton *)button;
//是否是纯数字

+ (BOOL)isNumText:(NSString *)str;

+ (NSString *)getTimeStyleWith:(NSString *)time subStringToIndex:(int)index;

+ (NSString *)getCurrentSystemTime;

//当前时间到1970的时间戳
+ (NSString *)getCurrentTimeIntervalSince1970;

+ (CGSize)getContentLableSize:(NSString *)contentString withLabelWith:(CGFloat)labelWith withFont:(UIFont *)font;

+ (NSString *)getURLOrderStringWithDictionary:(NSMutableDictionary *)prams;

+ (NSMutableArray *)exchangeArrayItem:(NSMutableArray *)array;

+ (UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize;

+ (UIImage *)stretchableImage:(NSString *)imgName;

+ (void)setViewLayerBordWithView:(UIView *)view;

+ (BOOL)checkDevice:(NSString*)name;

+ (NSMutableAttributedString *)setNbLabelTextProperty:(NSString *)text
                                               string:(NSString *)string
                                            textColor:(UIColor *)color
                                             textFont:(UIFont *)font;


//add HLM 传入整个字符串颜色 字体   需要特别处理的字符数组 颜色数组 字体数组 一一对应
/**
 *  @author HLM, 14-12-09 14:12:48
 *
 *  获取NSMutableAttributedString
 *
 *  @param text           整个字符串
 *  @param textColor      文本颜色
 *  @param lineSpace      行间隔
 *  @param textFont       文本字体
 *  @param extraStringArr 需要额外设置的字符串的数组
 *  @param extraColorArr  需要额外设置的颜色数组
 *  @param extraFont      需要额外设置的的字体数组
 *
 *  @return 返回设置好的NSMutableAttributedString
 */

/**
 *  @author HLM, 14-12-09 14:12:47
 *
 *  通过颜色穿件图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage*)createImageWithColor: (UIColor*) color;
/**
 *  @author HLM, 14-12-09 14:12:27
 *
 *  创建背景颜色的uiview
 *
 *  @param color 颜色
 *
 *  @return uiview
 */
+ (UIView *)viewForColor:(UIColor *)color;
/**
 *  @author HLM, 14-12-09 14:12:45
 *
 *  设置数字格式
 *
 *  @param number    数字
 *  @param isKeepDot 是否保持小数点
 *
 *  @return 被隔开的字符串
 */
+ (NSString *)separateNumbersWithSemicolon:(NSNumber *)number isKeepDot:(BOOL)isKeepDot;

/**
 *  @author HLM, 14-12-09 14:12:54
 *
 *  传参数需要intger类型 字符串
 *
 *  @param string 数字字符串
 *
 *  @return 数字
 */
+ (NSNumber *)numberConvertInString:(NSString *)string;

/**
 *  @author HLM, 14-12-09 14:12:24
 *
 *  通过时间字符串获取具体格式
 *
 *  @param dateString 日期字符串
 *  @param completion 传入的block
 */


//将字符串格式化成日期对象 chj
+ (double)toTimeStampString:(NSString *)dateString;



/**
 *  计算图片超过2M
 */
+ (BOOL)imageSizeBeyondScope:(UIImage *)image;

//按比例压缩图片
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

/**/
+(BOOL)isContainsEmoji:(NSString *)string;

//返回实际格式的数字
+(NSString *)returnActualFormatNumber:(float)number;



+(NSString*)getISISValue:(NSString*)isid;
+(NSString *)getJSESSIONIDValue:(NSString *)isid1;

@end

