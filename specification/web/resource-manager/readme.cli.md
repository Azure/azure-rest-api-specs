## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: appservice
  package-name: azure-mgmt-web
  namespace: azure.mgmt.web
  test-scenario:
    - name: /StaticSites/put/Create or update a static site
      disabled: true
    - name: /AppServicePlans/put/Create Or Update App Service plan
      disabled: true
    - name: /Certificates/put/Create Or Update Certificate
      disabled: true
    - name: /StaticSites/put/Creates or updates the function app settings of a static site.
      disabled: true
    - name: /StaticSites/put/Create or update a custom domain for a static site
      disabled: true
    - name: /StaticSites/put/Creates or updates the function app settings of a static site build.
      disabled: true
    - name: /WebApps/put/Approves or rejects a private endpoint connection for a site.
      disabled: true
    - name: /Diagnostics/get/Get App Detector
      disabled: true
    - name: /Diagnostics/get/Get App Slot Detector
      disabled: true
    - name: /Diagnostics/get/Get App Analysis
      disabled: true
    - name: /Diagnostics/get/Get App Slot Analysis
      disabled: true
    - name: /WebApps/get/Get the current status of a network trace operation for a site
      disabled: true
    - name: /Diagnostics/get/Get App Slot Detector
      disabled: true
    - name: /Diagnostics/get/Get App Detector
      disabled: true
    - name: /Diagnostics/get/Get App Analysis
      disabled: true
    - name: /Diagnostics/get/Get App Slot Analysis
      disabled: true
    - name: /Diagnostics/get/List App Slot Detectors
      disabled: true
    - name: /Diagnostics/get/List App Detectors
      disabled: true
    - name: /Diagnostics/get/List App Slot Analyses
      disabled: true
    - name: /Diagnostics/get/List App Analyses
      disabled: true
    - name: /WebApps/get/Get a private endpoint connection for a site.
      disabled: true
    - name: /WebApps/get/Get the current status of a network trace operation for a site
      disabled: true
    - name: /Diagnostics/get/Get App Slot Diagnostic Category
      disabled: true
    - name: /Diagnostics/get/Get App Diagnostic Category
      disabled: true
    - name: /WebApps/get/Get the current status of a network trace operation for a site
      disabled: true
    - name: /WebApps/get/Get Azure Key Vault app setting reference
      disabled: true
    - name: /Diagnostics/get/List App Slot Detectors
      disabled: true
    - name: /Diagnostics/get/List App Detectors
      disabled: true
    - name: /Diagnostics/get/Get App Slot Detector Response
      disabled: true
    - name: /Diagnostics/get/List App Slot Analyses
      disabled: true
    - name: /Diagnostics/get/Get App Detector Response
      disabled: true
    - name: /Diagnostics/get/List App Analyses
      disabled: true
    - name: /AppServiceEnvironments/get/Get Outbound Network Dependencies Endpoints
      disabled: true
    - name: /WebApps/get/Get NetworkTraces for a site
      disabled: true
    - name: /AppServiceEnvironments/get/Get Inbound Network Dependencies Endpoints
      disabled: true
    - name: /WebApps/get/Get NetworkTraces for a site
      disabled: true
    - name: /ResourceHealthMetadata/get/Get ResourceHealthMetadata
      disabled: true
    - name: /WebApps/get/Get site instance info
      disabled: true
    - name: /Diagnostics/get/Get App Service Environment Detector Responses
      disabled: true
    - name: /Diagnostics/get/Get App Slot Diagnostic Category
      disabled: true
    - name: /Diagnostics/get/Get App Diagnostic Category
      disabled: true
    - name: /WebApps/get/Get the current status of a network trace operation for a site
      disabled: true
    - name: /ResourceHealthMetadata/get/List ResourceHealthMetadata for a site
      disabled: true
    - name: /StaticSites/get/Gets the functions of a particular static site build
      disabled: true
    - name: /WebApps/get/Get Azure Key Vault references for app settings
      disabled: true
    - name: /Diagnostics/get/Get App Detector Response
      disabled: true
    - name: /Diagnostics/get/Get App Slot Detector Response
      disabled: true
    - name: /Diagnostics/get/List App Slot Diagnostic Categories
      disabled: true
    - name: /Diagnostics/get/List App Diagnostic Categories
      disabled: true
    - name: /WebApps/get/Get NetworkTraces for a site
      disabled: true
    - name: /Diagnostics/get/Get App Detector Responses
      disabled: true
    - name: /Diagnostics/get/Get App Slot Detector Responses
      disabled: true
    - name: /WebApps/get/Get NetworkTraces for a site
      disabled: true
    - name: /ResourceHealthMetadata/get/Get ResourceHealthMetadata
      disabled: true
    - name: /WebApps/get/Get site instance info
      disabled: true
    - name: /StaticSites/get/Get a static site build
      disabled: true
    - name: /Diagnostics/get/Get App Service Environment Detector Responses
      disabled: true
    - name: /ResourceHealthMetadata/get/List ResourceHealthMetadata for a site
      disabled: true
    - name: /WebApps/get/Get private link resources of a site
      disabled: true
    - name: /StaticSites/get/List custom domains for a static site
      disabled: true
    - name: /Diagnostics/get/List App Slot Diagnostic Categories
      disabled: true
    - name: /Diagnostics/get/List App Diagnostic Categories
      disabled: true
    - name: /StaticSites/get/Gets the functions of a static site
      disabled: true
    - name: /Diagnostics/get/Get App Slot Detector Responses
      disabled: true
    - name: /Diagnostics/get/Get App Detector Responses
      disabled: true
    - name: /StaticSites/get/Get all builds for a static site
      disabled: true
    - name: /DeletedWebApps/get/Get Deleted Web App by Location
      disabled: true
    - name: /Certificates/get/Get Certificate
      disabled: true
    - name: /ResourceHealthMetadata/get/List ResourceHealthMetadata for a resource group
      disabled: true
    - name: /StaticSites/get/Get details for a static site
      disabled: true
    - name: /AppServicePlans/get/Get App Service plan
    - name: /Certificates/get/List Certificates by resource group
      disabled: true
    - name: /StaticSites/get/Get static sites for a resource group
      disabled: true
    - name: /AppServicePlans/get/List App Service plans by resource group
    - name: /TopLevelDomains/get/Get Top Level Domain
      disabled: true
    - name: /DeletedWebApps/get/List Deleted Web App by Location
      disabled: true
    - name: /TopLevelDomains/get/List Top Level Domains
      disabled: true
    - name: /ResourceHealthMetadata/get/List ResourceHealthMetadata for a subscription
      disabled: true
    - name: /Certificates/get/List Certificates for subscription
      disabled: true
    - name: /StaticSites/get/Get all static sites in a subscription
      disabled: true
    - name: /AppServicePlans/get/List App Service plans
    - name: /CertificateRegistrationProvider/get/List operations
    - name: /DomainRegistrationProvider/get/List operations
    - name: /Provider/get/List operations
    - name: /Diagnostics/post/Execute site detector
      disabled: true
    - name: /Diagnostics/post/Execute site slot detector
      disabled: true
    - name: /Diagnostics/post/Execute site slot analysis
      disabled: true
    - name: /Diagnostics/post/Execute site analysis
      disabled: true
    - name: /Diagnostics/post/Execute site detector
      disabled: true
    - name: /Diagnostics/post/Execute site slot detector
      disabled: true
    - name: /Diagnostics/post/Execute site slot analysis
      disabled: true
    - name: /Diagnostics/post/Execute site analysis
      disabled: true
    - name: /StaticSites/patch/Create or update a user for a static site
      disabled: true
    - name: /StaticSites/post/Get function app settings of a static site build
      disabled: true
    - name: /StaticSites/post/List users for a static site
      disabled: true
    - name: /StaticSites/post/Validate a custom domain for a static site
      disabled: true
    - name: /WebApps/post/Start a new network trace operation for a site
      disabled: true
    - name: /WebApps/post/Start a new network trace operation for a site
      disabled: true
    - name: /WebApps/post/Stop a currently running network trace operation for a site
      disabled: true
    - name: /WebApps/post/Stop a currently running network trace operation for a site
      disabled: true
    - name: /StaticSites/post/Get function app settings of a static site
      disabled: true
    - name: /Domains/post/Renew an existing domain
      disabled: true
    - name: /WebApps/post/List backups
      disabled: true
    - name: /WebApps/post/Start a new network trace operation for a site
      disabled: true
    - name: /StaticSites/post/Create an invitation link for a user for a static site
      disabled: true
    - name: /WebApps/post/Copy slot
      disabled: true
    - name: /StaticSites/post/List secrets for a static site
      disabled: true
    - name: /StaticSites/post/Reset the api key for a static site
      disabled: true
    - name: /WebApps/post/Start a new network trace operation for a site
      disabled: true
    - name: /WebApps/post/Stop a currently running network trace operation for a site
      disabled: true
    - name: /WebApps/post/Stop a currently running network trace operation for a site
      disabled: true
    - name: /StaticSites/post/Detach a static site
      disabled: true
    - name: /WebApps/post/List backups
      disabled: true
    - name: /WebApps/post/Copy slot
      disabled: true
    - name: /AppServicePlans/patch/Patch Service plan
      disabled: true
    - name: /StaticSites/patch/Patch a static site
      disabled: true
    - name: /TopLevelDomains/post/List Top Level Domain Agreements
      disabled: true
    - name: //post/VerifyHostingEnvironmentVnet
      disabled: true
    - name: /WebApps/delete/Delete a private endpoint connection for a site.
      disabled: true
    - name: /StaticSites/delete/Delete a user for a static site
      disabled: true
    - name: /StaticSites/delete/Delete a custom domain for a static site
      disabled: true
    - name: /StaticSites/delete/Delete a static site build
      disabled: true
    - name: /Certificates/delete/Delete Certificate
      disabled: true
    - name: /AppServicePlans/delete/Delete App Service plan
    - name: /StaticSites/delete/Delete a static site
      disabled: true
```
