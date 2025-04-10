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

/**
 * The intended executor of the operation.
 */
union OperationOrigin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `user,system`: "user,system",
}

/**
 * The subscription state.
 */
union SubscriptionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Registered: "Registered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unregistered: "Unregistered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warned: "Warned",
}

/**
 * The resource type. Note: This should not be set by the user, as the constant value is Microsoft.DataLakeStore/accounts
 */
union CheckNameAvailabilityParametersType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.DataLakeStore/accounts`: "Microsoft.DataLakeStore/accounts",
}

/**
 * The provisioning status of the Data Lake Store account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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

/**
 * The state of the Data Lake Store account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DataLakeStoreAccountState {
  Active,
  Suspended,
}

/**
 * The type of encryption configuration being used. Currently the only supported types are 'UserManaged' and 'ServiceManaged'.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum EncryptionConfigType {
  UserManaged,
  ServiceManaged,
}

/**
 * The current state of encryption for this Data Lake Store account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum EncryptionState {
  Enabled,
  Disabled,
}

/**
 * The current state of the IP address firewall for this Data Lake Store account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum FirewallState {
  Enabled,
  Disabled,
}

/**
 * The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum FirewallAllowAzureIpsState {
  Enabled,
  Disabled,
}

/**
 * The current state of the trusted identity provider feature for this Data Lake Store account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum TrustedIdProviderState {
  Enabled,
  Disabled,
}

/**
 * The commitment tier to use for next month.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum TierType {
  Consumption,
  Commitment_1TB,
  Commitment_10TB,
  Commitment_100TB,
  Commitment_500TB,
  Commitment_1PB,
  Commitment_5PB,
}

/**
 * The current state of encryption provisioning for this Data Lake Store account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum EncryptionProvisioningState {
  Creating,
  Succeeded,
}

/**
 * Gets the unit of measurement.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum UsageUnit {
  Count,
  Bytes,
  Seconds,
  Percent,
  CountsPerSecond,
  BytesPerSecond,
}

/**
 * Basic Data Lake Store account information, returned on list calls.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DataLakeStoreAccountBasic extends Resource {
  /**
   * The basic Data Lake Store account properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: DataLakeStoreAccountPropertiesBasic;
}

/**
 * The basic account specific properties that are associated with an underlying Data Lake Store account.
 */
model DataLakeStoreAccountPropertiesBasic {
  /**
   * The unique identifier associated with this Data Lake Store account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  accountId?: string;

  /**
   * The provisioning status of the Data Lake Store account.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DataLakeStoreAccountStatus;

  /**
   * The state of the Data Lake Store account.
   */
  @visibility(Lifecycle.Read)
  state?: DataLakeStoreAccountState;

  /**
   * The account creation time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The account last modified time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * The full CName endpoint for this account.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;
}

/**
 * The resource model definition.
 */
model Resource {
  /**
   * The resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The resource location.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CreateDataLakeStoreAccountParameters {
  /**
   * The resource location.
   */
  location: string;

  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The Key Vault encryption identity, if any.
   */
  identity?: EncryptionIdentity;

  /**
   * The Data Lake Store account properties to use for creating.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: CreateDataLakeStoreAccountProperties;
}

/**
 * The encryption identity properties.
 */
model EncryptionIdentity {
  /**
   * The type of encryption being used. Currently the only supported type is 'SystemAssigned'.
   */
  type: "SystemAssigned";

  /**
   * The principal identifier associated with the encryption.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The tenant identifier associated with the encryption.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CreateDataLakeStoreAccountProperties {
  /**
   * The default owner group for all new folders and files created in the Data Lake Store account.
   */
  defaultGroup?: string;

  /**
   * The Key Vault encryption configuration.
   */
  encryptionConfig?: EncryptionConfig;

  /**
   * The current state of encryption for this Data Lake Store account.
   */
  encryptionState?: EncryptionState;

  /**
   * The list of firewall rules associated with this Data Lake Store account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  firewallRules?: CreateFirewallRuleWithAccountParameters[];

  /**
   * The list of virtual network rules associated with this Data Lake Store account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  virtualNetworkRules?: CreateVirtualNetworkRuleWithAccountParameters[];

  /**
   * The current state of the IP address firewall for this Data Lake Store account.
   */
  firewallState?: FirewallState;

  /**
   * The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.
   */
  firewallAllowAzureIps?: FirewallAllowAzureIpsState;

  /**
   * The list of trusted identity providers associated with this Data Lake Store account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  trustedIdProviders?: CreateTrustedIdProviderWithAccountParameters[];

  /**
   * The current state of the trusted identity provider feature for this Data Lake Store account.
   */
  trustedIdProviderState?: TrustedIdProviderState;

  /**
   * The commitment tier to use for next month.
   */
  newTier?: TierType;
}

/**
 * The encryption configuration for the account.
 */
model EncryptionConfig {
  /**
   * The type of encryption configuration being used. Currently the only supported types are 'UserManaged' and 'ServiceManaged'.
   */
  type: EncryptionConfigType;

  /**
   * The Key Vault information for connecting to user managed encryption keys.
   */
  keyVaultMetaInfo?: KeyVaultMetaInfo;
}

/**
 * Metadata information used by account encryption.
 */
model KeyVaultMetaInfo {
  /**
   * The resource identifier for the user managed Key Vault being used to encrypt.
   */
  keyVaultResourceId: string;

  /**
   * The name of the user managed encryption key.
   */
  encryptionKeyName: string;

  /**
   * The version of the user managed encryption key.
   */
  encryptionKeyVersion: string;
}

/**
 * The parameters used to create a new firewall rule while creating a new Data Lake Store account.
 */
model CreateFirewallRuleWithAccountParameters {
  /**
   * The unique name of the firewall rule to create.
   */
  name: string;

  /**
   * The firewall rule properties to use when creating a new firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: CreateOrUpdateFirewallRuleProperties;
}

/**
 * The firewall rule properties to use when creating a new firewall rule.
 */
model CreateOrUpdateFirewallRuleProperties {
  /**
   * The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  startIpAddress: string;

  /**
   * The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  endIpAddress: string;
}

/**
 * The parameters used to create a new virtual network rule while creating a new Data Lake Store account.
 */
model CreateVirtualNetworkRuleWithAccountParameters {
  /**
   * The unique name of the virtual network rule to create.
   */
  name: string;

  /**
   * The virtual network rule properties to use when creating a new virtual network rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: CreateOrUpdateVirtualNetworkRuleProperties;
}

/**
 * The virtual network rule properties to use when creating a new virtual network rule.
 */
model CreateOrUpdateVirtualNetworkRuleProperties {
  /**
   * The resource identifier for the subnet.
   */
  subnetId: string;
}

/**
 * The parameters used to create a new trusted identity provider while creating a new Data Lake Store account.
 */
model CreateTrustedIdProviderWithAccountParameters {
  /**
   * The unique name of the trusted identity provider to create.
   */
  name: string;

  /**
   * The trusted identity provider properties to use when creating a new trusted identity provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: CreateOrUpdateTrustedIdProviderProperties;
}

/**
 * The trusted identity provider properties to use when creating a new trusted identity provider.
 */
model CreateOrUpdateTrustedIdProviderProperties {
  /**
   * The URL of this trusted identity provider.
   */
  idProvider: string;
}

/**
 * Data Lake Store account properties information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DataLakeStoreAccountProperties
  extends DataLakeStoreAccountPropertiesBasic {
  /**
   * The default owner group for all new folders and files created in the Data Lake Store account.
   */
  @visibility(Lifecycle.Read)
  defaultGroup?: string;

  /**
   * The Key Vault encryption configuration.
   */
  @visibility(Lifecycle.Read)
  encryptionConfig?: EncryptionConfig;

  /**
   * The current state of encryption for this Data Lake Store account.
   */
  @visibility(Lifecycle.Read)
  encryptionState?: EncryptionState;

  /**
   * The current state of encryption provisioning for this Data Lake Store account.
   */
  @visibility(Lifecycle.Read)
  encryptionProvisioningState?: EncryptionProvisioningState;

  /**
   * The list of firewall rules associated with this Data Lake Store account.
   */
  @visibility(Lifecycle.Read)
  firewallRules?: FirewallRule[];

  /**
   * The list of virtual network rules associated with this Data Lake Store account.
   */
  @visibility(Lifecycle.Read)
  virtualNetworkRules?: VirtualNetworkRule[];

  /**
   * The current state of the IP address firewall for this Data Lake Store account.
   */
  @visibility(Lifecycle.Read)
  firewallState?: FirewallState;

  /**
   * The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.
   */
  @visibility(Lifecycle.Read)
  firewallAllowAzureIps?: FirewallAllowAzureIpsState;

  /**
   * The list of trusted identity providers associated with this Data Lake Store account.
   */
  @visibility(Lifecycle.Read)
  trustedIdProviders?: TrustedIdProvider[];

  /**
   * The current state of the trusted identity provider feature for this Data Lake Store account.
   */
  @visibility(Lifecycle.Read)
  trustedIdProviderState?: TrustedIdProviderState;

  /**
   * The commitment tier to use for next month.
   */
  @visibility(Lifecycle.Read)
  newTier?: TierType;

  /**
   * The commitment tier in use for the current month.
   */
  @visibility(Lifecycle.Read)
  currentTier?: TierType;
}

/**
 * The firewall rule properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model FirewallRuleProperties {
  /**
   * The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  @visibility(Lifecycle.Read)
  startIpAddress?: string;

  /**
   * The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  @visibility(Lifecycle.Read)
  endIpAddress?: string;
}

/**
 * The resource model definition for a nested resource.
 */
model SubResource {
  /**
   * The resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The virtual network rule properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model VirtualNetworkRuleProperties {
  /**
   * The resource identifier for the subnet.
   */
  @visibility(Lifecycle.Read)
  subnetId?: string;
}

/**
 * The trusted identity provider properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model TrustedIdProviderProperties {
  /**
   * The URL of this trusted identity provider.
   */
  @visibility(Lifecycle.Read)
  idProvider?: string;
}

/**
 * Data Lake Store account information to update.
 */
model UpdateDataLakeStoreAccountParameters {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The Data Lake Store account properties to update.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UpdateDataLakeStoreAccountProperties;
}

/**
 * Data Lake Store account properties information to be updated.
 */
model UpdateDataLakeStoreAccountProperties {
  /**
   * The default owner group for all new folders and files created in the Data Lake Store account.
   */
  defaultGroup?: string;

  /**
   * Used for rotation of user managed Key Vault keys. Can only be used to rotate a user managed encryption Key Vault key.
   */
  encryptionConfig?: UpdateEncryptionConfig;

  /**
   * The list of firewall rules associated with this Data Lake Store account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  firewallRules?: UpdateFirewallRuleWithAccountParameters[];

  /**
   * The list of virtual network rules associated with this Data Lake Store account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  virtualNetworkRules?: UpdateVirtualNetworkRuleWithAccountParameters[];

  /**
   * The current state of the IP address firewall for this Data Lake Store account. Disabling the firewall does not remove existing rules, they will just be ignored until the firewall is re-enabled.
   */
  firewallState?: FirewallState;

  /**
   * The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.
   */
  firewallAllowAzureIps?: FirewallAllowAzureIpsState;

  /**
   * The list of trusted identity providers associated with this Data Lake Store account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  trustedIdProviders?: UpdateTrustedIdProviderWithAccountParameters[];

  /**
   * The current state of the trusted identity provider feature for this Data Lake Store account. Disabling trusted identity provider functionality does not remove the providers, they will just be ignored until this feature is re-enabled.
   */
  trustedIdProviderState?: TrustedIdProviderState;

  /**
   * The commitment tier to use for next month.
   */
  newTier?: TierType;
}

/**
 * The encryption configuration used to update a user managed Key Vault key.
 */
model UpdateEncryptionConfig {
  /**
   * The updated Key Vault key to use in user managed key rotation.
   */
  keyVaultMetaInfo?: UpdateKeyVaultMetaInfo;
}

/**
 * The Key Vault update information used for user managed key rotation.
 */
model UpdateKeyVaultMetaInfo {
  /**
   * The version of the user managed encryption key to update through a key rotation.
   */
  encryptionKeyVersion?: string;
}

/**
 * The parameters used to update a firewall rule while updating a Data Lake Store account.
 */
model UpdateFirewallRuleWithAccountParameters {
  /**
   * The unique name of the firewall rule to update.
   */
  name: string;

  /**
   * The firewall rule properties to use when updating a firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UpdateFirewallRuleProperties;
}

/**
 * The firewall rule properties to use when updating a firewall rule.
 */
model UpdateFirewallRuleProperties {
  /**
   * The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  startIpAddress?: string;

  /**
   * The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  endIpAddress?: string;
}

/**
 * The parameters used to update a virtual network rule while updating a Data Lake Store account.
 */
model UpdateVirtualNetworkRuleWithAccountParameters {
  /**
   * The unique name of the virtual network rule to update.
   */
  name: string;

  /**
   * The virtual network rule properties to use when updating a virtual network rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UpdateVirtualNetworkRuleProperties;
}

/**
 * The virtual network rule properties to use when updating a virtual network rule.
 */
model UpdateVirtualNetworkRuleProperties {
  /**
   * The resource identifier for the subnet.
   */
  subnetId?: string;
}

/**
 * The parameters used to update a trusted identity provider while updating a Data Lake Store account.
 */
model UpdateTrustedIdProviderWithAccountParameters {
  /**
   * The unique name of the trusted identity provider to update.
   */
  name: string;

  /**
   * The trusted identity provider properties to use when updating a trusted identity provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UpdateTrustedIdProviderProperties;
}

/**
 * The trusted identity provider properties to use when updating a trusted identity provider.
 */
model UpdateTrustedIdProviderProperties {
  /**
   * The URL of this trusted identity provider.
   */
  idProvider?: string;
}

/**
 * The parameters used to create a new firewall rule.
 */
model CreateOrUpdateFirewallRuleParameters {
  /**
   * The firewall rule properties to use when creating a new firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: CreateOrUpdateFirewallRuleProperties;
}

/**
 * The parameters used to update a firewall rule.
 */
model UpdateFirewallRuleParameters {
  /**
   * The firewall rule properties to use when updating a firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UpdateFirewallRuleProperties;
}

/**
 * The parameters used to create a new virtual network rule.
 */
model CreateOrUpdateVirtualNetworkRuleParameters {
  /**
   * The virtual network rule properties to use when creating a new virtual network rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: CreateOrUpdateVirtualNetworkRuleProperties;
}

/**
 * The parameters used to update a virtual network rule.
 */
model UpdateVirtualNetworkRuleParameters {
  /**
   * The virtual network rule properties to use when updating a virtual network rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UpdateVirtualNetworkRuleProperties;
}

/**
 * The parameters used to create a new trusted identity provider.
 */
model CreateOrUpdateTrustedIdProviderParameters {
  /**
   * The trusted identity provider properties to use when creating a new trusted identity provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: CreateOrUpdateTrustedIdProviderProperties;
}

/**
 * The parameters used to update a trusted identity provider.
 */
model UpdateTrustedIdProviderParameters {
  /**
   * The trusted identity provider properties to use when updating a trusted identity provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UpdateTrustedIdProviderProperties;
}

/**
 * Subscription-level properties and limits for Data Lake Store.
 */
model CapabilityInformation {
  /**
   * The subscription credentials that uniquely identifies the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  subscriptionId?: string;

  /**
   * The subscription state.
   */
  @visibility(Lifecycle.Read)
  state?: SubscriptionState;

  /**
   * The maximum supported number of accounts under this subscription.
   */
  @visibility(Lifecycle.Read)
  maxAccountCount?: int32;

  /**
   * The current number of accounts under this subscription.
   */
  @visibility(Lifecycle.Read)
  accountCount?: int32;

  /**
   * The Boolean value of true or false to indicate the maintenance state.
   */
  @visibility(Lifecycle.Read)
  migrationState?: boolean;
}

/**
 * The response from the List Usages operation.
 */
@pagedResult
model UsageListResult {
  /**
   * Gets or sets the list of Storage Resource Usages.
   */
  @items
  value?: Usage[];
}

/**
 * Describes the Resource Usage.
 */
model Usage {
  /**
   * Gets the unit of measurement.
   */
  @visibility(Lifecycle.Read)
  unit?: UsageUnit;

  /**
   * Resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Gets the current count of the allocated resources in the subscription.
   */
  @visibility(Lifecycle.Read)
  currentValue?: int32;

  /**
   * Gets the maximum count of the resources that can be allocated in the subscription.
   */
  @visibility(Lifecycle.Read)
  limit?: int32;

  /**
   * Gets the name of the type of usage.
   */
  @visibility(Lifecycle.Read)
  name?: UsageName;
}

/**
 * The usage names that can be used.
 */
model UsageName {
  /**
   * Gets a string describing the resource name.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * Gets a localized string describing the resource name.
   */
  @visibility(Lifecycle.Read)
  localizedValue?: string;
}

/**
 * Data Lake Store account name availability check parameters.
 */
model CheckNameAvailabilityParameters {
  /**
   * The Data Lake Store name to check availability for.
   */
  name: string;

  /**
   * The resource type. Note: This should not be set by the user, as the constant value is Microsoft.DataLakeStore/accounts
   */
  type: CheckNameAvailabilityParametersType;
}

/**
 * Data Lake Store account name availability result information.
 */
model NameAvailabilityInformation {
  /**
   * The Boolean value of true or false to indicate whether the Data Lake Store account name is available or not.
   */
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * The reason why the Data Lake Store account name is not available, if nameAvailable is false.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * The message describing why the Data Lake Store account name is not available, if nameAvailable is false.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}
