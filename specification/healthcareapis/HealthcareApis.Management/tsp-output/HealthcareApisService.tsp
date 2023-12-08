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
model HealthcareApisService is TrackedResource<ServicesProperties> {
  @doc("The name of the service instance.")
  @maxLength(24)
  @minLength(3)
  @path
  @key("resourceName")
  @segment("services")
  name: string;
}

@armResourceOperations
interface HealthcareApisServices {
  @doc("Get the metadata of a service instance.")
  get is ArmResourceRead<HealthcareApisService>;
  @doc("Create or update the metadata of a service instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<HealthcareApisService>;
  @doc("Update the metadata of a service instance.")
  update is ArmResourcePatchAsync<HealthcareApisService, ServicesProperties>;
  @doc("Delete a service instance.")
  delete is ArmResourceDeleteWithoutOkAsync<HealthcareApisService>;
  @doc("Get all the service instances in a resource group.")
  listByResourceGroup is ArmResourceListByParent<HealthcareApisService>;
  @doc("Get all the service instances in a subscription.")
  list is ArmListBySubscription<HealthcareApisService>;
}
