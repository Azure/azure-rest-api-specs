import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Represents a catalog.")
@parentResource(DevCenter)
model DevCenterCatalog is ProxyResource<CatalogProperties> {
  @doc("The name of the Catalog.")
  @path
  @key("catalogName")
  @segment("catalogs")
  name: string;
}

@armResourceOperations
interface DevCenterCatalogs {
  @doc("Gets a catalog")
  get is ArmResourceRead<DevCenterCatalog>;
  @doc("Creates or updates a catalog.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DevCenterCatalog>;
  @doc("Partially updates a catalog.")
  update is ArmResourcePatchAsync<DevCenterCatalog, CatalogProperties>;
  @doc("Deletes a catalog resource.")
  delete is ArmResourceDeleteAsync<DevCenterCatalog>;
  @doc("Lists catalogs for a devcenter.")
  listByDevCenter is ArmResourceListByParent<
    DevCenterCatalog,
    {
      ...BaseParameters<DevCenterCatalog>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Syncs templates for a template source.")
  sync is ArmResourceActionNoResponseContentAsync<DevCenterCatalog, {}>;
}
