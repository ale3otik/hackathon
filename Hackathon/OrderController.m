//
//  OrderController.m
//  Hackathon
//
//  Created by Danil Tulin on 11/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "OrderController.h"

@interface OrderController ()

@property (nonatomic) Order *order;
@property (nonatomic, readwrite) NSInteger index;

@property (nonatomic) UILabel *productName;
@property (nonatomic) UILabel *price;
@property (nonatomic) UILabel *date;

@property (nonatomic) UIButton *doneButton;

@end

@implementation OrderController

+ (instancetype)orderControllerWithOrder:(Order *)order
                                andIndex:(NSInteger)index {
    OrderController *controller = [[OrderController alloc] init];
    controller.order = order;
    controller.index = index;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.productName];
    [self.view addSubview:self.price];
    [self.view addSubview:self.date];
    [self.view addSubview:self.doneButton];
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    float offset = 30;
    [self.productName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(offset);
        make.right.equalTo(self.view).offset(-offset);
        make.bottom.equalTo(self.price.mas_top);
    }];
    
    [self.price mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_centerY).multipliedBy(.5f);
        make.bottom.equalTo(self.doneButton.mas_top);
    }];
    
    [self.date mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.price.mas_left);
        make.top.equalTo(self.productName.mas_bottom);
        make.bottom.equalTo(self.doneButton.mas_top);
    }];
    
    [self.doneButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-offset);
     	make.left.equalTo(self.view).offset(offset);
        make.top.equalTo(self.view.mas_centerY);
        make.bottom.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

#pragma mark - Labels

- (UILabel *)productName {
    if (_productName)
        return _productName;
    _productName = [[UILabel alloc] init];
    _productName.text = self.order.product.name;
    _productName.font = [UIFont systemFontOfSize:200];
    _productName.textAlignment = NSTextAlignmentCenter;
    _productName.adjustsFontSizeToFitWidth = YES;
    return _productName;
}

- (UILabel *)price {
    if (_price)
        return _price;
    NSString *text = [[NSNumber numberWithInteger:self.order.product.price] stringValue];
    _price = [self createSeconLineLabelWithText:[text stringByAppendingString:@" P"]];
    return _price;
}

- (UILabel *)date {
    if (_date)
        return _date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *stringFromDate = [formatter stringFromDate:self.order.createdAt];
    _date = [self createSeconLineLabelWithText:stringFromDate];
    return _date;
}

- (UILabel *)createSeconLineLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:70];
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

#pragma mark - Done Button

- (UIButton *)doneButton {
    if (_doneButton)
        return _doneButton;
    _doneButton = [[UIButton alloc] init];
    NSDictionary *attrs = @{NSFontAttributeName: [UIFont systemFontOfSize:200],
                            NSForegroundColorAttributeName: [UIColor whiteColor]};
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"DONE"
                                                                 attributes:attrs];
    [_doneButton setAttributedTitle:attrString
                           forState:UIControlStateNormal];
    _doneButton.backgroundColor = [UIColor colorWithDisplayP3Red:0.23 green: 0.66
                                                            blue: 0.23 alpha: 1.0];
    [_doneButton addTarget:self
                    action:@selector(didTapDoneButton)
          forControlEvents:UIControlEventTouchUpInside];
    return _doneButton;
}

- (void)didTapDoneButton {
    [self.delegate orderControllerDidTapDoneButton:self];
}

@end
