/**
* @author Divya Babani
* @date 26 Jan 2020
*
* 
*
* @description This is used to fetch user list and used in lwcContactManagementComponent
*/
public with sharing class ManageUserController {
    @AuraEnabled(cacheable = true)  
    public static List<User> getUserList() { 
        String query = 'select id, Email, Name, Username, Phone,SmallPhotoUrl from User ';
        return Database.query(query);  
    }  
    
}
