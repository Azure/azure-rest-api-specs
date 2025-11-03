// Contains overrides to make the Autorest Swagger2.0 back compatible
namespace Microsoft.IoTOperationsDataProcessor;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Dataset.properties,
  "autorest"
);

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Instance.properties,
  "autorest"
);

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Pipeline.properties,
  "autorest"
);
