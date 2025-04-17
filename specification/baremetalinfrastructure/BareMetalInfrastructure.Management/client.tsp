import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.BareMetalInfrastructure;

@@clientName(AzureBareMetalInstances.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(AzureBareMetalInstances.update::parameters.properties,
  "tagsParameter"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureBareMetalInstance.properties);

@@clientName(AzureBareMetalStorageInstances.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(AzureBareMetalStorageInstances.update::parameters.properties,
  "azureBareMetalStorageInstanceBodyParameter"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureBareMetalStorageInstance.properties);
