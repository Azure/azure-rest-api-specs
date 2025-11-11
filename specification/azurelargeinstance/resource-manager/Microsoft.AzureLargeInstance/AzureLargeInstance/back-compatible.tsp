// Contains overrides to make the Autorest Swagger2.0 back compatible

using Microsoft.AzureLargeInstance;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AzureLargeInstance.properties,
  "autorest"
);

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AzureLargeStorageInstance.properties,
  "autorest"
);
