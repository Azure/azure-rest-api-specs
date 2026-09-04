---
external help file:
Module Name: Az.ResilienceManagement
online version: https://learn.microsoft.com/powershell/module/az.resiliencemanagement/get-azresiliencemanagementdrillrunreportdownloadurl
schema: 2.0.0
---

# Get-AzResilienceManagementDrillRunReportDownloadUrl

## SYNOPSIS
This returns a short-lived, read-only URL to download the report for this Drill Run.
The URL expires at the returned expiryTimestamp and grants access to that single report only.

## SYNTAX

### ListExpanded (Default)
```
Get-AzResilienceManagementDrillRunReportDownloadUrl -DrillName <String> -DrillRunName <String>
 -ServiceGroupName <String> -OperationId <String> [-Format <String>] [-AsJob] [-NoWait] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### List
```
Get-AzResilienceManagementDrillRunReportDownloadUrl -DrillName <String> -DrillRunName <String>
 -ServiceGroupName <String> -OperationId <String> -Body <IListReportDownloadUrlRequest> [-AsJob] [-NoWait]
 [-Confirm] [-WhatIf] [<CommonParameters>]
```

## DESCRIPTION
This returns a short-lived, read-only URL to download the report for this Drill Run.
The URL expires at the returned expiryTimestamp and grants access to that single report only.

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
Request to mint a short-lived, read-only download URL for a Drill Run report.

```yaml
Type: Sample.API.Models.IListReportDownloadUrlRequest
Parameter Sets: List
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
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DrillRunName
The name of the DrillRun (GUID).

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

### -Format
Format of the report to download.
Defaults to Html when not specified.

```yaml
Type: System.String
Parameter Sets: ListExpanded
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

### -ServiceGroupName
The name of the service group.

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

### Sample.API.Models.IListReportDownloadUrlRequest

## OUTPUTS

### Sample.API.Models.IListReportDownloadUrlResponse

## NOTES

COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.


`BODY <IListReportDownloadUrlRequest>`: Request to mint a short-lived, read-only download URL for a Drill Run report.
  - `[Format <String>]`: Format of the report to download. Defaults to Html when not specified.

## RELATED LINKS

