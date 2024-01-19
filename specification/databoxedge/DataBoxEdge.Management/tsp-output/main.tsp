import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";
import "./Alert.tsp";
import "./BandwidthSchedule.tsp";
import "./DiagnosticProactiveLogCollectionSettings.tsp";
import "./DiagnosticRemoteSupportSettings.tsp";
import "./Job.tsp";
import "./Order.tsp";
import "./Role.tsp";
import "./Addon.tsp";
import "./MonitoringMetricConfiguration.tsp";
import "./Share.tsp";
import "./StorageAccountCredential.tsp";
import "./StorageAccount.tsp";
import "./Container.tsp";
import "./Trigger.tsp";
import "./User.tsp";
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
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace Microsoft.DataBoxEdge;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2022-03-01 API version.")
  v2022_03_01: "2022-03-01",
}
