## PowerShell

These settings apply only when `--powershell` is specified on the command line.

<!--
Naming conventions (aligned with https://github.com/Azure/azure-powershell
best-practice: module `Az.<Service>`, cmdlets `Verb-Az<Service><Noun>`,
`Azure` prefix dropped from the service name to avoid `Az.AzureXxx` /
`Get-AzureXxx` redundancy).

Result:
  Module   : Az.ResilienceManagement
  Cmdlets  : Get-AzResilienceManagementGoalTemplate,
             Remove-AzResilienceManagementGoalAssignment, ...
-->

``` yaml $(powershell)
azure-powershell-sdk-type: management-sdk
service-name: ResilienceManagement
subject-prefix: AzResilienceManagement
root-namespace: Microsoft.Azure.PowerShell.Cmdlets.ResilienceManagement
module-name: Az.ResilienceManagement
output-folder: $(this-folder)/generated/powershell
preview-chk: true
```

### Directives to disambiguate colliding cmdlet names

The swagger contains several endpoints whose operationIds normalize to the same
`Verb-Subject_Variant` name after AutoRest's regular transforms. Without
intervention this produces cmdlets like `_List1`, `_Validate1`, `_Validate2`,
which are confusing to consumers. The directives below rewrite the
`operationId` for each colliding endpoint so the generated cmdlet name is
self-explanatory.

``` yaml $(powershell)
directive:
# --- UsagePlans: two `List` endpoints (by-subscription vs by-resource-group).
#      AutoRest strips trailing PascalCase words from operationIds when computing
#      the variant name, so `ListBySubscription` / `ListByResourceGroup` /
#      `ListInResourceGroup` all collapse to `_List`, forcing an ugly `_List1`
#      suffix on the second one. Rename the resulting cmdlet variant directly:
#        Get-AzResilienceManagementUsagePlan_List                 (subscription)
#        Get-AzResilienceManagementUsagePlan_ListByResourceGroup  (resource-group)
- where:
    verb: Get
    subject: UsagePlan
    variant: List1
  set:
    variant: ListByResourceGroup

# --- RecoveryPlanActions: six `Validate*` endpoints normalize to just `Validate`.
#      Rename them so each has its own subject, producing distinct cmdlets:
#        Test-AzResilienceManagementRecoveryPlanFailoverValidation_Validate
#        Test-AzResilienceManagementRecoveryPlanFailoverCommitValidation_Validate
#        Test-AzResilienceManagementRecoveryPlanOperationValidation_Validate
#        Test-AzResilienceManagementRecoveryPlanReprotectValidation_Validate
#        Test-AzResilienceManagementRecoveryPlanTestFailoverValidation_Validate
#        Test-AzResilienceManagementRecoveryPlanTestFailoverCleanupValidation_Validate
- from: swagger-document
  where: $.paths["/providers/Microsoft.Management/serviceGroups/{serviceGroupName}/providers/Microsoft.AzureResilienceManagement/recoveryPlans/{recoveryPlanName}/validateForFailover"].post
  transform: $.operationId = "RecoveryPlanFailoverValidation_Validate";

- from: swagger-document
  where: $.paths["/providers/Microsoft.Management/serviceGroups/{serviceGroupName}/providers/Microsoft.AzureResilienceManagement/recoveryPlans/{recoveryPlanName}/validateForFailoverCommit"].post
  transform: $.operationId = "RecoveryPlanFailoverCommitValidation_Validate";

- from: swagger-document
  where: $.paths["/providers/Microsoft.Management/serviceGroups/{serviceGroupName}/providers/Microsoft.AzureResilienceManagement/recoveryPlans/{recoveryPlanName}/validateForOperation"].post
  transform: $.operationId = "RecoveryPlanOperationValidation_Validate";

- from: swagger-document
  where: $.paths["/providers/Microsoft.Management/serviceGroups/{serviceGroupName}/providers/Microsoft.AzureResilienceManagement/recoveryPlans/{recoveryPlanName}/validateForReprotect"].post
  transform: $.operationId = "RecoveryPlanReprotectValidation_Validate";

- from: swagger-document
  where: $.paths["/providers/Microsoft.Management/serviceGroups/{serviceGroupName}/providers/Microsoft.AzureResilienceManagement/recoveryPlans/{recoveryPlanName}/validateForTestFailover"].post
  transform: $.operationId = "RecoveryPlanTestFailoverValidation_Validate";

- from: swagger-document
  where: $.paths["/providers/Microsoft.Management/serviceGroups/{serviceGroupName}/providers/Microsoft.AzureResilienceManagement/recoveryPlans/{recoveryPlanName}/validateForTestFailoverCleanup"].post
  transform: $.operationId = "RecoveryPlanTestFailoverCleanupValidation_Validate";
```

> **Note:** these directives take effect only on the next AutoRest run. The
> module currently checked in on this branch was generated before they were
> added, so its cmdlets still show the `_List1`, `_Validate1..5` numeric
> suffixes. Regenerate with `autorest --powershell readme.md` to apply them.
