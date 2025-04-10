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
 * Dev Tool Portal resource
 */
@parentResource(ServiceResource)
model DevToolPortalResource
  is Azure.ResourceManager.ProxyResource<DevToolPortalProperties> {
  ...ResourceNameParameter<
    Resource = DevToolPortalResource,
    KeyName = "devToolPortalName",
    SegmentName = "DevToolPortals",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;
}

@armResourceOperations
interface DevToolPortalResources {
  /**
   * Get the Application Live  and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevToolPortals_Get")
  get is ArmResourceRead<DevToolPortalResource>;

  /**
   * Create the default Dev Tool Portal or update the existing Dev Tool Portal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevToolPortals_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DevToolPortalResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Disable the default Dev Tool Portal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevToolPortals_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<DevToolPortalResource>;

  /**
   * Handles requests to list all resources in a Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DevToolPortals_List")
  list is ArmResourceListByParent<
    DevToolPortalResource,
    Response = ArmResponse<DevToolPortalResourceCollection>
  >;
}

@@doc(DevToolPortalResource.name, "The name of Dev Tool Portal.");
@@doc(DevToolPortalResource.properties, "Dev Tool Portal properties payload");
@@doc(DevToolPortalResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
