import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

@@clientLocation(VMSizeResources.get, "UnsupportedVmSizes");
@@clientLocation(VMSizeResources.list, "UnsupportedVmSizes");

@@clientName(Clusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(Clusters.update::parameters.properties, "parameters");
@@clientName(Clusters.listUpgradableVersions::parameters.body,
  "versionsDescription"
);

@@clientLocation(ApplicationTypeResources.get, "ApplicationTypes");
@@clientLocation(ApplicationTypeResources.createOrUpdate, "ApplicationTypes");
@@clientLocation(ApplicationTypeResources.delete, "ApplicationTypes");
@@clientLocation(ApplicationTypeResources.list, "ApplicationTypes");
@@clientName(ApplicationTypeResources.createOrUpdate::parameters.resource,
  "parameters"
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

@@clientLocation(ApplicationResources.get, "Applications");
@@clientLocation(ApplicationResources.createOrUpdate, "Applications");
@@clientLocation(ApplicationResources.update, "Applications");
@@clientLocation(ApplicationResources.delete, "Applications");
@@clientLocation(ApplicationResources.list, "Applications");
@@clientName(ApplicationResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApplicationResources.update::parameters.properties, "parameters");

@@clientLocation(ServiceResources.get, "Services");
@@clientLocation(ServiceResources.createOrUpdate, "Services");
@@clientLocation(ServiceResources.update, "Services");
@@clientLocation(ServiceResources.delete, "Services");
@@clientLocation(ServiceResources.list, "Services");
@@clientName(ServiceResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ServiceResources.update::parameters.properties, "parameters");

@@clientLocation(ClusterVersionsOperationGroup.get, "ClusterVersions");
@@clientLocation(ClusterVersionsOperationGroup.getByEnvironment,
  "ClusterVersions"
);
@@clientLocation(ClusterVersionsOperationGroup.list, "ClusterVersions");
@@clientLocation(ClusterVersionsOperationGroup.listByEnvironment,
  "ClusterVersions"
);

@@clientName(ClusterCodeVersions, "ClusterCodeVersionsResult");
