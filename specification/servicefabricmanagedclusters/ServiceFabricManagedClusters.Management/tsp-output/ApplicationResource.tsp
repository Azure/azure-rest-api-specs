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
 * The application resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedCluster)
@Azure.ResourceManager.Private.armResourceInternal(
  ApplicationResourceProperties
)
@includeInapplicableMetadataInPayload(false)
model ApplicationResource extends ProxyResource {
  /**
   * The name of the application resource.
   */
  @path
  @key("applicationName")
  @segment("applications")
  name: string;

  /**
   * Describes the managed identities for an Azure resource.
   */
  identity?: ManagedIdentity;

  /**
   * The application resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ApplicationResourceProperties;
}

@armResourceOperations
interface ApplicationResources {
  /**
   * Get a Service Fabric managed application resource created or in the process of being created in the Service Fabric cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Applications_Get")
  get is ArmResourceRead<ApplicationResource>;

  /**
   * Create or update a Service Fabric managed application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Applications_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApplicationResource,
    BaseParameters<ApplicationResource>,
    ArmLroLocationHeader
  >;

  /**
   * Updates the tags of an application resource of a given managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Applications_Update")
  update is ArmCustomPatchSync<
    ApplicationResource,
    ApplicationUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Applications_Delete")
  delete is ArmResourceDeleteAsync<
    ApplicationResource,
    BaseParameters<ApplicationResource>,
    ArmLroLocationHeader
  >;

  /**
   * Gets all managed application resources created or in the process of being created in the Service Fabric cluster resource.
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
  "The application resource updated tags."
);
