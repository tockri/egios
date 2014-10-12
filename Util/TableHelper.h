//
//  TableHelper.h
//  Pages
//


#import <UIKit/UIKit.h>

@interface TableHelper : NSObject<UITableViewDelegate, UITableViewDataSource> 
// データ配列
@property(strong)NSArray* data;
// セルのReuseIdentifier
@property(strong)NSString* identifier;
// 行高さ
@property(assign)CGFloat rowHeight;
// 選択イベント
@property(copy)void (^onSelected)(NSInteger row);
// 選択解除イベント
@property(copy)void (^onDeselected)(NSInteger row);
// アクセサリボタンのイベント
@property(copy)void (^onAccessoryTapped)(NSInteger row);
// セルの内容表示
@property(copy)void (^showCell)(NSInteger row, UITableViewCell* cell);
// 行数
@property(copy)NSUInteger (^rowCount)();
// セルオブジェクトの生成
@property(copy)UITableViewCell* (^createCell)();
// 移動イベント
@property(copy)void (^onMoved)(NSInteger from, NSInteger to);
// 削除イベント
@property(copy)void (^onDeleted)(NSInteger row);
// セルスタイル
@property(assign)UITableViewCellStyle cellStyle;
// 移動できるかどうか
@property(assign)BOOL canArrange;
// 削除できるかどうか
@property(assign)BOOL canDelete;
// 編集時に複数選択になるかどうか
@property(assign)BOOL editMultiSelect;
@end
