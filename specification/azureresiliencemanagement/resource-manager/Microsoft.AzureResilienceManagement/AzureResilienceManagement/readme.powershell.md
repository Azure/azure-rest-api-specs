## PowerShell

These settings apply only when `--powershell` is specified on the command line.

``` yaml $(powershell)
azure-powershell-sdk-type: management-sdk
powershell:
  preview-chk: true
  service-name: AzureResilienceManagement
  root-namespace: Microsoft.Azure.PowerShell.Cmdlets.AzureResilienceManagement
  module-name: Az.AzureResilienceManagement
  subject-prefix: $(service-name)
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
# --- UsagePlans: two `List` endpoints (by-subscription vs by-resource-group)
- from: swagger-document
  where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureResilienceManagement/usagePlans"].get
  transform: $.operationId = "UsagePlans_ListByResourceGroup";

# --- RecoveryPlanActions: six `Validate*` endpoints normalize to just `Validate`.
#      Rename them so each has its own subject, producing distinct cmdlets:
#        Test-AzureResilienceManagementRecoveryPlanFailoverValidation_Validate
#        Test-AzureResilienceManagementRecoveryPlanFailoverCommitValidation_Validate
#        Test-AzureResilienceManagementRecoveryPlanOperationValidation_Validate
#        Test-AzureResilienceManagementRecoveryPlanReprotectValidation_Validate
#        Test-AzureResilienceManagementRecoveryPlanTestFailoverValidation_Validate
#        Test-AzureResilienceManagementRecoveryPlanTestFailoverCleanupValidation_Validate
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
