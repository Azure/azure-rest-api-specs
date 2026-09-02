import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.PowerPlatform;

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * The Kind (type) of Enterprise Policy
 */
union EnterprisePolicyKind {
  string,

  /**
   * Lockbox
   */
  Lockbox: "Lockbox",

  /**
   * PrivateEndpoint
   */
  PrivateEndpoint: "PrivateEndpoint",

  /**
   * Encryption
   */
  Encryption: "Encryption",

  /**
   * NetworkInjection
   */
  NetworkInjection: "NetworkInjection",

  /**
   * Identity
   */
  Identity: "Identity",
}

/**
 * The state of onboarding, which only appears in the response.
 */
union State {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * NotConfigured
   */
  NotConfigured: "NotConfigured",
}

/**
 * The health status of the resource.
 */
union HealthStatus {
  string,

  /**
   * Undetermined
   */
  Undetermined: "Undetermined",

  /**
   * Healthy
   */
  Healthy: "Healthy",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Unhealthy
   */
  Unhealthy: "Unhealthy",
}

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * system
   */
  system: "system",

  /**
   * user,system
   */
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,

  /**
   * Internal
   */
  Internal: "Internal",
}

/**
 * The type of identity used for the EnterprisePolicy. Currently, the only supported type is 'SystemAssigned', which implicitly creates an identity.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceIdentityType {
  /**
   * SystemAssigned
   */
  SystemAssigned,

  /**
   * None
   */
  None,
}

/**
 * The properties that define configuration for the account.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AccountProperties {
  /**
   * The internally assigned unique identifier of the resource.
   */
  @visibility(Lifecycle.Read)
  systemId?: string;

  /**
   * The description of the account.
   */
  description?: string;
}

/**
 * Definition of the account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PatchAccount extends PatchTrackedResource {
  /**
   * The properties that define configuration for the account.
   */
  properties?: AccountProperties;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * The resource model definition for an Azure Resource Manager tracked top level resource which has 'tags' and a 'location'
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PatchTrackedResource extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

/**
 * The response of the list accounts operation.
 */
model AccountList {
  /**
   * The collection value.
   */
  @pageItems
  value?: Account[];

  /**
   * The next page link.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The identity of the EnterprisePolicy.
 */
model EnterprisePolicyIdentity {
  /**
   * The principal id of EnterprisePolicy identity.
   */
  @visibility(Lifecycle.Read)
  systemAssignedIdentityPrincipalId?: string;

  /**
   * The tenant id associated with the EnterprisePolicy.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the EnterprisePolicy. Currently, the only supported type is 'SystemAssigned', which implicitly creates an identity.
   */
  type?: ResourceIdentityType;
}

/**
 * The properties that define configuration for the enterprise policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Properties {
  /**
   * The internally assigned unique identifier of the resource.
   */
  @visibility(Lifecycle.Read)
  systemId?: string;

  /**
   * Settings concerning lockbox.
   */
  lockbox?: PropertiesLockbox;

  /**
   * The encryption settings for a configuration store.
   */
  encryption?: PropertiesEncryption;

  /**
   * Settings concerning network injection.
   */
  networkInjection?: PropertiesNetworkInjection;

  /**
   * The health status of the resource.
   */
  healthStatus?: HealthStatus;
}

/**
 * Settings concerning lockbox.
 */
model PropertiesLockbox {
  /**
   * lockbox configuration
   */
  state?: State;
}

/**
 * The encryption settings for a configuration store.
 */
model PropertiesEncryption {
  /**
   * Key vault properties.
   */
  keyVault?: KeyVaultProperties;

  /**
   * The state of onboarding, which only appears in the response.
   */
  state?: State;
}

/**
 * Settings concerning key vault encryption for a configuration store.
 */
model KeyVaultProperties {
  /**
   * Uri of KeyVault
   */
  id?: string;

  /**
   * Identity of the secret that includes name and version.
   */
  key?: keyProperties;
}

/**
 * Url and version of the KeyVault Secret
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model keyProperties {
  /**
   * The identifier of the key vault key used to encrypt data.
   */
  name?: string;

  /**
   * The version of the identity which will be used to access key vault.
   */
  version?: string;
}

/**
 * Settings concerning network injection.
 */
model PropertiesNetworkInjection {
  /**
   * Network injection configuration
   */
  virtualNetworks?: VirtualNetworkProperties[];
}

/**
 * Settings concerning the virtual network.
 */
model VirtualNetworkProperties {
  /**
   * Uri of the virtual network.
   */
  id?: string;

  /**
   * Properties of a subnet.
   */
  subnet?: SubnetProperties;
}

/**
 * Properties of a subnet.
 */
model SubnetProperties {
  /**
   * Subnet name.
   */
  name?: string;
}

/**
 * Definition of the EnterprisePolicy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PatchEnterprisePolicy extends PatchTrackedResource {
  /**
   * The identity of the EnterprisePolicy.
   */
  identity?: EnterprisePolicyIdentity;

  /**
   * The kind (type) of Enterprise Policy.
   */
  kind?: EnterprisePolicyKind;

  /**
   * The properties that define configuration for the enterprise policy
   */
  properties?: Properties;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * The response of the list EnterprisePolicy operation.
 */
model EnterprisePolicyList {
  /**
   * The collection value.
   */
  @pageItems
  value?: EnterprisePolicy[];

  /**
   * The next page link.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * A list of private endpoint connections
 */
model PrivateEndpointConnectionListResult {
  /**
   * Array of private endpoint connections
   */
  @pageItems
  value?: PrivateEndpointConnection[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}
