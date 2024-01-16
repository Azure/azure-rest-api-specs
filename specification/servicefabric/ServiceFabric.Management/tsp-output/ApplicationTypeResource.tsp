import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
@doc("The application type name resource")
@parentResource(Cluster)
model ApplicationTypeResource
  is TrackedResource<ApplicationTypeResourceProperties> {
  @doc("The name of the application type name resource.")
  @path
  @key("applicationTypeName")
  @segment("applicationTypes")
  name: string;
}

@armResourceOperations
interface ApplicationTypeResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Service Fabric application type name resource created or in the process of being created in the Service Fabric cluster resource.")
  @operationId("ApplicationTypes_Get")
  get is ArmResourceRead<ApplicationTypeResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a Service Fabric application type name resource with the specified name.")
  @operationId("ApplicationTypes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApplicationTypeResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Service Fabric application type name resource with the specified name.")
  @operationId("ApplicationTypes_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationTypeResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all application type name resources created or in the process of being created in the Service Fabric cluster resource.")
  @operationId("ApplicationTypes_List")
  list is ArmResourceListByParent<ApplicationTypeResource>;
}

@@projectedName(ApplicationTypeResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ApplicationTypeResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ApplicationTypeResources.createOrUpdate::parameters.resource,
  "The application type name resource."
);
