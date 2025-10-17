import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Compute, "ComputeManagementClient", "javascript");
@@clientName(Microsoft.Compute.NetworkApiVersion.`2020-11-01`,
  "TwoThousandTwenty1101",
  "javascript"
);
@@clientName(Microsoft.Compute.NetworkApiVersion.`2022-11-01`,
  "TwoThousandTwentyTwo1101",
  "javascript"
);
