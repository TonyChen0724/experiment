/**
 Cosc345 Asn 2, sqlite_operations.cpp
 Purpose: provide a database to interact with the UI.
 
 @author Xinru Chen, Luke Falvey, Molly Patterson
 @version 1.0 5/29/17
 */

#include "sqlite_operations.hpp"
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <functional>
#include <sstream>

using namespace std;


sqlite3 *db; // create a pointer point to sqlite3 object?
char *zErrMsg = 0;
int rc;
const char *sql;
const char *debugsql;
const char* data = "Callback function called";

/* this callback is being called in sqlite3_exec() function */
int callback(void *data, int argc, char **argv, char **azColName){
    int i;
    fprintf(stderr, "%s: ", (const char*)data); // send "Callback function called" to standard error
    for(i=0; i<argc; i++){
        printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
    }
    printf("\n");
    return 0;
}

/*
 update a name of record based on the times.
 */
void updateName(char* timer, char* name) {
    string updateusers = "UPDATE users SET lecture = '";
    string where = " WHERE time = '";
    string topcomma = "'";
    string comma = ",";
    string bracelet = "); ";
    string simicolon = ";";
    
    string sqlinfo = updateusers + name + topcomma + where + timer + topcomma + simicolon;
    sql = &sqlinfo[0u];
    cout << sql;
    rc = sqlite3_exec(db, sql, callback, 0, &zErrMsg);
    if( rc != SQLITE_OK ){
        fprintf(stderr, "SQL error: %s\n", zErrMsg);
        sqlite3_free(zErrMsg);
    }else{
        fprintf(stdout, "Records updated successfully\n");
    }
    
    
}

/*
 update a name of record based on the times.
 */
void updatePosition(char* timer, char* positioner) {
    string updateusers = "UPDATE users SET position = '";
    string where = " WHERE time = '";
    string topcomma = "'";
    string comma = ",";
    string bracelet = "); ";
    string simicolon = ";";
    
    string sqlinfo = updateusers + positioner + topcomma + where + timer + topcomma + simicolon;
    sql = &sqlinfo[0u];
    cout << sql;
    rc = sqlite3_exec(db, sql, callback, 0, &zErrMsg);
    if( rc != SQLITE_OK ){
        fprintf(stderr, "SQL error: %s\n", zErrMsg);
        sqlite3_free(zErrMsg);
    }else{
        fprintf(stdout, "Records updated successfully\n");
    }
    
    
}


/*
 insert a record to the database.
 */
void insertAssignment(const char* lectures, const char* times, const char* positions) {
//    string insertInto = "INSERT INTO users (lecture, time, position) VALUES ('";
//    string topcomma = "'";
//    string comma = ",";
//    string bracelet = "); ";
//    
//    string sqlinfo = insertInto + lectures + topcomma + comma + topcomma + times + topcomma + comma + topcomma + positions + topcomma + bracelet;
//    sql = &sqlinfo[0u];
//    rc = sqlite3_exec(db, sql, callback, 0, &zErrMsg);
//    if( rc != SQLITE_OK ){
//        fprintf(stderr, "SQL error: %s\n", zErrMsg);
//        sqlite3_free(zErrMsg);
//    }else{
//        fprintf(stdout, "Records created successfully\n");
//    }
    
    ostringstream os; //从sstream库中衍生出来的, 只是为了更方便格式化字符串
    os << "INSERT INTO users (lecture, time, position) VALUES ('" << lectures << "','" << times << "','" << positions << "')";
    sqlite3_exec(db, os.str().c_str(), [](void *foo, int columnNum, char **columnTexts, char **columnNames){return 0;}, NULL, NULL) == SQLITE_OK;

    
    
}

// doubt it's going to work cuz may have error concanating sqlinfo
void insertCalendarInfo(const char* classes, const char* starttimes, const char* days, const char* weekly, const char* fortnightly, const char* location) {
    string insertInto = "INSERT INTO calendar (class, starttime, days, weekly, fortnightly, location) VALUES ('";
    string topcomma = "'";
    string comma = ",";
    string bracelet = "); ";
    
    string sqlinfo = insertInto + classes + topcomma + comma + topcomma + starttimes + topcomma + comma + topcomma + days + topcomma + comma + topcomma + weekly + topcomma + comma + topcomma + fortnightly + topcomma + comma + topcomma + location + topcomma + bracelet;
    sql = &sqlinfo[0u];
    rc = sqlite3_exec(db, sql, callback, 0, &zErrMsg);
    if( rc != SQLITE_OK ){
        fprintf(stderr, "SQL error: %s\n", zErrMsg);
        sqlite3_free(zErrMsg);
    }else{
        fprintf(stdout, "Records created successfully\n");
    }
    
    
}


void insertMeetings(const char* lectures, const char* times, const char* positions) {
    ostringstream os;
    os << "INSERT INTO newuser (lecture, time, position) VALUES ('" << lectures << "','" << times << "','" << positions << "')";
    sqlite3_exec(db, os.str().c_str(), [](void *foo, int columnNum, char **columnTexts, char **columnNames){return 0;}, NULL, NULL);
    
    
}


void insertNewAssignmenter(const char* lectures, const char* times, const char* positions) {
    ostringstream os;
    os << "INSERT INTO thirduser (lecture, time, position) VALUES ('" << lectures << "','" << times << "','" << positions << "')";
    sqlite3_exec(db, os.str().c_str(), [](void *foo, int columnNum, char **columnTexts, char **columnNames){return 0;}, NULL, NULL);
    
    
}

// Addignment cpp is a class, the second assignmentcpp is a constructor->guess: it's initialize pkid, lecture, time, and position in class AssignmentCpp
AssignmentCpp::AssignmentCpp(int pkid, string lecture, string time, string position): pkid(pkid), lecture(lecture), time(time), position(position) {}

static long t_rowNum;
long rowNumberInAssignmentsTable() {
    return sqlite3_exec(db, "SELECT id FROM users", [](void *foo, int columnNum, char **columnTexts, char **columnNames){
        t_rowNum++;
        return 0;
    }, NULL, NULL) == SQLITE_OK ? t_rowNum : -1;
} // 这个函数构造和前面我所创造的函数构造完全相同

long rowNumberInNewAssignmentsTable() {
    return sqlite3_exec(db, "SELECT id FROM newusers", [](void *foo, int columnNum, char **columnTexts, char **columnNames){
        t_rowNum++;
        return 0;
    }, NULL, NULL) == SQLITE_OK ? t_rowNum : -1;
}


long rowNumberInNewNewAssignmentsTable() {
    return sqlite3_exec(db, "SELECT id FROM thirduser", [](void *foo, int columnNum, char **columnTexts, char **columnNames){
        t_rowNum++;
        return 0;
    }, NULL, NULL) == SQLITE_OK ? t_rowNum : -1;
}
vector<AssignmentCpp> t_assres{}; //创造一个包含assignmentcpp类型的容器
vector<AssignmentCpp> queryForAllAssignments() {
    t_assres.clear(); //清空容器
    sqlite3_exec(db, "SELECT * FROM users", [](void *foo, int columnNum, char **columnTexts, char **columnNames){
        auto vec = vector<string>{columnTexts, columnTexts + columnNum}; //就是说这个变量只在这个函数的域上才能使用
        t_assres.push_back(AssignmentCpp{stoi(vec[0]), vec[1], vec[2], vec[3]});
        //尾部插入一个assignmentcpp新类，值分别是vec[0...3]
        return 0;
    }, NULL, NULL);
    return t_assres; // 返回assignmentcpp的容器
}

//vector<AssignmentCpp> t_assres{};
vector<AssignmentCpp> queryForAllNewAssignments() {
    t_assres.clear();
    sqlite3_exec(db, "SELECT * FROM newuser", [](void *foo, int columnNum, char **columnTexts, char **columnNames){
        auto vec = vector<string>{columnTexts, columnTexts + columnNum};
        t_assres.push_back(AssignmentCpp{stoi(vec[0]), vec[1], vec[2], vec[3]});
        return 0;
    }, NULL, NULL);
    return t_assres;
}

vector<AssignmentCpp> queryForAllNewNewAssignments() {
    t_assres.clear();
    sqlite3_exec(db, "SELECT * FROM thirduser", [](void *foo, int columnNum, char **columnTexts, char **columnNames){
        auto vec = vector<string>{columnTexts, columnTexts + columnNum};
        t_assres.push_back(AssignmentCpp{stoi(vec[0]), vec[1], vec[2], vec[3]});
        return 0;
    }, NULL, NULL);
    return t_assres;
}




/*
 add new assignment to the app.
 */
void insertNewAssignmentCpp(AssignmentCpp asscpp) {
    insertAssignment(asscpp.lecture.c_str(), asscpp.time.c_str(), asscpp.position.c_str());
    //当运行时给予一个类assignmentcpp然后从我给予的类中去取得相应的值， 借助这个类我们联通了swift和这个c++文件
}

void insertCalendarInfoCpp(AssignmentCpp asscpp) {
    /*insertCalendarInfo(asscpp.classes.c_str(), <#const char *starttimes#>, <#const char *days#>, <#const char *weekly#>, <#const char *fortnightly#>, <#const char *location#>)*/
}

void insertMeetingsCpp(AssignmentCpp asscpp) {
    insertMeetings(asscpp.lecture.c_str(), asscpp.time.c_str(), asscpp.position.c_str());
}

void insertNewNewNewAssignmentCpp(AssignmentCpp asscpp) {
    insertNewAssignmenter(asscpp.lecture.c_str(), asscpp.time.c_str(), asscpp.position.c_str());
}


/*
 delete assignment by pkid.
 */
bool deleteAssignmentById(int pkid) {
    ostringstream os; //从sstream库中衍生出来的, 只是为了更方便格式化字符串
    os << "DELETE FROM users WHERE id = " << pkid;
    return sqlite3_exec(db, os.str().c_str(), [](void *foo, int columnNum, char **columnTexts, char **columnNames){return 0;}, NULL, NULL) == SQLITE_OK;
}

bool deleteNewAssignmentById(int pkid) {
    ostringstream os;
    os << "DELETE FROM newuser WHERE id = " << pkid;
    return sqlite3_exec(db, os.str().c_str(), [](void *foo, int columnNum, char **columnTexts, char **columnNames){return 0;}, NULL, NULL) == SQLITE_OK;
}

bool deleteNewNewAssignmentById(int pkid) {
    ostringstream os;
    os << "DELETE FROM thirduser WHERE id = " << pkid;
    return sqlite3_exec(db, os.str().c_str(), [](void *foo, int columnNum, char **columnTexts, char **columnNames){return 0;}, NULL, NULL) == SQLITE_OK;
}









/*
 delete the record by ID
 */
bool deleteCalendarById(int pkid) {
    ostringstream os;
    os << "DELETE FROM calendar WHERE id = " << pkid;
    return sqlite3_exec(db, os.str().c_str(), [](void *foo, int columnNum, char **columnTexts, char **columnNames){return 0;}, NULL, NULL) == SQLITE_OK;
}
