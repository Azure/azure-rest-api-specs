import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

@@clientLocation(VMSizeResources.get, "UnsupportedVmSizes");
@@clientLocation(VMSizeResources.list, "UnsupportedVmSizes");

@@clientLocation(ApplicationTypeResources.get, "ApplicationTypes");
@@clientLocation(ApplicationTypeResources.createOrUpdate, "ApplicationTypes");
@@clientLocation(ApplicationTypeResources.delete, "ApplicationTypes");
@@clientLocation(ApplicationTypeResources.list, "ApplicationTypes");

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

@@clientLocation(ApplicationResources.get, "Applications");
@@clientLocation(ApplicationResources.createOrUpdate, "Applications");
@@clientLocation(ApplicationResources.update, "Applications");
@@clientLocation(ApplicationResources.delete, "Applications");
@@clientLocation(ApplicationResources.list, "Applications");

@@clientLocation(ServiceResources.get, "Services");
@@clientLocation(ServiceResources.createOrUpdate, "Services");
@@clientLocation(ServiceResources.update, "Services");
@@clientLocation(ServiceResources.delete, "Services");
@@clientLocation(ServiceResources.list, "Services");

@@clientLocation(ClusterVersionsOperationGroup.get, "ClusterVersions");
@@clientLocation(ClusterVersionsOperationGroup.getByEnvironment,
  "ClusterVersions"
);
@@clientLocation(ClusterVersionsOperationGroup.list, "ClusterVersions");
@@clientLocation(ClusterVersionsOperationGroup.listByEnvironment,
  "ClusterVersions"
);
