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
  @visibility("read", "create")
  name: string;
}

/**
 * Operator API Connection resource properties that cannot be updated once a resource has been created.
 */
model OperatorApiConnectionProperties {
  /**
   * Reference to the Operator API Plan Resource ID.
   */
  @visibility("read", "create", "update")
  operatorApiPlanId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ProgrammableConnectivity/operatorApiPlans";
    }
  ]>;

  /**
   * Details about the SaaS offer purchased from the marketplace.
   */
  @TypeSpec.Versioning.removed(Versions.v2024_11_01_preview)
  @visibility("read", "create", "update")
  saasProperties?: SaasProperties;

  /**
   * Details about the SaaS offer purchased from the Azure Marketplace.
   */
  @TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
  @visibility("read")
  marketplaceSaasProperties?: SaasProperties;

  /**
   * Details about the Application that would use the Operator's Network APIs.
   */
  @TypeSpec.Versioning.removed(Versions.v2024_11_01_preview)
  @visibility("read", "create", "update")
  configuredApplication?: ApplicationProperties;

  /**
   * Application ID of the App Developer that is registered with the Operator in a specific country/region.
   */
  @TypeSpec.Versioning.removed(Versions.v2024_11_01_preview)
  @visibility("read", "create", "update")
  appId?: string;

  /**
   * Reference to the APC Gateway resource ID.
   */
  @visibility("read", "create")
  gatewayId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ProgrammableConnectivity/gateways";
    }
  ]>;

  /**
   * Type of the account the user has with the Operator's Network API infrastructure. AzureManaged | UserManaged.
   */
  @TypeSpec.Versioning.removed(Versions.v2024_11_01_preview)
  @visibility("read", "create")
  accountType: AccountType;

  /**
   * Application secret linked to the 'appId'. This should be stored securely and is not returned back when the resource information is read.
   */
  @TypeSpec.Versioning.removed(Versions.v2024_11_01_preview)
  @visibility("create", "update")
  @secret
  appSecret?: string;

  /**
   * Name of the Operator in the linked Operator API Plan belongs to.
   */
  @visibility("read")
  operatorName?: string;

  /**
   * The Network API for the current operator in the country/region provided in the linked Operator API Plan.
   */
  @visibility("read")
  camaraApiName?: string;

  /**
   * The status of the last operation.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The status of the OperatorApiConnection resource.
   */
  @visibility("read")
  status?: Status;

  /**
   * The purpose for which the Application will use the API. Max Items 1 currently as Operators do not support multiple.
   */
  @TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
  @maxItems(1)
  purposes: Purpose[];

  /**
   * Explanation of the reason that justifies the purpose: specifically why is the API used for the application's use case.
   */
  @TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
  purposeReason: string;

  /**
   * List of ways the data returned on this API is processed.
   */
  @TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
  @OpenAPI.extension("x-ms-identifiers", ["processingOperation"])
  dataProcessingList: DataProcessing[];
}

/**
 * The Account Type of the Operator API Connections.
 */
@TypeSpec.Versioning.removed(Versions.v2024_11_01_preview)
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
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
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
  @OpenAPI.extension("x-ms-identifiers", ["countryCode"])
  transitRegions: DataRegions[];

  /**
   * The countries/regions the data is stored in.
   */
  @OpenAPI.extension("x-ms-identifiers", ["countryCode"])
  storageRegions: DataRegions[];
}

/**
 * Model defining the information required about the countries/regions the data transits through or is stored in.
 */
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
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
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
union Frequency {
  dpvContinuousFrequency: "Continuous",
  dpvOftenFrequency: "Often",
  dpvSingularFrequency: "Singular",
  dpvSporadicFrequency: "Sporadic",
  string,
}

/**
 * Valid values for the duration based on W3C Data Privacy Vocabulary v2 https://w3c.github.io/dpv/2.0/dpv/.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
union Duration {
  dpvEndlessDuration: "Endless",
  dpvFixedOccurrencesDuration: "Fixed occurrences",
  dpvIndeterminateDuration: "Indeterminate",
  dpvTemporalDuration: "Temporal",
  dpvUntilEventDuration: "Until event",
  dpvUntilTimeDuration: "Until time",
  string,
}

/**
 * Valid values for the context based on W3C Data Privacy Vocabulary v2 https://w3c.github.io/dpv/2.0/dpv/.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
union Context {
  dpvAlgorithmicLogic: "Algorithmic logic",
  dpvAssistiveAutomation: "Assistive automation",
  dpvAutomatedDecisionMaking: "Automated decision making",
  dpvAutomatedScoringOfIndividuals: "Automated scoring of individuals",
  dpvAutomationLevel: "Automation level",
  dpvAutonomous: "Autonomous",
  dpvCannotChallengeProcess: "Cannot challenge process",
  dpvCannotChallengeProcessInput: "Cannot challenge process input",
  dpvCannotChallengeProcessOutput: "Cannot challenge process output",
  dpvCannotCorrectProcess: "Cannot correct process",
  dpvCannotCorrectProcessInput: "Cannot correct process input",
  dpvCannotCorrectProcessOutput: "Cannot correct process output",
  dpvCannotObjectToProcess: "Cannot object to process",
  dpvCannotOptInToProcess: "Cannot opt in to process",
  dpvCannotOptOutFromProcess: "Cannot opt out from process",
  dpvCannotReverseProcessEffects: "Cannot reverse process effects",
  dpvCannotReverseProcessInput: "Cannot reverse process input",
  dpvCannotReverseProcessOutput: "Cannot reverse process output",
  dpvCannotWithdrawFromProcess: "Cannot withdraw from process",
  dpvChallengingProcess: "Challenging process",
  dpvChallengingProcessInput: "Challenging process input",
  dpvChallengingProcessOutput: "Challenging process output",
  dpvConditionalAutomation: "Conditional automation",
  dpvConsentControl: "Consent control",
  dpvCorrectingProcess: "Correcting process",
  dpvCorrectingProcessInput: "Correcting process input",
  dpvCorrectingProcessOutput: "Correcting process output",
  dpvCompletelyManualProcessing: "Completely manual processing",
  dpvDataControllerDataSource: "Data controller data source",
  dpvDataPublishedByDataSubject: "Data published by data subject",
  dpvDataSource: "Data source",
  dpvDataSubject: "Data subject",
  dpvDataSubjectDataSource: "Data subject data source",
  dpvDataSubjectScale: "Data subject scale",
  dpvDataVolume: "Data volume",
  dpvDecisionMaking: "Decision making",
  dpvEntityActiveInvolvement: "Entity active involvement",
  dpvEntityInvolvement: "Entity involvement",
  dpvEntityNonInvolvement: "Entity non involvement",
  dpvEntityNonPermissiveInvolvement: "Entity non permissive involvement",
  dpvEntityPassiveInvolvement: "Entity passive involvement",
  dpvEntityPermissiveInvolvement: "Entity permissive involvement",
  dpvEvaluationOfIndividuals: "Evaluation of individuals",
  dpvEvaluationScoring: "Evaluation scoring",
  dpvFullAutomation: "Full automation",
  dpvGeographicCoverage: "Geographic coverage",
  dpvGlobalScale: "Global scale",
  dpvHighAutomation: "High automation",
  dpvHugeDataVolume: "Huge data volume",
  dpvHugeScaleOfDataSubjects: "Huge scale of data subjects",
  dpvHumanInvolved: "Human involved",
  dpvHumanInvolvement: "Human involvement",
  dpvHumanInvolvementForControl: "Human involvement for control",
  dpvHumanInvolvementForDecision: "Human involvement for decision",
  dpvHumanInvolvementForInput: "Human involvement for input",
  dpvHumanInvolvementForIntervention: "Human involvement for intervention",
  dpvHumanInvolvementForOversight: "Human involvement for oversight",
  dpvHumanInvolvementForVerification: "Human involvement for verification",
  dpvHumanNotInvolved: "Human not involved",
  dpvInnovativeUseOfExistingTechnology: "Innovative use of existing technology",
  dpvInnovativeUseOfNewTechnologies: "Innovative use of new technologies",
  dpvInnovativeUseOfTechnology: "Innovative use of technology",
  dpvLargeDataVolume: "Large data volume",
  dpvLargeScaleOfDataSubjects: "Large scale of data subjects",
  dpvLargeScaleProcessing: "Large scale processing",
  dpvLocalEnvironmentScale: "Local environment scale",
  dpvLocalityScale: "Locality scale",
  dpvMediumDataVolume: "Medium data volume",
  dpvMediumScaleOfDataSubjects: "Medium scale of data subjects",
  dpvMediumScaleProcessing: "Medium scale processing",
  dpvMultiNationalScale: "Multi national scale",
  dpvNationalScale: "National scale",
  dpvNearlyGlobalScale: "Nearly global scale",
  dpvNonPublicDataSource: "Non public data source",
  dpvNotAutomated: "Not automated",
  dpvObjectingToProcess: "Objecting to process",
  dpvObtainConsent: "Obtain consent",
  dpvOptingInToProcess: "Opting in to process",
  dpvOptingOutFromProcess: "Opting out from process",
  dpvPartialAutomation: "Partial automation",
  dpvProcessingCondition: "Processing condition",
  dpvProcessingDuration: "Processing duration",
  dpvProcessingLocation: "Processing location",
  dpvProcessingScale: "Processing scale",
  dpvProvideConsent: "Provide consent",
  dpvPublicDataSource: "Public data source",
  dpvReaffirmConsent: "Reaffirm consent",
  dpvRegionalScale: "Regional scale",
  dpvReversingProcessEffects: "Reversing process effects",
  dpvReversingProcessInput: "Reversing process input",
  dpvReversingProcessOutput: "Reversing process output",
  dpvScale: "Scale",
  dpvScoringOfIndividuals: "Scoring of individuals",
  dpvSingularDataVolume: "Singular data volume",
  dpvSingularScaleOfDataSubjects: "Singular scale of data subjects",
  dpvSmallDataVolume: "Small data volume",
  dpvSmallScaleOfDataSubjects: "Small scale of data subjects",
  dpvSmallScaleProcessing: "Small scale processing",
  dpvSporadicDataVolume: "Sporadic data volume",
  dpvSporadicScaleOfDataSubjects: "Sporadic scale of data subjects",
  dpvStorageCondition: "Storage condition",
  dpvStorageDeletion: "Storage deletion",
  dpvStorageDuration: "Storage duration",
  dpvStorageLocation: "Storage location",
  dpvStorageRestoration: "Storage restoration",
  dpvSystematicMonitoring: "Systematic monitoring",
  dpvThirdPartyDataSource: "Third party data source",
  dpvWithdrawConsent: "Withdraw consent",
  dpvWithdrawingFromProcess: "Withdrawing from process",
  string,
}

/**
 * Valid values for the processing operation based on W3C Data Privacy Vocabulary v2 https://w3c.github.io/dpv/2.0/dpv/.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
union ProcessingOperation {
  dpvAccess: "Access",
  dpvAcquire: "Acquire",
  dpvAdapt: "Adapt",
  dpvAggregate: "Aggregate",
  dpvAlign: "Align",
  dpvAlter: "Alter",
  dpvAnalyse: "Analyze",
  dpvAnonymise: "Anonymize",
  dpvAssess: "Assess",
  dpvCollect: "Collect",
  dpvCombine: "Combine",
  dpvConsult: "Consult",
  dpvCopy: "Copy",
  dpvCrossBorderTransfer: "Cross border transfer",
  dpvDelete: "Delete",
  dpvDerive: "Derive",
  dpvDestruct: "Destruct",
  dpvDisclose: "Disclose",
  dpvDiscloseByTransmission: "Disclose by transmission",
  dpvDisplay: "Display",
  dpvDisseminate: "Disseminate",
  dpvDownload: "Download",
  dpvErase: "Erase",
  dpvExport: "Export",
  dpvFilter: "Filter",
  dpvFormat: "Format",
  dpvGenerate: "Generate",
  dpvInfer: "Infer",
  dpvMakeAvailable: "Make available",
  dpvMatch: "Match",
  dpvModify: "Modify",
  dpvMonitor: "Monitor",
  dpvMove: "Move",
  dpvObserve: "Observe",
  dpvObtain: "Obtain",
  dpvOrganise: "Organize",
  dpvProfiling: "Profiling",
  dpvPseudonymise: "Pseudonymize",
  dpvQuery: "Query",
  dpvRecord: "Record",
  dpvReformat: "Reformat",
  dpvRemove: "Remove",
  dpvRestrict: "Restrict",
  dpvRetrieve: "Retrieve",
  dpvScreen: "Screen",
  dpvShare: "Share",
  dpvStore: "Store",
  dpvStructure: "Structure",
  dpvTransfer: "Transfer",
  dpvTransform: "Transform",
  dpvTransmit: "Transmit",
  dpvUse: "Use",
  string,
}

/**
 * Valid values for the purpose based on W3C Data Privacy Vocabulary v2 https://w3c.github.io/dpv/2.0/dpv/.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@TypeSpec.Versioning.added(Versions.v2024_11_01_preview)
union Purpose {
  dpvAcademicResearch: "Academic Research",
  dpvAccountManagement: "Account Management",
  dpvAdvertising: "Advertising",
  dpvAgeVerification: "Age Verification",
  dpvCombatClimateChange: "Combat Climate Change",
  dpvCommercialPurpose: "Commercial Purpose",
  dpvCommercialResearch: "Commercial Research",
  dpvCommunicationForCustomerCare: "Communication For Customer Care",
  dpvCommunicationManagement: "Communication Management",
  dpvCounterMoneyLaundering: "Counter Money Laundering",
  dpvCounterterrorism: "Counter-terrorism",
  dpvCreditChecking: "Credit Checking",
  dpvCustomerCare: "Customer Care",
  dpvCustomerClaimsManagement: "Customer Claims Management",
  dpvCustomerManagement: "Customer Management",
  dpvCustomerOrderManagement: "Customer Order Management",
  dpvCustomerRelationshipManagement: "Customer Relationship Management",
  dpvCustomerSolvencyMonitoring: "Customer Solvency Monitoring",
  dpvDataAltruism: "Data Altruism",
  dpvDeliveryOfGoods: "Delivery Of Goods",
  dpvDirectMarketing: "Direct Marketing",
  dpvDisputeManagement: "Dispute Management",
  dpvEnforceAccessControl: "Enforce Access Control",
  dpvEnforceSecurity: "Enforce Security",
  dpvEstablishContractualAgreement: "Establish Contractual Agreement",
  dpvFraudPreventionAndDetection: "Fraud Prevention And Detection",
  dpvFulfilmentOfContractualObligation: "Fulfillment Of Contractual Obligation",
  dpvFulfilmentOfObligation: "Fulfillment Of Obligation",
  dpvHumanResourceManagement: "Human Resource Management",
  dpvIdentityAuthentication: "Identity Authentication",
  dpvIdentityVerification: "Identity Verification",
  dpvImproveExistingProductsAndServices: "Improve Existing Products And Services",
  dpvImproveHealthcare: "Improve Healthcare",
  dpvImproveInternalCRMProcesses: "Improve Internal CRM Processes",
  dpvImprovePublicServices: "Improve Public Services",
  dpvImproveTransportMobility: "Improve Transport Mobility",
  dpvIncreaseServiceRobustness: "Increase Service Robustness",
  dpvInternalResourceOptimisation: "Internal Resource Optimization",
  dpvLegalCompliance: "Legal Compliance",
  dpvMaintainCreditCheckingDatabase: "Maintain Credit Checking Database",
  dpvMaintainCreditRatingDatabase: "Maintain Credit Rating Database",
  dpvMaintainFraudDatabase: "Maintain Fraud Database",
  dpvMarketing: "Marketing",
  dpvMemberPartnerManagement: "Member Partner Management",
  dpvMisusePreventionAndDetection: "Misuse Prevention And Detection",
  dpvNonCommercialPurpose: "Non Commercial Purpose",
  dpvNonCommercialResearch: "Non Commercial Research",
  dpvOptimisationForConsumer: "Optimization For Consumer",
  dpvOptimisationForController: "Optimization For Controller",
  dpvOptimiseUserInterface: "Optimize User Interface",
  dpvOrganisationComplianceManagement: "Organisation Compliance Management",
  dpvOrganisationGovernance: "Organisation Governance",
  dpvOrganisationRiskManagement: "Organisation Risk Management",
  dpvPaymentManagement: "Payment Management",
  dpvPersonalisation: "Personalization",
  dpvPersonalisedAdvertising: "Personalized Advertising",
  dpvPersonalisedBenefits: "Personalized Benefits",
  dpvPersonnelHiring: "Personnel Hiring",
  dpvPersonnelManagement: "Personnel Management",
  dpvPersonnelPayment: "Personnel Payment",
  dpvProtectionOfIPR: "Protection Of IPR",
  dpvProtectionOfNationalSecurity: "Protection Of National Security",
  dpvProtectionOfPublicSecurity: "Protection Of Public Security",
  dpvProvideEventRecommendations: "Provide Event Recommendations",
  dpvProvideOfficialStatistics: "Provide Official Statistics",
  dpvProvidePersonalisedRecommendations: "Provide Personalised Recommendations",
  dpvProvideProductRecommendations: "Provide Product Recommendations",
  dpvPublicBenefit: "Public Benefit",
  dpvPublicPolicyMaking: "Public Policy Making",
  dpvPublicRelations: "Public Relations",
  dpvRecordManagement: "Record Management",
  dpvRepairImpairments: "Repair Impairments",
  dpvRequestedServiceProvision: "Requested Service Provision",
  dpvResearchAndDevelopment: "Research And Development",
  dpvRightsFulfillment: "Rights Fulfillment",
  dpvScientificResearch: "Scientific Research",
  dpvSearchFunctionalities: "Search Functionalities",
  dpvSellDataToThirdParties: "Sell Data To Third Parties",
  dpvSellInsightsFromData: "Sell Insights From Data",
  dpvSellProducts: "Sell Products",
  dpvSellProductsToDataSubject: "Sell Products To Data Subject",
  dpvServiceOptimisation: "Service Optimization",
  dpvServicePersonalisation: "Service Personalisation",
  dpvServiceProvision: "Service Provision",
  dpvServiceRegistration: "Service Registration",
  dpvServiceUsageAnalytics: "Service Usage Analytics",
  dpvSocialMediaMarketing: "Social Media Marketing",
  dpvTargetedAdvertising: "Targeted Advertising",
  dpvTechnicalServiceProvision: "Technical Service Provision",
  dpvUserInterfacePersonalisation: "User Interface Personalisation",
  dpvVendorManagement: "Vendor Management",
  dpvVendorPayment: "Vendor Payment",
  dpvVendorRecordsManagement: "Vendor Records Management",
  dpvVendorSelectionAssessment: "Vendor Selection Assessment",
  dpvVerification: "Verification",
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
