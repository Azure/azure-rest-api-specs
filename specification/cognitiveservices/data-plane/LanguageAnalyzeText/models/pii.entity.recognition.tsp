import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.Text;

/** Contains the analyze text PIIEntityRecognition task input. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AnalyzeTextPiiEntitiesRecognitionInput extends AnalyzeTextTask {
  /** Kind of the task. */
  kind: AnalyzeTextTaskKind.PiiEntityRecognition;

  /** Contains the input documents. */
  analysisInput?: MultiLanguageAnalysisInput;

  /** Pii task parameters. */
  parameters?: PiiTaskParameters;
}

/** Supported parameters for a PII Entities Recognition task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model PiiTaskParameters is PreBuiltTaskParametersLoggingOptOut {
  /** Domain for PII task */
  domain?: PiiDomain = PiiDomain.none;

  /** Enumeration of PII categories to be returned in the response. */
  piiCategories?: PiiCategory[];

  /** StringIndexType to be used for analysis. */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  /** Enumeration of PII categories to be excluded in the response. */
  @added(Versions.v2024_11_15_preview)
  excludePiiCategories?: PiiCategoriesExclude[];

  /** RedactionPolicy to be used on the input. */
  @added(Versions.v2024_11_15_preview)
  redactionPolicy?: BaseRedactionPolicy;

  /** Policy for specific words and terms that should be excluded from detection by the PII detection service */
  @added(Versions.v2025_05_15_preview)
  valueExclusionPolicy?: ValueExclusionPolicy;

  /** (Optional) request parameter that allows the user to provide synonyms for context words that to enhance pii entity detection. */
  @added(Versions.v2025_05_15_preview)
  entitySynonyms?: EntitySynonyms[];
}

/** Object that allows the user to provide synonyms for context words that to enhance pii entity detection. */
@added(Versions.v2025_05_15_preview)
model EntitySynonyms {
  /** The entity name */
  entityType: EntityCategory;

  /** The entity synonyms */
  synonyms: EntitySynonym[];
}

/** The entity synonyms used to enhance pii entity detection */
@added(Versions.v2025_05_15_preview)
model EntitySynonym {
  /** The synonym to be used for context */
  synonym: string;

  /** The 2 letter ISO 639-1 language the synonym */
  language?: string;
}

/** Policy for specific words and terms that should be excluded from detection by the PII detection service */
@added(Versions.v2025_05_15_preview)
model ValueExclusionPolicy {
  /** Option to make the values excluded values case sensitive */
  caseSensitive: boolean = false;

  /** List of words and terms that should be excluded from detection by the PII detection service */
  excludedValues: string[];
}

/** The abstract base class for RedactionPolicy. */
@added(Versions.v2024_11_15_preview)
@discriminator("policyKind")
model BaseRedactionPolicy {
  /** The entity RedactionPolicy object kind. */
  policyKind: RedactionPolicyKind = RedactionPolicyKind.characterMask;
}

/** Represents the policy of redacting with a redaction character */
@added(Versions.v2024_11_15_preview)
model CharacterMaskPolicyType extends BaseRedactionPolicy {
  /** The entity RedactionPolicy object kind. */
  policyKind: RedactionPolicyKind.characterMask;

  /** Optional parameter to use a Custom Character to be used for redaction in PII responses. Default character will bce * as before. We allow specific ascii characters for redaction. */
  redactionCharacter?: redactionCharacter = redactionCharacter.asterisk;
}

/** Represents the policy of not redacting found PII. */
@added(Versions.v2024_11_15_preview)
model NoMaskPolicyType extends BaseRedactionPolicy {
  /** The entity RedactionPolicy object kind. */
  policyKind: RedactionPolicyKind.noMask;
}

/** Represents the policy of redacting PII with the entity type. */
@added(Versions.v2024_11_15_preview)
model EntityMaskPolicyType extends BaseRedactionPolicy {
  /** The entity OverlapPolicy object kind. */
  policyKind: RedactionPolicyKind.entityMask;
}

/** Kinds of redaction policies supported. */
@added(Versions.v2024_11_15_preview)
union RedactionPolicyKind {
  string,

  /** Do not redact detected entities. */
  noMask: "noMask",

  /** React detected entities with redaction character. */
  characterMask: "characterMask",

  /** Redact detected entities with entity type. */
  entityMask: "entityMask",
}

/** Contains the analyze text PIIEntityRecognition LRO task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model PiiLROTask extends AnalyzeTextLROTask {
  /** Kind of the task. */
  kind: AnalyzeTextLROTaskKind.PiiEntityRecognition;

  /** Pii task parameters. */
  parameters?: PiiTaskParameters;
}

/** Contains the analyze text PIIEntityRecognition LRO task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model PiiTaskResult extends AnalyzeTextTaskResult {
  /** The kind of the task. */
  kind: AnalyzeTextTaskResultsKind.PiiEntityRecognitionResults;

  /** The list of pii results */
  results: PiiResult;
}

/** Contains the PiiResult. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model PiiResult is PreBuiltResult {
  /** Response by document */
  @typeChangedFrom(Versions.v2024_11_15_preview, PiiEntitiesDocumentResult[])
  documents: PiiResultWithDetectedLanguage[];
}

/** PII domains. */
union PiiDomain {
  string,

  /** Indicates that entities in the Personal Health Information domain should be redacted. */
  phi: "phi",

  /** Indicates that no domain is specified. */
  none: "none",
}

/** Entity object with tags. */
@added(Versions.v2024_11_15_preview)
model PiiEntityWithTags is Entity {
  /** An entity type is the lowest (or finest) granularity at which the entity has been detected. The type maps to the specific metadata attributes associated with the entity detected. */
  type?: string;

  /** List of entity tags. Tags are to express some similarities/affinity between entities. */
  tags?: EntityTag[];

  /** Optional field which will be returned only when using the redaction policy kind “MaskWithEntityType”.  This field will contain the exact mask text used to mask the PII entity in the original text */
  mask?: string;

  /** Start position of masked text in the redacted text when using the redaction policy kind “MaskWithEntityType”. */
  maskOffset?: int32;

  /** The length of the masked text. Will be present when using the redaction policy kind “MaskWithEntityType”. */
  maskLength?: int32;
}

/** Contains the PII results. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model PiiEntitiesDocumentResult is DocumentResult {
  /** Returns redacted text. */
  redactedText: string;

  /** Recognized entities in the document. */
  @typeChangedFrom(Versions.v2024_11_15_preview, Entity[])
  entities: PiiEntityWithTags[];
}

/** Contains the PII results with detected language. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model PiiResultWithDetectedLanguage {
  ...PiiEntitiesDocumentResult;
  ...DocumentDetectedLanguage;
}

/** (Optional) describes the PII categories to return */
union PiiCategory {
  string,
  PiiCategoriesExclude,

  /** All PII categories. */
  All: "All",

  /** Default PII categories for the language. */
  Default: "Default",
}

/** Contains the PII LRO results. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model PiiEntityRecognitionLROResult extends AnalyzeTextLROResult {
  /** The kind of the task. */
  kind: AnalyzeTextLROResultsKind.PiiEntityRecognitionLROResults;

  /** The list of pii results */
  results: PiiResult;
}

/** (Optional) describes the PII categories to return */
union PiiCategoriesExclude {
  string,

  /** ABA Routing number */
  ABARoutingNumber: "ABARoutingNumber",

  /** AR National Identity Number */
  ARNationalIdentityNumber: "ARNationalIdentityNumber",

  /** AT Bank Account Number */
  AUBankAccountNumber: "AUBankAccountNumber",

  /** AU Driver's License Number */
  AUDriversLicenseNumber: "AUDriversLicenseNumber",

  /** AU Medical Account Number */
  AUMedicalAccountNumber: "AUMedicalAccountNumber",

  /** AU Passport Number */
  AUPassportNumber: "AUPassportNumber",

  /** AU Tax File Number */
  AUTaxFileNumber: "AUTaxFileNumber",

  /** AU Business Number */
  AUBusinessNumber: "AUBusinessNumber",

  /** AU Company Number */
  AUCompanyNumber: "AUCompanyNumber",

  /** AT Identity Card */
  ATIdentityCard: "ATIdentityCard",

  /** AT Tax Identification Number */
  ATTaxIdentificationNumber: "ATTaxIdentificationNumber",

  /** AT Value Added Tax Number */
  ATValueAddedTaxNumber: "ATValueAddedTaxNumber",

  /** Azure Document DB Auth Key */
  AzureDocumentDBAuthKey: "AzureDocumentDBAuthKey",

  /** Azure IAAS Database Connection And SQL String */
  AzureIAASDatabaseConnectionAndSQLString: "AzureIAASDatabaseConnectionAndSQLString",

  /** Azure IoT Connection String */
  AzureIoTConnectionString: "AzureIoTConnectionString",

  /** Azure Publish Setting Password */
  AzurePublishSettingPassword: "AzurePublishSettingPassword",

  /** Azure Redis Cache String */
  AzureRedisCacheString: "AzureRedisCacheString",

  /** Azure SAS */
  AzureSAS: "AzureSAS",

  /** Azure Service Bus String */
  AzureServiceBusString: "AzureServiceBusString",

  /** Azure Storage Account Key */
  AzureStorageAccountKey: "AzureStorageAccountKey",

  /** Azure Storage Account Generic */
  AzureStorageAccountGeneric: "AzureStorageAccountGeneric",

  /** BE National Number */
  BENationalNumber: "BENationalNumber",

  /** BE National Number V2 */
  BENationalNumberV2: "BENationalNumberV2",

  /** BE Value Added Tax Number */
  BEValueAddedTaxNumber: "BEValueAddedTaxNumber",

  /** BR CPF Number */
  BRCPFNumber: "BRCPFNumber",

  /** BR Legal Entity Number */
  BRLegalEntityNumber: "BRLegalEntityNumber",

  /** BR National ID RG */
  BRNationalIDRG: "BRNationalIDRG",

  /** BG Uniform Civil Number */
  BGUniformCivilNumber: "BGUniformCivilNumber",

  /** CA Bank Account Number */
  CABankAccountNumber: "CABankAccountNumber",

  /** CA Driver's License Number */
  CADriversLicenseNumber: "CADriversLicenseNumber",

  /** CA Health Service Number */
  CAHealthServiceNumber: "CAHealthServiceNumber",

  /** CA Passport Number */
  CAPassportNumber: "CAPassportNumber",

  /** CA Personal Health Identification */
  CAPersonalHealthIdentification: "CAPersonalHealthIdentification",

  /** CA Social Insurance Number */
  CASocialInsuranceNumber: "CASocialInsuranceNumber",

  /** CL Identity Card Number */
  CLIdentityCardNumber: "CLIdentityCardNumber",

  /** CN Resident Identity Card Number */
  CNResidentIdentityCardNumber: "CNResidentIdentityCardNumber",

  /** Credit Card Number */
  CreditCardNumber: "CreditCardNumber",

  /** HR Identity Card Number */
  HRIdentityCardNumber: "HRIdentityCardNumber",

  /** HR National ID Number */
  HRNationalIDNumber: "HRNationalIDNumber",

  /** HR Personal Identification Number */
  HRPersonalIdentificationNumber: "HRPersonalIdentificationNumber",

  /** HR Personal Identification OIB Number V2 */
  HRPersonalIdentificationOIBNumberV2: "HRPersonalIdentificationOIBNumberV2",

  /** CY Identity Card */
  CYIdentityCard: "CYIdentityCard",

  /** CY Tax Identification Number */
  CYTaxIdentificationNumber: "CYTaxIdentificationNumber",

  /** CZ Personal Identity Number */
  CZPersonalIdentityNumber: "CZPersonalIdentityNumber",

  /** CZ Personal Identity V2 */
  CZPersonalIdentityV2: "CZPersonalIdentityV2",

  /** DK Personal Identification Number */
  DKPersonalIdentificationNumber: "DKPersonalIdentificationNumber",

  /** DK Personal Identification V2 */
  DKPersonalIdentificationV2: "DKPersonalIdentificationV2",

  /** Drug Enforcement Agency Number */
  DrugEnforcementAgencyNumber: "DrugEnforcementAgencyNumber",

  /** EE Personal Identification Code */
  EEPersonalIdentificationCode: "EEPersonalIdentificationCode",

  /** EU Debit Card Number */
  EUDebitCardNumber: "EUDebitCardNumber",

  /** EU Driver's License Number */
  EUDriversLicenseNumber: "EUDriversLicenseNumber",

  /** EU GPS Coordinates */
  EUGPSCoordinates: "EUGPSCoordinates",

  /** EU National Identification Number */
  EUNationalIdentificationNumber: "EUNationalIdentificationNumber",

  /** EU Passport Number */
  EUPassportNumber: "EUPassportNumber",

  /** EU Social Security Number */
  EUSocialSecurityNumber: "EUSocialSecurityNumber",

  /** EU Tax Identification Number */
  EUTaxIdentificationNumber: "EUTaxIdentificationNumber",

  /** FI European Health Number */
  FIEuropeanHealthNumber: "FIEuropeanHealthNumber",

  /** FI National ID */
  FINationalID: "FINationalID",

  /** FI National ID V2 */
  FINationalIDV2: "FINationalIDV2",

  /** FI Passport Number */
  FIPassportNumber: "FIPassportNumber",

  /** FR Driver's License Number */
  FRDriversLicenseNumber: "FRDriversLicenseNumber",

  /** FR Health Insurance Number */
  FRHealthInsuranceNumber: "FRHealthInsuranceNumber",

  /** FR National ID */
  FRNationalID: "FRNationalID",

  /** FR Passport Number */
  FRPassportNumber: "FRPassportNumber",

  /** FR Social Security Number */
  FRSocialSecurityNumber: "FRSocialSecurityNumber",

  /** FR Tax Identification Number */
  FRTaxIdentificationNumber: "FRTaxIdentificationNumber",

  /** FR Value Added Tax Number */
  FRValueAddedTaxNumber: "FRValueAddedTaxNumber",

  /** DE Driver's License Number */
  DEDriversLicenseNumber: "DEDriversLicenseNumber",

  /** DE Passport Number */
  DEPassportNumber: "DEPassportNumber",

  /** DE Identity Card Number */
  DEIdentityCardNumber: "DEIdentityCardNumber",

  /** DE Tax Identification Number */
  DETaxIdentificationNumber: "DETaxIdentificationNumber",

  /** DE Value Added Number */
  DEValueAddedNumber: "DEValueAddedNumber",

  /** GR National ID Card */
  GRNationalIDCard: "GRNationalIDCard",

  /** GR National ID V2 */
  GRNationalIDV2: "GRNationalIDV2",

  /** GR Tax Identification Number */
  GRTaxIdentificationNumber: "GRTaxIdentificationNumber",

  /** HK Identity Card Number */
  HKIdentityCardNumber: "HKIdentityCardNumber",

  /** HU Value Added Number */
  HUValueAddedNumber: "HUValueAddedNumber",

  /** HU Personal Identification Number */
  HUPersonalIdentificationNumber: "HUPersonalIdentificationNumber",

  /** HU Tax Identification Number */
  HUTaxIdentificationNumber: "HUTaxIdentificationNumber",

  /** IN Permanent Account */
  INPermanentAccount: "INPermanentAccount",

  /** IN Unique Identification Number */
  INUniqueIdentificationNumber: "INUniqueIdentificationNumber",

  /** ID Identity Card Number */
  IDIdentityCardNumber: "IDIdentityCardNumber",

  /** International Banking Account Number */
  InternationalBankingAccountNumber: "InternationalBankingAccountNumber",

  /** IE Personal Public Service Number */
  IEPersonalPublicServiceNumber: "IEPersonalPublicServiceNumber",

  /** IE Personal Public Service Number V2 */
  IEPersonalPublicServiceNumberV2: "IEPersonalPublicServiceNumberV2",

  /** IL Bank Account Number */
  ILBankAccountNumber: "ILBankAccountNumber",

  /** IL National ID */
  ILNationalID: "ILNationalID",

  /** IT Driver's License Number */
  ITDriversLicenseNumber: "ITDriversLicenseNumber",

  /** IT Fiscal Code */
  ITFiscalCode: "ITFiscalCode",

  /** IT Value Added Tax Number */
  ITValueAddedTaxNumber: "ITValueAddedTaxNumber",

  /** JP Bank Account Number */
  JPBankAccountNumber: "JPBankAccountNumber",

  /** JP Driver's License Number */
  JPDriversLicenseNumber: "JPDriversLicenseNumber",

  /** JP Passport Number */
  JPPassportNumber: "JPPassportNumber",

  /** JP Resident Registration Number */
  JPResidentRegistrationNumber: "JPResidentRegistrationNumber",

  /** JP Social Insurance Number */
  JPSocialInsuranceNumber: "JPSocialInsuranceNumber",

  /** JP My Number Corporate */
  JPMyNumberCorporate: "JPMyNumberCorporate",

  /** JP My Number Personal */
  JPMyNumberPersonal: "JPMyNumberPersonal",

  /** JP Residence Card Number */
  JPResidenceCardNumber: "JPResidenceCardNumber",

  /** LV Personal Code */
  LVPersonalCode: "LVPersonalCode",

  /** LT Personal Code */
  LTPersonalCode: "LTPersonalCode",

  /** LU National Identification Number Natural */
  LUNationalIdentificationNumberNatural: "LUNationalIdentificationNumberNatural",

  /** LU National Identification Number Non Natural */
  LUNationalIdentificationNumberNonNatural: "LUNationalIdentificationNumberNonNatural",

  /** MY Identity Card Number */
  MYIdentityCardNumber: "MYIdentityCardNumber",

  /** MT Identity Card Number */
  MTIdentityCardNumber: "MTIdentityCardNumber",

  /** MT Tax ID Number */
  MTTaxIDNumber: "MTTaxIDNumber",

  /** NL Citizens Service Number */
  NLCitizensServiceNumber: "NLCitizensServiceNumber",

  /** NL Citizens Service Number V2 */
  NLCitizensServiceNumberV2: "NLCitizensServiceNumberV2",

  /** NL Tax Identification Number */
  NLTaxIdentificationNumber: "NLTaxIdentificationNumber",

  /** NL Value Added Tax Number */
  NLValueAddedTaxNumber: "NLValueAddedTaxNumber",

  /** NZ Bank Account Number */
  NZBankAccountNumber: "NZBankAccountNumber",

  /** NZ Driver's License Number */
  NZDriversLicenseNumber: "NZDriversLicenseNumber",

  /** NZ Inland Revenue Number */
  NZInlandRevenueNumber: "NZInlandRevenueNumber",

  /** NZ Ministry Of Health Number */
  NZMinistryOfHealthNumber: "NZMinistryOfHealthNumber",

  /** NZ Social Welfare Number */
  NZSocialWelfareNumber: "NZSocialWelfareNumber",

  /** NO Identity Number */
  NOIdentityNumber: "NOIdentityNumber",

  /** PH Unified Multi Purpose ID Number */
  PHUnifiedMultiPurposeIDNumber: "PHUnifiedMultiPurposeIDNumber",

  /** PL Identity Card */
  PLIdentityCard: "PLIdentityCard",

  /** PL National ID */
  PLNationalID: "PLNationalID",

  /** PL National ID V2 */
  PLNationalIDV2: "PLNationalIDV2",

  /** PL Passport Number */
  PLPassportNumber: "PLPassportNumber",

  /** PL Tax Identification Number */
  PLTaxIdentificationNumber: "PLTaxIdentificationNumber",

  /** PL REGON Number */
  PLREGONNumber: "PLREGONNumber",

  /** PT Citizen Card Number */
  PTCitizenCardNumber: "PTCitizenCardNumber",

  /** PT Citizen Card Number V2 */
  PTCitizenCardNumberV2: "PTCitizenCardNumberV2",

  /** PT Tax Identification Number */
  PTTaxIdentificationNumber: "PTTaxIdentificationNumber",

  /** RO Personal Numerical Code */
  ROPersonalNumericalCode: "ROPersonalNumericalCode",

  /** RU Passport Number Domestic */
  RUPassportNumberDomestic: "RUPassportNumberDomestic",

  /** RU Passport Number International */
  RUPassportNumberInternational: "RUPassportNumberInternational",

  /** SA National ID */
  SANationalID: "SANationalID",

  /** SG National Registration Identity Card Number */
  SGNationalRegistrationIdentityCardNumber: "SGNationalRegistrationIdentityCardNumber",

  /** SK Personal Number */
  SKPersonalNumber: "SKPersonalNumber",

  /** SI Tax Identification Number */
  SITaxIdentificationNumber: "SITaxIdentificationNumber",

  /** SI Unique Master Citizen Number */
  SIUniqueMasterCitizenNumber: "SIUniqueMasterCitizenNumber",

  /** ZA Identification Number */
  ZAIdentificationNumber: "ZAIdentificationNumber",

  /** KR Resident Registration Number */
  KRResidentRegistrationNumber: "KRResidentRegistrationNumber",

  /** ES DNI */
  ESDNI: "ESDNI",

  /** ES Social Security Number */
  ESSocialSecurityNumber: "ESSocialSecurityNumber",

  /** ES Tax Identification Number */
  ESTaxIdentificationNumber: "ESTaxIdentificationNumber",

  /** SQL Server Connection String */
  SQLServerConnectionString: "SQLServerConnectionString",

  /** SE National ID */
  SENationalID: "SENationalID",

  /** SE National ID V2 */
  SENationalIDV2: "SENationalIDV2",

  /** SE Passport Number */
  SEPassportNumber: "SEPassportNumber",

  /** SE Tax Identification Number */
  SETaxIdentificationNumber: "SETaxIdentificationNumber",

  /** SWIFT Code */
  SWIFTCode: "SWIFTCode",

  /** CH Social Security Number */
  CHSocialSecurityNumber: "CHSocialSecurityNumber",

  /** TW National ID */
  TWNationalID: "TWNationalID",

  /** TW Passport Number */
  TWPassportNumber: "TWPassportNumber",

  /** TW Resident Certificate */
  TWResidentCertificate: "TWResidentCertificate",

  /** TH Population Identification Code */
  THPopulationIdentificationCode: "THPopulationIdentificationCode",

  /** TR National Identification Number */
  TRNationalIdentificationNumber: "TRNationalIdentificationNumber",

  /** UK Driver's License Number */
  UKDriversLicenseNumber: "UKDriversLicenseNumber",

  /** UK Electoral Roll Number */
  UKElectoralRollNumber: "UKElectoralRollNumber",

  /** UK National Health Number */
  UKNationalHealthNumber: "UKNationalHealthNumber",

  /** UK National Insurance Number */
  UKNationalInsuranceNumber: "UKNationalInsuranceNumber",

  /** UK Unique Taxpayer Number */
  UKUniqueTaxpayerNumber: "UKUniqueTaxpayerNumber",

  /** US UK Passport Number */
  USUKPassportNumber: "USUKPassportNumber",

  /** US Bank Account Number */
  USBankAccountNumber: "USBankAccountNumber",

  /** US Driver's License Number */
  USDriversLicenseNumber: "USDriversLicenseNumber",

  /** US Individual Taxpayer Identification */
  USIndividualTaxpayerIdentification: "USIndividualTaxpayerIdentification",

  /** US Social Security Number */
  USSocialSecurityNumber: "USSocialSecurityNumber",

  /** UA Passport Number Domestic */
  UAPassportNumberDomestic: "UAPassportNumberDomestic",

  /** UA Passport Number International */
  UAPassportNumberInternational: "UAPassportNumberInternational",

  /** Organization */
  Organization: "Organization",

  /** Email */
  Email: "Email",

  /** URL */
  URL: "URL",

  /** Age */
  Age: "Age",

  /** Phone Number */
  PhoneNumber: "PhoneNumber",

  /** IP Address */
  IPAddress: "IPAddress",

  /** Date */
  Date: "Date",

  /** Person */
  Person: "Person",

  /** Address */
  Address: "Address",

  /** Date Of Birth */
  @added(Versions.v2025_05_15_preview)
  DateOfBirth: "DateOfBirth",

  /** Bank Account Number */
  @added(Versions.v2025_05_15_preview)
  BankAccountNumber: "BankAccountNumber",

  /** Passport Number */
  @added(Versions.v2025_05_15_preview)
  PassportNumber: "PassportNumber",

  /** Drivers License Number */
  @added(Versions.v2025_05_15_preview)
  DriversLicenseNumber: "DriversLicenseNumber",

  /** Neighborhood */
  @added(Versions.v2025_05_15_preview)
  Neighborhood: "Neighborhood",

  /** Sort Code. 6-digit number used in the UK to identify a specific bank and branch where a bank account is held */
  @added(Versions.v2025_05_15_preview)
  SortCode: "SortCode",

  /** PIN */
  @added(Versions.v2025_05_15_preview)
  PIN: "PIN",

  /** VIN */
  @added(Versions.v2025_05_15_preview)
  VIN: "VIN",

  /** License Plate */
  @added(Versions.v2025_05_15_preview)
  LicensePlate: "LicensePlate",
}
