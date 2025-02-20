import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * The application type name resource
 */
model ApplicationTypeResource
  is Azure.ResourceManager.TrackedResource<ApplicationTypeResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationTypeResource,
    KeyName = "applicationTypeName",
    SegmentName = "applicationTypes",
    NamePattern = ""
  >;
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
  @parameterVisibility
  update is ArmCustomPatchSync<
    ApplicationTypeResource,
    PatchModel = ApplicationTypeUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application type name resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Day 0 Property"
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationTypeResource>;

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
