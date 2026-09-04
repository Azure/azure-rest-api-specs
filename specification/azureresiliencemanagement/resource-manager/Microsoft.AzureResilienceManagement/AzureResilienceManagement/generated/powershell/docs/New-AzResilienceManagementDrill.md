---
external help file:
Module Name: Az.ResilienceManagement
online version: https://learn.microsoft.com/powershell/module/az.resiliencemanagement/new-azresiliencemanagementdrill
schema: 2.0.0
---

# New-AzResilienceManagementDrill

## SYNOPSIS
Create a Drill

## SYNTAX

### CreateExpanded (Default)
```
New-AzResilienceManagementDrill -DrillName <String> -ServiceGroupName <String>
 [-ChaosResourceIdentityForFaultType <String>] [-ChaosResourceIdentityForFaultUserAssignedIdentity <String>]
 [-ChaosResourcePropertiesIdentityType <String>]
 [-ChaosResourcePropertiesIdentityUserAssignedIdentity <String>] [-DrillAssetPropertyRegion <String>]
 [-DrillAssetPropertyResourceGroup <String>] [-DrillAssetPropertySubscription <String>] [-DrillType <String>]
 [-HealthModelMonitoringPropertiesIdentityType <String>]
 [-HealthModelMonitoringPropertiesIdentityUserAssignedIdentity <String>]
 [-HealthModelMonitoringPropertyDiscoveryRuleId <String>] [-IdentityType <String>]
 [-IdentityUserAssignedIdentities <Hashtable>] [-MonitoringPropertiesIdentityType <String>]
 [-MonitoringPropertiesIdentityUserAssignedIdentity <String>] [-RbacSetupMode <String>]
 [-RecoveryPlanPropertiesIdentityType <String>] [-RecoveryPlanPropertiesIdentityUserAssignedIdentity <String>]
 [-SliMonitoringPropertiesIdentityType <String>]
 [-SliMonitoringPropertiesIdentityUserAssignedIdentity <String>]
 [-SliMonitoringPropertySlis <ISliSelection[]>] [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### Create
```
New-AzResilienceManagementDrill -DrillName <String> -ServiceGroupName <String> -Resource <IDrill> [-AsJob]
 [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### CreateViaIdentity
```
New-AzResilienceManagementDrill -InputObject <IResilienceManagementIdentity> -Resource <IDrill> [-AsJob]
 [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### CreateViaIdentityExpanded
```
New-AzResilienceManagementDrill -InputObject <IResilienceManagementIdentity>
 [-ChaosResourceIdentityForFaultType <String>] [-ChaosResourceIdentityForFaultUserAssignedIdentity <String>]
 [-ChaosResourcePropertiesIdentityType <String>]
 [-ChaosResourcePropertiesIdentityUserAssignedIdentity <String>] [-DrillAssetPropertyRegion <String>]
 [-DrillAssetPropertyResourceGroup <String>] [-DrillAssetPropertySubscription <String>] [-DrillType <String>]
 [-HealthModelMonitoringPropertiesIdentityType <String>]
 [-HealthModelMonitoringPropertiesIdentityUserAssignedIdentity <String>]
 [-HealthModelMonitoringPropertyDiscoveryRuleId <String>] [-IdentityType <String>]
 [-IdentityUserAssignedIdentities <Hashtable>] [-MonitoringPropertiesIdentityType <String>]
 [-MonitoringPropertiesIdentityUserAssignedIdentity <String>] [-RbacSetupMode <String>]
 [-RecoveryPlanPropertiesIdentityType <String>] [-RecoveryPlanPropertiesIdentityUserAssignedIdentity <String>]
 [-SliMonitoringPropertiesIdentityType <String>]
 [-SliMonitoringPropertiesIdentityUserAssignedIdentity <String>]
 [-SliMonitoringPropertySlis <ISliSelection[]>] [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

## DESCRIPTION
Create a Drill

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

### -ChaosResourceIdentityForFaultType
Identity type linked with the resource

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChaosResourceIdentityForFaultUserAssignedIdentity
User assigned identity id linked with the resource

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChaosResourcePropertiesIdentityType
Identity type linked with the resource

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChaosResourcePropertiesIdentityUserAssignedIdentity
User assigned identity id linked with the resource

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DrillAssetPropertyRegion
Region where Drill's internal resources will be created.

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DrillAssetPropertyResourceGroup
Resource group where Drill's internal resources will be created.
If not specified, defaults to 'AzureResilienceManagementDrills'.
This value is immutable after drill creation.

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DrillAssetPropertySubscription
Subscription where Drill's internal resources will be created.

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DrillName
The name of the Drill

```yaml
Type: System.String
Parameter Sets: Create, CreateExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DrillType
The discriminator for the Drill object hierarchy.

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HealthModelMonitoringPropertiesIdentityType
Identity type linked with the resource

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HealthModelMonitoringPropertiesIdentityUserAssignedIdentity
User assigned identity id linked with the resource

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HealthModelMonitoringPropertyDiscoveryRuleId
Full ARM Id of the discovery rule inside the Azure Health Model.
The parent Health Model is derived from this Id; it is the only identifier accepted on the wire.

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
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
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
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
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
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
Parameter Sets: CreateViaIdentity, CreateViaIdentityExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -MonitoringPropertiesIdentityType
Identity type linked with the resource

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MonitoringPropertiesIdentityUserAssignedIdentity
User assigned identity id linked with the resource

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### -RbacSetupMode
RBAC setup mode.

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecoveryPlanPropertiesIdentityType
Identity type linked with the resource

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecoveryPlanPropertiesIdentityUserAssignedIdentity
User assigned identity id linked with the resource

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Resource
Drill resource

```yaml
Type: Sample.API.Models.IDrill
Parameter Sets: Create, CreateViaIdentity
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
Parameter Sets: Create, CreateExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SliMonitoringPropertiesIdentityType
Identity type linked with the resource

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SliMonitoringPropertiesIdentityUserAssignedIdentity
User assigned identity id linked with the resource

```yaml
Type: System.String
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SliMonitoringPropertySlis
The SLIs selected for Drill monitoring.
Maximum of two entries: at most one Availability and one Latency.
Duplicate types or duplicate SLI Ids are rejected.

```yaml
Type: Sample.API.Models.ISliSelection[]
Parameter Sets: CreateExpanded, CreateViaIdentityExpanded
Aliases:

Required: False
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

### Sample.API.Models.IDrill

### Sample.API.Models.IResilienceManagementIdentity

## OUTPUTS

### Sample.API.Models.IDrill

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

`RESOURCE <IDrill>`: Drill resource
  - `[AzureAsyncOperation <String>]`: 
  - `[ChaosResourceIdentityForFaultType <String>]`: Identity type linked with the resource
  - `[ChaosResourceIdentityForFaultUserAssignedIdentity <String>]`: User assigned identity id linked with the resource
  - `[ChaosResourcePropertiesIdentityType <String>]`: Identity type linked with the resource
  - `[ChaosResourcePropertiesIdentityUserAssignedIdentity <String>]`: User assigned identity id linked with the resource
  - `[DrillAssetPropertyRegion <String>]`: Region where Drill's internal resources will be created.
  - `[DrillAssetPropertyResourceGroup <String>]`: Resource group where Drill's internal resources will be created. If not specified, defaults to 'AzureResilienceManagementDrills'. This value is immutable after drill creation.
  - `[DrillAssetPropertySubscription <String>]`: Subscription where Drill's internal resources will be created.
  - `[DrillType <String>]`: The discriminator for the Drill object hierarchy.
  - `[HealthModelMonitoringPropertiesIdentityType <String>]`: Identity type linked with the resource
  - `[HealthModelMonitoringPropertiesIdentityUserAssignedIdentity <String>]`: User assigned identity id linked with the resource
  - `[HealthModelMonitoringPropertyDiscoveryRuleId <String>]`: Full ARM Id of the discovery rule inside the Azure Health Model. The parent Health Model is derived from this Id; it is the only identifier accepted on the wire.
  - `[IdentityType <String>]`: Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
  - `[IdentityUserAssignedIdentities <IManagedServiceIdentityUserAssignedIdentities>]`: The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
    - `[(Any) <IUserAssignedIdentity>]`: This indicates any property can be added to this object.
  - `[MonitoringPropertiesIdentityType <String>]`: Identity type linked with the resource
  - `[MonitoringPropertiesIdentityUserAssignedIdentity <String>]`: User assigned identity id linked with the resource
  - `[RbacSetupMode <String>]`: RBAC setup mode.
  - `[RecoveryPlanPropertiesIdentityType <String>]`: Identity type linked with the resource
  - `[RecoveryPlanPropertiesIdentityUserAssignedIdentity <String>]`: User assigned identity id linked with the resource
  - `[RetryAfter <Int32?>]`: 
  - `[SliMonitoringPropertiesIdentityType <String>]`: Identity type linked with the resource
  - `[SliMonitoringPropertiesIdentityUserAssignedIdentity <String>]`: User assigned identity id linked with the resource
  - `[SliMonitoringPropertySlis <List<ISliSelection>>]`: The SLIs selected for Drill monitoring. Maximum of two entries: at most one Availability and one Latency. Duplicate types or duplicate SLI Ids are rejected.
    - `SliId <String>`: Full ARM Id of the SLI.
    - `Type <String>`: User-declared category of the SLI. Must be unique across the selected SLIs.

`SLIMONITORINGPROPERTYSLIS <ISliSelection[]>`: The SLIs selected for Drill monitoring. Maximum of two entries: at most one Availability and one Latency. Duplicate types or duplicate SLI Ids are rejected.
  - `SliId <String>`: Full ARM Id of the SLI.
  - `Type <String>`: User-declared category of the SLI. Must be unique across the selected SLIs.

## RELATED LINKS

