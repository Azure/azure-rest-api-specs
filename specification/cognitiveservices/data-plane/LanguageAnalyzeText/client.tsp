import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Language.Text;
using Azure.ClientGenerator.Core;

namespace Language.AnalyzeTextClientCustomizations;

@@clientName(Text, "TextAnalysis");

@@clientName(Tasks, "TextActions");
@@clientName(State, "TextActionState");
@@clientName(Error, "AnalyzeTextError");

@@clientName(Match, "EntityLinkingMatch");
@@clientName(Entity, "NamedEntity");
@@clientName(EntityWithMetadata, "NamedEntityWithMetadata");
@@clientName(EntityInferenceOptions, "EntityInferenceConfig");
@@clientName(Temporality, "HealthcareAssertionTemporality");
@@clientName(Conditionality, "HealthcareAssertionConditionality");
@@clientName(Certainty, "HealthcareAssertionCertainty");
@@clientName(Association, "HealthcareAssertionAssociation");
@@clientName(SentimentResponse, "SentimentResult");

@@clientName(JobState.createdDateTime, "CreatedAt");

@@clientName(JobState.expirationDateTime, "ExpiresOn");

@@clientName(JobState.lastUpdatedDateTime, "LastUpdatedAt");

@@clientName(BaseEntityOverlapPolicy, "EntityOverlapPolicy");

@@clientName(BaseTemporalMetadata, "TemporalMetadata");

@@clientName(BaseTemporalMetadata.dateValues, "Dates");

@@clientName(EntityCategory.GPE, "GeoPoliticalEntity");

@@clientName(EntityCategory.IP, "IpAddress");

@@clientName(EntityCategory.URL, "Uri");

@@clientName(ErrorCode, "AnalyzeTextErrorCode");

@@clientName(WarningCodeValue, "WarningCode");

@@clientName(DocumentSentimentValue, "DocumentSentiment");

@@clientName(TokenSentimentValue, "TokenSentiment");

@@clientName(PiiCategoriesExclude.ABARoutingNumber, "AbaRoutingNumber");
@@clientName(PiiCategoriesExclude.ARNationalIdentityNumber,
  "ArNationalIdentityNumber"
);
@@clientName(PiiCategoriesExclude.AUBankAccountNumber, "AuBankAccountNumber");
@@clientName(PiiCategoriesExclude.AUDriversLicenseNumber,
  "AuDriversLicenseNumber"
);
@@clientName(PiiCategoriesExclude.AUMedicalAccountNumber,
  "AuMedicalAccountNumber"
);
@@clientName(PiiCategoriesExclude.AUPassportNumber, "AuPassportNumber");
@@clientName(PiiCategoriesExclude.AUTaxFileNumber, "AuTaxFileNumber");
@@clientName(PiiCategoriesExclude.AUBusinessNumber, "AuBusinessNumber");
@@clientName(PiiCategoriesExclude.AUCompanyNumber, "AuCompanyNumber");
@@clientName(PiiCategoriesExclude.ATIdentityCard, "AtIdentityCard");
@@clientName(PiiCategoriesExclude.ATTaxIdentificationNumber,
  "AtTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.ATValueAddedTaxNumber,
  "AtValueAddedTaxNumber"
);
@@clientName(PiiCategoriesExclude.AzureDocumentDBAuthKey,
  "AzureDocumentDbauthKey"
);
@@clientName(PiiCategoriesExclude.AzureIAASDatabaseConnectionAndSQLString,
  "AzureIaasDatabaseConnectionAndSqlString"
);
@@clientName(PiiCategoriesExclude.AzureSAS, "AzureSas");
@@clientName(PiiCategoriesExclude.BENationalNumber, "BeNationalNumber");
@@clientName(PiiCategoriesExclude.BENationalNumberV2, "BeNationalNumberV2");
@@clientName(PiiCategoriesExclude.BEValueAddedTaxNumber,
  "BeValueAddedTaxNumber"
);
@@clientName(PiiCategoriesExclude.BRCPFNumber, "BrCpfNumber");
@@clientName(PiiCategoriesExclude.BRLegalEntityNumber, "BrLegalEntityNumber");
@@clientName(PiiCategoriesExclude.BRNationalIDRG, "BrNationalIdRg");
@@clientName(PiiCategoriesExclude.BGUniformCivilNumber, "BgUniformCivilNumber");
@@clientName(PiiCategoriesExclude.CABankAccountNumber, "CaBankAccountNumber");
@@clientName(PiiCategoriesExclude.CADriversLicenseNumber,
  "CaDriversLicenseNumber"
);
@@clientName(PiiCategoriesExclude.CAHealthServiceNumber,
  "CaHealthServiceNumber"
);
@@clientName(PiiCategoriesExclude.CAPassportNumber, "CaPassportNumber");
@@clientName(PiiCategoriesExclude.CAPersonalHealthIdentification,
  "CaPersonalHealthIdentification"
);
@@clientName(PiiCategoriesExclude.CASocialInsuranceNumber,
  "CaSocialInsuranceNumber"
);
@@clientName(PiiCategoriesExclude.CLIdentityCardNumber, "ClIdentityCardNumber");
@@clientName(PiiCategoriesExclude.CNResidentIdentityCardNumber,
  "CnResidentIdentityCardNumber"
);
@@clientName(PiiCategoriesExclude.HRIdentityCardNumber, "HrIdentityCardNumber");
@@clientName(PiiCategoriesExclude.HRNationalIDNumber, "HrNationalIdNumber");
@@clientName(PiiCategoriesExclude.HRPersonalIdentificationNumber,
  "HrPersonalIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.HRPersonalIdentificationOIBNumberV2,
  "HrPersonalIdentificationOIBNumberV2"
);
@@clientName(PiiCategoriesExclude.CYIdentityCard, "CyIdentityCard");
@@clientName(PiiCategoriesExclude.CYTaxIdentificationNumber,
  "CyTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.CZPersonalIdentityNumber,
  "CzPersonalIdentityNumber"
);
@@clientName(PiiCategoriesExclude.CZPersonalIdentityV2, "CzPersonalIdentityV2");
@@clientName(PiiCategoriesExclude.DKPersonalIdentificationNumber,
  "DkPersonalIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.DKPersonalIdentificationV2,
  "DkPersonalIdentificationV2"
);
@@clientName(PiiCategoriesExclude.EEPersonalIdentificationCode,
  "EePersonalIdentificationCode"
);
@@clientName(PiiCategoriesExclude.EUDebitCardNumber, "EuDebitCardNumber");
@@clientName(PiiCategoriesExclude.EUDriversLicenseNumber,
  "EuDriversLicenseNumber"
);
@@clientName(PiiCategoriesExclude.EUGPSCoordinates, "EuGpsCoordinates");
@@clientName(PiiCategoriesExclude.EUNationalIdentificationNumber,
  "EuNationalIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.EUPassportNumber, "EuPassportNumber");
@@clientName(PiiCategoriesExclude.EUSocialSecurityNumber,
  "EuSocialSecurityNumber"
);
@@clientName(PiiCategoriesExclude.EUTaxIdentificationNumber,
  "EuTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.FIEuropeanHealthNumber,
  "FiEuropeanHealthNumber"
);
@@clientName(PiiCategoriesExclude.FINationalID, "FiNationalId");
@@clientName(PiiCategoriesExclude.FINationalIDV2, "FiNationalIdV2");
@@clientName(PiiCategoriesExclude.FIPassportNumber, "FiPassportNumber");
@@clientName(PiiCategoriesExclude.FRDriversLicenseNumber,
  "FrDriversLicenseNumber"
);
@@clientName(PiiCategoriesExclude.FRHealthInsuranceNumber,
  "FrHealthInsuranceNumber"
);
@@clientName(PiiCategoriesExclude.FRNationalID, "FrNationalId");
@@clientName(PiiCategoriesExclude.FRPassportNumber, "FrPassportNumber");
@@clientName(PiiCategoriesExclude.FRSocialSecurityNumber,
  "FrSocialSecurityNumber"
);
@@clientName(PiiCategoriesExclude.FRTaxIdentificationNumber,
  "FrTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.FRValueAddedTaxNumber,
  "FrValueAddedTaxNumber"
);
@@clientName(PiiCategoriesExclude.DEDriversLicenseNumber,
  "DeDriversLicenseNumber"
);
@@clientName(PiiCategoriesExclude.DEPassportNumber, "DePassportNumber");
@@clientName(PiiCategoriesExclude.DEIdentityCardNumber, "DeIdentityCardNumber");
@@clientName(PiiCategoriesExclude.DETaxIdentificationNumber,
  "DeTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.DEValueAddedNumber, "DeValueAddedNumber");
@@clientName(PiiCategoriesExclude.GRNationalIDCard, "GrNationalIdCard");
@@clientName(PiiCategoriesExclude.GRNationalIDV2, "GrNationalIdV2");
@@clientName(PiiCategoriesExclude.GRTaxIdentificationNumber,
  "GrTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.HKIdentityCardNumber, "HkIdentityCardNumber");
@@clientName(PiiCategoriesExclude.HUValueAddedNumber, "HuValueAddedNumber");
@@clientName(PiiCategoriesExclude.HUPersonalIdentificationNumber,
  "HuPersonalIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.HUTaxIdentificationNumber,
  "HuTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.INPermanentAccount, "InPermanentAccount");
@@clientName(PiiCategoriesExclude.INUniqueIdentificationNumber,
  "InUniqueIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.IDIdentityCardNumber, "IdIdentityCardNumber");
@@clientName(PiiCategoriesExclude.IEPersonalPublicServiceNumber,
  "IePersonalPublicServiceNumber"
);
@@clientName(PiiCategoriesExclude.IEPersonalPublicServiceNumberV2,
  "IePersonalPublicServiceNumberV2"
);
@@clientName(PiiCategoriesExclude.ILBankAccountNumber, "IlBankAccountNumber");
@@clientName(PiiCategoriesExclude.ILNationalID, "IlNationalId");
@@clientName(PiiCategoriesExclude.ITDriversLicenseNumber,
  "ItDriversLicenseNumber"
);
@@clientName(PiiCategoriesExclude.ITFiscalCode, "ItFiscalCode");
@@clientName(PiiCategoriesExclude.ITValueAddedTaxNumber,
  "ItValueAddedTaxNumber"
);
@@clientName(PiiCategoriesExclude.JPBankAccountNumber, "JpBankAccountNumber");
@@clientName(PiiCategoriesExclude.JPDriversLicenseNumber,
  "JpDriversLicenseNumber"
);
@@clientName(PiiCategoriesExclude.JPPassportNumber, "JpPassportNumber");
@@clientName(PiiCategoriesExclude.JPResidentRegistrationNumber,
  "JpResidentRegistrationNumber"
);
@@clientName(PiiCategoriesExclude.JPSocialInsuranceNumber,
  "JpSocialInsuranceNumber"
);
@@clientName(PiiCategoriesExclude.JPMyNumberCorporate, "JpMyNumberCorporate");
@@clientName(PiiCategoriesExclude.JPMyNumberPersonal, "JpMyNumberPersonal");
@@clientName(PiiCategoriesExclude.JPResidenceCardNumber,
  "JpResidenceCardNumber"
);
@@clientName(PiiCategoriesExclude.LVPersonalCode, "LvPersonalCode");
@@clientName(PiiCategoriesExclude.LTPersonalCode, "LtPersonalCode");
@@clientName(PiiCategoriesExclude.LUNationalIdentificationNumberNatural,
  "LuNationalIdentificationNumberNatural"
);
@@clientName(PiiCategoriesExclude.LUNationalIdentificationNumberNonNatural,
  "LuNationalIdentificationNumberNonNatural"
);
@@clientName(PiiCategoriesExclude.MYIdentityCardNumber, "MyIdentityCardNumber");
@@clientName(PiiCategoriesExclude.MTIdentityCardNumber, "MtIdentityCardNumber");
@@clientName(PiiCategoriesExclude.MTTaxIDNumber, "MtTaxIdNumber");
@@clientName(PiiCategoriesExclude.NLCitizensServiceNumber,
  "NlCitizensServiceNumber"
);
@@clientName(PiiCategoriesExclude.NLCitizensServiceNumberV2,
  "NlCitizensServiceNumberV2"
);
@@clientName(PiiCategoriesExclude.NLTaxIdentificationNumber,
  "NlTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.NLValueAddedTaxNumber,
  "NlValueAddedTaxNumber"
);
@@clientName(PiiCategoriesExclude.NZBankAccountNumber, "NzBankAccountNumber");
@@clientName(PiiCategoriesExclude.NZDriversLicenseNumber,
  "NzDriversLicenseNumber"
);
@@clientName(PiiCategoriesExclude.NZInlandRevenueNumber,
  "NzInlandRevenueNumber"
);
@@clientName(PiiCategoriesExclude.NZMinistryOfHealthNumber,
  "NzMinistryOfHealthNumber"
);
@@clientName(PiiCategoriesExclude.NZSocialWelfareNumber,
  "NzSocialWelfareNumber"
);
@@clientName(PiiCategoriesExclude.NOIdentityNumber, "NoIdentityNumber");
@@clientName(PiiCategoriesExclude.PHUnifiedMultiPurposeIDNumber,
  "PhUnifiedMultiPurposeIdNumber"
);
@@clientName(PiiCategoriesExclude.PLIdentityCard, "PlIdentityCard");
@@clientName(PiiCategoriesExclude.PLNationalID, "PlNationalId");
@@clientName(PiiCategoriesExclude.PLNationalIDV2, "PlNationalIdV2");
@@clientName(PiiCategoriesExclude.PLPassportNumber, "PlPassportNumber");
@@clientName(PiiCategoriesExclude.PLTaxIdentificationNumber,
  "PlTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.PLREGONNumber, "PlRegonNumber");
@@clientName(PiiCategoriesExclude.PTCitizenCardNumber, "PtCitizenCardNumber");
@@clientName(PiiCategoriesExclude.PTCitizenCardNumberV2,
  "PtCitizenCardNumberV2"
);
@@clientName(PiiCategoriesExclude.PTTaxIdentificationNumber,
  "PtTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.ROPersonalNumericalCode,
  "RoPersonalNumericalCode"
);
@@clientName(PiiCategoriesExclude.RUPassportNumberDomestic,
  "RuPassportNumberDomestic"
);
@@clientName(PiiCategoriesExclude.RUPassportNumberInternational,
  "RuPassportNumberInternational"
);
@@clientName(PiiCategoriesExclude.SANationalID, "SaNationalId");
@@clientName(PiiCategoriesExclude.SGNationalRegistrationIdentityCardNumber,
  "SgNationalRegistrationIdentityCardNumber"
);
@@clientName(PiiCategoriesExclude.SKPersonalNumber, "SkPersonalNumber");
@@clientName(PiiCategoriesExclude.SITaxIdentificationNumber,
  "SiTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.SIUniqueMasterCitizenNumber,
  "SiUniqueMasterCitizenNumber"
);
@@clientName(PiiCategoriesExclude.ZAIdentificationNumber,
  "ZaIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.KRResidentRegistrationNumber,
  "KrResidentRegistrationNumber"
);
@@clientName(PiiCategoriesExclude.ESDNI, "EsDni");
@@clientName(PiiCategoriesExclude.ESSocialSecurityNumber,
  "EsSocialSecurityNumber"
);
@@clientName(PiiCategoriesExclude.ESTaxIdentificationNumber,
  "EsTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.SQLServerConnectionString,
  "SqlServerConnectionString"
);
@@clientName(PiiCategoriesExclude.SENationalID, "SeNationalId");
@@clientName(PiiCategoriesExclude.SENationalIDV2, "SeNationalIdV2");
@@clientName(PiiCategoriesExclude.SEPassportNumber, "SePassportNumber");
@@clientName(PiiCategoriesExclude.SETaxIdentificationNumber,
  "SeTaxIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.SWIFTCode, "SwiftCode");
@@clientName(PiiCategoriesExclude.CHSocialSecurityNumber,
  "ChSocialSecurityNumber"
);
@@clientName(PiiCategoriesExclude.TWNationalID, "TwNationalId");
@@clientName(PiiCategoriesExclude.TWPassportNumber, "TwPassportNumber");
@@clientName(PiiCategoriesExclude.TWResidentCertificate,
  "TwResidentCertificate"
);
@@clientName(PiiCategoriesExclude.THPopulationIdentificationCode,
  "ThPopulationIdentificationCode"
);
@@clientName(PiiCategoriesExclude.TRNationalIdentificationNumber,
  "TrNationalIdentificationNumber"
);
@@clientName(PiiCategoriesExclude.UKDriversLicenseNumber,
  "UkDriversLicenseNumber"
);
@@clientName(PiiCategoriesExclude.UKElectoralRollNumber,
  "UkElectoralRollNumber"
);
@@clientName(PiiCategoriesExclude.UKNationalHealthNumber,
  "UkNationalHealthNumber"
);
@@clientName(PiiCategoriesExclude.UKNationalInsuranceNumber,
  "UkNationalInsuranceNumber"
);
@@clientName(PiiCategoriesExclude.UKUniqueTaxpayerNumber,
  "UkUniqueTaxpayerNumber"
);
@@clientName(PiiCategoriesExclude.USUKPassportNumber, "UsUkPassportNumber");
@@clientName(PiiCategoriesExclude.USBankAccountNumber, "UsBankAccountNumber");
@@clientName(PiiCategoriesExclude.USDriversLicenseNumber,
  "UsDriversLicenseNumber"
);
@@clientName(PiiCategoriesExclude.USIndividualTaxpayerIdentification,
  "UsIndividualTaxpayerIdentification"
);
@@clientName(PiiCategoriesExclude.USSocialSecurityNumber,
  "UsSocialSecurityNumber"
);
@@clientName(PiiCategoriesExclude.UAPassportNumberDomestic,
  "UaPassportNumberDomestic"
);
@@clientName(PiiCategoriesExclude.UAPassportNumberInternational,
  "UaPassportNumberInternational"
);

@@clientName(WeightUnit.ShortTonUS, "ShortTonUs");
@@clientName(WeightUnit.ShortHundredWeightUS, "ShortHundredWeightUs");

@@access(AnalyzeTextTask, Access.public);
@@clientName(AnalyzeTextTask, "AnalyzeTextInput");
@@clientName(AnalyzeTextTaskKind, "AnalyzeTextInputKind");

@@clientName(MultiLanguageAnalysisInput, "MultiLanguageTextInput");
@@clientName(MultiLanguageAnalysisInput.documents, "MultiLanguageInputs");
@@clientName(LanguageDetectionAnalysisInput, "LanguageDetectionTextInput");
@@clientName(LanguageDetectionAnalysisInput.documents, "LanguageInputs");
@@clientName(AnalyzeTextSentimentAnalysisInput, "TextSentimentAnalysisInput");
@@clientName(AnalyzeTextSentimentAnalysisInput.parameters, "ActionContent");
@@clientName(AnalyzeTextSentimentAnalysisInput.analysisInput, "TextInput");
@@clientName(SentimentAnalysisTaskParameters, "SentimentAnalysisActionContent");

@@clientName(AnalyzeTextPiiEntitiesRecognitionInput,
  "TextPiiEntitiesRecognitionInput"
);
@@clientName(AnalyzeTextPiiEntitiesRecognitionInput.parameters,
  "ActionContent"
);
@@clientName(AnalyzeTextPiiEntitiesRecognitionInput.analysisInput, "TextInput");
@@clientName(PiiTaskParameters, "PiiActionContent");

@@clientName(AnalyzeTextLanguageDetectionInput, "TextLanguageDetectionInput");
@@clientName(AnalyzeTextLanguageDetectionInput.parameters, "ActionContent");
@@clientName(AnalyzeTextLanguageDetectionInput.analysisInput, "TextInput");
@@clientName(LanguageDetectionTaskParameters, "LanguageDetectionActionContent");
@@clientName(AnalyzeTextKeyPhraseExtractionInput,
  "TextKeyPhraseExtractionInput"
);
@@clientName(AnalyzeTextKeyPhraseExtractionInput.parameters, "ActionContent");
@@clientName(AnalyzeTextKeyPhraseExtractionInput.analysisInput, "TextInput");
@@clientName(KeyPhraseTaskParameters, "KeyPhraseActionContent");
@@clientName(AnalyzeTextEntityRecognitionInput, "TextEntityRecognitionInput");
@@clientName(AnalyzeTextEntityRecognitionInput.parameters, "ActionContent");
@@clientName(AnalyzeTextEntityRecognitionInput.analysisInput, "TextInput");
@@clientName(EntitiesTaskParameters, "EntitiesActionContent");
@@clientName(EntitiesTaskParameters.exclusionList, "Exclusions");
@@clientName(EntitiesTaskParameters.inclusionList, "Inclusions");

@@clientName(AnalyzeTextEntityLinkingInput, "TextEntityLinkingInput");
@@clientName(AnalyzeTextEntityLinkingInput.parameters, "ActionContent");
@@clientName(AnalyzeTextEntityLinkingInput.analysisInput, "TextInput");
@@clientName(EntityLinkingTaskParameters, "EntityLinkingActionContent");

@@clientName(AnalyzeTextTaskResult, "AnalyzeTextResult");
@@clientName(AnalyzeTextTaskResultsKind, "AnalyzeTextResultsKind");

@@clientName(SentimentTaskResult, "AnalyzeTextSentimentResult");
@@clientName(PiiTaskResult, "AnalyzeTextPiiResult");
@@clientName(LanguageDetectionTaskResult, "AnalyzeTextLanguageDetectionResult");
@@clientName(EntitiesTaskResult, "AnalyzeTextEntitiesResult");
@@clientName(EntityLinkingTaskResult, "AnalyzeTextEntityLinkingResult");
@@clientName(KeyPhraseTaskResult, "AnalyzeTextKeyPhraseResult");

@@clientName(AnalyzeTextJobsInput, "AnalyzeTextOperationInput");
@@clientName(AnalyzeTextJobsInput.analysisInput, "TextInput");
@@clientName(AnalyzeTextJobsInput.tasks, "Actions");

@@clientName(AnalyzeTextLROTask, "AnalyzeTextOperationAction");
@@clientName(AnalyzeTextLROTask.taskName, "Name");

@@clientName(AnalyzeTextLROTaskKind, "AnalyzeTextOperationActionKind");
@@clientName(SentimentAnalysisLROTask, "SentimentAnalysisOperationAction");
@@clientName(ExtractiveSummarizationLROTask,
  "ExtractiveSummarizationOperationAction"
);
@@clientName(ExtractiveSummarizationLROTask.parameters, "ActionContent");
@@clientName(ExtractiveSummarizationTaskParameters,
  "ExtractiveSummarizationActionContent"
);
@@clientName(AbstractiveSummarizationLROTask,
  "AbstractiveSummarizationOperationAction"
);
@@clientName(AbstractiveSummarizationLROTask.parameters, "ActionContent");
@@clientName(AbstractiveSummarizationTaskParameters,
  "AbstractiveSummarizationActionContent"
);
@@clientName(CustomMultiLabelClassificationLROTask,
  "CustomMultiLabelClassificationOperationAction"
);
@@clientName(CustomMultiLabelClassificationLROTask.parameters, "ActionContent");
@@clientName(CustomMultiLabelClassificationTaskParameters,
  "CustomMultiLabelClassificationActionContent"
);
@@clientName(CustomSingleLabelClassificationLROTask,
  "CustomSingleLabelClassificationOperationAction"
);
@@clientName(CustomSingleLabelClassificationLROTask.parameters,
  "ActionContent"
);
@@clientName(CustomSingleLabelClassificationTaskParameters,
  "CustomSingleLabelClassificationActionContent"
);
@@clientName(CustomEntitiesTaskParameters, "CustomEntitiesActionContent");
@@clientName(AnalyzeTextLROResultsKind, "AnalyzeTextOperationResultsKind");
@@clientName(AnalyzeTextLROResultsKind.SentimentAnalysisLROResults,
  "SentimentAnalysisOperationResults"
);
@@clientName(AnalyzeTextLROResultsKind.EntityRecognitionLROResults,
  "EntityRecognitionOperationResults"
);
@@clientName(AnalyzeTextLROResultsKind.PiiEntityRecognitionLROResults,
  "PiiEntityRecognitionOperationResults"
);
@@clientName(AnalyzeTextLROResultsKind.KeyPhraseExtractionLROResults,
  "KeyPhraseExtractionOperationResults"
);
@@clientName(AnalyzeTextLROResultsKind.EntityLinkingLROResults,
  "EntityLinkingOperationResults"
);
@@clientName(AnalyzeTextLROResultsKind.HealthcareLROResults,
  "HealthcareOperationResults"
);
@@clientName(AnalyzeTextLROResultsKind.CustomEntityRecognitionLROResults,
  "CustomEntityRecognitionOperationResults"
);
@@clientName(AnalyzeTextLROResultsKind.CustomSingleLabelClassificationLROResults,
  "CustomSingleLabelClassificationOperationResults"
);
@@clientName(AnalyzeTextLROResultsKind.CustomMultiLabelClassificationLROResults,
  "CustomMultiLabelClassificationOperationResults"
);
@@clientName(AnalyzeTextLROResultsKind.ExtractiveSummarizationLROResults,
  "ExtractiveSummarizationOperationResults"
);
@@clientName(AnalyzeTextLROResultsKind.AbstractiveSummarizationLROResults,
  "AbstractiveSummarizationOperationResults"
);
@@clientName(AbstractiveSummarizationLROResult,
  "AbstractiveSummarizationOperationResult"
);
@@clientName(ExtractiveSummarizationLROResult,
  "ExtractiveSummarizationOperationResult"
);
@@clientName(PiiEntityRecognitionLROResult,
  "PiiEntityRecognitionOperationResult"
);
@@clientName(KeyPhraseExtractionLROResult,
  "KeyPhraseExtractionOperationResult"
);
@@clientName(EntityRecognitionLROResult, "EntityRecognitionOperationResult");
@@clientName(EntityLinkingLROResult, "EntityLinkingOperationResult");
@@clientName(CustomMultiLabelClassificationLROResult,
  "CustomMultiLabelClassificationOperationResult"
);
@@clientName(CustomSingleLabelClassificationLROResult,
  "CustomSingleLabelClassificationOperationResult"
);
@@clientName(CustomEntityRecognitionLROResult,
  "CustomEntityRecognitionOperationResult"
);
@@clientName(EntitiesDocumentResultWithMetadataDetectedLanguage,
  "EntityActionResult"
);
@@clientName(EntitiesDocumentResultWithMetadata,
  "EntityActionResultWithMetadata"
);
@@clientName(ClassificationDocumentResultWithDetectedLanguage,
  "ClassificationActionResult"
);
@@clientName(EntityLinkingResultWithDetectedLanguage,
  "EntityLinkingActionResult"
);
@@clientName(KeyPhrasesDocumentResultWithDetectedLanguage,
  "KeyPhrasesActionResult"
);
@@clientName(SentimentDocumentResultWithDetectedLanguage,
  "SentimentActionResult"
);
@@clientName(ExtractedSummaryDocumentResultWithDetectedLanguage,
  "ExtractedSummaryActionResult"
);
@@clientName(AbstractiveSummaryDocumentResultWithDetectedLanguage,
  "AbstractiveSummaryActionResult"
);
@@clientName(HealthcareEntitiesDocumentResultWithDocumentDetectedLanguage,
  "HealthcareActionResult"
);
@@clientName(EntitiesDocumentResultWithDetectedLanguage,
  "CustomEntityActionResult"
);
@@clientName(PiiEntityWithTags, "PiiEntity");

@@clientName(analyzeTextSubmitJob, "analyzeTextJob", "python");
@@clientName(analyzeTextCancelJob, "cancelJob", "python");
@@clientName(analyzeTextJobStatus, "getJobStatus", "python");

@@clientName(AnalyzeTextJobState, "AnalyzeTextOperationState", "python");
@@clientName(AnalyzeTextJobState.tasks, "Actions", "python");
