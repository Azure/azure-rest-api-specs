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
interface AgentDeploymentResourcesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of Cognitive Services account. */
        @path
        @segment("accounts")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @minLength(2)
        @maxLength(64)
        accountName: string,

        /**
         * The name of Cognitive Services account's project.
         */
        @path
        @segment("projects")
        @key
        @minLength(2)
        @maxLength(64)
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        projectName: string,

        /**
         * The name of the application associated with the Cognitive Services Account
         */
        @path
        @segment("applications")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        appName: string,
      },
      {
        /**
         * The name of the deployment associated with the Cognitive Services Account
         */
        @path
        @segment("agentDeployments")
        @key
        deploymentName: string,
      }
    > {}

@armResourceOperations
interface AgentDeploymentResources {
  /**
   * Gets an Agent Deployment by name.
   */
  get is AgentDeploymentResourcesOps.Read<AgentDeploymentResource>;

  /**
   * Creates or updates an Agent Deployment (asynchronous).
   */
  createOrUpdate is AgentDeploymentResourcesOps.CreateOrUpdateAsync<
    AgentDeploymentResource,
    Response = ArmResponse<AgentDeploymentResource> | ArmResourceCreatedResponse<
      AgentDeploymentResource,
      LroHeaders = ArmLroLocationHeader<FinalResult = AgentDeploymentResource> & {
        /**
         * URI to poll for asynchronous operation status.
         */
        @header("Azure-AsyncOperation")
        azureAsyncOperation: string;

        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @header("x-ms-async-operation-timeout")
        @format("duration")
        asyncOperationTimeout: string;
      }
    >
  >;

  /**
   * Delete Agent Deployment.
   */
  delete is AgentDeploymentResourcesOps.DeleteWithoutOkAsync<AgentDeploymentResource>;

  /**
   * Lists Agent Deployments in the application.
   */
  list is AgentDeploymentResourcesOps.List<
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
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
      orderByAsc?: boolean = false;
    },
    Response = ArmResponse<AgentDeploymentResourceArmPaginatedResult>
  >;

  /**
   * Starts an Agent Deployment.
   */
  start is AgentDeploymentResourcesOps.ActionSync<
    AgentDeploymentResource,
    void,
    OkResponse
  >;

  /**
   * Stops an Agent Deployment.
   */
  stop is AgentDeploymentResourcesOps.ActionSync<
    AgentDeploymentResource,
    void,
    OkResponse
  >;
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
@@summary(AgentDeploymentResources.get, "Gets an Agent Deployment by name.");
@@summary(AgentDeploymentResources.list,
  "Lists Agent Deployments in the application."
);
@@summary(AgentDeploymentResources.createOrUpdate,
  "Creates or updates an Agent Deployment (asynchronous)."
);
@@summary(AgentDeploymentResources.delete, "Delete Agent Deployment.");
@@summary(AgentDeploymentResources.start, "Starts an Agent Deployment.");
@@summary(AgentDeploymentResources.stop, "Stops an Agent Deployment.");
