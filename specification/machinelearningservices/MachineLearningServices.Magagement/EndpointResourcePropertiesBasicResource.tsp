import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

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

@armResourceOperations
interface EndpointResourcePropertiesBasicResources {
  /**
   * Gets endpoint resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Endpoint_Get")
  get is ArmResourceRead<EndpointResourcePropertiesBasicResource>;

  /**
   * Create or update endpoint resource with the specified parameters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Endpoint_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    EndpointResourcePropertiesBasicResource,
    Response = ArmResourceUpdatedResponse<EndpointResourcePropertiesBasicResource> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = EndpointResourcePropertiesBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List All the endpoints under this workspace
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Endpoint_List")
  list is ArmResourceListByParent<
    EndpointResourcePropertiesBasicResource,
    Parameters = {
      /**
       * Endpoint type filter
       */
      @query("endpointType")
      endpointType?: EndpointType;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("includeOnlineEndpoints")
      includeOnlineEndpoints?: boolean;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("includeServerlessEndpoints")
      includeServerlessEndpoints?: boolean;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("includeConnections")
      includeConnections?: boolean;

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
    },
    Response = ArmResponse<EndpointResourcePropertiesBasicResourceArmPaginatedResult>
  >;

  /**
   * List keys for the endpoint resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Endpoint_ListKeys")
  listKeys is ArmResourceActionSync<
    EndpointResourcePropertiesBasicResource,
    void,
    ArmResponse<EndpointKeys>
  >;

  /**
   * Get available models under the endpoint resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Endpoint_GetModels")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Endpoint_RegenerateKeys")
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
