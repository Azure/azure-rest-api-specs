import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationTypeResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceFabric;
@doc("An application type version resource for the specified application type name resource.")
@parentResource(ApplicationTypeResource)
model ApplicationTypeVersionResource
  is TrackedResource<ApplicationTypeVersionResourceProperties> {
  @doc("The application type version.")
  @key("version")
  @segment("versions")
  name: string;
}

@armResourceOperations
@projectedName("client", "ApplicationTypeVersions")
interface ApplicationTypeVersionResources_ApplicationTypeVersions {
  @doc("Get a Service Fabric application type version resource created or in the process of being created in the Service Fabric application type name resource.")
  get is ArmResourceRead<ApplicationTypeVersionResource>;

  @doc("Create or update a Service Fabric application type version resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ApplicationTypeVersionResource>;

  @doc("Delete a Service Fabric application type version resource with the specified name.")
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationTypeVersionResource>;

  @doc("Gets all application type version resources created or in the process of being created in the Service Fabric application type name resource.")
  list is ArmResourceListByParent<ApplicationTypeVersionResource>;
}
