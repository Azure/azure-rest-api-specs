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
interface ApplicationTypeResources {
  /**
   * Get a Service Fabric application type name resource created or in the process of being created in the Service Fabric managed cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationTypes_Get")
  get is ArmResourceRead<ApplicationTypeResource>;

  /**
   * Create or update a Service Fabric managed application type name resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ApplicationTypes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ApplicationTypeResource,
    Response = ArmResourceUpdatedResponse<ApplicationTypeResource>
  >;

  /**
   * Updates the tags of an application type resource of a given managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @parameterVisibility
  @operationId("ApplicationTypes_Update")
  update is ArmCustomPatchSync<
    ApplicationTypeResource,
    PatchModel = ApplicationTypeUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application type name resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("ApplicationTypes_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationTypeResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all application type name resources created or in the process of being created in the Service Fabric managed cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationTypes_List")
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
@@doc(ApplicationTypeResources.createOrUpdate::parameters.resource,
  "The application type name resource."
);
@@doc(ApplicationTypeResources.update::parameters.properties,
  "The application type resource updated tags."
);
