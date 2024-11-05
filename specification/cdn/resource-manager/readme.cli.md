## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: cdn
  package-name: azure-mgmt-cdn
  namespace: azure.mgmt.cdn
  test-scenario:
    - name: Profiles_Create
    - name: Endpoints_Create
    - name: Creates specific policy
    - name: CustomDomains_Create
    - name: CustomDomains_Get
    - name: Origins_Get
    - name: Get Policy
    - name: CustomDomains_ListByEndpoint
    - name: Origins_ListByEndpoint
    - name: Endpoints_Get
    - name: Endpoints_ListByProfile
    - name: List Policies in a Resource Group
    - name: Profiles_Get
    - name: Profiles_ListByResourceGroup
    - name: List Policies in a Resource Group
    - name: Profiles_List
    - name: Operations_List
    - name: EdgeNodes_List
    - name: CustomDomains_DisableCustomHttps
    - name: CustomDomains_EnableCustomHttpsUsingYourOwnCertificate
    - name: CustomDomains_EnableCustomHttpsUsingCDNManagedCertificate
    - name: Origins_Update
    - name: Creates specific policy
    - name: Endpoints_ValidateCustomDomain
    - name: Endpoints_ListResourceUsage
    - name: Endpoints_PurgeContent
    - name: Endpoints_Start
    - name: Endpoints_Stop
    - name: Endpoints_LoadContent
    - name: Profiles_ListSupportedOptimizationTypes
    - name: Endpoints_Update
    - name: Profiles_ListResourceUsage
    - name: Profiles_GenerateSsoUri
    - name: Profiles_Update
    - name: CheckNameAvailabilityWithSubscription
    - name: ResourceUsage_List
    - name: ValidateProbe
    - name: CheckNameAvailability
    - name: CustomDomains_Delete
    - name: Delete protection policy
    - name: Endpoints_Delete
    - name: Profiles_Delete
```