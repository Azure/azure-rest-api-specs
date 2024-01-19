import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedClusters.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
@doc("The agentPool resource definition")
@parentResource(ProvisionedClusters)
model AgentPool is TrackedResource<AgentPoolProperties> {
  @doc("Parameter for the name of the agent pool in the provisioned cluster")
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @path
  @key("agentPoolName")
  @segment("agentPools")
  name: string;

  @doc("Extended Location definition")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface AgentPools {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the agent pool in the Hybrid AKS provisioned cluster instance")
  @operationId("agentPool_Get")
  get is ArmResourceRead<AgentPool>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates the agent pool in the Hybrid AKS provisioned cluster instance")
  @operationId("agentPool_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    AgentPool,
    BaseParameters<AgentPool>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the agent pool in the Hybrid AKS provisioned cluster instance")
  @operationId("agentPool_Update")
  update is ArmCustomPatchAsync<
    AgentPool,
    AgentPoolPatch,
    BaseParameters<AgentPool>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the agent pool in the Hybrid AKS provisioned cluster instance")
  @operationId("agentPool_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    AgentPool,
    BaseParameters<AgentPool>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the agent pools in the Hybrid AKS provisioned cluster instance")
  @operationId("agentPool_ListByProvisionedCluster")
  listByProvisionedCluster is ArmResourceListByParent<AgentPool>;
}

@@projectedName(AgentPools.createOrUpdate::parameters.resource,
  "json",
  "agentPool"
);
@@extension(AgentPools.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "agentPool"
);
@@doc(AgentPools.createOrUpdate::parameters.resource, "");
@@projectedName(AgentPools.update::parameters.properties, "json", "agentPool");
@@extension(AgentPools.update::parameters.properties,
  "x-ms-client-name",
  "agentPool"
);
@@doc(AgentPools.update::parameters.properties, "");
