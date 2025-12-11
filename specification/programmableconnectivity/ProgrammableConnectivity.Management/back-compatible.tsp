import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Microsoft.ProgrammableConnectivity;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Gateway.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OperatorApiConnection.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OperatorApiPlan.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
