import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * App resource payload
 */
@parentResource(ServiceResource)
model AppResource
  is Azure.ResourceManager.ProxyResource<AppResourceProperties> {
  ...ResourceNameParameter<
    Resource = AppResource,
    KeyName = "appName",
    SegmentName = "apps",
    NamePattern = ""
  >;

  /**
   * The Managed Identity type of the app resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedIdentityProperties;

  /**
   * The GEO location of the application, always the same with its parent resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;
}

@armResourceOperations
interface AppResources {
  /**
   * Get an App and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Apps_Get")
  get is ArmResourceRead<
    AppResource,
    Parameters = {
      /**
       * Indicates whether sync status
       */
      @query("syncStatus")
      syncStatus?: string;
    }
  >;

  /**
   * Create a new App or update an exiting App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("Apps_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AppResource,
    Response = ArmResourceUpdatedResponse<AppResource> | ArmResourceCreatedResponse<
      AppResource,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: AppResource;
    })
  >;

  /**
   * Operation to update an exiting App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("Apps_Update")
  update is ArmCustomPatchAsync<
    AppResource,
    PatchModel = AppResource,
    Response = ArmResponse<AppResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: AppResource;
    })
  >;

  /**
   * Operation to delete an App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Apps_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    AppResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Apps_List")
  list is ArmResourceListByParent<
    AppResource,
    Response = ArmResponse<AppResourceCollection>
  >;

  /**
   * Get an resource upload URL for an App, which may be artifacts or source archive.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Apps_GetResourceUploadUrl")
  getResourceUploadUrl is ArmResourceActionSync<
    AppResource,
    void,
    ArmResponse<ResourceUploadDefinition>
  >;

  /**
   * Set existing Deployment under the app as active
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Apps_SetActiveDeployments")
  setActiveDeployments is ArmResourceActionAsync<
    AppResource,
    ActiveDeploymentCollection,
    ArmResponse<AppResource>
  >;

  /**
   * Check the resource name is valid as well as not in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Apps_ValidateDomain")
  validateDomain is ArmResourceActionSync<
    AppResource,
    CustomDomainValidatePayload,
    ArmResponse<CustomDomainValidateResult>
  >;
}

@@doc(AppResource.name, "The name of the App resource.");
@@doc(AppResource.properties, "Properties of the App resource");
@@doc(AppResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(AppResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@doc(AppResources.setActiveDeployments::parameters.body,
  "A list of Deployment name to be active."
);
@@doc(AppResources.validateDomain::parameters.body,
  "Custom domain payload to be validated"
);
