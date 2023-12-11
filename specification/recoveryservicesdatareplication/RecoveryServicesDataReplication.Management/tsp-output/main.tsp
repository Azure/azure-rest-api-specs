import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DataReplicationDra.tsp";
import "./DataReplicationEmailConfiguration.tsp";
import "./DataReplicationEvent.tsp";
import "./DataReplicationFabric.tsp";
import "./DataReplicationPolicy.tsp";
import "./DataReplicationProtectedItem.tsp";
import "./DataReplicationRecoveryPoint.tsp";
import "./DataReplicationReplicationExtension.tsp";
import "./DataReplicationVault.tsp";
import "./DataReplicationWorkflow.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Azure Site Recovery Management Service API",
})
@versioned(Versions)
@doc("A first party Azure service enabling the data replication.")
namespace Azure.ResourceManager.RecoveryServicesDataReplication;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_02_16_preview: "2021-02-16-preview",
}
