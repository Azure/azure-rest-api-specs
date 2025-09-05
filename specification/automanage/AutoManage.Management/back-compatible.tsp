import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Automanage;

@@clientLocation(BestPracticesVersionsOperationGroup.listByTenant,
  BestPracticesVersions
);
@@clientName(BestPracticesVersionsOperationGroup.listByTenant, "ListByTenant");

@@clientLocation(BestPractices.listByTenant, BestPractices);
@@clientName(BestPractices.listByTenant, "ListByTenant");

@@clientName(ConfigurationProfiles.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ConfigurationProfiles.update::parameters.properties, "parameters");
@@clientName(ConfigurationProfilesVersions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ConfigurationProfilesVersions.listByResourceGroup,
  ConfigurationProfilesVersions
);
@@clientName(ConfigurationProfilesVersions.listByResourceGroup,
  "ListChildResources"
);

@@clientLocation(ConfigurationProfiles.listByResourceGroup,
  ConfigurationProfiles
);
@@clientName(ConfigurationProfiles.listByResourceGroup, "ListByResourceGroup");

@@clientLocation(ConfigurationProfiles.listBySubscription,
  ConfigurationProfiles
);
@@clientName(ConfigurationProfiles.listBySubscription, "ListBySubscription");

@@clientName(ConfigurationProfileAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ConfigurationProfileHCRPAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ConfigurationProfileHCRPAssignments.listByMachineName,
  ConfigurationProfileAssignments
);
@@clientName(ConfigurationProfileHCRPAssignments.listByMachineName,
  "ListByMachineName"
);

@@clientName(ConfigurationProfileHCIAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ConfigurationProfileHCIAssignments.listByClusterName,
  ConfigurationProfileAssignments
);
@@clientName(ConfigurationProfileHCIAssignments.listByClusterName,
  "ListByClusterName"
);

@@clientLocation(Reports.get, "reports");
@@clientLocation(Reports.listByConfigurationProfileAssignments, "reports");
@@clientName(Reports.listByConfigurationProfileAssignments,
  "ListByConfigurationProfileAssignments"
);

@@clientLocation(ConfigurationProfileAssignmentsOperationGroup.list,
  ConfigurationProfileAssignments
);
@@clientName(ConfigurationProfileAssignmentsOperationGroup.list, "List");

@@clientLocation(ConfigurationProfileAssignments.listBySubscription,
  ConfigurationProfileAssignments
);
@@clientName(ConfigurationProfileAssignments.listBySubscription,
  "ListBySubscription"
);
