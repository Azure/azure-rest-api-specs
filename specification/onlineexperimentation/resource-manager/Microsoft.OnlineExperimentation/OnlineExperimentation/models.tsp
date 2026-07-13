import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.OnlineExperimentation;

alias AppConfigurationArmResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.AppConfiguration/configurationStores";
  }
]>;
alias LogAnalyticsWorkspaceArmResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.OperationalInsights/workspaces";
  }
]>;
alias StorageAccountArmResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Storage/storageAccounts";
  }
]>;

/**
 * The properties of an online experimentation workspace.
 */
model OnlineExperimentationWorkspaceProperties {
  /** The Id of the workspace. */
  @visibility(Lifecycle.Read)
  workspaceId?: string;

  /**
   * The provisioning state for the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The resource identifier of the Log Analytics workspace which online experimentation workspace uses for generating experiment analysis results.
   */
  logAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceArmResourceId;

  /**
   * The resource identifier of storage account where logs are exported from Log Analytics workspace. online experimentation workspace uses it generating experiment analysis results.
   */
  logsExporterStorageAccountResourceId: StorageAccountArmResourceId;

  /**
   * The resource identifier of App Configuration with which this online experimentation workspace is tied for experimentation. This is a required field for creating an online experimentation workspace.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  appConfigurationResourceId: AppConfigurationArmResourceId;

  /**
   * The encryption configuration for the online experimentation workspace resource.
   */
  encryption?: ResourceEncryptionConfiguration;

  /**
   * The data plane endpoint for the online experimentation workspace resource.
   */
  @visibility(Lifecycle.Read)
  endpoint?: url;

  /**
   * Public Network Access Control for the online experimentation resource. Defaults to Enabled if not set.
   * - Enabled: The resource can be accessed from the public internet.
   * - Disabled: The resource can only be accessed from a private endpoint.
   */
  @added(Microsoft.OnlineExperimentation.Versions.v2025_08_01_preview)
  publicNetworkAccess?: PublicNetworkAccessType;

  /**
   * The private endpoint connections associated with the online experimentation workspace resource.
   */
  @added(Microsoft.OnlineExperimentation.Versions.v2025_08_01_preview)
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];
}

/**
 * The public network access type for an online experimentation resource.
 */
@added(Microsoft.OnlineExperimentation.Versions.v2025_08_01_preview)
union PublicNetworkAccessType {
  /** Enabled: The resource can be accessed from the public internet */
  Enabled: "Enabled",

  /** Disabled: The resource can only be accessed from a private endpoint. */
  Disabled: "Disabled",

  string,
}

/**
 * The encryption configuration for the online experimentation workspace resource.
 */
model ResourceEncryptionConfiguration {
  /** All Customer-managed key encryption properties for the resource. */
  customerManagedKeyEncryption?: CustomerManagedKeyEncryption;
}

/** Customer-managed key encryption properties for the resource. */
model CustomerManagedKeyEncryption {
  /** All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault. */
  keyEncryptionKeyIdentity?: KeyEncryptionKeyIdentity;

  /** key encryption key Url, versioned or non-versioned. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78 or https://contosovault.vault.azure.net/keys/contosokek. */
  keyEncryptionKeyUrl?: url;
}

/** All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault. */
model KeyEncryptionKeyIdentity {
  /** The type of identity to use. Values can be systemAssignedIdentity, userAssignedIdentity, or delegatedResourceIdentity. */
  identityType?: KeyEncryptionKeyIdentityType;

  /** User assigned identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId. Mutually exclusive with identityType systemAssignedIdentity. */
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier;

  /** application client identity to use for accessing key encryption key Url in a different tenant. Ex: f83c6b1b-4d34-47e4-bb34-9d83df58b540 */
  federatedClientId?: uuid;
}

/** The type of identity to use. */
union KeyEncryptionKeyIdentityType {
  /** System assigned identity */
  SystemAssignedIdentity: "SystemAssignedIdentity",

  /** User assigned identity */
  UserAssignedIdentity: "UserAssignedIdentity",

  string,
}

/**
 * The SKU (Stock Keeping Unit) assigned to this resource.
 */
model OnlineExperimentationWorkspaceSku {
  /** The name of the SKU. Ex - F0, P0. It is typically a letter+number code */
  name: OnlineExperimentationWorkspaceSkuName;

  /** The name of the SKU tier */
  @visibility(Lifecycle.Read)
  tier?: OnlineExperimentationWorkspaceSkuTier;
}

/**
 * The allowed SKU tiers for the online experimentation workspace.
 */
union OnlineExperimentationWorkspaceSkuTier {
  /** The Free service tier. */
  Free: "Free",

  /** The Standard service tier. */
  Standard: "Standard",

  /** The Premium service tier. */
  Premium: "Premium",

  /** The Developer service tier. */
  Developer: "Developer",

  string,
}

/**
 * The allowed SKU names for the online experimentation workspace.
 */
union OnlineExperimentationWorkspaceSkuName {
  /** The Free service sku name. */
  F0: "F0",

  /** The Standard service sku name. */
  S0: "S0",

  /** The Premium service sku name. */
  P0: "P0",

  /** The Developer service sku name. */
  D0: "D0",

  string,
}
