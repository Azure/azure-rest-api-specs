import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationTypeResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * An application type version resource for the specified application type name resource.
 */
@parentResource(ApplicationTypeResource)
model ApplicationTypeVersionResource
  is Azure.ResourceManager.TrackedResource<ApplicationTypeVersionResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationTypeVersionResource,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ApplicationTypeVersionResources {
  /**
   * Get a Service Fabric managed application type version resource created or in the process of being created in the Service Fabric managed application type name resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationTypeVersions_Get")
  get is ArmResourceRead<ApplicationTypeVersionResource>;

  /**
   * Create or update a Service Fabric managed application type version resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("ApplicationTypeVersions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApplicationTypeVersionResource,
    Response = ArmResourceUpdatedResponse<ApplicationTypeVersionResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ApplicationTypeVersionResource;
    }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the tags of an application type version resource of a given managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @parameterVisibility
  @operationId("ApplicationTypeVersions_Update")
  update is ArmCustomPatchSync<
    ApplicationTypeVersionResource,
    PatchModel = ApplicationTypeVersionUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application type version resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("ApplicationTypeVersions_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationTypeVersionResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all application type version resources created or in the process of being created in the Service Fabric managed application type name resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationTypeVersions_ListByApplicationTypes")
  listByApplicationTypes is ArmResourceListByParent<
    ApplicationTypeVersionResource,
    Response = ArmResponse<ApplicationTypeVersionResourceList>
  >;
}

@@doc(ApplicationTypeVersionResource.name, "The application type version.");
@@doc(ApplicationTypeVersionResource.properties,
  "The properties of the application type version resource."
);
@@doc(ApplicationTypeVersionResources.createOrUpdate::parameters.resource,
  "The application type version resource."
);
@@doc(ApplicationTypeVersionResources.update::parameters.properties,
  "The application type version resource updated tags."
);
