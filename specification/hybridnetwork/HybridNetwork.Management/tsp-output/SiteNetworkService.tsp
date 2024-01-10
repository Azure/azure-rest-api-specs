import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridNetwork;
@doc("Site network service resource.")
model SiteNetworkService
  is TrackedResource<SiteNetworkServicePropertiesFormat> {
  @doc("The name of the site network service.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @key("siteNetworkServiceName")
  @segment("siteNetworkServices")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SiteNetworkServices {
  @doc("Gets information about the specified site network service.")
  get is ArmResourceRead<SiteNetworkService>;

  @doc("Creates or updates a network site.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SiteNetworkService>;

  @doc("Updates a site update tags.")
  updateTags is ArmCustomPatchSync<SiteNetworkService, TagsObject>;

  @doc("Deletes the specified site network service.")
  delete is ArmResourceDeleteWithoutOkAsync<SiteNetworkService>;

  @doc("Lists all site network services.")
  listByResourceGroup is ArmResourceListByParent<SiteNetworkService>;

  @doc("Lists all sites in the network service in a subscription.")
  listBySubscription is ArmListBySubscription<SiteNetworkService>;
}
