import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
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
@@clientName(Application, "ManagedApplication", "csharp");
@@clientName(Resource, "ManagedApplicationResourceInfo", "csharp");
@@clientName(GenericResource, "GenericResourceInfo", "csharp");
@@clientName(
  ApplicationJitAccessPolicy.jitAccessEnabled,
  "IsJitAccessEnabled",
  "csharp"
);
@@alternateType(
  ApplicationJitAccessPolicy.maximumJitAccessDuration,
  duration,
  "csharp"
);
@@clientName(ApplicationPatchable, "ApplicationPatch", "csharp");
@@clientName(PlanPatchable, "ManagedApplicationsPlanPatch", "csharp");
@@clientName(Status, "JitRequestStatus", "csharp");
@@clientName(Substatus, "JitRequestSubstatus", "csharp");
@@clientName(RegistryPackage, "ManagedApplicationsRegistryPackage", "csharp");
@@clientName(
  RegistryPackageLinks,
  "ManagedApplicationsRegistryPackageLinks",
  "csharp"
);
@@clientName(
  RegistryPackagePlan,
  "ManagedApplicationsRegistryPackagePlan",
  "csharp"
);
@@alternateType(
  Identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);

@@alternateType(Resource.id, armResourceIdentifier, "csharp");
@@alternateType(
  ApplicationProperties.managedResourceGroupId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ApplicationProperties.applicationDefinitionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ApplicationPropertiesPatchable.managedResourceGroupId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ApplicationPropertiesPatchable.applicationDefinitionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  JitRequestProperties.applicationResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ApplicationDefinitionProperties.storageAccountId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ApplicationPolicy.policyDefinitionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ApplicationAuthorization.roleDefinitionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  JitAuthorizationPolicies.roleDefinitionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedIdentityToken.resourceId,
  armResourceIdentifier,
  "csharp"
);
