### Ruby multi-api for managedapplications

``` yaml $(multiapi) && $(managedapplications)
package-name: azure_mgmt_managed_applications
package-version: "0.16.0"
azure-arm: true
batch:
  - tag: package-managedapplications-2021-02
```

### Tag: package-managedapplications-2021-02 and ruby

These settings apply only when `--tag=package-managedapplications-2021-02 --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

``` yaml $(tag) == 'package-managedapplications-2021-02' && $(ruby)
namespace: "Azure::ManagedApplications::Mgmt::V2021_02_01_preview"
output-folder: $(ruby-sdks-folder)/management/azure_mgmt_managed_applications/lib
```