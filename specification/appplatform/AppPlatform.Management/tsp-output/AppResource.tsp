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
@doc("App resource payload")
@parentResource(ServiceResource)
model AppResource is ProxyResource<AppResourceProperties> {
  @doc("The name of the App resource.")
  @path
  @key("appName")
  @segment("apps")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface AppResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get an App and its properties.")
  @operationId("Apps_Get")
  get is ArmResourceRead<
    AppResource,
    {
      ...BaseParameters<AppResource>;

      @doc("Indicates whether sync status")
      @query("syncStatus")
      syncStatus?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a new App or update an exiting App.")
  @operationId("Apps_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to update an exiting App.")
  @operationId("Apps_Update")
  update is ArmCustomPatchAsync<AppResource, AppResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to delete an App.")
  @operationId("Apps_Delete")
  delete is ArmResourceDeleteAsync<AppResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a Service.")
  @operationId("Apps_List")
  list is ArmResourceListByParent<AppResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get an resource upload URL for an App, which may be artifacts or source archive.")
  @operationId("Apps_GetResourceUploadUrl")
  getResourceUploadUrl is ArmResourceActionSync<
    AppResource,
    void,
    ResourceUploadDefinition
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Set existing Deployment under the app as active")
  @operationId("Apps_SetActiveDeployments")
  setActiveDeployments is ArmResourceActionAsync<
    AppResource,
    ActiveDeploymentCollection,
    AppResource
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Check the resource name is valid as well as not in use.")
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
