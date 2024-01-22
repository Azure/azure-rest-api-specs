import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * App resource payload
 */
@parentResource(ServiceResource)
model AppResource is ProxyResource<AppResourceProperties> {
  /**
   * The name of the App resource.
   */
  @path
  @key("appName")
  @segment("apps")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface AppResources {
  /**
   * Get an App and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Apps_Get")
  get is ArmResourceRead<
    AppResource,
    {
      ...BaseParameters<AppResource>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Apps_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AppResource>;

  /**
   * Operation to update an exiting App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Apps_Update")
  update is ArmCustomPatchAsync<AppResource, AppResource>;

  /**
   * Operation to delete an App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Apps_Delete")
  delete is ArmResourceDeleteAsync<AppResource>;

  /**
   * Handles requests to list all resources in a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Apps_List")
  list is ArmResourceListByParent<AppResource>;

  /**
   * Get an resource upload URL for an App, which may be artifacts or source archive.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Apps_GetResourceUploadUrl")
  getResourceUploadUrl is ArmResourceActionSync<
    AppResource,
    void,
    ResourceUploadDefinition
  >;

  /**
   * Set existing Deployment under the app as active
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Apps_SetActiveDeployments")
  setActiveDeployments is ArmResourceActionAsync<
    AppResource,
    ActiveDeploymentCollection,
    AppResource
  >;

  /**
   * Check the resource name is valid as well as not in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Apps_ValidateDomain")
  validateDomain is ArmResourceActionSync<
    AppResource,
    CustomDomainValidatePayload,
    CustomDomainValidateResult
  >;
}

@@projectedName(AppResources.createOrUpdate::parameters.resource,
  "json",
  "appResource"
);
@@extension(AppResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "appResource"
);
@@doc(AppResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@projectedName(AppResources.update::parameters.properties,
  "json",
  "appResource"
);
@@extension(AppResources.update::parameters.properties,
  "x-ms-client-name",
  "appResource"
);
@@doc(AppResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@projectedName(AppResources.setActiveDeployments::parameters.body,
  "json",
  "activeDeploymentCollection"
);
@@extension(AppResources.setActiveDeployments::parameters.body,
  "x-ms-client-name",
  "activeDeploymentCollection"
);
@@doc(AppResources.setActiveDeployments::parameters.body,
  "A list of Deployment name to be active."
);
@@projectedName(AppResources.validateDomain::parameters.body,
  "json",
  "validatePayload"
);
@@extension(AppResources.validateDomain::parameters.body,
  "x-ms-client-name",
  "validatePayload"
);
@@doc(AppResources.validateDomain::parameters.body,
  "Custom domain payload to be validated"
);
