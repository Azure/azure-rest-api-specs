import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationTypeResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ServiceFabric;
/**
 * An application type version resource for the specified application type name resource.
 */
@parentResource(ApplicationTypeResource)
model ApplicationTypeVersionResource
  is Azure.ResourceManager.ProxyResource<ApplicationTypeVersionResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationTypeVersionResource,
    KeyName = "version",
    SegmentName = "versions",
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
    Response = ArmResourceUpdatedResponse<ApplicationTypeVersionResource> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ApplicationTypeVersionResource>> & {
      @bodyRoot
      _: ApplicationTypeVersionResource;
    })
  >;

  /**
   * Updates the tags of an application type version resource of a given managed cluster.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ApplicationTypeVersionResource,
    PatchModel = ApplicationTypeVersionUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application type version resource with the specified name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationTypeVersionResource,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse
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

/**
 * The properties of the application type version resource.
 */
model ApplicationTypeVersionResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Day 0 property, keep as string for backwards compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The URL to the application package
   */
  appPackageUrl: string;
}

/**
 * The list of application type version resources for the specified application type name resource.
 */
model ApplicationTypeVersionResourceList
  is Azure.Core.Page<ApplicationTypeVersionResource>;

/**
 * Application type version update request
 */
model ApplicationTypeVersionUpdateParameters {
  /**
   * Application type version update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;
}
