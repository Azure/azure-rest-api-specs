import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Solutions;

@@clientName(
  Microsoft.Solutions.Operations.list,
  "listOperations",
  "javascript"
);
@@clientName(Microsoft.Solutions, "ApplicationClient", "javascript,go,java");
@@clientName(Microsoft.Solutions, "ManagedApplicationsMgmtClient", "python");

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

@@access(ApplicationDefinitionOpsById.getById, Access.internal, "csharp");
@@access(
  ApplicationDefinitionOpsById.createOrUpdateById,
  Access.internal,
  "csharp"
);
@@access(ApplicationDefinitionOpsById.updateById, Access.internal, "csharp");
@@access(ApplicationDefinitionOpsById.deleteById, Access.internal, "csharp");

@@clientName(JitApproverDefinition, "JitApprover", "csharp");
@@clientName(
  ApplicationPackageLockingPolicyDefinition,
  "ApplicationPackageLockingPolicy",
  "csharp"
);
@@clientName(UpdateAccessDefinition, "UpdateAccessContent", "csharp");
@@clientName(
  ListTokenRequest,
  "ManagedApplicationsListTokenRequestContent",
  "csharp"
);
@@clientName(Resource, "ManagedApplicationResourceInfo", "csharp");
@@clientName(GenericResource, "GenericResourceInfo", "csharp");
