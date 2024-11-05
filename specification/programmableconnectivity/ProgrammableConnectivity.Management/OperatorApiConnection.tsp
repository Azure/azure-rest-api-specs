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
   * Details about the SaaS offer purchased from the marketplace. TO DO figure out how to change this to read only
   */
  @visibility("read", "create", "update")
  saasProperties?: SaasProperties;

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
 * Valid values for the purpose based on W3C Data Privacy Vocabulary v2 https://w3c.github.io/dpv/2.0/dpv/
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
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
  dpvCounterterrorism: "Counterterrorism",
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
  dpvFulfilmentOfContractualObligation: "Fulfilment Of Contractual Obligation",
  dpvFulfilmentOfObligation: "Fulfilment Of Obligation",
  dpvHumanResourceManagement: "Human Resource Management",
  dpvIdentityAuthentication: "Identity Authentication",
  dpvIdentityVerification: "Identity Verification",
  dpvImproveExistingProductsAndServices: "Improve Existing Products And Services",
  dpvImproveHealthcare: "Improve Healthcare",
  dpvImproveInternalCRMProcesses: "Improve Internal CRM Processes",
  dpvImprovePublicServices: "Improve Public Services",
  dpvImproveTransportMobility: "Improve Transport Mobility",
  dpvIncreaseServiceRobustness: "Increase Service Robustness",
  dpvInternalResourceOptimisation: "Internal Resource Optimisation",
  dpvLegalCompliance: "Legal Compliance",
  dpvMaintainCreditCheckingDatabase: "Maintain Credit Checking Database",
  dpvMaintainCreditRatingDatabase: "Maintain Credit Rating Database",
  dpvMaintainFraudDatabase: "Maintain Fraud Database",
  dpvMarketing: "Marketing",
  dpvMemberPartnerManagement: "Member Partner Management",
  dpvMisusePreventionAndDetection: "Misuse Prevention And Detection",
  dpvNonCommercialPurpose: "Non Commercial Purpose",
  dpvNonCommercialResearch: "Non Commercial Research",
  dpvOptimisationForConsumer: "Optimisation For Consumer",
  dpvOptimisationForController: "Optimisation For Controller",
  dpvOptimiseUserInterface: "Optimise User Interface",
  dpvOrganisationComplianceManagement: "Organisation Compliance Management",
  dpvOrganisationGovernance: "Organisation Governance",
  dpvOrganisationRiskManagement: "Organisation Risk Management",
  dpvPaymentManagement: "Payment Management",
  dpvPersonalisation: "Personalisation",
  dpvPersonalisedAdvertising: "Personalised Advertising",
  dpvPersonalisedBenefits: "Personalised Benefits",
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
  dpvServiceOptimisation: "Service Optimisation",
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
