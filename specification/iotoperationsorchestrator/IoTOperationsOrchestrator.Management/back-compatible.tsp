// Contains overrides to make the Autorest Swagger2.0 back compatible
using Microsoft.IoTOperationsOrchestrator;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Instance.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Solution.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Target.properties,
  "autorest"
);
