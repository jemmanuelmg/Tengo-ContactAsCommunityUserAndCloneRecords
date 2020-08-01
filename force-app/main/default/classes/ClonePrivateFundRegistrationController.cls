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
public without sharing class ClonePrivateFundRegistrationController {
    
    @AuraEnabled
    public static Id cloneRecord(Id privateFundId) {

        PrivateFundRegistration__c originalRecord = [SELECT ALMCOCVResumeTitle__c,
                                                        ALMCOCVResume__c,
                                                        ALMCOCity__c,
                                                        ALMCOCountryOfBirth__c,
                                                        ALMCOCountry__c,
                                                        ALMCODateOfBirth__c,
                                                        ALMCOEmailAddress__c,
                                                        ALMCOEmployer__c,
                                                        ALMCOFacsimileNumber__c,
                                                        ALMCOFirstName__c,
                                                        ALMCOGender__c,
                                                        ALMCOLastName__c,
                                                        ALMCOMiddleName__c,
                                                        ALMCOOccupationTitle__c,
                                                        ALMCOOtherNames__c,
                                                        ALMCOPOBox__c,
                                                        ALMCOPhoneNumber__c,
                                                        ALMCOPrefix__c,
                                                        ALMCOStateProvince__c,
                                                        ALMCOStreetAddress__c,
                                                        ALMCOZipPostalCode__c,
                                                        AMLCFTServiceProviderCountry__c,
                                                        AMLCFTServiceProviderEmail__c,
                                                        AMLCFTServiceProviderName__c,
                                                        Account__c,
                                                        AccountingPrinciples__c,
                                                        ActualOrExpectedSizeOfInvestorBase__c,
                                                        AdministratorsConsentLetterTitle__c,
                                                        AttachAuditorsConsentLetter__c,
                                                        AttachCertOfIncorporationTitles__c,
                                                        AttachCertificateOfIncorporation_Re__c,
                                                        AttachConsFromRegAndTransfTitle__c,
                                                        AttachConsentFromNAVCalcAgenTitle__c,
                                                        AttachOfferingDocSummaryTitles__c,
                                                        AttachStructureChartTitles__c,
                                                        AttachStructureChart__c,
                                                        AttachTrustDeedDeclarationTitles__c,
                                                        AuditingPrinciples__c,
                                                        AuditorsConsentLetter__c,
                                                        BaseCurrencyOfOffering__c,
                                                        BuildingFloorSuiteB03a__c,
                                                        BuildingFloorSuiteB05a__c,
                                                        CIMAApplicationNumber__c,
                                                        CIMAIDC06__c,
                                                        CIMAID__c,
                                                        CaymanAuditorLocalAuditSignOff__c,
                                                        CityB03d__c,
                                                        CityB05d__c,
                                                        CloneRecord__c,
                                                        CompaniesRegistrationCORISNumber__c,
                                                        CountryB03g__c,
                                                        CountryB05g__c,
                                                        CountryOfAdministrator__c,
                                                        CountryOfDepositary__c,
                                                        CountryOfFormation__c,
                                                        CountryOfInvestmentManager__c,
                                                        CountryOfNAVCalculationAgent__c,
                                                        CountryOfOverseasAuditor__c,
                                                        CountryOfPromoterSponsor__c,
                                                        CountryOfRegistrarAndTransferAgent__c,
                                                        CreatedById,
                                                        CreatedDate,
                                                        CurrencyIsoCode,
                                                        DAMLCOCIMAID__c,
                                                        DAMLCOCVResumeTitle__c,
                                                        DAMLCOCVResume__c,
                                                        DAMLCOCity__c,
                                                        DAMLCOCountryOfBirth__c,
                                                        DAMLCOCountry__c,
                                                        DAMLCODateOfBirth__c,
                                                        DAMLCOEmailAddress__c,
                                                        DAMLCOEmployer__c,
                                                        DAMLCOFacsimileNumber__c,
                                                        DAMLCOFirstName__c,
                                                        DAMLCOGender__c,
                                                        DAMLCOLastName__c,
                                                        DAMLCOMiddleName__c,
                                                        DAMLCOOccupationTitle__c,
                                                        DAMLCOOtherNamesAliases__c,
                                                        DAMLCOPOBox__c,
                                                        DAMLCOPhoneNumber__c,
                                                        DAMLCOPrefix__c,
                                                        DAMLCOStateProvince__c,
                                                        DAMLCOStreetAddress__c,
                                                        DAMLCOZipPostalCode__c,
                                                        DMLROCIMAID__c,
                                                        DMLROCVResumeTitle__c,
                                                        DMLROCVResume__c,
                                                        DMLROCity__c,
                                                        DMLROCountryOfBirth__c,
                                                        DMLROCountry__c,
                                                        DMLRODateOfBirth__c,
                                                        DMLROEmailAddress__c,
                                                        DMLROEmployer__c,
                                                        DMLROFacsimileNumber__c,
                                                        DMLROFirstName__c,
                                                        DMLROGender__c,
                                                        DMLROLastName__c,
                                                        DMLROMiddleName__c,
                                                        DMLROOccupationTitle__c,
                                                        DMLROOtherNamesAliases__c,
                                                        DMLROPOBox__c,
                                                        DMLROPhoneNumber__c,
                                                        DMLROPrefix__c,
                                                        DMLROStateProvince__c,
                                                        DMLROStreetAddress__c,
                                                        DMLROZipPostalCode__c,
                                                        DateOfFormationIncorporation__c,
                                                        EmailAddressB03i__c,
                                                        EmailAddressB05i__c,
                                                        EmailAddress__c,
                                                        Engagement__c,
                                                        FYEDay__c,
                                                        FYEMonth__c,
                                                        FeePaymentsRegisteredOff__c,
                                                        FirstName__c,
                                                        FrequencyOfValuations__c,
                                                        FundName__c,
                                                        FundProvideItsAdministrationServices__c,
                                                        GPCountry__c,
                                                        GPLegalEntityIdentifierLEI__c,
                                                        GeneralPartnerGP__c,
                                                        HasAccess__c,
                                                        HasNomineeInvestors__c,
                                                        Id,
                                                        IfInCaymanNotRegisteredProvideIM__c,
                                                        IfInCaymanSelectAdministratorName__c,
                                                        IfInCaymanSelectInvestmentManager__c,
                                                        IfNoProvideFreePayments__c,
                                                        IfNoProvideNameOfNAVCalcAgent__c,
                                                        IfNoProvideNameOfRegistrarAndTra__c,
                                                        IfNoProvideOngoingQueries__c,
                                                        IfNotInCaymanProvideAdministrator__c,
                                                        IfNotInCaymanProvideIM__c,
                                                        IfNotInCaymanSelectNameOfRegulat__c,
                                                        IfRegulatorIsNotOnTheListInB19__c,
                                                        IfRegulatorIsNotOnTheListInB24__c,
                                                        IfRegulatorisNotOnTheListInB09__c,
                                                        IndustryReference__c,
                                                        InitialTermDurationOfFundInYears__c,
                                                        InvestmentManagerIndependent__c,
                                                        InvestmentRestrictionsCategory__c,
                                                        InvestmentRestrictionsDetails__c,
                                                        IsDeleted,
                                                        IsTheAMLFunctionOutsourced__c,
                                                        IsTheNAVCalculationAgentIndependent__c,
                                                        IsTheRegistrarAndTransferAgent__c,
                                                        LastModifiedById,
                                                        LastModifiedDate,
                                                        LastName__c,
                                                        LastReferencedDate,
                                                        LastViewedDate,
                                                        LegalCounselInCayman__c,
                                                        LegalEntityIdentifierLEI__c,
                                                        LegalStructure__c,
                                                        MLROCIMAID__c,
                                                        MLROCVResumeTitle__c,
                                                        MLROCVResume__c,
                                                        MLROCity__c,
                                                        MLROCountryOfBirth__c,
                                                        MLROCountry__c,
                                                        MLRODateOfBirth__c,
                                                        MLROEmailAddress__c,
                                                        MLROEmployer__c,
                                                        MLROFacsimileNumber__c,
                                                        MLROFirstName__c,
                                                        MLROGender__c,
                                                        MLROLastName__c,
                                                        MLROMiddleName__c,
                                                        MLROOccupationTitle__c,
                                                        MLROOtherNamesAliases__c,
                                                        MLROPOBox__c,
                                                        MLROPhoneNumber__c,
                                                        MLROPrefix__c,
                                                        MLROStateProvince__c,
                                                        MLROStreetAddress__c,
                                                        MLROZipPostalCode__c,
                                                        MaximumTermDurationOfFundInYears__c,
                                                        MinimumInitialInvestmentForInvestor__c,
                                                        NAVCalculationAgentSameAdmin__c,
                                                        Name,
                                                        NameC04__c,
                                                        NameOfDepositary__c,
                                                        NameOfDistributorIfApplicable__c,
                                                        NameOfFund__c,
                                                        NameOfOverseasAuditor__c,
                                                        NameOfPromoterSponsor__c,
                                                        NameOfRegisteredOffice__c,
                                                        NameOfRegulatorForAdministratorContB15__c,
                                                        NameOfRegulatorForAdministratorCont__c,
                                                        NameOfRegulatorForNAVCalculationAg__c,
                                                        NameOfRegulatorForRegistrarAndTran__c,
                                                        NewInvestmentManagerApplicationRef__c,
                                                        OfferingDocTermsSummaryMarketingMat__c,
                                                        OngoingQueriesRegisteredOff__c,
                                                        PFRFormLink__c,
                                                        POBoxB03c__c,
                                                        POBoxB05c__c,
                                                        PrimaryInvestmentStrategyOther__c,
                                                        PrimaryInvestmentStrategy__c,
                                                        PrimaryStockExchangeOfFund__c,
                                                        ProvinceStateB03e__c,
                                                        ProvinceStateB05e__c,
                                                        RegisterAndTransferAgentSameAdmin__c,
                                                        RequestedDateOfRegistration__c,
                                                        RiskFactors__c,
                                                        SecondaryInvestmentStrategyOther__c,
                                                        SecondaryInvestmentStrategy__c,
                                                        SingleFundMultiFund__c,
                                                        Status__c,
                                                        StreetNameAndNumberB03b__c,
                                                        StreetNameAndNumberB05b__c,
                                                        SystemModstamp,
                                                        TelephoneNumberB03h__c,
                                                        TelephoneNumberB05h__c,
                                                        TrustDeedPartnDeclMemAndAssArt__c,
                                                        Trustee__c,
                                                        ZIPPostalCodeB03f__c,
                                                        ZIPPostalCodeB05f__c 
                                                        FROM PrivateFundRegistration__c
                                                        WHERE Id = :privateFundId];

        PrivateFundRegistration__c clonedPFR = originalRecord.clone(false, false, false, false);
        clonedPFR.Status__c = 'Draft';
        insert clonedPFR;

        List<CIMAParticipant__c> originalParticipantList = [SELECT Id,
                                                            IsDeleted,
                                                            Name,
                                                            CurrencyIsoCode,
                                                            CreatedDate,
                                                            CreatedById,
                                                            LastModifiedDate,
                                                            LastModifiedById,
                                                            SystemModstamp,
                                                            LastViewedDate,
                                                            LastReferencedDate,
                                                            CIMAID__c,
                                                            Country__c,
                                                            DateOfBirth__c,
                                                            DirectorID__c,
                                                            Director__c,
                                                            EmailAddress__c,
                                                            FirstName__c,
                                                            FormId__c,
                                                            LastName__c,
                                                            MiddleName__c,
                                                            NameOfAdvisor__c,
                                                            SequenceNo__c 
                                                            FROM CIMAParticipant__c
                                                            WHERE PrivateFundRegistration__c = :originalRecord.Id];
        
        List<CIMAParticipant__c> clonedParticipants = new List<CIMAParticipant__c>();                                                    
        for (CIMAParticipant__c originalarticipant : originalParticipantList) {
            CIMAParticipant__c clonedParticipant = originalarticipant.clone(false, false, false, false);
            clonedParticipant.PrivateFundRegistration__c = clonedPFR.Id;
            clonedParticipants.add(clonedParticipant);
        }
        insert clonedParticipants;

        List<CIMAQualification__c> originalQualificationList = [SELECT Id,
                                                            IsDeleted,
                                                            Name,
                                                            CurrencyIsoCode,
                                                            CreatedDate,
                                                            CreatedById,
                                                            LastModifiedDate,
                                                            LastModifiedById,
                                                            SystemModstamp,
                                                            LastViewedDate,
                                                            LastReferencedDate,
                                                            AccreditingBody__c,
                                                            Date__c,
                                                            Description__c,
                                                            FormId__c,
                                                            SequenceNo__c,
                                                            Type__c 
                                                            FROM CIMAQualification__c
                                                            WHERE PrivateFundRegistration__c = :originalRecord.Id];

        List<CIMAQualification__c> clonedQualifications = new List<CIMAQualification__c>();                                                    
        for (CIMAQualification__c originalQualification : originalQualificationList) {
            CIMAQualification__c clonedQualification = originalQualification.clone(false, false, false, false);
            clonedQualification.PrivateFundRegistration__c = clonedPFR.Id;
            clonedQualifications.add(clonedQualification);
        }
        insert clonedQualifications;

        List<CIMAMultiFund__c> originalMultiFundList = [SELECT Id,
                                                        IsDeleted,
                                                        Name,
                                                        CurrencyIsoCode,
                                                        CreatedDate,
                                                        CreatedById,
                                                        LastModifiedDate,
                                                        LastModifiedById,
                                                        SystemModstamp,
                                                        LastViewedDate,
                                                        LastReferencedDate,
                                                        AccountingPrinciples__c,
                                                        ActualOrExpectedSizeOfInvestorBase__c,
                                                        AuditingPrinciples__c,
                                                        BaseCurrencyOfOffering__c,
                                                        CountryOfEstablishment__c,
                                                        DetailsA31ix__c,
                                                        DetailsA31xi__c,
                                                        DetailsSameAsAbovePrivateFund__c,
                                                        FYEDay__c,
                                                        FYEMonth__c,
                                                        FrequencyOfValuations__c,
                                                        InvestmentRestrictionsCategory__c,
                                                        InvestmentRestrictionsDetails__c,
                                                        InvestmentVehicleType__c,
                                                        MaximumAggregateOfOffering__c,
                                                        MinimumAggregateOfOffering__c,
                                                        MinimumInitialInvestmentforInvestor__c,
                                                        Name__c,
                                                        PrimaryInvestmentStrategy__c,
                                                        RiskFactors__c,
                                                        SecondaryInvestmentStrategy__c,
                                                        IsRecordValid__c,
                                                        SequenceNo__c 
                                                        FROM CIMAMultiFund__c
                                                        WHERE PrivateFundRegistration__c = :originalRecord.Id];

        List<CIMAMultiFund__c> clonedMultiFunds = new List<CIMAMultiFund__c>();                                                    
        for (CIMAMultiFund__c originalMultiFund : originalMultiFundList) {
            CIMAMultiFund__c clonedMultiFund = originalMultiFund.clone(false, false, false, false);
            clonedMultiFund.PrivateFundRegistration__c = clonedPFR.Id;
            clonedMultiFunds.add(clonedMultiFund);
        }
        insert clonedMultiFunds;

        List<ContentDocumentLink> documentLinks = [SELECT 
                                                    ContentDocumentId 
                                                    FROM ContentDocumentLink 
                                                    WHERE LinkedEntityId = :originalRecord.Id];
        List<Id> contentDocumentIds = new List<Id>();
        for (ContentDocumentLink documentLink : documentLinks) {
            contentDocumentIds.add(documentLink.ContentDocumentId);
        }
        List<ContentVersion> contentVersionList = [SELECT VersionNumber,
                                                        VersionData,
                                                        UploadedBy__c,
                                                        Transmission_Date__c,
                                                        Title,
                                                        TextPreview,
                                                        TagCsv,
                                                        SystemModstamp,
                                                        SharingPrivacy,
                                                        SharingOption,
                                                        Related_Task__c,
                                                        RecordTypeId,
                                                        Recipients_To__c,
                                                        Recipients_From__c,
                                                        Recipients_CC__c,
                                                        ReasonForChange,
                                                        RatingCount,
                                                        PublishStatus,
                                                        PositiveRatingCount,
                                                        PathOnClient,
                                                        OwnerId,
                                                        Origin,
                                                        NetworkId,
                                                        NegativeRatingCount,
                                                        LegacyId__c,
                                                        LastModifiedDate,
                                                        LastModifiedById,
                                                        IsMajorVersion,
                                                        IsLatest,
                                                        IsDeleted,
                                                        IsAssetEnabled,
                                                        InternetId__c,
                                                        Id,
                                                        Icon__c,
                                                        Hash_Code__c,
                                                        FirstPublishLocationId,
                                                        FileType,
                                                        FileExtension,
                                                        FeaturedContentDate,
                                                        FeaturedContentBoost,
                                                        ExternalDocumentInfo2,
                                                        ExternalDocumentInfo1,
                                                        ExternalDataSourceId,
                                                        DocumentId__c,
                                                        DocId__c,
                                                        Description,
                                                        CurrencyIsoCode,
                                                        CreatedDate,
                                                        CreatedById,
                                                        ConversationId__c,
                                                        ContentUrl,
                                                        ContentSize,
                                                        ContentModifiedDate,
                                                        ContentModifiedById,
                                                        ContentLocation,
                                                        Comments__c,
                                                        Checksum,
                                                        Categories__c
                                                        FROM ContentVersion
                                                        WHERE ContentDocumentId IN :contentDocumentIds];
        
        List<ContentVersion> clonedContentVersions = new List<ContentVersion>();                                      
        for (ContentVersion originalContentVersion : contentVersionList) {
            ContentVersion clonedContentVersion = originalContentVersion.clone(false, false, false, false);
            clonedContentVersion.ContentBodyId = null;
            clonedContentVersions.add(clonedContentVersion);
        }
        insert clonedContentVersions;
		
		List<id> clonedCVIds = new List<id>();
        for (ContentVersion element : clonedContentVersions) {
            clonedCVIds.add(element.Id);
        }
        List<ContentVersion> clonedContentVersions2 = [SELECT ContentDocumentId FROM ContentVersion WHERE Id IN :clonedCVIds];
        
        List<ContentDocumentLink> contDocLinkList = new List<ContentDocumentLink>();
        for (ContentVersion clonedCV : clonedContentVersions2) {
            ContentDocumentLink conDocLink = new ContentDocumentLink();
            conDocLink.LinkedEntityId = clonedPFR.Id;
            conDocLink.ContentDocumentId = clonedCV.ContentDocumentId;
            contDocLinkList.add(conDocLink);
        }
        insert contDocLinkList;
        
        return clonedPFR.Id;

    }

}