import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
@doc("The agentPool resource definition")
@parentResource(ProvisionedCluster)
model AgentPool is ProxyResource<AgentPoolProperties> {
  @doc("Parameter for the name of the agent pool in the provisioned cluster.")
  @maxLength(12)
  @minLength(3)
  @pattern("^[a-z][a-z0-9]{2,11}$")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  name: string;

  @doc("Extended location pointing to the underlying infrastructure")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface AgentPools {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the specified agent pool in the provisioned cluster")
  @operationId("agentPool_Get")
  get is ArmResourceRead<AgentPool>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates the agent pool in the provisioned cluster")
  @operationId("agentPool_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    AgentPool,
    BaseParameters<AgentPool>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the specified agent pool in the provisioned cluster")
  @operationId("agentPool_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    AgentPool,
    BaseParameters<AgentPool>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of agent pools in the specified provisioned cluster")
  @operationId("agentPool_ListByProvisionedCluster")
  listByProvisionedCluster is ArmResourceListByParent<AgentPool>;
}
