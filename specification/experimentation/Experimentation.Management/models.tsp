import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Experimentation;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The provisioning state of the remote variant assignment service endpoint.
 */
union RemoteVariantAssignmentProvisioningState {
  /**
   * The provisioning state is Succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The provisioning state is Failed.
   */
  Failed: "Failed",

  /**
   * The provisioning state is Running.
   */
  Accepted: "Accepted",

  /**
   * The provisioning state is Running.
   */
  Canceled: "Canceled",

  string,
}

/**
 * The type of managed identity for the workspace
 */
union ResourceIdentityType {
  /**
   * No managed identity
   */
  None: "None",

  /**
   * User assigned managed identity
   */
  UserAssigned: "UserAssigned",

  string,
}

/**
 * An experiment workspace properties.
 */
model ExperimentWorkspaceProperties {
  /**
   * The id for experiment workspace
   */
  @visibility("read")
  expWorkspaceId?: string;

  /**
   * The provisioning state for the resource
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  /**
   * The variant assignment configuration will be published to a storage account linked here. This involves using the Variant Assignment SDK. Using this assignment method, your service will pull the assignment blob from storage account registered in the workspace.
   */
  variantAssignmentConfigPublishing?: VariantAssignmentConfigPublishing;

  /**
   * The remote variant assignment, your service will do a network call to an assignment endpoint and retrieve the variants assigned. This option is recommended for testing with less than 100 RPS.
   */
  remoteVariantAssignment?: RemoteVariantAssignment;

  /**
   * The resource identifier of the Log Analytics workspace which experiment workspace uses for generating experiment analysis results.
   */
  logAnalyticsResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * The resource identifier of storage account where logs are exported from Log Analytics workspace. Experiment workspace uses it generating experiment analysis results.
   */
  logsExporterStorageAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;
}

/**
 * The variant assignment configuration will be published to a storage account linked here. This involves using the Variant Assignment SDK. Using this assignment method, your service will pull the assignment blob from storage account registered in the workspace.
 */
model VariantAssignmentConfigPublishing {
  /**
   * Indicates whether variant assignment publishing model is enabled or not.
   */
  enabled?: boolean;

  /**
   * The resource identifier of storage account where blob should be delivered. Blob would be delivered to exp-blobs storage container in the storage account.
   */
  storageAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * User assigned identity to use for accessing storage account. This identity should have access to storage account specified in storageAccountResourceId. If not specified, defaults to first alphabetically sorted user assigned identity assigned to the workspace.
   */
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

/**
 * The remote variant assignment, your service will do a network call to an assignment endpoint and retrieve the variants assigned. This option is recommended for testing with less than 100 RPS.
 */
model RemoteVariantAssignment {
  /**
   * Indicates whether the remote variant assignment is enabled or not. Provisioning a remote variant assignment endpoint is an asynchronous operation and can take up to 20 minutes.
   */
  enabled?: boolean;

  /**
   * The endpoint where your service will make a network call to retrieve the variants assigned.
   */
  @visibility("read")
  endpoint?: string;

  /**
   * The provisioning state of the remote variant assignment service endpoint.
   */
  @visibility("read")
  provisioningState?: RemoteVariantAssignmentProvisioningState;
}

/**
 * The workspace managed identity
 */
model ManagedIdentity {
  /** The type of managed identity assigned to this resource. */
  type: ResourceIdentityType;

  /** The identities assigned to this resource by the user. */
  #suppress "deprecated" "We are in private preview and not planning to use client SDKs generated from TypeSpec. For public preview, we will support system assigned and that should fix this warning"
  userAssignedIdentities?: UserAssignedIdentities;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * An experiment workspace properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Patching on sku will be supported once we support other tiers."
model ExperimentWorkspacePatch {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The identity of the workspace
   */
  identity?: ManagedIdentity;
}

/**
 * The experiment workspace model definition representing SKU
 */
model ExperimentWorkspaceSku {
  /** The name of the SKU. Ex - F0, P0. It is typically a letter+number code */
  name: ExperimentWorkspaceSkuName;

  /** The name of the SKU tier */
  @visibility("read")
  tier?: ExperimentWorkspaceSkuTier;
}

/**
 * The experiment workspace model SKU tier.
 */
union ExperimentWorkspaceSkuTier {
  /** The Free service tier. */
  Free: "Free",

  /** The Standard service tier. */
  Standard: "Standard",

  string,
}

/**
 * The experiment workspace model SKU name.
 */
union ExperimentWorkspaceSkuName {
  /** The Free service sku name. */
  F0: "F0",

  /** The Standard service sku name. */
  S0: "S0",

  string,
}

/**
 * The experiment workspace model Kind.
 */
union ExperimentWorkspaceKind {
  /** The Regular Kind */
  Regular: "Regular",

  /** The Advanced Kind generally available with Standard SKU */
  Advanced: "Advanced",

  string,
}
