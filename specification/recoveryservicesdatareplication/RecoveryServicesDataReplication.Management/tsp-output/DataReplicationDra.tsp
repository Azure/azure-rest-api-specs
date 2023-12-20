import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataReplicationFabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServicesDataReplication;
@doc("Dra model.")
@parentResource(DataReplicationFabric)
model DataReplicationDra is ProxyResource<DraModelProperties> {
  @doc("The fabric agent (Dra) name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("fabricAgentName")
  @segment("fabricAgents")
  name: string;
}

@armResourceOperations
interface DataReplicationDras {
  @doc("Gets the details of the fabric agent.")
  get is ArmResourceRead<DataReplicationDra>;
  @doc("Creates the fabric agent.")
  create is ArmResourceCreateOrUpdateAsync<DataReplicationDra>;
  @doc("Deletes the fabric agent.")
  delete is ArmResourceDeleteWithoutOkAsync<DataReplicationDra>;
  @doc("Gets the list of fabric agents in the given fabric.")
  list is ArmResourceListByParent<DataReplicationDra>;
}
