import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

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
  keyEncryptionKeyUrl?: string;
}

/** All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault. */
model KeyEncryptionKeyIdentity {
  /** The type of identity to use. Values can be systemAssignedIdentity, userAssignedIdentity, or delegatedResourceIdentity. */
  identityType?: KeyEncryptionKeyIdentityType;

  /** User assigned identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId. Mutually exclusive with identityType systemAssignedIdentity. */
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier;

  /** application client identity to use for accessing key encryption key Url in a different tenant. Ex: f83c6b1b-4d34-47e4-bb34-9d83df58b540 */
  federatedClientId?: uuid;

  /** delegated identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId. Mutually exclusive with identityType systemAssignedIdentity and userAssignedIdentity - internal use only. */
  delegatedIdentityClientId?: uuid;
}

/** The type of identity to use. */
union KeyEncryptionKeyIdentityType {
  /** System assigned identity */
  SystemAssignedIdentity: "systemAssignedIdentity",

  /** User assigned identity */
  UserAssignedIdentity: "userAssignedIdentity",

  /** Delegated identity */
  DelegatedResourceIdentity: "delegatedResourceIdentity",

  string,
}
