import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Agent Deployment resource
 */
@parentResource(Project)
model AgentDeploymentResource
  is Azure.ResourceManager.ProxyResource<AgentDeployment, false> {
  ...ResourceNameParameter<
    Resource = AgentDeploymentResource,
    KeyName = "deploymentName",
    SegmentName = "deployments",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AgentDeploymentResources {
  /**
   * Gets an Agent Deployment by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AgentDeployments_Get")
  get is ArmResourceRead<AgentDeploymentResource>;

  /**
   * Creates or updates an Agent Deployment (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AgentDeployments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AgentDeploymentResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = AgentDeploymentResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete Agent Deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AgentDeployments_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<AgentDeploymentResource>;

  /**
   * Lists Agent Deployments in the application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AgentDeployments_List")
  list is ArmResourceListByParent<
    AgentDeploymentResource,
    Parameters = {
      /**
       * Number of agent deployments to be retrieved in a page of results.
       */
      @query("count")
      count?: int32 = 30;

      /**
       * Continuation token for pagination.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Names of agent deployments to retrieve.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "For backward compatibility"
      @query(#{ name: "names", explode: true })
      names?: string[];

      /**
       * Field to order by.
       */
      @query("orderBy")
      orderBy?: string;

      /**
       * Whether to order in ascending order.
       */
      @query("orderByAsc")
      orderByAsc?: boolean;
    },
    Response = ArmResponse<AgentDeploymentResourceArmPaginatedResult>
  >;

  /**
   * Starts an Agent Deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AgentDeployments_Start")
  start is ArmResourceActionSync<AgentDeploymentResource, void, OkResponse>;

  /**
   * Stops an Agent Deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AgentDeployments_Stop")
  stop is ArmResourceActionSync<AgentDeploymentResource, void, OkResponse>;
}

@@doc(AgentDeploymentResource.name,
  "The name of the deployment associated with the Cognitive Services Account"
);
@@doc(AgentDeploymentResource.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(AgentDeploymentResources.createOrUpdate::parameters.resource,
  "Agent Deployment definition object."
);
