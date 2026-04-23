import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/SiteModels.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.Network;

@@doc(Site.name, "The name of the Site.");
@@doc(Site.properties, "The properties of the Site.");
@doc("Class representing a Site.")
@parentResource(TopologyMap)
model Site is ProxyResource<SiteProperties> {
  ...ResourceNameParameter<Site>;
}

@armResourceOperations
interface Sites {
  @doc("Gets a Site.")
  get is ArmResourceRead<Site>;

  @doc("Create or update a Site.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Site>;

  @doc("Updates a Site.")
  update is ArmResourcePatchAsync<Site, SiteProperties>;

  @doc("Deletes a Site.")
  delete is ArmResourceDeleteWithoutOkAsync<Site>;

  @doc("Lists all Sites within a topology map.")
  listByParent is ArmResourceListByParent<Site>;
}
