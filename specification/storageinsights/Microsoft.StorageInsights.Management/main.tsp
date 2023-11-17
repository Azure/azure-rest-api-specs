import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@versioned(ApiVersion)
@service({
  title: "StorageInsightsClient",
})
@armProviderNamespace
@doc("Storage Insights resource provider API.")
namespace Microsoft.StorageInsights;

@doc("A Storage Insights collection rule resource. This resource configures the collection of storage account metrics.")
model StorageCollectionRule
  is TrackedResource<StorageCollectionRuleProperties> {
  @doc("Name of the storage collection rule")
  @pattern("^[a-zA-Z0-9-]{3,250}$")
  @key("storageCollectionRuleName")
  @path
  @segment("storageCollectionRules")
  @extension("x-ms-parameter-location", "method")
  name: string;
}

@doc("Storage collection rule properties.")
model StorageCollectionRuleProperties {
  @doc("Value indicating whether the storage collection rule is enabled or not.")
  enabled: boolean;

  @doc("The display name of the storage collection rule.")
  displayName?: string;

  @doc("The description of the storage collection rule.")
  description?: string;

  @extension("x-ms-client-flatten", true)
  @doc("The filters definition of the storage collection rule. The storage collection rule will be applied to all of the storage accounts captured by these filters.")
  filters: StorageCollectionRuleFilters;

  @extension("x-ms-client-flatten", true)
  @doc("The destinations to which the storage collection rule sends data.")
  destinations: StorageCollectionRuleDestinations;

  @extension("x-ms-client-flatten", true)
  @doc("The configuration of the storage collection rule.")
  configuration: StorageCollectionRuleConfiguration;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;
}

@doc("Filters definition of the storage collection rule.")
model StorageCollectionRuleFilters {
  @doc("The filters to which the storage collection rule is applied.")
  includeFilter: StorageCollectionRuleFilter;

  @doc("The filters from which the storage collection rule is excluded.")
  excludeFilter?: StorageCollectionRuleFilter;
}

@doc("The filter definition of the storage collection rule. The filters are applied in a logical AND manner, such that only storage accounts that meet all the filters will be included in the collection. Filters that are empty or null have no effect on the selection. For filters that are arrays or dictionaries, any storage account that matches at least one of the array elements or key-value pairs will satisfy the filter condition.")
model StorageCollectionRuleFilter {
  @doc("The Azure Resource Manager scopes to filter. This can be the resource IDs of management groups, subscriptions, resource groups or specific storage accounts.")
  scopes: ResourceIdentifier<[
    {
      type: "*";
      scopes: ["ManagementGroup", "Subscription", "ResourceGroup"];
    }
  ]>[];

  @doc("The storage account names to filter.")
  names?: string[];

  @doc("The storage account tags to filter.")
  tags?: Record<string>;

  @doc("The storage account locations to filter.")
  locations?: string[];

  @doc("The storage account SKUs to filter.")
  skus?: StorageSku[];

  @doc("The storage account namespace structures to filter.")
  namespaceStructures?: NamespaceStructure[];
}

@doc("Destinations for storage collection rule data.")
model StorageCollectionRuleDestinations {
  @doc("The resource ID of the log analytics workspace.")
  dataCollectionRuleResourceId: ResourceIdentifier<[
    {
      type: "Microsoft.Insights/dataCollectionRules";
    }
  ]>;
}

@doc("Configuration of a storage collection rule.")
model StorageCollectionRuleConfiguration {
  @doc("The blob index tags and values to emit in Storage Insights metrics.")
  blobIndexTags?: Record<string>;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface StorageCollectionRules {
  get is ArmResourceRead<StorageCollectionRule>;
  createOrReplace is ArmResourceCreateOrReplaceSync<StorageCollectionRule>;
  update is ArmResourcePatchSync<
    StorageCollectionRule,
    StorageCollectionRuleProperties
  >;
  delete is ArmResourceDeleteSync<StorageCollectionRule>;
  listByResourceGroup is ArmResourceListByParent<StorageCollectionRule>;
  listBySubscription is ArmListBySubscription<StorageCollectionRule>;
}

@doc("Storage SKU")
enum StorageSku {
  @doc("Standard LRS")
  Standard_LRS,

  @doc("Standard GRS")
  Standard_GRS,

  @doc("Standard RAGRS")
  Standard_RAGRS,

  @doc("Standard ZRS")
  Standard_ZRS,

  @doc("Premium LRS")
  Premium_LRS,

  @doc("Premium ZRS")
  Premium_ZRS,

  @doc("Standard GZRS")
  Standard_GZRS,

  @doc("Standard RAGZRS")
  Standard_RAGZRS,
}

@doc("Storage account namespace structure")
enum NamespaceStructure {
  @doc("Hierarchical namespace")
  Hierarchical,

  @doc("Flat namespace")
  Flat,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum ApiVersion {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_08_01_preview: "2023-08-01-preview",
}
