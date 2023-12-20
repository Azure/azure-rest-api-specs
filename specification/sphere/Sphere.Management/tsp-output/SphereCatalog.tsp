import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sphere;
@doc("An Azure Sphere catalog")
model SphereCatalog is TrackedResource<CatalogProperties> {
  @doc("Name of catalog")
  @pattern("^[A-Za-z0-9_-]{1,50}$")
  @path
  @key("catalogName")
  @segment("catalogs")
  name: string;
}

@armResourceOperations
interface SphereCatalogs {
  @doc("Get a Catalog")
  get is ArmResourceRead<SphereCatalog>;
  @doc("Create a Catalog")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SphereCatalog>;
  @doc("Update a Catalog")
  update is ArmTagsPatchSync<SphereCatalog>;
  @doc("Delete a Catalog")
  delete is ArmResourceDeleteAsync<SphereCatalog>;
  @doc("List Catalog resources by resource group")
  listByResourceGroup is ArmResourceListByParent<SphereCatalog>;
  @doc("List Catalog resources by subscription ID")
  listBySubscription is ArmListBySubscription<SphereCatalog>;
  @doc("Counts devices in catalog.")
  countDevices is ArmResourceActionSync<
    SphereCatalog,
    void,
    CountDeviceResponse
  >;
  @doc("Lists deployments for catalog.")
  listDeployments is ArmResourceActionSync<
    SphereCatalog,
    void,
    ResourceListResult<SphereDeployment>,
    {
      ...BaseParameters<SphereCatalog>;

      @doc("Filter the result list using the given expression")
      @query("$filter")
      filter?: string;

      @doc("The number of result items to return.")
      @query("$top")
      top?: int32;

      @doc("The number of result items to skip.")
      @query("$skip")
      skip?: int32;

      @doc("The maximum number of result items per page.")
      @query("$maxpagesize")
      maxpagesize?: int32;
    }
  >;
  @doc("List the device groups for the catalog.")
  listDeviceGroups is ArmResourceActionSync<
    SphereCatalog,
    ListDeviceGroupsRequest,
    ResourceListResult<SphereDeviceGroup>,
    {
      ...BaseParameters<SphereCatalog>;

      @doc("Filter the result list using the given expression")
      @query("$filter")
      filter?: string;

      @doc("The number of result items to return.")
      @query("$top")
      top?: int32;

      @doc("The number of result items to skip.")
      @query("$skip")
      skip?: int32;

      @doc("The maximum number of result items per page.")
      @query("$maxpagesize")
      maxpagesize?: int32;
    }
  >;
  @doc("Lists device insights for catalog.")
  listDeviceInsights is ArmResourceActionSync<
    SphereCatalog,
    void,
    PagedDeviceInsight,
    {
      ...BaseParameters<SphereCatalog>;

      @doc("Filter the result list using the given expression")
      @query("$filter")
      filter?: string;

      @doc("The number of result items to return.")
      @query("$top")
      top?: int32;

      @doc("The number of result items to skip.")
      @query("$skip")
      skip?: int32;

      @doc("The maximum number of result items per page.")
      @query("$maxpagesize")
      maxpagesize?: int32;
    }
  >;
  @doc("Lists devices for catalog.")
  listDevices is ArmResourceActionSync<
    SphereCatalog,
    void,
    ResourceListResult<SphereDevice>,
    {
      ...BaseParameters<SphereCatalog>;

      @doc("Filter the result list using the given expression")
      @query("$filter")
      filter?: string;

      @doc("The number of result items to return.")
      @query("$top")
      top?: int32;

      @doc("The number of result items to skip.")
      @query("$skip")
      skip?: int32;

      @doc("The maximum number of result items per page.")
      @query("$maxpagesize")
      maxpagesize?: int32;
    }
  >;
}
