// Contains overrides to make the Autorest Swagger2.0 back compatible
using Microsoft.IoTOperationsOrchestrator;

<<<<<<< HEAD
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Instance.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Solution.properties,
  "autorest"
);
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Instance.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Solution.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Target.properties,
  "autorest"
);
