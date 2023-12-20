import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";
import "./DataBoxEdgeAlert.tsp";
import "./BandwidthSchedule.tsp";
import "./DiagnosticProactiveLogCollectionSetting.tsp";
import "./DiagnosticRemoteSupportSetting.tsp";
import "./DataBoxEdgeJob.tsp";
import "./DataBoxEdgeOrder.tsp";
import "./DataBoxEdgeRole.tsp";
import "./DataBoxEdgeRoleAddon.tsp";
import "./MonitoringMetricConfiguration.tsp";
import "./DataBoxEdgeShare.tsp";
import "./DataBoxEdgeStorageAccountCredential.tsp";
import "./DataBoxEdgeStorageAccount.tsp";
import "./DataBoxEdgeStorageContainer.tsp";
import "./DataBoxEdgeTrigger.tsp";
import "./DataBoxEdgeUser.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "DataBoxEdgeManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace Azure.ResourceManager.DataBoxEdge;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_03_01: "2022-03-01",
}
