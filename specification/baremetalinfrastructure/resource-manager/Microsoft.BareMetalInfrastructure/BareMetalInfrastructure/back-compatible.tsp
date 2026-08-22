import "@azure-tools/typespec-client-generator-core";
import "./AzureBareMetalInstance.tsp";
import "./AzureBareMetalStorageInstance.tsp";

using Azure.ClientGenerator.Core;

namespace Microsoft.BareMetalInfrastructure;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AzureBareMetalInstance.properties,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AzureBareMetalStorageInstance.properties,
  "!javascript"
);

@@clientName(AzureBareMetalInstances.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(AzureBareMetalInstances.update::parameters.properties,
  "tagsParameter"
);
@@clientName(AzureBareMetalInstances.restart::parameters.body,
  "forceParameter"
);

@@clientName(AzureBareMetalStorageInstances.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(AzureBareMetalStorageInstances.update::parameters.properties,
  "azureBareMetalStorageInstanceBodyParameter"
);
