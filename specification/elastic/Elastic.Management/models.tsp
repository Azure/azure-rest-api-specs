import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
namespace Microsoft.Elastic;

/**
 * Provisioning state of Elastic resource.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
}

/**
 * Flag specifying if the resource monitoring is enabled or disabled.
 */
union MonitoringStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union LiftrResourceCategories {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MonitorLogs: "MonitorLogs",
}

/**
 * Hosting type of the monitor resource - either Hosted deployments or Serverless Projects.
 */
union HostingType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Hosted: "Hosted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Serverless: "Serverless",
}

/**
 * Project type; ex: Elasticsearch / Observability / Security
 */
union ProjectType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Elasticsearch: "Elasticsearch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Observability: "Observability",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Security: "Security",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotApplicable: "NotApplicable",
}

/**
 * Configuration type of the Elasticsearch project
 */
union ConfigurationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GeneralPurpose: "GeneralPurpose",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Vector: "Vector",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TimeSeries: "TimeSeries",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotApplicable: "NotApplicable",
}

/**
 * Managed Identity types.
 */
union ManagedIdentityTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
}

/**
 * The operation for the patch on the resource.
 */
union Operation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AddBegin: "AddBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AddComplete: "AddComplete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeleteBegin: "DeleteBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeleteComplete: "DeleteComplete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
}

/**
 * The state of monitoring.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
}

/**
 * Valid actions for a filtering tag. Exclusion takes priority over inclusion.
 */
union TagAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Include: "Include",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Exclude: "Exclude",
}

/**
 * Flag indicating the status of the resource for sending logs operation to Elastic.
 */
union SendingLogs {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * Flag specifying if the Elastic deployment status is healthy or not.
 */
union ElasticDeploymentStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unhealthy: "Unhealthy",
}

/**
 * Operation to be performed on the given vm resource id.
 */
union OperationName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Add: "Add",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Delete: "Delete",
}

/**
 * Type of the elastic filter
 */
union Type {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ip: "ip",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azure_private_endpoint: "azure_private_endpoint",
}

/**
 * Represents a paginated list of operations.
 */
model OperationListResult {
  /**
   * The list of operations.
   */
  @pageItems
  @identifiers(#[])
  value: OperationResult[];

  /**
   * The URL to get the next set of results, if any.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Represents the display information for an operation.
 */
model OperationDisplay {
  /**
   * The service provider of the operation.
   */
  provider?: string;

  /**
   * The resource type of the operation.
   */
  resource?: string;

  /**
   * The name of the operation.
   */
  operation?: string;

  /**
   * A description of the operation.
   */
  description?: string;
}

/**
 * A Microsoft.Elastic REST API operation.
 */
model OperationResult {
  /**
   * Operation name, i.e., {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * The object that represents the operation.
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation
   */
  origin?: string;
}

/**
 * RP default error response.
 */
@error
model ResourceProviderDefaultErrorResponse {
  /**
   * Response body of Error
   */
  @visibility(Lifecycle.Read)
  error?: ErrorResponseBody;
}

/**
 * Error response body.
 */
model ErrorResponseBody {
  /**
   * Error code.
   */
  code?: string;

  /**
   * Error message.
   */
  message?: string;

  /**
   * Error target.
   */
  target?: string;

  /**
   * Error details.
   */
  @identifiers(#[])
  details?: ErrorResponseBody[];
}

/**
 * Response of a list operation.
 */
model ElasticMonitorResourceListResponse
  is Azure.Core.Page<ElasticMonitorResource>;

/**
 * Properties specific to the monitor resource.
 */
model MonitorProperties {
  /**
   * Provisioning state of the monitor resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Flag specifying if the resource monitoring is enabled or disabled.
   */
  monitoringStatus?: MonitoringStatus;

  /**
   * Elastic cloud properties.
   */
  elasticProperties?: ElasticProperties;

  /**
   * User information.
   */
  @visibility(Lifecycle.Create)
  userInfo?: UserInfo;

  /**
   * Plan details of the monitor resource.
   */
  planDetails?: PlanDetails;

  /**
   * Version of elastic of the monitor resource
   */
  version?: string;

  /**
   * State of the Azure Subscription containing the monitor resource
   */
  subscriptionState?: string;

  /**
   * Status of Azure Subscription where Marketplace SaaS is located.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  saaSAzureSubscriptionStatus?: string;

  /**
   * Name of the marketing campaign.
   */
  sourceCampaignName?: string;

  /**
   * A unique identifier associated with the campaign.
   */
  sourceCampaignId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  liftrResourceCategory?: LiftrResourceCategories;

  /**
   * The priority of the resource.
   */
  @visibility(Lifecycle.Read)
  liftrResourcePreference?: int32;

  /**
   * Flag to determine if User API Key has to be generated and shared.
   */
  generateApiKey?: boolean;

  /**
   * Hosting type of the monitor resource - either Hosted deployments OR Serverless Projects.
   */
  hostingType?: HostingType;

  /**
   * Project details of the monitor resource IF it belongs to Serverless offer kind.
   */
  projectDetails?: ProjectDetails;
}

/**
 * Elastic Resource Properties.
 */
model ElasticProperties {
  /**
   * Details of the user's elastic account.
   */
  elasticCloudUser?: ElasticCloudUser;

  /**
   * Details of the elastic cloud deployment.
   */
  elasticCloudDeployment?: ElasticCloudDeployment;
}

/**
 * Details of the user's elastic account.
 */
model ElasticCloudUser {
  /**
   * Email of the Elastic User Account.
   */
  @visibility(Lifecycle.Read)
  emailAddress?: string;

  /**
   * User Id of the elastic account of the User.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Elastic cloud default dashboard sso URL of the Elastic user account.
   */
  @visibility(Lifecycle.Read)
  elasticCloudSsoDefaultUrl?: string;
}

/**
 * Details of the user's elastic deployment associated with the monitor resource.
 */
model ElasticCloudDeployment {
  /**
   * Elastic deployment name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Elastic deployment Id
   */
  @visibility(Lifecycle.Read)
  deploymentId?: string;

  /**
   * Associated Azure subscription Id for the elastic deployment.
   */
  @visibility(Lifecycle.Read)
  azureSubscriptionId?: string;

  /**
   * Region where Deployment at Elastic side took place.
   */
  @visibility(Lifecycle.Read)
  elasticsearchRegion?: string;

  /**
   * Elasticsearch ingestion endpoint of the Elastic deployment.
   */
  @visibility(Lifecycle.Read)
  elasticsearchServiceUrl?: string;

  /**
   * Kibana endpoint of the Elastic deployment.
   */
  @visibility(Lifecycle.Read)
  kibanaServiceUrl?: string;

  /**
   * Kibana dashboard sso URL of the Elastic deployment.
   */
  @visibility(Lifecycle.Read)
  kibanaSsoUrl?: string;
}

/**
 * User Information to be passed to partners.
 */
model UserInfo {
  /**
   * First name of the user
   */
  @maxLength(128)
  firstName?: string;

  /**
   * Last name of the user
   */
  @maxLength(128)
  lastName?: string;

  /**
   * Company name of the user
   */
  @maxLength(128)
  companyName?: string;

  /**
   * Email of the user used by Elastic for contacting them if needed
   */
  @pattern("^([^<>()\\[\\]\\.,;:\\s@\"]+(\\.[^<>()\\[\\]\\.,;:\\s@\"]+)*)@(([a-zA-Z-_0-9]+\\.)+[a-zA-Z]{2,})$")
  emailAddress?: string;

  /**
   * Company information of the user to be passed to partners.
   */
  companyInfo?: CompanyInfo;
}

/**
 * Company information of the user to be passed to partners.
 */
model CompanyInfo {
  /**
   * Domain of the company
   */
  @maxLength(256)
  domain?: string;

  /**
   * Business of the company
   */
  @maxLength(128)
  business?: string;

  /**
   * Number of employees in the company
   */
  @maxLength(20)
  employeesNumber?: string;

  /**
   * State of the company location.
   */
  @maxLength(128)
  state?: string;

  /**
   * Country of the company location.
   */
  @maxLength(128)
  country?: string;
}

/**
 * Plan details of the monitor resource.
 */
model PlanDetails {
  /**
   * Offer ID of the plan
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  offerID?: string;

  /**
   * Publisher ID of the plan
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  publisherID?: string;

  /**
   * Term ID of the plan
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  termID?: string;

  /**
   * Plan ID
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  planID?: string;

  /**
   * Plan Name
   */
  planName?: string;
}

/**
 * Project details of the monitor resource IF it belongs to Serverless offer kind.
 */
model ProjectDetails {
  /**
   * Project type; ex: Elasticsearch / Observability / Security
   */
  projectType?: ProjectType;

  /**
   * Configuration type of the Elasticsearch project
   */
  configurationType?: ConfigurationType;
}

/**
 * Identity properties.
 */
model IdentityProperties {
  /**
   * The identity ID.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Managed identity type.
   */
  type?: ManagedIdentityTypes;
}

/**
 * List of elastic versions available in a region.
 */
model ElasticVersionsListResponse is Azure.Core.Page<ElasticVersionListFormat>;

/**
 * Elastic Version List Format
 */
model ElasticVersionListFormat {
  /**
   * Elastic Version Properties
   */
  properties?: ElasticVersionListProperties;
}

/**
 * Elastic Version Properties
 */
model ElasticVersionListProperties {
  /**
   * Available elastic version of the given region
   */
  version?: string;
}

/**
 * Monitor resource update parameters.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ElasticMonitorResourceUpdateParameters {
  /**
   * elastic monitor resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MonitoredSubscriptionPropertiesList
  is Azure.Core.Page<MonitoredSubscriptionProperties>;

/**
 * The request to update subscriptions needed to be monitored by the Elastic monitor resource.
 */
model SubscriptionList {
  /**
   * The operation for the patch on the resource.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  operation?: Operation;

  /**
   * List of subscriptions and the state of the monitoring.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["properties/subscriptionId"])
  monitoredSubscriptionList?: MonitoredSubscription[];

  /**
   * Provisioning State of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The list of subscriptions and it's monitoring status by current Elastic monitor.
 */
model MonitoredSubscription {
  /**
   * The subscriptionId to be monitored.
   */
  subscriptionId: string;

  /**
   * The state of monitoring.
   */
  status?: Status;

  /**
   * The reason of not monitoring the subscription.
   */
  error?: string;

  /**
   * Definition of the properties for a TagRules resource.
   */
  tagRules?: MonitoringTagRulesProperties;
}

/**
 * Definition of the properties for a TagRules resource.
 */
model MonitoringTagRulesProperties {
  /**
   * Provisioning state of the monitoring tag rules.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Rules for sending logs.
   */
  logRules?: LogRules;
}

/**
 * Set of rules for sending logs for the Monitor resource.
 */
model LogRules {
  /**
   * Flag specifying if AAD logs should be sent for the Monitor resource.
   */
  sendAadLogs?: boolean;

  /**
   * Flag specifying if subscription logs should be sent for the Monitor resource.
   */
  sendSubscriptionLogs?: boolean;

  /**
   * Flag specifying if activity logs from Azure resources should be sent for the Monitor resource.
   */
  sendActivityLogs?: boolean;

  /**
   * List of filtering tags to be used for capturing logs. This only takes effect if SendActivityLogs flag is enabled. If empty, all resources will be captured. If only Exclude action is specified, the rules will apply to the list of all available resources. If Include actions are specified, the rules will only include resources with the associated tags.
   */
  @identifiers(#[])
  filteringTags?: FilteringTag[];
}

/**
 * The definition of a filtering tag. Filtering tags are used for capturing resources and include/exclude them from being monitored.
 */
model FilteringTag {
  /**
   * The name (also known as the key) of the tag.
   */
  name?: string;

  /**
   * The value of the tag.
   */
  value?: string;

  /**
   * Valid actions for a filtering tag.
   */
  action?: TagAction;
}

/**
 * Response of a list operation.
 */
model MonitoredResourceListResponse is Azure.Core.Page<MonitoredResource>;

/**
 * The properties of a resource currently being monitored by the Elastic monitor resource.
 */
model MonitoredResource {
  /**
   * The ARM id of the resource.
   */
  id?: string;

  /**
   * Flag indicating the status of the resource for sending logs operation to Elastic.
   */
  sendingLogs?: SendingLogs;

  /**
   * Reason for why the resource is sending logs (or why it is not sending).
   */
  reasonForLogsStatus?: string;
}

/**
 * The properties of deployment in Elastic cloud corresponding to the Elastic monitor resource.
 */
model DeploymentInfoResponse {
  /**
   * The Elastic deployment status.
   */
  @visibility(Lifecycle.Read)
  status?: ElasticDeploymentStatus;

  /**
   * Version of the elasticsearch in Elastic cloud deployment.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * RAM capacity of the elasticsearch in Elastic cloud deployment.
   */
  @visibility(Lifecycle.Read)
  memoryCapacity?: string;

  /**
   * Disk capacity of the elasticsearch in Elastic cloud deployment.
   */
  @visibility(Lifecycle.Read)
  diskCapacity?: string;

  /**
   * Elasticsearch endpoint in Elastic cloud deployment. This is either the aliased_endpoint if available, or the service_url otherwise.
   */
  @visibility(Lifecycle.Read)
  elasticsearchEndPoint?: string;

  /**
   * Deployment URL of the elasticsearch in Elastic cloud deployment.
   */
  @visibility(Lifecycle.Read)
  deploymentUrl?: string;

  /**
   * Marketplace SaaS Info of the resource.
   */
  @visibility(Lifecycle.Read)
  marketplaceSaasInfo?: MarketplaceSaaSInfo;

  /**
   * Project Type - Applicable for Serverless only.
   */
  @visibility(Lifecycle.Read)
  projectType?: string;

  /**
   * ConfigurationType Type - Applicable for Serverless only.
   */
  @visibility(Lifecycle.Read)
  configurationType?: string;
}

/**
 * Marketplace SAAS Info of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MarketplaceSaaSInfo {
  /**
   * Marketplace Subscription
   */
  marketplaceSubscription?: MarketplaceSaaSInfoMarketplaceSubscription;

  /**
   * Marketplace Subscription Details: SAAS Name
   */
  marketplaceName?: string;

  /**
   * Marketplace Subscription Details: Resource URI
   */
  marketplaceResourceId?: string;

  /**
   * Marketplace Subscription Details: SaaS Subscription Status
   */
  marketplaceStatus?: string;

  /**
   * The Azure Subscription ID to which the Marketplace Subscription belongs and gets billed into.
   */
  billedAzureSubscriptionId?: string;

  /**
   * Flag specifying if the Marketplace status is subscribed or not.
   */
  subscribed?: boolean;
}

/**
 * Marketplace Subscription
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MarketplaceSaaSInfoMarketplaceSubscription {
  /**
   * Marketplace Subscription Id. This is a GUID-formatted string.
   */
  id?: string;

  /**
   * Publisher Id of the Marketplace offer.
   */
  publisherId?: string;

  /**
   * Offer Id of the Marketplace offer,
   */
  offerId?: string;
}

/**
 * The properties of the request required for creating user on elastic side
 */
model ExternalUserInfo {
  /**
   * Username of the user to be created or updated
   */
  userName?: string;

  /**
   * Full name of the user to be created or updated
   */
  fullName?: string;

  /**
   * Password of the user to be created or updated
   */
  @secret
  password?: string;

  /**
   * Email id of the user to be created or updated
   */
  emailId?: string;

  /**
   * Roles to be assigned for  created or updated user
   */
  roles?: string[];
}

/**
 * The properties of the response we got from elastic while creating external user
 */
model ExternalUserCreationResponse {
  /**
   * Shows if user is created or updated
   */
  @visibility(Lifecycle.Read)
  created?: boolean;
}

/**
 * Marketplace Subscription and Organization details to which resource gets billed into.
 */
model BillingInfoResponse {
  /**
   * Marketplace Subscription details
   */
  marketplaceSaasInfo?: MarketplaceSaaSInfo;

  /**
   * Partner Billing Entity details: Organization Info
   */
  partnerBillingEntity?: PartnerBillingEntity;
}

/**
 * Partner Billing details associated with the resource.
 */
model PartnerBillingEntity {
  /**
   * The Elastic Organization Id.
   */
  id?: string;

  /**
   * The Elastic Organization Name.
   */
  name?: string;

  /**
   * Link to the elastic organization page
   */
  partnerEntityUri?: string;
}

/**
 *  List of all active elastic deployments.
 */
model ConnectedPartnerResourcesListResponse
  is Azure.Core.Page<ConnectedPartnerResourcesListFormat>;

/**
 * Connected Partner Resources List Format
 */
model ConnectedPartnerResourcesListFormat {
  /**
   * Connected Partner Resource Properties
   */
  properties?: ConnectedPartnerResourceProperties;
}

/**
 * Connected Partner Resource Properties
 */
model ConnectedPartnerResourceProperties {
  /**
   * Elastic resource name
   */
  partnerDeploymentName?: string;

  /**
   * URL of the resource in Elastic cloud.
   */
  partnerDeploymentUri?: string;

  /**
   * The azure resource Id of the resource.
   */
  azureResourceId?: string;

  /**
   * The location of the resource.
   */
  location?: string;

  /**
   * The hosting type of the resource.
   */
  type?: string;
}

/**
 * Response of a list operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OpenAIIntegrationRPModelListResponse
  is Azure.Core.Page<OpenAIIntegrationRPModel>;

/**
 * Open AI Integration details.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OpenAIIntegrationProperties {
  /**
   * The resource name of Open AI resource
   */
  openAIResourceId?: string;

  /**
   * The API endpoint for Open AI resource
   */
  openAIResourceEndpoint?: string;

  /**
   * The connector id of Open AI resource
   */
  openAIConnectorId?: string;

  /**
   * Value of API key for Open AI resource
   */
  @secret
  key?: string;

  /**
   * Last Update Timestamp for key updation
   */
  @visibility(Lifecycle.Read)
  lastRefreshAt?: utcDateTime;
}

/**
 * Status of the OpenAI Integration
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OpenAIIntegrationStatusResponse {
  /**
   * Status of the OpenAI Integration
   */
  properties?: OpenAIIntegrationStatusResponseProperties;
}

/**
 * Status of the OpenAI Integration
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OpenAIIntegrationStatusResponseProperties {
  /**
   * Status of the OpenAI Integration
   */
  status?: string;
}

/**
 * Response of a list operation.
 */
model MonitoringTagRulesListResponse is Azure.Core.Page<MonitoringTagRules>;

/**
 * Response of a list operation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMHostListResponse is Azure.Core.Page<VMResources>;

/**
 * The vm resource properties that is currently being monitored by the Elastic monitor resource.
 */
model VMResources {
  /**
   * The ARM id of the VM resource.
   */
  vmResourceId?: string;
}

/**
 * The vm ingestion details to install an agent.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMIngestionDetailsResponse {
  /**
   * The cloudId of given Elastic monitor resource.
   */
  cloudId?: string;

  /**
   * Ingestion details to install agent on given VM.
   */
  @secret
  ingestionKey?: string;
}

/**
 * Update VM resource collection.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMCollectionUpdate {
  /**
   * ARM id of the VM resource.
   */
  vmResourceId?: string;

  /**
   * Operation to be performed for given VM.
   */
  operationName?: OperationName;
}

/**
 * Stack Versions that this version can upgrade to
 */
model UpgradableVersionsList {
  /**
   * Current version of the elastic monitor
   */
  currentVersion?: string;

  /**
   * Stack Versions that this version can upgrade to
   */
  upgradableVersions?: string[];
}

/**
 * Upgrade elastic monitor version
 */
model ElasticMonitorUpgrade {
  /**
   * Version to which the elastic monitor should be upgraded to
   */
  version?: string;
}

/**
 * List of elastic traffic filters in the account
 */
model ElasticTrafficFilterResponse {
  /**
   * List of elastic traffic filters in the account
   */
  @identifiers(#[])
  rulesets?: ElasticTrafficFilter[];
}

/**
 * Elastic traffic filter object
 */
model ElasticTrafficFilter {
  /**
   * Id of the elastic filter
   */
  id?: string;

  /**
   * Name of the elastic filter
   */
  name?: string;

  /**
   * Description of the elastic filter
   */
  description?: string;

  /**
   * Region of the elastic filter
   */
  region?: string;

  /**
   * Type of the elastic filter
   */
  type?: Type;

  /**
   * IncludeByDefault for the elastic filter
   */
  includeByDefault?: boolean;

  /**
   * Rules in the elastic filter
   */
  rules?: ElasticTrafficFilterRule[];
}

/**
 * Elastic traffic filter rule object
 */
model ElasticTrafficFilterRule {
  /**
   * IP of the elastic filter rule
   */
  source?: string;

  /**
   * Description of the elastic filter rule
   */
  description?: string;

  /**
   * Guid of Private Endpoint in the elastic filter rule
   */
  azureEndpointGuid?: string;

  /**
   * Name of the Private Endpoint in the elastic filter rule
   */
  azureEndpointName?: string;

  /**
   * Id of the elastic filter rule
   */
  id?: string;
}

/**
 * Email Id of the User Organization, of which the API Key must be returned
 */
model UserEmailId {
  /**
   * The User email Id
   */
  emailId?: string;
}

/**
 * The User Api Key created for the Organization associated with the User Email Id that was passed in the request
 */
model UserApiKeyResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: UserApiKeyResponseProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UserApiKeyResponseProperties {
  /**
   * The User Api Key Generated based on GenerateApiKey flag. This is applicable for non-Portal clients only.
   */
  @secret
  apiKey?: string;
}

/**
 * The Azure Subscription ID to which the Organization of the logged in user belongs and gets billed into.
 */
model ElasticOrganizationToAzureSubscriptionMappingResponse {
  /**
   * The properties of Azure Subscription ID to which the Organization of the logged in user belongs and gets billed into.
   */
  properties?: ElasticOrganizationToAzureSubscriptionMappingResponseProperties;
}

/**
 * The properties of Azure Subscription ID to which the Organization of the logged in user belongs and gets billed into.
 */
model ElasticOrganizationToAzureSubscriptionMappingResponseProperties {
  /**
   * The Azure Subscription ID to which the Organization belongs and gets billed into. This is empty for a new user OR a user without an Elastic Organization.
   */
  billedAzureSubscriptionId?: string;

  /**
   * Marketplace SaaS Info of the resource.
   */
  @visibility(Lifecycle.Read)
  marketplaceSaasInfo?: MarketplaceSaaSInfo;

  /**
   * The Elastic Organization Id.
   */
  elasticOrganizationId?: string;

  /**
   * The Elastic Organization Name.
   */
  elasticOrganizationName?: string;
}

/**
 * Resubscribe Properties
 */
model ResubscribeProperties {
  /**
   * Newly selected plan Id to create the new Marketplace subscription for Resubscribe
   */
  planId?: string;

  /**
   * Newly selected term to create the new Marketplace subscription for Resubscribe
   */
  term?: string;

  /**
   * Newly selected Azure Subscription Id in which the new Marketplace subscription will be created for Resubscribe
   */
  subscriptionId?: string;

  /**
   * Newly selected Azure resource group in which the new Marketplace subscription will be created for Resubscribe
   */
  resourceGroup?: string;

  /**
   * Organization Id of the Elastic Organization that needs to be resubscribed
   */
  organizationId?: string;
}
