//
//  TableHelper.m
//  Pages
//

#import "TableHelper.h"
#import "EG.h"


@implementation TableHelper
@synthesize onSelected, onAccessoryTapped, showCell, rowCount, cellStyle, data;
@synthesize rowHeight, createCell, onMoved, onDeleted, canArrange, identifier;
@synthesize canDelete, onDeselected, editMultiSelect;

#pragma mark - UITableViewDataSource
// セクション数：1
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (rowCount) {
        return rowCount();
    } else if (data) {
        return data.count;
    } else {
        return 0;
    }
}

// セルの表現
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        if (createCell) {
            cell = createCell();
        } else {
            if (!cellStyle) {
                cellStyle = UITableViewCellStyleDefault;
            }
            cell = [[UITableViewCell alloc]initWithStyle:cellStyle reuseIdentifier:identifier];
        }
    }
    if (showCell) {
        showCell(indexPath.row, cell);
    } else if (data) {
        id record = [data eAt:indexPath.row];
        if ([record isKindOfClass:[NSString class]]) {
            cell.textLabel.text = record;
        } else {
            cell.textLabel.text = [record performSelector:@selector(description)];
        }
    }
    return cell;
}
// セル移動イベント
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (onMoved) {
        onMoved(sourceIndexPath.row, destinationIndexPath.row);
    }
}
// セル削除イベント
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (onDeleted) {
        onDeleted(indexPath.row);
    }
}


#pragma mark - UITableViewDelegate

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return editMultiSelect ? 3 : UITableViewCellEditingStyleDelete;
}

// セル選択イベント
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (onSelected) {
        onSelected(indexPath.row);
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (onDeselected) {
        onDeselected(indexPath.row);
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (onAccessoryTapped) {
        onAccessoryTapped(indexPath.row);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (rowHeight > 0) {
        return rowHeight;
    } else {
        return tableView.rowHeight;
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return editMultiSelect || canDelete;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return canArrange;
}


-(id)init {
    self = [super init];
    identifier = @"Cell";
    return self;
}
@end
