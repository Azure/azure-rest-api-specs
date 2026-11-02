import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Synapse;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkspacePatchInfo.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AvailableRpOperation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OperationResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(
  PrivateEndpointConnectionForPrivateLinkHubBasic.properties
);

@@clientName(Workspaces.createOrUpdate::parameters.resource, "workspaceInfo");
@@clientName(Workspaces.update::parameters.properties, "workspacePatchInfo");
@@clientLocation(Workspaces.getLocationHeaderResult, "Operations");
@@clientLocation(Workspaces.getAzureAsyncHeaderResult, "Operations");
@@clientLocation(Workspaces.replaceAll, "IpFirewallRules");
@@clientName(Workspaces.replaceAll::parameters.body, "request");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Workspace.properties);

@@clientName(PrivateEndpointConnections.create::parameters.resource, "request");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(WorkspaceAadAdminInfos.get, "WorkspaceAadAdmins");
@@clientLocation(WorkspaceAadAdminInfos.createOrUpdate, "WorkspaceAadAdmins");
@@clientName(
  WorkspaceAadAdminInfos.createOrUpdate::parameters.resource,
  "aadAdminInfo"
);
@@clientLocation(WorkspaceAadAdminInfos.delete, "WorkspaceAadAdmins");
@@clientName(
  WorkspaceSqlAadAdmins.createOrUpdate::parameters.resource,
  "aadAdminInfo"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkspaceAadAdminInfo.properties);

@@clientLocation(
  ManagedIdentitySqlControlSettingsModels.get,
  "WorkspaceManagedIdentitySqlControlSettings"
);
@@clientLocation(
  ManagedIdentitySqlControlSettingsModels.createOrUpdate,
  "WorkspaceManagedIdentitySqlControlSettings"
);
@@clientName(
  ManagedIdentitySqlControlSettingsModels.createOrUpdate::parameters.resource,
  "managedIdentitySqlControlSettings"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedIdentitySqlControlSettingsModel.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RestorableDroppedSqlPool.properties);

@@clientName(
  AzureADOnlyAuthentications.create::parameters.resource,
  "AzureADOnlyAuthenticationInfo"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureADOnlyAuthentication.properties);

@@clientLocation(IpFirewallRuleInfos.get, "IpFirewallRules");
@@clientLocation(IpFirewallRuleInfos.createOrUpdate, "IpFirewallRules");
@@clientName(
  IpFirewallRuleInfos.createOrUpdate::parameters.resource,
  "ipFirewallRuleInfo"
);
@@clientLocation(IpFirewallRuleInfos.delete, "IpFirewallRules");
@@clientLocation(IpFirewallRuleInfos.listByWorkspace, "IpFirewallRules");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IpFirewallRuleInfo.properties);

@@clientName(Keys.createOrUpdate::parameters.resource, "keyProperties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Key.properties);

@@clientName(
  PrivateLinkHubs.createOrUpdate::parameters.resource,
  "privateLinkHubInfo"
);
@@clientName(
  PrivateLinkHubs.update::parameters.properties,
  "privateLinkHubPatchInfo"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateLinkHub.properties);

@@clientLocation(
  PrivateEndpointConnectionForPrivateLinkHubs.get,
  "PrivateEndpointConnectionsPrivateLinkHub"
);
@@clientLocation(
  PrivateEndpointConnectionForPrivateLinkHubs.list,
  "PrivateEndpointConnectionsPrivateLinkHub"
);

@@clientLocation(OperationsOperationGroup.checkNameAvailability, "Operations");
