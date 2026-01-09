import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Commerce;

@@clientName(Microsoft.Commerce, "UsageManagementClient", "python");

@@clientName(Microsoft.Commerce, "UsageManager", "java");

@@alternateType(Microsoft.Commerce.UsageSample.infoFields,
  ClientCustomizations.InfoField,
  "java"
);
