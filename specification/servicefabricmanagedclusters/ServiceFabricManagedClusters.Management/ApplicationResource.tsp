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
model ApplicationResource
  is Azure.ResourceManager.TrackedResource<ApplicationResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationResource,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = ""
  >;

  /**
   * Describes the managed identities for an Azure resource.
   */
  identity?: ManagedIdentity;
}

@armResourceOperations
interface ApplicationResources {
  /**
   * Get a Service Fabric managed application resource created or in the process of being created in the Service Fabric cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Applications_Get")
  get is ArmResourceRead<ApplicationResource>;

  /**
   * Create or update a Service Fabric managed application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("Applications_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @parameterVisibility
  @operationId("Applications_Update")
  update is ArmCustomPatchSync<
    ApplicationResource,
    PatchModel = ApplicationUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Applications_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all managed application resources created or in the process of being created in the Service Fabric cluster resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Applications_List")
  list is ArmResourceListByParent<
    ApplicationResource,
    Response = ArmResponse<ApplicationResourceList>
  >;

  /**
   * Get the status of the latest application upgrade. It will query the cluster to find the status of the latest application upgrade.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("fetchUpgradeStatus")
  @operationId("Applications_ReadUpgrade")
  readUpgrade is ArmResourceActionAsync<ApplicationResource, void, void>;

  /**
   * Send a request to resume the current application upgrade. This will resume the application upgrade from where it was paused.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Applications_ResumeUpgrade")
  resumeUpgrade is ArmResourceActionAsync<
    ApplicationResource,
    RuntimeResumeApplicationUpgradeParameters,
    void
  >;

  /**
   * Send a request to start a rollback of the current application upgrade. This will start rolling back the application to the previous version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Applications_StartRollback")
  startRollback is ArmResourceActionAsync<ApplicationResource, void, void>;
}

@@doc(ApplicationResource.name, "The name of the application resource.");
@@doc(ApplicationResource.properties, "The application resource properties.");
@@doc(ApplicationResources.createOrUpdate::parameters.resource,
  "The application resource."
);
@@doc(ApplicationResources.update::parameters.properties,
  "The application resource updated tags."
);
@@doc(ApplicationResources.resumeUpgrade::parameters.body,
  "The parameters for resuming an application upgrade."
);
