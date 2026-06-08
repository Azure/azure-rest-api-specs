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

@@doc(
  EndpointResourcePropertiesBasicResource.name,
  "Name of the endpoint resource."
);
@@doc(EndpointResourcePropertiesBasicResource.properties, "");
@@doc(
  EndpointResourcePropertiesBasicResources.regenerateKeys::parameters.body,
  ""
);
