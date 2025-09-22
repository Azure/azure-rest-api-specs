import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * A single API Management WorkspaceLinks in List or Get response.
 */
@parentResource(ApiManagementServiceResource)
model ApiManagementWorkspaceLinksResource
  is Azure.ResourceManager.ProxyResource<
    ApiManagementWorkspaceLinksProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ApiManagementWorkspaceLinksResource,
    KeyName = "workspaceId",
    SegmentName = "workspaceLinks",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

@armResourceOperations
interface ApiManagementWorkspaceLinksResources {
  /**
   * Gets an API Management WorkspaceLink resource description.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiManagementWorkspaceLink_Get")
  get is ArmResourceRead<ApiManagementWorkspaceLinksResource>;

  /**
   * List all API Management workspaceLinks for a service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApiManagementWorkspaceLinks_ListByService")
  listByService is ArmResourceListByParent<ApiManagementWorkspaceLinksResource>;
}

@@maxLength(ApiManagementWorkspaceLinksResource.name, 80);
@@minLength(ApiManagementWorkspaceLinksResource.name, 1);
@@doc(ApiManagementWorkspaceLinksResource.name,
  "Workspace identifier. Must be unique in the current API Management service instance."
);
@@encodedName(ApiManagementWorkspaceLinksResource.eTag,
  "application/json",
  "etag"
);
@@doc(ApiManagementWorkspaceLinksResource.properties,
  "Properties of the API Management WorkspaceLinks."
);
