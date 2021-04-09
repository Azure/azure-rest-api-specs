## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-securityandcompliance-2021-03-08
  - tag: schema-securityandcompliance-2021-01-11

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-securityandcompliance-2021-03-08 and azureresourceschema

``` yaml $(tag) == 'schema-securityandcompliance-2021-03-08' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SecurityAndCompliance/stable/2021-03-08/common-types.json
  - Microsoft.SecurityAndCompliance/stable/2021-03-08/privateLinkServicesForEDMUpload.json
  - Microsoft.SecurityAndCompliance/stable/2021-03-08/privateLinkServicesForM365ComplianceCenter.json
  - Microsoft.SecurityAndCompliance/stable/2021-03-08/privateLinkServicesForM365SecurityCenter.json
  - Microsoft.SecurityAndCompliance/stable/2021-03-08/privateLinkServicesForO365ManagementActivityAPI.json
  - Microsoft.SecurityAndCompliance/stable/2021-03-08/privateLinkServicesForSCCPowershell.json
  - Microsoft.SecurityAndCompliance/stable/2021-03-08/privateLinkServicesForMIPPolicySync.json

```

### Tag: schema-securityandcompliance-2021-01-11 and azureresourceschema

``` yaml $(tag) == 'schema-securityandcompliance-2021-01-11' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SecurityAndCompliance/stable/2021-01-11/common-types.json
  - Microsoft.SecurityAndCompliance/stable/2021-01-11/privateLinkServicesForEDMUpload.json
  - Microsoft.SecurityAndCompliance/stable/2021-01-11/privateLinkServicesForM365ComplianceCenter.json
  - Microsoft.SecurityAndCompliance/stable/2021-01-11/privateLinkServicesForM365SecurityCenter.json
  - Microsoft.SecurityAndCompliance/stable/2021-01-11/privateLinkServicesForO365ManagementActivityAPI.json
  - Microsoft.SecurityAndCompliance/stable/2021-01-11/privateLinkServicesForSCCPowershell.json

```
