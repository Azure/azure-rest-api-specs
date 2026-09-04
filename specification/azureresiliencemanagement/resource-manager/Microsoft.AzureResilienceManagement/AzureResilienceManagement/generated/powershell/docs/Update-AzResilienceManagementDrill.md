---
external help file:
Module Name: Az.ResilienceManagement
online version: https://learn.microsoft.com/powershell/module/az.resiliencemanagement/update-azresiliencemanagementdrill
schema: 2.0.0
---

# Update-AzResilienceManagementDrill

## SYNOPSIS
Update a Drill

## SYNTAX

### UpdateExpanded (Default)
```
Update-AzResilienceManagementDrill -DrillName <String> -ServiceGroupName <String>
 [-ChaosResourceIdentityForFaultType <String>] [-ChaosResourceIdentityForFaultUserAssignedIdentity <String>]
 [-ChaosResourcePropertiesIdentityType <String>]
 [-ChaosResourcePropertiesIdentityUserAssignedIdentity <String>] [-DrillAssetPropertyRegion <String>]
 [-DrillAssetPropertySubscription <String>] [-HealthModelMonitoringPropertiesIdentityType <String>]
 [-HealthModelMonitoringPropertiesIdentityUserAssignedIdentity <String>]
 [-HealthModelMonitoringPropertyDiscoveryRuleId <String>] [-IdentityType <String>]
 [-IdentityUserAssignedIdentities <Hashtable>] [-MonitoringPropertiesIdentityType <String>]
 [-MonitoringPropertiesIdentityUserAssignedIdentity <String>] [-RbacSetupMode <String>]
 [-RecoveryPlanPropertiesIdentityType <String>] [-RecoveryPlanPropertiesIdentityUserAssignedIdentity <String>]
 [-SliMonitoringPropertiesIdentityType <String>]
 [-SliMonitoringPropertiesIdentityUserAssignedIdentity <String>]
 [-SliMonitoringPropertySlis <ISliSelection[]>] [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### Update
```
Update-AzResilienceManagementDrill -DrillName <String> -ServiceGroupName <String> -Properties <IDrillUpdate>
 [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### UpdateViaIdentity
```
Update-AzResilienceManagementDrill -InputObject <IResilienceManagementIdentity> -Properties <IDrillUpdate>
 [-AsJob] [-NoWait] [-Confirm] [-WhatIf] [<CommonParameters>]
```

### UpdateViaIdentityExpanded
```
Update-AzResilienceManagementDrill -InputObject <IResilienceManagementIdentity>
 [-ChaosResourceIdentityForFaultType <String>] [-ChaosResourceIdentityForFaultUserAssignedIdentity <String>]
 [-ChaosResourcePropertiesIdentityType <String>]
 [-ChaosResourcePropertiesIdentityUserAssignedIdentity <String>] [-DrillAssetPropertyRegion <String>]
 [-DrillAssetPropertySubscription <String>] [-HealthModelMonitoringPropertiesIdentityType <String>]
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
Update a Drill

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
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
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
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
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
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
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
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
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
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
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
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
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
Parameter Sets: Update, UpdateExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HealthModelMonitoringPropertiesIdentityType
Identity type linked with the resource

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

### -HealthModelMonitoringPropertiesIdentityUserAssignedIdentity
User assigned identity id linked with the resource

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

### -HealthModelMonitoringPropertyDiscoveryRuleId
Full ARM Id of the discovery rule inside the Azure Health Model.
The parent Health Model is derived from this Id; it is the only identifier accepted on the wire.

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
The type of managed identity assigned to this resource.

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
The identities assigned to this resource by the user.

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

### -MonitoringPropertiesIdentityType
Identity type linked with the resource

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

### -MonitoringPropertiesIdentityUserAssignedIdentity
User assigned identity id linked with the resource

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

### -Properties
The type used for update operations of the Drill.

```yaml
Type: Sample.API.Models.IDrillUpdate
Parameter Sets: Update, UpdateViaIdentity
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -RbacSetupMode
RBAC setup mode.

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

### -RecoveryPlanPropertiesIdentityType
Identity type linked with the resource

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

### -RecoveryPlanPropertiesIdentityUserAssignedIdentity
User assigned identity id linked with the resource

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

### -SliMonitoringPropertiesIdentityType
Identity type linked with the resource

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

### -SliMonitoringPropertiesIdentityUserAssignedIdentity
User assigned identity id linked with the resource

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

### -SliMonitoringPropertySlis
The SLIs selected for Drill monitoring.
Maximum of two entries: at most one Availability and one Latency.
Duplicate types or duplicate SLI Ids are rejected.

```yaml
Type: Sample.API.Models.ISliSelection[]
Parameter Sets: UpdateExpanded, UpdateViaIdentityExpanded
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

### Sample.API.Models.IDrillUpdate

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

`PROPERTIES <IDrillUpdate>`: The type used for update operations of the Drill.
  - `[ChaosResourceIdentityForFaultType <String>]`: Identity type linked with the resource
  - `[ChaosResourceIdentityForFaultUserAssignedIdentity <String>]`: User assigned identity id linked with the resource
  - `[ChaosResourcePropertiesIdentityType <String>]`: Identity type linked with the resource
  - `[ChaosResourcePropertiesIdentityUserAssignedIdentity <String>]`: User assigned identity id linked with the resource
  - `[DrillAssetPropertyRegion <String>]`: Region where Drill's internal resources will be created.
  - `[DrillAssetPropertySubscription <String>]`: Subscription where Drill's internal resources will be created.
  - `[HealthModelMonitoringPropertiesIdentityType <String>]`: Identity type linked with the resource
  - `[HealthModelMonitoringPropertiesIdentityUserAssignedIdentity <String>]`: User assigned identity id linked with the resource
  - `[HealthModelMonitoringPropertyDiscoveryRuleId <String>]`: Full ARM Id of the discovery rule inside the Azure Health Model. The parent Health Model is derived from this Id; it is the only identifier accepted on the wire.
  - `[IdentityType <String>]`: The type of managed identity assigned to this resource.
  - `[IdentityUserAssignedIdentities <IAzureResourceManagerCommonTypesManagedServiceIdentityUpdateUserAssignedIdentities>]`: The identities assigned to this resource by the user.
    - `[(Any) <IUserAssignedIdentity>]`: This indicates any property can be added to this object.
  - `[MonitoringPropertiesIdentityType <String>]`: Identity type linked with the resource
  - `[MonitoringPropertiesIdentityUserAssignedIdentity <String>]`: User assigned identity id linked with the resource
  - `[RbacSetupMode <String>]`: RBAC setup mode.
  - `[RecoveryPlanPropertiesIdentityType <String>]`: Identity type linked with the resource
  - `[RecoveryPlanPropertiesIdentityUserAssignedIdentity <String>]`: User assigned identity id linked with the resource
  - `[SliMonitoringPropertiesIdentityType <String>]`: Identity type linked with the resource
  - `[SliMonitoringPropertiesIdentityUserAssignedIdentity <String>]`: User assigned identity id linked with the resource
  - `[SliMonitoringPropertySlis <List<ISliSelection>>]`: The SLIs selected for Drill monitoring. Maximum of two entries: at most one Availability and one Latency. Duplicate types or duplicate SLI Ids are rejected.
    - `SliId <String>`: Full ARM Id of the SLI.
    - `Type <String>`: User-declared category of the SLI. Must be unique across the selected SLIs.

`SLIMONITORINGPROPERTYSLIS <ISliSelection[]>`: The SLIs selected for Drill monitoring. Maximum of two entries: at most one Availability and one Latency. Duplicate types or duplicate SLI Ids are rejected.
  - `SliId <String>`: Full ARM Id of the SLI.
  - `Type <String>`: User-declared category of the SLI. Must be unique across the selected SLIs.

## RELATED LINKS

