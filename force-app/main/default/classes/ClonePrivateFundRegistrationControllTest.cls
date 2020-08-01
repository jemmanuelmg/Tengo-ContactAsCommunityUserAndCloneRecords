/**
 * @description       : 
 * @author            : emmanuel.martinez@tengo.co
 * @group             : 
 * @last modified on  : 07-14-2020
 * @last modified by  : emmanuel.martinez@tengo.co
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   07-14-2020   emmanuel.martinez@tengo.co   Initial Version
**/
@isTest
public class ClonePrivateFundRegistrationControllTest {
    
    @testSetup 
    static void setup() {
        
        Account account = TestDataFactory.createAccount('Test Account Name');
        insert account;
        InvestmentManagerCaymanOption__c option1 = TestDataFactory.createInvestmentManagerCaymanOption();
        insert option1;
        InvestmentManagerWorldOption__c option2 = TestDataFactory.createInvestmentManagerWorldOption();
        insert option2;
        PrivateFundRegistration__c privateFund = TestDataFactory.createPrivateFundRegistration(account, option1, option2);
        insert privateFund;
        CIMAParticipant__c participant = TestDataFactory.createCIMAParticipant(privateFund, 'B10', 1);
        insert participant;
        CIMAQualification__c qualification = TestDataFactory.createCIMAQualification(privateFund, 'D22', 1);
        insert qualification;
        CIMAMultiFund__c multiFund = TestDataFactory.createCIMAMultiFund(privateFund, 'A31', 1);
        insert multiFund;
        ContentVersion contentVersion1 = TestDataFactory.createContentVersionAndContentDocument('File1', 'Test content of attachment');
        ContentVersion contentVersion2 = TestDataFactory.createContentVersionAndContentDocument('File2', 'Test content of attachment');
        List<ContentVersion> contentVersionList =  new List<ContentVersion> {contentVersion1, contentVersion2};
        insert contentVersionList;
        List<ContentDocument> contentDocumentList =[Select Id, Title, SystemModstamp FROM ContentDocument ORDER BY SystemModstamp DESC LIMIT 2];
        ContentDocumentLink documentLink1 = TestDataFactory.createContentDocumentLink(contentDocumentList[0].Id, privateFund.Id);
        ContentDocumentLink documentLink2 = TestDataFactory.createContentDocumentLink(contentDocumentList[1].Id, privateFund.Id);
        List<ContentDocumentLink> documentLinkList = new List<ContentDocumentLink> {documentLink1, documentLink2};
        insert documentLinkList;
        
    }
    
    @isTest
    static void testCloneRecord() {
        
        PrivateFundRegistration__c testPFR = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        
        Test.startTest();
        	ClonePrivateFundRegistrationController.cloneRecord(testPFR.Id);
        Test.stopTest();
        
        List<PrivateFundRegistration__c> pfrList = [SELECT Id FROM PrivateFundRegistration__c];
        System.assertEquals(2, pfrList.size(), 'Expected to have 2 Private Fund Registration records');
        
    }
    
}