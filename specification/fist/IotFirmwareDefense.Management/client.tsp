import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.IoTFirmwareDefense, "IoTFirmwareDefenseMgmt", "python");

@@clientName(Microsoft.IoTFirmwareDefense,
  "IoTFirmwareDefenseMgmtClient",
  "java"
);

@@clientName(Versions.v2024_08_07, "V20250401Preview", "javascript");
