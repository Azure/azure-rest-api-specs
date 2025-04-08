import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

// The Azure Storage Management API.
@armProviderNamespace
@service(#{ title: "StorageDiscoveryClient" })
@versioned(ApiVersion)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.StorageDiscovery;

@doc("A Storage Discovery Workspace resource. This resource configures the collection of storage account metrics.")
model StorageDiscoveryWorkspace
  is Azure.ResourceManager.TrackedResource<StorageDiscoveryWorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = StorageDiscoveryWorkspace,
    KeyName = "storageDiscoveryWorkspaceName",
    SegmentName = "storageDiscoveryWorkspaces",
    NamePattern = "^[a-z0-9]{3,18}$"
  >;
}

@doc("Storage Discovery Workspace Properties")
model StorageDiscoveryWorkspaceProperties {
  @doc("The storage discovery sku.")
  @renamedFrom(ApiVersion.v2025_03_01_preview, "tier")
  sku: StorageDiscoverySku;

  @doc("The state of storage discovery workspace")
  @added(ApiVersion.v2025_03_01_preview)
  workspaceState: WorkspaceState;

  @doc("The state of storage discovery data export")
  @madeOptional(ApiVersion.v2025_03_01_preview)
  exportState?: DataExportState;

  @doc("The description of the storage discovery workspace")
  description?: string;

  @doc("The view level storage discovery data estate")
  @added(ApiVersion.v2025_01_01_preview)
  @renamedFrom(ApiVersion.v2025_03_01_preview, "storageEstateViewLevel")
  @typeChangedFrom(
    ApiVersion.v2025_03_01_preview,
    Azure.Core.armResourceIdentifier
  )
  discoveryScopeLevels: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
      scopes: ["tenant", "subscription", "resourceGroup"];
    }
  ]>[];

  @doc("The scope of the storage discovery workspace.")
  @identifiers(#["displayName"])
  @removed(ApiVersion.v2025_01_01_preview)
  scopes: StorageDiscoveryScopeV1[];

  @doc("The storage discovery resource collections.")
  @identifiers(#["displayName"])
  @added(ApiVersion.v2025_01_01_preview)
  @renamedFrom(ApiVersion.v2025_03_01_preview, "storageCollections")
  discoveryScopes: StorageDiscoveryScope[];

  @doc("The destinations to which the storage workspace sends data")
  @removed(ApiVersion.v2025_01_01_preview)
  @added(ApiVersion.v2025_03_01_preview)
  @madeOptional(ApiVersion.v2025_03_01_preview)
  destinations?: StorageDiscoveryDestination;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;
}

@doc("The state of storage discovery workspace")
@added(ApiVersion.v2025_03_01_preview)
union WorkspaceState {
  @doc("Workspace is Enabled")
  Enabled: "Enabled",

  @doc("Workspace is Disabled")
  Disabled: "Disabled",

  string,
}

@doc("The state of storage discovery data export")
union DataExportState {
  @doc("Data export is stopped.")
  Stopped: "Stopped",

  @doc("Data export is running continuously")
  Running: "Running",

  string,
}

@doc("Storage Discovery Sku")
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

@doc("Storage Discovery Scope")
@removed(ApiVersion.v2025_01_01_preview)
@renamedFrom(ApiVersion.v2025_03_01_preview, "StorageDiscoveryScope")
model StorageDiscoveryScopeV1 {
  @doc("Display name of the scope")
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

@doc("Storage resource filters for the scope")
@removed(ApiVersion.v2025_01_01_preview)
model StorageDiscoveryResourceFilter {
  @doc("The storage account locations to filter")
  locations: string[];

  ...ArmTagsProperty;
}

@doc("Storage Discovery Collection")
@added(ApiVersion.v2025_01_01_preview)
@renamedFrom(ApiVersion.v2025_03_01_preview, "StorageDiscoveryCollection")
model StorageDiscoveryScope {
  @doc("Display name of the collection")
  displayName: string;

  @doc("Resource types for the collection")
  resourceTypes: StorageDiscoveryResourceType[];

  @doc("The storage account tags keys to filter")
  tagKeysOnly?: string[];

  ...ArmTagsProperty;
}

@doc("Storage Discovery Resource Type")
@added(ApiVersion.v2025_01_01_preview)
union StorageDiscoveryResourceType {
  @doc("Storage Account Resource Type")
  StorageAccounts: "Microsoft.Storage/storageAccounts",

  string,
}

@doc("Destinations for storage discovery data")
@removed(ApiVersion.v2025_01_01_preview)
@added(ApiVersion.v2025_03_01_preview)
model StorageDiscoveryDestination {
  @doc("The ADX destination sink for analytics data")
  @renamedFrom(ApiVersion.v2025_03_01_preview, "storageAccountArmId")
  storageAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;
}

/** The available API versions. */
enum ApiVersion {
  /** 2024-12-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_12_01_preview: "2024-12-01-preview",

  /** 2025-01-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_01_01_preview: "2025-01-01-preview",

  /** 2025-03-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_03_01_preview: "2025-03-01-preview",

  /** 2025-04-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_04_01_preview: "2025-04-01-preview",
}

@doc("Request to get StorageDiscoveryWorkspace data from ADX")
@added(ApiVersion.v2025_04_01_preview)
model GetReportRequest {
  @doc("The list of queries")
  queries: string[];
}

@doc("The response of the report operation")
@added(ApiVersion.v2025_04_01_preview)
model GetReportResponse {
  @doc("One or more result sets, in the same order as the queries in the request body")
  @identifiers(#[])
  results: ReportResponseResultSet[];
}

@doc("The result set of the report operation")
@added(ApiVersion.v2025_04_01_preview)
model ReportResponseResultSet {
  @doc("Array of columns object, present only if the query succeeded")
  @identifiers(#[])
  columns?: ReportResponseColumn[];

  @doc("Array of all rows from ADX, present only if the query succeeded")
  @identifiers(#[])
  rows?: string[][];

  @doc("Provides an error about the query, present only if the query fails")
  errorCode?: string;
}

@doc("The column of the response result set")
@added(ApiVersion.v2025_04_01_preview)
model ReportResponseColumn {
  @doc("Name of the column")
  name: string;

  @doc("ADX type of the column")
  type: string;
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
    GetReportRequest,
    GetReportResponse
  >;
}

interface Operations extends Azure.ResourceManager.Operations {}
