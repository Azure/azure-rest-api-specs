import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
@doc("Represents a catalog.")
@parentResource(DevCenter)
model Catalog is ProxyResource<CatalogProperties> {
  @doc("The name of the Catalog.")
  @path
  @key("catalogName")
  @segment("catalogs")
  name: string;
}

@armResourceOperations
interface Catalogs {
  @doc("Gets a catalog")
  get is ArmResourceRead<Catalog>;

  @doc("Creates or updates a catalog.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Catalog,
    BaseParameters<Catalog>,
    ArmAsyncOperationHeader
  >;

  @doc("Partially updates a catalog.")
  update is ArmCustomPatchAsync<
    Catalog,
    CatalogUpdate,
    BaseParameters<Catalog>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a catalog resource.")
  delete is ArmResourceDeleteAsync<
    Catalog,
    BaseParameters<Catalog>,
    ArmAsyncOperationHeader
  >;

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
  sync is ArmResourceActionNoResponseContentAsync<
    Catalog,
    void,
    BaseParameters<Catalog>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(Catalogs.createOrUpdate::parameters.resource, "json", "body");
@@extension(Catalogs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Catalogs.createOrUpdate::parameters.resource, "Represents a catalog.");
@@projectedName(Catalogs.update::parameters.properties, "json", "body");
@@extension(Catalogs.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Catalogs.update::parameters.properties, "Updatable catalog properties.");
