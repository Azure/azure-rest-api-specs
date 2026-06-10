import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
model BatchJobResource is Azure.ResourceManager.ProxyResource<BatchJob, false> {
  ...ResourceNameParameter<
    Resource = BatchJobResource,
    KeyName = "id",
    SegmentName = "jobs",
    NamePattern = ""
  >;
}

alias BatchJobResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of Azure Machine Learning workspace. */
    @path
    @segment("workspaces")
    @key
    workspaceName: string;

    /** Name of endpoint */
    @path
    @segment("batchEndpoints")
    @key
    endpointName: string;

    /** Name of deployment */
    @path
    @segment("deployments")
    @key
    deploymentName: string;
  },
  {
    /** Identifier for the batch endpoint job. */
    @path
    @segment("jobs")
    @key
    id: string;
  }
>;

@armResourceOperations
interface BatchJobResources {
  /**
   * Gets a batch inference job by name at deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BatchJobDeployment_Get")
  get is BatchJobResourceOps.Read<BatchJobResource>;

  /**
   * Lists batch inference jobs in this deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BatchJobDeployment_List")
  list is BatchJobResourceOps.List<
    BatchJobResource,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    },
    Response = ArmResponse<BatchJobResourceArmPaginatedResult>
  >;
}
alias BatchJobEndpointOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of Azure Machine Learning workspace. */
    @path
    @segment("workspaces")
    @key
    workspaceName: string;

    /** Name of endpoint */
    @path
    @segment("batchEndpoints")
    @key
    endpointName: string;
  },
  {
    /** Identifier for the batch endpoint job. */
    @path
    @segment("jobs")
    @key
    id: string;
  }
>;

@armResourceOperations
interface BatchJobEndpoint {
  /**
   * Gets a batch inference endpoint job by name.
   */
  get is BatchJobEndpointOps.Read<BatchJobResource>;

  /**
   * Lists batch inference endpoint jobs in this endpoint.
   */
  list is BatchJobEndpointOps.List<
    BatchJobResource,
    Parameters = {
      /**
       * Optional filter for jobs related to a specific deployment in the endpoint.
       */
      @query("deployment")
      deployment?: string;

      /**
       * Continuation token for pagination.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    },
    Response = ArmResponse<BatchJobResourceArmPaginatedResult>
  >;
}

@@doc(BatchJobResource.name, "Identifier for the batch endpoint job.");
@@doc(
  BatchJobResource.properties,
  "[Required] Additional attributes of the entity."
);
