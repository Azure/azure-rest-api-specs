import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Maps;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MapsAccountUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CreatorUpdateParameters.properties);

@@clientName(Accounts.createOrUpdate::parameters.resource, "MapsAccount");
@@clientName(Accounts.update::parameters.properties,
  "MapsAccountUpdateParameters"
);
@@clientName(Accounts.listSas::parameters.body, "MapsAccountSasParameters");
@@clientName(Accounts.regenerateKeys::parameters.body, "keySpecification");

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientName(Creators.createOrUpdate::parameters.resource, "CreatorResource");
@@clientName(Creators.update::parameters.properties, "CreatorUpdateParameters");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkResource.properties);

@@clientLocation(OperationResultOperationGroup.get, "OperationResult");

@@clientLocation(OperationStatusOperationGroup.get, "OperationStatus");

@@clientLocation(Operations.list, "Maps");
@@clientName(Operations.list, "ListOperations");
