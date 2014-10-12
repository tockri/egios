#import "EG.h"
#import "EG_ui.h"

// nibからクラスを生成する
id eNewFromNib(Class cls, BOOL distinctDevice) {
    NSString* nibName = NSStringFromClass(cls);
    if (distinctDevice) {
        if ([EG isForIpad]) {
            nibName = [nibName eAdd:@"_iPad"];
        } else {
            nibName = [nibName eAdd:@"_iPhone"];
        }
    }
    
    NSArray* nib = [[NSBundle mainBundle] 
                    loadNibNamed:nibName
                    owner:nil 
                    options:nil];
    for (id o in nib) {
        if ([o isKindOfClass:cls]) {
            return o;
        }
    }
    return nil;

}