import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./KubernetesCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * AgentPool represents the agent pool of Kubernetes cluster.
 */
@parentResource(KubernetesCluster)
model AgentPool is TrackedResource<AgentPoolProperties> {
  /**
   * The name of the Kubernetes cluster agent pool.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  name: string;

  /**
   * The extended location of the cluster associated with the resource.
   */
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface AgentPools {
  /**
   * Get properties of the provided Kubernetes cluster agent pool.
   */
  get is ArmResourceRead<AgentPool>;

  /**
   * Create a new Kubernetes cluster agent pool or update the properties of the existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AgentPool,
    BaseParameters<AgentPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch the properties of the provided Kubernetes cluster agent pool, or update the tags associated with the Kubernetes cluster agent pool. Properties and tag updates can be done independently.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    AgentPool,
    AgentPoolPatchParameters,
    BaseParameters<AgentPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete the provided Kubernetes cluster agent pool.
   */
  delete is ArmResourceDeleteAsync<
    AgentPool,
    BaseParameters<AgentPool>,
    ArmLroLocationHeader
  >;

  /**
   * Get a list of agent pools for the provided Kubernetes cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AgentPools_ListByKubernetesCluster")
  listByKubernetesCluster is ArmResourceListByParent<AgentPool>;
}

@@projectedName(AgentPools.createOrUpdate::parameters.resource,
  "json",
  "agentPoolParameters"
);
@@extension(AgentPools.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "agentPoolParameters"
);
@@doc(AgentPools.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(AgentPools.update::parameters.properties,
  "json",
  "agentPoolUpdateParameters"
);
@@extension(AgentPools.update::parameters.properties,
  "x-ms-client-name",
  "agentPoolUpdateParameters"
);
@@doc(AgentPools.update::parameters.properties, "The request body.");
