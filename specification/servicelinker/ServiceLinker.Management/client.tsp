import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceLinker;

@@clientName(Linkers, "LinkersOperations", "java");
@@clientName(Microsoft.ServiceLinker,
  "ServiceLinkerManagementClient",
  "javascript"
);
