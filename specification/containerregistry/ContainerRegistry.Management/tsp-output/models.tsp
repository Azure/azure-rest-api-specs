import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ContainerRegistry;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * When Force, any existing target tags will be overwritten. When NoForce, any existing target tags will fail the operation before any copying begins.
 */
enum ImportMode {
  NoForce,
  Force,
}

/**
 * The private link service connection status.
 */
enum ConnectionStatus {
  Approved,
  Pending,
  Rejected,
  Disconnected,
}

/**
 * A message indicating if changes on the service provider require any updates on the consumer.
 */
enum ActionsRequired {
  None,
  Recreate,
}

/**
 * The provisioning state of this agent pool
 */
enum ProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
}

/**
 * The type of identity that last modified the resource.
 */
enum LastModifiedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

/**
 * The SKU name of the container registry. Required for registry creation.
 */
enum SkuName {
  Classic,
  Basic,
  Standard,
  Premium,
}

/**
 * The default action of allow or deny when no other rules match.
 */
enum DefaultAction {
  Allow,
  Deny,
}

/**
 * The action of IP ACL rule.
 */
enum Action {
  Allow,
}

/**
 * The value that indicates whether the policy is enabled or not.
 */
enum PolicyStatus {
  enabled,
  disabled,
}

/**
 * The type of trust policy.
 */
enum TrustPolicyType {
  Notary,
}

/**
 * The value that indicates whether the policy is enabled or not.
 */
enum ExportPolicyStatus {
  enabled,
  disabled,
}

/**
 * Indicates whether or not the encryption is enabled for container registry.
 */
enum EncryptionStatus {
  enabled,
  disabled,
}

/**
 * Whether or not public network access is allowed for the container registry.
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * Whether to allow trusted Azure services to access a network restricted registry.
 */
enum NetworkRuleBypassOptions {
  AzureServices,
  None,
}

/**
 * Whether or not zone redundancy is enabled for this container registry
 */
enum ZoneRedundancy {
  Enabled,
  Disabled,
}

/**
 * The unit of measurement.
 */
enum RegistryUsageUnit {
  Count,
  Bytes,
}

enum TokenCertificateName {
  certificate1,
  certificate2,
}

/**
 * The password name "password1" or "password2"
 */
enum TokenPasswordName {
  password1,
  password2,
}

/**
 * The status of the token example enabled or disabled.
 */
enum TokenStatus {
  enabled,
  disabled,
}

/**
 * The status of the webhook at the time the operation was called.
 */
enum WebhookStatus {
  enabled,
  disabled,
}

enum WebhookAction {
  push,
  delete,
  quarantine,
  chart_push,
  chart_delete,
}

/**
 * The OS of agent machine
 */
enum OS {
  Windows,
  Linux,
}

/**
 * The current status of the run.
 */
enum RunStatus {
  Queued,
  Started,
  Running,
  Succeeded,
  Failed,
  Canceled,
  Error,
  Timeout,
}

/**
 * The type of run.
 */
enum RunType {
  QuickBuild,
  QuickRun,
  AutoBuild,
  AutoRun,
}

/**
 * The OS architecture.
 */
enum Architecture {
  amd64,
  x86,
  `386`,
  arm,
  arm64,
}

/**
 * Variant of the CPU.
 */
enum Variant {
  v6,
  v7,
  v8,
}

/**
 * The current status of task.
 */
enum TaskStatus {
  Disabled,
  Enabled,
}

/**
 * The type of the step.
 */
enum StepType {
  Docker,
  FileTask,
  EncodedTask,
}

/**
 * The type of the base image dependency.
 */
enum BaseImageDependencyType {
  BuildTime,
  RunTime,
}

/**
 * The current status of trigger.
 */
enum TriggerStatus {
  Disabled,
  Enabled,
}

/**
 * The type of source control service.
 */
enum SourceControlType {
  Github,
  VisualStudioTeamService,
}

/**
 * The type of Auth token.
 */
enum TokenType {
  PAT,
  OAuth,
}

enum SourceTriggerEvent {
  commit,
  pullrequest,
}

/**
 * The type of the auto trigger for base image dependency updates.
 */
enum BaseImageTriggerType {
  All,
  Runtime,
}

/**
 * Type of Payload body for Base image update triggers.
 */
enum UpdateTriggerPayloadType {
  Default,
  Token,
}

/**
* The authentication mode which determines the source registry login scope. The credentials for the source registry
will be generated using the given scope. These credentials will be used to login to
the source registry during the run.
*/
enum SourceRegistryLoginMode {
  None,
  Default,
}

/**
* The type of the secret object which determines how the value of the secret object has to be
interpreted.
*/
enum SecretObjectType {
  Opaque,
  Vaultsecret,
}

/**
 * The identity type.
 */
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The password name.
 */
@fixed
enum PasswordName {
  password,
  password2,
}

model ImportImageParameters {
  /**
   * The source of the image.
   */
  source: ImportSource;

  /**
   * List of strings of the form repo[:tag]. When tag is omitted the source will be used (or 'latest' if source tag is also omitted).
   */
  targetTags?: string[];

  /**
   * List of strings of repository names to do a manifest only copy. No tag will be created.
   */
  untaggedTargetRepositories?: string[];

  /**
   * When Force, any existing target tags will be overwritten. When NoForce, any existing target tags will fail the operation before any copying begins.
   */
  mode?: ImportMode = ImportMode.NoForce;
}

model ImportSource {
  /**
   * The resource identifier of the source Azure Container Registry.
   */
  resourceId?: string;

  /**
   * The address of the source registry (e.g. 'mcr.microsoft.com').
   */
  registryUri?: string;

  /**
   * Credentials used when importing from a registry uri.
   */
  credentials?: ImportSourceCredentials;

  /**
* Repository name of the source image.
Specify an image by repository ('hello-world'). This will use the 'latest' tag.
Specify an image by tag ('hello-world:latest').
Specify an image by sha256-based manifest digest ('hello-world@sha256:abc123').
*/
  sourceImage: string;
}

model ImportSourceCredentials {
  /**
   * The username to authenticate with the source registry.
   */
  username?: string;

  /**
   * The password used to authenticate with the source registry.
   */
  password: string;
}

/**
 * The definition of a container registry operation.
 */
model OperationDefinition {
  /**
   * The origin information of the container registry operation.
   */
  origin?: string;

  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * The display information for the container registry operation.
   */
  display?: OperationDisplayDefinition;

  /**
   * The properties information for the container registry operation.
   */
  properties?: OperationPropertiesDefinition;

  /**
* This property indicates if the operation is an action or a data action
ref: https://docs.microsoft.com/en-us/azure/role-based-access-control/role-definitions#management-and-data-operations
*/
  isDataAction?: boolean;
}

/**
 * The display information for a container registry operation.
 */
model OperationDisplayDefinition {
  /**
   * The resource provider name: Microsoft.ContainerRegistry.
   */
  provider?: string;

  /**
   * The resource on which the operation is performed.
   */
  resource?: string;

  /**
   * The operation that users can perform.
   */
  operation?: string;

  /**
   * The description for the operation.
   */
  description?: string;
}

/**
 * The definition of Azure Monitoring properties.
 */
model OperationPropertiesDefinition {
  /**
   * The definition of Azure Monitoring service.
   */
  serviceSpecification?: OperationServiceSpecificationDefinition;
}

/**
 * The definition of Azure Monitoring list.
 */
model OperationServiceSpecificationDefinition {
  /**
   * A list of Azure Monitoring metrics definition.
   */
  metricSpecifications?: OperationMetricSpecificationDefinition[];

  /**
   * A list of Azure Monitoring log definitions.
   */
  logSpecifications?: OperationLogSpecificationDefinition[];
}

/**
 * The definition of Azure Monitoring metric.
 */
model OperationMetricSpecificationDefinition {
  /**
   * Metric name.
   */
  name?: string;

  /**
   * Metric display name.
   */
  displayName?: string;

  /**
   * Metric description.
   */
  displayDescription?: string;

  /**
   * Metric unit.
   */
  unit?: string;

  /**
   * Metric aggregation type.
   */
  aggregationType?: string;

  /**
   * Internal metric name.
   */
  internalMetricName?: string;
}

/**
 * The definition of Azure Monitoring log.
 */
model OperationLogSpecificationDefinition {
  /**
   * Log name.
   */
  name?: string;

  /**
   * Log display name.
   */
  displayName?: string;

  /**
   * Log blob duration.
   */
  blobDuration?: string;
}

/**
 * A request to check whether a container registry name is available.
 */
model RegistryNameCheckRequest {
  /**
   * The name of the container registry.
   */
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]*$")
  name: string;

  /**
   * The resource type of the container registry. This field must be set to 'Microsoft.ContainerRegistry/registries'.
   */
  type: "Microsoft.ContainerRegistry/registries";
}

/**
 * The result of a request to check the availability of a container registry name.
 */
model RegistryNameStatus {
  /**
   * The value that indicates whether the name is available.
   */
  nameAvailable?: boolean;

  /**
   * If any, the reason that the name is not available.
   */
  reason?: string;

  /**
   * If any, the error message that provides more detail for the reason that the name is not available.
   */
  message?: string;
}

/**
 * The properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private endpoint.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * This is private endpoint resource created with Microsoft.Network resource provider.
   */
  id?: string;
}

/**
 * The state of a private link service connection.
 */
model PrivateLinkServiceConnectionState {
  /**
   * The private link service connection status.
   */
  status?: ConnectionStatus;

  /**
   * The description for connection status. For example if connection is rejected it can indicate reason for rejection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: ActionsRequired;
}

/**
 * The SKU of a container registry.
 */
model Sku {
  /**
   * The SKU name of the container registry. Required for registry creation.
   */
  name: SkuName;

  /**
   * The SKU tier based on the SKU name.
   */
  @visibility("read")
  tier?: SkuTier;
}

/**
 * Managed identity for the resource.
 */
model IdentityProperties {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: ResourceIdentityType;

  /**
* The list of user identities associated with the resource. The user identity 
dictionary key references will be ARM resource ids in the form: 
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/
    providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
*/
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

model UserIdentityProperties {
  /**
   * The principal id of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * The properties of a container registry.
 */
model RegistryProperties {
  /**
   * The URL that can be used to log into the container registry.
   */
  @visibility("read")
  loginServer?: string;

  /**
   * The creation date of the container registry in ISO8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The provisioning state of the container registry at the time the operation was called.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The status of the container registry at the time the operation was called.
   */
  @visibility("read")
  status?: Status;

  /**
   * The value that indicates whether the admin user is enabled.
   */
  adminUserEnabled?: boolean;

  /**
   * The network rule set for a container registry.
   */
  networkRuleSet?: NetworkRuleSet;

  /**
   * The policies for a container registry.
   */
  policies?: Policies;

  /**
   * The encryption settings of container registry.
   */
  encryption?: EncryptionProperty;

  /**
   * Enable a single data endpoint per region for serving data.
   */
  dataEndpointEnabled?: boolean;

  /**
   * List of host names that will serve data when dataEndpointEnabled is true.
   */
  @visibility("read")
  dataEndpointHostNames?: string[];

  /**
   * List of private endpoint connections for a container registry.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Whether or not public network access is allowed for the container registry.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Whether to allow trusted Azure services to access a network restricted registry.
   */
  networkRuleBypassOptions?: NetworkRuleBypassOptions;

  /**
   * Whether or not zone redundancy is enabled for this container registry
   */
  zoneRedundancy?: ZoneRedundancy;
}

/**
 * The status of an Azure resource at the time the operation was called.
 */
model Status {
  /**
   * The short label for the status.
   */
  @visibility("read")
  displayStatus?: string;

  /**
   * The detailed message for the status, including alerts and error messages.
   */
  @visibility("read")
  message?: string;

  /**
   * The timestamp when the status was changed to the current value.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;
}

/**
 * The network rule set for a container registry.
 */
model NetworkRuleSet {
  /**
   * The default action of allow or deny when no other rules match.
   */
  defaultAction: DefaultAction = DefaultAction.Allow;

  /**
   * The IP ACL rules.
   */
  ipRules?: IPRule[];
}

/**
 * IP rule with specific IP or IP range in CIDR format.
 */
model IPRule {
  /**
   * The action of IP ACL rule.
   */
  action?: Action = Action.Allow;

  /**
   * Specifies the IP or IP range in CIDR format. Only IPV4 address is allowed.
   */
  @projectedName("json", "value")
  IPAddressOrRange: string;
}

/**
 * The policies for a container registry.
 */
model Policies {
  /**
   * The quarantine policy for a container registry.
   */
  quarantinePolicy?: QuarantinePolicy;

  /**
   * The content trust policy for a container registry.
   */
  trustPolicy?: TrustPolicy;

  /**
   * The retention policy for a container registry.
   */
  retentionPolicy?: RetentionPolicy;

  /**
   * The export policy for a container registry.
   */
  exportPolicy?: ExportPolicy;
}

/**
 * The quarantine policy for a container registry.
 */
model QuarantinePolicy {
  /**
   * The value that indicates whether the policy is enabled or not.
   */
  status?: PolicyStatus;
}

/**
 * The content trust policy for a container registry.
 */
model TrustPolicy {
  /**
   * The type of trust policy.
   */
  type?: TrustPolicyType = TrustPolicyType.Notary;

  /**
   * The value that indicates whether the policy is enabled or not.
   */
  status?: PolicyStatus;
}

/**
 * The retention policy for a container registry.
 */
model RetentionPolicy {
  /**
   * The number of days to retain an untagged manifest after which it gets purged.
   */
  days?: int32 = 7;

  /**
   * The timestamp when the policy was last updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * The value that indicates whether the policy is enabled or not.
   */
  status?: PolicyStatus;
}

/**
 * The export policy for a container registry.
 */
model ExportPolicy {
  /**
   * The value that indicates whether the policy is enabled or not.
   */
  status?: ExportPolicyStatus = ExportPolicyStatus.enabled;
}

model EncryptionProperty {
  /**
   * Indicates whether or not the encryption is enabled for container registry.
   */
  status?: EncryptionStatus;

  /**
   * Key vault properties.
   */
  keyVaultProperties?: KeyVaultProperties;
}

model KeyVaultProperties {
  /**
   * Key vault uri to access the encryption key.
   */
  keyIdentifier?: string;

  /**
   * The fully qualified key identifier that includes the version of the key that is actually used for encryption.
   */
  @visibility("read")
  versionedKeyIdentifier?: string;

  /**
   * The client id of the identity which will be used to access key vault.
   */
  identity?: string;

  /**
   * Auto key rotation status for a CMK enabled registry.
   */
  @visibility("read")
  keyRotationEnabled?: boolean;

  /**
   * Timestamp of the last successful key rotation.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastKeyRotationTimestamp?: utcDateTime;
}

/**
 * An Azure resource.
 */
model Resource {
  /**
   * The resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;

  /**
   * The location of the resource. This cannot be changed after the resource is created.
   */
  @visibility("read", "create")
  location: string;

  /**
   * The tags of the resource.
   */
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The parameters for updating a container registry.
 */
model RegistryUpdateParameters {
  /**
   * The identity of the container registry.
   */
  identity?: IdentityProperties;

  /**
   * The tags for the container registry.
   */
  tags?: Record<string>;

  /**
   * The SKU of the container registry.
   */
  sku?: Sku;

  /**
   * The properties that the container registry will be updated with.
   */
  properties?: RegistryPropertiesUpdateParameters;
}

/**
 * The parameters for updating the properties of a container registry.
 */
model RegistryPropertiesUpdateParameters {
  /**
   * The value that indicates whether the admin user is enabled.
   */
  adminUserEnabled?: boolean;

  /**
   * The network rule set for a container registry.
   */
  networkRuleSet?: NetworkRuleSet;

  /**
   * The policies for a container registry.
   */
  policies?: Policies;

  /**
   * The encryption settings of container registry.
   */
  encryption?: EncryptionProperty;

  /**
   * Enable a single data endpoint per region for serving data.
   */
  dataEndpointEnabled?: boolean;

  /**
   * Whether or not public network access is allowed for the container registry.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Whether to allow trusted Azure services to access a network restricted registry.
   */
  networkRuleBypassOptions?: NetworkRuleBypassOptions;
}

/**
 * The result of a request to get container registry quota usages.
 */
model RegistryUsageListResult {
  /**
   * The list of container registry quota usages.
   */
  value?: RegistryUsage[];
}

/**
 * The quota usage for a container registry.
 */
model RegistryUsage {
  /**
   * The name of the usage.
   */
  name?: string;

  /**
   * The limit of the usage.
   */
  limit?: int64;

  /**
   * The current value of the usage.
   */
  currentValue?: int64;

  /**
   * The unit of measurement.
   */
  unit?: RegistryUsageUnit;
}

/**
 * The properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * An error response from the Azure Container Registry service.
 */
model ErrorResponseBody {
  /**
   * error code.
   */
  code: string;

  /**
   * error message.
   */
  message: string;

  /**
   * target of the particular error.
   */
  target?: string;

  /**
   * an array of additional nested error response info objects, as described by this contract.
   */
  details?: InnerErrorDescription[];
}

/**
 * inner error.
 */
model InnerErrorDescription {
  /**
   * error code.
   */
  code: string;

  /**
   * error message.
   */
  message: string;

  /**
   * target of the particular error.
   */
  target?: string;
}

/**
 * The response from the ListCredentials operation.
 */
model RegistryListCredentialsResult {
  /**
   * The username for a container registry.
   */
  username?: string;

  /**
   * The list of passwords for a container registry.
   */
  passwords?: RegistryPassword[];
}

/**
 * The login password for the container registry.
 */
model RegistryPassword {
  /**
   * The password name.
   */
  name?: PasswordName;

  /**
   * The password value.
   */
  value?: string;
}

/**
 * The parameters used to regenerate the login credential.
 */
model RegenerateCredentialParameters {
  /**
   * Specifies name of the password which should be regenerated -- password or password2.
   */
  name: PasswordName;
}

/**
 * The properties of a replication.
 */
model ReplicationProperties {
  /**
   * The provisioning state of the replication at the time the operation was called.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The status of the replication at the time the operation was called.
   */
  @visibility("read")
  status?: Status;

  /**
   * Specifies whether the replication's regional endpoint is enabled. Requests will not be routed to a replication whose regional endpoint is disabled, however its data will continue to be synced with other replications.
   */
  regionEndpointEnabled?: boolean = true;

  /**
   * Whether or not zone redundancy is enabled for this container registry replication
   */
  zoneRedundancy?: ZoneRedundancy;
}

/**
 * The parameters for updating a replication.
 */
model ReplicationUpdateParameters {
  /**
   * The tags for the replication.
   */
  tags?: Record<string>;

  /**
   * The parameters for updating a replication's properties
   */
  properties?: ReplicationUpdateParametersProperties;
}

model ReplicationUpdateParametersProperties {
  /**
   * Specifies whether the replication's regional endpoint is enabled. Requests will not be routed to a replication whose regional endpoint is disabled, however its data will continue to be synced with other replications.
   */
  regionEndpointEnabled?: boolean;
}

/**
 * The properties of a scope map.
 */
model ScopeMapProperties {
  /**
   * The user friendly description of the scope map.
   */
  description?: string;

  /**
   * The type of the scope map. E.g. BuildIn scope map.
   */
  @visibility("read")
  type?: string;

  /**
   * The creation date of scope map.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
* The list of scoped permissions for registry artifacts.
E.g. repositories/repository-name/content/read,
repositories/repository-name/metadata/write
*/
  actions: string[];
}

/**
 * The properties for updating the scope map.
 */
model ScopeMapUpdateParameters {
  /**
   * The update parameters for scope map properties.
   */
  properties?: ScopeMapPropertiesUpdateParameters;
}

/**
 * The update parameters for scope map properties.
 */
model ScopeMapPropertiesUpdateParameters {
  /**
   * The user friendly description of the scope map.
   */
  description?: string;

  /**
* The list of scope permissions for registry artifacts.
E.g. repositories/repository-name/pull, 
repositories/repository-name/delete
*/
  actions?: string[];
}

/**
 * The properties of a token.
 */
model TokenProperties {
  /**
   * The creation date of scope map.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The resource ID of the scope map to which the token will be associated with.
   */
  scopeMapId?: string;

  /**
   * The credentials that can be used for authenticating the token.
   */
  credentials?: TokenCredentialsProperties;

  /**
   * The status of the token example enabled or disabled.
   */
  status?: TokenStatus;
}

/**
 * The properties of the credentials that can be used for authenticating the token.
 */
model TokenCredentialsProperties {
  certificates?: TokenCertificate[];
  passwords?: TokenPassword[];
}

/**
 * The properties of a certificate used for authenticating a token.
 */
model TokenCertificate {
  name?: TokenCertificateName;

  /**
   * The expiry datetime of the certificate.
   */
  @projectedName("json", "expiry")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expireOn?: utcDateTime;

  /**
   * The thumbprint of the certificate.
   */
  thumbprint?: string;

  /**
   * Base 64 encoded string of the public certificate1 in PEM format that will be used for authenticating the token.
   */
  encodedPemCertificate?: string;
}

/**
 * The password that will be used for authenticating the token of a container registry.
 */
model TokenPassword {
  /**
   * The creation datetime of the password.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The expiry datetime of the password.
   */
  @projectedName("json", "expiry")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expireOn?: utcDateTime;

  /**
   * The password name "password1" or "password2"
   */
  name?: TokenPasswordName;

  /**
   * The password value.
   */
  @visibility("read")
  value?: string;
}

/**
 * The parameters for updating a token.
 */
model TokenUpdateParameters {
  /**
   * The properties of the token update parameters.
   */
  properties?: TokenUpdateProperties;
}

/**
 * The parameters for updating token properties.
 */
model TokenUpdateProperties {
  /**
   * The resource ID of the scope map to which the token will be associated with.
   */
  scopeMapId?: string;

  /**
   * The status of the token example enabled or disabled.
   */
  status?: TokenStatus;

  /**
   * The credentials that can be used for authenticating the token.
   */
  credentials?: TokenCredentialsProperties;
}

/**
 * The parameters used to generate credentials for a specified token or user of a container registry.
 */
model GenerateCredentialsParameters {
  /**
   * The resource ID of the token for which credentials have to be generated.
   */
  tokenId?: string;

  /**
   * The expiry date of the generated credentials after which the credentials become invalid.
   */
  @projectedName("json", "expiry")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expireOn?: utcDateTime;

  /**
   * Specifies name of the password which should be regenerated if any -- password1 or password2.
   */
  name?: TokenPasswordName;
}

/**
 * The response from the GenerateCredentials operation.
 */
model GenerateCredentialsResult {
  /**
   * The username for a container registry.
   */
  username?: string;

  /**
   * The list of passwords for a container registry.
   */
  passwords?: TokenPassword[];
}

/**
 * The properties of a webhook.
 */
model WebhookProperties {
  /**
   * The status of the webhook at the time the operation was called.
   */
  status?: WebhookStatus;

  /**
   * The scope of repositories where the event can be triggered. For example, 'foo:*' means events for all tags under repository 'foo'. 'foo:bar' means events for 'foo:bar' only. 'foo' is equivalent to 'foo:latest'. Empty means all events.
   */
  scope?: string;

  /**
   * The list of actions that trigger the webhook to post notifications.
   */
  actions: WebhookAction[];

  /**
   * The provisioning state of the webhook at the time the operation was called.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The parameters for creating a webhook.
 */
model WebhookCreateParameters {
  /**
   * The tags for the webhook.
   */
  tags?: Record<string>;

  /**
   * The location of the webhook. This cannot be changed after the resource is created.
   */
  location: string;

  /**
   * The properties that the webhook will be created with.
   */
  properties?: WebhookPropertiesCreateParameters;
}

/**
 * The parameters for creating the properties of a webhook.
 */
model WebhookPropertiesCreateParameters {
  /**
   * The service URI for the webhook to post notifications.
   */
  serviceUri: string;

  /**
   * Custom headers that will be added to the webhook notifications.
   */
  customHeaders?: Record<string>;

  /**
   * The status of the webhook at the time the operation was called.
   */
  status?: WebhookStatus;

  /**
   * The scope of repositories where the event can be triggered. For example, 'foo:*' means events for all tags under repository 'foo'. 'foo:bar' means events for 'foo:bar' only. 'foo' is equivalent to 'foo:latest'. Empty means all events.
   */
  scope?: string;

  /**
   * The list of actions that trigger the webhook to post notifications.
   */
  actions: WebhookAction[];
}

/**
 * The parameters for updating a webhook.
 */
model WebhookUpdateParameters {
  /**
   * The tags for the webhook.
   */
  tags?: Record<string>;

  /**
   * The properties that the webhook will be updated with.
   */
  properties?: WebhookPropertiesUpdateParameters;
}

/**
 * The parameters for updating the properties of a webhook.
 */
model WebhookPropertiesUpdateParameters {
  /**
   * The service URI for the webhook to post notifications.
   */
  serviceUri?: string;

  /**
   * Custom headers that will be added to the webhook notifications.
   */
  customHeaders?: Record<string>;

  /**
   * The status of the webhook at the time the operation was called.
   */
  status?: WebhookStatus;

  /**
   * The scope of repositories where the event can be triggered. For example, 'foo:*' means events for all tags under repository 'foo'. 'foo:bar' means events for 'foo:bar' only. 'foo' is equivalent to 'foo:latest'. Empty means all events.
   */
  scope?: string;

  /**
   * The list of actions that trigger the webhook to post notifications.
   */
  actions?: WebhookAction[];
}

/**
 * The basic information of an event.
 */
model EventInfo {
  /**
   * The event ID.
   */
  id?: string;
}

/**
 * The result of a request to list events for a webhook.
 */
model EventListResult is Azure.Core.Page<Event>;

/**
 * The event for a webhook.
 */
model Event extends EventInfo {
  /**
   * The event request message sent to the service URI.
   */
  eventRequestMessage?: EventRequestMessage;

  /**
   * The event response message received from the service URI.
   */
  eventResponseMessage?: EventResponseMessage;
}

/**
 * The event request message sent to the service URI.
 */
model EventRequestMessage {
  /**
   * The content of the event request message.
   */
  content?: EventContent;

  /**
   * The headers of the event request message.
   */
  headers?: Record<string>;

  /**
   * The HTTP method used to send the event request message.
   */
  method?: string;

  /**
   * The URI used to send the event request message.
   */
  requestUri?: string;

  /**
   * The HTTP message version.
   */
  version?: string;
}

/**
 * The content of the event request message.
 */
model EventContent {
  /**
   * The event ID.
   */
  id?: string;

  /**
   * The time at which the event occurred.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The action that encompasses the provided event.
   */
  action?: string;

  /**
   * The target of the event.
   */
  target?: Target;

  /**
   * The request that generated the event.
   */
  request?: Request;

  /**
   * The agent that initiated the event. For most situations, this could be from the authorization context of the request.
   */
  actor?: Actor;

  /**
   * The registry node that generated the event. Put differently, while the actor initiates the event, the source generates it.
   */
  source?: Source;
}

/**
 * The target of the event.
 */
model Target {
  /**
   * The MIME type of the referenced object.
   */
  mediaType?: string;

  /**
   * The number of bytes of the content. Same as Length field.
   */
  size?: int64;

  /**
   * The digest of the content, as defined by the Registry V2 HTTP API Specification.
   */
  digest?: string;

  /**
   * The number of bytes of the content. Same as Size field.
   */
  length?: int64;

  /**
   * The repository name.
   */
  repository?: string;

  /**
   * The direct URL to the content.
   */
  url?: string;

  /**
   * The tag name.
   */
  tag?: string;

  /**
   * The name of the artifact.
   */
  name?: string;

  /**
   * The version of the artifact.
   */
  version?: string;
}

/**
 * The request that generated the event.
 */
model Request {
  /**
   * The ID of the request that initiated the event.
   */
  id?: string;

  /**
   * The IP or hostname and possibly port of the client connection that initiated the event. This is the RemoteAddr from the standard http request.
   */
  addr?: string;

  /**
   * The externally accessible hostname of the registry instance, as specified by the http host header on incoming requests.
   */
  host?: string;

  /**
   * The request method that generated the event.
   */
  method?: string;

  /**
   * The user agent header of the request.
   */
  useragent?: string;
}

/**
 * The agent that initiated the event. For most situations, this could be from the authorization context of the request.
 */
model Actor {
  /**
   * The subject or username associated with the request context that generated the event.
   */
  name?: string;
}

/**
 * The registry node that generated the event. Put differently, while the actor initiates the event, the source generates it.
 */
model Source {
  /**
   * The IP or hostname and the port of the registry node that generated the event. Generally, this will be resolved by os.Hostname() along with the running port.
   */
  addr?: string;

  /**
   * The running instance of an application. Changes after each restart.
   */
  instanceID?: string;
}

/**
 * The event response message received from the service URI.
 */
model EventResponseMessage {
  /**
   * The content of the event response message.
   */
  content?: string;

  /**
   * The headers of the event response message.
   */
  headers?: Record<string>;

  /**
   * The reason phrase of the event response message.
   */
  reasonPhrase?: string;

  /**
   * The status code of the event response message.
   */
  statusCode?: string;

  /**
   * The HTTP message version.
   */
  version?: string;
}

/**
 * The configuration of service URI and custom headers for the webhook.
 */
model CallbackConfig {
  /**
   * The service URI for the webhook to post notifications.
   */
  serviceUri: string;

  /**
   * Custom headers that will be added to the webhook notifications.
   */
  customHeaders?: Record<string>;
}

/**
 * The properties of agent pool.
 */
model AgentPoolProperties {
  /**
   * The count of agent machine
   */
  count?: int32;

  /**
   * The Tier of agent machine
   */
  tier?: string;

  /**
   * The OS of agent machine
   */
  os?: OS;

  /**
   * The Virtual Network Subnet Resource Id of the agent machine
   */
  virtualNetworkSubnetResourceId?: string;

  /**
   * The provisioning state of this agent pool
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The parameters for updating an agent pool.
 */
model AgentPoolUpdateParameters {
  /**
   * The properties associated with the agent pool
   */
  properties?: AgentPoolPropertiesUpdateParameters;

  /**
   * The ARM resource tags.
   */
  tags?: Record<string>;
}

model AgentPoolPropertiesUpdateParameters {
  /**
   * The count of agent machine
   */
  count?: int32;
}

/**
 * The QueueStatus of Agent Pool
 */
model AgentPoolQueueStatus {
  /**
   * The number of pending runs in the queue
   */
  count?: int32;
}

/**
 * The request parameters for scheduling a run.
 */
@discriminator("type")
model RunRequest {
  /**
   * The value that indicates whether archiving is enabled for the run or not.
   */
  isArchiveEnabled?: boolean;

  /**
   * The dedicated agent pool for the run.
   */
  agentPoolName?: string;

  /**
   * The template that describes the repository and tag information for run log artifact.
   */
  logTemplate?: string;
}

/**
 * The properties for a run.
 */
model RunProperties {
  /**
   * The unique identifier for the run.
   */
  runId?: string;

  /**
   * The current status of the run.
   */
  status?: RunStatus;

  /**
   * The last updated time for the run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * The type of run.
   */
  runType?: RunType;

  /**
   * The dedicated agent pool for the run.
   */
  agentPoolName?: string;

  /**
   * The time the run was scheduled.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The time the run started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The time the run finished.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishTime?: utcDateTime;

  /**
   * The list of all images that were generated from the run. This is applicable if the run generates base image dependencies.
   */
  outputImages?: ImageDescriptor[];

  /**
   * The task against which run was scheduled.
   */
  task?: string;

  /**
   * The image update trigger that caused the run. This is applicable if the task has base image trigger configured.
   */
  imageUpdateTrigger?: ImageUpdateTrigger;

  /**
   * The source trigger that caused the run.
   */
  sourceTrigger?: SourceTriggerDescriptor;

  /**
   * The timer trigger that caused the run.
   */
  timerTrigger?: TimerTriggerDescriptor;

  /**
   * The platform properties against which the run will happen.
   */
  platform?: PlatformProperties;

  /**
   * The machine configuration of the run agent.
   */
  agentConfiguration?: AgentProperties;

  /**
   * The scope of the credentials that were used to login to the source registry during this run.
   */
  sourceRegistryAuth?: string;

  /**
   * The list of custom registries that were logged in during this run.
   */
  customRegistries?: string[];

  /**
   * The error message received from backend systems after the run is scheduled.
   */
  @visibility("read")
  runErrorMessage?: string;

  /**
   * The update trigger token passed for the Run.
   */
  updateTriggerToken?: string;

  /**
   * The image description for the log artifact.
   */
  @visibility("read")
  logArtifact?: ImageDescriptor;

  /**
   * The provisioning state of a run.
   */
  provisioningState?: ProvisioningState;

  /**
   * The value that indicates whether archiving is enabled or not.
   */
  isArchiveEnabled?: boolean;
}

/**
 * Properties for a registry image.
 */
model ImageDescriptor {
  /**
   * The registry login server.
   */
  registry?: string;

  /**
   * The repository name.
   */
  repository?: string;

  /**
   * The tag name.
   */
  tag?: string;

  /**
   * The sha256-based digest of the image manifest.
   */
  digest?: string;
}

/**
 * The image update trigger that caused a build.
 */
model ImageUpdateTrigger {
  /**
   * The unique ID of the trigger.
   */
  id?: string;

  /**
   * The timestamp when the image update happened.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The list of image updates that caused the build.
   */
  images?: ImageDescriptor[];
}

/**
 * The source trigger that caused a run.
 */
model SourceTriggerDescriptor {
  /**
   * The unique ID of the trigger.
   */
  id?: string;

  /**
   * The event type of the trigger.
   */
  eventType?: string;

  /**
   * The unique ID that identifies a commit.
   */
  commitId?: string;

  /**
   * The unique ID that identifies pull request.
   */
  pullRequestId?: string;

  /**
   * The repository URL.
   */
  repositoryUrl?: string;

  /**
   * The branch name in the repository.
   */
  branchName?: string;

  /**
   * The source control provider type.
   */
  providerType?: string;
}

model TimerTriggerDescriptor {
  /**
   * The timer trigger name that caused the run.
   */
  timerTriggerName?: string;

  /**
   * The occurrence that triggered the run.
   */
  scheduleOccurrence?: string;
}

/**
 * The platform properties against which the run has to happen.
 */
model PlatformProperties {
  /**
   * The operating system type required for the run.
   */
  os: OS;

  /**
   * The OS architecture.
   */
  architecture?: Architecture;

  /**
   * Variant of the CPU.
   */
  variant?: Variant;
}

/**
 * The properties that determine the run agent configuration.
 */
model AgentProperties {
  /**
   * The CPU configuration in terms of number of cores required for the run.
   */
  cpu?: int32;
}

/**
 * The properties of a response to source upload request.
 */
model SourceUploadDefinition {
  /**
   * The URL where the client can upload the source.
   */
  uploadUrl?: string;

  /**
   * The relative path to the source. This is used to submit the subsequent queue build request.
   */
  relativePath?: string;
}

/**
 * The set of run properties that can be updated.
 */
model RunUpdateParameters {
  /**
   * The value that indicates whether archiving is enabled or not.
   */
  isArchiveEnabled?: boolean;
}

/**
 * The result of get log link operation.
 */
model RunGetLogResult {
  /**
   * The link to logs for a run on a azure container registry.
   */
  logLink?: string;

  /**
   * The link to logs in registry for a run on a azure container registry.
   */
  logArtifactLink?: string;
}

/**
 * The properties of task run.
 */
model TaskRunProperties {
  /**
   * The provisioning state of this task run
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The request (parameters) for the run
   */
  runRequest?: RunRequest;

  /**
   * The result of this task run
   */
  @visibility("read")
  runResult?: Run;

  /**
   * How the run should be forced to rerun even if the run request configuration has not changed
   */
  forceUpdateTag?: string;
}

/**
 * The parameters for updating a task run.
 */
model TaskRunUpdateParameters {
  /**
   * Identity for the resource.
   */
  identity?: IdentityProperties;

  /**
   * The properties for updating a task run.
   */
  properties?: TaskRunPropertiesUpdateParameters;

  /**
   * The location of the resource
   */
  location?: string;

  /**
   * The ARM resource tags.
   */
  tags?: Record<string>;
}

/**
 * The properties of a task run update parameters.
 */
model TaskRunPropertiesUpdateParameters {
  /**
   * The request (parameters) for the new run
   */
  runRequest?: RunRequest;

  /**
   * How the run should be forced to rerun even if the run request configuration has not changed
   */
  forceUpdateTag?: string;
}

/**
 * The properties of a task.
 */
model TaskProperties {
  /**
   * The provisioning state of the task.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The creation date of task.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The current status of task.
   */
  status?: TaskStatus;

  /**
   * The platform properties against which the run has to happen.
   */
  platform?: PlatformProperties;

  /**
   * The machine configuration of the run agent.
   */
  agentConfiguration?: AgentProperties;

  /**
   * The dedicated agent pool for the task.
   */
  agentPoolName?: string;

  /**
   * Run timeout in seconds.
   */
  @maxValue(28800)
  @minValue(300)
  timeout?: int32 = 3600;

  /**
   * The properties of a task step.
   */
  step?: TaskStepProperties;

  /**
   * The properties that describe all triggers for the task.
   */
  trigger?: TriggerProperties;

  /**
   * The properties that describes a set of credentials that will be used when this run is invoked.
   */
  credentials?: Credentials;

  /**
   * The template that describes the repository and tag information for run log artifact.
   */
  logTemplate?: string;

  /**
   * The value of this property indicates whether the task resource is system task or not.
   */
  isSystemTask?: boolean;
}

/**
 * Base properties for any task step.
 */
@discriminator("type")
model TaskStepProperties {
  /**
   * List of base image dependencies for a step.
   */
  @visibility("read")
  baseImageDependencies?: BaseImageDependency[];

  /**
   * The URL(absolute or relative) of the source context for the task step.
   */
  contextPath?: string;

  /**
   * The token (git PAT or SAS token of storage account blob) associated with the context for a step.
   */
  contextAccessToken?: string;
}

/**
 * Properties that describe a base image dependency.
 */
model BaseImageDependency {
  /**
   * The type of the base image dependency.
   */
  type?: BaseImageDependencyType;

  /**
   * The registry login server.
   */
  registry?: string;

  /**
   * The repository name.
   */
  repository?: string;

  /**
   * The tag name.
   */
  tag?: string;

  /**
   * The sha256-based digest of the image manifest.
   */
  digest?: string;
}

/**
 * The properties of a trigger.
 */
model TriggerProperties {
  /**
   * The collection of timer triggers.
   */
  timerTriggers?: TimerTrigger[];

  /**
   * The collection of triggers based on source code repository.
   */
  sourceTriggers?: SourceTrigger[];

  /**
   * The trigger based on base image dependencies.
   */
  baseImageTrigger?: BaseImageTrigger;
}

/**
 * The properties of a timer trigger.
 */
model TimerTrigger {
  /**
   * The CRON expression for the task schedule
   */
  schedule: string;

  /**
   * The current status of trigger.
   */
  status?: TriggerStatus;

  /**
   * The name of the trigger.
   */
  name: string;
}

/**
 * The properties of a source based trigger.
 */
model SourceTrigger {
  /**
   * The properties that describes the source(code) for the task.
   */
  sourceRepository: SourceProperties;

  /**
   * The source event corresponding to the trigger.
   */
  sourceTriggerEvents: SourceTriggerEvent[];

  /**
   * The current status of trigger.
   */
  status?: TriggerStatus;

  /**
   * The name of the trigger.
   */
  name: string;
}

/**
 * The properties of the source code repository.
 */
model SourceProperties {
  /**
   * The type of source control service.
   */
  sourceControlType: SourceControlType;

  /**
   * The full URL to the source code repository
   */
  repositoryUrl: string;

  /**
   * The branch name of the source code.
   */
  branch?: string;

  /**
* The authorization properties for accessing the source code repository and to set up
webhooks for notifications.
*/
  sourceControlAuthProperties?: AuthInfo;
}

/**
 * The authorization properties for accessing the source code repository.
 */
model AuthInfo {
  /**
   * The type of Auth token.
   */
  tokenType: TokenType;

  /**
   * The access token used to access the source control provider.
   */
  token: string;

  /**
   * The refresh token used to refresh the access token.
   */
  refreshToken?: string;

  /**
   * The scope of the access token.
   */
  scope?: string;

  /**
   * Time in seconds that the token remains valid
   */
  expiresIn?: int32;
}

/**
 * The trigger based on base image dependency.
 */
model BaseImageTrigger {
  /**
   * The type of the auto trigger for base image dependency updates.
   */
  baseImageTriggerType: BaseImageTriggerType;

  /**
   * The endpoint URL for receiving update triggers.
   */
  updateTriggerEndpoint?: string;

  /**
   * Type of Payload body for Base image update triggers.
   */
  updateTriggerPayloadType?: UpdateTriggerPayloadType;

  /**
   * The current status of trigger.
   */
  status?: TriggerStatus;

  /**
   * The name of the trigger.
   */
  name: string;
}

/**
 * The parameters that describes a set of credentials that will be used when a run is invoked.
 */
model Credentials {
  /**
   * Describes the credential parameters for accessing the source registry.
   */
  sourceRegistry?: SourceRegistryCredentials;

  /**
* Describes the credential parameters for accessing other custom registries. The key
for the dictionary item will be the registry login server (myregistry.azurecr.io) and
the value of the item will be the registry credentials for accessing the registry.
*/
  customRegistries?: Record<CustomRegistryCredentials>;
}

/**
 * Describes the credential parameters for accessing the source registry.
 */
model SourceRegistryCredentials {
  /**
* The authentication mode which determines the source registry login scope. The credentials for the source registry
will be generated using the given scope. These credentials will be used to login to
the source registry during the run.
*/
  loginMode?: SourceRegistryLoginMode;
}

/**
 * Describes the credentials that will be used to access a custom registry during a run.
 */
model CustomRegistryCredentials {
  /**
   * The username for logging into the custom registry.
   */
  userName?: SecretObject;

  /**
* The password for logging into the custom registry. The password is a secret 
object that allows multiple ways of providing the value for it.
*/
  password?: SecretObject;

  /**
* Indicates the managed identity assigned to the custom credential. If a user-assigned identity
this value is the Client ID. If a system-assigned identity, the value will be `system`. In
the case of a system-assigned identity, the Client ID will be determined by the runner. This
identity may be used to authenticate to key vault to retrieve credentials or it may be the only 
source of authentication used for accessing the registry.
*/
  identity?: string;
}

/**
 * Describes the properties of a secret object value.
 */
model SecretObject {
  /**
* The value of the secret. The format of this value will be determined
based on the type of the secret object. If the type is Opaque, the value will be
used as is without any modification.
*/
  value?: string;

  /**
* The type of the secret object which determines how the value of the secret object has to be
interpreted.
*/
  type?: SecretObjectType;
}

/**
 * The parameters for updating a task.
 */
model TaskUpdateParameters {
  /**
   * Identity for the resource.
   */
  identity?: IdentityProperties;

  /**
   * The properties for updating a task.
   */
  properties?: TaskPropertiesUpdateParameters;

  /**
   * The ARM resource tags.
   */
  tags?: Record<string>;
}

/**
 * The properties for updating a task.
 */
model TaskPropertiesUpdateParameters {
  /**
   * The current status of task.
   */
  status?: TaskStatus;

  /**
   * The platform properties against which the run has to happen.
   */
  platform?: PlatformUpdateParameters;

  /**
   * The machine configuration of the run agent.
   */
  agentConfiguration?: AgentProperties;

  /**
   * The dedicated agent pool for the task.
   */
  agentPoolName?: string;

  /**
   * Run timeout in seconds.
   */
  timeout?: int32;

  /**
   * The properties for updating a task step.
   */
  step?: TaskStepUpdateParameters;

  /**
   * The properties for updating trigger properties.
   */
  trigger?: TriggerUpdateParameters;

  /**
   * The parameters that describes a set of credentials that will be used when this run is invoked.
   */
  credentials?: Credentials;

  /**
   * The template that describes the repository and tag information for run log artifact.
   */
  logTemplate?: string;
}

/**
 * The properties for updating the platform configuration.
 */
model PlatformUpdateParameters {
  /**
   * The operating system type required for the run.
   */
  os?: OS;

  /**
   * The OS architecture.
   */
  architecture?: Architecture;

  /**
   * Variant of the CPU.
   */
  variant?: Variant;
}

/**
 * Base properties for updating any task step.
 */
@discriminator("type")
model TaskStepUpdateParameters {
  /**
   * The URL(absolute or relative) of the source context for the task step.
   */
  contextPath?: string;

  /**
   * The token (git PAT or SAS token of storage account blob) associated with the context for a step.
   */
  contextAccessToken?: string;
}

/**
 * The properties for updating triggers.
 */
model TriggerUpdateParameters {
  /**
   * The collection of timer triggers.
   */
  timerTriggers?: TimerTriggerUpdateParameters[];

  /**
   * The collection of triggers based on source code repository.
   */
  sourceTriggers?: SourceTriggerUpdateParameters[];

  /**
   * The trigger based on base image dependencies.
   */
  baseImageTrigger?: BaseImageTriggerUpdateParameters;
}

/**
 * The properties for updating a timer trigger.
 */
model TimerTriggerUpdateParameters {
  /**
   * The CRON expression for the task schedule
   */
  schedule?: string;

  /**
   * The current status of trigger.
   */
  status?: TriggerStatus;

  /**
   * The name of the trigger.
   */
  name: string;
}

/**
 * The properties for updating a source based trigger.
 */
model SourceTriggerUpdateParameters {
  /**
   * The properties that describes the source(code) for the task.
   */
  sourceRepository?: SourceUpdateParameters;

  /**
   * The source event corresponding to the trigger.
   */
  sourceTriggerEvents?: SourceTriggerEvent[];

  /**
   * The current status of trigger.
   */
  status?: TriggerStatus;

  /**
   * The name of the trigger.
   */
  name: string;
}

/**
 * The properties for updating the source code repository.
 */
model SourceUpdateParameters {
  /**
   * The type of source control service.
   */
  sourceControlType?: SourceControlType;

  /**
   * The full URL to the source code repository
   */
  repositoryUrl?: string;

  /**
   * The branch name of the source code.
   */
  branch?: string;

  /**
* The authorization properties for accessing the source code repository and to set up
webhooks for notifications.
*/
  sourceControlAuthProperties?: AuthInfoUpdateParameters;
}

/**
 * The authorization properties for accessing the source code repository.
 */
model AuthInfoUpdateParameters {
  /**
   * The type of Auth token.
   */
  tokenType?: TokenType;

  /**
   * The access token used to access the source control provider.
   */
  token?: string;

  /**
   * The refresh token used to refresh the access token.
   */
  refreshToken?: string;

  /**
   * The scope of the access token.
   */
  scope?: string;

  /**
   * Time in seconds that the token remains valid
   */
  expiresIn?: int32;
}

/**
 * The properties for updating base image dependency trigger.
 */
model BaseImageTriggerUpdateParameters {
  /**
   * The type of the auto trigger for base image dependency updates.
   */
  baseImageTriggerType?: BaseImageTriggerType;

  /**
   * The endpoint URL for receiving update triggers.
   */
  updateTriggerEndpoint?: string;

  /**
   * Type of Payload body for Base image update triggers.
   */
  updateTriggerPayloadType?: UpdateTriggerPayloadType;

  /**
   * The current status of trigger.
   */
  status?: TriggerStatus;

  /**
   * The name of the trigger.
   */
  name: string;
}

/**
 * The properties of a storage account for a container registry. Only applicable to Classic SKU.
 */
model StorageAccountProperties {
  /**
   * The resource ID of the storage account.
   */
  id: string;
}

/**
 * The properties of a package type.
 */
model PackageType {
  /**
   * The name of the package type.
   */
  name?: string;

  /**
   * The endpoint of the package type.
   */
  @visibility("read")
  endpoint?: string;
}

/**
 * The Active Directory Object that will be used for authenticating the token of a container registry.
 */
model ActiveDirectoryObject {
  /**
   * The user/group/application object ID for Active Directory Object that will be used for authenticating the token of a container registry.
   */
  objectId?: string;

  /**
   * The tenant ID of user/group/application object Active Directory Object that will be used for authenticating the token of a container registry.
   */
  tenantId?: string;
}

/**
 * Properties that are enabled for Odata querying on runs.
 */
model RunFilter {
  /**
   * The unique identifier for the run.
   */
  runId?: string;

  /**
   * The type of run.
   */
  runType?: RunType;

  /**
   * The current status of the run.
   */
  status?: RunStatus;

  /**
   * The create time for a run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The time the run finished.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishTime?: utcDateTime;

  /**
* The list of comma-separated image manifests that were generated from the run. This is applicable if the run is of
build type.
*/
  outputImageManifests?: string;

  /**
   * The value that indicates whether archiving is enabled or not.
   */
  isArchiveEnabled?: boolean;

  /**
   * The name of the task that the run corresponds to.
   */
  taskName?: string;

  /**
   * The name of the agent pool that the run corresponds to.
   */
  agentPoolName?: string;
}

/**
 * The parameters for a docker quick build.
 */
model DockerBuildRequest extends RunRequest {
  /**
   * The fully qualified image names including the repository and tag.
   */
  imageNames?: string[];

  /**
   * The value of this property indicates whether the image built should be pushed to the registry or not.
   */
  isPushEnabled?: boolean = true;

  /**
   * The value of this property indicates whether the image cache is enabled or not.
   */
  noCache?: boolean;

  /**
   * The Docker file path relative to the source location.
   */
  dockerFilePath: string;

  /**
   * The name of the target build stage for the docker build.
   */
  target?: string;

  /**
   * The collection of override arguments to be used when executing the run.
   */
  arguments?: Argument[];

  /**
   * Run timeout in seconds.
   */
  @maxValue(28800)
  @minValue(300)
  timeout?: int32 = 3600;

  /**
   * The platform properties against which the run has to happen.
   */
  platform: PlatformProperties;

  /**
   * The machine configuration of the run agent.
   */
  agentConfiguration?: AgentProperties;

  /**
* The URL(absolute or relative) of the source context. It can be an URL to a tar or git repository.
If it is relative URL, the relative path should be obtained from calling listBuildSourceUploadUrl API.
*/
  sourceLocation?: string;

  /**
   * The properties that describes a set of credentials that will be used when this run is invoked.
   */
  credentials?: Credentials;

  /**
   * The type of the run request.
   */
  type: "DockerBuildRequest";
}

/**
 * The properties of a run argument.
 */
model Argument {
  /**
   * The name of the argument.
   */
  name: string;

  /**
   * The value of the argument.
   */
  value: string;

  /**
   * Flag to indicate whether the argument represents a secret and want to be removed from build logs.
   */
  isSecret?: boolean;
}

/**
 * The request parameters for a scheduling run against a task file.
 */
model FileTaskRunRequest extends RunRequest {
  /**
   * The template/definition file path relative to the source.
   */
  taskFilePath: string;

  /**
   * The values/parameters file path relative to the source.
   */
  valuesFilePath?: string;

  /**
   * The collection of overridable values that can be passed when running a task.
   */
  values?: SetValue[];

  /**
   * Run timeout in seconds.
   */
  @maxValue(28800)
  @minValue(300)
  timeout?: int32 = 3600;

  /**
   * The platform properties against which the run has to happen.
   */
  platform: PlatformProperties;

  /**
   * The machine configuration of the run agent.
   */
  agentConfiguration?: AgentProperties;

  /**
* The URL(absolute or relative) of the source context. It can be an URL to a tar or git repository.
If it is relative URL, the relative path should be obtained from calling listBuildSourceUploadUrl API.
*/
  sourceLocation?: string;

  /**
   * The properties that describes a set of credentials that will be used when this run is invoked.
   */
  credentials?: Credentials;

  /**
   * The type of the run request.
   */
  type: "FileTaskRunRequest";
}

/**
 * The properties of a overridable value that can be passed to a task template.
 */
model SetValue {
  /**
   * The name of the overridable value.
   */
  name: string;

  /**
   * The overridable value.
   */
  value: string;

  /**
   * Flag to indicate whether the value represents a secret or not.
   */
  isSecret?: boolean;
}

/**
 * The parameters for a task run request.
 */
model TaskRunRequest extends RunRequest {
  /**
   * The resource ID of task against which run has to be queued.
   */
  taskId: string;

  /**
   * Set of overridable parameters that can be passed when running a Task.
   */
  overrideTaskStepProperties?: OverrideTaskStepProperties;

  /**
   * The type of the run request.
   */
  type: "TaskRunRequest";
}

model OverrideTaskStepProperties {
  /**
   * The source context against which run has to be queued.
   */
  contextPath?: string;

  /**
   * The file against which run has to be queued.
   */
  file?: string;

  /**
* Gets or sets the collection of override arguments to be used when
executing a build step.
*/
  arguments?: Argument[];

  /**
   * The name of the target build stage for the docker build.
   */
  target?: string;

  /**
   * The collection of overridable values that can be passed when running a Task.
   */
  values?: SetValue[];

  /**
   * Base64 encoded update trigger token that will be attached with the base image trigger webhook.
   */
  updateTriggerToken?: string;
}

/**
 * The parameters for a quick task run request.
 */
model EncodedTaskRunRequest extends RunRequest {
  /**
   * Base64 encoded value of the template/definition file content.
   */
  encodedTaskContent: string;

  /**
   * Base64 encoded value of the parameters/values file content.
   */
  encodedValuesContent?: string;

  /**
   * The collection of overridable values that can be passed when running a task.
   */
  values?: SetValue[];

  /**
   * Run timeout in seconds.
   */
  @maxValue(28800)
  @minValue(300)
  timeout?: int32 = 3600;

  /**
   * The platform properties against which the run has to happen.
   */
  platform: PlatformProperties;

  /**
   * The machine configuration of the run agent.
   */
  agentConfiguration?: AgentProperties;

  /**
* The URL(absolute or relative) of the source context. It can be an URL to a tar or git repository.
If it is relative URL, the relative path should be obtained from calling listBuildSourceUploadUrl API.
*/
  sourceLocation?: string;

  /**
   * The properties that describes a set of credentials that will be used when this run is invoked.
   */
  credentials?: Credentials;

  /**
   * The type of the run request.
   */
  type: "EncodedTaskRunRequest";
}

/**
 * The Docker build step.
 */
model DockerBuildStep extends TaskStepProperties {
  /**
   * The fully qualified image names including the repository and tag.
   */
  imageNames?: string[];

  /**
   * The value of this property indicates whether the image built should be pushed to the registry or not.
   */
  isPushEnabled?: boolean = true;

  /**
   * The value of this property indicates whether the image cache is enabled or not.
   */
  noCache?: boolean;

  /**
   * The Docker file path relative to the source context.
   */
  dockerFilePath: string;

  /**
   * The name of the target build stage for the docker build.
   */
  target?: string;

  /**
   * The collection of override arguments to be used when executing this build step.
   */
  arguments?: Argument[];

  /**
   * The type of the step.
   */
  type: "Docker";
}

/**
 * The properties of a task step.
 */
model FileTaskStep extends TaskStepProperties {
  /**
   * The task template/definition file path relative to the source context.
   */
  taskFilePath: string;

  /**
   * The task values/parameters file path relative to the source context.
   */
  valuesFilePath?: string;

  /**
   * The collection of overridable values that can be passed when running a task.
   */
  values?: SetValue[];

  /**
   * The type of the step.
   */
  type: "FileTask";
}

/**
 * The properties of a encoded task step.
 */
model EncodedTaskStep extends TaskStepProperties {
  /**
   * Base64 encoded value of the template/definition file content.
   */
  encodedTaskContent: string;

  /**
   * Base64 encoded value of the parameters/values file content.
   */
  encodedValuesContent?: string;

  /**
   * The collection of overridable values that can be passed when running a task.
   */
  values?: SetValue[];

  /**
   * The type of the step.
   */
  type: "EncodedTask";
}

/**
 * The properties for updating a docker build step.
 */
model DockerBuildStepUpdateParameters extends TaskStepUpdateParameters {
  /**
   * The fully qualified image names including the repository and tag.
   */
  imageNames?: string[];

  /**
   * The value of this property indicates whether the image built should be pushed to the registry or not.
   */
  isPushEnabled?: boolean;

  /**
   * The value of this property indicates whether the image cache is enabled or not.
   */
  noCache?: boolean;

  /**
   * The Docker file path relative to the source context.
   */
  dockerFilePath?: string;

  /**
   * The collection of override arguments to be used when executing this build step.
   */
  arguments?: Argument[];

  /**
   * The name of the target build stage for the docker build.
   */
  target?: string;

  /**
   * The type of the step.
   */
  type: "Docker";
}

/**
 * The properties of updating a task step.
 */
model FileTaskStepUpdateParameters extends TaskStepUpdateParameters {
  /**
   * The task template/definition file path relative to the source context.
   */
  taskFilePath?: string;

  /**
   * The values/parameters file path relative to the source context.
   */
  valuesFilePath?: string;

  /**
   * The collection of overridable values that can be passed when running a task.
   */
  values?: SetValue[];

  /**
   * The type of the step.
   */
  type: "FileTask";
}

/**
 * The properties for updating encoded task step.
 */
model EncodedTaskStepUpdateParameters extends TaskStepUpdateParameters {
  /**
   * Base64 encoded value of the template/definition file content.
   */
  encodedTaskContent?: string;

  /**
   * Base64 encoded value of the parameters/values file content.
   */
  encodedValuesContent?: string;

  /**
   * The collection of overridable values that can be passed when running a task.
   */
  values?: SetValue[];

  /**
   * The type of the step.
   */
  type: "EncodedTask";
}
