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
/**
 * The application type name resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedCluster)
@includeInapplicableMetadataInPayload(false)
model ApplicationTypeResource extends ProxyResource {
  /**
   * The name of the application type name resource.
   */
  @path
  @key("applicationTypeName")
  @segment("applicationTypes")
  @visibility("read")
  name: string;

  /**
   * The application type name properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ApplicationTypeResourceProperties;
}

@armResourceOperations
interface ApplicationTypeResources {
  /**
   * Get a Service Fabric application type name resource created or in the process of being created in the Service Fabric managed cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationTypes_Get")
  get is ArmResourceRead<ApplicationTypeResource>;

  /**
   * Create or update a Service Fabric managed application type name resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationTypes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApplicationTypeResource>;

  /**
   * Updates the tags of an application type resource of a given managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("ApplicationTypes_Update")
  update is ArmCustomPatchSync<
    ApplicationTypeResource,
    ApplicationTypeUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application type name resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ApplicationTypes_Delete")
  delete is ArmResourceDeleteAsync<
    ApplicationTypeResource,
    BaseParameters<ApplicationTypeResource>,
    ArmLroLocationHeader
  >;

  /**
   * Gets all application type name resources created or in the process of being created in the Service Fabric managed cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
@@projectedName(ApplicationTypeResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ApplicationTypeResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ApplicationTypeResources.update::parameters.properties,
  "The application type resource updated tags."
);
