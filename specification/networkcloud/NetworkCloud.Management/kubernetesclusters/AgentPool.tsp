import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./AgentPool_models.tsp";
import "./KubernetesCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the Kubernetes cluster agent pool.
 */
model AgentPoolNameParameter
  is ResourceNameParameter<
    Resource = AgentPool,
    KeyName = "agentPoolName",
    SegmentName = "agentPools",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

/**
 * AgentPool represents the agent pool of Kubernetes cluster.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
@parentResource(KubernetesCluster)
model AgentPool
  is Azure.ResourceManager.TrackedResource<AgentPoolProperties, false> {
  ...AgentPoolNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...ExtendedLocationProperty;
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
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AgentPool>
  >;

  /**
   * Patch the properties of the provided Kubernetes cluster agent pool, or update the tags associated with the Kubernetes cluster agent pool. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    AgentPool,
    PatchModel = AgentPoolPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = AgentPool> &
      ArmLroLocationHeader<FinalResult = AgentPool>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided Kubernetes cluster agent pool.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    AgentPool,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of agent pools for the provided Kubernetes cluster.
   */
  listByKubernetesCluster is ArmResourceListByParent<
    AgentPool,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<AgentPoolList>
  >;
}

@@doc(AgentPool.name, "The name of the Kubernetes cluster agent pool.");
@@doc(AgentPool.properties, "The list of the resource properties.");
@@doc(AgentPools.createOrUpdate::parameters.resource, "The request body.");
@@doc(AgentPools.update::parameters.properties, "The request body.");
