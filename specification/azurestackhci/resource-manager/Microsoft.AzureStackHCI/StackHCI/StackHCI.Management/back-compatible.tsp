import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ArcSettingsPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ArcIdentityResponse.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ClusterPatch.identity);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ClusterPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ClusterIdentityResponse.properties);

@@clientName(QosPolicyOverrides.priorityValue8021Action_Cluster,
  "priorityValue8021ActionCluster"
);
@@clientName(QosPolicyOverrides.priorityValue8021Action_SMB,
  "priorityValue8021ActionSMB"
);
@@clientName(QosPolicyOverrides.bandwidthPercentage_SMB,
  "bandwidthPercentageSMB"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExtensionProperties.extensionParameters);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExtensionPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateRunProperties.progress);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateProperties.componentVersions);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateProperties.rebootRequired);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateProperties.healthState);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateProperties.healthCheckResult);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateProperties.updateStateProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateSummariesProperties.packageVersions);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateSummariesProperties.healthState);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateSummariesProperties.healthCheckResult);

@@clientName(ArcSettings.create::parameters.resource, "arcSetting");
@@clientName(ArcSettings.update::parameters.properties, "arcSetting");
@@clientName(ArcSettings.reconcile::parameters.body,
  "reconcileArcSettingsRequest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ArcSetting.properties);

@@clientName(Clusters.create::parameters.resource, "cluster");
@@clientName(Clusters.update::parameters.properties, "cluster");
@@clientName(Clusters.uploadCertificate::parameters.body,
  "uploadCertificateRequest"
);
@@clientName(Clusters.extendSoftwareAssuranceBenefit::parameters.body,
  "softwareAssuranceChangeRequest"
);
@@clientName(Clusters.changeRing::parameters.body, "changeRingRequest");
@@clientName(Clusters.triggerLogCollection::parameters.body,
  "logCollectionRequest"
);
@@clientName(Clusters.configureRemoteSupport::parameters.body,
  "remoteSupportRequest"
);
@@clientLocation(Clusters.listByCluster, Offers);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Cluster.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DeploymentSetting.properties);

@@clientName(EdgeDevices.validate::parameters.body, "ValidateRequest");

@@clientName(Extensions.create::parameters.resource, "extension");
@@clientName(Extensions.update::parameters.properties, "extension");
@@clientName(Extensions.upgrade::parameters.body, "extensionUpgradeParameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Extension.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Offer.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Publisher.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SecuritySetting.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Sku.properties);

@@clientName(UpdateRuns.put::parameters.resource, "updateRunsProperties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateRun.properties);

@@clientName(Updates.put::parameters.resource, "updateProperties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Microsoft.AzureStackHCI.Update.properties);

@@clientLocation(UpdateSummariesOperationGroup.get, "UpdateSummaries");
@@clientLocation(UpdateSummariesOperationGroup.put, "UpdateSummaries");
@@clientName(UpdateSummariesOperationGroup.put::parameters.resource,
  "updateLocationProperties"
);
@@clientLocation(UpdateSummariesOperationGroup.delete, "UpdateSummaries");
@@clientLocation(UpdateSummariesOperationGroup.list, "UpdateSummaries");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateSummaries.properties);
@@key(Azure.ResourceManager.Extension.ScopeParameter.scope, "resourceUri");
