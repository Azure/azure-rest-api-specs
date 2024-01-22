import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AutoscaleSettingResource.tsp";
import "./AlertRuleResource.tsp";
import "./LogProfileResource.tsp";
import "./DiagnosticSettingsResource.tsp";
import "./DiagnosticSettingsCategoryResource.tsp";
import "./ActionGroupResource.tsp";
import "./MetricAlertResource.tsp";
import "./ScheduledQueryRuleResource.tsp";
import "./VMInsightsOnboardingStatus.tsp";
import "./AzureMonitorPrivateLinkScope.tsp";
import "./PrivateLinkResource.tsp";
import "./PrivateEndpointConnection.tsp";
import "./ScopedResource.tsp";
import "./ActivityLogAlertResource.tsp";
import "./DataCollectionEndpointResource.tsp";
import "./DataCollectionRuleAssociationProxyOnlyResource.tsp";
import "./DataCollectionRuleResource.tsp";
import "./AzureMonitorWorkspaceResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Monitor Management Client
 */
@armProviderNamespace
@service({
  title: "MonitorClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.Insights;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-10-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_10_01: "2022-10-01",

  /**
   * The 2016-03-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2016_03_01: "2016-03-01",

  /**
   * The 2021-05-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_05_01_preview: "2021-05-01-preview",

  /**
   * The 2023-01-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_01_01: "2023-01-01",

  /**
   * The 2015-04-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2015_04_01: "2015-04-01",

  /**
   * The 2018-01-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2018_01_01: "2018-01-01",

  /**
   * The 2021-05-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_05_01: "2021-05-01",

  /**
   * The 2019-03-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2019_03_01: "2019-03-01",

  /**
   * The 2018-03-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2018_03_01: "2018-03-01",

  /**
   * The 2022-06-15 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_06_15: "2022-06-15",

  /**
   * The 2017-12-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2017_12_01_preview: "2017-12-01-preview",

  /**
   * The 2018-11-27-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2018_11_27_preview: "2018-11-27-preview",

  /**
   * The 2021-07-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_07_01_preview: "2021-07-01-preview",

  /**
   * The 2020-10-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2020_10_01: "2020-10-01",

  /**
   * The 2022-06-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_06_01: "2022-06-01",

  /**
   * The 2023-04-03 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_04_03: "2023-04-03",
}
