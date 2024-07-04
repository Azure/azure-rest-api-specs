import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.AppComplianceAutomation;

@@clientName(Microsoft.AppComplianceAutomation,
  "AppComplianceAutomationMgmt",
  "python"
);
@@access(Operations.list, Access.internal, "csharp");
