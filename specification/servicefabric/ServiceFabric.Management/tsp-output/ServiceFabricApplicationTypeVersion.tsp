import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceFabricApplicationType.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceFabric;
@doc("An application type version resource for the specified application type name resource.")
@parentResource(ServiceFabricApplicationType)
model ServiceFabricApplicationTypeVersion
  is TrackedResource<ApplicationTypeVersionResourceProperties> {
  @doc("The application type version.")
  @path
  @key("version")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface ServiceFabricApplicationTypeVersions {
  @doc("Get a Service Fabric application type version resource created or in the process of being created in the Service Fabric application type name resource.")
  get is ArmResourceRead<ServiceFabricApplicationTypeVersion>;
  @doc("Create or update a Service Fabric application type version resource with the specified name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceFabricApplicationTypeVersion>;
  @doc("Delete a Service Fabric application type version resource with the specified name.")
  delete is ArmResourceDeleteWithoutOkAsync<ServiceFabricApplicationTypeVersion>;
  @doc("Gets all application type version resources created or in the process of being created in the Service Fabric application type name resource.")
  list is ArmResourceListByParent<ServiceFabricApplicationTypeVersion>;
}
