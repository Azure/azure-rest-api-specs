import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the analyze text PIIEntityRecognition task input.")
model AnalyzeTextPiiEntitiesRecognitionInput extends AnalyzeTextTask {
  @doc("Kind of the task.")
  kind: AnalyzeTextTaskKind.PiiEntityRecognition;

  @doc("Contains the input documents.")
  analysisInput?: MultiLanguageAnalysisInput;

  @doc("Pii task parameters.")
  parameters?: PiiTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@clientName("PiiTaskContent", "csharp")
@doc("Supported parameters for a PII Entities Recognition task.")
model PiiTaskParameters is PreBuiltTaskParameters {
  @doc("Domain for PII task")
  domain?: PiiDomain = PiiDomain.none;

  @doc("Enumeration of PII categories to be returned in the response.")
  piiCategories?: Array<PiiCategory>;

  @doc("StringIndexType to be used for analysis.")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  @added(Versions.v2023_04_15_preview)
  @doc("Enumeration of PII categories to be excluded in the response.")
  excludePiiCategories?: PiiCategoriesExclude;

  @added(Versions.v2023_04_15_preview)
  @doc("Character to be used for redaction. Default in '*'.")
  redactionCharacter?: redactionCharacter = redactionCharacter.asterisk;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the analyze text PIIEntityRecognition LRO task.")
model PiiLROTask extends AnalyzeTextLROTask {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROTaskKind.PiiEntityRecognition;

  @doc("Pii task parameters.")
  parameters?: PiiTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the analyze text PIIEntityRecognition LRO task.")
model PiiTaskResult extends AnalyzeTextTaskResult {
  @doc("The kind of the task.")
  kind: AnalyzeTextTaskResultsKind.PiiEntityRecognitionResults;

  @doc("The list of pii results")
  results: PiiResult;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the PiiResult.")
model PiiResult is PreBuiltResult {
  @doc("Response by document")
  @typeChangedFrom(
    Versions.v2023_04_15_preview,
    Array<PiiEntitiesDocumentResult>
  )
  documents: Array<PiiResultWithDetectedLanguage>;
}

@doc("PII domains.")
union PiiDomain {
  string,

  @doc("Indicates that entities in the Personal Health Information domain should be redacted.")
  phi: "phi",

  @doc("Indicates that no domain is specified.")
  none: "none",
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the PII results.")
model PiiEntitiesDocumentResult is DocumentResult {
  @doc("Returns redacted text.")
  redactedText: string;

  @doc("Recognized entities in the document.")
  entities: Array<Entity>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the PII results with detected language.")
model PiiResultWithDetectedLanguage {
  ...PiiEntitiesDocumentResult;
  ...DocumentDetectedLanguage;
}

@doc("(Optional) describes the PII categories to return")
union PiiCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ABARoutingNumber: "ABARoutingNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ARNationalIdentityNumber: "ARNationalIdentityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUBankAccountNumber: "AUBankAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUDriversLicenseNumber: "AUDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUMedicalAccountNumber: "AUMedicalAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUPassportNumber: "AUPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUTaxFileNumber: "AUTaxFileNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUBusinessNumber: "AUBusinessNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUCompanyNumber: "AUCompanyNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ATIdentityCard: "ATIdentityCard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ATTaxIdentificationNumber: "ATTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ATValueAddedTaxNumber: "ATValueAddedTaxNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureDocumentDBAuthKey: "AzureDocumentDBAuthKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureIAASDatabaseConnectionAndSQLString: "AzureIAASDatabaseConnectionAndSQLString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureIoTConnectionString: "AzureIoTConnectionString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzurePublishSettingPassword: "AzurePublishSettingPassword",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureRedisCacheString: "AzureRedisCacheString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureSAS: "AzureSAS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureServiceBusString: "AzureServiceBusString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureStorageAccountKey: "AzureStorageAccountKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureStorageAccountGeneric: "AzureStorageAccountGeneric",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BENationalNumber: "BENationalNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BENationalNumberV2: "BENationalNumberV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BEValueAddedTaxNumber: "BEValueAddedTaxNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BRCPFNumber: "BRCPFNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BRLegalEntityNumber: "BRLegalEntityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BRNationalIDRG: "BRNationalIDRG",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BGUniformCivilNumber: "BGUniformCivilNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CABankAccountNumber: "CABankAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CADriversLicenseNumber: "CADriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CAHealthServiceNumber: "CAHealthServiceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CAPassportNumber: "CAPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CAPersonalHealthIdentification: "CAPersonalHealthIdentification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CASocialInsuranceNumber: "CASocialInsuranceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CLIdentityCardNumber: "CLIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CNResidentIdentityCardNumber: "CNResidentIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CreditCardNumber: "CreditCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HRIdentityCardNumber: "HRIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HRNationalIDNumber: "HRNationalIDNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HRPersonalIdentificationNumber: "HRPersonalIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HRPersonalIdentificationOIBNumberV2: "HRPersonalIdentificationOIBNumberV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CYIdentityCard: "CYIdentityCard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CYTaxIdentificationNumber: "CYTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CZPersonalIdentityNumber: "CZPersonalIdentityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CZPersonalIdentityV2: "CZPersonalIdentityV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DKPersonalIdentificationNumber: "DKPersonalIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DKPersonalIdentificationV2: "DKPersonalIdentificationV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DrugEnforcementAgencyNumber: "DrugEnforcementAgencyNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EEPersonalIdentificationCode: "EEPersonalIdentificationCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUDebitCardNumber: "EUDebitCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUDriversLicenseNumber: "EUDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUGPSCoordinates: "EUGPSCoordinates",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUNationalIdentificationNumber: "EUNationalIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUPassportNumber: "EUPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUSocialSecurityNumber: "EUSocialSecurityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUTaxIdentificationNumber: "EUTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FIEuropeanHealthNumber: "FIEuropeanHealthNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FINationalID: "FINationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FINationalIDV2: "FINationalIDV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FIPassportNumber: "FIPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRDriversLicenseNumber: "FRDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRHealthInsuranceNumber: "FRHealthInsuranceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRNationalID: "FRNationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRPassportNumber: "FRPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRSocialSecurityNumber: "FRSocialSecurityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRTaxIdentificationNumber: "FRTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRValueAddedTaxNumber: "FRValueAddedTaxNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DEDriversLicenseNumber: "DEDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DEPassportNumber: "DEPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DEIdentityCardNumber: "DEIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DETaxIdentificationNumber: "DETaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DEValueAddedNumber: "DEValueAddedNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  GRNationalIDCard: "GRNationalIDCard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  GRNationalIDV2: "GRNationalIDV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  GRTaxIdentificationNumber: "GRTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HKIdentityCardNumber: "HKIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HUValueAddedNumber: "HUValueAddedNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HUPersonalIdentificationNumber: "HUPersonalIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HUTaxIdentificationNumber: "HUTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  INPermanentAccount: "INPermanentAccount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  INUniqueIdentificationNumber: "INUniqueIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  IDIdentityCardNumber: "IDIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  InternationalBankingAccountNumber: "InternationalBankingAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  IEPersonalPublicServiceNumber: "IEPersonalPublicServiceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  IEPersonalPublicServiceNumberV2: "IEPersonalPublicServiceNumberV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ILBankAccountNumber: "ILBankAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ILNationalID: "ILNationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ITDriversLicenseNumber: "ITDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ITFiscalCode: "ITFiscalCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ITValueAddedTaxNumber: "ITValueAddedTaxNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPBankAccountNumber: "JPBankAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPDriversLicenseNumber: "JPDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPPassportNumber: "JPPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPResidentRegistrationNumber: "JPResidentRegistrationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPSocialInsuranceNumber: "JPSocialInsuranceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPMyNumberCorporate: "JPMyNumberCorporate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPMyNumberPersonal: "JPMyNumberPersonal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPResidenceCardNumber: "JPResidenceCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LVPersonalCode: "LVPersonalCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LTPersonalCode: "LTPersonalCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LUNationalIdentificationNumberNatural: "LUNationalIdentificationNumberNatural",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LUNationalIdentificationNumberNonNatural: "LUNationalIdentificationNumberNonNatural",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MYIdentityCardNumber: "MYIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MTIdentityCardNumber: "MTIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MTTaxIDNumber: "MTTaxIDNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NLCitizensServiceNumber: "NLCitizensServiceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NLCitizensServiceNumberV2: "NLCitizensServiceNumberV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NLTaxIdentificationNumber: "NLTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NLValueAddedTaxNumber: "NLValueAddedTaxNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZBankAccountNumber: "NZBankAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZDriversLicenseNumber: "NZDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZInlandRevenueNumber: "NZInlandRevenueNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZMinistryOfHealthNumber: "NZMinistryOfHealthNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZSocialWelfareNumber: "NZSocialWelfareNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NOIdentityNumber: "NOIdentityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PHUnifiedMultiPurposeIDNumber: "PHUnifiedMultiPurposeIDNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLIdentityCard: "PLIdentityCard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLNationalID: "PLNationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLNationalIDV2: "PLNationalIDV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLPassportNumber: "PLPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLTaxIdentificationNumber: "PLTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLREGONNumber: "PLREGONNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PTCitizenCardNumber: "PTCitizenCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PTCitizenCardNumberV2: "PTCitizenCardNumberV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PTTaxIdentificationNumber: "PTTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ROPersonalNumericalCode: "ROPersonalNumericalCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RUPassportNumberDomestic: "RUPassportNumberDomestic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RUPassportNumberInternational: "RUPassportNumberInternational",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SANationalID: "SANationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SGNationalRegistrationIdentityCardNumber: "SGNationalRegistrationIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SKPersonalNumber: "SKPersonalNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SITaxIdentificationNumber: "SITaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SIUniqueMasterCitizenNumber: "SIUniqueMasterCitizenNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ZAIdentificationNumber: "ZAIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KRResidentRegistrationNumber: "KRResidentRegistrationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ESDNI: "ESDNI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ESSocialSecurityNumber: "ESSocialSecurityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ESTaxIdentificationNumber: "ESTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SQLServerConnectionString: "SQLServerConnectionString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SENationalID: "SENationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SENationalIDV2: "SENationalIDV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SEPassportNumber: "SEPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SETaxIdentificationNumber: "SETaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SWIFTCode: "SWIFTCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CHSocialSecurityNumber: "CHSocialSecurityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TWNationalID: "TWNationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TWPassportNumber: "TWPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TWResidentCertificate: "TWResidentCertificate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  THPopulationIdentificationCode: "THPopulationIdentificationCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TRNationalIdentificationNumber: "TRNationalIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKDriversLicenseNumber: "UKDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKElectoralRollNumber: "UKElectoralRollNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKNationalHealthNumber: "UKNationalHealthNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKNationalInsuranceNumber: "UKNationalInsuranceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKUniqueTaxpayerNumber: "UKUniqueTaxpayerNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USUKPassportNumber: "USUKPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USBankAccountNumber: "USBankAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USDriversLicenseNumber: "USDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USIndividualTaxpayerIdentification: "USIndividualTaxpayerIdentification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USSocialSecurityNumber: "USSocialSecurityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UAPassportNumberDomestic: "UAPassportNumberDomestic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UAPassportNumberInternational: "UAPassportNumberInternational",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Organization: "Organization",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Email: "Email",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  URL: "URL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Age: "Age",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PhoneNumber: "PhoneNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  IPAddress: "IPAddress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Date: "Date",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Person: "Person",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Address: "Address",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  All: "All",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Default: "Default",
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the PII LRO results.")
model PiiEntityRecognitionLROResult extends AnalyzeTextLROResult {
  @doc("The kind of the task.")
  kind: AnalyzeTextLROResultsKind.PiiEntityRecognitionLROResults;

  @doc("The list of pii results")
  results: PiiResult;
}

@added(Versions.v2023_04_15_preview)
@doc("(Optional) describes the PII categories to return")
union PiiCategoriesExclude {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ABARoutingNumber: "ABARoutingNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ARNationalIdentityNumber: "ARNationalIdentityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUBankAccountNumber: "AUBankAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUDriversLicenseNumber: "AUDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUMedicalAccountNumber: "AUMedicalAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUPassportNumber: "AUPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUTaxFileNumber: "AUTaxFileNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUBusinessNumber: "AUBusinessNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUCompanyNumber: "AUCompanyNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ATIdentityCard: "ATIdentityCard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ATTaxIdentificationNumber: "ATTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ATValueAddedTaxNumber: "ATValueAddedTaxNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureDocumentDBAuthKey: "AzureDocumentDBAuthKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureIAASDatabaseConnectionAndSQLString: "AzureIAASDatabaseConnectionAndSQLString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureIoTConnectionString: "AzureIoTConnectionString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzurePublishSettingPassword: "AzurePublishSettingPassword",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureRedisCacheString: "AzureRedisCacheString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureSAS: "AzureSAS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureServiceBusString: "AzureServiceBusString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureStorageAccountKey: "AzureStorageAccountKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureStorageAccountGeneric: "AzureStorageAccountGeneric",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BENationalNumber: "BENationalNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BENationalNumberV2: "BENationalNumberV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BEValueAddedTaxNumber: "BEValueAddedTaxNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BRCPFNumber: "BRCPFNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BRLegalEntityNumber: "BRLegalEntityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BRNationalIDRG: "BRNationalIDRG",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BGUniformCivilNumber: "BGUniformCivilNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CABankAccountNumber: "CABankAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CADriversLicenseNumber: "CADriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CAHealthServiceNumber: "CAHealthServiceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CAPassportNumber: "CAPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CAPersonalHealthIdentification: "CAPersonalHealthIdentification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CASocialInsuranceNumber: "CASocialInsuranceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CLIdentityCardNumber: "CLIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CNResidentIdentityCardNumber: "CNResidentIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CreditCardNumber: "CreditCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HRIdentityCardNumber: "HRIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HRNationalIDNumber: "HRNationalIDNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HRPersonalIdentificationNumber: "HRPersonalIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HRPersonalIdentificationOIBNumberV2: "HRPersonalIdentificationOIBNumberV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CYIdentityCard: "CYIdentityCard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CYTaxIdentificationNumber: "CYTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CZPersonalIdentityNumber: "CZPersonalIdentityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CZPersonalIdentityV2: "CZPersonalIdentityV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DKPersonalIdentificationNumber: "DKPersonalIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DKPersonalIdentificationV2: "DKPersonalIdentificationV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DrugEnforcementAgencyNumber: "DrugEnforcementAgencyNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EEPersonalIdentificationCode: "EEPersonalIdentificationCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUDebitCardNumber: "EUDebitCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUDriversLicenseNumber: "EUDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUGPSCoordinates: "EUGPSCoordinates",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUNationalIdentificationNumber: "EUNationalIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUPassportNumber: "EUPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUSocialSecurityNumber: "EUSocialSecurityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUTaxIdentificationNumber: "EUTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FIEuropeanHealthNumber: "FIEuropeanHealthNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FINationalID: "FINationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FINationalIDV2: "FINationalIDV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FIPassportNumber: "FIPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRDriversLicenseNumber: "FRDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRHealthInsuranceNumber: "FRHealthInsuranceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRNationalID: "FRNationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRPassportNumber: "FRPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRSocialSecurityNumber: "FRSocialSecurityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRTaxIdentificationNumber: "FRTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRValueAddedTaxNumber: "FRValueAddedTaxNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DEDriversLicenseNumber: "DEDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DEPassportNumber: "DEPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DEIdentityCardNumber: "DEIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DETaxIdentificationNumber: "DETaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DEValueAddedNumber: "DEValueAddedNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  GRNationalIDCard: "GRNationalIDCard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  GRNationalIDV2: "GRNationalIDV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  GRTaxIdentificationNumber: "GRTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HKIdentityCardNumber: "HKIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HUValueAddedNumber: "HUValueAddedNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HUPersonalIdentificationNumber: "HUPersonalIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HUTaxIdentificationNumber: "HUTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  INPermanentAccount: "INPermanentAccount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  INUniqueIdentificationNumber: "INUniqueIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  IDIdentityCardNumber: "IDIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  InternationalBankingAccountNumber: "InternationalBankingAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  IEPersonalPublicServiceNumber: "IEPersonalPublicServiceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  IEPersonalPublicServiceNumberV2: "IEPersonalPublicServiceNumberV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ILBankAccountNumber: "ILBankAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ILNationalID: "ILNationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ITDriversLicenseNumber: "ITDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ITFiscalCode: "ITFiscalCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ITValueAddedTaxNumber: "ITValueAddedTaxNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPBankAccountNumber: "JPBankAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPDriversLicenseNumber: "JPDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPPassportNumber: "JPPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPResidentRegistrationNumber: "JPResidentRegistrationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPSocialInsuranceNumber: "JPSocialInsuranceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPMyNumberCorporate: "JPMyNumberCorporate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPMyNumberPersonal: "JPMyNumberPersonal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPResidenceCardNumber: "JPResidenceCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LVPersonalCode: "LVPersonalCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LTPersonalCode: "LTPersonalCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LUNationalIdentificationNumberNatural: "LUNationalIdentificationNumberNatural",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LUNationalIdentificationNumberNonNatural: "LUNationalIdentificationNumberNonNatural",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MYIdentityCardNumber: "MYIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MTIdentityCardNumber: "MTIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MTTaxIDNumber: "MTTaxIDNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NLCitizensServiceNumber: "NLCitizensServiceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NLCitizensServiceNumberV2: "NLCitizensServiceNumberV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NLTaxIdentificationNumber: "NLTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NLValueAddedTaxNumber: "NLValueAddedTaxNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZBankAccountNumber: "NZBankAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZDriversLicenseNumber: "NZDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZInlandRevenueNumber: "NZInlandRevenueNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZMinistryOfHealthNumber: "NZMinistryOfHealthNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZSocialWelfareNumber: "NZSocialWelfareNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NOIdentityNumber: "NOIdentityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PHUnifiedMultiPurposeIDNumber: "PHUnifiedMultiPurposeIDNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLIdentityCard: "PLIdentityCard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLNationalID: "PLNationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLNationalIDV2: "PLNationalIDV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLPassportNumber: "PLPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLTaxIdentificationNumber: "PLTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLREGONNumber: "PLREGONNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PTCitizenCardNumber: "PTCitizenCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PTCitizenCardNumberV2: "PTCitizenCardNumberV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PTTaxIdentificationNumber: "PTTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ROPersonalNumericalCode: "ROPersonalNumericalCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RUPassportNumberDomestic: "RUPassportNumberDomestic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RUPassportNumberInternational: "RUPassportNumberInternational",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SANationalID: "SANationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SGNationalRegistrationIdentityCardNumber: "SGNationalRegistrationIdentityCardNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SKPersonalNumber: "SKPersonalNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SITaxIdentificationNumber: "SITaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SIUniqueMasterCitizenNumber: "SIUniqueMasterCitizenNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ZAIdentificationNumber: "ZAIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KRResidentRegistrationNumber: "KRResidentRegistrationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ESDNI: "ESDNI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ESSocialSecurityNumber: "ESSocialSecurityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ESTaxIdentificationNumber: "ESTaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SQLServerConnectionString: "SQLServerConnectionString",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SENationalID: "SENationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SENationalIDV2: "SENationalIDV2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SEPassportNumber: "SEPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SETaxIdentificationNumber: "SETaxIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SWIFTCode: "SWIFTCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CHSocialSecurityNumber: "CHSocialSecurityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TWNationalID: "TWNationalID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TWPassportNumber: "TWPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TWResidentCertificate: "TWResidentCertificate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  THPopulationIdentificationCode: "THPopulationIdentificationCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TRNationalIdentificationNumber: "TRNationalIdentificationNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKDriversLicenseNumber: "UKDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKElectoralRollNumber: "UKElectoralRollNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKNationalHealthNumber: "UKNationalHealthNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKNationalInsuranceNumber: "UKNationalInsuranceNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKUniqueTaxpayerNumber: "UKUniqueTaxpayerNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USUKPassportNumber: "USUKPassportNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USBankAccountNumber: "USBankAccountNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USDriversLicenseNumber: "USDriversLicenseNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USIndividualTaxpayerIdentification: "USIndividualTaxpayerIdentification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USSocialSecurityNumber: "USSocialSecurityNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UAPassportNumberDomestic: "UAPassportNumberDomestic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UAPassportNumberInternational: "UAPassportNumberInternational",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Organization: "Organization",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Email: "Email",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  URL: "URL",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Age: "Age",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PhoneNumber: "PhoneNumber",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  IPAddress: "IPAddress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Date: "Date",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Person: "Person",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Address: "Address",
}
