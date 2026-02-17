import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ArcSettingsPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ArcIdentityResponse.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterPatch.identity);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterIdentityResponse.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExtensionProperties.extensionParameters);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExtensionPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(UpdateRunProperties.progress);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(UpdateProperties.updateStateProperties);

@@clientName(ArcSettings.create::parameters.resource, "arcSetting");
@@clientName(ArcSettings.update::parameters.properties, "arcSetting");
@@clientName(ArcSettings.reconcile::parameters.body,
  "reconcileArcSettingsRequest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Cluster.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DeploymentSetting.properties);

@@clientName(EdgeDevices.validate::parameters.body, "ValidateRequest");

@@clientName(Extensions.create::parameters.resource, "extension");
@@clientName(Extensions.update::parameters.properties, "extension");
@@clientName(Extensions.upgrade::parameters.body, "extensionUpgradeParameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Extension.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Offer.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Publisher.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecuritySetting.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Sku.properties);

@@clientName(UpdateRuns.put::parameters.resource, "updateRunsProperties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(UpdateRun.properties);

@@clientName(Updates.put::parameters.resource, "updateProperties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Microsoft.AzureStackHCI.Update.properties);

@@clientLocation(UpdateSummariesOperationGroup.get, "UpdateSummaries");
@@clientLocation(UpdateSummariesOperationGroup.put, "UpdateSummaries");
@@clientName(UpdateSummariesOperationGroup.put::parameters.resource,
  "updateLocationProperties"
);
@@clientLocation(UpdateSummariesOperationGroup.delete, "UpdateSummaries");
@@clientLocation(UpdateSummariesOperationGroup.list, "UpdateSummaries");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(UpdateSummaries.properties);
@@key(Azure.ResourceManager.Extension.ScopeParameter.scope, "resourceUri");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Cluster.identity);
