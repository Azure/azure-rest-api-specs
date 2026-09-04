---
external help file:
Module Name: Az.ResilienceManagement
online version: https://learn.microsoft.com/powershell/module/az.resiliencemanagement/set-azresiliencemanagementrecoveryplan
schema: 2.0.0
---

# Set-AzResilienceManagementRecoveryPlan

## SYNOPSIS
Update a RecoveryPlan

## SYNTAX

### UpdateExpanded (Default)
```
Set-AzResilienceManagementRecoveryPlan -RecoveryPlanName <String> -ServiceGroupName <String>
 [-Description <String>] [-GroupUniqueId <String>] [-IdentityType <String>]
 [-IdentityUserAssignedIdentities <Hashtable>] [-OrderId <Int32>] [-PlanDescription <String>]
 [-PlanType <String>] [-PostActions <IRecoveryGroupBaseAction[]>] [-PreActions <IRecoveryGroupBaseAction[]>]
 [-RecoveryGroupSettingAdditionalGroups <IRecoveryGroup[]>] [-AsJob] [-NoWait] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### Update
```
Set-AzResilienceManagementRecoveryPlan -RecoveryPlanName <String> -ServiceGroupName <String>
 -Resource <IRecoveryPlan> [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### UpdateViaIdentity
```
Set-AzResilienceManagementRecoveryPlan -InputObject <IResilienceManagementIdentity> -Resource <IRecoveryPlan>
 [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### UpdateViaIdentityExpanded
```
Set-AzResilienceManagementRecoveryPlan -InputObject <IResilienceManagementIdentity> [-Description <String>]
 [-GroupUniqueId <String>] [-IdentityType <String>] [-IdentityUserAssignedIdentities <Hashtable>]
 [-OrderId <Int32>] [-PlanDescription <String>] [-PlanType <String>]
 [-PostActions <IRecoveryGroupBaseAction[]>] [-PreActions <IRecoveryGroupBaseAction[]>]
 [-RecoveryGroupSettingAdditionalGroups <IRecoveryGroup[]>] [-AsJob] [-NoWait] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

## DESCRIPTION
Update a RecoveryPlan

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

### -Description
A description of the recovery orchestration group.

```yaml
Type: System.String
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupUniqueId
A unique id for the recovery orchestration group, which is a GUID.

```yaml
Type: System.String
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IdentityType
Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).

```yaml
Type: System.String
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IdentityUserAssignedIdentities
The set of user assigned identities associated with the resource.
The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}.
The dictionary values can be empty objects ({}) in requests.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
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
Parameter Sets: UpdateViaIdentity, UpdateViaIdentityExpanded
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

### -OrderId
The order ID of the recovery orchestration group.

```yaml
Type: System.Int32
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PlanDescription
A description of the recovery orchestration plan.

```yaml
Type: System.String
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PlanType
The type of the recovery orchestration plan, which can be set during creation but cannot be changed afterward.

```yaml
Type: System.String
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PostActions
Post-actions for the recovery orchestration group.

```yaml
Type: Sample.API.Models.IRecoveryGroupBaseAction[]
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PreActions
Pre-actions for the recovery orchestration group.

```yaml
Type: Sample.API.Models.IRecoveryGroupBaseAction[]
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecoveryGroupSettingAdditionalGroups
Additional recovery orchestration group settings.

```yaml
Type: Sample.API.Models.IRecoveryGroup[]
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecoveryPlanName
The name of the recovery orchestration plan.

```yaml
Type: System.String
Parameter Sets: Update, UpdateExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Resource
Represents a recovery orchestration plan resource in the Azure Resilience Management provider namespace.

```yaml
Type: Sample.API.Models.IRecoveryPlan
Parameter Sets: Update, UpdateViaIdentity
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ServiceGroupName
The name of the service group.

```yaml
Type: System.String
Parameter Sets: Update, UpdateExpanded
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

### Sample.API.Models.IRecoveryPlan

### Sample.API.Models.IResilienceManagementIdentity

## OUTPUTS

### Sample.API.Models.IRecoveryPlan

## NOTES

COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.


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

`POSTACTIONS <IRecoveryGroupBaseAction[]>`: Post-actions for the recovery orchestration group.
  - `Name <String>`: The name of the recovery orchestration group action.
  - `TimeoutInMinutes <Int32>`: The maximum amount of time, in minutes, allowed for the action to complete before it times out.
  - `Type <String>`: The type of the recovery orchestration group action.
  - `[Description <String>]`: A description of the recovery orchestration group action, containing the instructions to be performed during this action.

`PREACTIONS <IRecoveryGroupBaseAction[]>`: Pre-actions for the recovery orchestration group.
  - `Name <String>`: The name of the recovery orchestration group action.
  - `TimeoutInMinutes <Int32>`: The maximum amount of time, in minutes, allowed for the action to complete before it times out.
  - `Type <String>`: The type of the recovery orchestration group action.
  - `[Description <String>]`: A description of the recovery orchestration group action, containing the instructions to be performed during this action.

`RECOVERYGROUPSETTINGADDITIONALGROUPS <IRecoveryGroup[]>`: Additional recovery orchestration group settings.
  - `[Description <String>]`: A description of the recovery orchestration group.
  - `[GroupUniqueId <String>]`: A unique id for the recovery orchestration group, which is a GUID.
  - `[OrderId <Int32?>]`: The order ID of the recovery orchestration group.
  - `[PostActions <List<IRecoveryGroupBaseAction>>]`: Post-actions for the recovery orchestration group.
    - `Name <String>`: The name of the recovery orchestration group action.
    - `TimeoutInMinutes <Int32>`: The maximum amount of time, in minutes, allowed for the action to complete before it times out.
    - `Type <String>`: The type of the recovery orchestration group action.
    - `[Description <String>]`: A description of the recovery orchestration group action, containing the instructions to be performed during this action.
  - `[PreActions <List<IRecoveryGroupBaseAction>>]`: Pre-actions for the recovery orchestration group.

`RESOURCE <IRecoveryPlan>`: Represents a recovery orchestration plan resource in the Azure Resilience Management provider namespace.
  - `[AzureAsyncOperation <String>]`: 
  - `[Description <String>]`: A description of the recovery orchestration group.
  - `[GroupUniqueId <String>]`: A unique id for the recovery orchestration group, which is a GUID.
  - `[IdentityType <String>]`: Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
  - `[IdentityUserAssignedIdentities <IManagedServiceIdentityUserAssignedIdentities>]`: The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
    - `[(Any) <IUserAssignedIdentity>]`: This indicates any property can be added to this object.
  - `[OrderId <Int32?>]`: The order ID of the recovery orchestration group.
  - `[PlanDescription <String>]`: A description of the recovery orchestration plan.
  - `[PlanType <String>]`: The type of the recovery orchestration plan, which can be set during creation but cannot be changed afterward.
  - `[PostActions <List<IRecoveryGroupBaseAction>>]`: Post-actions for the recovery orchestration group.
    - `Name <String>`: The name of the recovery orchestration group action.
    - `TimeoutInMinutes <Int32>`: The maximum amount of time, in minutes, allowed for the action to complete before it times out.
    - `Type <String>`: The type of the recovery orchestration group action.
    - `[Description <String>]`: A description of the recovery orchestration group action, containing the instructions to be performed during this action.
  - `[PreActions <List<IRecoveryGroupBaseAction>>]`: Pre-actions for the recovery orchestration group.
  - `[RecoveryGroupSettingAdditionalGroups <List<IRecoveryGroup>>]`: Additional recovery orchestration group settings.
    - `[Description <String>]`: A description of the recovery orchestration group.
    - `[GroupUniqueId <String>]`: A unique id for the recovery orchestration group, which is a GUID.
    - `[OrderId <Int32?>]`: The order ID of the recovery orchestration group.
    - `[PostActions <List<IRecoveryGroupBaseAction>>]`: Post-actions for the recovery orchestration group.
    - `[PreActions <List<IRecoveryGroupBaseAction>>]`: Pre-actions for the recovery orchestration group.
  - `[RetryAfter <Int32?>]`: 

## RELATED LINKS

