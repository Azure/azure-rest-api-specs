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

@armProviderNamespace
@service({
  title: "StorageDiscoveryClient",
})
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

@doc("Storage Discovery Workspace Properties.")
model StorageDiscoveryWorkspaceProperties {
  @doc("The storage discovery tier.")
  tier: StorageDiscoveryTier;

  @doc("The state of storage discovery data export")
  exportState: DataExportState;

  @doc("The view level storage discovery data estate")
  storageEstateViewLevel: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
      scopes: ["tenant", "subscription", "resourceGroup"];
    }
  ]>;

  @doc("The description of the storage discovery workspace.")
  description?: string;

  @doc("The storage discovery resource collections")
  @extension("x-ms-identifiers", ["displayName"])
  storageCollections: StorageDiscoveryCollection[];

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;
}

@doc("The state of storage discovery data export")
union DataExportState {
  @doc("Data export is stopped.")
  Stopped: "Stopped",

  @doc("Data export is running continuously.")
  Running: "Running",

  string,
}

@doc("Storage Discovery Tier")
union StorageDiscoveryTier {
  @doc("Standard Tier")
  Standard: "Standard",

  @doc("Premium Tier")
  Premium: "Premium",

  @doc("Basic Tier")
  Basic: "Basic",

  string,
}

@doc("Storage Discovery Collection")
model StorageDiscoveryCollection {
  @doc("Display name of the collection")
  displayName: string;

  @doc("Resource types for the collection")
  resourceTypes: StorageDiscoveryResourceType[];

  @doc("The storage account tags keys to filter")
  tagKeysOnly?: string[];

  ...ArmTagsProperty;
}

@doc("Storage Discovery Resource Type")
union StorageDiscoveryResourceType {
  @doc("Storage Account Resource Type")
  StorageAccounts: "Microsoft.Storage/storageAccounts",

  string,
}

/** The available API versions. */
enum ApiVersion {
  /** 2024-12-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_12_01_preview: "2024-12-01-preview",
}

@armResourceOperations
interface StorageDiscoveryWorkspaces {
  get is ArmResourceRead<StorageDiscoveryWorkspace>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageDiscoveryWorkspace>;
  update is ArmResourcePatchSync<
    StorageDiscoveryWorkspace,
    StorageDiscoveryWorkspaceProperties
  >;
  @parameterVisibility
  delete is ArmResourceDeleteSync<StorageDiscoveryWorkspace>;
  listByResourceGroup is ArmResourceListByParent<StorageDiscoveryWorkspace>;
  listBySubscription is ArmListBySubscription<StorageDiscoveryWorkspace>;
}

interface Operations extends Azure.ResourceManager.Operations {}
