import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.OnlineExperimentation;

/**
 * The properties of an online experiment workspace.
 */
model OnlineExperimentWorkspaceProperties {
  /** The Id of the workspace. */
  @visibility(Lifecycle.Read)
  workspaceId?: string;

  /**
   * The provisioning state for the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The resource identifier of the Log Analytics workspace which online experiment workspace uses for generating experiment analysis results.
   */
  logAnalyticsWorkspaceResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * The resource identifier of storage account where logs are exported from Log Analytics workspace. Online Experiment workspace uses it generating experiment analysis results.
   */
  logsExporterStorageAccountResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * The resource identifier of App Configuration with which this online experiment workspace is tied for experimentation. This is a required field for creating an online experiment workspace.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  appConfigurationResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AppConfiguration/configurationStores";
    }
  ]>;

  /**
   * The encryption configuration for the online experiment workspace resource.
   */
  encryption?: ResourceEncryptionConfiguration;

  /**
   * The data plane endpoint for the online experiment workspace resource.
   */
  @visibility(Lifecycle.Read)
  endpoint?: url;
}

/**
 * The encryption configuration for the online experiment workspace resource.
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
