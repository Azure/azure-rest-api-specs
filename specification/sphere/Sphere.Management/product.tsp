import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AzureSphere;

//Products
@doc("An product resource belonging to a catalog resource.")
@parentResource(Catalog)
model Product is ProxyResource<ProductProperties> {
  @doc("Name of product.")
  @pattern("^[\\w][\\w\\s]{1,48}[\\w]$|^\\.default$|^\\.unassigned$")
  @key("productName")
  @path
  @segment("products")
  name: string;
}

interface ProxyResourceOperationsProducts<
  TResource extends ArmResource,
  TListParameters extends {} = {}
>
  extends ResourceListByParent<
      TResource,
      TListParameters & BaseParameters<TResource>
    > {
  @doc("Get a Product. '.default' and '.unassigned' are system defined values and cannot be used for product name.")
  get is ArmResourceRead<Product>;
  @doc("Create a Product. '.default' and '.unassigned' are system defined values and cannot be used for product name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Product>;
  @doc("Delete a Product. '.default' and '.unassigned' are system defined values and cannot be used for product name'")
  delete is ArmResourceDeleteAsync<Product>;
  @doc("Update a Product. '.default' and '.unassigned' are system defined values and cannot be used for product name.")
  update is ArmResourcePatchAsync<Product, ProductProperties>;
}

@armResourceOperations
interface Products extends ProxyResourceOperationsProducts<Product> {
  @autoRoute
  @doc("Generates default device groups for the product. '.default' and '.unassigned' are system defined values and cannot be used for product name.")
  @armResourceAction(Product)
  @post
  generateDefaultDeviceGroups(
    ...ResourceInstanceParameters<Product>,
  ): ArmResponse<ResourceListResult<DeviceGroup>> | ErrorResponse;

  @doc("Counts devices in product. '.default' and '.unassigned' are system defined values and cannot be used for product name.")
  @removed(Versions.v2024_04_01)
  @autoRoute
  @renamedFrom(Versions.v2024_04_01, "countDevices")
  @armResourceAction(Product)
  @action("countDevices")
  @post
  deprecated(
    ...ResourceInstanceParameters<Product>,
  ): ArmResponse<CountDeviceResponse> | ErrorResponse;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "preview api"
  @doc("Counts devices in product. '.default' and '.unassigned' are system defined values and cannot be used for product name.")
  @added(Versions.v2024_04_01)
  @autoRoute
  @sharedRoute
  @armResourceAction(Product)
  @post
  countDevices(
    ...ResourceInstanceParameters<Product>,
  ): ArmResponse<CountDevicesResponse> | ErrorResponse;
}

@doc("The properties of product")
model ProductProperties {
  @doc("Description of the product")
  description: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}
