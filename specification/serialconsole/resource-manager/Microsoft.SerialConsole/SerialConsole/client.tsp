import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Microsoft.SerialConsole;
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.SerialConsole,
  "MicrosoftSerialConsoleClient",
  "javascript,python,go"
);
