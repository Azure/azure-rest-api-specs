import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Sql;

@@alternateType(SecurityAlertPolicyProperties.state,
  SecurityAlertPolicyState,
  "java"
);
