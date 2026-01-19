import "@azure-tools/typespec-client-generator-core";
import "./GuestSubscription.tsp";
import "./SharedLimit.tsp";

<<<<<<< HEAD
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Microsoft.ComputeLimit.GuestSubscription.properties,
  "autorest"
);
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Microsoft.ComputeLimit.GuestSubscription.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Microsoft.ComputeLimit.SharedLimit.properties,
  "autorest"
);
