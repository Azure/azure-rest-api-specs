import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Microsoft.SerialConsole;
using Azure.ClientGenerator.Core;
using TypeSpec.Rest;

@@clientName(
  Microsoft.SerialConsole,
  "MicrosoftSerialConsoleClient",
  "javascript,python,go"
);

@@clientLocation(
  Microsoft.SerialConsole.SerialConsoleOperationGroup.disableConsole,
  Microsoft.SerialConsole,
  "go,javascript,python"
);
@@clientLocation(
  Microsoft.SerialConsole.SerialConsoleOperationGroup.enableConsole,
  Microsoft.SerialConsole,
  "go,javascript,python"
);

@@clientName(SerialConsoleOperationsValueItem, "SerialConsoleOperationInfo", "csharp");
@@clientName(SerialConsoleOperationsValueItemDisplay, "SerialConsoleOperationDisplay", "csharp");
@@clientName(SerialPorts.listBySubscriptions, "GetSerialPorts", "csharp");
@@alternateType(SerialConsoleOperationsValueItem.isDataAction, boolean, "csharp");
@@segment(ParentResourceParameters.resourceGroupName, "resourceGroups");

@@alternateType(getConsoleStatus::parameters.default, "default", "csharp");
