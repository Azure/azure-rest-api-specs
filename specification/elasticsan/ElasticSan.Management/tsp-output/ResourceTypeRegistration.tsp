import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

@parentResource(ProviderRegistration)
model ResourceTypeRegistration
  is ProxyResource<ResourceTypeRegistrationProperties> {
  @doc("The resource type.")
  @path
  @key("resourceType")
  @segment("resourcetypeRegistrations")
  name: string;
}

@armResourceOperations
interface ResourceTypeRegistrations {
  @doc("Gets a resource type details in the given subscription and provider.")
  get is ArmResourceRead<ResourceTypeRegistration>;

  @doc("Creates or updates a resource type.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ResourceTypeRegistration,
    BaseParameters<ResourceTypeRegistration>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a resource type")
  delete is ArmResourceDeleteSync<ResourceTypeRegistration>;

  @doc("Gets the list of the resource types for the given provider.")
  listByProviderRegistration is ArmResourceListByParent<ResourceTypeRegistration>;
}

@@projectedName(ResourceTypeRegistrations.createOrUpdate::parameters.resource,
  "json",
  "properties"
);
@@extension(ResourceTypeRegistrations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(ResourceTypeRegistrations.createOrUpdate::parameters.resource,
  "The required request body parameters supplied to the resource type registration CreateOrUpdate operation."
);
