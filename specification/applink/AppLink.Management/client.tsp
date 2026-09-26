import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.AppLink;

@@clientName(Microsoft.AppLink, "AppNetworkMgmtClient", "python");

@@clientName(
  AvailableVersionProperties.selfManagedVersions,
  "selfManagedVersionDetail",
  "csharp"
);

@@clientName(ProvisioningState, "AppLinkProvisioningState", "csharp");
@@clientName(ClusterType, "AppLinkClusterType", "csharp");
@@clientName(
  EastWestGatewayVisibility,
  "AppLinkEastWestGatewayVisibility",
  "csharp"
);
@@clientName(UpgradeMode, "AppLinkUpgradeMode", "csharp");
@@clientName(UpgradeReleaseChannel, "AppLinkUpgradeReleaseChannel", "csharp");
@@clientName(ConnectivityProfile, "AppLinkConnectivityProfile", "csharp");
@@clientName(UpgradeProfile, "AppLinkUpgradeProfile", "csharp");
@@clientName(ReleaseChannelInfo, "AppLinkReleaseChannelInfo", "csharp");
@@clientName(VersionInfo, "AppLinkVersionInfo", "csharp");
@@clientName(AvailableVersion, "AppLinkAvailableVersion", "csharp");
@@clientName(
  AvailableVersionProperties,
  "AppLinkAvailableVersionProperties",
  "csharp"
);
@@clientName(UpgradeHistory, "AppLinkUpgradeHistory", "csharp");
@@clientName(
  UpgradeHistoryProperties,
  "AppLinkUpgradeHistoryProperties",
  "csharp"
);

@@clientName(
  AvailableVersions.listByLocation,
  "GetAppLinkAvailableVersionsByLocation",
  "csharp"
);
@@clientName(
  UpgradeHistories.listByAppLinkMember,
  "GetAppLinkUpgradeHistories",
  "csharp"
);

@@clientName(UpgradeHistoryProperties.startTimestamp, "startOn", "csharp");
@@clientName(UpgradeHistoryProperties.endTimestamp, "endOn", "csharp");

@@clientName(ClusterType.AKS, "Aks", "csharp");
