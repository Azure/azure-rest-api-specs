# Machine Learning Services API Version Migration Analysis
## 2025-07-01-preview → 2025-09-01 (stable)

**Purpose:** Track all features, properties, and definitions from preview that did not migrate to stable for follow-up with feature owners.

---

## Executive Summary

| Swagger File | Missing Paths | Missing Definitions | Definitions with Property Gaps | Enum Value Changes |
|--------------|---------------|---------------------|-------------------------------|-------------------|
| **machineLearningServices.json** | 5 | 4 | 5 | 1 |
| **workspaceRP.json** | 28 | 77 | 9 | 0 |
| **mfe.json** | 14 | 58 | 6 | 0 |
| **registries.json** | 0 | 0 | 0 | 0 |
| **workspaceFeatures.json** | 0 | 0 | 0 | 0 |
| **TOTAL** | **47** | **139** | **20** | **1** |

---

## 1. machineLearningServices.json

### 1.1 Missing Operation Paths (5)

#### Compute Management
1. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/resize`
   - **Feature:** Compute instance resize capability
   - **Impact:** Unable to resize compute instances via API

2. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/customServices`
   - **Feature:** Custom services on compute instances
   - **Impact:** Cannot manage custom services

3. **PATCH** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/customServices/{serviceName}`
   - **Feature:** Custom service updates
   - **Impact:** Cannot update custom service configurations

4. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/dataMounts`
   - **Feature:** Data mount management
   - **Impact:** Cannot configure data mounts on compute instances

5. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/computes/{computeName}/idleShutdown`
   - **Feature:** Idle shutdown configuration
   - **Impact:** Cannot configure idle shutdown behavior

### 1.2 Missing Schema Definitions (4)

1. **OsPatchingStatus** - OS patching status tracking
2. **JupyterKernelConfig** - Jupyter kernel configuration for custom services
3. **ComputeInstanceAutologgerSettings** - Auto-logger configuration settings
4. **ResizeSchema** - Schema for resize operations

### 1.3 Properties Missing from Existing Definitions (5 definitions, 14 properties)

#### ComputeInstanceDataMount
- `mountMode` - Mount mode specification (read-only vs read-write)

#### ImageMetadata
- `osPatchingStatus` - OS patching status information

#### Image
- `version` - Image version tracking

#### ComputeInstanceProperties (6 missing properties)
- `autologgerSettings` - Auto-logger configuration
- `enableOSPatching` - Enable/disable OS patching
- `enableRootAccess` - Root access control
- `enableSSO` - Single sign-on enablement
- `releaseQuotaOnStop` - Quota release behavior
- `idleTimeBeforeShutdown` - Idle time configuration

#### CustomService
- `kernel` - Jupyter kernel configuration

### 1.4 Missing Enum Values (1 definition, 2 values)

#### ComputeInstanceLastOperation.name
- `ResizeFailed` - Failed resize operation state
- `Resize` - Resize operation state

---

## 2. workspaceRP.json

### 2.1 Missing Operation Paths (28)

#### Endpoint Management (7 paths)
1. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints`
2. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}`
3. **PUT** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}`
4. **PATCH** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}`
5. **DELETE** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}`
6. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/listKeys`
7. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/regenerateKeys`

#### Endpoint Deployment Management (6 paths)
8. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments`
9. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}`
10. **PUT** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}`
11. **PATCH** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}`
12. **DELETE** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}`
13. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/endpoints/{endpointName}/deployments/{deploymentName}/listSkus`

#### RAI (Responsible AI) Management (6 paths)
14. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/raiPolicies`
15. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/raiPolicies/{raiPolicyName}`
16. **PUT** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/raiPolicies/{raiPolicyName}`
17. **DELETE** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/raiPolicies/{raiPolicyName}`
18. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/raiBlocklists`
19. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/raiBlocklists/{raiBlocklistName}`

#### Connection Management (3 paths)
20. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}/listsecrets`
21. **DELETE** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}`
22. **PATCH** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/connections/{connectionName}`

#### Managed Network V2 (4 paths)
23. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworkProvisions/{managedNetworkProvisionName}`
24. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/managedNetworkSettingsRules/{ruleName}`
25. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundRules/{ruleName}`
26. **DELETE** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/outboundRules/{ruleName}`

#### Workspace Features (2 paths)
27. **PATCH** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}`
28. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/resyncKeys`

### 2.2 Missing Schema Definitions (77)

#### Account & Keys
1. AccountApiKeys
2. AccountApiKeysResult

#### Content Safety
3. AllowedContentLevel
4. AllowedContentLevelResult

#### Endpoint Core
5. Endpoint
6. EndpointAuthKeys
7. EndpointAuthKeysResult
8. EndpointAuthMode
9. EndpointAuthToken
10. EndpointComputeType
11. EndpointDeployment
12. EndpointDeploymentProperties
13. EndpointDeploymentPropertiesBasicResource
14. EndpointDeploymentPropertiesBasicResourceArmPaginatedResult
15. EndpointDeploymentPropertiesResourceBaseProperties
16. EndpointDeploymentResourceProperties
17. EndpointDeploymentResourcePropertiesBasicResource
18. EndpointDeploymentResourcePropertiesBasicResourceArmPaginatedResult
19. EndpointDeploymentResourcePropertiesResourceBaseProperties
20. EndpointDeploymentState
21. EndpointProperties
22. EndpointPropertiesArmPaginatedResult
23. EndpointPropertiesBaseResource
24. EndpointProvisioningState
25. EndpointRequestSettings
26. EndpointType

#### Kubernetes Endpoint
27. KubernetesDeploymentProperties
28. KubernetesEndpointProperties

#### Managed Network V2
29. ManagedNetworkProvision
30. ManagedNetworkProvisionStatus
31. ManagedNetworkSettingsRule

#### Managed Online Endpoint/Deployment
32. ManagedOnlineDeployment
33. ManagedOnlineDeploymentProperties
34. ManagedOnlineEndpoint
35. ManagedOnlineEndpointProperties

#### RAI (Responsible AI)
36. RaiBlocklist
37. RaiBlocklistConfig
38. RaiBlocklistItemBulkRequest
39. RaiBlocklistItemProperties
40. RaiBlocklistItemPropertiesBasicResourceArmPaginatedResult
41. RaiBlocklistProperties
42. RaiBlocklistPropertiesArmPaginatedResult
43. RaiPolicyContentFilter
44. RaiPolicyProperties
45. RaiPolicyPropertiesArmPaginatedResult
46. RaiPolicyType

#### Serverless Endpoint/Deployment
47. ServerlessDeploymentProperties
48. ServerlessEndpoint
49. ServerlessEndpointProperties

#### Workspace Connection
50. ConnectionAuthType
51. WorkspaceConnectionAccessKey
52. WorkspaceConnectionAccountKey
53. WorkspaceConnectionApiKey
54. WorkspaceConnectionManagedIdentity
55. WorkspaceConnectionOAuth2
56. WorkspaceConnectionPersonalAccessToken
67. WorkspaceConnectionProperties
58. WorkspaceConnectionPropertiesArmPaginatedResult
59. WorkspaceConnectionPropertiesBasicResource
60. WorkspaceConnectionPropertiesBasicResourceArmPaginatedResult
61. WorkspaceConnectionPropertiesV2
62. WorkspaceConnectionPropertiesV2BasicResource
63. WorkspaceConnectionPropertiesV2BasicResourceArmPaginatedResult
64. WorkspaceConnectionSas
65. WorkspaceConnectionServicePrincipal
66. WorkspaceConnectionSharedAccessSignature
67. WorkspaceConnectionUsernamePassword

#### Workspace Features
68. FeatureStoreSettings
69. ManagedNetworkProvisionOptions
70. ManagedNetworkSettings
71. ServerlessComputeSettings
72. SystemCreatedAcrAccount
73. SystemCreatedStorageAccount
74. WorkspacePropertiesEncryptionOnlineEndpointsCosmosDb
75. WorkspacePropertiesEncryptionOnlineEndpointsSearchAccount
76. WorkspaceUpdateParametersProperties
77. WorkspaceUpdateParametersPropertiesEncryptionOnlineEndpointsCosmosDb

### 2.3 Properties Missing from Existing Definitions (9 definitions, 45 properties)

#### WorkspacePropertiesUpdateParameters (5 properties)
- `allowRoleAssignmentOnRG` - Role assignment permission control
- `enableSoftwareBillOfMaterials` - SBOM generation enablement
- `ipAllowlist` - IP allowlist configuration
- `networkAcls` - Network ACL settings
- `softDeleteRetentionInDays` - Soft delete retention period

#### WorkspaceProperties (11 properties)
- `agentsEndpointUri` - Agents endpoint URI
- `enableSimplifiedCmk` - Simplified CMK enablement
- `enableSoftwareBillOfMaterials` - SBOM enablement
- `ipAllowlist` - IP allowlist
- `networkAcls` - Network ACLs
- `serverlessComputeSettings` - Serverless compute configuration
- `softDeleteRetentionInDays` - Soft delete retention
- `containerRegistries` - Container registry list
- `keyVaults` - Key vault list
- `storageAccounts` - Storage account list
- `systemCreatedResources` - System-created resource tracking

#### WorkspaceConnectionPropertiesV2 (4 properties)
- `error` - Error information
- `peRequirement` - Private endpoint requirement
- `peStatus` - Private endpoint status
- `useWorkspaceManagedIdentity` - Use workspace managed identity

#### EncryptionProperty (3 properties)
- `cosmosDbResourceId` - Cosmos DB resource ID for encryption
- `searchAccountResourceId` - Search account resource ID
- `storageAccountResourceId` - Storage account resource ID

#### AssetBase (1 property)
- `stage` - Asset lifecycle stage

#### ComputeInstanceProperties (13 properties)
- `customServices` - Custom services configuration
- `enableNodePublicIp` - Node public IP enablement
- `osImageMetadata` - OS image metadata
- `setupScripts` - Setup scripts configuration
- `autologgerSettings` - Auto-logger settings
- `enableOSPatching` - OS patching enablement
- `enableRootAccess` - Root access control
- `enableSSO` - SSO enablement
- `idleTimeBeforeShutdown` - Idle shutdown timer
- `releaseQuotaOnStop` - Quota release on stop
- `computeInstanceAuthorizationType` - Authorization type
- `lastOperation` - Last operation info
- `state` - Current state

#### AmlComputeProperties (1 property)
- `propertyBag` - Property bag for additional properties

#### RegistryListCredentialsResult (1 property)
- `passwords` - Password list

#### ModelVersionResourceArmPaginatedResult (6 properties)
- `nextLink` - Pagination next link
- `value` - Model version list
- `properties` - Properties bag
- `systemData` - System data
- `id` - Resource ID
- `name` - Resource name

#### EnvironmentVersionResourceArmPaginatedResult (6 properties)
- `nextLink` - Pagination link
- `value` - Environment version list
- `properties` - Properties
- `systemData` - System data
- `id` - Resource ID
- `name` - Resource name

---

## 3. mfe.json (Model Front-End)

### 3.1 Missing Operation Paths (14)

#### PTU Quota Management (3 paths)
1. **GET** `/subscriptions/{subscriptionId}/providers/Microsoft.MachineLearningServices/locations/{location}/availableQuota`
   - **Feature:** Available PTU quota listing
2. **GET** `/subscriptions/{subscriptionId}/providers/Microsoft.MachineLearningServices/locations/{location}/availableQuota/default`
   - **Feature:** Default available quota information
3. **GET** `/subscriptions/{subscriptionId}/providers/Microsoft.MachineLearningServices/locations/{location}/quotaAndUsage`
   - **Feature:** Quota and usage details

#### Inference Pool Management (11 paths)
4. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools`
   - **Feature:** List inference pools
5. **GET/PUT/PATCH/DELETE** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{inferencePoolName}`
   - **Feature:** Inference pool CRUD operations
6. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints`
   - **Feature:** List pool endpoints
7. **GET/PUT/PATCH/DELETE** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/endpoints/{endpointName}`
   - **Feature:** Endpoint CRUD operations
8. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups`
   - **Feature:** List inference groups
9. **GET/PUT/PATCH/DELETE** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}`
   - **Feature:** Group CRUD operations
10. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/getStatus`
    - **Feature:** Delta model status
11. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/list`
    - **Feature:** List delta models
12. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/deltaModels/modify`
    - **Feature:** Modify delta models
13. **POST** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/getStatus`
    - **Feature:** Group status
14. **GET** `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningServices/workspaces/{workspaceName}/inferencePools/{poolName}/groups/{groupName}/skus`
    - **Feature:** Available SKUs for group

### 3.2 Missing Schema Definitions (58)

#### Capacity & Quota
1. ActualCapacityInfo
2. AvailableQuota
3. AvailableQuotaArmPaginatedResult
4. AvailableQuotaProperties
5. PTUDeploymentUsage
6. ScaleUnitConfiguration
7. UsageAndQuotaDetails
8. UsageAndQuotaDetailsArmPaginatedResult

#### Inference Pool Core
9. InferencePool
10. InferencePoolTrackedResource
11. InferencePoolTrackedResourceArmPaginatedResult
12. InferenceEndpoint
13. InferenceEndpointTrackedResource
14. InferenceEndpointTrackedResourceArmPaginatedResult
15. InferenceGroup
16. InferenceGroupTrackedResource
17. InferenceGroupTrackedResourceArmPaginatedResult
18. PoolProvisioningState

#### Fine-tuning & Distillation
19. AzureOpenAiFineTuning
20. AzureOpenAiHyperParameters
21. CustomModelFineTuning
22. DistillationJob
23. FineTuningJob
24. FineTuningTaskType
25. FineTuningVertical
26. FinetuningDetails
27. TeacherModelEndpoint
28. TeacherModelEndpointRequestSettings
29. TeacherModelSettings
30. JobResources

#### Data Generation
31. DataGenerationTaskType
32. DataGenerationType
33. DataGenerationVertical
34. DatasetReference
35. LabelGeneration
36. PromptSettings

#### Delta Models
37. DeltaModelCurrentState
38. DeltaModelListRequest
39. DeltaModelModifyRequest
40. DeltaModelStatusRequest
41. DeltaModelStatusResponse

#### Group Configuration
42. GroupEnvironmentConfiguration
43. GroupModelConfiguration
44. GroupStatus
45. RequestConfiguration

#### Image & Package Management
46. ImageDetails
47. ImageInfo
48. PackageDetails
49. VulnerabilityDetails
50. VulnerabilityFindings
51. VulnerabilityRisk

#### Authentication & Security
52. AuthMode
53. ContentSafetyLevel
54. SecretExpiry

#### Miscellaneous
55. ModelProvider
56. PropertiesBase
57. StringArmPaginatedResult
58. StringStringKeyValuePair

### 3.3 Properties Missing from Existing Definitions (6 definitions, 6 properties)

#### JobResourceConfiguration
- `dockerArgsList` - Docker arguments list

#### AssetJobOutput
- `assetName` - Asset name reference

#### JobBase
- `parentJobName` - Parent job reference for hierarchical jobs

#### EnvironmentVersion
- `imageDetails` - Detailed image information including vulnerability scanning

#### ContentSafety
- `contentSafetyLevel` - Content safety level configuration

#### ModelVersion
- `datasets` - Associated datasets for the model

---

## 4. registries.json
✅ **NO DIFFERENCES** - All preview features successfully migrated to stable

---

## 5. workspaceFeatures.json
✅ **NO DIFFERENCES** - All preview features successfully migrated to stable

---

## Feature Categories for Follow-up

### HIGH PRIORITY - Major Feature Sets Missing

#### 1. Inference Pools (mfe.json)
- **Scope:** Entire inference pool management system (14 endpoints, 58 definitions)
- **Feature Owner:** Model deployment team
- **Impact:** Cannot manage inference pools, groups, endpoints, or delta models
- **Questions:**
  - What is the timeline for GA of inference pools?
  - Are there blocking issues preventing GA?
  - Is this feature being reconsidered or redesigned?

#### 2. Endpoints & Deployments (workspaceRP.json)
- **Scope:** Workspace-level endpoints (13 endpoints, multiple definitions)
- **Feature Owner:** Endpoint management team
- **Impact:** Cannot create/manage workspace endpoints outside of inference pools
- **Questions:**
  - Is this being replaced by inference pools?
  - What is the relationship between workspace endpoints and inference pools?
  - Timeline for GA?

#### 3. RAI (Responsible AI) Management (workspaceRP.json)
- **Scope:** RAI policies and blocklists (6 endpoints, ~10 definitions)
- **Feature Owner:** Responsible AI team
- **Impact:** Cannot configure content filtering, RAI policies, or blocklists
- **Questions:**
  - What is blocking RAI features from GA?
  - Are there compliance or legal reviews pending?
  - Alternative approaches for content safety?

#### 4. PTU Quota Management (mfe.json)
- **Scope:** Available quota and usage (3 endpoints, 8 definitions)
- **Feature Owner:** Capacity management team
- **Impact:** Cannot query available PTU quota programmatically
- **Questions:**
  - Is this being consolidated with other quota APIs?
  - Timeline for GA?

### MEDIUM PRIORITY - Feature Enhancements

#### 5. Compute Instance Enhancements (machineLearningServices.json)
- **Missing Operations:** Resize, custom services, data mounts, idle shutdown
- **Missing Properties:** Auto-logger, OS patching, root access, SSO, quota release
- **Feature Owner:** Compute team
- **Questions:**
  - Are these features being redesigned?
  - What is the priority for these enhancements?

#### 6. Workspace Features (workspaceRP.json)
- **Missing Properties:** Agents endpoint, simplified CMK, SBOM, network ACLs, soft delete
- **Feature Owner:** Workspace team
- **Questions:**
  - Which properties are planned for next release?
  - Are any properties being deprecated?

#### 7. Connection Management Enhancements (workspaceRP.json)
- **Missing Operations:** Delete, patch, list secrets
- **Missing Properties:** Private endpoint status, workspace managed identity
- **Feature Owner:** Workspace connections team
- **Questions:**
  - Why is delete/patch not in stable?
  - Timeline for private endpoint features?

### LOW PRIORITY - Minor Enhancements

#### 8. Job & Model Enhancements (mfe.json)
- **Missing Properties:** Parent job name, asset name, docker args list
- **Feature Owner:** Jobs/training team

#### 9. Environment Version (mfe.json)
- **Missing Properties:** Image details with vulnerability scanning
- **Feature Owner:** Environment team

---

## Next Steps

1. **Identify Feature Owners:** Map each feature category to specific engineering teams
2. **Schedule Reviews:** Set up meetings with each team to discuss:
   - Reasons for exclusion from stable
   - Timeline for GA
   - Any breaking changes or redesigns planned
3. **Document Decisions:** Record whether exclusions are:
   - Temporary (coming in next release)
   - Long-term (major redesign needed)
   - Deprecated (feature being removed)
4. **Track Progress:** Set up tracking for each feature set with target GA dates
5. **ARM Compliance:** Ensure all exclusions align with ARM swagger versioning guidelines

---

## ARM Swagger Versioning Guidelines Reference

Per ARM guidelines, preview API versions should be a superset of stable versions unless there are intentional breaking changes. This analysis identifies 47 operation paths, 139 schema definitions, and 20+ property additions that are not following this pattern. Each exclusion should be justified and tracked.
