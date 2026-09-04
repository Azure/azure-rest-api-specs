---
external help file:
Module Name: Az.ResilienceManagement
online version: https://learn.microsoft.com/powershell/module/az.resiliencemanagement/set-azresiliencemanagementrecoveryplanaction
schema: 2.0.0
---

# Set-AzResilienceManagementRecoveryPlanAction

## SYNOPSIS
This action triggers the failover operation on the recovery orchestration plan for the qualified resources.

## SYNTAX

### FailoverExpanded (Default)
```
Set-AzResilienceManagementRecoveryPlanAction -RecoveryPlanName <String> -ServiceGroupName <String>
 -OperationId <String> [-ExecutionConfigurationUserConsent <String>]
 [-FailoverRequestPropertySelectedResourceIds <String[]>] [-FailoverRequestPropertySourceLocations <String[]>]
 [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### Failover
```
Set-AzResilienceManagementRecoveryPlanAction -RecoveryPlanName <String> -ServiceGroupName <String>
 -OperationId <String> -Body <IFailoverRequest> [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### FailoverViaIdentity
```
Set-AzResilienceManagementRecoveryPlanAction -InputObject <IResilienceManagementIdentity>
 -OperationId <String> -Body <IFailoverRequest> [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### FailoverViaIdentityExpanded
```
Set-AzResilienceManagementRecoveryPlanAction -InputObject <IResilienceManagementIdentity>
 -OperationId <String> [-ExecutionConfigurationUserConsent <String>]
 [-FailoverRequestPropertySelectedResourceIds <String[]>] [-FailoverRequestPropertySourceLocations <String[]>]
 [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

## DESCRIPTION
This action triggers the failover operation on the recovery orchestration plan for the qualified resources.

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
Failover post action request.

```yaml
Type: Sample.API.Models.IFailoverRequest
Parameter Sets: Failover, FailoverViaIdentity
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ExecutionConfigurationUserConsent
User consent for performing recovery action.

```yaml
Type: System.String
Parameter Sets: FailoverExpanded, FailoverViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FailoverRequestPropertySelectedResourceIds
Selected recovery resource Ids to be processed.
If not provided, all qualified resources based on the source location(s) will be processed.

```yaml
Type: System.String[]
Parameter Sets: FailoverExpanded, FailoverViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FailoverRequestPropertySourceLocations
Source locations from where resources to be failed-over.

```yaml
Type: System.String[]
Parameter Sets: FailoverExpanded, FailoverViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Identity Parameter

```yaml
Type: Sample.API.Models.IResilienceManagementIdentity
Parameter Sets: FailoverViaIdentity, FailoverViaIdentityExpanded
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

### -OperationId
A GUID that represents the Long Running OperationId.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecoveryPlanName
The name of the recovery orchestration plan.

```yaml
Type: System.String
Parameter Sets: Failover, FailoverExpanded
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
Parameter Sets: Failover, FailoverExpanded
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

### Sample.API.Models.IFailoverRequest

### Sample.API.Models.IResilienceManagementIdentity

## OUTPUTS

### Sample.API.Models.IRecoveryPlanActionBaseResponse

## NOTES

COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.


`BODY <IFailoverRequest>`: Failover post action request.
  - `[ExecutionConfigurationUserConsent <String>]`: User consent for performing recovery action.
  - `[FailoverRequestPropertySelectedResourceIds <List<String>>]`: Selected recovery resource Ids to be processed. If not provided, all qualified resources based on the source location(s) will be processed.
  - `[FailoverRequestPropertySourceLocations <List<String>>]`: Source locations from where resources to be failed-over.

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

## RELATED LINKS

