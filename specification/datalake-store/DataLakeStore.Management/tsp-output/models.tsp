import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataLakeStore;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The intended executor of the operation.")
enum OperationOrigin {
  user,
  system,
  `user,system`,
}

@doc("The subscription state.")
enum SubscriptionState {
  Registered,
  Suspended,
  Deleted,
  Unregistered,
  Warned,
}

@doc("The resource type. Note: This should not be set by the user, as the constant value is Microsoft.DataLakeStore/accounts")
enum CheckNameAvailabilityParametersType {
  `Microsoft.DataLakeStore/accounts`,
}

@doc("The provisioning status of the Data Lake Store account.")
@fixed
enum DataLakeStoreAccountStatus {
  Failed,
  Creating,
  Running,
  Succeeded,
  Patching,
  Suspending,
  Resuming,
  Deleting,
  Deleted,
  Undeleting,
  Canceled,
}

@doc("The state of the Data Lake Store account.")
@fixed
enum DataLakeStoreAccountState {
  Active,
  Suspended,
}

@doc("The type of encryption configuration being used. Currently the only supported types are 'UserManaged' and 'ServiceManaged'.")
@fixed
enum EncryptionConfigType {
  UserManaged,
  ServiceManaged,
}

@doc("The current state of encryption for this Data Lake Store account.")
@fixed
enum EncryptionState {
  Enabled,
  Disabled,
}

@doc("The current state of the IP address firewall for this Data Lake Store account.")
@fixed
enum FirewallState {
  Enabled,
  Disabled,
}

@doc("The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.")
@fixed
enum FirewallAllowAzureIpsState {
  Enabled,
  Disabled,
}

@doc("The current state of the trusted identity provider feature for this Data Lake Store account.")
@fixed
enum TrustedIdProviderState {
  Enabled,
  Disabled,
}

@doc("The commitment tier to use for next month.")
@fixed
enum TierType {
  Consumption,
  Commitment_1TB,
  Commitment_10TB,
  Commitment_100TB,
  Commitment_500TB,
  Commitment_1PB,
  Commitment_5PB,
}

@doc("The current state of encryption provisioning for this Data Lake Store account.")
@fixed
enum EncryptionProvisioningState {
  Creating,
  Succeeded,
}

@doc("Gets the unit of measurement.")
@fixed
enum UsageUnit {
  Count,
  Bytes,
  Seconds,
  Percent,
  CountsPerSecond,
  BytesPerSecond,
}

@doc("Basic Data Lake Store account information, returned on list calls.")
model DataLakeStoreAccountBasic extends Resource {
  @doc("The basic Data Lake Store account properties.")
  @visibility("read")
  properties?: DataLakeStoreAccountPropertiesBasic;
}

@doc("The basic account specific properties that are associated with an underlying Data Lake Store account.")
model DataLakeStoreAccountPropertiesBasic {
  @doc("The unique identifier associated with this Data Lake Store account.")
  @visibility("read")
  accountId?: string;

  @doc("The provisioning status of the Data Lake Store account.")
  @visibility("read")
  provisioningState?: DataLakeStoreAccountStatus;

  @doc("The state of the Data Lake Store account.")
  @visibility("read")
  state?: DataLakeStoreAccountState;

  @doc("The account creation time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("The account last modified time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("The full CName endpoint for this account.")
  @visibility("read")
  endpoint?: string;
}

@doc("The resource model definition.")
model Resource {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;

  @doc("The resource location.")
  @visibility("read")
  location?: string;

  @doc("The resource tags.")
  @visibility("read")
  tags?: Record<string>;
}

model CreateDataLakeStoreAccountParameters {
  @doc("The resource location.")
  location: string;

  @doc("The resource tags.")
  tags?: Record<string>;

  @doc("The Key Vault encryption identity, if any.")
  identity?: EncryptionIdentity;

  @doc("The Data Lake Store account properties to use for creating.")
  properties?: CreateDataLakeStoreAccountProperties;
}

@doc("The encryption identity properties.")
model EncryptionIdentity {
  @doc("The type of encryption being used. Currently the only supported type is 'SystemAssigned'.")
  type: "SystemAssigned";

  @doc("The principal identifier associated with the encryption.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant identifier associated with the encryption.")
  @visibility("read")
  tenantId?: string;
}

model CreateDataLakeStoreAccountProperties {
  @doc("The default owner group for all new folders and files created in the Data Lake Store account.")
  defaultGroup?: string;

  @doc("The Key Vault encryption configuration.")
  encryptionConfig?: EncryptionConfig;

  @doc("The current state of encryption for this Data Lake Store account.")
  encryptionState?: EncryptionState;

  @doc("The list of firewall rules associated with this Data Lake Store account.")
  firewallRules?: CreateFirewallRuleWithAccountParameters[];

  @doc("The list of virtual network rules associated with this Data Lake Store account.")
  virtualNetworkRules?: CreateVirtualNetworkRuleWithAccountParameters[];

  @doc("The current state of the IP address firewall for this Data Lake Store account.")
  firewallState?: FirewallState;

  @doc("The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.")
  firewallAllowAzureIps?: FirewallAllowAzureIpsState;

  @doc("The list of trusted identity providers associated with this Data Lake Store account.")
  trustedIdProviders?: CreateTrustedIdProviderWithAccountParameters[];

  @doc("The current state of the trusted identity provider feature for this Data Lake Store account.")
  trustedIdProviderState?: TrustedIdProviderState;

  @doc("The commitment tier to use for next month.")
  newTier?: TierType;
}

@doc("The encryption configuration for the account.")
model EncryptionConfig {
  @doc("The type of encryption configuration being used. Currently the only supported types are 'UserManaged' and 'ServiceManaged'.")
  type: EncryptionConfigType;

  @doc("The Key Vault information for connecting to user managed encryption keys.")
  keyVaultMetaInfo?: KeyVaultMetaInfo;
}

@doc("Metadata information used by account encryption.")
model KeyVaultMetaInfo {
  @doc("The resource identifier for the user managed Key Vault being used to encrypt.")
  keyVaultResourceId: string;

  @doc("The name of the user managed encryption key.")
  encryptionKeyName: string;

  @doc("The version of the user managed encryption key.")
  encryptionKeyVersion: string;
}

@doc("The parameters used to create a new firewall rule while creating a new Data Lake Store account.")
model CreateFirewallRuleWithAccountParameters {
  @doc("The unique name of the firewall rule to create.")
  name: string;

  @doc("The firewall rule properties to use when creating a new firewall rule.")
  properties: CreateOrUpdateFirewallRuleProperties;
}

@doc("The firewall rule properties to use when creating a new firewall rule.")
model CreateOrUpdateFirewallRuleProperties {
  @doc("The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.")
  startIpAddress: string;

  @doc("The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.")
  endIpAddress: string;
}

@doc("The parameters used to create a new virtual network rule while creating a new Data Lake Store account.")
model CreateVirtualNetworkRuleWithAccountParameters {
  @doc("The unique name of the virtual network rule to create.")
  name: string;

  @doc("The virtual network rule properties to use when creating a new virtual network rule.")
  properties: CreateOrUpdateVirtualNetworkRuleProperties;
}

@doc("The virtual network rule properties to use when creating a new virtual network rule.")
model CreateOrUpdateVirtualNetworkRuleProperties {
  @doc("The resource identifier for the subnet.")
  subnetId: string;
}

@doc("The parameters used to create a new trusted identity provider while creating a new Data Lake Store account.")
model CreateTrustedIdProviderWithAccountParameters {
  @doc("The unique name of the trusted identity provider to create.")
  name: string;

  @doc("The trusted identity provider properties to use when creating a new trusted identity provider.")
  properties: CreateOrUpdateTrustedIdProviderProperties;
}

@doc("The trusted identity provider properties to use when creating a new trusted identity provider.")
model CreateOrUpdateTrustedIdProviderProperties {
  @doc("The URL of this trusted identity provider.")
  idProvider: string;
}

@doc("Data Lake Store account properties information.")
model DataLakeStoreAccountProperties
  extends DataLakeStoreAccountPropertiesBasic {
  @doc("The default owner group for all new folders and files created in the Data Lake Store account.")
  @visibility("read")
  defaultGroup?: string;

  @doc("The Key Vault encryption configuration.")
  @visibility("read")
  encryptionConfig?: EncryptionConfig;

  @doc("The current state of encryption for this Data Lake Store account.")
  @visibility("read")
  encryptionState?: EncryptionState;

  @doc("The current state of encryption provisioning for this Data Lake Store account.")
  @visibility("read")
  encryptionProvisioningState?: EncryptionProvisioningState;

  @doc("The list of firewall rules associated with this Data Lake Store account.")
  @visibility("read")
  firewallRules?: FirewallRule[];

  @doc("The list of virtual network rules associated with this Data Lake Store account.")
  @visibility("read")
  virtualNetworkRules?: VirtualNetworkRule[];

  @doc("The current state of the IP address firewall for this Data Lake Store account.")
  @visibility("read")
  firewallState?: FirewallState;

  @doc("The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.")
  @visibility("read")
  firewallAllowAzureIps?: FirewallAllowAzureIpsState;

  @doc("The list of trusted identity providers associated with this Data Lake Store account.")
  @visibility("read")
  trustedIdProviders?: TrustedIdProvider[];

  @doc("The current state of the trusted identity provider feature for this Data Lake Store account.")
  @visibility("read")
  trustedIdProviderState?: TrustedIdProviderState;

  @doc("The commitment tier to use for next month.")
  @visibility("read")
  newTier?: TierType;

  @doc("The commitment tier in use for the current month.")
  @visibility("read")
  currentTier?: TierType;
}

@doc("The firewall rule properties.")
model FirewallRuleProperties {
  @doc("The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.")
  @visibility("read")
  startIpAddress?: string;

  @doc("The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.")
  @visibility("read")
  endIpAddress?: string;
}

@doc("The resource model definition for a nested resource.")
model SubResource {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;
}

@doc("The virtual network rule properties.")
model VirtualNetworkRuleProperties {
  @doc("The resource identifier for the subnet.")
  @visibility("read")
  subnetId?: string;
}

@doc("The trusted identity provider properties.")
model TrustedIdProviderProperties {
  @doc("The URL of this trusted identity provider.")
  @visibility("read")
  idProvider?: string;
}

@doc("Data Lake Store account information to update.")
model UpdateDataLakeStoreAccountParameters {
  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The Data Lake Store account properties to update.")
  properties?: UpdateDataLakeStoreAccountProperties;
}

@doc("Data Lake Store account properties information to be updated.")
model UpdateDataLakeStoreAccountProperties {
  @doc("The default owner group for all new folders and files created in the Data Lake Store account.")
  defaultGroup?: string;

  @doc("Used for rotation of user managed Key Vault keys. Can only be used to rotate a user managed encryption Key Vault key.")
  encryptionConfig?: UpdateEncryptionConfig;

  @doc("The list of firewall rules associated with this Data Lake Store account.")
  firewallRules?: UpdateFirewallRuleWithAccountParameters[];

  @doc("The list of virtual network rules associated with this Data Lake Store account.")
  virtualNetworkRules?: UpdateVirtualNetworkRuleWithAccountParameters[];

  @doc("The current state of the IP address firewall for this Data Lake Store account. Disabling the firewall does not remove existing rules, they will just be ignored until the firewall is re-enabled.")
  firewallState?: FirewallState;

  @doc("The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.")
  firewallAllowAzureIps?: FirewallAllowAzureIpsState;

  @doc("The list of trusted identity providers associated with this Data Lake Store account.")
  trustedIdProviders?: UpdateTrustedIdProviderWithAccountParameters[];

  @doc("The current state of the trusted identity provider feature for this Data Lake Store account. Disabling trusted identity provider functionality does not remove the providers, they will just be ignored until this feature is re-enabled.")
  trustedIdProviderState?: TrustedIdProviderState;

  @doc("The commitment tier to use for next month.")
  newTier?: TierType;
}

@doc("The encryption configuration used to update a user managed Key Vault key.")
model UpdateEncryptionConfig {
  @doc("The updated Key Vault key to use in user managed key rotation.")
  keyVaultMetaInfo?: UpdateKeyVaultMetaInfo;
}

@doc("The Key Vault update information used for user managed key rotation.")
model UpdateKeyVaultMetaInfo {
  @doc("The version of the user managed encryption key to update through a key rotation.")
  encryptionKeyVersion?: string;
}

@doc("The parameters used to update a firewall rule while updating a Data Lake Store account.")
model UpdateFirewallRuleWithAccountParameters {
  @doc("The unique name of the firewall rule to update.")
  name: string;

  @doc("The firewall rule properties to use when updating a firewall rule.")
  properties?: UpdateFirewallRuleProperties;
}

@doc("The firewall rule properties to use when updating a firewall rule.")
model UpdateFirewallRuleProperties {
  @doc("The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.")
  startIpAddress?: string;

  @doc("The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.")
  endIpAddress?: string;
}

@doc("The parameters used to update a virtual network rule while updating a Data Lake Store account.")
model UpdateVirtualNetworkRuleWithAccountParameters {
  @doc("The unique name of the virtual network rule to update.")
  name: string;

  @doc("The virtual network rule properties to use when updating a virtual network rule.")
  properties?: UpdateVirtualNetworkRuleProperties;
}

@doc("The virtual network rule properties to use when updating a virtual network rule.")
model UpdateVirtualNetworkRuleProperties {
  @doc("The resource identifier for the subnet.")
  subnetId?: string;
}

@doc("The parameters used to update a trusted identity provider while updating a Data Lake Store account.")
model UpdateTrustedIdProviderWithAccountParameters {
  @doc("The unique name of the trusted identity provider to update.")
  name: string;

  @doc("The trusted identity provider properties to use when updating a trusted identity provider.")
  properties?: UpdateTrustedIdProviderProperties;
}

@doc("The trusted identity provider properties to use when updating a trusted identity provider.")
model UpdateTrustedIdProviderProperties {
  @doc("The URL of this trusted identity provider.")
  idProvider?: string;
}

@doc("The parameters used to create a new firewall rule.")
model CreateOrUpdateFirewallRuleParameters {
  @doc("The firewall rule properties to use when creating a new firewall rule.")
  properties: CreateOrUpdateFirewallRuleProperties;
}

@doc("The parameters used to update a firewall rule.")
model UpdateFirewallRuleParameters {
  @doc("The firewall rule properties to use when updating a firewall rule.")
  properties?: UpdateFirewallRuleProperties;
}

@doc("The parameters used to create a new virtual network rule.")
model CreateOrUpdateVirtualNetworkRuleParameters {
  @doc("The virtual network rule properties to use when creating a new virtual network rule.")
  properties: CreateOrUpdateVirtualNetworkRuleProperties;
}

@doc("The parameters used to update a virtual network rule.")
model UpdateVirtualNetworkRuleParameters {
  @doc("The virtual network rule properties to use when updating a virtual network rule.")
  properties?: UpdateVirtualNetworkRuleProperties;
}

@doc("The parameters used to create a new trusted identity provider.")
model CreateOrUpdateTrustedIdProviderParameters {
  @doc("The trusted identity provider properties to use when creating a new trusted identity provider.")
  properties: CreateOrUpdateTrustedIdProviderProperties;
}

@doc("The parameters used to update a trusted identity provider.")
model UpdateTrustedIdProviderParameters {
  @doc("The trusted identity provider properties to use when updating a trusted identity provider.")
  properties?: UpdateTrustedIdProviderProperties;
}

@doc("Subscription-level properties and limits for Data Lake Store.")
model CapabilityInformation {
  @doc("The subscription credentials that uniquely identifies the subscription.")
  @visibility("read")
  subscriptionId?: string;

  @doc("The subscription state.")
  @visibility("read")
  state?: SubscriptionState;

  @doc("The maximum supported number of accounts under this subscription.")
  @visibility("read")
  maxAccountCount?: int32;

  @doc("The current number of accounts under this subscription.")
  @visibility("read")
  accountCount?: int32;

  @doc("The Boolean value of true or false to indicate the maintenance state.")
  @visibility("read")
  migrationState?: boolean;
}

@doc("The response from the List Usages operation.")
@pagedResult
model UsageListResult {
  @doc("Gets or sets the list of Storage Resource Usages.")
  @items
  value?: Usage[];
}

@doc("Describes the Resource Usage.")
model Usage {
  @doc("Gets the unit of measurement.")
  @visibility("read")
  unit?: UsageUnit;

  @doc("Resource identifier.")
  @visibility("read")
  id?: string;

  @doc("Gets the current count of the allocated resources in the subscription.")
  @visibility("read")
  currentValue?: int32;

  @doc("Gets the maximum count of the resources that can be allocated in the subscription.")
  @visibility("read")
  limit?: int32;

  @doc("Gets the name of the type of usage.")
  @visibility("read")
  name?: UsageName;
}

@doc("The usage names that can be used.")
model UsageName {
  @doc("Gets a string describing the resource name.")
  @visibility("read")
  value?: string;

  @doc("Gets a localized string describing the resource name.")
  @visibility("read")
  localizedValue?: string;
}

@doc("Data Lake Store account name availability check parameters.")
model CheckNameAvailabilityParameters {
  @doc("The Data Lake Store name to check availability for.")
  name: string;

  @doc("The resource type. Note: This should not be set by the user, as the constant value is Microsoft.DataLakeStore/accounts")
  type: CheckNameAvailabilityParametersType;
}

@doc("Data Lake Store account name availability result information.")
model NameAvailabilityInformation {
  @doc("The Boolean value of true or false to indicate whether the Data Lake Store account name is available or not.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("The reason why the Data Lake Store account name is not available, if nameAvailable is false.")
  @visibility("read")
  reason?: string;

  @doc("The message describing why the Data Lake Store account name is not available, if nameAvailable is false.")
  @visibility("read")
  message?: string;
}
