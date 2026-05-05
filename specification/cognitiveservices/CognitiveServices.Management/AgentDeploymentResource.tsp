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

alias AgentDeploymentsListParameters = {
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
};

/**
 * Agent Deployment resource
 */
@parentResource(Project)
model AgentDeployment
  is Azure.ResourceManager.ProxyResource<AgentDeploymentProperties, false> {
  ...ResourceNameParameter<
    Resource = AgentDeployment,
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

@armResourceOperations(#{ omitTags: true })
interface AgentDeploymentResources {
  /**
   * Gets an Agent Deployment by name.
   */
  @tag("AgentDeployment")
  get is AgentDeploymentResourcesOps.Read<AgentDeployment>;

  /**
   * Creates or updates an Agent Deployment (asynchronous).
   */
  @tag("AgentDeployment")
  createOrUpdate is AgentDeploymentResourcesOps.CreateOrUpdateAsync<
    AgentDeployment,
    Response = ArmResponse<AgentDeployment> | ArmResourceCreatedResponse<
      AgentDeployment,
      LroHeaders = ArmLroLocationHeader<FinalResult = AgentDeployment> & {
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
  @tag("AgentDeployment")
  delete is AgentDeploymentResourcesOps.DeleteWithoutOkAsync<AgentDeployment>;

  /**
   * Lists Agent Deployments in the application.
   */
  @tag("AgentDeployment")
  list is AgentDeploymentResourcesOps.List<
    AgentDeployment,
    Parameters = AgentDeploymentsListParameters,
    Response = ArmResponse<AgentDeploymentResourceArmPaginatedResult>
  >;

  /**
   * Starts an Agent Deployment.
   */
  @tag("AgentDeployment")
  start is AgentDeploymentResourcesOps.ActionSync<
    AgentDeployment,
    void,
    OkResponse
  >;

  /**
   * Stops an Agent Deployment.
   */
  @tag("AgentDeployment")
  stop is AgentDeploymentResourcesOps.ActionSync<
    AgentDeployment,
    void,
    OkResponse
  >;
}

@@doc(AgentDeployment.name,
  "The name of the deployment associated with the Cognitive Services Account"
);
@@doc(AgentDeployment.properties,
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
