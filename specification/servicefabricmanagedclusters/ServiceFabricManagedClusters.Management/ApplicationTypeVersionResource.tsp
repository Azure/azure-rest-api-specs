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
interface ApplicationTypeVersions {
  /**
   * Get a Service Fabric managed application type version resource created or in the process of being created in the Service Fabric managed application type name resource.
   */
  get is ArmResourceRead<ApplicationTypeVersionResource>;

  /**
   * Create or update a Service Fabric managed application type version resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Day 0 Property"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Day 0 Property"
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ApplicationTypeVersionResource,
    Response = ArmResourceUpdatedResponse<ApplicationTypeVersionResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ApplicationTypeVersionResource;
    }),
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Updates the tags of an application type version resource of a given managed cluster.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    ApplicationTypeVersionResource,
    PatchModel = ApplicationTypeVersionUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application type version resource with the specified name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationTypeVersionResource,
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all application type version resources created or in the process of being created in the Service Fabric managed application type name resource.
   */
  listByApplicationTypes is ArmResourceListByParent<
    ApplicationTypeVersionResource,
    Response = ArmResponse<ApplicationTypeVersionResourceList>
  >;
}

@@doc(ApplicationTypeVersionResource.name, "The application type version.");
@@doc(ApplicationTypeVersionResource.properties,
  "The properties of the application type version resource."
);
@@doc(ApplicationTypeVersions.createOrUpdate::parameters.resource,
  "The application type version resource."
);
@@doc(ApplicationTypeVersions.update::parameters.properties,
  "The application type version resource updated tags."
);
