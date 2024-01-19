import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Module.tsp";
import "./Module.tsp";
import "./DscNode.tsp";
import "./DscNodeConfiguration.tsp";
import "./DscCompilationJob.tsp";
import "./SourceControl.tsp";
import "./AutomationAccount.tsp";
import "./Certificate.tsp";
import "./Connection.tsp";
import "./ConnectionType.tsp";
import "./Credential.tsp";
import "./JobSchedule.tsp";
import "./Schedule.tsp";
import "./Variable.tsp";
import "./Watcher.tsp";
import "./DscConfiguration.tsp";
import "./Job.tsp";
import "./SoftwareUpdateConfiguration.tsp";
import "./Runbook.tsp";
import "./Webhook.tsp";
import "./HybridRunbookWorker.tsp";
import "./HybridRunbookWorkerGroup.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "AutomationClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("Automation Client")
namespace Microsoft.Automation;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2020-01-13-preview API version.")
  v2020_01_13_preview: "2020-01-13-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2021-06-22 API version.")
  v2021_06_22: "2021-06-22",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2019-06-01 API version.")
  v2019_06_01: "2019-06-01",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2018-06-30 API version.")
  v2018_06_30: "2018-06-30",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2015-10-31 API version.")
  v2015_10_31: "2015-10-31",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2022-01-31 API version.")
  v2022_01_31: "2022-01-31",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2022-02-22 API version.")
  v2022_02_22: "2022-02-22",
}
