/**
 Cosc345 Asn 2, AssignmentObjc.h
 Purpose: part of code that solve the IOS sandbox environment problem.
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

#import <Foundation/Foundation.h>
#import "sqlite_operations.hpp"

@interface AssignmentObjc : NSObject

@property (readonly) NSNumber *pkid;
@property (readonly) NSString *lecture;
@property (readonly) NSString *time;
@property (readonly) NSString *position;

- (instancetype)initWithPkid:(NSNumber *)pkid lecture:(NSString *)lecture time:(NSString *)time position:(NSString *)position;

- (instancetype)initWithAssignmentCpp:(AssignmentCpp)assCpp;

+ (instancetype)assignmentObjcWithPkid:(NSNumber *)pkid lecture:(NSString *)lecture time:(NSString *)time position:(NSString *)position;

+ (instancetype)assignmentObjcWithAssignmentCpp:(AssignmentCpp)assCpp;

- (AssignmentCpp)toAssignmentCpp;

@end

AssignmentCpp assignmentCppFromAssignmentObjc(AssignmentObjc *assobjc);
