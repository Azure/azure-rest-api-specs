import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EndpointResourcePropertiesBasicResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

@parentResource(EndpointResourcePropertiesBasicResource)
model EndpointDeploymentResourcePropertiesBasicResource
  is Azure.ResourceManager.ProxyResource<
    EndpointDeploymentResourceProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = EndpointDeploymentResourcePropertiesBasicResource,
    KeyName = "deploymentName",
    SegmentName = "deployments",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
}

@armResourceOperations
interface EndpointDeploymentResourcePropertiesBasicResources {
  /**
   * Get deployments under endpoint resource by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EndpointDeployment_Get")
  get is ArmResourceRead<EndpointDeploymentResourcePropertiesBasicResource>;

  /**
   * Create or update endpoint deployment resource with the specified parameters
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("EndpointDeployment_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    EndpointDeploymentResourcePropertiesBasicResource,
    Response =
      | ArmResourceUpdatedResponse<EndpointDeploymentResourcePropertiesBasicResource>
      | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = EndpointDeploymentResourcePropertiesBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete  endpoint deployment resource by name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EndpointDeployment_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<EndpointDeploymentResourcePropertiesBasicResource>;

  /**
   * Get all the deployments under the endpoint resource scope
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EndpointDeployment_List")
  list is ArmResourceListByParent<
    EndpointDeploymentResourcePropertiesBasicResource,
    Response = ArmResponse<EndpointDeploymentResourcePropertiesBasicResourceArmPaginatedResult>
  >;
}

@@doc(
  EndpointDeploymentResourcePropertiesBasicResource.name,
  "Name of the deployment resource"
);
@@doc(EndpointDeploymentResourcePropertiesBasicResource.properties, "");
@@doc(
  EndpointDeploymentResourcePropertiesBasicResources.createOrUpdate::parameters.resource,
  "deployment object"
);
