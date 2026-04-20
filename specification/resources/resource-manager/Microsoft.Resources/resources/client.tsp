import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Resources,
  "ResourceManagementClient",
  "javascript,python,java"
);

@@clientName(Microsoft.Resources.ErrorResponse,
  "ResourcesErrorResponse",
  "python"
);
