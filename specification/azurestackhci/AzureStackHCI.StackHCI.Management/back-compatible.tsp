import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureStackHCI;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ArcSettingsPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ArcIdentityResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterPatch.identity);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterIdentityResponse.properties);

@@clientName(QosPolicyOverrides.priorityValue8021Action_Cluster,
  "priorityValue8021ActionCluster"
);
@@clientName(QosPolicyOverrides.priorityValue8021Action_SMB,
  "priorityValue8021ActionSMB"
);
@@clientName(QosPolicyOverrides.bandwidthPercentage_SMB,
  "bandwidthPercentageSMB"
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HCIExtensionProperties.extensionParameters);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HCIExtensionPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateRunProperties.progress);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateProperties.componentVersions);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateProperties.rebootRequired);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateProperties.healthState);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateProperties.healthCheckResult);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateProperties.updateStateProperties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateSummariesProperties.packageVersions);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateSummariesProperties.healthState);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateSummariesProperties.healthCheckResult);

@@clientName(ArcSettings.create::parameters.resource, "arcSetting");
@@clientName(ArcSettings.update::parameters.properties, "arcSetting");

@@clientName(ArcSettings.reconcile::parameters.body,
  "reconcileArcSettingsRequest"
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ArcSetting.properties);

@@clientName(Clusters.create::parameters.resource, "cluster");
@@clientName(Clusters.update::parameters.properties, "cluster");

@@clientName(Clusters.uploadCertificate::parameters.body,
  "uploadCertificateRequest"
);

@@clientName(Clusters.extendSoftwareAssuranceBenefit::parameters.body,
  "softwareAssuranceChangeRequest"
);
@@clientName(Clusters.triggerLogCollection::parameters.body,
  "logCollectionRequest"
);
@@clientName(Clusters.configureRemoteSupport::parameters.body,
  "remoteSupportRequest"
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Cluster.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeploymentSetting.properties);

@@clientName(EdgeDevices.validate::parameters.body, "ValidateRequest");

@@clientName(Extensions.create::parameters.resource, "extension");
@@clientName(Extensions.update::parameters.properties, "extension");
@@clientName(Extensions.upgrade::parameters.body, "extensionUpgradeParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HCIExtension.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Offer.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Publisher.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SecuritySetting.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Sku.properties);

@@clientName(UpdateRuns.put::parameters.resource, "updateRunsProperties");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateRun.properties);

@@clientName(Updates.put::parameters.resource, "updateProperties");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Microsoft.AzureStackHCI.Update.properties);

@@clientName(UpdateSummaries.put::parameters.resource,
  "updateLocationProperties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateSummary.properties);
