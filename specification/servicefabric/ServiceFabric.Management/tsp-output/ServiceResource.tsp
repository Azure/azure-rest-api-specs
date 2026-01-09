import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * The service resource.
 */
@parentResource(ApplicationResource)
model ServiceResource is TrackedResource<ServiceResourceProperties> {
  /**
   * The name of the service resource in the format of {applicationName}~{serviceName}.
   */
  @path
  @key("serviceName")
  @segment("services")
  name: string;
}

@armResourceOperations
interface ServiceResources {
  /**
   * Get a Service Fabric service resource created or in the process of being created in the Service Fabric application resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_Get")
  get is ArmResourceRead<ServiceResource>;

  /**
   * Create or update a Service Fabric service resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceResource>;

  /**
   * Update a Service Fabric service resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Services_Update")
  update is ArmCustomPatchAsync<ServiceResource, ServiceResourceUpdate>;

  /**
   * Delete a Service Fabric service resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ServiceResource>;

  /**
   * Gets all service resources created or in the process of being created in the Service Fabric application resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_List")
  list is ArmResourceListByParent<ServiceResource>;
}

@@projectedName(ServiceResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServiceResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceResources.createOrUpdate::parameters.resource,
  "The service resource."
);
@@projectedName(ServiceResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ServiceResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceResources.update::parameters.properties,
  "The service resource for patch operations."
);
