//
//  ViewController.m
//  card
//
//  Created by 施峰磊 on 2021/5/8.
//

#import "ViewController.h"
#import "CardTableView.h"
#import "TextTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,TableCardGroupDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self configerView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.list removeAllObjects];
        for (int i = 0; i<5; i++) {
            [self.list addObject:@[@"1",@"2",@"3",@"4"]];
        }
        [self.tableView reloadData];
    });
}

- (void)initData{
    self.list = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<5; i++) {
        [self.list addObject:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
    }
}

- (void)configerView{
    self.tableView.cardGroupDataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextTableViewCell"];
    [self.tableView registerClass:[CardFrameView class] forGroupCardViewReuseIdentifier:@"CardFrameView"];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource,TableCardGroupDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.list.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = [self.list objectAtIndex:section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [self.list objectAtIndex:indexPath.section];
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextTableViewCell" forIndexPath:indexPath];
    cell.showText.text = [array objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.left = 10;
    cell.right = 10;
    cell.lineLeft = 25;
    cell.lineRight = 20;
    cell.hiddenLine = array.count == (indexPath.row+1);
    return  cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

/// TODO:获取CardView
/// @param tableView tableView
/// @param section 组索引
- (UIView *)tableView:(UITableView *)tableView cardViewForSection:(NSInteger)section{
    CardFrameView *view = (CardFrameView *)[tableView dequeueReusableGroupCardViewWithIdentifier:@"CardFrameView" section:section];
    view.layer.cornerRadius = 4;
    view.layer.shadowOpacity = 0.5;
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    view.layer.shadowRadius = 5.0;
    view.layer.shadowOffset = CGSizeMake(0, 2);
    view.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    view.subBorderWidth = 1.0;
    view.subBorderColor = [UIColor colorWithWhite:0.90 alpha:1.0];
    view.subBackgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
    return  view;
}

/// TODO:卡片相距尺寸
/// @param tableView 表单
/// @param section 组索引
- (UIEdgeInsets)cardViewMarginForTableView:(UITableView *)tableView section:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
