import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

alias EndpointResourceListParameters = {
  /**
   * Endpoint type filter
   */
  @query("endpointType")
  endpointType?: EndpointType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @query("includeOnlineEndpoints")
  includeOnlineEndpoints?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @query("includeServerlessEndpoints")
  includeServerlessEndpoints?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Documentation not available in original swagger"
  @query("includeConnections")
  includeConnections?: boolean = false;

  /**
   * Continuation token for pagination.
   */
  @query("$skip")
  $skip?: string;

  /**
   * Whether the endpoint resource will be expand to include deployment information, e.g. $expand=deployments
   */
  @query("$expand")
  $expand?: string;
};

/**
 * EndpointResourcePropertiesBasicResource is a preview-only resource.
 */
@removed(Versions.v2025_12_01)
@parentResource(Workspace)
model EndpointResourcePropertiesBasicResource
  is Azure.ResourceManager.ProxyResource<EndpointResourceProperties, false> {
  ...ResourceNameParameter<
    Resource = EndpointResourcePropertiesBasicResource,
    KeyName = "endpointName",
    SegmentName = "endpoints",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]{2,32}$"
  >;
}

/**
 * EndpointResourcePropertiesBasicResources interface is preview-only.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Resource does not support delete operation"
@removed(Versions.v2025_12_01)
@armResourceOperations
interface EndpointResourcePropertiesBasicResources {
  /**
   * Gets endpoint resource
   */
  @summary("Get endpoint resource")
  get is ArmResourceRead<EndpointResourcePropertiesBasicResource>;

  /**
   * Create or update endpoint resource with the specified parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing API returns additional response codes"
  @summary("Create or update endpoint resource with the specified parameters")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    EndpointResourcePropertiesBasicResource,
    Response = ArmResourceUpdatedResponse<EndpointResourcePropertiesBasicResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = EndpointResourcePropertiesBasicResource>> &
      Azure.Core.Foundations.RetryAfterHeader)
  >;

  /**
   * List All the endpoints under this workspace
   */
  @summary("List All the endpoints under this workspace")
  list is ArmResourceListByParent<
    EndpointResourcePropertiesBasicResource,
    Parameters = EndpointResourceListParameters,
    Response = ArmResponse<EndpointResourcePropertiesBasicResourceArmPaginatedResult>
  >;

  /**
   * List keys for the endpoint resource.
   */
  @summary("List keys for the endpoint resource.")
  listKeys is ArmResourceActionSync<
    EndpointResourcePropertiesBasicResource,
    void,
    ArmResponse<EndpointKeys>
  >;

  /**
   * Get available models under the endpoint resource.
   */
  @summary("Get available models under the endpoint resource.")
  @list
  @get
  @action("models")
  getModels is ArmResourceActionSync<
    EndpointResourcePropertiesBasicResource,
    void,
    ArmResponse<EndpointModels>
  >;

  /**
   * Regenerate account keys
   */
  @summary("Regenerate account keys")
  @action("regenerateKey")
  regenerateKeys is ArmResourceActionSync<
    EndpointResourcePropertiesBasicResource,
    RegenerateServiceAccountKeyContent,
    ArmResponse<AccountApiKeys>
  >;
}

@@doc(EndpointResourcePropertiesBasicResource.name,
  "Name of the endpoint resource."
);
@@doc(EndpointResourcePropertiesBasicResource.properties, "");
@@doc(EndpointResourcePropertiesBasicResources.createOrUpdate::parameters.resource,
  "Endpoint resource object"
);
@@doc(EndpointResourcePropertiesBasicResources.regenerateKeys::parameters.body,
  ""
);
