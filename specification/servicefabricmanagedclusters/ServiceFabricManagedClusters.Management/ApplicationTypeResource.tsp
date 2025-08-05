import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ServiceFabric;
/**
 * The application type name resource
 */
@parentResource(ManagedCluster)
model ApplicationTypeResource
  is Azure.ResourceManager.ProxyResource<ApplicationTypeResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationTypeResource,
    KeyName = "applicationTypeName",
    SegmentName = "applicationTypes",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface ApplicationTypes {
  /**
   * Get a Service Fabric application type name resource created or in the process of being created in the Service Fabric managed cluster resource.
   */
  get is ArmResourceRead<ApplicationTypeResource>;

  /**
   * Create or update a Service Fabric managed application type name resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Day 0 Property"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ApplicationTypeResource,
    Response = ArmResourceUpdatedResponse<ApplicationTypeResource>
  >;

  /**
   * Updates the tags of an application type resource of a given managed cluster.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ApplicationTypeResource,
    PatchModel = ApplicationTypeUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application type name resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Day 0 Property"
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationTypeResource,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all application type name resources created or in the process of being created in the Service Fabric managed cluster resource.
   */
  list is ArmResourceListByParent<
    ApplicationTypeResource,
    Response = ArmResponse<ApplicationTypeResourceList>
  >;
}

@@doc(ApplicationTypeResource.name,
  "The name of the application type name resource."
);
@@doc(ApplicationTypeResource.properties,
  "The application type name properties"
);
@@doc(ApplicationTypes.createOrUpdate::parameters.resource,
  "The application type name resource."
);
@@doc(ApplicationTypes.update::parameters.properties,
  "The application type resource updated tags."
);

/**
 * The application type name properties
 */
model ApplicationTypeResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Day 0 property, keep as string for backwards compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * The list of application type names.
 */
model ApplicationTypeResourceList is Azure.Core.Page<ApplicationTypeResource>;

/**
 * Application type update request
 */
model ApplicationTypeUpdateParameters {
  /**
   * Application type update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;
}
