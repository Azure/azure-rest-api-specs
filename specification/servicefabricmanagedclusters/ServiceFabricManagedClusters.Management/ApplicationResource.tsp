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
 * The application resource.
 */
@parentResource(ManagedCluster)
model ApplicationResource
  is Azure.ResourceManager.ProxyResource<ApplicationResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationResource,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * Describes the managed identities for an Azure resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Backwards compatibility with existing spec"
  identity?: ManagedIdentity;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility("create", "read")
  location?: string;
}

@armResourceOperations
interface Applications {
  /**
   * Get a Service Fabric managed application resource created or in the process of being created in the Service Fabric cluster resource.
   */
  get is ArmResourceRead<ApplicationResource>;

  /**
   * Create or update a Service Fabric managed application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Day 0 Property"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Day 0 Property"
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ApplicationResource,
    Response = ArmResourceUpdatedResponse<ApplicationResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: ApplicationResource;
    }),
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the tags of an application resource of a given managed cluster.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    ApplicationResource,
    PatchModel = ApplicationUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application resource with the specified name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationResource,
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all managed application resources created or in the process of being created in the Service Fabric cluster resource.
   */
  list is ArmResourceListByParent<
    ApplicationResource,
    Response = ArmResponse<ApplicationResourceList>
  >;

  /**
   * Get the status of the latest application upgrade. It will query the cluster to find the status of the latest application upgrade.
   */
  @action("fetchUpgradeStatus")
  readUpgrade is ArmResourceActionAsync<ApplicationResource, void, never>;

  /**
   * Send a request to resume the current application upgrade. This will resume the application upgrade from where it was paused.
   */
  resumeUpgrade is ArmResourceActionAsync<
    ApplicationResource,
    RuntimeResumeApplicationUpgradeParameters,
    never
  >;

  /**
   * Send a request to start a rollback of the current application upgrade. This will start rolling back the application to the previous version.
   */
  startRollback is ArmResourceActionAsync<ApplicationResource, void, never>;
}

@@doc(ApplicationResource.name, "The name of the application resource.");
@@doc(ApplicationResource.properties, "The application resource properties.");
@@doc(Applications.createOrUpdate::parameters.resource,
  "The application resource."
);
@@doc(Applications.update::parameters.properties,
  "The application resource updated tags."
);
@@doc(Applications.resumeUpgrade::parameters.body,
  "The parameters for resuming an application upgrade."
);
