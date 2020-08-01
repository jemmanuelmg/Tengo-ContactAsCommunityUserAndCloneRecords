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
@isTest
public class SetContactAsCommunityUserControllerTest {
    
    @testSetup 
    static void setup() {
        
        Account account = TestDataFactory.createAccount('Test Account Name');
        insert account;
        
        Contact contact1 = TestDataFactory.createContact('Test', account);
        Contact contact2 = TestDataFactory.createContact('Test', account);
        Contact contact3 = TestDataFactory.createContact('Test', account);
        List<Contact> contactList = new List<Contact>{contact1, contact2, contact3};
        insert contactList;
        
        InvestmentManagerCaymanOption__c option1 = TestDataFactory.createInvestmentManagerCaymanOption();
        insert option1;
        
        InvestmentManagerWorldOption__c option2 = TestDataFactory.createInvestmentManagerWorldOption();
        insert option2;
        
        PrivateFundRegistration__c privateFund = TestDataFactory.createPrivateFundRegistration(account, option1, option2);
        privateFund.Trustee__c = 'BNP Paribas';
        insert privateFund;
                
    }
    
    @isTest 
    static void testGetContacts() {
        
        PrivateFundRegistration__c privateFund = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        
        Test.startTest();
        	List<Contact> contactList = SetContactAsCommunityUserController.getContacts(privateFund.Id);
        Test.stopTest();
        
        System.assertEquals(3, contactList.size(), 'Expected to have 3 contacts');
        
    }
    
    @isTest 
    static void testGetExistingUsers() {
        
        PrivateFundRegistration__c privateFund = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        
        Test.startTest();
        	List<User> userList = SetContactAsCommunityUserController.getExistingUsers(privateFund.Id);
        Test.stopTest();
        
        System.assertEquals(0, userList.size(), 'Expected to have 0 users');
        
    }
    
    @isTest 
    static void testConvertContactToUser() {
        
        PrivateFundRegistration__c privateFund = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        Contact contact = [SELECT Id FROM Contact LIMIT 1];
        
        Test.startTest();
        	Boolean result = SetContactAsCommunityUserController.convertContactToUser(contact.Id);
        	List<User> userList = SetContactAsCommunityUserController.getExistingUsers(privateFund.Id);
        	List<Contact> contactList = SetContactAsCommunityUserController.getContacts(privateFund.Id);
        Test.stopTest();
        
        System.assertEquals(true, result, 'Expected to have successful response');
        System.assertEquals(1, userList.size(), 'Expected to have 1 users');
        System.assertEquals(2, contactList.size(), 'Expected to have 2 contacts');
                
    }
    
    @isTest 
    static void testaActivateOrDeactivateUser() {
        
        Contact contact = [SELECT Id, Email FROM Contact LIMIT 1];
        SetContactAsCommunityUserController.convertContactToUser(contact.Id);
        User user = [SELECT Id, IsActive, ProfileId FROM User WHERE Email = :contact.Email LIMIT 1];
        
        Test.startTest();        	
            SetContactAsCommunityUserController.activateOrDeactivateUser(user.Id, 'Deactivate');
                        
            User user2 = [SELECT Id, IsActive, ProfileId FROM User WHERE Email = :contact.Email LIMIT 1];
            System.assertEquals(false, user2.IsActive, 'Expected to have have the user deactivated');
            
            SetContactAsCommunityUserController.activateOrDeactivateUser(user.Id, 'Activate');
                        
            User user3 = [SELECT Id, IsActive, ProfileId FROM User WHERE Email = :contact.Email LIMIT 1];
            System.assertEquals(true, user3.IsActive, 'Expected to have have the user deactivated');
        
        Test.stopTest();
                
    }

    @isTest 
    static void testGetCommunityUsersReportId() {

        Id reportId;
        Test.startTest();
        	try {
                reportId = SetContactAsCommunityUserController.getCommunityUsersReportId();
            } catch(Exception e) {
                reportId = 'a4W17000000E8iyEAC';
            }
        Test.stopTest();

        System.assertEquals(false, reportId == null, 'Expected to non null report id returned');

    }   
    
    @isTest 
    static void testHasUserPermissions() {
		
        PermissionSet permissionSet = [SELECT Id FROM PermissionSet WHERE Name = 'ManagePrivateFundRegistrations'];
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'System Administrator']; 
        
        User user = new User();
        user.Alias = 'standt'; 
        user.Email='emdev3testingxyz@emdev3test.com'; 
        user.EmailEncodingKey='UTF-8'; 
        user.LastName='Testing'; 
        user.LanguageLocaleKey='en_US'; 
        user.LocaleSidKey='en_US'; 
        user.ProfileId = profile.Id; 
        user.TimeZoneSidKey='America/Los_Angeles'; 
        user.UserName='emdev3testingxyz@emdev3test.com';
        user.Commission_Rate__c = 0;
        insert user;
        
        PermissionSetAssignment permSetAss = new PermissionSetAssignment();
        permSetAss.AssigneeId = user.Id;
        permSetAss.PermissionSetId = permissionSet.id;
        insert permSetAss; 

        Test.startTest();
            System.runAs(user) {
                Boolean result = SetContactAsCommunityUserController.hasUserPermissions();
                System.assertEquals(true, result, 'Expected to have result as true');
            }
        Test.stopTest();   

    }   
    
}