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

@doc("When Force, any existing target tags will be overwritten. When NoForce, any existing target tags will fail the operation before any copying begins.")
enum ImportMode {
  NoForce,
  Force,
}

@doc("The private link service connection status.")
enum ConnectionStatus {
  Approved,
  Pending,
  Rejected,
  Disconnected,
}

@doc("A message indicating if changes on the service provider require any updates on the consumer.")
enum ActionsRequired {
  None,
  Recreate,
}

@doc("The provisioning state of this agent pool")
enum ProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
}

@doc("The type of identity that last modified the resource.")
enum LastModifiedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

@doc("The SKU name of the container registry. Required for registry creation.")
enum SkuName {
  Classic,
  Basic,
  Standard,
  Premium,
}

@doc("The default action of allow or deny when no other rules match.")
enum DefaultAction {
  Allow,
  Deny,
}

@doc("The action of IP ACL rule.")
enum Action {
  Allow,
}

@doc("The value that indicates whether the policy is enabled or not.")
enum PolicyStatus {
  enabled,
  disabled,
}

@doc("The type of trust policy.")
enum TrustPolicyType {
  Notary,
}

@doc("The value that indicates whether the policy is enabled or not.")
enum ExportPolicyStatus {
  enabled,
  disabled,
}

@doc("Indicates whether or not the encryption is enabled for container registry.")
enum EncryptionStatus {
  enabled,
  disabled,
}

@doc("Whether or not public network access is allowed for the container registry.")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("Whether to allow trusted Azure services to access a network restricted registry.")
enum NetworkRuleBypassOptions {
  AzureServices,
  None,
}

@doc("Whether or not zone redundancy is enabled for this container registry")
enum ZoneRedundancy {
  Enabled,
  Disabled,
}

@doc("The unit of measurement.")
enum RegistryUsageUnit {
  Count,
  Bytes,
}

enum TokenCertificateName {
  certificate1,
  certificate2,
}

@doc("The password name \"password1\" or \"password2\"")
enum TokenPasswordName {
  password1,
  password2,
}

@doc("The status of the token example enabled or disabled.")
enum TokenStatus {
  enabled,
  disabled,
}

@doc("The status of the webhook at the time the operation was called.")
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

@doc("The OS of agent machine")
enum OS {
  Windows,
  Linux,
}

@doc("The current status of the run.")
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

@doc("The type of run.")
enum RunType {
  QuickBuild,
  QuickRun,
  AutoBuild,
  AutoRun,
}

@doc("The OS architecture.")
enum Architecture {
  amd64,
  x86,
  `386`,
  arm,
  arm64,
}

@doc("Variant of the CPU.")
enum Variant {
  v6,
  v7,
  v8,
}

@doc("The current status of task.")
enum TaskStatus {
  Disabled,
  Enabled,
}

@doc("The type of the step.")
enum StepType {
  Docker,
  FileTask,
  EncodedTask,
}

@doc("The type of the base image dependency.")
enum BaseImageDependencyType {
  BuildTime,
  RunTime,
}

@doc("The current status of trigger.")
enum TriggerStatus {
  Disabled,
  Enabled,
}

@doc("The type of source control service.")
enum SourceControlType {
  Github,
  VisualStudioTeamService,
}

@doc("The type of Auth token.")
enum TokenType {
  PAT,
  OAuth,
}

enum SourceTriggerEvent {
  commit,
  pullrequest,
}

@doc("The type of the auto trigger for base image dependency updates.")
enum BaseImageTriggerType {
  All,
  Runtime,
}

@doc("Type of Payload body for Base image update triggers.")
enum UpdateTriggerPayloadType {
  Default,
  Token,
}

@doc("""
The authentication mode which determines the source registry login scope. The credentials for the source registry
will be generated using the given scope. These credentials will be used to login to
the source registry during the run.
""")
enum SourceRegistryLoginMode {
  None,
  Default,
}

@doc("""
The type of the secret object which determines how the value of the secret object has to be
interpreted.
""")
enum SecretObjectType {
  Opaque,
  Vaultsecret,
}

@doc("The identity type.")
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

@doc("The password name.")
@fixed
enum PasswordName {
  password,
  password2,
}

model ImportImageParameters {
  @doc("The source of the image.")
  source: ImportSource;

  @doc("List of strings of the form repo[:tag]. When tag is omitted the source will be used (or 'latest' if source tag is also omitted).")
  targetTags?: string[];

  @doc("List of strings of repository names to do a manifest only copy. No tag will be created.")
  untaggedTargetRepositories?: string[];

  @doc("When Force, any existing target tags will be overwritten. When NoForce, any existing target tags will fail the operation before any copying begins.")
  mode?: ImportMode;
}

model ImportSource {
  @doc("The resource identifier of the source Azure Container Registry.")
  resourceId?: string;

  @doc("The address of the source registry (e.g. 'mcr.microsoft.com').")
  registryUri?: string;

  @doc("Credentials used when importing from a registry uri.")
  credentials?: ImportSourceCredentials;

  @doc("""
Repository name of the source image.
Specify an image by repository ('hello-world'). This will use the 'latest' tag.
Specify an image by tag ('hello-world:latest').
Specify an image by sha256-based manifest digest ('hello-world@sha256:abc123').
""")
  sourceImage: string;
}

model ImportSourceCredentials {
  @doc("The username to authenticate with the source registry.")
  username?: string;

  @doc("The password used to authenticate with the source registry.")
  password: string;
}

@doc("The definition of a container registry operation.")
model OperationDefinition {
  @doc("The origin information of the container registry operation.")
  origin?: string;

  @doc("Operation name: {provider}/{resource}/{operation}.")
  name?: string;

  @doc("The display information for the container registry operation.")
  display?: OperationDisplayDefinition;

  @doc("The properties information for the container registry operation.")
  properties?: OperationPropertiesDefinition;

  @doc("""
This property indicates if the operation is an action or a data action
ref: https://docs.microsoft.com/en-us/azure/role-based-access-control/role-definitions#management-and-data-operations
""")
  isDataAction?: boolean;
}

@doc("The display information for a container registry operation.")
model OperationDisplayDefinition {
  @doc("The resource provider name: Microsoft.ContainerRegistry.")
  provider?: string;

  @doc("The resource on which the operation is performed.")
  resource?: string;

  @doc("The operation that users can perform.")
  operation?: string;

  @doc("The description for the operation.")
  description?: string;
}

@doc("The definition of Azure Monitoring properties.")
model OperationPropertiesDefinition {
  @doc("The definition of Azure Monitoring service.")
  serviceSpecification?: OperationServiceSpecificationDefinition;
}

@doc("The definition of Azure Monitoring list.")
model OperationServiceSpecificationDefinition {
  @doc("A list of Azure Monitoring metrics definition.")
  metricSpecifications?: OperationMetricSpecificationDefinition[];

  @doc("A list of Azure Monitoring log definitions.")
  logSpecifications?: OperationLogSpecificationDefinition[];
}

@doc("The definition of Azure Monitoring metric.")
model OperationMetricSpecificationDefinition {
  @doc("Metric name.")
  name?: string;

  @doc("Metric display name.")
  displayName?: string;

  @doc("Metric description.")
  displayDescription?: string;

  @doc("Metric unit.")
  unit?: string;

  @doc("Metric aggregation type.")
  aggregationType?: string;

  @doc("Internal metric name.")
  internalMetricName?: string;
}

@doc("The definition of Azure Monitoring log.")
model OperationLogSpecificationDefinition {
  @doc("Log name.")
  name?: string;

  @doc("Log display name.")
  displayName?: string;

  @doc("Log blob duration.")
  blobDuration?: string;
}

@doc("A request to check whether a container registry name is available.")
model RegistryNameCheckRequest {
  @doc("The name of the container registry.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]*$")
  name: string;

  @doc("The resource type of the container registry. This field must be set to 'Microsoft.ContainerRegistry/registries'.")
  type: "Microsoft.ContainerRegistry/registries";
}

@doc("The result of a request to check the availability of a container registry name.")
model RegistryNameStatus {
  @doc("The value that indicates whether the name is available.")
  nameAvailable?: boolean;

  @doc("If any, the reason that the name is not available.")
  reason?: string;

  @doc("If any, the error message that provides more detail for the reason that the name is not available.")
  message?: string;
}

@doc("The properties of a private endpoint connection.")
model PrivateEndpointConnectionProperties {
  @doc("The resource of private endpoint.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  @doc("The provisioning state of private endpoint connection resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The Private Endpoint resource.")
model PrivateEndpoint {
  @doc("This is private endpoint resource created with Microsoft.Network resource provider.")
  id?: string;
}

@doc("The state of a private link service connection.")
model PrivateLinkServiceConnectionState {
  @doc("The private link service connection status.")
  status?: ConnectionStatus;

  @doc("The description for connection status. For example if connection is rejected it can indicate reason for rejection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: ActionsRequired;
}

@doc("The SKU of a container registry.")
model Sku {
  @doc("The SKU name of the container registry. Required for registry creation.")
  name: SkuName;

  @doc("The SKU tier based on the SKU name.")
  @visibility("read")
  tier?: SkuTier;
}

@doc("Managed identity for the resource.")
model IdentityProperties {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type?: ResourceIdentityType;

  @doc("""
The list of user identities associated with the resource. The user identity 
dictionary key references will be ARM resource ids in the form: 
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/
    providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
""")
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

model UserIdentityProperties {
  @doc("The principal id of user assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client id of user assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("The properties of a container registry.")
model RegistryProperties {
  @doc("The URL that can be used to log into the container registry.")
  @visibility("read")
  loginServer?: string;

  @doc("The creation date of the container registry in ISO8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("The provisioning state of the container registry at the time the operation was called.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The status of the container registry at the time the operation was called.")
  @visibility("read")
  status?: Status;

  @doc("The value that indicates whether the admin user is enabled.")
  adminUserEnabled?: boolean;

  @doc("The network rule set for a container registry.")
  networkRuleSet?: NetworkRuleSet;

  @doc("The policies for a container registry.")
  policies?: Policies;

  @doc("The encryption settings of container registry.")
  encryption?: EncryptionProperty;

  @doc("Enable a single data endpoint per region for serving data.")
  dataEndpointEnabled?: boolean;

  @doc("List of host names that will serve data when dataEndpointEnabled is true.")
  @visibility("read")
  dataEndpointHostNames?: string[];

  @doc("List of private endpoint connections for a container registry.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Whether or not public network access is allowed for the container registry.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("Whether to allow trusted Azure services to access a network restricted registry.")
  networkRuleBypassOptions?: NetworkRuleBypassOptions;

  @doc("Whether or not zone redundancy is enabled for this container registry")
  zoneRedundancy?: ZoneRedundancy;
}

@doc("The status of an Azure resource at the time the operation was called.")
model Status {
  @doc("The short label for the status.")
  @visibility("read")
  displayStatus?: string;

  @doc("The detailed message for the status, including alerts and error messages.")
  @visibility("read")
  message?: string;

  @doc("The timestamp when the status was changed to the current value.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;
}

@doc("The network rule set for a container registry.")
model NetworkRuleSet {
  @doc("The default action of allow or deny when no other rules match.")
  defaultAction: DefaultAction;

  @doc("The IP ACL rules.")
  ipRules?: IPRule[];
}

@doc("IP rule with specific IP or IP range in CIDR format.")
model IPRule {
  @doc("The action of IP ACL rule.")
  action?: Action;

  @doc("Specifies the IP or IP range in CIDR format. Only IPV4 address is allowed.")
  @projectedName("json", "value")
  IPAddressOrRange: string;
}

@doc("The policies for a container registry.")
model Policies {
  @doc("The quarantine policy for a container registry.")
  quarantinePolicy?: QuarantinePolicy;

  @doc("The content trust policy for a container registry.")
  trustPolicy?: TrustPolicy;

  @doc("The retention policy for a container registry.")
  retentionPolicy?: RetentionPolicy;

  @doc("The export policy for a container registry.")
  exportPolicy?: ExportPolicy;
}

@doc("The quarantine policy for a container registry.")
model QuarantinePolicy {
  @doc("The value that indicates whether the policy is enabled or not.")
  status?: PolicyStatus;
}

@doc("The content trust policy for a container registry.")
model TrustPolicy {
  @doc("The type of trust policy.")
  type?: TrustPolicyType;

  @doc("The value that indicates whether the policy is enabled or not.")
  status?: PolicyStatus;
}

@doc("The retention policy for a container registry.")
model RetentionPolicy {
  @doc("The number of days to retain an untagged manifest after which it gets purged.")
  days?: int32;

  @doc("The timestamp when the policy was last updated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  @doc("The value that indicates whether the policy is enabled or not.")
  status?: PolicyStatus;
}

@doc("The export policy for a container registry.")
model ExportPolicy {
  @doc("The value that indicates whether the policy is enabled or not.")
  status?: ExportPolicyStatus;
}

model EncryptionProperty {
  @doc("Indicates whether or not the encryption is enabled for container registry.")
  status?: EncryptionStatus;

  @doc("Key vault properties.")
  keyVaultProperties?: KeyVaultProperties;
}

model KeyVaultProperties {
  @doc("Key vault uri to access the encryption key.")
  keyIdentifier?: string;

  @doc("The fully qualified key identifier that includes the version of the key that is actually used for encryption.")
  @visibility("read")
  versionedKeyIdentifier?: string;

  @doc("The client id of the identity which will be used to access key vault.")
  identity?: string;

  @doc("Auto key rotation status for a CMK enabled registry.")
  @visibility("read")
  keyRotationEnabled?: boolean;

  @doc("Timestamp of the last successful key rotation.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastKeyRotationTimestamp?: utcDateTime;
}

@doc("An Azure resource.")
model Resource {
  @doc("The resource ID.")
  @visibility("read")
  id?: string;

  @doc("The name of the resource.")
  @visibility("read")
  name?: string;

  @doc("The type of the resource.")
  @visibility("read")
  type?: string;

  @doc("The location of the resource. This cannot be changed after the resource is created.")
  @visibility("read", "create")
  location: string;

  @doc("The tags of the resource.")
  tags?: Record<string>;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The parameters for updating a container registry.")
model RegistryUpdateParameters {
  @doc("The identity of the container registry.")
  identity?: IdentityProperties;

  @doc("The tags for the container registry.")
  tags?: Record<string>;

  @doc("The SKU of the container registry.")
  sku?: Sku;

  @doc("The properties that the container registry will be updated with.")
  properties?: RegistryPropertiesUpdateParameters;
}

@doc("The parameters for updating the properties of a container registry.")
model RegistryPropertiesUpdateParameters {
  @doc("The value that indicates whether the admin user is enabled.")
  adminUserEnabled?: boolean;

  @doc("The network rule set for a container registry.")
  networkRuleSet?: NetworkRuleSet;

  @doc("The policies for a container registry.")
  policies?: Policies;

  @doc("The encryption settings of container registry.")
  encryption?: EncryptionProperty;

  @doc("Enable a single data endpoint per region for serving data.")
  dataEndpointEnabled?: boolean;

  @doc("Whether or not public network access is allowed for the container registry.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("Whether to allow trusted Azure services to access a network restricted registry.")
  networkRuleBypassOptions?: NetworkRuleBypassOptions;
}

@doc("The result of a request to get container registry quota usages.")
model RegistryUsageListResult {
  @doc("The list of container registry quota usages.")
  value?: RegistryUsage[];
}

@doc("The quota usage for a container registry.")
model RegistryUsage {
  @doc("The name of the usage.")
  name?: string;

  @doc("The limit of the usage.")
  limit?: int32;

  @doc("The current value of the usage.")
  currentValue?: int32;

  @doc("The unit of measurement.")
  unit?: RegistryUsageUnit;
}

@doc("The properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  groupId?: string;

  @doc("The private link resource required member names.")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  requiredZoneNames?: string[];
}

@doc("An error response from the Azure Container Registry service.")
model ErrorResponseBody {
  @doc("error code.")
  code: string;

  @doc("error message.")
  message: string;

  @doc("target of the particular error.")
  target?: string;

  @doc("an array of additional nested error response info objects, as described by this contract.")
  details?: InnerErrorDescription[];
}

@doc("inner error.")
model InnerErrorDescription {
  @doc("error code.")
  code: string;

  @doc("error message.")
  message: string;

  @doc("target of the particular error.")
  target?: string;
}

@doc("The response from the ListCredentials operation.")
model RegistryListCredentialsResult {
  @doc("The username for a container registry.")
  username?: string;

  @doc("The list of passwords for a container registry.")
  passwords?: RegistryPassword[];
}

@doc("The login password for the container registry.")
model RegistryPassword {
  @doc("The password name.")
  name?: PasswordName;

  @doc("The password value.")
  value?: string;
}

@doc("The parameters used to regenerate the login credential.")
model RegenerateCredentialParameters {
  @doc("Specifies name of the password which should be regenerated -- password or password2.")
  name: PasswordName;
}

@doc("The properties of a replication.")
model ReplicationProperties {
  @doc("The provisioning state of the replication at the time the operation was called.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The status of the replication at the time the operation was called.")
  @visibility("read")
  status?: Status;

  @doc("Specifies whether the replication's regional endpoint is enabled. Requests will not be routed to a replication whose regional endpoint is disabled, however its data will continue to be synced with other replications.")
  regionEndpointEnabled?: boolean;

  @doc("Whether or not zone redundancy is enabled for this container registry replication")
  zoneRedundancy?: ZoneRedundancy;
}

@doc("The parameters for updating a replication.")
model ReplicationUpdateParameters {
  @doc("The tags for the replication.")
  tags?: Record<string>;

  @doc("The parameters for updating a replication's properties")
  properties?: ReplicationUpdateParametersProperties;
}

model ReplicationUpdateParametersProperties {
  @doc("Specifies whether the replication's regional endpoint is enabled. Requests will not be routed to a replication whose regional endpoint is disabled, however its data will continue to be synced with other replications.")
  regionEndpointEnabled?: boolean;
}

@doc("The properties of a scope map.")
model ScopeMapProperties {
  @doc("The user friendly description of the scope map.")
  description?: string;

  @doc("The type of the scope map. E.g. BuildIn scope map.")
  @visibility("read")
  type?: string;

  @doc("The creation date of scope map.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("""
The list of scoped permissions for registry artifacts.
E.g. repositories/repository-name/content/read,
repositories/repository-name/metadata/write
""")
  actions: string[];
}

@doc("The properties for updating the scope map.")
model ScopeMapUpdateParameters {
  @doc("The update parameters for scope map properties.")
  properties?: ScopeMapPropertiesUpdateParameters;
}

@doc("The update parameters for scope map properties.")
model ScopeMapPropertiesUpdateParameters {
  @doc("The user friendly description of the scope map.")
  description?: string;

  @doc("""
The list of scope permissions for registry artifacts.
E.g. repositories/repository-name/pull, 
repositories/repository-name/delete
""")
  actions?: string[];
}

@doc("The properties of a token.")
model TokenProperties {
  @doc("The creation date of scope map.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The resource ID of the scope map to which the token will be associated with.")
  scopeMapId?: string;

  @doc("The credentials that can be used for authenticating the token.")
  credentials?: TokenCredentialsProperties;

  @doc("The status of the token example enabled or disabled.")
  status?: TokenStatus;
}

@doc("The properties of the credentials that can be used for authenticating the token.")
model TokenCredentialsProperties {
  certificates?: TokenCertificate[];
  passwords?: TokenPassword[];
}

@doc("The properties of a certificate used for authenticating a token.")
model TokenCertificate {
  name?: TokenCertificateName;

  @doc("The expiry datetime of the certificate.")
  @projectedName("json", "expiry")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expireOn?: utcDateTime;

  @doc("The thumbprint of the certificate.")
  thumbprint?: string;

  @doc("Base 64 encoded string of the public certificate1 in PEM format that will be used for authenticating the token.")
  encodedPemCertificate?: string;
}

@doc("The password that will be used for authenticating the token of a container registry.")
model TokenPassword {
  @doc("The creation datetime of the password.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("The expiry datetime of the password.")
  @projectedName("json", "expiry")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expireOn?: utcDateTime;

  @doc("The password name \"password1\" or \"password2\"")
  name?: TokenPasswordName;

  @doc("The password value.")
  @visibility("read")
  value?: string;
}

@doc("The parameters for updating a token.")
model TokenUpdateParameters {
  @doc("The properties of the token update parameters.")
  properties?: TokenUpdateProperties;
}

@doc("The parameters for updating token properties.")
model TokenUpdateProperties {
  @doc("The resource ID of the scope map to which the token will be associated with.")
  scopeMapId?: string;

  @doc("The status of the token example enabled or disabled.")
  status?: TokenStatus;

  @doc("The credentials that can be used for authenticating the token.")
  credentials?: TokenCredentialsProperties;
}

@doc("The parameters used to generate credentials for a specified token or user of a container registry.")
model GenerateCredentialsParameters {
  @doc("The resource ID of the token for which credentials have to be generated.")
  tokenId?: string;

  @doc("The expiry date of the generated credentials after which the credentials become invalid.")
  @projectedName("json", "expiry")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expireOn?: utcDateTime;

  @doc("Specifies name of the password which should be regenerated if any -- password1 or password2.")
  name?: TokenPasswordName;
}

@doc("The response from the GenerateCredentials operation.")
model GenerateCredentialsResult {
  @doc("The username for a container registry.")
  username?: string;

  @doc("The list of passwords for a container registry.")
  passwords?: TokenPassword[];
}

@doc("The properties of a webhook.")
model WebhookProperties {
  @doc("The status of the webhook at the time the operation was called.")
  status?: WebhookStatus;

  @doc("The scope of repositories where the event can be triggered. For example, 'foo:*' means events for all tags under repository 'foo'. 'foo:bar' means events for 'foo:bar' only. 'foo' is equivalent to 'foo:latest'. Empty means all events.")
  scope?: string;

  @doc("The list of actions that trigger the webhook to post notifications.")
  actions: WebhookAction[];

  @doc("The provisioning state of the webhook at the time the operation was called.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The parameters for creating a webhook.")
model WebhookCreateParameters {
  @doc("The tags for the webhook.")
  tags?: Record<string>;

  @doc("The location of the webhook. This cannot be changed after the resource is created.")
  location: string;

  @doc("The properties that the webhook will be created with.")
  properties?: WebhookPropertiesCreateParameters;
}

@doc("The parameters for creating the properties of a webhook.")
model WebhookPropertiesCreateParameters {
  @doc("The service URI for the webhook to post notifications.")
  serviceUri: string;

  @doc("Custom headers that will be added to the webhook notifications.")
  customHeaders?: Record<string>;

  @doc("The status of the webhook at the time the operation was called.")
  status?: WebhookStatus;

  @doc("The scope of repositories where the event can be triggered. For example, 'foo:*' means events for all tags under repository 'foo'. 'foo:bar' means events for 'foo:bar' only. 'foo' is equivalent to 'foo:latest'. Empty means all events.")
  scope?: string;

  @doc("The list of actions that trigger the webhook to post notifications.")
  actions: WebhookAction[];
}

@doc("The parameters for updating a webhook.")
model WebhookUpdateParameters {
  @doc("The tags for the webhook.")
  tags?: Record<string>;

  @doc("The properties that the webhook will be updated with.")
  properties?: WebhookPropertiesUpdateParameters;
}

@doc("The parameters for updating the properties of a webhook.")
model WebhookPropertiesUpdateParameters {
  @doc("The service URI for the webhook to post notifications.")
  serviceUri?: string;

  @doc("Custom headers that will be added to the webhook notifications.")
  customHeaders?: Record<string>;

  @doc("The status of the webhook at the time the operation was called.")
  status?: WebhookStatus;

  @doc("The scope of repositories where the event can be triggered. For example, 'foo:*' means events for all tags under repository 'foo'. 'foo:bar' means events for 'foo:bar' only. 'foo' is equivalent to 'foo:latest'. Empty means all events.")
  scope?: string;

  @doc("The list of actions that trigger the webhook to post notifications.")
  actions?: WebhookAction[];
}

@doc("The basic information of an event.")
model EventInfo {
  @doc("The event ID.")
  id?: string;
}

@doc("The result of a request to list events for a webhook.")
model EventListResult is Azure.Core.Page<Event>;

@doc("The event for a webhook.")
model Event extends EventInfo {
  @doc("The event request message sent to the service URI.")
  eventRequestMessage?: EventRequestMessage;

  @doc("The event response message received from the service URI.")
  eventResponseMessage?: EventResponseMessage;
}

@doc("The event request message sent to the service URI.")
model EventRequestMessage {
  @doc("The content of the event request message.")
  content?: EventContent;

  @doc("The headers of the event request message.")
  headers?: Record<string>;

  @doc("The HTTP method used to send the event request message.")
  method?: string;

  @doc("The URI used to send the event request message.")
  requestUri?: string;

  @doc("The HTTP message version.")
  version?: string;
}

@doc("The content of the event request message.")
model EventContent {
  @doc("The event ID.")
  id?: string;

  @doc("The time at which the event occurred.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("The action that encompasses the provided event.")
  action?: string;

  @doc("The target of the event.")
  target?: Target;

  @doc("The request that generated the event.")
  request?: Request;

  @doc("The agent that initiated the event. For most situations, this could be from the authorization context of the request.")
  actor?: Actor;

  @doc("The registry node that generated the event. Put differently, while the actor initiates the event, the source generates it.")
  source?: Source;
}

@doc("The target of the event.")
model Target {
  @doc("The MIME type of the referenced object.")
  mediaType?: string;

  @doc("The number of bytes of the content. Same as Length field.")
  size?: int32;

  @doc("The digest of the content, as defined by the Registry V2 HTTP API Specification.")
  digest?: string;

  @doc("The number of bytes of the content. Same as Size field.")
  length?: int32;

  @doc("The repository name.")
  repository?: string;

  @doc("The direct URL to the content.")
  url?: string;

  @doc("The tag name.")
  tag?: string;

  @doc("The name of the artifact.")
  name?: string;

  @doc("The version of the artifact.")
  version?: string;
}

@doc("The request that generated the event.")
model Request {
  @doc("The ID of the request that initiated the event.")
  id?: string;

  @doc("The IP or hostname and possibly port of the client connection that initiated the event. This is the RemoteAddr from the standard http request.")
  addr?: string;

  @doc("The externally accessible hostname of the registry instance, as specified by the http host header on incoming requests.")
  host?: string;

  @doc("The request method that generated the event.")
  method?: string;

  @doc("The user agent header of the request.")
  useragent?: string;
}

@doc("The agent that initiated the event. For most situations, this could be from the authorization context of the request.")
model Actor {
  @doc("The subject or username associated with the request context that generated the event.")
  name?: string;
}

@doc("The registry node that generated the event. Put differently, while the actor initiates the event, the source generates it.")
model Source {
  @doc("The IP or hostname and the port of the registry node that generated the event. Generally, this will be resolved by os.Hostname() along with the running port.")
  addr?: string;

  @doc("The running instance of an application. Changes after each restart.")
  instanceID?: string;
}

@doc("The event response message received from the service URI.")
model EventResponseMessage {
  @doc("The content of the event response message.")
  content?: string;

  @doc("The headers of the event response message.")
  headers?: Record<string>;

  @doc("The reason phrase of the event response message.")
  reasonPhrase?: string;

  @doc("The status code of the event response message.")
  statusCode?: string;

  @doc("The HTTP message version.")
  version?: string;
}

@doc("The configuration of service URI and custom headers for the webhook.")
model CallbackConfig {
  @doc("The service URI for the webhook to post notifications.")
  serviceUri: string;

  @doc("Custom headers that will be added to the webhook notifications.")
  customHeaders?: Record<string>;
}

@doc("The properties of agent pool.")
model AgentPoolProperties {
  @doc("The count of agent machine")
  count?: int32;

  @doc("The Tier of agent machine")
  tier?: string;

  @doc("The OS of agent machine")
  os?: OS;

  @doc("The Virtual Network Subnet Resource Id of the agent machine")
  virtualNetworkSubnetResourceId?: string;

  @doc("The provisioning state of this agent pool")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The parameters for updating an agent pool.")
model AgentPoolUpdateParameters {
  @doc("The properties associated with the agent pool")
  properties?: AgentPoolPropertiesUpdateParameters;

  @doc("The ARM resource tags.")
  tags?: Record<string>;
}

model AgentPoolPropertiesUpdateParameters {
  @doc("The count of agent machine")
  count?: int32;
}

@doc("The QueueStatus of Agent Pool")
model AgentPoolQueueStatus {
  @doc("The number of pending runs in the queue")
  count?: int32;
}

@doc("The request parameters for scheduling a run.")
@discriminator("type")
model RunRequest {
  @doc("The value that indicates whether archiving is enabled for the run or not.")
  isArchiveEnabled?: boolean;

  @doc("The dedicated agent pool for the run.")
  agentPoolName?: string;

  @doc("The template that describes the repository and tag information for run log artifact.")
  logTemplate?: string;
}

@doc("The properties for a run.")
model RunProperties {
  @doc("The unique identifier for the run.")
  runId?: string;

  @doc("The current status of the run.")
  status?: RunStatus;

  @doc("The last updated time for the run.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  @doc("The type of run.")
  runType?: RunType;

  @doc("The dedicated agent pool for the run.")
  agentPoolName?: string;

  @doc("The time the run was scheduled.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  @doc("The time the run started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The time the run finished.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishTime?: utcDateTime;

  @doc("The list of all images that were generated from the run. This is applicable if the run generates base image dependencies.")
  outputImages?: ImageDescriptor[];

  @doc("The task against which run was scheduled.")
  task?: string;

  @doc("The image update trigger that caused the run. This is applicable if the task has base image trigger configured.")
  imageUpdateTrigger?: ImageUpdateTrigger;

  @doc("The source trigger that caused the run.")
  sourceTrigger?: SourceTriggerDescriptor;

  @doc("The timer trigger that caused the run.")
  timerTrigger?: TimerTriggerDescriptor;

  @doc("The platform properties against which the run will happen.")
  platform?: PlatformProperties;

  @doc("The machine configuration of the run agent.")
  agentConfiguration?: AgentProperties;

  @doc("The scope of the credentials that were used to login to the source registry during this run.")
  sourceRegistryAuth?: string;

  @doc("The list of custom registries that were logged in during this run.")
  customRegistries?: string[];

  @doc("The error message received from backend systems after the run is scheduled.")
  @visibility("read")
  runErrorMessage?: string;

  @doc("The update trigger token passed for the Run.")
  updateTriggerToken?: string;

  @doc("The image description for the log artifact.")
  @visibility("read")
  logArtifact?: ImageDescriptor;

  @doc("The provisioning state of a run.")
  provisioningState?: ProvisioningState;

  @doc("The value that indicates whether archiving is enabled or not.")
  isArchiveEnabled?: boolean;
}

@doc("Properties for a registry image.")
model ImageDescriptor {
  @doc("The registry login server.")
  registry?: string;

  @doc("The repository name.")
  repository?: string;

  @doc("The tag name.")
  tag?: string;

  @doc("The sha256-based digest of the image manifest.")
  digest?: string;
}

@doc("The image update trigger that caused a build.")
model ImageUpdateTrigger {
  @doc("The unique ID of the trigger.")
  id?: string;

  @doc("The timestamp when the image update happened.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  @doc("The list of image updates that caused the build.")
  images?: ImageDescriptor[];
}

@doc("The source trigger that caused a run.")
model SourceTriggerDescriptor {
  @doc("The unique ID of the trigger.")
  id?: string;

  @doc("The event type of the trigger.")
  eventType?: string;

  @doc("The unique ID that identifies a commit.")
  commitId?: string;

  @doc("The unique ID that identifies pull request.")
  pullRequestId?: string;

  @doc("The repository URL.")
  repositoryUrl?: string;

  @doc("The branch name in the repository.")
  branchName?: string;

  @doc("The source control provider type.")
  providerType?: string;
}

model TimerTriggerDescriptor {
  @doc("The timer trigger name that caused the run.")
  timerTriggerName?: string;

  @doc("The occurrence that triggered the run.")
  scheduleOccurrence?: string;
}

@doc("The platform properties against which the run has to happen.")
model PlatformProperties {
  @doc("The operating system type required for the run.")
  os: OS;

  @doc("The OS architecture.")
  architecture?: Architecture;

  @doc("Variant of the CPU.")
  variant?: Variant;
}

@doc("The properties that determine the run agent configuration.")
model AgentProperties {
  @doc("The CPU configuration in terms of number of cores required for the run.")
  cpu?: int32;
}

@doc("The properties of a response to source upload request.")
model SourceUploadDefinition {
  @doc("The URL where the client can upload the source.")
  uploadUrl?: string;

  @doc("The relative path to the source. This is used to submit the subsequent queue build request.")
  relativePath?: string;
}

@doc("The set of run properties that can be updated.")
model RunUpdateParameters {
  @doc("The value that indicates whether archiving is enabled or not.")
  isArchiveEnabled?: boolean;
}

@doc("The result of get log link operation.")
model RunGetLogResult {
  @doc("The link to logs for a run on a azure container registry.")
  logLink?: string;

  @doc("The link to logs in registry for a run on a azure container registry.")
  logArtifactLink?: string;
}

@doc("The properties of task run.")
model TaskRunProperties {
  @doc("The provisioning state of this task run")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The request (parameters) for the run")
  runRequest?: RunRequest;

  @doc("The result of this task run")
  @visibility("read")
  runResult?: Run;

  @doc("How the run should be forced to rerun even if the run request configuration has not changed")
  forceUpdateTag?: string;
}

@doc("The parameters for updating a task run.")
model TaskRunUpdateParameters {
  @doc("Identity for the resource.")
  identity?: IdentityProperties;

  @doc("The properties for updating a task run.")
  properties?: TaskRunPropertiesUpdateParameters;

  @doc("The location of the resource")
  location?: string;

  @doc("The ARM resource tags.")
  tags?: Record<string>;
}

@doc("The properties of a task run update parameters.")
model TaskRunPropertiesUpdateParameters {
  @doc("The request (parameters) for the new run")
  runRequest?: RunRequest;

  @doc("How the run should be forced to rerun even if the run request configuration has not changed")
  forceUpdateTag?: string;
}

@doc("The properties of a task.")
model TaskProperties {
  @doc("The provisioning state of the task.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The creation date of task.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("The current status of task.")
  status?: TaskStatus;

  @doc("The platform properties against which the run has to happen.")
  platform?: PlatformProperties;

  @doc("The machine configuration of the run agent.")
  agentConfiguration?: AgentProperties;

  @doc("The dedicated agent pool for the task.")
  agentPoolName?: string;

  @doc("Run timeout in seconds.")
  @maxValue(28800)
  @minValue(300)
  timeout?: int32;

  @doc("The properties of a task step.")
  step?: TaskStepProperties;

  @doc("The properties that describe all triggers for the task.")
  trigger?: TriggerProperties;

  @doc("The properties that describes a set of credentials that will be used when this run is invoked.")
  credentials?: Credentials;

  @doc("The template that describes the repository and tag information for run log artifact.")
  logTemplate?: string;

  @doc("The value of this property indicates whether the task resource is system task or not.")
  isSystemTask?: boolean;
}

@doc("Base properties for any task step.")
@discriminator("type")
model TaskStepProperties {
  @doc("List of base image dependencies for a step.")
  @visibility("read")
  baseImageDependencies?: BaseImageDependency[];

  @doc("The URL(absolute or relative) of the source context for the task step.")
  contextPath?: string;

  @doc("The token (git PAT or SAS token of storage account blob) associated with the context for a step.")
  contextAccessToken?: string;
}

@doc("Properties that describe a base image dependency.")
model BaseImageDependency {
  @doc("The type of the base image dependency.")
  type?: BaseImageDependencyType;

  @doc("The registry login server.")
  registry?: string;

  @doc("The repository name.")
  repository?: string;

  @doc("The tag name.")
  tag?: string;

  @doc("The sha256-based digest of the image manifest.")
  digest?: string;
}

@doc("The properties of a trigger.")
model TriggerProperties {
  @doc("The collection of timer triggers.")
  timerTriggers?: TimerTrigger[];

  @doc("The collection of triggers based on source code repository.")
  sourceTriggers?: SourceTrigger[];

  @doc("The trigger based on base image dependencies.")
  baseImageTrigger?: BaseImageTrigger;
}

@doc("The properties of a timer trigger.")
model TimerTrigger {
  @doc("The CRON expression for the task schedule")
  schedule: string;

  @doc("The current status of trigger.")
  status?: TriggerStatus;

  @doc("The name of the trigger.")
  name: string;
}

@doc("The properties of a source based trigger.")
model SourceTrigger {
  @doc("The properties that describes the source(code) for the task.")
  sourceRepository: SourceProperties;

  @doc("The source event corresponding to the trigger.")
  sourceTriggerEvents: SourceTriggerEvent[];

  @doc("The current status of trigger.")
  status?: TriggerStatus;

  @doc("The name of the trigger.")
  name: string;
}

@doc("The properties of the source code repository.")
model SourceProperties {
  @doc("The type of source control service.")
  sourceControlType: SourceControlType;

  @doc("The full URL to the source code repository")
  repositoryUrl: string;

  @doc("The branch name of the source code.")
  branch?: string;

  @doc("""
The authorization properties for accessing the source code repository and to set up
webhooks for notifications.
""")
  sourceControlAuthProperties?: AuthInfo;
}

@doc("The authorization properties for accessing the source code repository.")
model AuthInfo {
  @doc("The type of Auth token.")
  tokenType: TokenType;

  @doc("The access token used to access the source control provider.")
  token: string;

  @doc("The refresh token used to refresh the access token.")
  refreshToken?: string;

  @doc("The scope of the access token.")
  scope?: string;

  @doc("Time in seconds that the token remains valid")
  expiresIn?: int32;
}

@doc("The trigger based on base image dependency.")
model BaseImageTrigger {
  @doc("The type of the auto trigger for base image dependency updates.")
  baseImageTriggerType: BaseImageTriggerType;

  @doc("The endpoint URL for receiving update triggers.")
  updateTriggerEndpoint?: string;

  @doc("Type of Payload body for Base image update triggers.")
  updateTriggerPayloadType?: UpdateTriggerPayloadType;

  @doc("The current status of trigger.")
  status?: TriggerStatus;

  @doc("The name of the trigger.")
  name: string;
}

@doc("The parameters that describes a set of credentials that will be used when a run is invoked.")
model Credentials {
  @doc("Describes the credential parameters for accessing the source registry.")
  sourceRegistry?: SourceRegistryCredentials;

  @doc("""
Describes the credential parameters for accessing other custom registries. The key
for the dictionary item will be the registry login server (myregistry.azurecr.io) and
the value of the item will be the registry credentials for accessing the registry.
""")
  customRegistries?: Record<CustomRegistryCredentials>;
}

@doc("Describes the credential parameters for accessing the source registry.")
model SourceRegistryCredentials {
  @doc("""
The authentication mode which determines the source registry login scope. The credentials for the source registry
will be generated using the given scope. These credentials will be used to login to
the source registry during the run.
""")
  loginMode?: SourceRegistryLoginMode;
}

@doc("Describes the credentials that will be used to access a custom registry during a run.")
model CustomRegistryCredentials {
  @doc("The username for logging into the custom registry.")
  userName?: SecretObject;

  @doc("""
The password for logging into the custom registry. The password is a secret 
object that allows multiple ways of providing the value for it.
""")
  password?: SecretObject;

  @doc("""
Indicates the managed identity assigned to the custom credential. If a user-assigned identity
this value is the Client ID. If a system-assigned identity, the value will be `system`. In
the case of a system-assigned identity, the Client ID will be determined by the runner. This
identity may be used to authenticate to key vault to retrieve credentials or it may be the only 
source of authentication used for accessing the registry.
""")
  identity?: string;
}

@doc("Describes the properties of a secret object value.")
model SecretObject {
  @doc("""
The value of the secret. The format of this value will be determined
based on the type of the secret object. If the type is Opaque, the value will be
used as is without any modification.
""")
  value?: string;

  @doc("""
The type of the secret object which determines how the value of the secret object has to be
interpreted.
""")
  type?: SecretObjectType;
}

@doc("The parameters for updating a task.")
model TaskUpdateParameters {
  @doc("Identity for the resource.")
  identity?: IdentityProperties;

  @doc("The properties for updating a task.")
  properties?: TaskPropertiesUpdateParameters;

  @doc("The ARM resource tags.")
  tags?: Record<string>;
}

@doc("The properties for updating a task.")
model TaskPropertiesUpdateParameters {
  @doc("The current status of task.")
  status?: TaskStatus;

  @doc("The platform properties against which the run has to happen.")
  platform?: PlatformUpdateParameters;

  @doc("The machine configuration of the run agent.")
  agentConfiguration?: AgentProperties;

  @doc("The dedicated agent pool for the task.")
  agentPoolName?: string;

  @doc("Run timeout in seconds.")
  timeout?: int32;

  @doc("The properties for updating a task step.")
  step?: TaskStepUpdateParameters;

  @doc("The properties for updating trigger properties.")
  trigger?: TriggerUpdateParameters;

  @doc("The parameters that describes a set of credentials that will be used when this run is invoked.")
  credentials?: Credentials;

  @doc("The template that describes the repository and tag information for run log artifact.")
  logTemplate?: string;
}

@doc("The properties for updating the platform configuration.")
model PlatformUpdateParameters {
  @doc("The operating system type required for the run.")
  os?: OS;

  @doc("The OS architecture.")
  architecture?: Architecture;

  @doc("Variant of the CPU.")
  variant?: Variant;
}

@doc("Base properties for updating any task step.")
@discriminator("type")
model TaskStepUpdateParameters {
  @doc("The URL(absolute or relative) of the source context for the task step.")
  contextPath?: string;

  @doc("The token (git PAT or SAS token of storage account blob) associated with the context for a step.")
  contextAccessToken?: string;
}

@doc("The properties for updating triggers.")
model TriggerUpdateParameters {
  @doc("The collection of timer triggers.")
  timerTriggers?: TimerTriggerUpdateParameters[];

  @doc("The collection of triggers based on source code repository.")
  sourceTriggers?: SourceTriggerUpdateParameters[];

  @doc("The trigger based on base image dependencies.")
  baseImageTrigger?: BaseImageTriggerUpdateParameters;
}

@doc("The properties for updating a timer trigger.")
model TimerTriggerUpdateParameters {
  @doc("The CRON expression for the task schedule")
  schedule?: string;

  @doc("The current status of trigger.")
  status?: TriggerStatus;

  @doc("The name of the trigger.")
  name: string;
}

@doc("The properties for updating a source based trigger.")
model SourceTriggerUpdateParameters {
  @doc("The properties that describes the source(code) for the task.")
  sourceRepository?: SourceUpdateParameters;

  @doc("The source event corresponding to the trigger.")
  sourceTriggerEvents?: SourceTriggerEvent[];

  @doc("The current status of trigger.")
  status?: TriggerStatus;

  @doc("The name of the trigger.")
  name: string;
}

@doc("The properties for updating the source code repository.")
model SourceUpdateParameters {
  @doc("The type of source control service.")
  sourceControlType?: SourceControlType;

  @doc("The full URL to the source code repository")
  repositoryUrl?: string;

  @doc("The branch name of the source code.")
  branch?: string;

  @doc("""
The authorization properties for accessing the source code repository and to set up
webhooks for notifications.
""")
  sourceControlAuthProperties?: AuthInfoUpdateParameters;
}

@doc("The authorization properties for accessing the source code repository.")
model AuthInfoUpdateParameters {
  @doc("The type of Auth token.")
  tokenType?: TokenType;

  @doc("The access token used to access the source control provider.")
  token?: string;

  @doc("The refresh token used to refresh the access token.")
  refreshToken?: string;

  @doc("The scope of the access token.")
  scope?: string;

  @doc("Time in seconds that the token remains valid")
  expiresIn?: int32;
}

@doc("The properties for updating base image dependency trigger.")
model BaseImageTriggerUpdateParameters {
  @doc("The type of the auto trigger for base image dependency updates.")
  baseImageTriggerType?: BaseImageTriggerType;

  @doc("The endpoint URL for receiving update triggers.")
  updateTriggerEndpoint?: string;

  @doc("Type of Payload body for Base image update triggers.")
  updateTriggerPayloadType?: UpdateTriggerPayloadType;

  @doc("The current status of trigger.")
  status?: TriggerStatus;

  @doc("The name of the trigger.")
  name: string;
}

@doc("The properties of a storage account for a container registry. Only applicable to Classic SKU.")
model StorageAccountProperties {
  @doc("The resource ID of the storage account.")
  id: string;
}

@doc("The properties of a package type.")
model PackageType {
  @doc("The name of the package type.")
  name?: string;

  @doc("The endpoint of the package type.")
  @visibility("read")
  endpoint?: string;
}

@doc("The Active Directory Object that will be used for authenticating the token of a container registry.")
model ActiveDirectoryObject {
  @doc("The user/group/application object ID for Active Directory Object that will be used for authenticating the token of a container registry.")
  objectId?: string;

  @doc("The tenant ID of user/group/application object Active Directory Object that will be used for authenticating the token of a container registry.")
  tenantId?: string;
}

@doc("Properties that are enabled for Odata querying on runs.")
model RunFilter {
  @doc("The unique identifier for the run.")
  runId?: string;

  @doc("The type of run.")
  runType?: RunType;

  @doc("The current status of the run.")
  status?: RunStatus;

  @doc("The create time for a run.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  @doc("The time the run finished.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishTime?: utcDateTime;

  @doc("""
The list of comma-separated image manifests that were generated from the run. This is applicable if the run is of
build type.
""")
  outputImageManifests?: string;

  @doc("The value that indicates whether archiving is enabled or not.")
  isArchiveEnabled?: boolean;

  @doc("The name of the task that the run corresponds to.")
  taskName?: string;

  @doc("The name of the agent pool that the run corresponds to.")
  agentPoolName?: string;
}

@doc("The parameters for a docker quick build.")
model DockerBuildRequest extends RunRequest {
  @doc("The fully qualified image names including the repository and tag.")
  imageNames?: string[];

  @doc("The value of this property indicates whether the image built should be pushed to the registry or not.")
  isPushEnabled?: boolean;

  @doc("The value of this property indicates whether the image cache is enabled or not.")
  noCache?: boolean;

  @doc("The Docker file path relative to the source location.")
  dockerFilePath: string;

  @doc("The name of the target build stage for the docker build.")
  target?: string;

  @doc("The collection of override arguments to be used when executing the run.")
  arguments?: Argument[];

  @doc("Run timeout in seconds.")
  @maxValue(28800)
  @minValue(300)
  timeout?: int32;

  @doc("The platform properties against which the run has to happen.")
  platform: PlatformProperties;

  @doc("The machine configuration of the run agent.")
  agentConfiguration?: AgentProperties;

  @doc("""
The URL(absolute or relative) of the source context. It can be an URL to a tar or git repository.
If it is relative URL, the relative path should be obtained from calling listBuildSourceUploadUrl API.
""")
  sourceLocation?: string;

  @doc("The properties that describes a set of credentials that will be used when this run is invoked.")
  credentials?: Credentials;

  @doc("The type of the run request.")
  type: "DockerBuildRequest";
}

@doc("The properties of a run argument.")
model Argument {
  @doc("The name of the argument.")
  name: string;

  @doc("The value of the argument.")
  value: string;

  @doc("Flag to indicate whether the argument represents a secret and want to be removed from build logs.")
  isSecret?: boolean;
}

@doc("The request parameters for a scheduling run against a task file.")
model FileTaskRunRequest extends RunRequest {
  @doc("The template/definition file path relative to the source.")
  taskFilePath: string;

  @doc("The values/parameters file path relative to the source.")
  valuesFilePath?: string;

  @doc("The collection of overridable values that can be passed when running a task.")
  values?: SetValue[];

  @doc("Run timeout in seconds.")
  @maxValue(28800)
  @minValue(300)
  timeout?: int32;

  @doc("The platform properties against which the run has to happen.")
  platform: PlatformProperties;

  @doc("The machine configuration of the run agent.")
  agentConfiguration?: AgentProperties;

  @doc("""
The URL(absolute or relative) of the source context. It can be an URL to a tar or git repository.
If it is relative URL, the relative path should be obtained from calling listBuildSourceUploadUrl API.
""")
  sourceLocation?: string;

  @doc("The properties that describes a set of credentials that will be used when this run is invoked.")
  credentials?: Credentials;

  @doc("The type of the run request.")
  type: "FileTaskRunRequest";
}

@doc("The properties of a overridable value that can be passed to a task template.")
model SetValue {
  @doc("The name of the overridable value.")
  name: string;

  @doc("The overridable value.")
  value: string;

  @doc("Flag to indicate whether the value represents a secret or not.")
  isSecret?: boolean;
}

@doc("The parameters for a task run request.")
model TaskRunRequest extends RunRequest {
  @doc("The resource ID of task against which run has to be queued.")
  taskId: string;

  @doc("Set of overridable parameters that can be passed when running a Task.")
  overrideTaskStepProperties?: OverrideTaskStepProperties;

  @doc("The type of the run request.")
  type: "TaskRunRequest";
}

model OverrideTaskStepProperties {
  @doc("The source context against which run has to be queued.")
  contextPath?: string;

  @doc("The file against which run has to be queued.")
  file?: string;

  @doc("""
Gets or sets the collection of override arguments to be used when
executing a build step.
""")
  arguments?: Argument[];

  @doc("The name of the target build stage for the docker build.")
  target?: string;

  @doc("The collection of overridable values that can be passed when running a Task.")
  values?: SetValue[];

  @doc("Base64 encoded update trigger token that will be attached with the base image trigger webhook.")
  updateTriggerToken?: string;
}

@doc("The parameters for a quick task run request.")
model EncodedTaskRunRequest extends RunRequest {
  @doc("Base64 encoded value of the template/definition file content.")
  encodedTaskContent: string;

  @doc("Base64 encoded value of the parameters/values file content.")
  encodedValuesContent?: string;

  @doc("The collection of overridable values that can be passed when running a task.")
  values?: SetValue[];

  @doc("Run timeout in seconds.")
  @maxValue(28800)
  @minValue(300)
  timeout?: int32;

  @doc("The platform properties against which the run has to happen.")
  platform: PlatformProperties;

  @doc("The machine configuration of the run agent.")
  agentConfiguration?: AgentProperties;

  @doc("""
The URL(absolute or relative) of the source context. It can be an URL to a tar or git repository.
If it is relative URL, the relative path should be obtained from calling listBuildSourceUploadUrl API.
""")
  sourceLocation?: string;

  @doc("The properties that describes a set of credentials that will be used when this run is invoked.")
  credentials?: Credentials;

  @doc("The type of the run request.")
  type: "EncodedTaskRunRequest";
}

@doc("The Docker build step.")
model DockerBuildStep extends TaskStepProperties {
  @doc("The fully qualified image names including the repository and tag.")
  imageNames?: string[];

  @doc("The value of this property indicates whether the image built should be pushed to the registry or not.")
  isPushEnabled?: boolean;

  @doc("The value of this property indicates whether the image cache is enabled or not.")
  noCache?: boolean;

  @doc("The Docker file path relative to the source context.")
  dockerFilePath: string;

  @doc("The name of the target build stage for the docker build.")
  target?: string;

  @doc("The collection of override arguments to be used when executing this build step.")
  arguments?: Argument[];

  @doc("The type of the step.")
  type: "Docker";
}

@doc("The properties of a task step.")
model FileTaskStep extends TaskStepProperties {
  @doc("The task template/definition file path relative to the source context.")
  taskFilePath: string;

  @doc("The task values/parameters file path relative to the source context.")
  valuesFilePath?: string;

  @doc("The collection of overridable values that can be passed when running a task.")
  values?: SetValue[];

  @doc("The type of the step.")
  type: "FileTask";
}

@doc("The properties of a encoded task step.")
model EncodedTaskStep extends TaskStepProperties {
  @doc("Base64 encoded value of the template/definition file content.")
  encodedTaskContent: string;

  @doc("Base64 encoded value of the parameters/values file content.")
  encodedValuesContent?: string;

  @doc("The collection of overridable values that can be passed when running a task.")
  values?: SetValue[];

  @doc("The type of the step.")
  type: "EncodedTask";
}

@doc("The properties for updating a docker build step.")
model DockerBuildStepUpdateParameters extends TaskStepUpdateParameters {
  @doc("The fully qualified image names including the repository and tag.")
  imageNames?: string[];

  @doc("The value of this property indicates whether the image built should be pushed to the registry or not.")
  isPushEnabled?: boolean;

  @doc("The value of this property indicates whether the image cache is enabled or not.")
  noCache?: boolean;

  @doc("The Docker file path relative to the source context.")
  dockerFilePath?: string;

  @doc("The collection of override arguments to be used when executing this build step.")
  arguments?: Argument[];

  @doc("The name of the target build stage for the docker build.")
  target?: string;

  @doc("The type of the step.")
  type: "Docker";
}

@doc("The properties of updating a task step.")
model FileTaskStepUpdateParameters extends TaskStepUpdateParameters {
  @doc("The task template/definition file path relative to the source context.")
  taskFilePath?: string;

  @doc("The values/parameters file path relative to the source context.")
  valuesFilePath?: string;

  @doc("The collection of overridable values that can be passed when running a task.")
  values?: SetValue[];

  @doc("The type of the step.")
  type: "FileTask";
}

@doc("The properties for updating encoded task step.")
model EncodedTaskStepUpdateParameters extends TaskStepUpdateParameters {
  @doc("Base64 encoded value of the template/definition file content.")
  encodedTaskContent?: string;

  @doc("Base64 encoded value of the parameters/values file content.")
  encodedValuesContent?: string;

  @doc("The collection of overridable values that can be passed when running a task.")
  values?: SetValue[];

  @doc("The type of the step.")
  type: "EncodedTask";
}
