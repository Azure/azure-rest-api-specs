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
/**
 * An application type version resource for the specified application type name resource.
 */
@parentResource(ApplicationTypeResource)
model ApplicationTypeVersionResource
  is TrackedResource<ApplicationTypeVersionResourceProperties> {
  /**
   * The application type version.
   */
  @path
  @key("version")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface ApplicationTypeVersionResources {
  /**
   * Get a Service Fabric application type version resource created or in the process of being created in the Service Fabric application type name resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationTypeVersions_Get")
  get is ArmResourceRead<ApplicationTypeVersionResource>;

  /**
   * Create or update a Service Fabric application type version resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationTypeVersions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApplicationTypeVersionResource>;

  /**
   * Delete a Service Fabric application type version resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationTypeVersions_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationTypeVersionResource>;

  /**
   * Gets all application type version resources created or in the process of being created in the Service Fabric application type name resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
