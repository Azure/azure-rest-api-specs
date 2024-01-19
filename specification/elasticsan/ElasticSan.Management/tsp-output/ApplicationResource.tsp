import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
@doc("The application resource.")
@parentResource(ManagedCluster)
model ApplicationResource is TrackedResource<ApplicationResourceProperties> {
  @doc("The name of the application resource.")
  @path
  @key("applicationName")
  @segment("applications")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ApplicationResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Service Fabric managed application resource created or in the process of being created in the Service Fabric cluster resource.")
  @operationId("Applications_Get")
  get is ArmResourceRead<ApplicationResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a Service Fabric managed application resource with the specified name.")
  @operationId("Applications_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ApplicationResource,
    BaseParameters<ApplicationResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the tags of an application resource of a given managed cluster.")
  @operationId("Applications_Update")
  update is ArmCustomPatchSync<
    ApplicationResource,
    ApplicationUpdateParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Service Fabric managed application resource with the specified name.")
  @operationId("Applications_Delete")
  delete is ArmResourceDeleteAsync<
    ApplicationResource,
    BaseParameters<ApplicationResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all managed application resources created or in the process of being created in the Service Fabric cluster resource.")
  @operationId("Applications_List")
  list is ArmResourceListByParent<ApplicationResource>;
}

@@projectedName(ApplicationResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ApplicationResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ApplicationResources.createOrUpdate::parameters.resource,
  "The application resource."
);
@@projectedName(ApplicationResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ApplicationResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ApplicationResources.update::parameters.properties,
  "The application resource updated tags."
);
