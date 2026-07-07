import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Solutions;

@@clientName(
  Microsoft.Solutions.Operations.list,
  "listOperations",
  "javascript"
);
@@clientName(
  Microsoft.Solutions,
  "ApplicationClient",
  "javascript,python,go,java"
);

@@clientName(Operations.list, "list_operations", "python");
@@clientLocation(Operations.list, Microsoft.Solutions, "python,javascript");
@@clientLocation(JitRequestDefinitions.get, "JitRequests", "python");
@@clientLocation(JitRequestDefinitions.createOrUpdate, "JitRequests", "python");
@@clientLocation(JitRequestDefinitions.update, "JitRequests", "python");
@@clientLocation(JitRequestDefinitions.delete, "JitRequests", "python");
@@clientLocation(
  JitRequestDefinitions.listByResourceGroup,
  "JitRequests",
  "python"
);
@@clientLocation(
  JitRequestDefinitions.listBySubscription,
  "JitRequests",
  "python"
);

@@clientName(
  ApplicationDefinitionOpsById.getById,
  "getByResourceGroup",
  "java"
);
@@clientName(ApplicationDefinitions.get, "getById", "java");
