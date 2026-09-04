---
external help file:
Module Name: Az.ResilienceManagement
online version: https://learn.microsoft.com/powershell/module/az.resiliencemanagement/add-azresiliencemanagementdrillresource
schema: 2.0.0
---

# Add-AzResilienceManagementDrillResource

## SYNOPSIS
This enables the user to include, exclude or add resources from their Drill.

## SYNTAX

### AddExpanded (Default)
```
Add-AzResilienceManagementDrillResource -DrillName <String> -ServiceGroupName <String> -OperationId <String>
 -FaultDurationInMin <Int32> [-ForceInclusionAndUpdate <String>] [-ResourceListExcludeResources <String[]>]
 [-ResourceListIncludeResources <IIncludeOrUpdateResource[]>]
 [-ResourceListUpdateResources <IIncludeOrUpdateResource[]>] [-AsJob] [-NoWait] [-PassThru] [-Confirm]
 [-WhatIf] [<CommonParameters>]
```

### Add
```
Add-AzResilienceManagementDrillResource -DrillName <String> -ServiceGroupName <String> -OperationId <String>
 -Body <IAddOrUpdateResourcesRequest> [-AsJob] [-NoWait] [-PassThru] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### AddViaIdentity
```
Add-AzResilienceManagementDrillResource -InputObject <IResilienceManagementIdentity> -OperationId <String>
 -Body <IAddOrUpdateResourcesRequest> [-AsJob] [-NoWait] [-PassThru] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### AddViaIdentityExpanded
```
Add-AzResilienceManagementDrillResource -InputObject <IResilienceManagementIdentity> -OperationId <String>
 -FaultDurationInMin <Int32> [-ForceInclusionAndUpdate <String>] [-ResourceListExcludeResources <String[]>]
 [-ResourceListIncludeResources <IIncludeOrUpdateResource[]>]
 [-ResourceListUpdateResources <IIncludeOrUpdateResource[]>] [-AsJob] [-NoWait] [-PassThru] [-Confirm]
 [-WhatIf] [<CommonParameters>]
```

## DESCRIPTION
This enables the user to include, exclude or add resources from their Drill.

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
Request body of the AddOrUpdateResources API.

```yaml
Type: Sample.API.Models.IAddOrUpdateResourcesRequest
Parameter Sets: Add, AddViaIdentity
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -DrillName
The name of the Drill

```yaml
Type: System.String
Parameter Sets: Add, AddExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FaultDurationInMin
Duration of faults.

```yaml
Type: System.Int32
Parameter Sets: AddExpanded, AddViaIdentityExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceInclusionAndUpdate
Whether to allow inclusion and update despite attention reasons.

```yaml
Type: System.String
Parameter Sets: AddExpanded, AddViaIdentityExpanded
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
Parameter Sets: AddViaIdentity, AddViaIdentityExpanded
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

### -PassThru
Returns true when the command succeeds

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

### -ResourceListExcludeResources
Excluded resource

```yaml
Type: System.String[]
Parameter Sets: AddExpanded, AddViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceListIncludeResources
Include resource

```yaml
Type: Sample.API.Models.IIncludeOrUpdateResource[]
Parameter Sets: AddExpanded, AddViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceListUpdateResources
Update resource

```yaml
Type: Sample.API.Models.IIncludeOrUpdateResource[]
Parameter Sets: AddExpanded, AddViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServiceGroupName
The name of the service group.

```yaml
Type: System.String
Parameter Sets: Add, AddExpanded
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

### Sample.API.Models.IAddOrUpdateResourcesRequest

### Sample.API.Models.IResilienceManagementIdentity

## OUTPUTS

### System.Boolean

## NOTES

COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.


`BODY <IAddOrUpdateResourcesRequest>`: Request body of the AddOrUpdateResources API.
  - `FaultDurationInMin <Int32>`: Duration of faults.
  - `[ForceInclusionAndUpdate <String>]`: Whether to allow inclusion and update despite attention reasons.
  - `[ResourceListExcludeResources <List<String>>]`: Excluded resource
  - `[ResourceListIncludeResources <List<IIncludeOrUpdateResource>>]`: Include resource
    - `Id <String>`: Id of the DrillResource to be included (NOT the ARM Id of the underlying resource).
    - `[CustomFaultName <String>]`: fault name
    - `[CustomFaultScriptResourceId <String>]`: ID of ARM resource used for automation (e.g. Automation runbook URL).
    - `[OverriddenDefaultFaultName <String>]`: fault name
    - `[OverriddenDefaultFaultTargetResourceId <String>]`: ARMId of the target resource where fault will be applied. For non-NSG, same as ResourceId. For NSG, its the NSG resource and not the actual resource which is to be simulated for faulting.
    - `[OverriddenDefaultFaultUrn <String>]`: fault urn.
  - `[ResourceListUpdateResources <List<IIncludeOrUpdateResource>>]`: Update resource

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

`RESOURCELISTINCLUDERESOURCES <IIncludeOrUpdateResource[]>`: Include resource
  - `Id <String>`: Id of the DrillResource to be included (NOT the ARM Id of the underlying resource).
  - `[CustomFaultName <String>]`: fault name
  - `[CustomFaultScriptResourceId <String>]`: ID of ARM resource used for automation (e.g. Automation runbook URL).
  - `[OverriddenDefaultFaultName <String>]`: fault name
  - `[OverriddenDefaultFaultTargetResourceId <String>]`: ARMId of the target resource where fault will be applied. For non-NSG, same as ResourceId. For NSG, its the NSG resource and not the actual resource which is to be simulated for faulting.
  - `[OverriddenDefaultFaultUrn <String>]`: fault urn.

`RESOURCELISTUPDATERESOURCES <IIncludeOrUpdateResource[]>`: Update resource
  - `Id <String>`: Id of the DrillResource to be included (NOT the ARM Id of the underlying resource).
  - `[CustomFaultName <String>]`: fault name
  - `[CustomFaultScriptResourceId <String>]`: ID of ARM resource used for automation (e.g. Automation runbook URL).
  - `[OverriddenDefaultFaultName <String>]`: fault name
  - `[OverriddenDefaultFaultTargetResourceId <String>]`: ARMId of the target resource where fault will be applied. For non-NSG, same as ResourceId. For NSG, its the NSG resource and not the actual resource which is to be simulated for faulting.
  - `[OverriddenDefaultFaultUrn <String>]`: fault urn.

## RELATED LINKS

