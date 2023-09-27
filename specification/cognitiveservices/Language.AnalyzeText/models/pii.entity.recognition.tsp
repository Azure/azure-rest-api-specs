
import "@typespec/rest";
import "@typespec/http";
import "../common.tsp";
import "./entity.recognition.tsp";
import "./common.models.tsp";

namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextPiiEntitiesRecognitionInput extends AnalyzeTextTask{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskKind.PiiEntityRecognition;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  analysisInput?: MultiLanguageAnalysisInput;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: PiiTaskParameters;
}

@doc("Supported parameters for a PII Entities Recognition task.")
model PiiTaskParameters extends PreBuiltTaskParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  domain?: PiiDomain = PiiDomain.none;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  piiCategories?: Array<PiiCategories>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType?: StringIndexType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model PiiLroTask extends AnalyzeTextLroTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroTaskKind.PiiEntityRecognition;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: PiiTaskParameters;

}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model PiiTaskResult extends AnalyzeTextTaskResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskResultsKind.PiiEntityRecognitionResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: PiiResult;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model PiiResult extends AnalyzeTextPreBuiltResult {
  @doc("Response by document")
  documents: Array<PiiEntitiesDocumentResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum PiiDomain {
  @doc("Indicates that entities in the Personal Health Information domain should be redacted.")
  phi,

  @doc("Indicates that no domain is specified.")
  none
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model PiiEntitiesDocumentResult {
  @doc("Returns redacted text.")
  redactedText: string;

  @doc("Recognized entities in the document.")
  entities: Array<Entity>;
}

@doc("(Optional) describes the PII categories to return")
enum PiiCategories {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ABARoutingNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ARNationalIdentityNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUBankAccountNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUDriversLicenseNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUMedicalAccountNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUPassportNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUTaxFileNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUBusinessNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AUCompanyNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ATIdentityCard,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ATTaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ATValueAddedTaxNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureDocumentDBAuthKey,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureIAASDatabaseConnectionAndSQLString,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureIoTConnectionString,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzurePublishSettingPassword,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureRedisCacheString,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureSAS,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureServiceBusString,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureStorageAccountKey,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AzureStorageAccountGeneric,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BENationalNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BENationalNumberV2,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BEValueAddedTaxNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BRCPFNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BRLegalEntityNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BRNationalIDRG,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  BGUniformCivilNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CABankAccountNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CADriversLicenseNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CAHealthServiceNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CAPassportNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CAPersonalHealthIdentification,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CASocialInsuranceNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CLIdentityCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CNResidentIdentityCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CreditCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HRIdentityCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HRNationalIDNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HRPersonalIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HRPersonalIdentificationOIBNumberV2,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CYIdentityCard,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CYTaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CZPersonalIdentityNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CZPersonalIdentityV2,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DKPersonalIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DKPersonalIdentificationV2,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DrugEnforcementAgencyNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EEPersonalIdentificationCode,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUDebitCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUDriversLicenseNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUGPSCoordinates,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUNationalIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUPassportNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUSocialSecurityNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EUTaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FIEuropeanHealthNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FINationalID,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FINationalIDV2,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FIPassportNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRDriversLicenseNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRHealthInsuranceNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRNationalID,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRPassportNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRSocialSecurityNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRTaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  FRValueAddedTaxNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DEDriversLicenseNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DEPassportNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DEIdentityCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DETaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DEValueAddedNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  GRNationalIDCard,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  GRNationalIDV2,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  GRTaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HKIdentityCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HUValueAddedNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HUPersonalIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HUTaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  INPermanentAccount,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  INUniqueIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  IDIdentityCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  InternationalBankingAccountNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  IEPersonalPublicServiceNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  IEPersonalPublicServiceNumberV2,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ILBankAccountNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ILNationalID,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ITDriversLicenseNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ITFiscalCode,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ITValueAddedTaxNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPBankAccountNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPDriversLicenseNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPPassportNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPResidentRegistrationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPSocialInsuranceNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPMyNumberCorporate,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPMyNumberPersonal,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  JPResidenceCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LVPersonalCode,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LTPersonalCode,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LUNationalIdentificationNumberNatural,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LUNationalIdentificationNumberNonNatural,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MYIdentityCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MTIdentityCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  MTTaxIDNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NLCitizensServiceNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NLCitizensServiceNumberV2,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NLTaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NLValueAddedTaxNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZBankAccountNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZDriversLicenseNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZInlandRevenueNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZMinistryOfHealthNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NZSocialWelfareNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NOIdentityNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PHUnifiedMultiPurposeIDNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLIdentityCard,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLNationalID,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLNationalIDV2,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLPassportNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLTaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PLREGONNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PTCitizenCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PTCitizenCardNumberV2,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PTTaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ROPersonalNumericalCode,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RUPassportNumberDomestic,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RUPassportNumberInternational,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SANationalID,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SGNationalRegistrationIdentityCardNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SKPersonalNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SITaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SIUniqueMasterCitizenNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ZAIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KRResidentRegistrationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ESDNI,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ESSocialSecurityNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ESTaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SQLServerConnectionString,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SENationalID,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SENationalIDV2,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SEPassportNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SETaxIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SWIFTCode,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CHSocialSecurityNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TWNationalID,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TWPassportNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TWResidentCertificate,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  THPopulationIdentificationCode,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TRNationalIdentificationNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKDriversLicenseNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKElectoralRollNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKNationalHealthNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKNationalInsuranceNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UKUniqueTaxpayerNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USUKPassportNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USBankAccountNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USDriversLicenseNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USIndividualTaxpayerIdentification,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USSocialSecurityNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UAPassportNumberDomestic,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  UAPassportNumberInternational,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Organization,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Email,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  URL,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Age,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PhoneNumber,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  IPAddress,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Date,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Person,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Address,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  All,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Default
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model PiiEntityRecognitionLroResult extends AnalyzeTextLroResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroResultsKind.PiiEntityRecognitionLroResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: PiiResult;
}