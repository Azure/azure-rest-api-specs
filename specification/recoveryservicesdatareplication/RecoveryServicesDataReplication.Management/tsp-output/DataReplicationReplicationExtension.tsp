import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataReplicationVault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServicesDataReplication;
@doc("Replication extension model.")
@parentResource(DataReplicationVault)
model DataReplicationReplicationExtension
  is ProxyResource<ReplicationExtensionModelProperties> {
  @doc("The replication extension name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("replicationExtensionName")
  @segment("replicationExtensions")
  name: string;
}

@armResourceOperations
interface DataReplicationReplicationExtensions {
  @doc("Gets the details of the replication extension.")
  get is ArmResourceRead<DataReplicationReplicationExtension>;
  @doc("Creates the replication extension in the given vault.")
  create is ArmResourceCreateOrUpdateAsync<DataReplicationReplicationExtension>;
  @doc("Deletes the replication extension in the given vault.")
  delete is ArmResourceDeleteWithoutOkAsync<DataReplicationReplicationExtension>;
  @doc("Gets the list of replication extensions in the given vault.")
  list is ArmResourceListByParent<DataReplicationReplicationExtension>;
}
