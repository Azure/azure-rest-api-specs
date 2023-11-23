import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.MobileNetwork;
@doc("Service resource. Must be created in the same location as its parent mobile network.")
@parentResource(MobileNetwork)
model Service is TrackedResource<ServicePropertiesFormat> {
  @doc("The name of the service. You must not use any of the following reserved strings - `default`, `requested` or `service`")
  @maxLength(64)
  @pattern("^(?!(default|requested|service)$)[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("serviceName")
  @segment("services")
  name: string;
}

@armResourceOperations
interface Services {
  @doc("Gets information about the specified service.")
  get is ArmResourceRead<Service>;
  @doc("Creates or updates a service. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Service>;
  @doc("Updates service tags.")
  updateTags is ArmTagsPatchSync<Service>;
  @doc("Deletes the specified service.")
  delete is ArmResourceDeleteAsync<Service>;
  @doc("Gets all the services in a mobile network.")
  listByMobileNetwork is ArmResourceListByParent<Service>;
}
