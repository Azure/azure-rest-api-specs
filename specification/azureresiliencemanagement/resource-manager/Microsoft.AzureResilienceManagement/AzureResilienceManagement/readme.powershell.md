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
# --- Flags below mirror azure-powershell/src/readme.azure.noprofile.md.
#     Without azure:true + powershell:true + namespace:, autorest.powershell
#     emits the "sample" template: Module class under Sample.API with only
#     EventListener wired, and no auth handlers. Az.Accounts.Register-AzModule
#     then cannot wire OnNewRequest / GetParameterValue / etc., every call
#     goes out without Authorization, and Register-AzModule silently no-ops.
#     Setting these three flags switches autorest to the management-sdk
#     template that emits Microsoft.Azure.PowerShell.Cmdlets.<Service>.Module
#     with all 10 handlers exposed.
azure: true
powershell: true
namespace: Microsoft.Azure.PowerShell.Cmdlets.ResilienceManagement
azure-powershell-sdk-type: management-sdk
service-name: ResilienceManagement
subject-prefix: AzResilienceManagement
root-namespace: Microsoft.Azure.PowerShell.Cmdlets.ResilienceManagement
module-name: Az.ResilienceManagement
output-folder: $(this-folder)/generated/powershell
clear-output-folder: true
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
# --- CODEGEN BUG WORKAROUND: DrillProperties.errorDetails ---
# autorest.powershell 4.0.674 mis-generates the discriminated subtypes
# (RegionalDrillProperties, ZonalDrillProperties). It renames the flattened
# `errorDetails` property to `ErrorDetail` on the base, then in the subclass
# emits a colliding `ErrorDetail : List<IErrorDetail>` (the flattened `.details`
# sub-list) plus a stray `ErrorDetails : IErrorDetail`. Both fail to match
# the parent interface (CS9333/CS0539/CS0535).
# The property is readOnly / server-populated, so dropping it from the swagger
# for PowerShell codegen is safe — cmdlet users still see the underlying error
# via the operation's failure response, and the model stays clean.
- from: swagger-document
  where: $.definitions.DrillProperties.properties
  transform: >-
    delete $["errorDetails"];

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
