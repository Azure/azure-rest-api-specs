import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.AppLink;

@@clientName(Microsoft.AppLink, "AppNetworkMgmtClient", "python");

@@clientName(AvailableVersionProperties.selfManagedVersions,
  "selfManagedVersionDetail",
  "csharp"
);

@@clientName(ProvisioningState, "AppLinkProvisioningState", "csharp");
@@clientName(ClusterType, "AppLinkClusterType", "csharp");
@@clientName(EastWestGatewayVisibility,
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
@@clientName(AvailableVersionProperties,
  "AppLinkAvailableVersionProperties",
  "csharp"
);
@@clientName(UpgradeHistory, "AppLinkUpgradeHistory", "csharp");
@@clientName(UpgradeHistoryProperties,
  "AppLinkUpgradeHistoryProperties",
  "csharp"
);

@@clientName(AvailableVersions.listByLocation,
  "GetAppLinkAvailableVersionsByLocation",
  "csharp"
);
@@clientName(UpgradeHistories.listByAppLinkMember,
  "GetAppLinkUpgradeHistories",
  "csharp"
);

@@clientName(UpgradeHistoryProperties.startTimestamp, "startOn", "csharp");
@@clientName(UpgradeHistoryProperties.endTimestamp, "endOn", "csharp");

@@clientName(ClusterType.AKS, "Aks", "csharp");

@doc("The type used for update operations of the AppLink.")
model AppLinkUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;
}

@@alternateType(Microsoft.AppLink.AppLinks.update::parameters.properties,
  AppLinkUpdate,
  "javascript,go,python,java,csharp"
);

@doc("The updatable properties of the AppLinkMember.")
model AppLinkMemberUpdateProperties {
  @doc("Upgrade profile.")
  upgradeProfile?: UpgradeProfile;

  @doc("Observability profile")
  observabilityProfile?: ObservabilityProfile;

  @doc("Connectivity profile.")
  connectivityProfile?: ConnectivityProfile;
}

@doc("The type used for update operations of the AppLinkMember.")
model AppLinkMemberUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?: AppLinkMemberUpdateProperties;
}

@@alternateType(Microsoft.AppLink.AppLinkMembers.update::parameters.properties,
  AppLinkMemberUpdate,
  "javascript,go,python,java,csharp"
);
