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
 * Application Live View resource
 */
@parentResource(ServiceResource)
model ApplicationLiveViewResource
  is Azure.ResourceManager.ProxyResource<ApplicationLiveViewProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationLiveViewResource,
    KeyName = "applicationLiveViewName",
    SegmentName = "applicationLiveViews",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;
}

@armResourceOperations
interface ApplicationLiveViewResources {
  /**
   * Get the Application Live  and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationLiveViews_Get")
  get is ArmResourceRead<ApplicationLiveViewResource>;

  /**
   * Create the default Application Live View or update the existing Application Live View.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationLiveViews_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ApplicationLiveViewResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Disable the default Application Live View.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationLiveViews_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationLiveViewResource>;

  /**
   * Handles requests to list all resources in a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationLiveViews_List")
  list is ArmResourceListByParent<
    ApplicationLiveViewResource,
    Response = ArmResponse<ApplicationLiveViewResourceCollection>
  >;
}

@@doc(ApplicationLiveViewResource.name, "The name of Application Live View.");
@@doc(ApplicationLiveViewResource.properties,
  "Application Live View properties payload"
);
@@doc(ApplicationLiveViewResources.createOrUpdate::parameters.resource,
  "Parameters for the update operation"
);
