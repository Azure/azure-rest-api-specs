import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureStackHCI;

@@clientName(QosPolicyOverrides.priorityValue8021Action_Cluster,
  "priorityValue8021ActionCluster"
);
@@clientName(QosPolicyOverrides.priorityValue8021Action_SMB,
  "priorityValue8021ActionSMB"
);
@@clientName(QosPolicyOverrides.bandwidthPercentage_SMB,
  "bandwidthPercentageSMB"
);

@@clientName(ArcSettings.create::parameters.resource, "arcSetting");
@@clientName(ArcSettings.update::parameters.properties, "arcSetting");

@@clientName(ArcSettings.reconcile::parameters.body,
  "reconcileArcSettingsRequest"
);

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
@@clientName(Clusters.changeRing::parameters.body, "changeRingRequest");

@@clientName(EdgeDevices.validate::parameters.body, "ValidateRequest");

@@clientName(Extensions.create::parameters.resource, "extension");
@@clientName(Extensions.update::parameters.properties, "extension");
@@clientName(Extensions.upgrade::parameters.body, "extensionUpgradeParameters");

@@clientName(UpdateRuns.put::parameters.resource, "updateRunsProperties");

@@clientName(Updates.put::parameters.resource, "updateProperties");

@@clientName(UpdateSummaries.put::parameters.resource,
  "updateLocationProperties"
);
