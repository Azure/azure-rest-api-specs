---
external help file:
Module Name: Az.ResilienceManagement
online version: https://learn.microsoft.com/powershell/module/az.resiliencemanagement/invoke-azresiliencemanagementrecommendgoalassignmentcapacity
schema: 2.0.0
---

# Invoke-AzResilienceManagementRecommendGoalAssignmentCapacity

## SYNOPSIS
Recommends capacity improvements for resources under the goal assignments scope.
Returns AI-powered capacity assessments and recommendations.

## SYNTAX

### RecommendExpanded (Default)
```
Invoke-AzResilienceManagementRecommendGoalAssignmentCapacity -GoalAssignmentName <String>
 -ServiceGroupName <String> -ResourceIds <String[]> [-AsJob] [-NoWait] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### Recommend
```
Invoke-AzResilienceManagementRecommendGoalAssignmentCapacity -GoalAssignmentName <String>
 -ServiceGroupName <String> -Body <IRecommendCapacityRequest> [-AsJob] [-NoWait] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### RecommendViaIdentity
```
Invoke-AzResilienceManagementRecommendGoalAssignmentCapacity -InputObject <IResilienceManagementIdentity>
 -Body <IRecommendCapacityRequest> [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### RecommendViaIdentityExpanded
```
Invoke-AzResilienceManagementRecommendGoalAssignmentCapacity -InputObject <IResilienceManagementIdentity>
 -ResourceIds <String[]> [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

## DESCRIPTION
Recommends capacity improvements for resources under the goal assignments scope.
Returns AI-powered capacity assessments and recommendations.

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
Request body for the recommend capacity action.
Provide specific resource IDs to evaluate, or pass an empty array to let the service automatically select non-resilient resources from the goal assignment.

```yaml
Type: Sample.API.Models.IRecommendCapacityRequest
Parameter Sets: Recommend, RecommendViaIdentity
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
Parameter Sets: Recommend, RecommendExpanded
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
Parameter Sets: RecommendViaIdentity, RecommendViaIdentityExpanded
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

### -ResourceIds
Azure resource IDs to evaluate for resiliency.
Pass an empty array to automatically discover and evaluate non-resilient resources in the service group.
Maximum 50 resources per request.

```yaml
Type: System.String[]
Parameter Sets: RecommendExpanded, RecommendViaIdentityExpanded
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
Parameter Sets: Recommend, RecommendExpanded
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

### Sample.API.Models.IRecommendCapacityRequest

### Sample.API.Models.IResilienceManagementIdentity

## OUTPUTS

### Sample.API.Models.IRecommendCapacityResult

## NOTES

COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.


`BODY <IRecommendCapacityRequest>`: Request body for the recommend capacity action. Provide specific resource IDs to evaluate, or pass an empty array to let the service automatically select non-resilient resources from the goal assignment.
  - `ResourceIds <List<String>>`: Azure resource IDs to evaluate for resiliency. Pass an empty array to automatically discover and evaluate non-resilient resources in the service group. Maximum 50 resources per request.

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

