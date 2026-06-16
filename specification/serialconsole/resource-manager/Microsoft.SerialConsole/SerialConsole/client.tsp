import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Microsoft.SerialConsole;
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.SerialConsole,
  "MicrosoftSerialConsoleClient",
  "javascript,python,go"
);

@@clientLocation(Microsoft.SerialConsole.SerialConsoleOperationGroup.disableConsole,
  Microsoft.SerialConsole,
  "go"
);
@@clientLocation(Microsoft.SerialConsole.SerialConsoleOperationGroup.enableConsole,
  Microsoft.SerialConsole,
  "go"
);
