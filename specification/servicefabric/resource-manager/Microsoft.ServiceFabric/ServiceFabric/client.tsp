import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

@@clientName(Clusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(Clusters.update::parameters.properties, "parameters");
@@clientName(Clusters.listUpgradableVersions::parameters.body,
  "versionsDescription"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Cluster.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ClusterUpdateParameters.properties
);

@@clientLocation(ApplicationTypeResources.get, "ApplicationTypes");
@@clientLocation(ApplicationTypeResources.createOrUpdate, "ApplicationTypes");
@@clientLocation(ApplicationTypeResources.delete, "ApplicationTypes");
@@clientLocation(ApplicationTypeResources.list, "ApplicationTypes");
@@clientName(ApplicationTypeResources.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicationTypeResource.properties
);

@@clientLocation(ApplicationTypeVersionResources.get,
  "ApplicationTypeVersions"
);
@@clientLocation(ApplicationTypeVersionResources.createOrUpdate,
  "ApplicationTypeVersions"
);
@@clientLocation(ApplicationTypeVersionResources.delete,
  "ApplicationTypeVersions"
);
@@clientLocation(ApplicationTypeVersionResources.list,
  "ApplicationTypeVersions"
);
@@clientName(ApplicationTypeVersionResources.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicationTypeVersionResource.properties
);

@@clientLocation(ApplicationResources.get, "Applications");
@@clientLocation(ApplicationResources.createOrUpdate, "Applications");
@@clientLocation(ApplicationResources.update, "Applications");
@@clientLocation(ApplicationResources.delete, "Applications");
@@clientLocation(ApplicationResources.list, "Applications");
@@clientName(ApplicationResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApplicationResources.update::parameters.properties, "parameters");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicationResource.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicationResourceUpdate.properties
);

@@clientLocation(ServiceResources.get, "Services");
@@clientLocation(ServiceResources.createOrUpdate, "Services");
@@clientLocation(ServiceResources.update, "Services");
@@clientLocation(ServiceResources.delete, "Services");
@@clientLocation(ServiceResources.list, "Services");
@@clientName(ServiceResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ServiceResources.update::parameters.properties, "parameters");
// TODO: "Cannot flatten property of polymorphic type"
// #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
// @@Azure.ClientGenerator.Core.Legacy.flattenProperty(ServiceResource.properties);
// #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
// @@Azure.ClientGenerator.Core.Legacy.flattenProperty(ServiceResourceUpdate.properties
// );

@@clientLocation(VMSizeResources.get, "UnsupportedVmSizes");
@@clientLocation(VMSizeResources.list, "UnsupportedVmSizes");

@@clientLocation(ClusterVersionsOperationGroup.get, "ClusterVersions");
@@clientLocation(ClusterVersionsOperationGroup.getByEnvironment,
  "ClusterVersions"
);
@@clientLocation(ClusterVersionsOperationGroup.list, "ClusterVersions");
@@clientLocation(ClusterVersionsOperationGroup.listByEnvironment,
  "ClusterVersions"
);

@@clientName(ClusterCodeVersions, "ClusterCodeVersionsResult");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ClusterCodeVersions.properties
);

@@clientName(Microsoft.ServiceFabric,
  "ServiceFabricManagementClient",
  "javascript"
);
