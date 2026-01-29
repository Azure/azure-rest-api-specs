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

  /**
   * ETag of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: Azure.Core.eTag;
}

@armResourceOperations
interface ApiManagementWorkspaceLinksResources {
  /**
   * Gets an API Management WorkspaceLink resource description.
   */
  get is ArmResourceRead<ApiManagementWorkspaceLinksResource>;

  /**
   * List all API Management workspaceLinks for a service.
   */
  listByService is ArmResourceListByParent<
    ApiManagementWorkspaceLinksResource,
    Response = ArmResponse<ApiManagementWorkspaceLinksListResult>
  >;
}

@@maxLength(ApiManagementWorkspaceLinksResource.name, 80);
@@minLength(ApiManagementWorkspaceLinksResource.name, 1);
@@doc(ApiManagementWorkspaceLinksResource.name,
  "Workspace identifier. Must be unique in the current API Management service instance."
);
@@encodedName(ApiManagementWorkspaceLinksResource.etag,
  "application/json",
  "etag"
);
@@doc(ApiManagementWorkspaceLinksResource.properties,
  "Properties of the API Management WorkspaceLinks."
);
