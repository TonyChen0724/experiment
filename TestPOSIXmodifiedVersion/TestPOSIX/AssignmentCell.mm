/**
 Cosc345 Asn 2, AssignmentCell.mm
 Purpose: part of code that solve the IOS sandbox environment problem.
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

#import "AssignmentCell.h"

@interface AssignmentCell ()

@property (strong, nonatomic) IBOutlet UITextView *lectureTextView;
@property (strong, nonatomic) IBOutlet UITextView *timeTextView;

@end

@implementation AssignmentCell

- (void) setAss:(AssignmentObjc *)ass {
    _ass = ass;
    self.lectureTextView.text = [@"Assignment: " stringByAppendingString:ass.lecture];
    self.timeTextView.text = [@"Time: " stringByAppendingString:ass.time];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
