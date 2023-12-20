import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SphereCatalog.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sphere;
@doc("An product resource belonging to a catalog resource.")
@parentResource(SphereCatalog)
model SphereProduct is ProxyResource<ProductProperties> {
  @doc("Name of product.")
  @pattern("^[\\w][\\w\\s]{1,48}[\\w]$|^\\.default$|^\\.unassigned$")
  @path
  @key("productName")
  @segment("products")
  name: string;
}

@armResourceOperations
interface SphereProducts {
  @doc("Get a Product. '.default' and '.unassigned' are system defined values and cannot be used for product name.")
  get is ArmResourceRead<SphereProduct>;
  @doc("Create a Product. '.default' and '.unassigned' are system defined values and cannot be used for product name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SphereProduct>;
  @doc("Update a Product. '.default' and '.unassigned' are system defined values and cannot be used for product name.")
  update is ArmResourcePatchAsync<SphereProduct, ProductProperties>;
  @doc("Delete a Product. '.default' and '.unassigned' are system defined values and cannot be used for product name'")
  delete is ArmResourceDeleteAsync<SphereProduct>;
  @doc("List Product resources by Catalog")
  listByCatalog is ArmResourceListByParent<SphereProduct>;
  @doc("Counts devices in product. '.default' and '.unassigned' are system defined values and cannot be used for product name.")
  countDevices is ArmResourceActionSync<
    SphereProduct,
    void,
    CountDeviceResponse
  >;
  @doc("Generates default device groups for the product. '.default' and '.unassigned' are system defined values and cannot be used for product name.")
  generateDefaultDeviceGroups is ArmResourceActionSync<
    SphereProduct,
    void,
    ResourceListResult<SphereDeviceGroup>
  >;
}
