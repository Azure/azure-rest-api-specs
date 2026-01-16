import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterScopeSettings.properties);

@@clientLocation(ExtensionTypeOperationGroup.get, ExtensionTypes);
@@clientLocation(ExtensionTypeOperationGroup.list, ExtensionTypes);

@@clientLocation(ExtensionTypeVersionForReleaseTrains.getVersion,
  ExtensionTypes
);
@@clientLocation(ExtensionTypeVersionForReleaseTrains.listVersions,
  ExtensionTypes
);
@@clientLocation(ExtensionTypeVersionForReleaseTrainOperationGroup.clusterGetVersion,
  ExtensionTypes
);
@@clientLocation(ExtensionTypeVersionForReleaseTrainOperationGroup.clusterListVersions,
  ExtensionTypes
);
@@visibility(ExtensionTypeVersionsList.value, Lifecycle.Read);
@@visibility(ExtensionTypesList.value, Lifecycle.Read);
