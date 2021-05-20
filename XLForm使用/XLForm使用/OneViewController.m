//
//  OneViewController.m
//  XLForm使用
//
//  Created by 杨帆 on 2018/4/24.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "OneViewController.h"
#import "XLForm.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的表单";
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (void)initializeForm {
    
    // 设置是否显示Cell之间分界线
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置Section的高度
    self.tableView.sectionHeaderHeight = 30;
    
    XLFormDescriptor * form;//form，一个表单只有一个
    XLFormSectionDescriptor * section;//section，一个表单可能有多个
    XLFormRowDescriptor * row; //row，每个section可能有多个row
    
    // Form
    form = [XLFormDescriptor formDescriptor];

    
    // First section
    section = [XLFormSectionDescriptor formSection];
    section.title = @"用户";
    [form addFormSection:section];
    // 普通文本
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"username" rowType:XLFormRowDescriptorTypeText];
    // 设置placeholder
    [row.cellConfig setObject:@"用户名" forKey:@"textField.placeholder"];
    // 设置文本颜色
    [row.cellConfig setObject:[UIColor redColor] forKey:@"textField.textColor"];
    [section addFormRow:row];
    // 密码
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"password" rowType:XLFormRowDescriptorTypePassword];
    // 设置placeholder的颜色
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"密码" attributes:
                                      @{NSForegroundColorAttributeName:[UIColor greenColor],
                                        }];
    [row.cellConfig setObject:attrString forKey:@"textField.attributedPlaceholder"];
    [section addFormRow:row];
    
    
    
    // Second Section
    section = [XLFormSectionDescriptor formSection];
    section.title = @"日期";
    [form addFormSection:section];
    // 日期选择器
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"birthday" rowType:XLFormRowDescriptorTypeDate title:@"出生日期"];
    row.value = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    [section addFormRow:row];
    
    
    
     // Third Section
    section = [XLFormSectionDescriptor formSection];
    section.title = @"头像";
    [form addFormSection:section];
    // 图片选择
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"userpic" rowType:XLFormRowDescriptorTypeImage];
    [section addFormRow:row];
    
    
    
    // Fourth Section
    section = [XLFormSectionDescriptor formSection];
    section.title = @"选择器";
    [form addFormSection:section];
    // 选择器
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"sex" rowType:XLFormRowDescriptorTypeSelectorPush];
    row.noValueDisplayText = @"暂无";
    row.selectorTitle = @"性别选择";
    row.selectorOptions = @[@"男",@"女",@"其他"];
    row.title = @"性别";
    [row.cellConfigForSelector setObject:[UIColor redColor] forKey:@"textLabel.textColor"];
    [row.cellConfigForSelector setObject:[UIColor greenColor] forKey:@"detailTextLabel.textColor"];
    [section addFormRow:row];
    
    
    
    // Fifth Section
    section = [XLFormSectionDescriptor formSection];
    section.title = @"加固";
    [form addFormSection:section];
    // 开关
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"enforce" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"加固"];
    [section addFormRow:row];
    
    
    // Sixth Section
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    // 按钮
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"conform" rowType:XLFormRowDescriptorTypeButton];
    row.title = @"确定";
    [section addFormRow:row];
    

    self.form = form;
}

-(void)didSelectFormRow:(XLFormRowDescriptor *)formRow{

    // 判断是不是点击了确定按钮
    if([formRow.tag isEqualToString:@"conform"] && formRow.rowType == XLFormRowDescriptorTypeButton){

        //获取表单所有到的值
        NSDictionary *values =  [self formValues];

        NSLog(@"%@", values);

    }
    
    [super didSelectFormRow:formRow];

}

//重写改该方法 上面的方法就不会调用了
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    NSLog(@"%s", __func__);
//
//}


@end
