import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Confluent;

/**
 * Result of GET request to list Confluent operations.
 */
@Azure.Core.pagedResult
model OperationListResult {
  /**
   * List of Confluent operations supported by the Microsoft.Confluent provider.
   */
  @Azure.Core.items
  value: OperationResult[];

  /**
   * URL to get the next set of operation list results if there are any.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Provision states for confluent RP
 */
union ProvisionState {
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
 * SaaS Offer Status for confluent RP
 */
union SaaSOfferStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Started: "Started",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PendingFulfillmentStart: "PendingFulfillmentStart",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Subscribed: "Subscribed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Reinstated: "Reinstated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unsubscribed: "Unsubscribed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
}

/**
 * Stream Governance Package. Supported values are ESSENTIALS and ADVANCED
 */
union Package {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ESSENTIALS: "ESSENTIALS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ADVANCED: "ADVANCED",
}

/**
 * Connector Type
 */
union ConnectorType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SINK: "SINK",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SOURCE: "SOURCE",
}

/**
 * Connector Class
 */
union ConnectorClass {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AZUREBLOBSOURCE: "AZUREBLOBSOURCE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AZUREBLOBSINK: "AZUREBLOBSINK",
}

/**
 * Connector Status
 */
union ConnectorStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PROVISIONING: "PROVISIONING",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RUNNING: "RUNNING",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PAUSED: "PAUSED",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FAILED: "FAILED",
}

/**
 * The connector service type.
 */
union ConnectorServiceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBlobStorageSinkConnector: "AzureBlobStorageSinkConnector",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBlobStorageSourceConnector: "AzureBlobStorageSourceConnector",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureCosmosDBSinkConnector: "AzureCosmosDBSinkConnector",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureCosmosDBSourceConnector: "AzureCosmosDBSourceConnector",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureSynapseAnalyticsSinkConnector: "AzureSynapseAnalyticsSinkConnector",
}

/**
 * Partner Connector type.
 */
union PartnerConnectorType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  KafkaAzureBlobStorageSource: "KafkaAzureBlobStorageSource",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  KafkaAzureBlobStorageSink: "KafkaAzureBlobStorageSink",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  KafkaAzureCosmosDBSource: "KafkaAzureCosmosDBSource",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  KafkaAzureCosmosDBSink: "KafkaAzureCosmosDBSink",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  KafkaAzureSynapseAnalyticsSink: "KafkaAzureSynapseAnalyticsSink",
}

/**
 * Kafka Connector Auth Type
 */
union AuthType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SERVICE_ACCOUNT: "SERVICE_ACCOUNT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  KAFKA_API_KEY: "KAFKA_API_KEY",
}

/**
 * Data Format Type
 */
union DataFormatType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AVRO: "AVRO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  JSON: "JSON",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  STRING: "STRING",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BYTES: "BYTES",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PROTOBUF: "PROTOBUF",
}

/**
 * Response of a list operation.
 */
model ConfluentAgreementResourceListResponse
  is Azure.Core.Page<ConfluentAgreementResource>;

/**
 * Agreement Terms definition
 */
model ConfluentAgreementResource {
  /**
   * The ARM id of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the agreement.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the agreement.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * Represents the properties of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ConfluentAgreementProperties;
}

/**
 * Terms properties for Marketplace and Confluent.
 */
model ConfluentAgreementProperties {
  /**
   * Publisher identifier string.
   */
  publisher?: string;

  /**
   * Product identifier string.
   */
  product?: string;

  /**
   * Plan identifier string.
   */
  plan?: string;

  /**
   * Link to HTML with Microsoft and Publisher terms.
   */
  licenseTextLink?: string;

  /**
   * Link to the privacy policy of the publisher.
   */
  privacyPolicyLink?: string;

  /**
   * Date and time in UTC of when the terms were accepted. This is empty if Accepted is false.
   */
  retrieveDatetime?: utcDateTime;

  /**
   * Terms signature.
   */
  signature?: string;

  /**
   * If any version of the terms have been accepted, otherwise false.
   */
  accepted?: boolean;
}

/**
 * Default error response for resource provider
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
 * Response body of Error
 */
model ErrorResponseBody {
  /**
   * Error code
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Error target
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * Error detail
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  details?: ErrorResponseBody[];
}

/**
 * An Confluent REST API operation.
 */
model OperationResult {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The object that represents the operation.
   */
  display?: OperationDisplay;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;
}

/**
 * The object that represents the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft.Confluent
   */
  provider?: string;

  /**
   * Type on which the operation is performed, e.g., 'clusters'.
   */
  resource?: string;

  /**
   * Operation type, e.g., read, write, delete, etc.
   */
  operation?: string;

  /**
   * Description of the operation, e.g., 'Write confluent'.
   */
  description?: string;
}

/**
 * Organization resource property
 */
model OrganizationResourceProperties {
  /**
   * The creation time of the resource.
   */
  @visibility(Lifecycle.Read)
  createdTime?: utcDateTime;

  /**
   * Provision states for confluent RP
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisionState;

  /**
   * Id of the Confluent organization.
   */
  @visibility(Lifecycle.Read)
  organizationId?: string;

  /**
   * SSO url for the Confluent organization.
   */
  @visibility(Lifecycle.Read)
  ssoUrl?: string;

  /**
   * Confluent offer detail
   */
  offerDetail: OfferDetail;

  /**
   * Subscriber detail
   */
  userDetail: UserDetail;

  /**
   * Link an existing Confluent organization
   */
  linkOrganization?: LinkOrganization;
}

/**
 * Confluent Offer detail
 */
model OfferDetail {
  /**
   * Publisher Id
   */
  @maxLength(50)
  publisherId: string;

  /**
   * Offer Id
   */
  @maxLength(50)
  id: string;

  /**
   * Offer Plan Id
   */
  @maxLength(200)
  planId: string;

  /**
   * Offer Plan Name
   */
  @maxLength(200)
  planName: string;

  /**
   * Offer Plan Term unit
   */
  @maxLength(25)
  termUnit: string;

  /**
   * Offer Plan Term Id
   */
  @maxLength(50)
  termId?: string;

  /**
   * Private Offer Id
   */
  @maxLength(255)
  privateOfferId?: string;

  /**
   * Array of Private Offer Ids
   */
  privateOfferIds?: string[];

  /**
   * SaaS Offer Status
   */
  status?: SaaSOfferStatus;
}

/**
 * Subscriber detail
 */
model UserDetail {
  /**
   * First name
   */
  @maxLength(50)
  firstName?: string;

  /**
   * Last name
   */
  @maxLength(50)
  lastName?: string;

  /**
   * Email address
   */
  @pattern("^\\S+@\\S+\\.\\S+$")
  emailAddress: string;

  /**
   * User principal name
   */
  userPrincipalName?: string;

  /**
   * AAD email address
   */
  aadEmail?: string;
}

/**
 * Link an existing Confluent organization
 */
model LinkOrganization {
  /**
   * User auth token
   */
  @visibility(Lifecycle.Create)
  @secret
  token: string;
}

/**
 * Organization Resource update
 */
model OrganizationResourceUpdate {
  /**
   * ARM resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Validation response from the provider
 */
model ValidationResponse {
  /**
   * Info from the response
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  info?: Record<string>;
}

/**
 * List Access Request Model
 */
model ListAccessRequestModel {
  /**
   * Search filters for the request
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  searchFilters?: Record<string>;
}

/**
 * List users success response
 */
model AccessListUsersSuccessResponse {
  /**
   * Type of response
   */
  kind?: string;

  /**
   * Metadata of the list
   */
  metadata?: ConfluentListMetadata;

  /**
   * Data of the users list
   */
  data?: UserRecord[];
}

/**
 * Metadata of the list
 */
model ConfluentListMetadata {
  /**
   * First page of the list
   */
  first?: string;

  /**
   * Last page of the list
   */
  last?: string;

  /**
   * Previous page of the list
   */
  prev?: string;

  /**
   * Next page of the list
   */
  next?: string;

  /**
   * Total size of the list
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  total_size?: int32;
}

/**
 * Record of the user
 */
model UserRecord {
  /**
   * Type of account
   */
  kind?: string;

  /**
   * Id of the user
   */
  id?: string;

  /**
   * Metadata of the record
   */
  metadata?: MetadataEntity;

  /**
   * Email of the user
   */
  email?: string;

  /**
   * Name of the user
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  full_name?: string;

  /**
   * Auth type of the user
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  auth_type?: string;
}

/**
 * Metadata of the data record
 */
model MetadataEntity {
  /**
   * Self lookup url
   */
  self?: string;

  /**
   * Resource name of the record
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource_name?: string;

  /**
   * Created Date Time
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  created_at?: string;

  /**
   * Updated Date time
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updated_at?: string;

  /**
   * Deleted Date time
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleted_at?: string;
}

/**
 * List service accounts success response
 */
model AccessListServiceAccountsSuccessResponse {
  /**
   * Type of response
   */
  kind?: string;

  /**
   * Metadata of the list
   */
  metadata?: ConfluentListMetadata;

  /**
   * Data of the service accounts list
   */
  data?: ServiceAccountRecord[];
}

/**
 * Record of the service account
 */
model ServiceAccountRecord {
  /**
   * Type of account
   */
  kind?: string;

  /**
   * Id of the service account
   */
  id?: string;

  /**
   * Metadata of the record
   */
  metadata?: MetadataEntity;

  /**
   * Name of the service account
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  display_name?: string;

  /**
   * Description of the service account
   */
  description?: string;
}

/**
 * List invitations success response
 */
model AccessListInvitationsSuccessResponse {
  /**
   * Type of response
   */
  kind?: string;

  /**
   * Metadata of the list
   */
  metadata?: ConfluentListMetadata;

  /**
   * Data of the invitations list
   */
  data?: InvitationRecord[];
}

/**
 * Record of the invitation
 */
model InvitationRecord {
  /**
   * Type of account
   */
  kind?: string;

  /**
   * Id of the invitation
   */
  id?: string;

  /**
   * Metadata of the record
   */
  metadata?: MetadataEntity;

  /**
   * Email of the user
   */
  email?: string;

  /**
   * Auth type of the user
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  auth_type?: string;

  /**
   * Status of the invitation
   */
  status?: string;

  /**
   * Accepted date time of the invitation
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accepted_at?: string;

  /**
   * Expiration date time of the invitation
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  expires_at?: string;
}

/**
 * Invite User Account model
 */
model AccessInviteUserAccountModel {
  /**
   * Id of the organization
   */
  organizationId?: string;

  /**
   * Email of the logged in user
   */
  email?: string;

  /**
   * Upn of the logged in user
   */
  upn?: string;

  /**
   * Details of the user who is being invited
   */
  invitedUserDetails?: AccessInvitedUserDetails;
}

/**
 * Details of the user being invited
 */
model AccessInvitedUserDetails {
  /**
   * UPN/Email of the user who is being invited
   */
  invitedEmail?: string;

  /**
   * Auth type of the user
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  auth_type?: string;
}

/**
 * Details of the environments returned on successful response
 */
model AccessListEnvironmentsSuccessResponse {
  /**
   * Type of response
   */
  kind?: string;

  /**
   * Metadata of the  environment list
   */
  metadata?: ConfluentListMetadata;

  /**
   * Environment list data
   */
  data?: EnvironmentRecord[];
}

/**
 * Details about environment name, metadata and environment id of an environment
 */
model EnvironmentRecord {
  /**
   * Type of environment
   */
  kind?: string;

  /**
   * Id of the environment
   */
  id?: string;

  /**
   * Metadata of the record
   */
  metadata?: MetadataEntity;

  /**
   * Display name of the user
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  display_name?: string;
}

/**
 * Details of the clusters returned on successful response
 */
model AccessListClusterSuccessResponse {
  /**
   * Type of response
   */
  kind?: string;

  /**
   * Metadata of the list
   */
  metadata?: ConfluentListMetadata;

  /**
   * List of clusters
   */
  data?: ClusterRecord[];
}

/**
 * Details of cluster record
 */
model ClusterRecord {
  /**
   * Type of cluster
   */
  kind?: string;

  /**
   * Id of the cluster
   */
  id?: string;

  /**
   * Metadata of the record
   */
  metadata?: MetadataEntity;

  /**
   * Display name of the cluster
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  display_name?: string;

  /**
   * Specification of the cluster
   */
  spec?: ClusterSpecEntity;

  /**
   * Specification of the cluster
   */
  status?: ClusterStatusEntity;
}

/**
 * Spec of the cluster record
 */
model ClusterSpecEntity {
  /**
   * The name of the cluster
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  display_name?: string;

  /**
   * The availability zone configuration of the cluster
   */
  availability?: string;

  /**
   * The cloud service provider
   */
  cloud?: string;

  /**
   * type of zone availability
   */
  zone?: string;

  /**
   * The cloud service provider region
   */
  region?: string;

  /**
   * The bootstrap endpoint used by Kafka clients to connect to the cluster
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kafka_bootstrap_endpoint?: string;

  /**
   * The cluster HTTP request URL.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  http_endpoint?: string;

  /**
   * The Kafka API cluster endpoint
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  api_endpoint?: string;

  /**
   * Specification of the cluster
   */
  config?: ClusterConfigEntity;

  /**
   * Specification of the cluster
   */
  environment?: ClusterEnvironmentEntity;

  /**
   * Specification of the cluster
   */
  network?: ClusterNetworkEntity;

  /**
   * Specification of the cluster
   */
  byok?: ClusterByokEntity;
}

/**
 * The configuration of the Kafka cluster
 */
model ClusterConfigEntity {
  /**
   * The lifecycle phase of the cluster
   */
  kind?: string;
}

/**
 * The environment to which cluster belongs
 */
model ClusterEnvironmentEntity {
  /**
   * ID of the referred resource
   */
  id?: string;

  /**
   * Environment of the referred resource
   */
  environment?: string;

  /**
   * API URL for accessing or modifying the referred object
   */
  related?: string;

  /**
   * CRN reference to the referred resource
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource_name?: string;
}

/**
 * The network associated with this object
 */
model ClusterNetworkEntity {
  /**
   * ID of the referred resource
   */
  id?: string;

  /**
   * Environment of the referred resource
   */
  environment?: string;

  /**
   * API URL for accessing or modifying the referred object
   */
  related?: string;

  /**
   * CRN reference to the referred resource
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource_name?: string;
}

/**
 * The network associated with this object
 */
model ClusterByokEntity {
  /**
   * ID of the referred resource
   */
  id?: string;

  /**
   * API URL for accessing or modifying the referred object
   */
  related?: string;

  /**
   * CRN reference to the referred resource
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource_name?: string;
}

/**
 * Status of the cluster record
 */
model ClusterStatusEntity {
  /**
   * The lifecycle phase of the cluster
   */
  phase?: string;

  /**
   * The number of Confluent Kafka Units
   */
  cku?: int32;
}

/**
 * Details of the role bindings returned on successful response
 */
model AccessListRoleBindingsSuccessResponse {
  /**
   * Type of response
   */
  kind?: string;

  /**
   * Metadata of the list
   */
  metadata?: ConfluentListMetadata;

  /**
   * List of role binding
   */
  data?: RoleBindingRecord[];
}

/**
 * Details on principal, role name and crn pattern of a role binding
 */
model RoleBindingRecord {
  /**
   * The type of the resource.
   */
  kind?: string;

  /**
   * Id of the role binding
   */
  id?: string;

  /**
   * Metadata of the record
   */
  metadata?: MetadataEntity;

  /**
   * The principal User or Group to bind the role to
   */
  principal?: string;

  /**
   * The name of the role to bind to the principal
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  role_name?: string;

  /**
   * A CRN that specifies the scope and resource patterns necessary for the role to bind
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  crn_pattern?: string;
}

/**
 * Create role binding request model
 */
model AccessCreateRoleBindingRequestModel {
  /**
   * The principal User or Group to bind the role to
   */
  principal?: string;

  /**
   * The name of the role to bind to the principal
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  role_name?: string;

  /**
   * A CRN that specifies the scope and resource patterns necessary for the role to bind
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  crn_pattern?: string;
}

/**
 * Details of the role binding names returned on successful response
 */
model AccessRoleBindingNameListSuccessResponse {
  /**
   * Type of response
   */
  kind?: string;

  /**
   * Metadata of the list
   */
  metadata?: ConfluentListMetadata;

  /**
   * List of role binding names
   */
  data?: string[];
}

/**
 * Result of GET request to list Confluent operations.
 */
model GetEnvironmentsResponse is Azure.Core.Page<SCEnvironmentRecord>;

/**
 * Environment resource property
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EnvironmentProperties {
  /**
   * Stream governance configuration
   */
  streamGovernanceConfig?: StreamGovernanceConfig;

  /**
   * Metadata of the record
   */
  metadata?: SCMetadataEntity;
}

/**
 * Stream governance configuration
 */
model StreamGovernanceConfig {
  /**
   * Stream governance configuration
   */
  package?: Package;
}

/**
 * Metadata of the data record
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SCMetadataEntity {
  /**
   * Self lookup url
   */
  self?: string;

  /**
   * Resource name of the record
   */
  resourceName?: string;

  /**
   * Created Date Time
   */
  createdTimestamp?: string;

  /**
   * Updated Date time
   */
  updatedTimestamp?: string;

  /**
   * Deleted Date time
   */
  deletedTimestamp?: string;
}

/**
 * Result of GET request to list clusters in the environment of a confluent organization
 */
model ListClustersSuccessResponse is Azure.Core.Page<SCClusterRecord>;

/**
 * Service Connector Cluster Properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ClusterProperties {
  /**
   * Metadata of the record
   */
  metadata?: SCMetadataEntity;

  /**
   * Specification of the cluster
   */
  spec?: SCClusterSpecEntity;

  /**
   * Specification of the cluster status
   */
  status?: ClusterStatusEntity;
}

/**
 * Spec of the cluster record
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SCClusterSpecEntity {
  /**
   * The name of the cluster
   */
  name?: string;

  /**
   * The availability zone configuration of the cluster
   */
  availability?: string;

  /**
   * The cloud service provider
   */
  cloud?: string;

  /**
   * type of zone availability
   */
  zone?: string;

  /**
   * Stream governance configuration
   */
  package?: Package;

  /**
   * The cloud service provider region
   */
  region?: string;

  /**
   * The bootstrap endpoint used by Kafka clients to connect to the cluster
   */
  kafkaBootstrapEndpoint?: string;

  /**
   * The cluster HTTP request URL.
   */
  httpEndpoint?: string;

  /**
   * The Kafka API cluster endpoint
   */
  apiEndpoint?: string;

  /**
   * Specification of the cluster configuration
   */
  config?: ClusterConfigEntity;

  /**
   * Specification of the cluster environment
   */
  environment?: SCClusterNetworkEnvironmentEntity;

  /**
   * Specification of the cluster network
   */
  network?: SCClusterNetworkEnvironmentEntity;

  /**
   * Specification of the cluster byok
   */
  byok?: SCClusterByokEntity;
}

/**
 * The environment or the network to which cluster belongs
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SCClusterNetworkEnvironmentEntity {
  /**
   * ID of the referred resource
   */
  id?: string;

  /**
   * Environment of the referred resource
   */
  environment?: string;

  /**
   * API URL for accessing or modifying the referred object
   */
  related?: string;

  /**
   * CRN reference to the referred resource
   */
  resourceName?: string;
}

/**
 * The network associated with this object
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SCClusterByokEntity {
  /**
   * ID of the referred resource
   */
  id?: string;

  /**
   * API URL for accessing or modifying the referred object
   */
  related?: string;

  /**
   * CRN reference to the referred resource
   */
  resourceName?: string;
}

/**
 * Result of GET request to list schema registry clusters in the environment of a confluent organization
 */
model ListSchemaRegistryClustersResponse
  is Azure.Core.Page<SchemaRegistryClusterRecord>;

/**
 * Details of schema registry cluster record
 */
model SchemaRegistryClusterRecord {
  /**
   * Kind of the cluster
   */
  kind?: string;

  /**
   * Id of the cluster
   */
  id?: string;

  /**
   * Schema Registry Cluster Properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: SchemaRegistryClusterProperties;
}

/**
 * Schema Registry Cluster Properties
 */
model SchemaRegistryClusterProperties {
  /**
   * Metadata of the record
   */
  metadata?: SCMetadataEntity;

  /**
   * Specification of the schema registry cluster
   */
  spec?: SchemaRegistryClusterSpecEntity;

  /**
   * Specification of the cluster status
   */
  status?: SchemaRegistryClusterStatusEntity;
}

/**
 * Details of schema registry cluster spec
 */
model SchemaRegistryClusterSpecEntity {
  /**
   * Name of the schema registry cluster
   */
  name?: string;

  /**
   * Http endpoint of the cluster
   */
  httpEndpoint?: string;

  /**
   * Type of the cluster package Advanced, essentials
   */
  package?: string;

  /**
   * Region details of the schema registry cluster
   */
  region?: SchemaRegistryClusterEnvironmentRegionEntity;

  /**
   * Environment details of the schema registry cluster
   */
  environment?: SchemaRegistryClusterEnvironmentRegionEntity;

  /**
   * The cloud service provider
   */
  cloud?: string;
}

/**
 * The environment associated with this object
 */
model SchemaRegistryClusterEnvironmentRegionEntity {
  /**
   * ID of the referred resource
   */
  id?: string;

  /**
   * API URL for accessing or modifying the referred object
   */
  related?: string;

  /**
   * CRN reference to the referred resource
   */
  resourceName?: string;
}

/**
 * Status of the schema registry cluster record
 */
model SchemaRegistryClusterStatusEntity {
  /**
   * The lifecycle phase of the cluster
   */
  phase?: string;
}

/**
 * Result of POST request to list regions supported by confluent
 */
model ListRegionsSuccessResponse {
  /**
   * List of regions supported by confluent
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  data?: RegionRecord[];
}

/**
 * Details of region record
 */
model RegionRecord {
  /**
   * Kind of the cluster
   */
  kind?: string;

  /**
   * Id of the cluster
   */
  id?: string;

  /**
   * Region Properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: RegionProperties;
}

/**
 * Region Properties
 */
model RegionProperties {
  /**
   * Metadata of the record
   */
  metadata?: SCMetadataEntity;

  /**
   * Specification of the region
   */
  spec?: RegionSpecEntity;
}

/**
 * Region spec details
 */
model RegionSpecEntity {
  /**
   * Display Name of the region
   */
  name?: string;

  /**
   * Cloud provider name
   */
  cloud?: string;

  /**
   * Region name
   */
  regionName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  packages?: string[];
}

/**
 * Create API Key model
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CreateAPIKeyModel {
  /**
   * Name of the API Key
   */
  name?: string;

  /**
   * Description of the API Key
   */
  description?: string;
}

/**
 * Details API key
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model APIKeyRecord {
  /**
   * Type of api key
   */
  kind?: string;

  /**
   * Id of the api key
   */
  id?: string;

  /**
   * API Key Properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: APIKeyProperties;
}

/**
 * API Key Properties
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model APIKeyProperties {
  /**
   * Metadata of the record
   */
  metadata?: SCMetadataEntity;

  /**
   * Specification of the API Key
   */
  spec?: APIKeySpecEntity;
}

/**
 * Spec of the API Key record
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model APIKeySpecEntity {
  /**
   * The description of the API Key
   */
  description?: string;

  /**
   * The name of the API Key
   */
  name?: string;

  /**
   * API Key Secret
   */
  @visibility(Lifecycle.Create)
  @secret
  secret?: string;

  /**
   * Specification of the cluster
   */
  resource?: APIKeyResourceEntity;

  /**
   * Specification of the cluster
   */
  owner?: APIKeyOwnerEntity;
}

/**
 * API Key Resource details which can be kafka cluster or schema registry cluster
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model APIKeyResourceEntity {
  /**
   * Id of the resource
   */
  id?: string;

  /**
   * The environment of the api key
   */
  environment?: string;

  /**
   * API URL for accessing or modifying the api key resource object
   */
  related?: string;

  /**
   * CRN reference to the referred resource
   */
  resourceName?: string;

  /**
   * Type of the owner which can be service or user account
   */
  kind?: string;
}

/**
 * API Key Owner details which can be a user or service account
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model APIKeyOwnerEntity {
  /**
   * API Key owner id
   */
  id?: string;

  /**
   * API URL for accessing or modifying the referred object
   */
  related?: string;

  /**
   * CRN reference to the referred resource
   */
  resourceName?: string;

  /**
   * Type of the owner service or user account
   */
  kind?: string;
}

/**
 * The resource properties of the Connector
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConnectorResourceProperties {
  /**
   * Connector Info Base
   */
  connectorBasicInfo?: ConnectorInfoBase;

  /**
   * Connector Service type info base properties.
   */
  connectorServiceTypeInfo?: ConnectorServiceTypeInfoBase;

  /**
   * The connection information consumed by applications.
   */
  partnerConnectorInfo?: PartnerInfoBase;
}

/**
 * Connector Info Base properties
 */
model ConnectorInfoBase {
  /**
   * Connector Type
   */
  connectorType?: ConnectorType;

  /**
   * Connector Class
   */
  connectorClass?: ConnectorClass;

  /**
   * Connector Name
   */
  connectorName?: string;

  /**
   * Connector Id
   */
  connectorId?: string;

  /**
   * Connector Status
   */
  connectorState?: ConnectorStatus;
}

/**
 * The connector service type info
 */
@discriminator("connectorServiceType")
model ConnectorServiceTypeInfoBase {
  /**
   * The connector service type.
   */
  connectorServiceType: ConnectorServiceType;
}

/**
 * The partner info base
 */
@discriminator("partnerConnectorType")
model PartnerInfoBase {
  /**
   * The partner connector type.
   */
  partnerConnectorType: PartnerConnectorType;
}

/**
 * Result of GET request to list connectors in the cluster of a confluent organization
 */
model ListConnectorsSuccessResponse is Azure.Core.Page<ConnectorResource>;

/**
 * Result of GET request to list topics in the cluster of a confluent organization
 */
model ListTopicsSuccessResponse is Azure.Core.Page<TopicRecord>;

/**
 * Topic Properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TopicProperties {
  /**
   * Type of topic
   */
  kind?: string;

  /**
   * Topic Id returned by Confluent
   */
  topicId?: string;

  /**
   * Metadata of the record
   */
  metadata?: TopicMetadataEntity;

  /**
   * Partition Specification of the topic
   */
  partitions?: TopicsRelatedLink;

  /**
   * Config Specification of the topic
   */
  configs?: TopicsRelatedLink;

  /**
   * Input Config Specification of the topic
   */
  inputConfigs?: TopicsInputConfig[];

  /**
   * Partition Reassignment Specification of the topic
   */
  partitionsReassignments?: TopicsRelatedLink;

  /**
   * Partition count of the topic
   */
  partitionsCount?: string;

  /**
   * Replication factor of the topic
   */
  replicationFactor?: string;
}

/**
 * Metadata of the data record
 */
model TopicMetadataEntity {
  /**
   * Self lookup url
   */
  self?: string;

  /**
   * Resource name of the record
   */
  resourceName?: string;
}

/**
 * Partition Config spec of the topic record
 */
model TopicsRelatedLink {
  /**
   * Relationship of the topic
   */
  related?: string;
}

/**
 * Topics input config
 */
model TopicsInputConfig {
  /**
   * Name of the topic input config
   */
  name?: string;

  /**
   * Value of the topic input config
   */
  value?: string;
}

/**
 * Metadata of the list
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SCConfluentListMetadata {
  /**
   * First page of the list
   */
  first?: string;

  /**
   * Last page of the list
   */
  last?: string;

  /**
   * Previous page of the list
   */
  prev?: string;

  /**
   * Next page of the list
   */
  next?: string;

  /**
   * Total size of the list
   */
  totalSize?: int32;
}

/**
 * The authentication info when auth_type is azureBlobStorageSinkConnector
 */
model AzureBlobStorageSinkConnectorServiceInfo
  extends ConnectorServiceTypeInfoBase {
  /**
   * Azure Blob Storage Account Name
   */
  storageAccountName?: string;

  /**
   * Azure Blob Storage Account Key
   */
  storageAccountKey?: string;

  /**
   * Azure Blob Storage Account Container Name
   */
  storageContainerName?: string;

  /**
   * The connector service type.
   */
  connectorServiceType: "AzureBlobStorageSinkConnector";
}

/**
 * The connector service type is AzureBlobStorageSourceConnector
 */
model AzureBlobStorageSourceConnectorServiceInfo
  extends ConnectorServiceTypeInfoBase {
  /**
   * Azure Blob Storage Account Name
   */
  storageAccountName?: string;

  /**
   * Azure Blob Storage Account Key
   */
  @secret
  storageAccountKey?: string;

  /**
   * Azure Blob Storage Account Container Name
   */
  storageContainerName?: string;

  /**
   * The connector service type.
   */
  connectorServiceType: "AzureBlobStorageSourceConnector";
}

/**
 * The authentication info when auth_type is AzureCosmosDBSinkConnector
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureCosmosDBSinkConnectorServiceInfo
  extends ConnectorServiceTypeInfoBase {
  /**
   * Azure Cosmos Database Name
   */
  cosmosDatabaseName?: string;

  /**
   * Azure Cosmos Database Master Key
   */
  cosmosMasterKey?: string;

  /**
   * Azure Cosmos Database Connection Endpoint
   */
  cosmosConnectionEndpoint?: string;

  /**
   * Azure Cosmos Database Containers Topic Mapping
   */
  cosmosContainersTopicMapping?: string;

  /**
   * Azure Cosmos Database Id Strategy
   */
  cosmosIdStrategy?: string;

  /**
   * The connector service type.
   */
  connectorServiceType: "AzureCosmosDBSinkConnector";
}

/**
 * The authentication info when auth_type is AzureCosmosDBSourceConnector
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureCosmosDBSourceConnectorServiceInfo
  extends ConnectorServiceTypeInfoBase {
  /**
   * Azure Cosmos Database Name
   */
  cosmosDatabaseName?: string;

  /**
   * Azure Cosmos Database Master Key
   */
  cosmosMasterKey?: string;

  /**
   * Azure Cosmos Database Connection Endpoint
   */
  cosmosConnectionEndpoint?: string;

  /**
   * Azure Cosmos Database Containers Topic Mapping
   */
  cosmosContainersTopicMapping?: string;

  /**
   * Azure Cosmos Database Message Key Enabled
   */
  cosmosMessageKeyEnabled?: boolean;

  /**
   * Azure Cosmos Database Message Key Field
   */
  cosmosMessageKeyField?: string;

  /**
   * The connector service type.
   */
  connectorServiceType: "AzureCosmosDBSourceConnector";
}

/**
 * The authentication info when auth_type is AzureSynapseAnalyticsSinkConnector
 */
model AzureSynapseAnalyticsSinkConnectorServiceInfo
  extends ConnectorServiceTypeInfoBase {
  /**
   * Azure Synapse Analytics SQL Server Name
   */
  synapseSqlServerName?: string;

  /**
   * Azure Synapse SQL login details
   */
  synapseSqlUser?: string;

  /**
   * Azure Synapse SQL login details
   */
  synapseSqlPassword?: string;

  /**
   * Azure Synapse Dedicated SQL Pool Database Name
   */
  synapseSqlDatabaseName?: string;

  /**
   * The connector service type.
   */
  connectorServiceType: "AzureSynapseAnalyticsSinkConnector";
}

/**
 * The partner connector type is KafkaAzureBlobStorageSink
 */
model KafkaAzureBlobStorageSinkConnectorInfo extends PartnerInfoBase {
  /**
   * Kafka Auth Type
   */
  authType?: AuthType;

  /**
   * Kafka Input Data Format Type
   */
  inputFormat?: DataFormatType;

  /**
   * Kafka Output Data Format Type
   */
  outputFormat?: DataFormatType;

  /**
   * Kafka API Key
   */
  apiKey?: string;

  /**
   * Kafka API Key Secret
   */
  apiSecret?: string;

  /**
   * Kafka Service Account Id
   */
  serviceAccountId?: string;

  /**
   * Kafka topics list
   */
  topics?: string[];

  /**
   * Kafka topics directory
   */
  topicsDir?: string;

  /**
   * Flush size
   */
  flushSize?: string;

  /**
   * Maximum Tasks
   */
  maxTasks?: string;

  /**
   * Time Interval
   */
  timeInterval?: string;

  /**
   * The partner connector type.
   */
  partnerConnectorType: "KafkaAzureBlobStorageSink";
}

/**
 * The partner connector type is KafkaAzureBlobStorageSource
 */
model KafkaAzureBlobStorageSourceConnectorInfo extends PartnerInfoBase {
  /**
   * Kafka Auth Type
   */
  authType?: AuthType;

  /**
   * Kafka Input Data Format Type
   */
  inputFormat?: DataFormatType;

  /**
   * Kafka Output Data Format Type
   */
  outputFormat?: DataFormatType;

  /**
   * Kafka API Key
   */
  apiKey?: string;

  /**
   * Kafka API Secret
   */
  @secret
  apiSecret?: string;

  /**
   * Kafka Service Account Id
   */
  serviceAccountId?: string;

  /**
   * Kafka topics Regex pattern
   */
  topicRegex?: string;

  /**
   * Kafka topics directory
   */
  topicsDir?: string;

  /**
   * Maximum Tasks
   */
  maxTasks?: string;

  /**
   * The partner connector type.
   */
  partnerConnectorType: "KafkaAzureBlobStorageSource";
}

/**
 * The partner connector type is KafkaAzureCosmosDBSink
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KafkaAzureCosmosDBSinkConnectorInfo extends PartnerInfoBase {
  /**
   * Kafka Auth Type
   */
  authType?: AuthType;

  /**
   * Kafka Input Data Format Type
   */
  inputFormat?: DataFormatType;

  /**
   * Kafka Output Data Format Type
   */
  outputFormat?: DataFormatType;

  /**
   * Kafka API Key
   */
  apiKey?: string;

  /**
   * Kafka API Key Secret
   */
  apiSecret?: string;

  /**
   * Kafka Service Account Id
   */
  serviceAccountId?: string;

  /**
   * Kafka topics list
   */
  topics?: string[];

  /**
   * Kafka topics directory
   */
  topicsDir?: string;

  /**
   * Flush size
   */
  flushSize?: string;

  /**
   * Maximum Tasks
   */
  maxTasks?: string;

  /**
   * Time Interval
   */
  timeInterval?: string;

  /**
   * The partner connector type.
   */
  partnerConnectorType: "KafkaAzureCosmosDBSink";
}

/**
 * The partner connector type is KafkaAzureCosmosDBSource
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KafkaAzureCosmosDBSourceConnectorInfo extends PartnerInfoBase {
  /**
   * Kafka Auth Type
   */
  authType?: AuthType;

  /**
   * Kafka Input Data Format Type
   */
  inputFormat?: DataFormatType;

  /**
   * Kafka Output Data Format Type
   */
  outputFormat?: DataFormatType;

  /**
   * Kafka API Key
   */
  apiKey?: string;

  /**
   * Kafka API Secret
   */
  @secret
  apiSecret?: string;

  /**
   * Kafka Service Account Id
   */
  serviceAccountId?: string;

  /**
   * Kafka topics Regex pattern
   */
  topicRegex?: string;

  /**
   * Kafka topics directory
   */
  topicsDir?: string;

  /**
   * Maximum Tasks
   */
  maxTasks?: string;

  /**
   * The partner connector type.
   */
  partnerConnectorType: "KafkaAzureCosmosDBSource";
}

/**
 * The partner connector type is KafkaAzureSynapseAnalyticsSink
 */
model KafkaAzureSynapseAnalyticsSinkConnectorInfo extends PartnerInfoBase {
  /**
   * Kafka Auth Type
   */
  authType?: AuthType;

  /**
   * Kafka Input Data Format Type
   */
  inputFormat?: DataFormatType;

  /**
   * Kafka Output Data Format Type
   */
  outputFormat?: DataFormatType;

  /**
   * Kafka API Key
   */
  apiKey?: string;

  /**
   * Kafka API Key Secret
   */
  apiSecret?: string;

  /**
   * Kafka Service Account Id
   */
  serviceAccountId?: string;

  /**
   * Kafka topics list
   */
  topics?: string[];

  /**
   * Kafka topics directory
   */
  topicsDir?: string;

  /**
   * Flush size
   */
  flushSize?: string;

  /**
   * Maximum Tasks
   */
  maxTasks?: string;

  /**
   * Time Interval
   */
  timeInterval?: string;

  /**
   * The partner connector type.
   */
  partnerConnectorType: "KafkaAzureSynapseAnalyticsSink";
}
