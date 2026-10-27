import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ConnectedCache;

@removed(Versions.v2024_11_30_preview)
@doc("ConnectedCache Resource. Represents the high level Nodes needed to provision CacheNode and customer resources used in private preview")
model EnterprisePreviewResource is TrackedResource<CacheNodeOldResponse> {
  @doc("Name of the Customer resource")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9\\_\\-]*")
  @key("customerResourceName")
  @segment("enterpriseCustomers")
  @path
  name: string;
}

@removed(Versions.v2024_11_30_preview)
@armResourceOperations
interface EnterpriseCustomerOperations {
  @doc("Retrieves the properties of a Enterprise customer")
  get is ArmResourceRead<EnterprisePreviewResource>;
  @doc("Creates a cacheNodes with the specified create parameters")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EnterprisePreviewResource>;
  @doc("updates an existing enterpriseCustomers")
  update is ArmCustomPatchSync<
    EnterprisePreviewResource,
    ConnectedCachePatchResource
  >;
  @doc("Deletes an existing customer Enterprise resource")
  delete is ArmResourceDeleteSync<EnterprisePreviewResource>;
  @doc("Retrieves the properties of all ConnectedCache enterpriseCustomers")
  listByResourceGroup is ArmResourceListByParent<EnterprisePreviewResource>;
  @doc("Retrieves the properties of all ConnectedCaches")
  listBySubscription is ArmListBySubscription<EnterprisePreviewResource>;
}
