import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Automanage;

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
@@clientName(ConfigurationProfileHCIAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
