import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridNetwork;
@doc("Site resource.")
model Site is TrackedResource<SitePropertiesFormat> {
  @doc("The name of the network service site.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("siteName")
  @segment("sites")
  name: string;
}

@armResourceOperations
interface Sites {
  @doc("Gets information about the specified network site.")
  get is ArmResourceRead<Site>;
  @doc("Creates or updates a network site.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Site>;
  @doc("Updates a site update tags.")
  updateTags is ArmTagsPatchSync<Site>;
  @doc("Deletes the specified network site.")
  delete is ArmResourceDeleteWithoutOkAsync<Site>;
  @doc("Lists all sites in the network service.")
  listByResourceGroup is ArmResourceListByParent<Site>;
  @doc("Lists all sites in the network service in a subscription.")
  listBySubscription is ArmListBySubscription<Site>;
}
