import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Microsoft.ProgrammableConnectivity;

@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Gateway.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OperatorApiConnection.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OperatorApiPlan.properties,
  "autorest"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "autorest"
);
