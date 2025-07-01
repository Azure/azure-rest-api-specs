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
  @doc("The storage discovery sku.")
  @renamedFrom(ApiVersion.v2025_03_01_preview, "tier")
  @renamedFrom(ApiVersion.v2025_06_01_preview, "sku")
  @removed(ApiVersion.v2025_06_01_preview)
  oldsku: StorageDiscoverySku;

  @doc("The storage discovery sku")
  @added(ApiVersion.v2025_06_01_preview)
  sku?: StorageDiscoverySku = StorageDiscoverySku.Standard;

  @doc("The state of storage discovery workspace")
  @added(ApiVersion.v2025_03_01_preview)
  @removed(ApiVersion.v2025_06_01_preview)
  workspaceState: WorkspaceState;

  @doc("The state of storage discovery data export")
  @madeOptional(ApiVersion.v2025_03_01_preview)
  @removed(ApiVersion.v2025_06_01_preview)
  exportState?: DataExportState;

  @doc("The description of the storage discovery workspace")
  description?: string;

  @doc("The view level storage discovery data estate")
  @added(ApiVersion.v2025_01_01_preview)
  @renamedFrom(ApiVersion.v2025_03_01_preview, "storageEstateViewLevel")
  @removed(ApiVersion.v2025_06_01_preview)
  @typeChangedFrom(
    ApiVersion.v2025_03_01_preview,
    Azure.Core.armResourceIdentifier
  )
  discoveryScopeLevels: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
      scopes: ["Tenant", "Subscription", "ResourceGroup"];
    }
  ]>[];

  @doc("The view level storage discovery data estate")
  @added(ApiVersion.v2025_06_01_preview)
  workspaceRoots: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
      scopes: ["Tenant", "Subscription", "ResourceGroup"];
    }
  ]>[];

  @doc("The scope of the storage discovery workspace.")
  @identifiers(#["displayName"])
  @removed(ApiVersion.v2025_01_01_preview)
  @renamedFrom(ApiVersion.v2025_06_01_preview, "scopes")
  oldScopes: StorageDiscoveryScopeV1[];

  @doc("The storage discovery resource collections.")
  @identifiers(#["displayName"])
  @added(ApiVersion.v2025_01_01_preview)
  @renamedFrom(ApiVersion.v2025_03_01_preview, "storageCollections")
  @renamedFrom(ApiVersion.v2025_06_01_preview, "discoveryScopes")
  scopes: StorageDiscoveryScope[];

  @doc("The destinations to which the storage workspace sends data")
  @removed(ApiVersion.v2025_01_01_preview)
  @added(ApiVersion.v2025_03_01_preview)
  @madeOptional(ApiVersion.v2025_03_01_preview)
  @removed(ApiVersion.v2025_06_01_preview)
  destinations?: StorageDiscoveryDestination;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;
}

/**
 * The state of storage discovery workspace
 */
@added(ApiVersion.v2025_03_01_preview)
@removed(ApiVersion.v2025_06_01_preview)
union WorkspaceState {
  @doc("Workspace is Enabled")
  Enabled: "Enabled",

  @doc("Workspace is Disabled")
  Disabled: "Disabled",

  string,
}

/**
 * The state of storage discovery data export
 */
@removed(ApiVersion.v2025_06_01_preview)
union DataExportState {
  @doc("Data export is stopped.")
  Stopped: "Stopped",

  @doc("Data export is running continuously")
  Running: "Running",

  string,
}

/**
 * Storage Discovery Sku
 */
@renamedFrom(ApiVersion.v2025_03_01_preview, "StorageDiscoveryTier")
union StorageDiscoverySku {
  @doc("Basic Sku")
  @removed(ApiVersion.v2025_03_01_preview)
  Basic: "Basic",

  @doc("Free Sku")
  @added(ApiVersion.v2025_03_01_preview)
  Free: "Free",

  @doc("Standard Sku")
  Standard: "Standard",

  @doc("Premium Sku")
  Premium: "Premium",

  string,
}

/**
 * Storage Discovery Scope
 */
@removed(ApiVersion.v2025_01_01_preview)
@renamedFrom(ApiVersion.v2025_03_01_preview, "StorageDiscoveryScope")
model StorageDiscoveryScopeV1 {
  @doc("Display name of the scope")
  @pattern("^[a-zA-Z][a-zA-Z0-9]*(-[a-zA-Z0-9]+)*$")
  @minLength(4)
  @maxLength(64)
  displayName: string;

  @doc("Resource types for the scope")
  resourceTypes: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>[];

  @doc("ARM scope URIs for the scope")
  armScopes: string[];

  @doc("Storage resource filters for the scope")
  storageAccountFilters: StorageDiscoveryResourceFilter;
}

/**
 * Storage resource filters for the scope
 */
@removed(ApiVersion.v2025_01_01_preview)
model StorageDiscoveryResourceFilter {
  @doc("The storage account locations to filter")
  locations: string[];

  ...ArmTagsProperty;
}

/**
 * Storage Discovery Collection
 */
@added(ApiVersion.v2025_01_01_preview)
@renamedFrom(ApiVersion.v2025_03_01_preview, "StorageDiscoveryCollection")
model StorageDiscoveryScope {
  @doc("Display name of the collection")
  @pattern("^[a-zA-Z][a-zA-Z0-9]*(-[a-zA-Z0-9]+)*$")
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
 * Storage Discovery Resource Type
 */
@added(ApiVersion.v2025_01_01_preview)
union StorageDiscoveryResourceType {
  @doc("Storage Account Resource Type")
  StorageAccounts: "Microsoft.Storage/storageAccounts",

  string,
}

/**
 * Destinations for storage discovery data
 */
@removed(ApiVersion.v2025_01_01_preview)
@added(ApiVersion.v2025_03_01_preview)
@removed(ApiVersion.v2025_06_01_preview)
model StorageDiscoveryDestination {
  @doc("The ADX destination sink for analytics data")
  @renamedFrom(ApiVersion.v2025_03_01_preview, "storageAccountArmId")
  storageAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;
}

@armResourceOperations
interface StorageDiscoveryWorkspaces {
  get is ArmResourceRead<StorageDiscoveryWorkspace>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageDiscoveryWorkspace>;
  update is ArmResourcePatchSync<
    StorageDiscoveryWorkspace,
    StorageDiscoveryWorkspaceProperties
  >;
  delete is ArmResourceDeleteSync<StorageDiscoveryWorkspace>;
  listByResourceGroup is ArmResourceListByParent<StorageDiscoveryWorkspace>;
  listBySubscription is ArmListBySubscription<StorageDiscoveryWorkspace>;

  @autoRoute
  @post
  @added(ApiVersion.v2025_04_01_preview)
  report is ArmResourceActionAsync<
    StorageDiscoveryWorkspace,
    GetReportContent,
    GetReportResult
  >;
}

interface Operations extends Azure.ResourceManager.Operations {}
