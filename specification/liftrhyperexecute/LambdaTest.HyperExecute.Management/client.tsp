import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(LambdaTest.HyperExecute,
  "LambdaTestHyperExecuteMgmtClient",
  "java"
);
@@clientName(LambdaTest.HyperExecute,
  "LambdaTestHyperExecuteMgmtClient",
  "python"
);
