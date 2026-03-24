## Swagger Changes

### Changes for `produces`

| Path | Change Type | Value |
|------|------------|-------|
| `produces__added` | added | `["application/json"]` |

### Changes for `consumes`

| Path | Change Type | Value |
|------|------------|-------|
| `consumes__added` | added | `["application/json"]` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActionableRemediation.properties.branchConfiguration.description__added` | added | `Repository branch configuration for PR Annotations.` |
| `definitions.AzureDevOpsOrg.properties.properties.description__added` | added | `Azure DevOps Organization properties.` |
| `definitions.AzureDevOpsOrgProperties.properties.actionableRemediation.description__added` | added | `Configuration payload for PR Annotations.` |
| `definitions.AzureDevOpsProject.properties.properties.description__added` | added | `Azure DevOps Project properties.` |
| `definitions.AzureDevOpsProjectProperties.properties.actionableRemediation.description__added` | added | `Configuration payload for PR Annotations.` |
| `definitions.AzureDevOpsRepository.properties.properties.description__added` | added | `Azure DevOps Repository properties.` |
| `definitions.AzureDevOpsRepositoryProperties.properties.actionableRemediation.description__added` | added | `Configuration payload for PR Annotations.` |
| `definitions.DevOpsConfiguration.properties.properties.description__added` | added | `DevOps Configuration properties.` |
| `definitions.DevOpsConfigurationProperties.properties.agentlessConfiguration.description__added` | added | `Details about Agentless configuration.` |
| `definitions.DevOpsConfigurationProperties.properties.authorization.description__added` | added | `Authorization payload.` |
| `definitions.GitHubOwner.properties.properties.description__added` | added | `GitHub Owner properties.` |
| `definitions.GitHubRepository.properties.properties.description__added` | added | `GitHub Repository properties.` |
| `definitions.GitLabGroup.properties.properties.description__added` | added | `GitLab Group properties.` |
| `definitions.GitLabProject.properties.properties.description__added` | added | `GitLab Project properties.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops'].get.description__added` | added | `List DevOps Configurations.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].delete.description__added` | added | `Deletes a DevOps Connector.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].get.description__added` | added | `Gets a DevOps Configuration.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].patch.description__added` | added | `Updates a DevOps Configuration.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].put.description__added` | added | `Creates or updates a DevOps Configuration.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs'].get.description__added` | added | `Returns a list of Azure DevOps organizations onboarded to the connector.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}'].get.description__added` | added | `Returns a monitored Azure DevOps organization resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}'].patch.description__added` | added | `Updates monitored Azure DevOps organization details.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}'].put.description__added` | added | `Creates or updates monitored Azure DevOps organization details.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects'].get.description__added` | added | `Returns a list of Azure DevOps projects onboarded to the connector.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}'].get.description__added` | added | `Returns a monitored Azure DevOps project resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}'].patch.description__added` | added | `Updates a monitored Azure DevOps project resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}'].put.description__added` | added | `Creates or updates a monitored Azure DevOps project resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}/repos'].get.description__added` | added | `Returns a list of Azure DevOps repositories onboarded to the connector.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}/repos/{repoName}'].get.description__added` | added | `Returns a monitored Azure DevOps repository resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}/repos/{repoName}'].patch.description__added` | added | `Updates a monitored Azure DevOps repository resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}/repos/{repoName}'].put.description__added` | added | `Creates or updates a monitored Azure DevOps repository resource.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitHubOwners'].get.description__added` | added | `Returns a list of GitHub owners onboarded to the connector.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitHubOwners/{ownerName}'].get.description__added` | added | `Returns a monitored GitHub owner.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitHubOwners/{ownerName}/repos'].get.description__added` | added | `Returns a list of GitHub repositories onboarded to the connector.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitHubOwners/{ownerName}/repos/{repoName}'].get.description__added` | added | `Returns a monitored GitHub repository.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitHubOwners/{ownerName}/repos/{repoName}/issues'].post.description__added` | added | `Creates a GitHub issue for the specified repository and assessment.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitLabGroups'].get.description__added` | added | `Returns a list of GitLab groups onboarded to the connector.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitLabGroups/{groupFQName}'].get.description__added` | added | `Returns a monitored GitLab Group resource for a given fully-qualified name.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitLabGroups/{groupFQName}/listSubgroups'].post.description__added` | added | `Gets nested subgroups of given GitLab Group which are onboarded to the connector.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitLabGroups/{groupFQName}/projects'].get.description__added` | added | `Gets a list of GitLab projects that are directly owned by given group and onboarded to the connector.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitLabGroups/{groupFQName}/projects/{projectName}'].get.description__added` | added | `Returns a monitored GitLab Project resource for a given fully-qualified group name and project name.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/listAvailableAzureDevOpsOrgs'].post.description__added` | added | `Returns a list of all Azure DevOps organizations accessible by the user token consumed by the connector.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/listAvailableGitHubOwners'].post.description__added` | added | `Returns a list of all GitHub owners accessible by the user token consumed by the connector.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/listAvailableGitLabGroups'].post.description__added` | added | `Returns a list of all GitLab groups accessible by the user token consumed by the connector.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/operationResults/{operationResultId}'].get.description__added` | added | `Get devops long running operation result.` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].put.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}/repos/{repoName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}/repos/{repoName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitHubOwners/{ownerName}/repos/{repoName}/issues'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DevOpsConfiguration` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DevOpsConfiguration` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/AzureDevOpsOrg` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/AzureDevOpsOrg` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/AzureDevOpsProject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/AzureDevOpsProject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}/repos/{repoName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/AzureDevOpsRepository` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}/repos/{repoName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/AzureDevOpsRepository` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Authorization.properties.code.format__added` | added | `password` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitHubOwners/{ownerName}/repos/{repoName}/issues'].post.parameters[3].schema.format__deleted` | deleted | `arm-id` |

### Changes for `AzureDevOpsOrganizationConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDevOpsOrganizationConfiguration__deleted` | deleted | `{"type":"object","description":"AzureDevOps Org Inventory Configuration.","properties":{"autoDiscove...` |

### Changes for `AzureDevOpsProjectConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDevOpsProjectConfiguration__deleted` | deleted | `{"type":"object","description":"AzureDevOps Project Inventory Configuration.","properties":{"autoDis...` |

### Changes for `BaseResourceConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BaseResourceConfiguration__deleted` | deleted | `{"type":"object","description":"Base Resource Inventory configuration changes.","properties":{"desir...` |

### Changes for `GitHubOwnerConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GitHubOwnerConfiguration__deleted` | deleted | `{"type":"object","description":"GitHub Owner Inventory Configuration.","properties":{"autoDiscovery"...` |

### Changes for `GitLabGroupConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GitLabGroupConfiguration__deleted` | deleted | `{"type":"object","description":"GitLab Group Inventory Configuration.","properties":{"autoDiscovery"...` |

### Changes for `modelAsExtensible`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActionableRemediation.properties.inheritFromParentState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.ActionableRemediation.properties.state['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.AgentlessConfiguration.properties.agentlessAutoDiscovery['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.AgentlessConfiguration.properties.agentlessEnabled['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.AgentlessConfiguration.properties.inventoryListType['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.AzureDevOpsOrgProperties.properties.onboardingState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.AzureDevOpsOrgProperties.properties.provisioningState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.AzureDevOpsProjectProperties.properties.onboardingState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.AzureDevOpsProjectProperties.properties.provisioningState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.AzureDevOpsRepositoryProperties.properties.onboardingState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.AzureDevOpsRepositoryProperties.properties.provisioningState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.CategoryConfiguration.properties.category['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.DevOpsConfigurationProperties.properties.autoDiscovery['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.DevOpsConfigurationProperties.properties.provisioningState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.GitHubOwnerProperties.properties.onboardingState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.GitHubOwnerProperties.properties.provisioningState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.GitHubRepositoryProperties.properties.onboardingState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.GitHubRepositoryProperties.properties.provisioningState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.GitLabGroupProperties.properties.onboardingState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.GitLabGroupProperties.properties.provisioningState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.GitLabProjectProperties.properties.onboardingState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.GitLabProjectProperties.properties.provisioningState['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.InventoryList.properties.inventoryKind['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |
| `definitions.TargetBranchConfiguration.properties.annotateDefaultBranch['x-ms-enum'].modelAsExtensible__deleted` | deleted | `true` |

### Changes for `example`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Authorization.properties.code.example__deleted` | deleted | `00000000000000000000.` |
| `definitions.AzureDevOpsOrgProperties.properties.provisioningStatusMessage.example__deleted` | deleted | `Resource onboarded successful.` |
| `definitions.AzureDevOpsProjectProperties.properties.provisioningStatusMessage.example__deleted` | deleted | `Resource onboarded successful.` |
| `definitions.AzureDevOpsRepositoryProperties.properties.provisioningStatusMessage.example__deleted` | deleted | `Resource onboarded successful.` |
| `definitions.DevOpsConfigurationProperties.properties.provisioningStatusMessage.example__deleted` | deleted | `Resource onboarded successful.` |
| `definitions.GitHubOwnerProperties.properties.provisioningStatusMessage.example__deleted` | deleted | `Resource onboarded successful.` |
| `definitions.GitHubRepositoryProperties.properties.provisioningStatusMessage.example__deleted` | deleted | `Resource onboarded successful.` |
| `definitions.GitLabGroupProperties.properties.provisioningStatusMessage.example__deleted` | deleted | `Resource onboarded successful.` |
| `definitions.GitLabProjectProperties.properties.provisioningStatusMessage.example__deleted` | deleted | `Resource onboarded successful.` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AzureDevOpsOrg.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.AzureDevOpsProject.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.AzureDevOpsRepository.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.DevOpsConfiguration.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.GitHubOwner.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.GitHubRepository.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.GitLabGroup.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.GitLabProject.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ActionableRemediation.properties.inheritFromParentState.description` | `Update Settings.

Enabled - Resource should inherit configurations from parent.
Disabled - Resource should not inherit configurations from parent.` | `Update Settings.

Enabled - Resource should inherit configurations from parent.
Disabled - Resource should not inherit configurations from parent.` |
| `definitions.ActionableRemediation.properties.state.description` | `ActionableRemediation Setting.
None - the setting was never set.
Enabled - ActionableRemediation is enabled.
Disabled - ActionableRemediation is disabled.` | `ActionableRemediation Setting.
None - the setting was never set.
Enabled - ActionableRemediation is enabled.
Disabled - ActionableRemediation is disabled.` |
| `definitions.AgentlessConfiguration.properties.inventoryList.description` | `Gets or sets the inventory list for inclusion or exclusion from Agentless.
Will be ignored if agentless auto-discovery is enabled.` | `Gets or sets the inventory list for inclusion or exclusion from Agentless.
Will be ignored if agentless auto-discovery is enabled.` |
| `definitions.Authorization.properties.code.description` | `Gets or sets one-time OAuth code to exchange for refresh and access tokens.

Only used during PUT/PATCH operations. The secret is cleared during GET.` | `Gets or sets one-time OAuth code to exchange for refresh and access tokens.

Only used during PUT/PATCH operations. The secret is cleared during GET.` |
| `definitions.AzureDevOpsOrg.allOf[0].$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.AzureDevOpsOrgProperties.properties.onboardingState.description` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` |
| `definitions.AzureDevOpsOrgProperties.properties.provisioningState.description` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` |
| `definitions.AzureDevOpsProject.allOf[0].$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.AzureDevOpsProjectProperties.properties.onboardingState.description` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` |
| `definitions.AzureDevOpsProjectProperties.properties.provisioningState.description` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` |
| `definitions.AzureDevOpsRepository.allOf[0].$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.AzureDevOpsRepositoryProperties.properties.onboardingState.description` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` |
| `definitions.AzureDevOpsRepositoryProperties.properties.provisioningState.description` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` |
| `definitions.CategoryConfiguration.properties.category.description` | `Rule categories.
Code - code scanning results.
Artifact scanning results.
Dependencies scanning results.
IaC results.
Secrets scanning results.
Container scanning results.` | `Rule categories.
Code - code scanning results.
Artifact scanning results.
Dependencies scanning results.
IaC results.
Secrets scanning results.
Container scanning results.` |
| `definitions.DevOpsConfiguration.allOf[0].$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.DevOpsConfigurationProperties.properties.provisioningState.description` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` |
| `definitions.DevOpsConfigurationProperties.properties.topLevelInventoryList.description` | `List of top-level inventory to select when AutoDiscovery is disabled.
This field is ignored when AutoDiscovery is enabled.` | `List of top-level inventory to select when AutoDiscovery is disabled.
This field is ignored when AutoDiscovery is enabled.` |
| `definitions.GitHubOwner.allOf[0].$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.GitHubOwnerProperties.properties.onboardingState.description` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` |
| `definitions.GitHubOwnerProperties.properties.provisioningState.description` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` |
| `definitions.GitHubRepository.allOf[0].$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.GitHubRepositoryProperties.properties.onboardingState.description` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` |
| `definitions.GitHubRepositoryProperties.properties.provisioningState.description` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` |
| `definitions.GitHubRepositoryProperties.properties.repoFullName.description` | `Gets or sets GitHub Full Name.
Repository name, prefixed with Owner name.
Eg: "my-org/new-repo-1".` | `Gets or sets GitHub Full Name.
Repository name, prefixed with Owner name.
Eg: "my-org/new-repo-1".` |
| `definitions.GitHubRepositoryProperties.properties.repoId.description` | `Gets or sets GitHub Repository id.

This is a numeric id defined by Github.
Eg: "123456".` | `Gets or sets GitHub Repository id.

This is a numeric id defined by Github.
Eg: "123456".` |
| `definitions.GitHubRepositoryProperties.properties.repoName.description` | `Gets or sets GitHub Repository name.
Eg: "new-repo-1".` | `Gets or sets GitHub Repository name.
Eg: "new-repo-1".` |
| `definitions.GitLabGroup.allOf[0].$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.GitLabGroupProperties.properties.fullyQualifiedFriendlyName.description` | `Gets or sets the human readable fully-qualified name of the Group object.

This contains the entire namespace hierarchy as seen on GitLab UI where namespaces are separated by the '/' character.` | `Gets or sets the human readable fully-qualified name of the Group object.

This contains the entire namespace hierarchy as seen on GitLab UI where namespaces are separated by the '/' character.` |
| `definitions.GitLabGroupProperties.properties.fullyQualifiedName.description` | `Gets or sets the fully-qualified name of the Group object.

This contains the entire namespace hierarchy where namespaces are separated by the '$' character.` | `Gets or sets the fully-qualified name of the Group object.

This contains the entire namespace hierarchy where namespaces are separated by the '$' character.` |
| `definitions.GitLabGroupProperties.properties.onboardingState.description` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` |
| `definitions.GitLabGroupProperties.properties.provisioningState.description` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` |
| `definitions.GitLabProject.allOf[0].$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.GitLabProjectProperties.properties.fullyQualifiedFriendlyName.description` | `Gets or sets the human readable fully-qualified name of the Project object.

This contains the entire namespace hierarchy as seen on GitLab UI where entities are separated by the '/' character.` | `Gets or sets the human readable fully-qualified name of the Project object.

This contains the entire namespace hierarchy as seen on GitLab UI where entities are separated by the '/' character.` |
| `definitions.GitLabProjectProperties.properties.fullyQualifiedName.description` | `Gets or sets the fully-qualified name of the project object.

This contains the entire hierarchy where entities are separated by the '$' character.` | `Gets or sets the fully-qualified name of the project object.

This contains the entire hierarchy where entities are separated by the '$' character.` |
| `definitions.GitLabProjectProperties.properties.fullyQualifiedParentGroupName.description` | `Gets or sets the fully-qualified name of the project's parent group object.

This contains the entire hierarchy where namespaces are separated by the '$' character.` | `Gets or sets the fully-qualified name of the project's parent group object.

This contains the entire hierarchy where namespaces are separated by the '$' character.` |
| `definitions.GitLabProjectProperties.properties.onboardingState.description` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` | `Details about resource onboarding status across all connectors.

OnboardedByOtherConnector - this resource has already been onboarded to another connector. This is only applicable to top-level resources.
Onboarded - this resource has already been onboarded by the specified connector.
NotOnboarded - this resource has not been onboarded to any connector.
NotApplicable - the onboarding state is not applicable to the current endpoint.` |
| `definitions.GitLabProjectProperties.properties.provisioningState.description` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` | `The provisioning state of the resource.

Pending - Provisioning pending.
Failed - Provisioning failed.
Succeeded - Successful provisioning.
Canceled - Provisioning canceled.
PendingDeletion - Deletion pending.
DeletionSuccess - Deletion successful.
DeletionFailure - Deletion failure.` |
| `definitions.TargetBranchConfiguration.properties.annotateDefaultBranch.description` | `Configuration of PR Annotations on default branch.

Enabled - PR Annotations are enabled on the resource's default branch.
Disabled - PR Annotations are disabled on the resource's default branch.` | `Configuration of PR Annotations on default branch.

Enabled - PR Annotations are enabled on the resource's default branch.
Disabled - PR Annotations are disabled on the resource's default branch.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].patch.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}'].patch.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}'].patch.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}/repos'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}/repos/{repoName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}/repos/{repoName}'].patch.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/azureDevOpsOrgs/{orgName}/projects/{projectName}/repos/{repoName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitHubOwners'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitHubOwners/{ownerName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitHubOwners/{ownerName}/repos'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitHubOwners/{ownerName}/repos/{repoName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitHubOwners/{ownerName}/repos/{repoName}/issues'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitLabGroups'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitLabGroups/{groupFQName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitLabGroups/{groupFQName}/listSubgroups'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitLabGroups/{groupFQName}/projects'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/gitLabGroups/{groupFQName}/projects/{projectName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/listAvailableAzureDevOpsOrgs'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/listAvailableGitHubOwners'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/listAvailableGitLabGroups'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/operationResults/{operationResultId}'].get.responses.200.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/OperationStatusResult` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/OperationStatusResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Security/securityConnectors/{securityConnectorName}/devops/default/operationResults/{operationResultId}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

