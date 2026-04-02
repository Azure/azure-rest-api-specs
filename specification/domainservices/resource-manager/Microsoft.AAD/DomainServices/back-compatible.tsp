import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AAD;

@@clientName(DomainServices.createOrUpdate::parameters.resource,
  "domainService"
);
@@clientName(DomainServices.update::parameters.properties, "domainService");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DomainService.properties);

@@clientLocation(OuContainers.get, "OuContainer");
@@clientLocation(OuContainers.create, "OuContainer");
@@clientName(OuContainers.create::parameters.resource, "containerAccount");
@@clientLocation(OuContainers.update, "OuContainer");
@@clientName(OuContainers.update::parameters.properties, "containerAccount");
@@clientLocation(OuContainers.delete, "OuContainer");
@@clientLocation(OuContainers.list, "OuContainer");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OuContainer.properties);
@@clientLocation(Operations.list, "DomainServiceOperations");
