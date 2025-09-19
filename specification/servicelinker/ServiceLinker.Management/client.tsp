import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceLinker;

@@clientName(Linkers, "LinkersOperations", "java");
@@clientName(Microsoft.ServiceLinker,
  "ServiceLinkerManagementClient",
  "javascript"
);
@@clientName(Microsoft.ServiceLinker,
  "ServiceLinkerManagementClient",
  "python"
);

// Go SDK Breaking Changes Resolution for TypeSpec conversion
@@clientName(DatabaseAadAuthInfo, "DatabaseAADAuthInfo", "go");

@@clientName(ActionType, "ActionTypeFlag");
