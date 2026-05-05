import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Language.AnalyzeDocuments;
using Azure.ClientGenerator.Core;

namespace Language.AnalyzeTextClientCustomizations;

@@clientName(Tasks, "DocumentActions", "csharp");
@@clientName(State, "DocumentActionState", "csharp");
@@clientName(Error, "AnalyzeDocumentsError", "csharp");

@@clientName(Entity, "NamedEntity", "csharp");

@@clientName(JobState.createdDateTime, "CreatedAt", "csharp");

@@clientName(JobState.expirationDateTime, "ExpiresOn", "csharp");

@@clientName(JobState.lastUpdatedDateTime, "LastUpdatedAt", "csharp");

@@clientName(ErrorCode, "AnalyzeDocumentsErrorCode", "csharp");

@@clientName(WarningCodeValue, "WarningCode", "csharp");

@@clientName(AnalyzeDocumentsLROTask.taskName, "Name", "csharp");

@@clientName(PiiCategoriesExclude.ABARoutingNumber,
  "AbaRoutingNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.ARNationalIdentityNumber,
  "ArNationalIdentityNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.AUBankAccountNumber,
  "AuBankAccountNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.AUDriversLicenseNumber,
  "AuDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.AUMedicalAccountNumber,
  "AuMedicalAccountNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.AUPassportNumber,
  "AuPassportNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.AUTaxFileNumber, "AuTaxFileNumber", "csharp");
@@clientName(PiiCategoriesExclude.AUBusinessNumber,
  "AuBusinessNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.AUCompanyNumber, "AuCompanyNumber", "csharp");
@@clientName(PiiCategoriesExclude.ATIdentityCard, "AtIdentityCard", "csharp");
@@clientName(PiiCategoriesExclude.ATTaxIdentificationNumber,
  "AtTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.ATValueAddedTaxNumber,
  "AtValueAddedTaxNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.AzureDocumentDBAuthKey,
  "AzureDocumentDbauthKey",
  "csharp"
);
@@clientName(PiiCategoriesExclude.AzureIAASDatabaseConnectionAndSQLString,
  "AzureIaasDatabaseConnectionAndSqlString",
  "csharp"
);
@@clientName(PiiCategoriesExclude.AzureSAS, "AzureSas", "csharp");
@@clientName(PiiCategoriesExclude.BENationalNumber,
  "BeNationalNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.BENationalNumberV2,
  "BeNationalNumberV2",
  "csharp"
);
@@clientName(PiiCategoriesExclude.BEValueAddedTaxNumber,
  "BeValueAddedTaxNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.BRCPFNumber, "BrCpfNumber", "csharp");
@@clientName(PiiCategoriesExclude.BRLegalEntityNumber,
  "BrLegalEntityNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.BRNationalIDRG, "BrNationalIdRg", "csharp");
@@clientName(PiiCategoriesExclude.BGUniformCivilNumber,
  "BgUniformCivilNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.CABankAccountNumber,
  "CaBankAccountNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.CADriversLicenseNumber,
  "CaDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.CAHealthServiceNumber,
  "CaHealthServiceNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.CAPassportNumber,
  "CaPassportNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.CAPersonalHealthIdentification,
  "CaPersonalHealthIdentification",
  "csharp"
);
@@clientName(PiiCategoriesExclude.CASocialInsuranceNumber,
  "CaSocialInsuranceNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.CLIdentityCardNumber,
  "ClIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.CNResidentIdentityCardNumber,
  "CnResidentIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.HRIdentityCardNumber,
  "HrIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.HRNationalIDNumber,
  "HrNationalIdNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.HRPersonalIdentificationNumber,
  "HrPersonalIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.HRPersonalIdentificationOIBNumberV2,
  "HrPersonalIdentificationOIBNumberV2",
  "csharp"
);
@@clientName(PiiCategoriesExclude.CYIdentityCard, "CyIdentityCard", "csharp");
@@clientName(PiiCategoriesExclude.CYTaxIdentificationNumber,
  "CyTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.CZPersonalIdentityNumber,
  "CzPersonalIdentityNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.CZPersonalIdentityV2,
  "CzPersonalIdentityV2",
  "csharp"
);
@@clientName(PiiCategoriesExclude.DKPersonalIdentificationNumber,
  "DkPersonalIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.DKPersonalIdentificationV2,
  "DkPersonalIdentificationV2",
  "csharp"
);
@@clientName(PiiCategoriesExclude.EEPersonalIdentificationCode,
  "EePersonalIdentificationCode",
  "csharp"
);
@@clientName(PiiCategoriesExclude.EUDebitCardNumber,
  "EuDebitCardNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.EUDriversLicenseNumber,
  "EuDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.EUGPSCoordinates,
  "EuGpsCoordinates",
  "csharp"
);
@@clientName(PiiCategoriesExclude.EUNationalIdentificationNumber,
  "EuNationalIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.EUPassportNumber,
  "EuPassportNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.EUSocialSecurityNumber,
  "EuSocialSecurityNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.EUTaxIdentificationNumber,
  "EuTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.FIEuropeanHealthNumber,
  "FiEuropeanHealthNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.FINationalID, "FiNationalId", "csharp");
@@clientName(PiiCategoriesExclude.FINationalIDV2, "FiNationalIdV2", "csharp");
@@clientName(PiiCategoriesExclude.FIPassportNumber,
  "FiPassportNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.FRDriversLicenseNumber,
  "FrDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.FRHealthInsuranceNumber,
  "FrHealthInsuranceNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.FRNationalID, "FrNationalId", "csharp");
@@clientName(PiiCategoriesExclude.FRPassportNumber,
  "FrPassportNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.FRSocialSecurityNumber,
  "FrSocialSecurityNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.FRTaxIdentificationNumber,
  "FrTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.FRValueAddedTaxNumber,
  "FrValueAddedTaxNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.DEDriversLicenseNumber,
  "DeDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.DEPassportNumber,
  "DePassportNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.DEIdentityCardNumber,
  "DeIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.DETaxIdentificationNumber,
  "DeTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.DEValueAddedNumber,
  "DeValueAddedNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.GRNationalIDCard,
  "GrNationalIdCard",
  "csharp"
);
@@clientName(PiiCategoriesExclude.GRNationalIDV2, "GrNationalIdV2", "csharp");
@@clientName(PiiCategoriesExclude.GRTaxIdentificationNumber,
  "GrTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.HKIdentityCardNumber,
  "HkIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.HUValueAddedNumber,
  "HuValueAddedNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.HUPersonalIdentificationNumber,
  "HuPersonalIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.HUTaxIdentificationNumber,
  "HuTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.INPermanentAccount,
  "InPermanentAccount",
  "csharp"
);
@@clientName(PiiCategoriesExclude.INUniqueIdentificationNumber,
  "InUniqueIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.IDIdentityCardNumber,
  "IdIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.IEPersonalPublicServiceNumber,
  "IePersonalPublicServiceNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.IEPersonalPublicServiceNumberV2,
  "IePersonalPublicServiceNumberV2",
  "csharp"
);
@@clientName(PiiCategoriesExclude.ILBankAccountNumber,
  "IlBankAccountNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.ILNationalID, "IlNationalId", "csharp");
@@clientName(PiiCategoriesExclude.ITDriversLicenseNumber,
  "ItDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.ITFiscalCode, "ItFiscalCode", "csharp");
@@clientName(PiiCategoriesExclude.ITValueAddedTaxNumber,
  "ItValueAddedTaxNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.JPBankAccountNumber,
  "JpBankAccountNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.JPDriversLicenseNumber,
  "JpDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.JPPassportNumber,
  "JpPassportNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.JPResidentRegistrationNumber,
  "JpResidentRegistrationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.JPSocialInsuranceNumber,
  "JpSocialInsuranceNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.JPMyNumberCorporate,
  "JpMyNumberCorporate",
  "csharp"
);
@@clientName(PiiCategoriesExclude.JPMyNumberPersonal,
  "JpMyNumberPersonal",
  "csharp"
);
@@clientName(PiiCategoriesExclude.JPResidenceCardNumber,
  "JpResidenceCardNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.LVPersonalCode, "LvPersonalCode", "csharp");
@@clientName(PiiCategoriesExclude.LTPersonalCode, "LtPersonalCode", "csharp");
@@clientName(PiiCategoriesExclude.LUNationalIdentificationNumberNatural,
  "LuNationalIdentificationNumberNatural",
  "csharp"
);
@@clientName(PiiCategoriesExclude.LUNationalIdentificationNumberNonNatural,
  "LuNationalIdentificationNumberNonNatural",
  "csharp"
);
@@clientName(PiiCategoriesExclude.MYIdentityCardNumber,
  "MyIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.MTIdentityCardNumber,
  "MtIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.MTTaxIDNumber, "MtTaxIdNumber", "csharp");
@@clientName(PiiCategoriesExclude.NLCitizensServiceNumber,
  "NlCitizensServiceNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.NLCitizensServiceNumberV2,
  "NlCitizensServiceNumberV2",
  "csharp"
);
@@clientName(PiiCategoriesExclude.NLTaxIdentificationNumber,
  "NlTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.NLValueAddedTaxNumber,
  "NlValueAddedTaxNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.NZBankAccountNumber,
  "NzBankAccountNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.NZDriversLicenseNumber,
  "NzDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.NZInlandRevenueNumber,
  "NzInlandRevenueNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.NZMinistryOfHealthNumber,
  "NzMinistryOfHealthNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.NZSocialWelfareNumber,
  "NzSocialWelfareNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.NOIdentityNumber,
  "NoIdentityNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.PHUnifiedMultiPurposeIDNumber,
  "PhUnifiedMultiPurposeIdNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.PLIdentityCard, "PlIdentityCard", "csharp");
@@clientName(PiiCategoriesExclude.PLNationalID, "PlNationalId", "csharp");
@@clientName(PiiCategoriesExclude.PLNationalIDV2, "PlNationalIdV2", "csharp");
@@clientName(PiiCategoriesExclude.PLPassportNumber,
  "PlPassportNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.PLTaxIdentificationNumber,
  "PlTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.PLREGONNumber, "PlRegonNumber", "csharp");
@@clientName(PiiCategoriesExclude.PTCitizenCardNumber,
  "PtCitizenCardNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.PTCitizenCardNumberV2,
  "PtCitizenCardNumberV2",
  "csharp"
);
@@clientName(PiiCategoriesExclude.PTTaxIdentificationNumber,
  "PtTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.ROPersonalNumericalCode,
  "RoPersonalNumericalCode",
  "csharp"
);
@@clientName(PiiCategoriesExclude.RUPassportNumberDomestic,
  "RuPassportNumberDomestic",
  "csharp"
);
@@clientName(PiiCategoriesExclude.RUPassportNumberInternational,
  "RuPassportNumberInternational",
  "csharp"
);
@@clientName(PiiCategoriesExclude.SANationalID, "SaNationalId", "csharp");
@@clientName(PiiCategoriesExclude.SGNationalRegistrationIdentityCardNumber,
  "SgNationalRegistrationIdentityCardNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.SKPersonalNumber,
  "SkPersonalNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.SITaxIdentificationNumber,
  "SiTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.SIUniqueMasterCitizenNumber,
  "SiUniqueMasterCitizenNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.ZAIdentificationNumber,
  "ZaIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.KRResidentRegistrationNumber,
  "KrResidentRegistrationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.ESDNI, "EsDni", "csharp");
@@clientName(PiiCategoriesExclude.ESSocialSecurityNumber,
  "EsSocialSecurityNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.ESTaxIdentificationNumber,
  "EsTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.SQLServerConnectionString,
  "SqlServerConnectionString",
  "csharp"
);
@@clientName(PiiCategoriesExclude.SENationalID, "SeNationalId", "csharp");
@@clientName(PiiCategoriesExclude.SENationalIDV2, "SeNationalIdV2", "csharp");
@@clientName(PiiCategoriesExclude.SEPassportNumber,
  "SePassportNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.SETaxIdentificationNumber,
  "SeTaxIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.SWIFTCode, "SwiftCode", "csharp");
@@clientName(PiiCategoriesExclude.CHSocialSecurityNumber,
  "ChSocialSecurityNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.TWNationalID, "TwNationalId", "csharp");
@@clientName(PiiCategoriesExclude.TWPassportNumber,
  "TwPassportNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.TWResidentCertificate,
  "TwResidentCertificate",
  "csharp"
);
@@clientName(PiiCategoriesExclude.THPopulationIdentificationCode,
  "ThPopulationIdentificationCode",
  "csharp"
);
@@clientName(PiiCategoriesExclude.TRNationalIdentificationNumber,
  "TrNationalIdentificationNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.UKDriversLicenseNumber,
  "UkDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.UKElectoralRollNumber,
  "UkElectoralRollNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.UKNationalHealthNumber,
  "UkNationalHealthNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.UKNationalInsuranceNumber,
  "UkNationalInsuranceNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.UKUniqueTaxpayerNumber,
  "UkUniqueTaxpayerNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.USUKPassportNumber,
  "UsUkPassportNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.USBankAccountNumber,
  "UsBankAccountNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.USDriversLicenseNumber,
  "UsDriversLicenseNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.USIndividualTaxpayerIdentification,
  "UsIndividualTaxpayerIdentification",
  "csharp"
);
@@clientName(PiiCategoriesExclude.USSocialSecurityNumber,
  "UsSocialSecurityNumber",
  "csharp"
);
@@clientName(PiiCategoriesExclude.UAPassportNumberDomestic,
  "UaPassportNumberDomestic",
  "csharp"
);
@@clientName(PiiCategoriesExclude.UAPassportNumberInternational,
  "UaPassportNumberInternational",
  "csharp"
);

@@clientName(MultiLanguageAnalysisInput,
  "MultiLanguageDocumentInput",
  "csharp"
);

@@clientName(PiiTaskParameters, "PiiActionContent", "csharp");

@@clientName(AnalyzeDocumentsLROTask,
  "AnalyzeDocumentsOperationAction",
  "csharp"
);
@@clientName(AnalyzeDocumentsLROTask.taskName, "Name", "csharp");

@@clientName(AnalyzeDocumentsLROTaskKind,
  "AnalyzeDocumentsOperationActionKind",
  "csharp"
);

@@clientName(AbstractiveSummarizationLROTask,
  "AbstractiveSummarizationOperationAction",
  "csharp"
);
@@clientName(AbstractiveSummarizationLROTask.parameters,
  "ActionContent",
  "csharp"
);
@@clientName(AbstractiveSummarizationTaskParameters,
  "AbstractiveSummarizationActionContent",
  "csharp"
);

@@clientName(ExtractiveSummarizationLROTask,
  "ExtractiveSummarizationOperationAction",
  "csharp"
);
@@clientName(ExtractiveSummarizationLROTask.parameters,
  "ActionContent",
  "csharp"
);
@@clientName(ExtractiveSummarizationTaskParameters,
  "ExtractiveSummarizationActionContent",
  "csharp"
);

@@clientName(AnalyzeDocumentJobsInput,
  "AnalyzeDocumentsOperationInput",
  "csharp"
);
@@clientName(AnalyzeDocumentJobsInput.analysisInput,
  "DocumentsInput",
  "csharp"
);
@@clientName(AnalyzeDocumentJobsInput.tasks, "Actions", "csharp");

@@clientName(AnalyzeDocumentsLROResultsKind,
  "AnalyzeDocumentsOperationResultsKind",
  "csharp"
);
@@clientName(AnalyzeDocumentsLROResultsKind.AbstractiveSummarizationLROResults,
  "AbstractiveSummarizationOperationResults",
  "csharp"
);
@@clientName(AnalyzeDocumentsLROResultsKind.ExtractiveSummarizationLROResults,
  "ExtractiveSummarizationOperationResults",
  "csharp"
);
@@clientName(AnalyzeDocumentsLROResultsKind.PiiEntityRecognitionLROResults,
  "PiiEntityRecognitionOperationResults",
  "csharp"
);

@@clientName(PiiEntityRecognitionLROResult,
  "PiiEntityRecognitionOperationResult",
  "csharp"
);
@@clientName(AbstractiveSummarizationLROResult,
  "AbstractiveSummarizationOperationResult",
  "csharp"
);
@@clientName(ExtractiveSummarizationLROResult,
  "ExtractiveSummarizationOperationResult",
  "csharp"
);

@@clientName(analyzeDocumentsSubmitJob,
  "AnalyzeDocumentsSubmitOperation",
  "csharp"
);

@@clientName(analyzeDocumentsJobStatus,
  "GetAnalyzeDocumentsJobStatus",
  "csharp"
);
@@clientName(analyzeDocumentsCancelJob,
  "AnalyzeDocumentsCancelOperation",
  "csharp"
);
