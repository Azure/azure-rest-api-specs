import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./versions.tsp";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.StorageDiscovery;

/**
 * Storage Discovery Workspace Properties
 */
model StorageDiscoveryWorkspaceProperties {
  @doc("The storage discovery sku")
  sku?: StorageDiscoverySku = StorageDiscoverySku.Standard;

  @doc("The description of the storage discovery workspace")
  description?: string;

  @doc("The capabilities configured for the storage discovery workspace.")
  @added(ApiVersion.v2026_10_01_preview)
  capabilities?: StorageDiscoveryCapabilities;

  @doc("The view level storage discovery data estate")
  workspaceRoots: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
      scopes: ["Tenant", "Subscription", "ResourceGroup"];
    }
  ]>[];

  @doc("The scopes of the storage discovery workspace.")
  @identifiers(#["displayName"])
  scopes: StorageDiscoveryScope[];

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;
}

/**
 * Storage Discovery Sku
 */
union StorageDiscoverySku {
  @doc("Standard Sku")
  Standard: "Standard",

  @doc("Free Sku")
  Free: "Free",

  string,
}

model StorageDiscoveryWorkspacePropertiesUpdate
  is UpdateableProperties<OptionalProperties<OmitDefaults<StorageDiscoveryWorkspaceProperties>>>;

model StorageDiscoveryWorkspaceUpdate
  is UpdateableProperties<OptionalProperties<OmitDefaults<OmitProperties<
    StorageDiscoveryWorkspace,
    "properties" | "name"
  >>>> {
  /** The resource-specific properties for this resource. */
  properties?: StorageDiscoveryWorkspacePropertiesUpdate;
}

/**
 * Storage Discovery Scope. This had added validations
 */
model StorageDiscoveryScope {
  @doc("Display name of the collection")
  @pattern("^[a-zA-Z0-9]+([ -][a-zA-Z0-9]+)*$")
  @minLength(4)
  @maxLength(64)
  displayName: string;

  @doc("Resource types for the collection")
  resourceTypes: StorageDiscoveryResourceType[];

  @doc("The storage account tags keys to filter")
  tagKeysOnly?: string[];

  ...ArmTagsProperty;
}

/**
 * The capabilities configured for a storage discovery workspace.
 */
@added(ApiVersion.v2026_10_01_preview)
model StorageDiscoveryCapabilities {
  @doc("The Azure Blob Storage capability configuration for the storage discovery workspace.")
  azureBlobStorage: AzureBlobStorageCapability;
}

/**
 * The Azure Blob Storage capability configuration.
 */
@added(ApiVersion.v2026_10_01_preview)
model AzureBlobStorageCapability {
  @doc("The capacity details configuration for Azure Blob Storage.")
  capacityDetails: CapacityDetails;

  @doc("The prefix definitions that scope the capacity details to specific storage accounts, containers, and prefixes.")
  @identifiers(#[])
  prefixDefinitions?: PrefixDefinition[];
}

/**
 * The capacity details configuration.
 */
@added(ApiVersion.v2026_10_01_preview)
model CapacityDetails {
  @doc("The enablement status of the capacity details capability.")
  status: CapabilityStatus;
}

/**
 * The enablement status of a storage discovery capability.
 */
@added(ApiVersion.v2026_10_01_preview)
union CapabilityStatus {
  @doc("The capability is enabled.")
  Enabled: "Enabled",

  @doc("The capability is disabled.")
  Disabled: "Disabled",

  string,
}

/**
 * A prefix definition that scopes capacity details to a specific storage account, container, and prefix.
 */
@added(ApiVersion.v2026_10_01_preview)
model PrefixDefinition {
  @doc("The name of the storage account.")
  @minLength(3)
  @maxLength(24)
  @pattern("^[a-z0-9]{3,24}$")
  storageAccountName: string;

  @doc("The name of the blob container within the storage account.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-z0-9]([a-z0-9]|(-(?!-))){1,61}[a-z0-9]$")
  containerName: string;

  @doc("The blob prefix within the container to scope capacity details to. An empty value scopes to the entire container. Must not start with a '/'.")
  @maxLength(1024)
  @pattern("^([^/].*)?$")
  prefix: string;
}

/**
 * Storage Discovery Resource Type
 */
union StorageDiscoveryResourceType {
  @doc("Storage Account Resource Type")
  StorageAccounts: "Microsoft.Storage/storageAccounts",

  string,
}

@armResourceOperations
interface StorageDiscoveryWorkspaces {
  get is ArmResourceRead<StorageDiscoveryWorkspace>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageDiscoveryWorkspace>;

  @sharedRoute
  update is ArmCustomPatchSync<
    StorageDiscoveryWorkspace,
    StorageDiscoveryWorkspaceUpdate
  >;

  delete is ArmResourceDeleteSync<StorageDiscoveryWorkspace>;
  listByResourceGroup is ArmResourceListByParent<StorageDiscoveryWorkspace>;
  listBySubscription is ArmListBySubscription<StorageDiscoveryWorkspace>;

  @doc("A long-running resource action.")
  @autoRoute
  @post
  report is ArmResourceActionAsync<
    StorageDiscoveryWorkspace,
    GetReportContent,
    GetReportResult
  >;
}

interface Operations extends Azure.ResourceManager.Operations {}
