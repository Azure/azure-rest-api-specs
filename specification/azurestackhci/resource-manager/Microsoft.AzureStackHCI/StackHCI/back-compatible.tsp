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

@@clientName(EdgeDevices.validate::parameters.body, "ValidateRequest");

@@clientName(Extensions.create::parameters.resource, "extension");
@@clientName(Extensions.update::parameters.properties, "extension");
@@clientName(Extensions.upgrade::parameters.body, "extensionUpgradeParameters");

@@clientName(UpdateRuns.put::parameters.resource, "updateRunsProperties");

@@clientName(Updates.put::parameters.resource, "updateProperties");

@@clientName(UpdateSummaries.put::parameters.resource,
  "updateLocationProperties"
);

@@path(ResourceUriParameter.resourceUri, "scope");
@@Azure.ResourceManager.CommonTypes.Private.armCommonParameter(ResourceUriParameter.resourceUri,
  "ScopeParameter",
  Azure.ResourceManager.CommonTypes.Versions.v5
);

@@doc(Azure.ResourceManager.ResourceUriParameter.resourceUri,
  "The scope of the operation or resource. Valid scopes are: subscription (format: '/subscriptions/{subscriptionId}'), or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'"
);