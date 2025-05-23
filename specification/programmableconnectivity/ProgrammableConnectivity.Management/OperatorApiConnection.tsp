import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProgrammableConnectivity;
/**
 * A Programmable Connectivity Operator API Connection resource
 */
model OperatorApiConnection
  is Azure.ResourceManager.TrackedResource<OperatorApiConnectionProperties> {
  /**
   * Azure Programmable Connectivity (APC) Operator API Connection Name.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("operatorApiConnectionName")
  @segment("operatorApiConnections")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;
}

/**
 * Operator API Connection resource properties that cannot be updated once a resource has been created.
 */
model OperatorApiConnectionProperties {
  /**
   * Reference to the Operator API Plan Resource ID.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  operatorApiPlanId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ProgrammableConnectivity/operatorApiPlans";
    }
  ]>;

  /**
   * Details about the SaaS offer purchased from the marketplace.
   */
  @TypeSpec.Versioning.removed(Versions.v2025_03_30_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  saasProperties?: SaasProperties;

  /**
   * Details about the Application that would use the Operator's Network APIs.
   */
  @TypeSpec.Versioning.removed(Versions.v2025_03_30_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  configuredApplication?: ApplicationProperties;

  /**
   * Application ID of the App Developer that is registered with the Operator in a specific country/region.
   */
  @TypeSpec.Versioning.removed(Versions.v2025_03_30_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  appId?: string;

  /**
   * Reference to the APC Gateway resource ID.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  gatewayId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ProgrammableConnectivity/gateways";
    }
  ]>;

  /**
   * Type of the account the user has with the Operator's Network API infrastructure. AzureManaged | UserManaged.
   */
  @TypeSpec.Versioning.removed(Versions.v2025_03_30_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  accountType: AccountType;

  /**
   * Application secret linked to the 'appId'. This should be stored securely and is not returned back when the resource information is read.
   */
  @TypeSpec.Versioning.removed(Versions.v2025_03_30_preview)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  appSecret?: string;

  /**
   * Name of the Operator in the linked Operator API Plan belongs to.
   */
  @visibility(Lifecycle.Read)
  operatorName?: string;

  /**
   * The Network API for the current operator in the country/region provided in the linked Operator API Plan.
   */
  @visibility(Lifecycle.Read)
  camaraApiName?: string;

  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The status of the OperatorApiConnection resource.
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * Whether the caller has accepted the Terms and Conditions of the associated Operator API Plan.
   * After creation, the planTermsAndConditionsLink property is set to the Terms and Conditions that
   * have been accepted.
   *
   * Must be set to True, as the Terms and Conditions must be accepted.
   */
  @TypeSpec.Versioning.added(Versions.v2025_03_30_preview)
  planTermsAndConditionsAccepted: boolean;

  /**
   * Links to the Terms and Conditions of the Operator API Plan that were accepted on creation.
   */
  @TypeSpec.Versioning.added(Versions.v2025_03_30_preview)
  @visibility(Lifecycle.Read)
  planTermsAndConditionsLinks?: string[];

  /**
   * The purpose for which the Application will use the API. Max Items 1 currently as Operators do not support multiple.
   */
  @TypeSpec.Versioning.added(Versions.v2025_03_30_preview)
  @maxItems(1)
  purposes: Purpose[];

  /**
   * Explanation of the reason that justifies the purpose: specifically why is the API used for the application's use case.
   */
  @TypeSpec.Versioning.added(Versions.v2025_03_30_preview)
  purposeReason: string;

  /**
   * List of ways the data returned on this API is processed.
   */
  @TypeSpec.Versioning.added(Versions.v2025_03_30_preview)
  @OpenAPI.extension("x-ms-identifiers", #["processingOperation"])
  dataProcessingList: DataProcessing[];
}

/**
 * The Account Type of the Operator API Connections.
 */
@TypeSpec.Versioning.removed(Versions.v2025_03_30_preview)
union AccountType {
  /**
   * Managed by Azure on-behalf-of the user.
   */
  AzureManaged: "AzureManaged",

  /**
   * Managed by the User themselves on the Operator end.
   */
  UserManaged: "UserManaged",

  string,
}

/**
 * Model defining how received data is processed.
 */
@TypeSpec.Versioning.added(Versions.v2025_03_30_preview)
model DataProcessing {
  /**
   *  The operation that is performed on the data received.
   */
  processingOperation: ProcessingOperation;

  /**
   * The contexts in which the data is processed.
   */
  contexts: Context[];

  /**
   * The duration or temporal limitation of the data processing.
   */
  duration: Duration;

  /**
   * The frequency of the data processing.
   */
  frequency: Frequency;

  /**
   * The countries/regions the data transits through.
   */
  @OpenAPI.extension("x-ms-identifiers", #["countryCode"])
  transitRegions: DataRegions[];

  /**
   * The countries/regions the data is stored in.
   */
  @OpenAPI.extension("x-ms-identifiers", #["countryCode"])
  storageRegions: DataRegions[];
}

/**
 * Model defining the information required about the countries/regions the data transits through or is stored in.
 */
@TypeSpec.Versioning.added(Versions.v2025_03_30_preview)
model DataRegions {
  /**
   * The country code of the country/region the data transits through or is stored in.
   */
  @pattern("[A-Z]{2}", "Provide 2 letter country code")
  countryCode: string;

  /**
   * The commercial organization who is managing the data.
   */
  commercialOrganization?: string;

  /**
   * Flag to indicate if commercial activity applies to this data management.
   */
  commercialActivity: boolean;

  /**
   * URL of the organization or governmental data privacy framework.
   */
  dataPrivacyFrameworkUrl: url;
}

/**
 * Valid values for the frequency based on W3C Data Privacy Vocabulary v2 https://w3c.github.io/dpv/2.0/dpv/.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@TypeSpec.Versioning.added(Versions.v2025_03_30_preview)
union Frequency {
  continuousFrequency: "Continuous",
  oftenFrequency: "Often",
  singularFrequency: "Singular",
  sporadicFrequency: "Sporadic",
  string,
}

/**
 * Valid values for the duration based on W3C Data Privacy Vocabulary v2 https://w3c.github.io/dpv/2.0/dpv/.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@TypeSpec.Versioning.added(Versions.v2025_03_30_preview)
union Duration {
  endlessDuration: "Endless",
  fixedOccurrencesDuration: "Fixed occurrences",
  indeterminateDuration: "Indeterminate",
  temporalDuration: "Temporal",
  untilEventDuration: "Until event",
  untilTimeDuration: "Until time",
  string,
}

/**
 * Valid values for the context based on W3C Data Privacy Vocabulary v2 https://w3c.github.io/dpv/2.0/dpv/.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@TypeSpec.Versioning.added(Versions.v2025_03_30_preview)
union Context {
  algorithmicLogic: "Algorithmic logic",
  assistiveAutomation: "Assistive automation",
  automatedDecisionMaking: "Automated decision making",
  automatedScoringOfIndividuals: "Automated scoring of individuals",
  automationLevel: "Automation level",
  autonomous: "Autonomous",
  cannotChallengeProcess: "Cannot challenge process",
  cannotChallengeProcessInput: "Cannot challenge process input",
  cannotChallengeProcessOutput: "Cannot challenge process output",
  cannotCorrectProcess: "Cannot correct process",
  cannotCorrectProcessInput: "Cannot correct process input",
  cannotCorrectProcessOutput: "Cannot correct process output",
  cannotObjectToProcess: "Cannot object to process",
  cannotOptInToProcess: "Cannot opt in to process",
  cannotOptOutFromProcess: "Cannot opt out from process",
  cannotReverseProcessEffects: "Cannot reverse process effects",
  cannotReverseProcessInput: "Cannot reverse process input",
  cannotReverseProcessOutput: "Cannot reverse process output",
  cannotWithdrawFromProcess: "Cannot withdraw from process",
  challengingProcess: "Challenging process",
  challengingProcessInput: "Challenging process input",
  challengingProcessOutput: "Challenging process output",
  conditionalAutomation: "Conditional automation",
  consentControl: "Consent control",
  correctingProcess: "Correcting process",
  correctingProcessInput: "Correcting process input",
  correctingProcessOutput: "Correcting process output",
  completelyManualProcessing: "Completely manual processing",
  dataControllerDataSource: "Data controller data source",
  dataPublishedByDataSubject: "Data published by data subject",
  dataSource: "Data source",
  dataSubject: "Data subject",
  dataSubjectDataSource: "Data subject data source",
  dataSubjectScale: "Data subject scale",
  dataVolume: "Data volume",
  decisionMaking: "Decision making",
  entityActiveInvolvement: "Entity active involvement",
  entityInvolvement: "Entity involvement",
  entityNonInvolvement: "Entity non involvement",
  entityNonPermissiveInvolvement: "Entity non permissive involvement",
  entityPassiveInvolvement: "Entity passive involvement",
  entityPermissiveInvolvement: "Entity permissive involvement",
  evaluationOfIndividuals: "Evaluation of individuals",
  evaluationScoring: "Evaluation scoring",
  fullAutomation: "Full automation",
  geographicCoverage: "Geographic coverage",
  globalScale: "Global scale",
  highAutomation: "High automation",
  hugeDataVolume: "Huge data volume",
  hugeScaleOfDataSubjects: "Huge scale of data subjects",
  humanInvolved: "Human involved",
  humanInvolvement: "Human involvement",
  humanInvolvementForControl: "Human involvement for control",
  humanInvolvementForDecision: "Human involvement for decision",
  humanInvolvementForInput: "Human involvement for input",
  humanInvolvementForIntervention: "Human involvement for intervention",
  humanInvolvementForOversight: "Human involvement for oversight",
  humanInvolvementForVerification: "Human involvement for verification",
  humanNotInvolved: "Human not involved",
  innovativeUseOfExistingTechnology: "Innovative use of existing technology",
  innovativeUseOfNewTechnologies: "Innovative use of new technologies",
  innovativeUseOfTechnology: "Innovative use of technology",
  largeDataVolume: "Large data volume",
  largeScaleOfDataSubjects: "Large scale of data subjects",
  largeScaleProcessing: "Large scale processing",
  localEnvironmentScale: "Local environment scale",
  localityScale: "Locality scale",
  mediumDataVolume: "Medium data volume",
  mediumScaleOfDataSubjects: "Medium scale of data subjects",
  mediumScaleProcessing: "Medium scale processing",
  multiNationalScale: "Multi national scale",
  nationalScale: "National scale",
  nearlyGlobalScale: "Nearly global scale",
  nonPublicDataSource: "Non public data source",
  notAutomated: "Not automated",
  objectingToProcess: "Objecting to process",
  obtainConsent: "Obtain consent",
  optingInToProcess: "Opting in to process",
  optingOutFromProcess: "Opting out from process",
  partialAutomation: "Partial automation",
  processingCondition: "Processing condition",
  processingDuration: "Processing duration",
  processingLocation: "Processing location",
  processingScale: "Processing scale",
  provideConsent: "Provide consent",
  publicDataSource: "Public data source",
  reaffirmConsent: "Reaffirm consent",
  regionalScale: "Regional scale",
  reversingProcessEffects: "Reversing process effects",
  reversingProcessInput: "Reversing process input",
  reversingProcessOutput: "Reversing process output",
  scale: "Scale",
  scoringOfIndividuals: "Scoring of individuals",
  singularDataVolume: "Singular data volume",
  singularScaleOfDataSubjects: "Singular scale of data subjects",
  smallDataVolume: "Small data volume",
  smallScaleOfDataSubjects: "Small scale of data subjects",
  smallScaleProcessing: "Small scale processing",
  sporadicDataVolume: "Sporadic data volume",
  sporadicScaleOfDataSubjects: "Sporadic scale of data subjects",
  storageCondition: "Storage condition",
  storageDeletion: "Storage deletion",
  storageDuration: "Storage duration",
  storageLocation: "Storage location",
  storageRestoration: "Storage restoration",
  systematicMonitoring: "Systematic monitoring",
  thirdPartyDataSource: "Third party data source",
  withdrawConsent: "Withdraw consent",
  withdrawingFromProcess: "Withdrawing from process",
  string,
}

/**
 * Valid values for the processing operation based on W3C Data Privacy Vocabulary v2 https://w3c.github.io/dpv/2.0/dpv/.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@TypeSpec.Versioning.added(Versions.v2025_03_30_preview)
union ProcessingOperation {
  access: "Access",
  acquire: "Acquire",
  adapt: "Adapt",
  aggregate: "Aggregate",
  align: "Align",
  alter: "Alter",
  analyze: "Analyze",
  anonymize: "Anonymize",
  assess: "Assess",
  collect: "Collect",
  combine: "Combine",
  consult: "Consult",
  copy: "Copy",
  crossBorderTransfer: "Cross border transfer",
  delete: "Delete",
  derive: "Derive",
  destruct: "Destruct",
  disclose: "Disclose",
  discloseByTransmission: "Disclose by transmission",
  display: "Display",
  disseminate: "Disseminate",
  download: "Download",
  erase: "Erase",
  export: "Export",
  filter: "Filter",
  format: "Format",
  generate: "Generate",
  infer: "Infer",
  makeAvailable: "Make available",
  match: "Match",
  modify: "Modify",
  monitor: "Monitor",
  move: "Move",
  observe: "Observe",
  obtain: "Obtain",
  organize: "Organize",
  profiling: "Profiling",
  pseudonymize: "Pseudonymize",
  query: "Query",
  record: "Record",
  reformat: "Reformat",
  remove: "Remove",
  restrict: "Restrict",
  retrieve: "Retrieve",
  screen: "Screen",
  share: "Share",
  store: "Store",
  structure: "Structure",
  transfer: "Transfer",
  transform: "Transform",
  transmit: "Transmit",
  use: "Use",
  string,
}

/**
 * Valid values for the purpose based on W3C Data Privacy Vocabulary v2 https://w3c.github.io/dpv/2.0/dpv/.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@TypeSpec.Versioning.added(Versions.v2025_03_30_preview)
union Purpose {
  academicResearch: "Academic Research",
  accountManagement: "Account Management",
  advertising: "Advertising",
  ageVerification: "Age Verification",
  combatClimateChange: "Combat Climate Change",
  commercialPurpose: "Commercial Purpose",
  commercialResearch: "Commercial Research",
  communicationForCustomerCare: "Communication For Customer Care",
  communicationManagement: "Communication Management",
  counterMoneyLaundering: "Counter Money Laundering",
  counterterrorism: "Counter-terrorism",
  creditChecking: "Credit Checking",
  customerCare: "Customer Care",
  customerClaimsManagement: "Customer Claims Management",
  customerManagement: "Customer Management",
  customerOrderManagement: "Customer Order Management",
  customerRelationshipManagement: "Customer Relationship Management",
  customerSolvencyMonitoring: "Customer Solvency Monitoring",
  dataAltruism: "Data Altruism",
  deliveryOfGoods: "Delivery Of Goods",
  directMarketing: "Direct Marketing",
  disputeManagement: "Dispute Management",
  enforceAccessControl: "Enforce Access Control",
  enforceSecurity: "Enforce Security",
  establishContractualAgreement: "Establish Contractual Agreement",
  fraudPreventionAndDetection: "Fraud Prevention And Detection",
  fulfillmentOfContractualObligation: "Fulfillment Of Contractual Obligation",
  fulfillmentOfObligation: "Fulfillment Of Obligation",
  humanResourceManagement: "Human Resource Management",
  identityAuthentication: "Identity Authentication",
  identityVerification: "Identity Verification",
  improveExistingProductsAndServices: "Improve Existing Products And Services",
  improveHealthcare: "Improve Healthcare",
  improveInternalCRMProcesses: "Improve Internal CRM Processes",
  improvePublicServices: "Improve Public Services",
  improveTransportMobility: "Improve Transport Mobility",
  increaseServiceRobustness: "Increase Service Robustness",
  internalResourceOptimization: "Internal Resource Optimization",
  legalCompliance: "Legal Compliance",
  maintainCreditCheckingDatabase: "Maintain Credit Checking Database",
  maintainCreditRatingDatabase: "Maintain Credit Rating Database",
  maintainFraudDatabase: "Maintain Fraud Database",
  marketing: "Marketing",
  memberPartnerManagement: "Member Partner Management",
  misusePreventionAndDetection: "Misuse Prevention And Detection",
  nonCommercialPurpose: "Non Commercial Purpose",
  nonCommercialResearch: "Non Commercial Research",
  optimizationForConsumer: "Optimization For Consumer",
  optimizationForController: "Optimization For Controller",
  optimizeUserInterface: "Optimize User Interface",
  organizationComplianceManagement: "Organization Compliance Management",
  organizationGovernance: "Organization Governance",
  organizationRiskManagement: "Organization Risk Management",
  paymentManagement: "Payment Management",
  personalization: "Personalization",
  personalizedAdvertising: "Personalized Advertising",
  personalizedBenefits: "Personalized Benefits",
  personnelHiring: "Personnel Hiring",
  personnelManagement: "Personnel Management",
  personnelPayment: "Personnel Payment",
  protectionOfIPR: "Protection Of IPR",
  protectionOfNationalSecurity: "Protection Of National Security",
  protectionOfPublicSecurity: "Protection Of Public Security",
  provideEventRecommendations: "Provide Event Recommendations",
  provideOfficialStatistics: "Provide Official Statistics",
  providePersonalizedRecommendations: "Provide Personalized Recommendations",
  provideProductRecommendations: "Provide Product Recommendations",
  publicBenefit: "Public Benefit",
  publicPolicyMaking: "Public Policy Making",
  publicRelations: "Public Relations",
  recordManagement: "Record Management",
  repairImpairments: "Repair Impairments",
  requestedServiceProvision: "Requested Service Provision",
  researchAndDevelopment: "Research And Development",
  rightsFulfillment: "Rights Fulfillment",
  scientificResearch: "Scientific Research",
  searchFunctionalities: "Search Functionalities",
  sellDataToThirdParties: "Sell Data To Third Parties",
  sellInsightsFromData: "Sell Insights From Data",
  sellProducts: "Sell Products",
  sellProductsToDataSubject: "Sell Products To Data Subject",
  serviceoptimization: "Service Optimization",
  servicePersonalization: "Service Personalization",
  serviceProvision: "Service Provision",
  serviceRegistration: "Service Registration",
  serviceUsageAnalytics: "Service Usage Analytics",
  socialMediaMarketing: "Social Media Marketing",
  targetedAdvertising: "Targeted Advertising",
  technicalServiceProvision: "Technical Service Provision",
  userInterfacePersonalization: "User Interface Personalization",
  vendorManagement: "Vendor Management",
  vendorPayment: "Vendor Payment",
  vendorRecordsManagement: "Vendor Records Management",
  vendorSelectionAssessment: "Vendor Selection Assessment",
  verification: "Verification",
  string,
}

/**
 * Details about the SaaS offer purchased from the marketplace.
 */
model SaasProperties {
  /**
   * Subscription ID of the SaaS offer purchased from the marketplace.
   */
  saasSubscriptionId?: string;

  /**
   * Resource ID of the SaaS offer purchased from the marketplace.
   */
  saasResourceId?: string;
}

/**
 * Description of the current status of the OperatorApiConnection resource.
 */
model Status {
  /**
   * Current state of the OperatorApiConnection resource.
   */
  state?: string;

  /**
   * Explanation of the current state of the OperatorApiConnection resource.
   */
  reason?: string;
}

@armResourceOperations
interface OperatorApiConnections {
  /**
   * Get an Operator API Connection.
   */
  get is ArmResourceRead<OperatorApiConnection>;

  /**
   * Create an Operator API Connection.
   */
  create is ArmResourceCreateOrReplaceAsync<OperatorApiConnection>;

  /**
   * Update an Operator API Connection.
   */
  update is ArmCustomPatchAsync<
    OperatorApiConnection,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      OperatorApiConnection,
      OperatorApiConnectionProperties
    >
  >;

  /**
   * Delete an Operator API Connection.
   */
  delete is ArmResourceDeleteWithoutOkAsync<OperatorApiConnection>;

  /**
   * List OperatorApiConnection resources by resource group.
   */
  listByResourceGroup is ArmResourceListByParent<OperatorApiConnection>;

  /**
   * List OperatorApiConnection resources by subscription ID.
   */
  listBySubscription is ArmListBySubscription<OperatorApiConnection>;
}
