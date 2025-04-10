import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Maps;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MapsAccountUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreatorUpdateParameters.properties);

@@clientName(Accounts.createOrUpdate::parameters.resource, "MapsAccount");
@@clientName(Accounts.update::parameters.properties,
  "MapsAccountUpdateParameters"
);
@@clientName(Accounts.listSas::parameters.body, "MapsAccountSasParameters");
@@clientName(Accounts.regenerateKeys::parameters.body, "keySpecification");

@@clientName(Creators.createOrUpdate::parameters.resource, "CreatorResource");
@@clientName(Creators.update::parameters.properties, "CreatorUpdateParameters");
