import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataReplication;
@doc("Replication extension model.")
@parentResource(VaultModel)
model ReplicationExtensionModel
  is ProxyResource<ReplicationExtensionModelProperties> {
  @doc("The replication extension name.")
  @pattern("^[a-zA-Z0-9]*$")
  @key("replicationExtensionName")
  @segment("replicationExtensions")
  name: string;
}

@armResourceOperations
@projectedName("client", "ReplicationExtension")
interface ReplicationExtensionModels_ReplicationExtension {
  @doc("Gets the details of the replication extension.")
  get is ArmResourceRead<ReplicationExtensionModel>;

  @doc("Creates the replication extension in the given vault.")
  create is ArmResourceCreateOrUpdateAsync<ReplicationExtensionModel>;

  @doc("Deletes the replication extension in the given vault.")
  delete is ArmResourceDeleteWithoutOkAsync<ReplicationExtensionModel>;

  @doc("Gets the list of replication extensions in the given vault.")
  list is ArmResourceListByParent<ReplicationExtensionModel>;
}
