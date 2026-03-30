import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Sql;

@@clientName(SecurityAlertsPolicyState, "SecurityAlertPolicyState", "java");
