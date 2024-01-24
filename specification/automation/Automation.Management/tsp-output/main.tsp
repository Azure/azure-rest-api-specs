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
/**
 * Automation Client
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "AutomationClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.Automation;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2020-01-13-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2020_01_13_preview: "2020-01-13-preview",

  /**
   * The 2021-06-22 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_06_22: "2021-06-22",

  /**
   * The 2019-06-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2019_06_01: "2019-06-01",

  /**
   * The 2018-06-30 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2018_06_30: "2018-06-30",

  /**
   * The 2015-10-31 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2015_10_31: "2015-10-31",

  /**
   * The 2022-01-31 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_01_31: "2022-01-31",

  /**
   * The 2022-02-22 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_02_22: "2022-02-22",
}
