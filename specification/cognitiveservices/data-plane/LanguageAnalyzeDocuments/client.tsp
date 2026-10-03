import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Language.AnalyzeDocuments;
using Azure.ClientGenerator.Core;

namespace Language.AnalyzeTextClientCustomizations;

@@clientName(AnalyzeDocuments, "DocumentsServiceClient", "csharp");
@@clientName(Tasks, "DocumentTasksState", "csharp");
@@clientName(Tasks.items, "Results", "csharp");
@@clientName(State, "DocumentActionStatus", "csharp");
@@clientName(State.cancelled, "Canceled", "csharp");
@@clientName(Error, "AnalyzeDocumentsError", "csharp");
@@clientName(Error.innererror, "InnerError", "csharp");

@@clientName(Entity, "NamedEntity", "csharp");

@@clientName(JobState.createdDateTime, "CreatedAt", "csharp");

@@clientName(JobState.expirationDateTime, "ExpiresOn", "csharp");

@@clientName(JobState.lastUpdatedDateTime, "LastUpdatedAt", "csharp");

@@clientName(ErrorCode, "AnalyzeDocumentsErrorCode", "csharp");

@@clientName(WarningCodeValue, "WarningCode", "csharp");

@@clientName(AnalyzeDocumentsLROTask.taskName, "Name", "csharp");

@@clientName(PiiCategories.ABARoutingNumber, "AbaRoutingNumber", "csharp");
@@clientName(
  PiiCategories.ARNationalIdentityNumber,
  "ArNationalIdentityNumber",
  "csharp"
);
@@clientName(
  PiiCategories.AUBankAccountNumber,
  "AuBankAccountNumber",
  "csharp"
);
@@clientName(
  PiiCategories.AUDriversLicenseNumber,
  "AuDriversLicenseNumber",
  "csharp"
);
@@clientName(
  PiiCategories.AUMedicalAccountNumber,
  "AuMedicalAccountNumber",
  "csharp"
);
@@clientName(PiiCategories.AUPassportNumber, "AuPassportNumber", "csharp");
@@clientName(PiiCategories.AUTaxFileNumber, "AuTaxFileNumber", "csharp");
@@clientName(PiiCategories.AUBusinessNumber, "AuBusinessNumber", "csharp");
@@clientName(PiiCategories.AUCompanyNumber, "AuCompanyNumber", "csharp");
@@clientName(PiiCategories.ATIdentityCard, "AtIdentityCard", "csharp");
@@clientName(
  PiiCategories.ATTaxIdentificationNumber,
  "AtTaxIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.ATValueAddedTaxNumber,
  "AtValueAddedTaxNumber",
  "csharp"
);
@@clientName(PiiCategories.AzureDocumentDBAuthKey,
  "AzureDocumentDBAuthKey",
  "csharp"
);
@@clientName(PiiCategories.AzureIAASDatabaseConnectionAndSQLString,
  "AzureIaasDBConnectionAndSqlString",
  "csharp"
);
@@clientName(PiiCategories.AzureSAS, "AzureSas", "csharp");
@@clientName(PiiCategories.BENationalNumber, "BeNationalNumber", "csharp");
@@clientName(PiiCategories.BENationalNumberV2, "BeNationalNumberV2", "csharp");
@@clientName(
  PiiCategories.BEValueAddedTaxNumber,
  "BeValueAddedTaxNumber",
  "csharp"
);
@@clientName(PiiCategories.BRCPFNumber, "BrCpfNumber", "csharp");
@@clientName(
  PiiCategories.BRLegalEntityNumber,
  "BrLegalEntityNumber",
  "csharp"
);
@@clientName(PiiCategories.BRNationalIDRG, "BrNationalIdRg", "csharp");
@@clientName(
  PiiCategories.BGUniformCivilNumber,
  "BgUniformCivilNumber",
  "csharp"
);
@@clientName(
  PiiCategories.CABankAccountNumber,
  "CaBankAccountNumber",
  "csharp"
);
@@clientName(
  PiiCategories.CADriversLicenseNumber,
  "CaDriversLicenseNumber",
  "csharp"
);
@@clientName(
  PiiCategories.CAHealthServiceNumber,
  "CaHealthServiceNumber",
  "csharp"
);
@@clientName(PiiCategories.CAPassportNumber, "CaPassportNumber", "csharp");
@@clientName(
  PiiCategories.CAPersonalHealthIdentification,
  "CaPersonalHealthIdentification",
  "csharp"
);
@@clientName(
  PiiCategories.CASocialInsuranceNumber,
  "CaSocialInsuranceNumber",
  "csharp"
);
@@clientName(
  PiiCategories.CLIdentityCardNumber,
  "ClIdentityCardNumber",
  "csharp"
);
@@clientName(
  PiiCategories.CNResidentIdentityCardNumber,
  "CnResidentIdentityCardNumber",
  "csharp"
);
@@clientName(
  PiiCategories.HRIdentityCardNumber,
  "HrIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategories.HRNationalIDNumber, "HrNationalIdNumber", "csharp");
@@clientName(
  PiiCategories.HRPersonalIdentificationNumber,
  "HrPersonalIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.HRPersonalIdentificationOIBNumberV2,
  "HrPersonalIdentificationOIBNumberV2",
  "csharp"
);
@@clientName(PiiCategories.CYIdentityCard, "CyIdentityCard", "csharp");
@@clientName(
  PiiCategories.CYTaxIdentificationNumber,
  "CyTaxIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.CZPersonalIdentityNumber,
  "CzPersonalIdentityNumber",
  "csharp"
);
@@clientName(
  PiiCategories.CZPersonalIdentityV2,
  "CzPersonalIdentityV2",
  "csharp"
);
@@clientName(
  PiiCategories.DKPersonalIdentificationNumber,
  "DkPersonalIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.DKPersonalIdentificationV2,
  "DkPersonalIdentificationV2",
  "csharp"
);
@@clientName(
  PiiCategories.EEPersonalIdentificationCode,
  "EePersonalIdentificationCode",
  "csharp"
);
@@clientName(PiiCategories.EUDebitCardNumber, "EuDebitCardNumber", "csharp");
@@clientName(
  PiiCategories.EUDriversLicenseNumber,
  "EuDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategories.EUGPSCoordinates, "EuGpsCoordinates", "csharp");
@@clientName(
  PiiCategories.EUNationalIdentificationNumber,
  "EuNationalIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategories.EUPassportNumber, "EuPassportNumber", "csharp");
@@clientName(
  PiiCategories.EUSocialSecurityNumber,
  "EuSocialSecurityNumber",
  "csharp"
);
@@clientName(
  PiiCategories.EUTaxIdentificationNumber,
  "EuTaxIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.FIEuropeanHealthNumber,
  "FiEuropeanHealthNumber",
  "csharp"
);
@@clientName(PiiCategories.FINationalID, "FiNationalId", "csharp");
@@clientName(PiiCategories.FINationalIDV2, "FiNationalIdV2", "csharp");
@@clientName(PiiCategories.FIPassportNumber, "FiPassportNumber", "csharp");
@@clientName(
  PiiCategories.FRDriversLicenseNumber,
  "FrDriversLicenseNumber",
  "csharp"
);
@@clientName(
  PiiCategories.FRHealthInsuranceNumber,
  "FrHealthInsuranceNumber",
  "csharp"
);
@@clientName(PiiCategories.FRNationalID, "FrNationalId", "csharp");
@@clientName(PiiCategories.FRPassportNumber, "FrPassportNumber", "csharp");
@@clientName(
  PiiCategories.FRSocialSecurityNumber,
  "FrSocialSecurityNumber",
  "csharp"
);
@@clientName(
  PiiCategories.FRTaxIdentificationNumber,
  "FrTaxIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.FRValueAddedTaxNumber,
  "FrValueAddedTaxNumber",
  "csharp"
);
@@clientName(
  PiiCategories.DEDriversLicenseNumber,
  "DeDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategories.DEPassportNumber, "DePassportNumber", "csharp");
@@clientName(
  PiiCategories.DEIdentityCardNumber,
  "DeIdentityCardNumber",
  "csharp"
);
@@clientName(
  PiiCategories.DETaxIdentificationNumber,
  "DeTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategories.DEValueAddedNumber, "DeValueAddedNumber", "csharp");
@@clientName(PiiCategories.GRNationalIDCard, "GrNationalIdCard", "csharp");
@@clientName(PiiCategories.GRNationalIDV2, "GrNationalIdV2", "csharp");
@@clientName(
  PiiCategories.GRTaxIdentificationNumber,
  "GrTaxIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.HKIdentityCardNumber,
  "HkIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategories.HUValueAddedNumber, "HuValueAddedNumber", "csharp");
@@clientName(
  PiiCategories.HUPersonalIdentificationNumber,
  "HuPersonalIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.HUTaxIdentificationNumber,
  "HuTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategories.INPermanentAccount, "InPermanentAccount", "csharp");
@@clientName(
  PiiCategories.INUniqueIdentificationNumber,
  "InUniqueIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.IDIdentityCardNumber,
  "IdIdentityCardNumber",
  "csharp"
);
@@clientName(
  PiiCategories.IEPersonalPublicServiceNumber,
  "IePersonalPublicServiceNumber",
  "csharp"
);
@@clientName(
  PiiCategories.IEPersonalPublicServiceNumberV2,
  "IePersonalPublicServiceNumberV2",
  "csharp"
);
@@clientName(
  PiiCategories.ILBankAccountNumber,
  "IlBankAccountNumber",
  "csharp"
);
@@clientName(PiiCategories.ILNationalID, "IlNationalId", "csharp");
@@clientName(
  PiiCategories.ITDriversLicenseNumber,
  "ItDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategories.ITFiscalCode, "ItFiscalCode", "csharp");
@@clientName(
  PiiCategories.ITValueAddedTaxNumber,
  "ItValueAddedTaxNumber",
  "csharp"
);
@@clientName(
  PiiCategories.JPBankAccountNumber,
  "JpBankAccountNumber",
  "csharp"
);
@@clientName(
  PiiCategories.JPDriversLicenseNumber,
  "JpDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategories.JPPassportNumber, "JpPassportNumber", "csharp");
@@clientName(
  PiiCategories.JPResidentRegistrationNumber,
  "JpResidentRegistrationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.JPSocialInsuranceNumber,
  "JpSocialInsuranceNumber",
  "csharp"
);
@@clientName(
  PiiCategories.JPMyNumberCorporate,
  "JpMyNumberCorporate",
  "csharp"
);
@@clientName(PiiCategories.JPMyNumberPersonal, "JpMyNumberPersonal", "csharp");
@@clientName(
  PiiCategories.JPResidenceCardNumber,
  "JpResidenceCardNumber",
  "csharp"
);
@@clientName(PiiCategories.LVPersonalCode, "LvPersonalCode", "csharp");
@@clientName(PiiCategories.LTPersonalCode, "LtPersonalCode", "csharp");
@@clientName(
  PiiCategories.LUNationalIdentificationNumberNatural,
  "LuNationalIdentificationNumberNatural",
  "csharp"
);
@@clientName(
  PiiCategories.LUNationalIdentificationNumberNonNatural,
  "LuNationalIdentificationNumberNonNatural",
  "csharp"
);
@@clientName(
  PiiCategories.MYIdentityCardNumber,
  "MyIdentityCardNumber",
  "csharp"
);
@@clientName(
  PiiCategories.MTIdentityCardNumber,
  "MtIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategories.MTTaxIDNumber, "MtTaxIdNumber", "csharp");
@@clientName(
  PiiCategories.NLCitizensServiceNumber,
  "NlCitizensServiceNumber",
  "csharp"
);
@@clientName(
  PiiCategories.NLCitizensServiceNumberV2,
  "NlCitizensServiceNumberV2",
  "csharp"
);
@@clientName(
  PiiCategories.NLTaxIdentificationNumber,
  "NlTaxIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.NLValueAddedTaxNumber,
  "NlValueAddedTaxNumber",
  "csharp"
);
@@clientName(
  PiiCategories.NZBankAccountNumber,
  "NzBankAccountNumber",
  "csharp"
);
@@clientName(
  PiiCategories.NZDriversLicenseNumber,
  "NzDriversLicenseNumber",
  "csharp"
);
@@clientName(
  PiiCategories.NZInlandRevenueNumber,
  "NzInlandRevenueNumber",
  "csharp"
);
@@clientName(
  PiiCategories.NZMinistryOfHealthNumber,
  "NzMinistryOfHealthNumber",
  "csharp"
);
@@clientName(
  PiiCategories.NZSocialWelfareNumber,
  "NzSocialWelfareNumber",
  "csharp"
);
@@clientName(PiiCategories.NOIdentityNumber, "NoIdentityNumber", "csharp");
@@clientName(
  PiiCategories.PHUnifiedMultiPurposeIDNumber,
  "PhUnifiedMultiPurposeIdNumber",
  "csharp"
);
@@clientName(PiiCategories.PLIdentityCard, "PlIdentityCard", "csharp");
@@clientName(PiiCategories.PLNationalID, "PlNationalId", "csharp");
@@clientName(PiiCategories.PLNationalIDV2, "PlNationalIdV2", "csharp");
@@clientName(PiiCategories.PLPassportNumber, "PlPassportNumber", "csharp");
@@clientName(
  PiiCategories.PLTaxIdentificationNumber,
  "PlTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategories.PLREGONNumber, "PlRegonNumber", "csharp");
@@clientName(
  PiiCategories.PTCitizenCardNumber,
  "PtCitizenCardNumber",
  "csharp"
);
@@clientName(
  PiiCategories.PTCitizenCardNumberV2,
  "PtCitizenCardNumberV2",
  "csharp"
);
@@clientName(
  PiiCategories.PTTaxIdentificationNumber,
  "PtTaxIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.ROPersonalNumericalCode,
  "RoPersonalNumericalCode",
  "csharp"
);
@@clientName(
  PiiCategories.RUPassportNumberDomestic,
  "RuPassportNumberDomestic",
  "csharp"
);
@@clientName(
  PiiCategories.RUPassportNumberInternational,
  "RuPassportNumberInternational",
  "csharp"
);
@@clientName(PiiCategories.SANationalID, "SaNationalId", "csharp");
@@clientName(
  PiiCategories.SGNationalRegistrationIdentityCardNumber,
  "SgNationalRegistrationIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategories.SKPersonalNumber, "SkPersonalNumber", "csharp");
@@clientName(
  PiiCategories.SITaxIdentificationNumber,
  "SiTaxIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.SIUniqueMasterCitizenNumber,
  "SiUniqueMasterCitizenNumber",
  "csharp"
);
@@clientName(
  PiiCategories.ZAIdentificationNumber,
  "ZaIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.KRResidentRegistrationNumber,
  "KrResidentRegistrationNumber",
  "csharp"
);
@@clientName(PiiCategories.ESDNI, "EsDni", "csharp");
@@clientName(
  PiiCategories.ESSocialSecurityNumber,
  "EsSocialSecurityNumber",
  "csharp"
);
@@clientName(
  PiiCategories.ESTaxIdentificationNumber,
  "EsTaxIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.SQLServerConnectionString,
  "SqlServerConnectionString",
  "csharp"
);
@@clientName(PiiCategories.SENationalID, "SeNationalId", "csharp");
@@clientName(PiiCategories.SENationalIDV2, "SeNationalIdV2", "csharp");
@@clientName(PiiCategories.SEPassportNumber, "SePassportNumber", "csharp");
@@clientName(
  PiiCategories.SETaxIdentificationNumber,
  "SeTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategories.SWIFTCode, "SwiftCode", "csharp");
@@clientName(
  PiiCategories.CHSocialSecurityNumber,
  "ChSocialSecurityNumber",
  "csharp"
);
@@clientName(PiiCategories.TWNationalID, "TwNationalId", "csharp");
@@clientName(PiiCategories.TWPassportNumber, "TwPassportNumber", "csharp");
@@clientName(
  PiiCategories.TWResidentCertificate,
  "TwResidentCertificate",
  "csharp"
);
@@clientName(
  PiiCategories.THPopulationIdentificationCode,
  "ThPopulationIdentificationCode",
  "csharp"
);
@@clientName(
  PiiCategories.TRNationalIdentificationNumber,
  "TrNationalIdentificationNumber",
  "csharp"
);
@@clientName(
  PiiCategories.UKDriversLicenseNumber,
  "UkDriversLicenseNumber",
  "csharp"
);
@@clientName(
  PiiCategories.UKElectoralRollNumber,
  "UkElectoralRollNumber",
  "csharp"
);
@@clientName(
  PiiCategories.UKNationalHealthNumber,
  "UkNationalHealthNumber",
  "csharp"
);
@@clientName(
  PiiCategories.UKNationalInsuranceNumber,
  "UkNationalInsuranceNumber",
  "csharp"
);
@@clientName(
  PiiCategories.UKUniqueTaxpayerNumber,
  "UkUniqueTaxpayerNumber",
  "csharp"
);
@@clientName(PiiCategories.USUKPassportNumber, "UsUkPassportNumber", "csharp");
@@clientName(
  PiiCategories.USBankAccountNumber,
  "UsBankAccountNumber",
  "csharp"
);
@@clientName(
  PiiCategories.USDriversLicenseNumber,
  "UsDriversLicenseNumber",
  "csharp"
);
@@clientName(
  PiiCategories.USIndividualTaxpayerIdentification,
  "UsIndividualTaxpayerIdentification",
  "csharp"
);
@@clientName(
  PiiCategories.USSocialSecurityNumber,
  "UsSocialSecurityNumber",
  "csharp"
);
@@clientName(
  PiiCategories.UAPassportNumberDomestic,
  "UaPassportNumberDomestic",
  "csharp"
);
@@clientName(
  PiiCategories.UAPassportNumberInternational,
  "UaPassportNumberInternational",
  "csharp"
);

@@clientName(MultiLanguageAnalysisInput,
  "MultiLanguageDocumentCollection",
  "csharp"
);

@@clientName(PiiTaskParameters, "PiiActionContent", "csharp");

@@clientName(
  AnalyzeDocumentsLROTask,
  "AnalyzeDocumentsOperationAction",
  "csharp"
);
@@clientName(AnalyzeDocumentsLROTask,
  "AnalyzeDocumentsOperationAction",
  "python"
);
@@clientName(PiiLROTask,
  "PiiEntityRecognitionAction",
  "csharp"
);
@@clientName(PiiLROTask,
  "PiiEntityRecognitionAction",
  "python"
);

@@clientName(AnalyzeDocumentsLROTask.taskName, "Name", "csharp");

@@clientName(
  AnalyzeDocumentsLROTaskKind,
  "AnalyzeDocumentsOperationActionKind",
  "csharp"
);
@@clientName(AnalyzeDocumentsLROTaskKind,
  "AnalyzeDocumentsOperationActionKind",
  "python"
);

@@clientName(
  AbstractiveSummarizationLROTask,
  "AbstractiveSummarizationOperationAction",
  "csharp"
);
@@clientName(AbstractiveSummarizationLROTask,
  "AbstractiveSummarizationOperationAction",
  "python"
);
@@clientName(AbstractiveSummarizationLROTask.parameters,
  "ActionContent",
  "csharp"
);
@@clientName(AbstractiveSummarizationTaskParameters,
  "AbstractiveSummarizationOptions",
  "csharp"
);
@@clientName(AbstractiveSummarizationTaskParameters.loggingOptOut,
  "ShouldLog",
  "csharp"
);

@@clientName(
  ExtractiveSummarizationLROTask,
  "ExtractiveSummarizationOperationAction",
  "csharp"
);
@@clientName(ExtractiveSummarizationLROTask,
  "ExtractiveSummarizationOperationAction",
  "python"
);
@@clientName(ExtractiveSummarizationLROTask.parameters,
  "ActionContent",
  "csharp"
);
@@clientName(ExtractiveSummarizationTaskParameters,
  "ExtractiveSummarizationOptions",
  "csharp"
);
@@clientName(ExtractiveSummarizationTaskParameters.sortBy,
  "OrderBy",
  "csharp"
);

@@clientName(
  AnalyzeDocumentJobsInput,
  "AnalyzeDocumentsOperationInput",
  "csharp"
);
@@clientName(AnalyzeDocumentJobsInput,
  "AnalyzeDocumentsJob",
  "python"
);
@@clientName(AnalyzeDocumentJobsInput.analysisInput,
  "DocumentInput",
  "csharp"
);
@@clientName(AnalyzeDocumentJobsInput.tasks, "Actions", "csharp");

@@clientName(
  AnalyzeDocumentsLROResultsKind,
  "AnalyzeDocumentsOperationResultsKind",
  "csharp"
);
@@clientName(AnalyzeDocumentsLROResultsKind,
  "AnalyzeDocumentsOperationResultsKind",
  "python"
);
@@clientName(AnalyzeDocumentsLROResultsKind.AbstractiveSummarizationLROResults,
  "AbstractiveSummarizationOperationResults",
  "csharp"
);
@@clientName(
  AnalyzeDocumentsLROResultsKind.ExtractiveSummarizationLROResults,
  "ExtractiveSummarizationOperationResults",
  "csharp"
);
@@clientName(
  AnalyzeDocumentsLROResultsKind.PiiEntityRecognitionLROResults,
  "PiiEntityRecognitionOperationResults",
  "csharp"
);
@@clientName(AnalyzeDocumentsLROResult,
  "AnalyzeDocumentsOperationResult",
  "csharp"
);
@@clientName(AnalyzeDocumentsLROResult,
  "AnalyzeDocumentsOperationResult",
  "python"
);

@@clientName(
  PiiEntityRecognitionLROResult,
  "PiiEntityRecognitionOperationResult",
  "csharp"
);
@@clientName(PiiEntityRecognitionLROResult,
  "PiiEntityRecognitionOperationResult",
  "python"
);
@@clientName(AbstractiveSummarizationLROResult,
  "AbstractiveSummarizationOperationResult",
  "csharp"
);
@@clientName(AbstractiveSummarizationLROResult,
  "AbstractiveSummarizationOperationResult",
  "python"
);
@@clientName(ExtractiveSummarizationLROResult,
  "ExtractiveSummarizationOperationResult",
  "csharp"
);
@@clientName(ExtractiveSummarizationLROResult,
  "ExtractiveSummarizationOperationResult",
  "python"
);

@@clientName(
  analyzeDocumentsSubmitJob,
  "AnalyzeDocumentsSubmitOperation",
  "csharp"
);

@@clientName(analyzeDocumentsSubmitJob,
  "SubmitJob",
  "python"
);

@@clientName(analyzeDocumentsJobStatus,
  "GetAnalyzeDocumentsJobState",
  "csharp"
);
@@clientName(analyzeDocumentsJobStatus,
  "GetJobState",
  "python"
);

@@clientName(analyzeDocumentsCancelJob,
  "AnalyzeDocumentsCancelOperation",
  "csharp"
);
@@clientName(analyzeDocumentsCancelJob,
  "CancelJob",
  "python"
);

@@clientName(SummaryLengthBucket,
  "SummarySize",
  "csharp"
);
@@clientName(redactionCharacter.equals, "EqualsSign", "csharp");
@@clientName(EntityMaskPolicy, "EntityMaskRedactionPolicy", "csharp");

@@clientName(DocumentWarning.targetRef, "TargetReference", "csharp");

@@clientName(PiiDomain.phi, "Health", "csharp");

@@clientName(PiiCategories.URL, "Url", "csharp");

@@clientName(RequestStatistics, "DocumentRequestStatistics", "csharp");

@@clientName(RequestStatistics, "OperationStatistics", "python");

@@clientName(ScriptKind, "DocumentScriptKind", "csharp");

@@clientName(ScriptCode, "DocumentScriptCode", "csharp");

@@clientName(NoMaskPolicy, "NoMaskRedactionPolicy", "csharp");

@@clientName(BaseRedactionPolicy, "RedactionPolicy", "csharp");

@@clientName(TaskState.lastUpdateDateTime, "LastUpdatedAt", "csharp");

@@clientName(DocumentAnalysisDocumentResult.target, "Targets", "csharp");

@@clientName(DocumentAnalysisDocumentResult, "DocumentAnalysisResult", "python");

@@clientName(ExtractiveSummarizationSortingCriteria, "ExtractiveSummarizationOrder", "csharp");

@@clientName(AbstractiveSummary, "DocumentAbstractiveSummary", "csharp");

@@clientName(PiiCategories.AzureIoTConnectionString, "AzureIOTConnectionString", "python");

@@clientName(AnalyzeDocumentsDocumentError, "AnalyzeDocumentsError", "python");