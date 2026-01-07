import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
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
