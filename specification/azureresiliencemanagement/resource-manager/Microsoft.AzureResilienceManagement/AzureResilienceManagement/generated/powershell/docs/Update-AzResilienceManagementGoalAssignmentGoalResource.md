---
external help file:
Module Name: Az.ResilienceManagement
online version: https://learn.microsoft.com/powershell/module/az.resiliencemanagement/update-azresiliencemanagementgoalassignmentgoalresource
schema: 2.0.0
---

# Update-AzResilienceManagementGoalAssignmentGoalResource

## SYNOPSIS
Refreshes the goal resources under a goal assignment.
This operation scans for new resources under the scope of the assignment.

## SYNTAX

### Refresh (Default)
```
Update-AzResilienceManagementGoalAssignmentGoalResource -GoalAssignmentName <String>
 -ServiceGroupName <String> [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### RefreshViaIdentity
```
Update-AzResilienceManagementGoalAssignmentGoalResource -InputObject <IResilienceManagementIdentity> [-AsJob]
 [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### Update
```
Update-AzResilienceManagementGoalAssignmentGoalResource -GoalAssignmentName <String>
 -ServiceGroupName <String> -Body <IUpdateGoalResourceRequest> [-AsJob] [-NoWait] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### UpdateExpanded
```
Update-AzResilienceManagementGoalAssignmentGoalResource -GoalAssignmentName <String>
 -ServiceGroupName <String> -Resources <IGoalResource[]> [-AsJob] [-NoWait] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### UpdateViaIdentity
```
Update-AzResilienceManagementGoalAssignmentGoalResource -InputObject <IResilienceManagementIdentity>
 -Body <IUpdateGoalResourceRequest> [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### UpdateViaIdentityExpanded
```
Update-AzResilienceManagementGoalAssignmentGoalResource -InputObject <IResilienceManagementIdentity>
 -Resources <IGoalResource[]> [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

## DESCRIPTION
Refreshes the goal resources under a goal assignment.
This operation scans for new resources under the scope of the assignment.

## EXAMPLES

### Example 1: {{ Add title here }}
```powershell
{{ Add code here }}
```

```output
{{ Add output here (remove the output block if the example doesn't have an output) }}
```

{{ Add description here }}

### Example 2: {{ Add title here }}
```powershell
{{ Add code here }}
```

```output
{{ Add output here (remove the output block if the example doesn't have an output) }}
```

{{ Add description here }}

## PARAMETERS

### -AsJob
Run the command as a job

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Body
Request model for update goal resource.

```yaml
Type: Sample.API.Models.IUpdateGoalResourceRequest
Parameter Sets: Update, UpdateViaIdentity
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -GoalAssignmentName
The name of the GoalAssignment

```yaml
Type: System.String
Parameter Sets: Refresh, Update, UpdateExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Identity Parameter

```yaml
Type: Sample.API.Models.IResilienceManagementIdentity
Parameter Sets: RefreshViaIdentity, UpdateViaIdentity, UpdateViaIdentityExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NoWait
Run the command asynchronously

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Resources
List of update goal resource.

```yaml
Type: Sample.API.Models.IGoalResource[]
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServiceGroupName
The name of the service group.

```yaml
Type: System.String
Parameter Sets: Refresh, Update, UpdateExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Sample.API.Models.IResilienceManagementIdentity

### Sample.API.Models.IUpdateGoalResourceRequest

## OUTPUTS

### Sample.API.Models.IRefreshGoalResourcesResponse

### Sample.API.Models.IUpdateGoalResourceResponse

## NOTES

COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.


`BODY <IUpdateGoalResourceRequest>`: Request model for update goal resource.
  - `Resources <List<IGoalResource>>`: List of update goal resource.
    - `[DisasterRecoveryAttestationStatus <String>]`: Flag which depicts whether the Arm resource is manually attested for disaster recovery recommendation.
    - `[DisasterRecoveryGoalParticipation <String>]`: Flag which depicts whether the Arm resource is excluded for disaster recovery recommendation.
    - `[HighAvailabilityAttestationStatus <String>]`: Flag which depicts whether the Arm resource is manually attested for high availability recommendation.
    - `[HighAvailabilityGoalParticipation <String>]`: Flag which depicts whether the Arm resource is excluded for high availability recommendation.
    - `[ResourceArmId <String>]`: Arm Id of resource under the SG for which the extension resource is maintained.
    - `[UserConfirmationForHighAvailability <List<IUserConfirmationItem>>]`: List of user confirmations for high availability solutions.
      - `ConfirmationStatus <String>`: The confirmation status of the high availability solution.
      - `SolutionDisplayName <String>`: The solution display name of the high availability solution.
      - `[ReasonForRequestingConfirmation <String>]`: The reason for requesting user confirmation for the high availability solution.
    - `[ZonalResiliencyAttestationStatus <String>]`: Flag which depicts whether the Arm resource is manually attested for resiliency recommendation.
    - `[ZonalResiliencyGoalParticipation <String>]`: Flag which depicts whether the Arm resource is excluded for resiliency recommendation.
    - `[ZonalResiliencyUserConfirmation <List<IUserConfirmationItem>>]`: List of user confirmations for resiliency solutions.

`INPUTOBJECT <IResilienceManagementIdentity>`: Identity Parameter
  - `[DrillName <String>]`: The name of the Drill
  - `[DrillResourceName <String>]`: The name of the DrillResource (GUID).
  - `[DrillRunName <String>]`: The name of the DrillRun (GUID).
  - `[DrillRunResourceName <String>]`: The unique name (GUID) of the recovery job resource.
  - `[EnrollmentName <String>]`: The name of the enrollment.
  - `[GoalAssignmentName <String>]`: The name of the GoalAssignment
  - `[GoalResourceName <String>]`: The name of the GoalAssignment
  - `[GoalTemplateName <String>]`: The name of the goalTemplate
  - `[Location <String>]`: The name of the Azure region.
  - `[OperationId <String>]`: The ID of an ongoing async operation.
  - `[RecoveryJobName <String>]`: The unique name (GUID) of the recovery job.
  - `[RecoveryJobResourceName <String>]`: The unique name (GUID) of the recovery job resource.
  - `[RecoveryPlanName <String>]`: The name of the recovery orchestration plan.
  - `[RecoveryResourceName <String>]`: The unique name (Guid) of the recovery resource
  - `[ResourceGroupName <String>]`: The name of the resource group. The name is case insensitive.
  - `[ServiceGroupName <String>]`: The name of the service group.
  - `[SubscriptionId <String>]`: The ID of the target subscription. The value must be an UUID.
  - `[UnifiedResilienceItemName <String>]`: The name of the unified resilience item.
  - `[UsagePlanName <String>]`: The name of the usage plan.

`RESOURCES <IGoalResource[]>`: List of update goal resource.
  - `[DisasterRecoveryAttestationStatus <String>]`: Flag which depicts whether the Arm resource is manually attested for disaster recovery recommendation.
  - `[DisasterRecoveryGoalParticipation <String>]`: Flag which depicts whether the Arm resource is excluded for disaster recovery recommendation.
  - `[HighAvailabilityAttestationStatus <String>]`: Flag which depicts whether the Arm resource is manually attested for high availability recommendation.
  - `[HighAvailabilityGoalParticipation <String>]`: Flag which depicts whether the Arm resource is excluded for high availability recommendation.
  - `[ResourceArmId <String>]`: Arm Id of resource under the SG for which the extension resource is maintained.
  - `[UserConfirmationForHighAvailability <List<IUserConfirmationItem>>]`: List of user confirmations for high availability solutions.
    - `ConfirmationStatus <String>`: The confirmation status of the high availability solution.
    - `SolutionDisplayName <String>`: The solution display name of the high availability solution.
    - `[ReasonForRequestingConfirmation <String>]`: The reason for requesting user confirmation for the high availability solution.
  - `[ZonalResiliencyAttestationStatus <String>]`: Flag which depicts whether the Arm resource is manually attested for resiliency recommendation.
  - `[ZonalResiliencyGoalParticipation <String>]`: Flag which depicts whether the Arm resource is excluded for resiliency recommendation.
  - `[ZonalResiliencyUserConfirmation <List<IUserConfirmationItem>>]`: List of user confirmations for resiliency solutions.

## RELATED LINKS

