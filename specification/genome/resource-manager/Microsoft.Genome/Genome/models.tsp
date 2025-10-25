import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Genome;

/** SKU tier of a resource. */
union SkuTier {
  string,

  /** Free tier */
  Free: "Free",

  /** Basic tier */
  Basic: "Basic",

  /** Standard tier */
  Standard: "Standard",

  /** Premium tier */
  Premium: "Premium",

  /** Enterprise tier */
  Enterprise: "Enterprise",
}

/** The resource model definition representing SKU */
model Sku {
  /** The name of the SKU. Ex - P3. It is typically a letter+number code */
  name: string;

  /** This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT. */
  tier?: SkuTier;

  /** The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code. */
  size?: string;

  /** If the service has different generations of hardware, for the same SKU, then that can be captured here. */
  family?: string;

  /** If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted. */
  capacity?: int32;
}

/** The identity type. */
union ResourceIdentityType {
  string,

  /** No managed identity is assigned to the resource */
  None: "None",

  /** System-assigned managed identity */
  SystemAssigned: "SystemAssigned",

  /** User-assigned managed identity */
  UserAssigned: "UserAssigned",

  /** Both system-assigned and user-assigned managed identities */
  `SystemAssigned, UserAssigned`: "SystemAssigned, UserAssigned",
}

/** User-assigned managed identity. */
model UserAssignedIdentity {
  /** Azure Active Directory principal ID associated with this Identity. */
  principalId?: string;

  /** Client App Id associated with this identity. */
  clientId?: string;
}

/** Identity for the resource. */
model Identity {
  /** The identity type. */
  type?: ResourceIdentityType;

  /** The tenant ID of resource. */
  tenantId?: string;

  /** The principal ID of resource identity. */
  principalId?: string;

  /** The list of user assigned identities associated with the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Standard ARM pattern"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/** The provisioning state of the genome account. */
union ProvisioningState {
  string,

  /** Resource is being provisioned */
  Provisioning: "Provisioning",

  /** Resource is active and ready for use */
  Active: "Active",

  /** Resource is being updated */
  Updating: "Updating",

  /** Resource has been suspended */
  Suspended: "Suspended",

  /** Resource is being deleted */
  Deleting: "Deleting",

  /** Operation completed successfully */
  Succeeded: "Succeeded",

  /** Operation failed to complete */
  Failed: "Failed",

  /** Operation was canceled */
  Canceled: "Canceled",
}

/** Network rule action type. */
union NetworkRuleAction {
  string,

  /** Allow network access */
  Allow: "Allow",

  /** Deny network access */
  Deny: "Deny",
}

/** Virtual network service endpoint behavior. */
union VnetServiceEndpointBehavior {
  string,

  /** Ignore missing virtual network service endpoint */
  Ignore: "Ignore",

  /** Require virtual network service endpoint to be present */
  Require: "Require",
}

/** IP rule for network access control. */
model IpRule {
  /** An IPv4 address range in CIDR notation. */
  value: string;
}

/** Virtual network rule for network access control. */
model VirtualNetworkRule {
  /** Full resource id of a vnet subnet. */
  id: string;

  /** Gets the state of virtual network rule. */
  state?: string;

  /** Virtual network service endpoint behavior. */
  vnetServiceEndpointBehavior?: VnetServiceEndpointBehavior;
}

/** Network access control rules. */
model NetworkRuleSet {
  /** The default action when no rule matches. */
  defaultAction?: NetworkRuleAction;

  /** The list of IP address rules. */
  @OpenAPI.extension("x-ms-identifiers", #["value"])
  ipRules?: IpRule[];

  /** The list of virtual network rules. */
  virtualNetworkRules?: VirtualNetworkRule[];
}

/** Key source for encryption. */
union KeySource {
  string,

  /** Encryption managed by the Genome service */
  MicrosoftGenome: "Microsoft.Genome",

  /** Encryption managed by Azure Key Vault */
  MicrosoftKeyVault: "Microsoft.KeyVault",
}

/** Key Vault properties for encryption. */
model KeyVaultProperties {
  /** Name of the Key from KeyVault */
  keyName?: string;

  /** Version of the Key from KeyVault */
  keyVersion?: string;

  /** Uri of KeyVault */
  keyVaultUri?: string;

  /** Identity client ID */
  identityClientId?: string;
}

/** Encryption configuration. */
model Encryption {
  /** Properties of KeyVault */
  keyVaultProperties?: KeyVaultProperties;

  /** Key source for encryption */
  keySource?: KeySource;
}

/** Properties of Genome account. */
model GenomeAccountProperties {
  /** The provisioning state of the account. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Endpoint of the created account. */
  @visibility(Lifecycle.Read)
  endpoint?: string;

  /** The name of the deployment environment (e.g., dev, test, ppe, prod) where the genome account resource is provisioned. */
  environmentName?: string;

  /** Network access control rules. */
  networkAcls?: NetworkRuleSet;

  /** Encryption properties for this resource. */
  encryption?: Encryption;
}
