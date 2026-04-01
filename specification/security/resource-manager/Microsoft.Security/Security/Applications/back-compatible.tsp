import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudError.error);

@@clientLocation(Applications.get, "Application");
@@clientLocation(Applications.createOrUpdate, "Application");
@@clientName(Applications.createOrUpdate::parameters.resource, "application");
@@clientLocation(Applications.delete, "Application");
@@clientName(SecurityConnectorApplication.createOrUpdate::parameters.resource,
  "application"
);
@@clientLocation(SecurityConnectorApplication.list,
  "SecurityConnectorApplications"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Application.properties);
