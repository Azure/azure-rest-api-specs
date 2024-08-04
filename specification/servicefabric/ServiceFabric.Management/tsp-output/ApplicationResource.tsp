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
/**
 * The application resource.
 */
@parentResource(Cluster)
model ApplicationResource is TrackedResource<ApplicationResourceProperties> {
  /**
   * The name of the application resource.
   */
  @path
  @key("applicationName")
  @segment("applications")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ApplicationResources {
  /**
   * Get a Service Fabric application resource created or in the process of being created in the Service Fabric cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Applications_Get")
  get is ArmResourceRead<ApplicationResource>;

  /**
   * Create or update a Service Fabric application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Applications_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApplicationResource>;

  /**
   * Update a Service Fabric application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Applications_Update")
  update is ArmCustomPatchAsync<ApplicationResource, ApplicationResourceUpdate>;

  /**
   * Delete a Service Fabric application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Applications_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationResource>;

  /**
   * Gets all application resources created or in the process of being created in the Service Fabric cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
  "The application resource for patch operations."
);
