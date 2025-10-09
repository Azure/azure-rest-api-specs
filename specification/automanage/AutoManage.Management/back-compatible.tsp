import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Automanage;

@@clientLocation(BestPracticesVersionsOperationGroup.listByTenant,
  BestPracticesVersions
);

@@clientName(ConfigurationProfiles.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ConfigurationProfiles.update::parameters.properties, "parameters");
@@clientName(ConfigurationProfilesVersions.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(ConfigurationProfileAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ConfigurationProfileHCRPAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ConfigurationProfileHCRPAssignments.listByMachineName,
  ConfigurationProfileAssignments
);

@@clientName(ConfigurationProfileHCIAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ConfigurationProfileHCIAssignments.listByClusterName,
  ConfigurationProfileAssignments
);

@@clientLocation(ConfigurationProfileAssignmentsOperationGroup.list,
  ConfigurationProfileAssignments
);

@@clientLocation(ConfigurationProfilesVersions.listByResourceGroup,
  ConfigurationProfiles
);
