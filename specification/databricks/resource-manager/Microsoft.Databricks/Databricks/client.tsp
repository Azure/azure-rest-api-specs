import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Databricks;

@@clientName(Azure.ResourceManager.CommonTypes.ErrorDetail,
  "ArmErrorDetail",
  "python"
);
@@clientName(Microsoft.Databricks,
  "AzureDatabricksManagementClient",
  "python,javascript"
);
@@clientLocation(VirtualNetworkPeerings.get, "VNetPeering", "python");
@@clientLocation(VirtualNetworkPeerings.createOrUpdate,
  "VNetPeering",
  "python"
);
@@clientLocation(VirtualNetworkPeerings.delete, "VNetPeering", "python");
@@clientLocation(VirtualNetworkPeerings.listByWorkspace,
  "VNetPeering",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(WorkspaceDeleteParameters.forceDeletion,
  false,
  "python"
);

@@clientName(Microsoft.Databricks.ErrorDetail, "DatabricksErrorDetail", "java");
@@clientName(Microsoft.Databricks.WorkspaceNoPublicIPBooleanParameter,
  "WorkspaceNoPublicIpBooleanParameter",
  "java"
);
