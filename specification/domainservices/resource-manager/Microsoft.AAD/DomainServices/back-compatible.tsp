import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AAD;

@@clientName(DomainServices.createOrUpdate::parameters.resource,
  "domainService"
);
@@clientName(DomainServices.update::parameters.properties, "domainService");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DomainService.properties);

@@clientLocation(OuContainers.get, "OuContainer", "!javascript");
@@clientLocation(OuContainers.create, "OuContainer", "!javascript");
@@clientName(OuContainers.create::parameters.resource, "containerAccount");
@@clientLocation(OuContainers.update, "OuContainer", "!javascript");
@@clientName(OuContainers.update::parameters.properties, "containerAccount");
@@clientLocation(OuContainers.delete, "OuContainer", "!javascript");
@@clientLocation(OuContainers.list, "OuContainer", "!javascript");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OuContainer.properties);
@@clientLocation(Operations.list, "DomainServiceOperations");
@@clientLocation(OuContainers.get, "OuContainerOperationGrp", "javascript");
@@clientLocation(OuContainers.create, "OuContainerOperationGrp", "javascript");
@@clientLocation(OuContainers.update, "OuContainerOperationGrp", "javascript");
@@clientLocation(OuContainers.delete, "OuContainerOperationGrp", "javascript");
@@clientLocation(OuContainers.list, "OuContainerOperationGrp", "javascript");
