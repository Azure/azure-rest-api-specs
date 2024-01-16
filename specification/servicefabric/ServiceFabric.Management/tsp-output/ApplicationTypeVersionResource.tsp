import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationTypeResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
@doc("An application type version resource for the specified application type name resource.")
@parentResource(ApplicationTypeResource)
model ApplicationTypeVersionResource
  is TrackedResource<ApplicationTypeVersionResourceProperties> {
  @doc("The application type version.")
  @path
  @key("version")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface ApplicationTypeVersionResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Service Fabric application type version resource created or in the process of being created in the Service Fabric application type name resource.")
  @operationId("ApplicationTypeVersions_Get")
  get is ArmResourceRead<ApplicationTypeVersionResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a Service Fabric application type version resource with the specified name.")
  @operationId("ApplicationTypeVersions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ApplicationTypeVersionResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Service Fabric application type version resource with the specified name.")
  @operationId("ApplicationTypeVersions_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationTypeVersionResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all application type version resources created or in the process of being created in the Service Fabric application type name resource.")
  @operationId("ApplicationTypeVersions_List")
  list is ArmResourceListByParent<ApplicationTypeVersionResource>;
}

@@projectedName(ApplicationTypeVersionResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ApplicationTypeVersionResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ApplicationTypeVersionResources.createOrUpdate::parameters.resource,
  "The application type version resource."
);
