two sqlite database: Timetable Database & Assignment Database

Timetable Database:
1. data addition.
a.we use Timetable interface to add event into Timetable Database.(if the data is added this way, the property "isMeetng(BOOL)" is always false);
b.we use meeting interface to add event into Timetable Database.(if the data is added this way, the property "isMeeting(BOOL)" is always true);

2.data extraction.
a. timetable interface extract all data. (not all column).

b. meeting interface extract data whose property "isMeeting(BOOL)" is true.


Assignment Database:
just interact with Assignment interface. independent.



strategy: we first finish pure functional app and then we modify the display.

current step: I have already solved the database apply problem and now I can add and extract data by selecting certain feature.

next step: make another database which is Assignment Database.
because Assignment Interface is much easier to implement(list) so I will do assignment interface first. 
