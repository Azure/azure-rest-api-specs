## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-m365securityandcompliance-2021-03-25-preview
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-m365securityandcompliance-2021-03-25-preview and azureresourceschema

``` yaml $(tag) == 'schema-m365securityandcompliance-2021-03-25-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/common-types.json
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/privateLinkServicesForEDMUpload.json
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/privateLinkServicesForM365ComplianceCenter.json
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/privateLinkServicesForM365SecurityCenter.json
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/privateLinkServicesForO365ManagementActivityAPI.json
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/privateLinkServicesForSCCPowershell.json

```

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-m365securityandcompliance-2021-03-25-preview
```

### Tag: schema-m365securityandcompliance-2021-03-25-preview and azureresourceschema

``` yaml $(tag) == 'schema-m365securityandcompliance-2021-03-25-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/common-types.json
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/privateLinkServicesForEDMUpload.json
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/privateLinkServicesForM365ComplianceCenter.json
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/privateLinkServicesForM365SecurityCenter.json
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/privateLinkServicesForO365ManagementActivityAPI.json
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/privateLinkServicesForSCCPowershell.json
  - Microsoft.M365SecurityAndCompliance/preview/2021-03-25-preview/privateLinkServicesForMIPPolicySync.json

```
