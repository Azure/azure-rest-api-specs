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
@doc("Supported parameters for a PII Entities Recognition task.")
model PiiTaskParameters is PreBuiltTaskParameters {
  @doc("Domain for PII task")
  domain?: PiiDomain = PiiDomain.none;

  @doc("Enumeration of PII categories to be returned in the response.")
  piiCategories?: Array<PiiCategory>;

  @doc("StringIndexType to be used for analysis.")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  @added(Versions.v2023_11_15_preview)
  @doc("Enumeration of PII categories to be excluded in the response.")
  excludePiiCategories?: Array<PiiCategoriesExclude>;

  @added(Versions.v2023_11_15_preview)
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
    Versions.v2023_11_15_preview,
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
  PiiCategoriesExclude,

  @doc("All PII categories.")
  All: "All",

  @doc("Default PII categories for the language.")
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

@doc("(Optional) describes the PII categories to return")
union PiiCategoriesExclude {
  string,

  @doc("ABA Routing number")
  ABARoutingNumber: "ABARoutingNumber",

  @doc("AR National Identity Number")
  ARNationalIdentityNumber: "ARNationalIdentityNumber",

  @doc("AT Identity Card")
  AUBankAccountNumber: "AUBankAccountNumber",

  @doc("AU Driver's License Number")
  AUDriversLicenseNumber: "AUDriversLicenseNumber",

  @doc("AU Medical Account Number")
  AUMedicalAccountNumber: "AUMedicalAccountNumber",

  @doc("AU Passport Number")
  AUPassportNumber: "AUPassportNumber",

  @doc("AU Tax File Number")
  AUTaxFileNumber: "AUTaxFileNumber",

  @doc("AU Business Number")
  AUBusinessNumber: "AUBusinessNumber",

  @doc("AU Company Number")
  AUCompanyNumber: "AUCompanyNumber",

  @doc("AT Identity Card")
  ATIdentityCard: "ATIdentityCard",

  @doc("AT Tax Identification Number")
  ATTaxIdentificationNumber: "ATTaxIdentificationNumber",

  @doc("AT Value Added Tax Number")
  ATValueAddedTaxNumber: "ATValueAddedTaxNumber",

  @doc("Azure Document DB Auth Key")
  AzureDocumentDBAuthKey: "AzureDocumentDBAuthKey",

  @doc("Azure IAAS Database Connection And SQL String")
  AzureIAASDatabaseConnectionAndSQLString: "AzureIAASDatabaseConnectionAndSQLString",

  @doc("Azure IoT Connection String")
  AzureIoTConnectionString: "AzureIoTConnectionString",

  @doc("Azure Publish Setting Password")
  AzurePublishSettingPassword: "AzurePublishSettingPassword",

  @doc("Azure Redis Cache String")
  AzureRedisCacheString: "AzureRedisCacheString",

  @doc("Azure SAS")
  AzureSAS: "AzureSAS",

  @doc("Azure Service Bus String")
  AzureServiceBusString: "AzureServiceBusString",

  @doc("Azure Storage Account Key")
  AzureStorageAccountKey: "AzureStorageAccountKey",

  @doc("Azure Storage Account Generic")
  AzureStorageAccountGeneric: "AzureStorageAccountGeneric",

  @doc("BE National Number")
  BENationalNumber: "BENationalNumber",

  @doc("BE National Number V2")
  BENationalNumberV2: "BENationalNumberV2",

  @doc("BE Value Added Tax Number")
  BEValueAddedTaxNumber: "BEValueAddedTaxNumber",

  @doc("BR CPF Number")
  BRCPFNumber: "BRCPFNumber",

  @doc("BR Legal Entity Number")
  BRLegalEntityNumber: "BRLegalEntityNumber",

  @doc("BR National ID RG")
  BRNationalIDRG: "BRNationalIDRG",

  @doc("BG Uniform Civil Number")
  BGUniformCivilNumber: "BGUniformCivilNumber",

  @doc("CA Bank Account Number")
  CABankAccountNumber: "CABankAccountNumber",

  @doc("CA Driver's License Number")
  CADriversLicenseNumber: "CADriversLicenseNumber",

  @doc("CA Health Service Number")
  CAHealthServiceNumber: "CAHealthServiceNumber",

  @doc("CA Passport Number")
  CAPassportNumber: "CAPassportNumber",

  @doc("CA Personal Health Identification")
  CAPersonalHealthIdentification: "CAPersonalHealthIdentification",

  @doc("CA Social Insurance Number")
  CASocialInsuranceNumber: "CASocialInsuranceNumber",

  @doc("CL Identity Card Number")
  CLIdentityCardNumber: "CLIdentityCardNumber",

  @doc("CN Resident Identity Card Number")
  CNResidentIdentityCardNumber: "CNResidentIdentityCardNumber",

  @doc("Credit Card Number")
  CreditCardNumber: "CreditCardNumber",

  @doc("HR Identity Card Number")
  HRIdentityCardNumber: "HRIdentityCardNumber",

  @doc("HR National ID Number")
  HRNationalIDNumber: "HRNationalIDNumber",

  @doc("HR Personal Identification Number")
  HRPersonalIdentificationNumber: "HRPersonalIdentificationNumber",

  @doc("HR Personal Identification OIB Number V2")
  HRPersonalIdentificationOIBNumberV2: "HRPersonalIdentificationOIBNumberV2",

  @doc("CY Identity Card")
  CYIdentityCard: "CYIdentityCard",

  @doc("CY Tax Identification Number")
  CYTaxIdentificationNumber: "CYTaxIdentificationNumber",

  @doc("CZ Personal Identity Number")
  CZPersonalIdentityNumber: "CZPersonalIdentityNumber",

  @doc("CZ Personal Identity V2")
  CZPersonalIdentityV2: "CZPersonalIdentityV2",

  @doc("DK Personal Identification Number")
  DKPersonalIdentificationNumber: "DKPersonalIdentificationNumber",

  @doc("DK Personal Identification V2")
  DKPersonalIdentificationV2: "DKPersonalIdentificationV2",

  @doc("Drug Enforcement Agency Number")
  DrugEnforcementAgencyNumber: "DrugEnforcementAgencyNumber",

  @doc("EE Personal Identification Code")
  EEPersonalIdentificationCode: "EEPersonalIdentificationCode",

  @doc("EU Debit Card Number")
  EUDebitCardNumber: "EUDebitCardNumber",

  @doc("EU Driver's License Number")
  EUDriversLicenseNumber: "EUDriversLicenseNumber",

  @doc("EU GPS Coordinates")
  EUGPSCoordinates: "EUGPSCoordinates",

  @doc("EU National Identification Number")
  EUNationalIdentificationNumber: "EUNationalIdentificationNumber",

  @doc("EU Passport Number")
  EUPassportNumber: "EUPassportNumber",

  @doc("EU Social Security Number")
  EUSocialSecurityNumber: "EUSocialSecurityNumber",

  @doc("EU Tax Identification Number")
  EUTaxIdentificationNumber: "EUTaxIdentificationNumber",

  @doc("FI European Health Number")
  FIEuropeanHealthNumber: "FIEuropeanHealthNumber",

  @doc("FI National ID")
  FINationalID: "FINationalID",

  @doc("FI National ID V2")
  FINationalIDV2: "FINationalIDV2",

  @doc("FI Passport Number")
  FIPassportNumber: "FIPassportNumber",

  @doc("FR Driver's License Number")
  FRDriversLicenseNumber: "FRDriversLicenseNumber",

  @doc("FR Health Insurance Number")
  FRHealthInsuranceNumber: "FRHealthInsuranceNumber",

  @doc("FR National ID")
  FRNationalID: "FRNationalID",

  @doc("FR Passport Number")
  FRPassportNumber: "FRPassportNumber",

  @doc("FR Social Security Number")
  FRSocialSecurityNumber: "FRSocialSecurityNumber",

  @doc("FR Tax Identification Number")
  FRTaxIdentificationNumber: "FRTaxIdentificationNumber",

  @doc("FR Value Added Tax Number")
  FRValueAddedTaxNumber: "FRValueAddedTaxNumber",

  @doc("DE Driver's License Number")
  DEDriversLicenseNumber: "DEDriversLicenseNumber",

  @doc("DE Passport Number")
  DEPassportNumber: "DEPassportNumber",

  @doc("DE Identity Card Number")
  DEIdentityCardNumber: "DEIdentityCardNumber",

  @doc("DE Tax Identification Number")
  DETaxIdentificationNumber: "DETaxIdentificationNumber",

  @doc("DE Value Added Number")
  DEValueAddedNumber: "DEValueAddedNumber",

  @doc("GR National ID Card")
  GRNationalIDCard: "GRNationalIDCard",

  @doc("GR National ID V2")
  GRNationalIDV2: "GRNationalIDV2",

  @doc("GR Tax Identification Number")
  GRTaxIdentificationNumber: "GRTaxIdentificationNumber",

  @doc("HK Identity Card Number")
  HKIdentityCardNumber: "HKIdentityCardNumber",

  @doc("HU Value Added Number")
  HUValueAddedNumber: "HUValueAddedNumber",

  @doc("HU Personal Identification Number")
  HUPersonalIdentificationNumber: "HUPersonalIdentificationNumber",

  @doc("HU Tax Identification Number")
  HUTaxIdentificationNumber: "HUTaxIdentificationNumber",

  @doc("IN Permanent Account")
  INPermanentAccount: "INPermanentAccount",

  @doc("IN Unique Identification Number")
  INUniqueIdentificationNumber: "INUniqueIdentificationNumber",

  @doc("ID Identity Card Number")
  IDIdentityCardNumber: "IDIdentityCardNumber",

  @doc("International Banking Account Number")
  InternationalBankingAccountNumber: "InternationalBankingAccountNumber",

  @doc("IE Personal Public Service Number")
  IEPersonalPublicServiceNumber: "IEPersonalPublicServiceNumber",

  @doc("IE Personal Public Service Number V2")
  IEPersonalPublicServiceNumberV2: "IEPersonalPublicServiceNumberV2",

  @doc("IL Bank Account Number")
  ILBankAccountNumber: "ILBankAccountNumber",

  @doc("IL National ID")
  ILNationalID: "ILNationalID",

  @doc("IT Driver's License Number")
  ITDriversLicenseNumber: "ITDriversLicenseNumber",

  @doc("IT Fiscal Code")
  ITFiscalCode: "ITFiscalCode",

  @doc("IT Value Added Tax Number")
  ITValueAddedTaxNumber: "ITValueAddedTaxNumber",

  @doc("JP Bank Account Number")
  JPBankAccountNumber: "JPBankAccountNumber",

  @doc("JP Driver's License Number")
  JPDriversLicenseNumber: "JPDriversLicenseNumber",

  @doc("JP Passport Number")
  JPPassportNumber: "JPPassportNumber",

  @doc("JP Resident Registration Number")
  JPResidentRegistrationNumber: "JPResidentRegistrationNumber",

  @doc("JP Social Insurance Number")
  JPSocialInsuranceNumber: "JPSocialInsuranceNumber",

  @doc("JP My Number Corporate")
  JPMyNumberCorporate: "JPMyNumberCorporate",

  @doc("JP My Number Personal")
  JPMyNumberPersonal: "JPMyNumberPersonal",

  @doc("JP Residence Card Number")
  JPResidenceCardNumber: "JPResidenceCardNumber",

  @doc("LV Personal Code")
  LVPersonalCode: "LVPersonalCode",

  @doc("LT Personal Code")
  LTPersonalCode: "LTPersonalCode",

  @doc("LU National Identification Number Natural")
  LUNationalIdentificationNumberNatural: "LUNationalIdentificationNumberNatural",

  @doc("LU National Identification Number Non Natural")
  LUNationalIdentificationNumberNonNatural: "LUNationalIdentificationNumberNonNatural",

  @doc("MY Identity Card Number")
  MYIdentityCardNumber: "MYIdentityCardNumber",

  @doc("MT Identity Card Number")
  MTIdentityCardNumber: "MTIdentityCardNumber",

  @doc("MT Tax ID Number")
  MTTaxIDNumber: "MTTaxIDNumber",

  @doc("NL Citizens Service Number")
  NLCitizensServiceNumber: "NLCitizensServiceNumber",

  @doc("NL Citizens Service Number V2")
  NLCitizensServiceNumberV2: "NLCitizensServiceNumberV2",

  @doc("NL Tax Identification Number")
  NLTaxIdentificationNumber: "NLTaxIdentificationNumber",

  @doc("NL Value Added Tax Number")
  NLValueAddedTaxNumber: "NLValueAddedTaxNumber",

  @doc("NZ Bank Account Number")
  NZBankAccountNumber: "NZBankAccountNumber",

  @doc("NZ Driver's License Number")
  NZDriversLicenseNumber: "NZDriversLicenseNumber",

  @doc("NZ Inland Revenue Number")
  NZInlandRevenueNumber: "NZInlandRevenueNumber",

  @doc("NZ Ministry Of Health Number")
  NZMinistryOfHealthNumber: "NZMinistryOfHealthNumber",

  @doc("NZ Social Welfare Number")
  NZSocialWelfareNumber: "NZSocialWelfareNumber",

  @doc("NO Identity Number")
  NOIdentityNumber: "NOIdentityNumber",

  @doc("PH Unified Multi Purpose ID Number")
  PHUnifiedMultiPurposeIDNumber: "PHUnifiedMultiPurposeIDNumber",

  @doc("PL Identity Card")
  PLIdentityCard: "PLIdentityCard",

  @doc("PL National ID")
  PLNationalID: "PLNationalID",

  @doc("PL National ID V2")
  PLNationalIDV2: "PLNationalIDV2",

  @doc("PL Passport Number")
  PLPassportNumber: "PLPassportNumber",

  @doc("PL Tax Identification Number")
  PLTaxIdentificationNumber: "PLTaxIdentificationNumber",

  @doc("PL REGON Number")
  PLREGONNumber: "PLREGONNumber",

  @doc("PT Citizen Card Number")
  PTCitizenCardNumber: "PTCitizenCardNumber",

  @doc("PT Citizen Card Number V2")
  PTCitizenCardNumberV2: "PTCitizenCardNumberV2",

  @doc("PT Tax Identification Number")
  PTTaxIdentificationNumber: "PTTaxIdentificationNumber",

  @doc("RO Personal Numerical Code")
  ROPersonalNumericalCode: "ROPersonalNumericalCode",

  @doc("RU Passport Number Domestic")
  RUPassportNumberDomestic: "RUPassportNumberDomestic",

  @doc("RU Passport Number International")
  RUPassportNumberInternational: "RUPassportNumberInternational",

  @doc("SA National ID")
  SANationalID: "SANationalID",

  @doc("SG National Registration Identity Card Number")
  SGNationalRegistrationIdentityCardNumber: "SGNationalRegistrationIdentityCardNumber",

  @doc("SK Personal Number")
  SKPersonalNumber: "SKPersonalNumber",

  @doc("SI Tax Identification Number")
  SITaxIdentificationNumber: "SITaxIdentificationNumber",

  @doc("SI Unique Master Citizen Number")
  SIUniqueMasterCitizenNumber: "SIUniqueMasterCitizenNumber",

  @doc("ZA Identification Number")
  ZAIdentificationNumber: "ZAIdentificationNumber",

  @doc("KR Resident Registration Number")
  KRResidentRegistrationNumber: "KRResidentRegistrationNumber",

  @doc("ES DNI")
  ESDNI: "ESDNI",

  @doc("ES Social Security Number")
  ESSocialSecurityNumber: "ESSocialSecurityNumber",

  @doc("ES Tax Identification Number")
  ESTaxIdentificationNumber: "ESTaxIdentificationNumber",

  @doc("SQL Server Connection String")
  SQLServerConnectionString: "SQLServerConnectionString",

  @doc("SE National ID")
  SENationalID: "SENationalID",

  @doc("SE National ID V2")
  SENationalIDV2: "SENationalIDV2",

  @doc("SE Passport Number")
  SEPassportNumber: "SEPassportNumber",

  @doc("SE Tax Identification Number")
  SETaxIdentificationNumber: "SETaxIdentificationNumber",

  @doc("SWIFT Code")
  SWIFTCode: "SWIFTCode",

  @doc("CH Social Security Number")
  CHSocialSecurityNumber: "CHSocialSecurityNumber",

  @doc("TW National ID")
  TWNationalID: "TWNationalID",

  @doc("TW Passport Number")
  TWPassportNumber: "TWPassportNumber",

  @doc("TW Resident Certificate")
  TWResidentCertificate: "TWResidentCertificate",

  @doc("TH Population Identification Code")
  THPopulationIdentificationCode: "THPopulationIdentificationCode",

  @doc("TR National Identification Number")
  TRNationalIdentificationNumber: "TRNationalIdentificationNumber",

  @doc("UK Driver's License Number")
  UKDriversLicenseNumber: "UKDriversLicenseNumber",

  @doc("UK Electoral Roll Number")
  UKElectoralRollNumber: "UKElectoralRollNumber",

  @doc("UK National Health Number")
  UKNationalHealthNumber: "UKNationalHealthNumber",

  @doc("UK National Insurance Number")
  UKNationalInsuranceNumber: "UKNationalInsuranceNumber",

  @doc("UK Unique Taxpayer Number")
  UKUniqueTaxpayerNumber: "UKUniqueTaxpayerNumber",

  @doc("US UK Passport Number")
  USUKPassportNumber: "USUKPassportNumber",

  @doc("US Bank Account Number")
  USBankAccountNumber: "USBankAccountNumber",

  @doc("US Driver's License Number")
  USDriversLicenseNumber: "USDriversLicenseNumber",

  @doc("US Individual Taxpayer Identification")
  USIndividualTaxpayerIdentification: "USIndividualTaxpayerIdentification",

  @doc("US Social Security Number")
  USSocialSecurityNumber: "USSocialSecurityNumber",

  @doc("UA Passport Number Domestic")
  UAPassportNumberDomestic: "UAPassportNumberDomestic",

  @doc("UA Passport Number International")
  UAPassportNumberInternational: "UAPassportNumberInternational",

  @doc("Organization")
  Organization: "Organization",

  @doc("Email")
  Email: "Email",

  @doc("URL")
  URL: "URL",

  @doc("Age")
  Age: "Age",

  @doc("Phone Number")
  PhoneNumber: "PhoneNumber",

  @doc("IP Address")
  IPAddress: "IPAddress",

  @doc("Date")
  Date: "Date",

  @doc("Person")
  Person: "Person",

  @doc("Address")
  Address: "Address",
}
