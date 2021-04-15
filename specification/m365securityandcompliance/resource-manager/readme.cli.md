## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: mysql
  package-name: azure-mgmt-m365securityandcompliance
  namespace: azure.mgmt.m365securityandcompliance
  test-scenario:
    - split: privateLinkServicesForM365SecurityCenter
    - name: /privateLinkServicesForM365SecurityCenter/put/Create a privateLinkServiceForM365SecurityCenter
    - name: /privateLinkServicesForM365SecurityCenter/get/Get privateLinkServiceForM365SecurityCenter
    - name: /privateLinkServicesForM365SecurityCenter/get/List privateLinkServicesForM365SecurityCenter in resource group
    - name: /privateLinkServicesForM365SecurityCenter/get/List all privateLinkServicesForM365SecurityCenter
    - name: /privateLinkServicesForM365SecurityCenter/patch/Update privateLinkServiceForM365SecurityCenter
    - name: /privateLinkServicesForM365SecurityCenter/delete/Delete privateLinkServiceForM365SecurityCenter
    - split: privateLinkServicesForM365ComplianceCenter
    - name: /privateLinkServicesForM365ComplianceCenter/put/Create a privateLinkServiceForM365ComplianceCenter
    - name: /privateLinkServicesForM365ComplianceCenter/get/Get privateLinkServiceForM365ComplianceCenter
    - name: /privateLinkServicesForM365ComplianceCenter/get/List privateLinkServicesForM365ComplianceCenter in resource group
    - name: /privateLinkServicesForM365ComplianceCenter/get/List all privateLinkServicesForM365ComplianceCenter
    - name: /privateLinkServicesForM365ComplianceCenter/patch/Update privateLinkServiceForM365ComplianceCenter
    - name: /privateLinkServicesForM365ComplianceCenter/delete/Delete privateLinkServiceForM365ComplianceCenter
	- split: privateLinkServicesForO365ManagementActivityAPI
    - name: /privateLinkServicesForO365ManagementActivityAPI/put/Create a privateLinkServiceForO365ManagementActivityAPI
    - name: /privateLinkServicesForO365ManagementActivityAPI/get/Get privateLinkServiceForO365ManagementActivityAPI
    - name: /privateLinkServicesForO365ManagementActivityAPI/get/List privateLinkServicesForO365ManagementActivityAPI in resource group
    - name: /privateLinkServicesForO365ManagementActivityAPI/get/List all privateLinkServicesForO365ManagementActivityAPI
    - name: /privateLinkServicesForO365ManagementActivityAPI/patch/Update privateLinkServiceForO365ManagementActivityAPI
    - name: /privateLinkServicesForO365ManagementActivityAPI/delete/Delete privateLinkServiceForO365ManagementActivityAPI
	- split: privateLinkServicesForEDMUpload
    - name: /privateLinkServicesForEDMUpload/put/Create a privateLinkServiceForEDMUpload
    - name: /privateLinkServicesForEDMUpload/get/Get privateLinkServiceForEDMUpload
    - name: /privateLinkServicesForEDMUpload/get/List privateLinkServicesForEDMUpload in resource group
    - name: /privateLinkServicesForEDMUpload/get/List all privateLinkServicesForEDMUpload
    - name: /privateLinkServicesForEDMUpload/patch/Update privateLinkServiceForEDMUpload
    - name: /privateLinkServicesForEDMUpload/delete/Delete privateLinkServiceForEDMUpload
	- split: privateLinkServicesForSCCPowershell
    - name: /privateLinkServicesForSCCPowershell/put/Create a privateLinkServiceForSCCPowershell
    - name: /privateLinkServicesForSCCPowershell/get/Get privateLinkServiceForSCCPowershell
    - name: /privateLinkServicesForSCCPowershell/get/List privateLinkServicesForSCCPowershell in resource group
    - name: /privateLinkServicesForSCCPowershell/get/List all privateLinkServicesForSCCPowershell
    - name: /privateLinkServicesForSCCPowershell/patch/Update privateLinkServiceForSCCPowershell
    - name: /privateLinkServicesForSCCPowershell/delete/Delete privateLinkServiceForSCCPowershell
	- split: privateLinkServicesForMIPPolicySync
    - name: /privateLinkServicesForMIPPolicySync/put/Create a privateLinkServiceForMIPPolicySync
    - name: /privateLinkServicesForMIPPolicySync/get/Get privateLinkServiceForMIPPolicySync
    - name: /privateLinkServicesForMIPPolicySync/get/List privateLinkServicesForMIPPolicySync in resource group
    - name: /privateLinkServicesForMIPPolicySync/get/List all privateLinkServicesForMIPPolicySync
    - name: /privateLinkServicesForMIPPolicySync/patch/Update privateLinkServiceForMIPPolicySync
    - name: /privateLinkServicesForMIPPolicySync/delete/Delete privateLinkServiceForMIPPolicySync
```