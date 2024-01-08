import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DevCenter;
@doc("Represents a catalog.")
@parentResource(DevCenter)
model Catalog is ProxyResource<CatalogProperties> {
  @doc("The name of the Catalog.")
  @key("catalogName")
  @segment("catalogs")
  name: string;
}

@armResourceOperations
interface Catalogs {
  @doc("Gets a catalog")
  get is ArmResourceRead<Catalog>;
  @doc("Creates or updates a catalog.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Catalog>;
  @doc("Partially updates a catalog.")
  update is ArmCustomPatchAsync<Catalog, CatalogUpdate>;
  @doc("Deletes a catalog resource.")
  delete is ArmResourceDeleteAsync<Catalog>;
  @doc("Lists catalogs for a devcenter.")
  listByDevCenter is ArmResourceListByParent<
    Catalog,
    {
      ...BaseParameters<Catalog>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Syncs templates for a template source.")
  sync is ArmResourceActionNoResponseContentAsync<Catalog, void>;
}
