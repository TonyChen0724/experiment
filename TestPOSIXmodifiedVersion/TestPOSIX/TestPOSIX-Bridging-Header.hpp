/**
 Cosc345 Asn 2, TestPOSIX-Bridging-Header.hpp
 Purpose: part of code that solve the IOS sandbox environment problem.
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

#ifndef TestPOSIX_Bridging_Header_h
#define TestPOSIX_Bridging_Header_h

#import "AssignmentObjc.h"
#import "vector"

AssignmentCpp assignmentCppFromAssignmentObjc(AssignmentObjc *assobjc);

@interface Bridging : NSObject

+ (NSArray *)convertToAssignmentObjcArrayWithAssignmentCppVector:(std::vector<AssignmentCpp>)vasscpp;

+ (NSArray *)queryForAllAssignments;

+ (NSArray *)queryForAllNewAssignments;

+ (NSArray *)queryForAllNewNewAssignments;

+ (void)insertNewAssignmentCpp:(AssignmentCpp)asscpp;

+ (void)insertNewAssignmentObjc:(AssignmentObjc *)assobjc;

+ (void)insertNewNewAssignmentObjc:(AssignmentObjc *)assobjc;

+ (BOOL)deleteAssignmentById:(NSNumber *)pkid;

+ (NSArray *)convertToCalendarObjcArrayWithCalendarCppVector:(std::vector<CalendarCpp>)vcalcpp;

+ (NSArray *)queryForAllCalendars;


+ (BOOL)deleteCalendarById:(NSNumber *)pkid;

@end

#endif /* TestPOSIX_Bridging_Header_h */
