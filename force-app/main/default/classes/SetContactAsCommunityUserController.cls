/**
 * @description       : 
 * @author            : emmanuel.martinez@tengo.co
 * @group             : 
 * @last modified on  : 07-14-2020
 * @last modified by  : emmanuel.martinez@tengo.co
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   07-03-2020   emmanuel.martinez@tengo.co   Initial Version
**/
public without sharing class SetContactAsCommunityUserController {
    
    @AuraEnabled
    public static List<Contact> getContacts(Id privateFundId) {

        PrivateFundRegistration__c privateFund = [SELECT Account__c FROM PrivateFundRegistration__c WHERE Id = :privateFundId LIMIT 1];
        List<User> existingUserList = [SELECT ContactId FROM User WHERE AccountId = :privateFund.Account__c];
        List<Id> contactIdList = new List<Id>();
        for (User user : existingUserList) {
            contactIdList.add(user.ContactId);
        }
        List<Contact> contactList = [SELECT Id, Name, Email, AccountId FROM Contact WHERE AccountId = :privateFund.Account__c AND Id NOT IN :contactIdList ORDER BY Name ASC];
        return contactList;

    }

    @AuraEnabled
    public static List<User> getExistingUsers(Id privateFundId) {

        PrivateFundRegistration__c privateFund = [SELECT Account__c FROM PrivateFundRegistration__c WHERE Id = :privateFundId LIMIT 1];
        List<User> existingUserList = [SELECT Name, Username, LastLoginDate, IsActive  FROM User WHERE AccountId = :privateFund.Account__c ORDER BY Name ASC];
        return existingUserList;

    }

    @AuraEnabled
    public static Boolean convertContactToUser(Id contactId) {

        Contact contact = [SELECT FirstName, Lastname, MiddleName, Email FROM Contact WHERE Id = :contactId];
        Profile profile = [SELECT Id FROM Profile WHERE Name LIKE 'DMS Client Portal Community User'];

        User newUser = new User();
        String nick = contact.Firstname + ' ' + contact.Lastname;
        newUser.LastName = contact.Lastname;
        newUser.FirstName = contact.Firstname;
        newUser.MiddleName = contact.MiddleName;
        newUser.Email = contact.Email;
        newUser.Username = contact.Email;
        newUser.ProfileId = profile.Id;
        newUser.ContactId = contact.Id;
        newUser.CommunityNickname = nick.mid(0, 39);
        newUser.Commission_Rate__c = 0;
        newUser.Alias = 'commusr';
        newUser.TimeZoneSidKey = 'GMT';
        newUser.LanguageLocaleKey = 'en_US';
        newUser.EmailEncodingKey = 'UTF-8';
        newUser.LocaleSidKey = 'en_US';
        insert newUser;

        return true;

    }

    @AuraEnabled
    public static void activateOrDeactivateUser(Id userId, String option) {

        User user = [SELECT IsActive FROM User WHERE Id = :userId];

        if (option == 'Activate') {
            user.IsActive = true;
        } else {
            user.IsActive = false;
        }

        update user;

    }

    @AuraEnabled
    public static Id getCommunityUsersReportId() {

        Report report = [SELECT Id FROM Report WHERE Name = 'Community Usage Report' AND DeveloperName = 'CommunityUsageReport'];
        return report.Id;

    }
    
    @AuraEnabled
    public static Boolean hasUserPermissions() {
        
        Id userId = UserInfo.getUserId();
        List<PermissionSetAssignment> permSetList = [SELECT Id FROM PermissionSetAssignment WHERE AssigneeId = :userId AND PermissionSet.Name = 'ManagePrivateFundRegistrations'];
        Profile profile = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId()];
        
        if (!permSetList.isEmpty() || profile.Name == 'System Administrator') {
            return true;
        } else {
            return false;
        }
        
    } 

}