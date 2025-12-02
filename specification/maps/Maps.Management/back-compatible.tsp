import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Maps;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MapsAccountUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientName(Creators.createOrUpdate::parameters.resource, "CreatorResource");
@@clientName(Creators.update::parameters.properties, "CreatorUpdateParameters");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateLink.properties);

@@clientLocation(OperationResultOperationGroup.get, "OperationResult");

@@clientLocation(OperationStatusOperationGroup.get, "OperationStatus");

@@operationId(Operations.list, "Maps_ListOperations");
