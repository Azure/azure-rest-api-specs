import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HealthcareApis;
@doc("The description of the service.")
model ServicesDescription is TrackedResource<ServicesProperties> {
  @doc("The name of the service instance.")
  @maxLength(24)
  @minLength(3)
  @key("resourceName")
  @segment("services")
  name: string;
}

@armResourceOperations
interface Services {
  @doc("Get the metadata of a service instance.")
  get is ArmResourceRead<ServicesDescription>;
  @doc("Create or update the metadata of a service instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServicesDescription>;
  @doc("Update the metadata of a service instance.")
  update is ArmCustomPatchAsync<ServicesDescription, ServicesPatchDescription>;
  @doc("Delete a service instance.")
  delete is ArmResourceDeleteWithoutOkAsync<ServicesDescription>;
  @doc("Get all the service instances in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ServicesDescription>;
  @doc("Get all the service instances in a subscription.")
  list is ArmListBySubscription<ServicesDescription>;
}
