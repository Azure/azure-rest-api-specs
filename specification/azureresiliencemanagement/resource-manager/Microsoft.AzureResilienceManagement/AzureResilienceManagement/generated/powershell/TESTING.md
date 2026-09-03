# Testing Guide — Az.AzureResilienceManagement

End-to-end walkthrough for anyone picking up this branch and testing the
generated cmdlets against Azure.

- **Module version:** `0.1.0` (unreleased; hand-patched build from this branch)
- **API version:** `2026-08-31-preview`
- **Total cmdlets:** 417 (34 nouns × ~6-8 variants each)
- **Scope:** all endpoints are scoped to a `Microsoft.Management/serviceGroups` resource. There is no subscription- or resource-group-scoped surface in this API version.

---

## 1. Prerequisites

| Requirement | Minimum | How to check |
|---|---|---|
| PowerShell | 7.2+ (PowerShell 5.1 works but 7.x recommended) | `$PSVersionTable.PSVersion` |
| .NET SDK | 8.0 (only needed if you plan to *rebuild* the module) | `dotnet --version` |
| `Az.Accounts` module | 2.7.5+ | `Get-Module Az.Accounts -ListAvailable` |
| Azure sign-in | any account with `Reader` role on the target service group (for CRUD you need `Contributor`) | `Connect-AzAccount` |
| A `Microsoft.Management/serviceGroups` resource enrolled with the RP | provisioned by the AzureResilienceManagement POC team | Ask the POC team; there is no self-service creation yet |

Install `Az.Accounts` if you don't have it:

```powershell
Install-Module Az.Accounts -Scope CurrentUser -Force
```

---

## 2. Get the module bits

### Option A — clone this branch and use the pre-built binaries

```powershell
git clone --branch krt/pwsh-cmd --depth 1 https://github.com/krtcodee/azure-rest-api-specs.git
cd .\azure-rest-api-specs\specification\azureresiliencemanagement\resource-manager\Microsoft.AzureResilienceManagement\AzureResilienceManagement\generated\powershell
```

The compiled DLL (`bin/Az.AzureResilienceManagement.private.dll`) is checked into
the branch, so **no build step is required for testing**.

### Option B — rebuild from source

Only needed if you change generator config or apply new patches:

```powershell
cd .\generated\powershell
.\build-module.ps1 -Release
```

Expect the last step (`Export-ProxyCmdlet`) to report an error on
`Test-*RecoveryPlanAction` — see [Known limitations](#5-known-limitations). The
DLL still builds and cmdlets still work.

---

## 3. Install the module so PowerShell can discover it by name

The build folder isn't automatically on `$env:PSModulePath`. Copy it into your
user modules folder (one-time step):

```powershell
$src  = '.\generated\powershell'                 # from the folder above
$dest = "$HOME\Documents\PowerShell\Modules\Az.AzureResilienceManagement\0.1.0"
if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
New-Item -ItemType Directory $dest -Force | Out-Null
Copy-Item "$src\Az.AzureResilienceManagement.psd1" $dest
Copy-Item "$src\Az.AzureResilienceManagement.psm1" $dest
Copy-Item "$src\bin" (Join-Path $dest 'bin') -Recurse

Get-Module Az.AzureResilienceManagement -ListAvailable
```

Now you can just:

```powershell
Import-Module Az.AzureResilienceManagement
```

---

## 4. Connect to Azure

```powershell
Connect-AzAccount                                     # opens browser
Set-AzContext -Subscription '<subscription-id>'       # or -Tenant '<tenant-id>'
Get-AzContext                                         # verify

# Store your service group name once so the rest of the guide reads cleanly:
$sg = '<your-service-group-name>'                     # ask the POC team
```

If you need a device-code flow (headless / no browser):

```powershell
Connect-AzAccount -UseDeviceAuthentication -Tenant '<tenant-id>'
```

---

## 5. Cmdlet naming — required reading

Because the proxy-export step of the AutoRest build failed (see
[Known limitations](#8-known-limitations)), the DLL exposes **raw variant
cmdlets** rather than the friendly single-cmdlet-per-operation surface Az
modules usually ship with.

Every cmdlet name has the shape:

```
<Verb>-AzureResilienceManagement<Noun>_<Variant>
```

| Variant suffix | Use when… |
|---|---|
| `_Get`, `_List`, `_Create`, `_Update`, `_Delete` | direct call, pass IDs by hand |
| `_Expanded` | you want to pass body properties as individual `-Prop` flags |
| `_ViaIdentity` | you are piping a resource object in |
| `_ViaIdentityServiceGroup` | you are piping the parent service group in |
| `_ViaJsonString` | you have the body as a JSON string |
| `_ViaJsonFilePath` | you have the body in a file |

Browse the full inventory (with parameter tables) here:
[`CMDLETS.md`](./CMDLETS.md).

---

## 6. Read-only smoke tests

Zero side-effects. Run these first to confirm auth + connectivity.

```powershell
# 6.1 - Enrollment for this service group
Get-AzureResilienceManagementEnrollment_Get -ServiceGroupName $sg

# 6.2 - Usage plans
Get-AzureResilienceManagementUsagePlan_List -ServiceGroupName $sg

# 6.3 - Drills in this service group
Get-AzureResilienceManagementDrill_List -ServiceGroupName $sg

# 6.4 - Recovery plans
Get-AzureResilienceManagementRecoveryPlan_List -ServiceGroupName $sg

# 6.5 - Available SKUs
Get-AzureResilienceManagementSku_List -ServiceGroupName $sg
```

Each should return either objects or an empty array. Any 401/403 = auth
problem; any 404 = the service group is not enrolled with the RP yet.

---

## 7. Full CRUD walkthrough

⚠️ **Runs against a real subscription and creates real Azure resources.**
Use only in a scratch/POC subscription.

### 7.1 Create a drill

```powershell
$drillName  = "poc-drill-$(Get-Random -Maximum 9999)"
$location   = 'eastus2'

$drill = New-AzureResilienceManagementDrill_CreateExpanded `
    -ServiceGroupName $sg `
    -Name            $drillName `
    -Location        $location `
    -Property        @{
        displayName = 'POC smoke drill'
        description = 'Created by TESTING.md walkthrough'
        drillType   = 'RegionalDrill'
    }

$drill | Format-List Name, Location, Property.ProvisioningState
```

### 7.2 Add a resource to the drill

```powershell
# The resource you want to include in the drill (e.g. a VM or an ASR item):
$targetResourceId = '/subscriptions/<sub>/resourceGroups/<rg>/providers/Microsoft.Compute/virtualMachines/<vm>'

Add-AzureResilienceManagementDrillResource_AddExpanded `
    -ServiceGroupName $sg `
    -DrillName        $drillName `
    -Name             ($targetResourceId -split '/')[-1] `
    -Property         @{
        sourceResourceId = $targetResourceId
        resourceType     = 'Microsoft.Compute/virtualMachines'
    }
```

### 7.3 Validate readiness (dry-run)

```powershell
Test-AzureResilienceManagementDrillResyncReadiness_Check `
    -ServiceGroupName $sg -DrillName $drillName
```

### 7.4 Start the drill

```powershell
Start-AzureResilienceManagementDrill_Start `
    -ServiceGroupName $sg -DrillName $drillName

# Poll for status:
do {
    Start-Sleep -Seconds 30
    $d = Get-AzureResilienceManagementDrill_Get -ServiceGroupName $sg -Name $drillName
    "State: $($d.Property.ProvisioningState)"
} while ($d.Property.ProvisioningState -eq 'Running')
```

### 7.5 List drill runs + report

```powershell
$runs = Get-AzureResilienceManagementDrillRun_List `
            -ServiceGroupName $sg -DrillName $drillName
$runs | Format-Table Name, Property.State

# Generate report for latest run:
$runName = $runs[0].Name
New-AzureResilienceManagementDrillRunReport_GenerateExpanded `
    -ServiceGroupName $sg -DrillName $drillName -DrillRunName $runName `
    -Format 'Pdf'

# Get download URL:
Get-AzureResilienceManagementDrillRunReportDownloadUrl_List `
    -ServiceGroupName $sg -DrillName $drillName -DrillRunName $runName
```

### 7.6 Stop the drill

```powershell
Stop-AzureResilienceManagementDrill_End `
    -ServiceGroupName $sg -DrillName $drillName
```

### 7.7 Delete the drill (cleanup)

```powershell
Remove-AzureResilienceManagementDrill_Delete `
    -ServiceGroupName $sg -Name $drillName
```

---

## 8. Known limitations

| # | Symptom | Root cause | Workaround |
|---|---|---|---|
| 1 | No `Get-AzureResilienceManagementDrill` (unsuffixed) | Proxy-export step failed for `Test-*RecoveryPlanAction` and short-circuited proxy generation for the whole module | Use the `_<Variant>` suffixed names (see [`CMDLETS.md`](./CMDLETS.md)) |
| 2 | `Test-*RecoveryPlanAction` cmdlets present but poorly documented | Same swagger endpoint accepts three different body shapes (`IFailoverRequest`, `IValidateForOperationRequest`, `IReprotectRequest`) | Read the swagger operation definitions in `../../../preview/2026-08-31-preview/openapi.json` and pass `-Body` as JSON |
| 3 | Cmdlet source is committed to the branch | Convenience for testers; will be replaced by proper build artifacts before merging | Ignore the `generated/powershell/generated/` folder in code review |
| 4 | Some property/model names hand-patched (`ErrorDetail` vs `ErrorDetailDetails`) | Generator bug in `@autorest/powershell@4.0.758` | Bug will need a `directive` in `readme.powershell.md` before we regenerate |

Re-running AutoRest today **will** re-introduce (1)-(4). Do not regenerate
without re-applying the hand patches or landing directive-based fixes first.

---

## 9. Reporting issues

- Cmdlet-level bugs (missing params, wrong types) → open an issue on this
  fork's tracker with the cmdlet name + expected vs actual.
- Swagger-level bugs (missing endpoints, wrong scope) → file against the
  AzureResilienceManagement service team.
- Generator bugs (hand patches needed) → track under
  [`Azure/autorest.powershell`](https://github.com/Azure/autorest.powershell).
