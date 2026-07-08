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
  update is ArmCustomPatchSync<
    StorageDiscoveryWorkspace,
    StorageDiscoveryWorkspaceUpdate
  >;
  delete is ArmResourceDeleteSync<StorageDiscoveryWorkspace>;
  listByResourceGroup is ArmResourceListByParent<StorageDiscoveryWorkspace>;
  listBySubscription is ArmListBySubscription<StorageDiscoveryWorkspace>;

  @autoRoute
  @post
  report is ArmResourceActionAsync<
    StorageDiscoveryWorkspace,
    GetReportContent,
    GetReportResult
  >;
}

interface Operations extends Azure.ResourceManager.Operations {}
