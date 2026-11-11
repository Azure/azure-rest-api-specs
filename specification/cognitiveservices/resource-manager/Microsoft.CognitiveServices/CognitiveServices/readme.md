# CognitiveServices

> see https://aka.ms/autorest

This is the AutoRest configuration file for CognitiveServices.

# Notice

Microsoft will use data you send to Bing Search Services or the Translator Speech API to improve Microsoft products and services. Where you send personal data to these Cognitive Services, you are responsible for obtaining sufficient consent from the data subjects. The General Privacy and Security Terms in the Online Services Terms do not apply to these Cognitive Services. Please refer to the Microsoft Cognitive Services section in the [Online Services Terms](https://www.microsoft.com/en-us/Licensing/product-licensing/products.aspx) for details. Microsoft offers policy controls that may be used to [disable new Cognitive Services deployments](https://learn.microsoft.com/azure/cognitive-services/cognitive-services-apis-create-account).

---

## Getting Started

To build the SDK for CognitiveServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the CognitiveServices API.

```yaml
openapi-type: arm
tag: package-2026-11-01
```

### Tag: package-2026-11-15-preview

These settings apply only when `--tag=package-2026-11-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-11-15-preview'
input-file:
  - preview/2026-11-15-preview/cognitiveservices.json
suppressions:
  - code: DefinitionsPropertiesNamesCamelCase
    reason: The acs property embeds a separately versioned Agent Control Specification document. These fields retain the canonical ACS snake_case wire names so customers can import, export, validate, and round-trip ACS manifests without translation; generated SDKs expose idiomatic camelCase names through x-ms-client-name.
    from: cognitiveservices.json
    where:
      - $.definitions.RaiAcsHarmConfiguration.properties.harm_config_id
      - $.definitions.RaiAcsAgentShutdownInterventionPoint.properties.policy_target
      - $.definitions.RaiAcsAgentShutdownInterventionPoint.properties.policy_target_kind
      - $.definitions.RaiAcsAgentStartupInterventionPoint.properties.policy_target
      - $.definitions.RaiAcsAgentStartupInterventionPoint.properties.policy_target_kind
      - $.definitions.RaiAcsPreModelCallInterventionPoint.properties.policy_target
      - $.definitions.RaiAcsPreModelCallInterventionPoint.properties.policy_target_kind
      - $.definitions.RaiAcsPostModelCallInterventionPoint.properties.policy_target
      - $.definitions.RaiAcsPostModelCallInterventionPoint.properties.policy_target_kind
      - $.definitions.RaiAcsInterventionPoints.properties.agent_startup
      - $.definitions.RaiAcsInterventionPoints.properties.pre_model_call
      - $.definitions.RaiAcsInterventionPoints.properties.post_model_call
      - $.definitions.RaiAcsInterventionPoints.properties.agent_shutdown
      - $.definitions.RaiAcsInterventionPoint.properties.policy_target
      - $.definitions.RaiAcsInterventionPoint.properties.policy_target_kind
      - $.definitions.RaiAcsToolInterventionPoint.properties.policy_target
      - $.definitions.RaiAcsToolInterventionPoint.properties.policy_target_kind
      - $.definitions.RaiAcsToolInterventionPoint.properties.tool_name_from
      - $.definitions.RaiAcsInterventionPoints.properties.pre_tool_call
      - $.definitions.RaiAcsInterventionPoints.properties.post_tool_call
      - $.definitions.RaiAcsManifest.properties.agent_control_specification_version
      - $.definitions.RaiAcsManifest.properties.intervention_points
      - $.definitions.RaiAcsModerationBindingExtension.properties.subject_format
      - $.definitions.RaiAcsModerationBindingExtension.properties.harm_configs
      - $.definitions.RaiAcsPolicyBinding.properties.aacs_moderation
      - $.definitions.RaiAcsToolDefinition.properties.security_labels
  - code: AvoidAdditionalProperties
    reason: The canonical ACS manifest defines metadata and tool entries as extensible JSON objects, and policies and tools as name-keyed maps. Replacing these objects with closed properties or arrays would break ACS manifest portability and round-tripping.
    from: cognitiveservices.json
    where:
      - $.definitions.RaiAcsManifest.properties.metadata
      - $.definitions.RaiAcsManifest.properties.policies
      - $.definitions.RaiAcsManifest.properties.tools
      - $.definitions.RaiAcsToolDefinition
  - code: AvoidAdditionalProperties
    reason: ACS annotator declarations and intervention-point bindings are canonical name-keyed maps with host-defined configuration. Typed entries retain required type/from fields; closed properties or arrays would break manifest portability and round-tripping.
    from: cognitiveservices.json
    where:
      - $.definitions.RaiAcsAnnotatorDefinition
      - $.definitions.RaiAcsAnnotationBinding
      - $.definitions.RaiAcsManifest.properties.annotators
      - $.definitions.RaiAcsInterventionPoint.properties.annotations
      - $.definitions.RaiAcsToolInterventionPoint.properties.annotations
      - $.definitions.RaiAcsAgentStartupInterventionPoint.properties.annotations
      - $.definitions.RaiAcsPreModelCallInterventionPoint.properties.annotations
      - $.definitions.RaiAcsPostModelCallInterventionPoint.properties.annotations
      - $.definitions.RaiAcsAgentShutdownInterventionPoint.properties.annotations
  - code: PutResponseCodes
    reason: Compute create is a genuine long-running async operation - the service returns 202 Accepted on success (never 200/201) and 4xx on failure. Modeling 202-only reflects the real backend contract (live-validated). Preview-only bug fix correcting the contract before GA.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"].put
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Compute create returns 202 Accepted for long-running provisioning. provisioningState is present in ComputeProperties and returned in the final LRO result retrieved via GET. Preview-only bug fix.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"].put
  - code: PutGetPatchResponseSchema
    reason: Compute create PUT is 202-only with no response body, so its response schema intentionally differs from GET, which returns the Compute resource once the LRO completes. This is inherent to the async 202-only contract. Preview-only bug fix.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"]
  - code: NestedResourcesMustHaveListOperation
    reason: ComputeOperationStatus is an async operation status polling resource, listing all operations is not applicable.
    from: cognitiveservices.json
    where:
      - $.definitions.ComputeOperationStatus
  - code: ArmResourcePropertiesBag
    reason: OutboundRule.properties.type is the existing outbound-rule kind discriminator, distinct from the top-level ARM resource type. Renaming this field would change the released rule payload and requires coordinated backend and versioned-contract changes; a narrowly scoped legacy exception is requested.
    from: cognitiveservices.json
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: ManagedNetworkSettings.outboundRules is the existing dictionary of caller-named outbound rules with explicitly modeled rule values. Replacing this map with fixed properties or an array would change the released managed-network payload; review is requested for this specific legacy map representation.
    from: cognitiveservices.json
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: These released managed-network and outbound-rule PUT contracts return 200 or 202, not 201. The managed-network 200 model exposes provisioningState; outbound rules expose their existing status field instead. Inventing a 201 response or a new provisioningState in Swagger would not fix the underlying service behavior; review is requested for the scoped legacy contract.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: Managed-network and outbound-rule PUT operations use the released 200 synchronous-completion and 202 asynchronous-acceptance contracts with polling headers. They do not advertise 201; changing response codes requires backend alignment rather than a Swagger-only change. A scoped legacy exception is requested.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: ProvisioningStateSpecifiedForLROPut
    reason: >-
      From 2026-11-15-preview, customer-initiated Project creates use the service's existing 202 Accepted LRO response instead of 201.
      The 200 update and 202 create responses include the Project resource with provisioningState.
      The missing 201 response schema is intentional and reflects the RP response contract, not a missing provisioningState property.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
  - code: PutResponseCodes
    reason: November preview Project PUT uses 200 for updates and 202 for asynchronous creation after the scoped correction in PR 47911; it does not advertise 201. Synchronous connection PUT operations return 200. Review is requested for these exact contracts rather than adding responses the service does not return.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: The released Project PATCH contract includes a Project body on 202 Accepted as well as on 200 completion. Removing that body only from Swagger would change the documented contract without changing the service; review is requested for this specific legacy asynchronous-response shape.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: Connection PATCH still requires authType during backend polymorphic binding, and managed-compute deployment PATCH uses the existing SKU shape with its required name. These inherited partial-update restrictions are not fixed by changing Swagger alone. The connection deferral in https://github.com/Azure/azure-rest-api-specs/pull/47307#discussion_r4485773604 applies to November stable only; coordinated preview fixes remain outstanding.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedComputeDeployments/{deploymentName}"].patch.parameters[5].schema.properties.sku
  - code: PatchBodyParametersSchema
    reason: >-
      The optional cost-control filter is replaced atomically rather than merged.
      A supplied tag condition requires name, operator, and values to form a valid replacement.
      The validator maps these nested filter diagnostics to the PATCH properties bag.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/costControls/{costControlName}"].patch.parameters[6].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/costControls/{costControlName}"].patch.parameters[7].schema.properties.properties
  - code: AvoidAdditionalProperties
    reason: >-
      Cost-control notifications and provider actions are dictionaries keyed by customer-defined names, following the Azure Budget notifications pattern.
      Each value has an explicit notification or action schema; PATCH also accepts null entries to delete named items.
      Replacing these dictionaries with fixed properties or arrays would change the public REST contract.
    from: cognitiveservices.json
    where:
      - $.definitions.CostControlProperties.properties.notifications
      - $.definitions.CostControlPatchProperties.properties.notifications
      - $.definitions.CostControlProviderProperties.properties.actions
      - $.definitions.CostControlProviderPropertiesPatch.properties.actions
  - code: DeleteResponseCodes
    reason: These Project and managed-compute deployment DELETE contracts allow immediate completion with 200 or 204 and asynchronous acceptance with 202 and polling headers. Review is requested for the exact existing response codes rather than silently changing the documented completion behavior.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedComputeDeployments/{deploymentName}"].delete
  - code: AvoidAdditionalProperties
    reason: Connection metadata uses caller-defined string keys, and CustomKeys.keys accepts caller-defined credential/header names with string secret values. Fixed property names would not represent these inputs. Custom keys remain write-side credentials and are excluded from ordinary November responses; explicit exception review is requested.
    from: cognitiveservices.json
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: AvoidAdditionalProperties
    reason: This read projection preserves the existing connection metadata string dictionary, whose keys are caller-defined and must remain extensible.
    from: cognitiveservices.json
    where:
      - $.definitions.ConnectionPropertiesV2Read.properties.metadata
  - code: AvoidAdditionalProperties
    reason: Account read endpoints are dynamically named service URLs determined by account kind, and API-specific properties retain the existing extensible kind-specific bag. The read projections exclude the named credentials while preserving these released metadata shapes; review is requested for these specific provider-owned extensible bags.
    from: cognitiveservices.json
    where:
      - $.definitions.AccountPropertiesRead.properties.endpoints
      - $.definitions.ApiPropertiesRead
  - code: PutRequestResponseSchemeArm
    reason: Account and connection credentials are accepted in PUT/PATCH inputs but deliberately omitted from ordinary resource responses. Nonsensitive metadata is preserved, the request is a superset of the response, and each resource provides PATCH for updates.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: ConsistentPatchProperties
    reason: migrationToken and the apiProperties fields qnaAzureSearchEndpointKey, eventHubConnectionString and storageAccountConnectionString are write-only secrets accepted by PATCH but intentionally omitted from the resource read model. Their existing write types, optionality and constraints are preserved.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}"].patch.parameters[4].schema
  - code: AvoidAdditionalProperties
    reason: Endpoints is a read-only dictionary of service endpoint names to URLs (e.g. OpenAI, Speech). Keys are dynamically determined at runtime by the account kind and region from the service API catalog. Same pattern as AccountProperties.endpoints which has shipped in stable since the original TypeSpec migration.
    from: cognitiveservices.json
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: capabilities is a read-only string map of model capability flags resolved from the asset store system metadata. Keys are dynamic capability names not predefined by the service, backed by a Dictionary of string. Same pattern as the existing AccountModel.capabilities and DeploymentProperties.capabilities.
    from: cognitiveservices.json
    where:
      - $.definitions.ManagedComputeDeploymentProperties.properties.capabilities
  - code: AvoidAdditionalProperties
    reason: Account and project tool-label values are dictionaries of customer-defined label names and string values. The referenced schema definitions hold those actual dictionaries; fixed properties would prevent customers from assigning their own labels.
    from: cognitiveservices.json
    where:
      - $.definitions.RaiToolLabelPropertiesAccountScope.properties.labelValues
      - $.definitions.RaiToolLabelPropertiesProjectScopesItem.properties.labelValues
  - code: TopLevelResourcesListByResourceGroup
    reason: RaiExternalSafetyProviderSchema is subscription-scoped. Its resource ID has no resource-group segment, and the API provides subscription collection GET and point GET. Listing this resource by resource group is not applicable to its declared scope.
    from: cognitiveservices.json
    where:
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: These eight exact routes already exist in released stable contracts without the requested name pattern. A new restrictive pattern can reject previously accepted names; backend validation and compatibility must be assessed before changing it. A scoped legacy exception is requested, not inferred from preview usage.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/commitmentPlans/{commitmentPlanName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/pause"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/resume"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/skus"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}/start"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}/stop"]
  - code: ParametersSchemaAsTypeObject
    reason: These two bulk blocklist POST operations accept an array of items as their existing request body, including released stable versions. Wrapping that array in an object would change the established wire payload; the generic object-body rule does not describe this bulk-input contract.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
  - code: RequiredPropertiesMissingInResourceModel
    reason: ManagedComputeUsageListResult is a usage/quota list envelope, not an ARM resource. Same pattern as existing UsageListResult. Individual ManagedComputeUsage items already include id, name, and type properties.
    from: cognitiveservices.json
    where:
      - $.definitions.ManagedComputeUsageListResult
  - code: AvoidAdditionalProperties
    reason: EvaluateDeploymentPoliciesResponse.results is a dictionary keyed by deployment name, mapping each hypothetical deployment to its policy evaluation result. Keys are user-provided deployment names from the request.
    from: cognitiveservices.json
    where:
      - $.definitions.EvaluateDeploymentPoliciesResponse.properties.results
  - code: AvoidAdditionalProperties
    reason: nodeSelector and capabilities are dynamic string maps with keys that are not predefined by the service. nodeSelector holds user-defined Kubernetes node label keys used for pod scheduling; capabilities is a read-only map of model/runtime capability flags resolved at runtime. Both are backed by a Dictionary of string, matching the existing ManagedComputeDeploymentProperties.capabilities pattern and the arm-no-record suppressions in the TypeSpec source.
    from: cognitiveservices.json
    where:
      - $.definitions.ArcDeploymentProperties.properties.nodeSelector
      - $.definitions.ArcDeploymentProperties.properties.capabilities
      - $.definitions.ArcDeploymentUpdateProperties.properties.nodeSelector
```

### Tag: package-2026-11-01

These settings apply only when `--tag=package-2026-11-01` is specified on the command line.

```yaml $(tag) == 'package-2026-11-01'
input-file:
  - stable/2026-11-01/cognitiveservices.json
suppressions:
  - code: ArmResourcePropertiesBag
    reason: OutboundRule.properties.type is the existing outbound-rule kind discriminator, distinct from the top-level ARM resource type. Renaming this field would change the released rule payload and requires coordinated backend and versioned-contract changes; a narrowly scoped legacy exception is requested.
    from: cognitiveservices.json
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: ManagedNetworkSettings.outboundRules is the existing dictionary of caller-named outbound rules with explicitly modeled rule values. Replacing this map with fixed properties or an array would change the released managed-network payload; review is requested for this specific legacy map representation.
    from: cognitiveservices.json
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: These released managed-network and outbound-rule PUT contracts return 200 or 202, not 201. The managed-network 200 model exposes provisioningState; outbound rules expose their existing status field instead. Inventing a 201 response or a new provisioningState in Swagger would not fix the underlying service behavior; review is requested for the scoped legacy contract.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: Managed-network and outbound-rule PUT operations use the released 200 synchronous-completion and 202 asynchronous-acceptance contracts with polling headers. They do not advertise 201; changing response codes requires backend alignment rather than a Swagger-only change. A scoped legacy exception is requested.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: The released Project PUT contract allows 200 for updates, 201 for synchronous creation and 202 for asynchronous creation; synchronous connection PUT operations return 200. These exact response-code deviations are retained pending ARM review rather than adding or removing responses unsupported by the current contract.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: The released Project PATCH contract includes a Project body on 202 Accepted as well as on 200 completion. Removing that body only from Swagger would change the documented contract without changing the service; review is requested for this specific legacy asynchronous-response shape.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: Both connection PATCH routes currently bind a polymorphic properties model whose authType discriminator is required even for metadata-only updates. Removing the requirement only in Swagger would advertise unsupported requests. The reviewer treats this inherited requirement as non-blocking for November stable in https://github.com/Azure/azure-rest-api-specs/pull/47307#discussion_r4485773604; coordinated backend and partial-update contract work remains outstanding.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: DeleteResponseCodes
    reason: The released Project DELETE contract allows immediate completion with 200 or 204 and asynchronous acceptance with 202 and polling headers. This exception preserves those exact response codes pending ARM review; it does not waive DELETE rules for other resource types.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
  - code: AvoidAdditionalProperties
    reason: Connection metadata uses caller-defined string keys, and CustomKeys.keys accepts caller-defined credential/header names with string secret values. Fixed property names would not represent these inputs. Custom keys remain write-side credentials and are excluded from ordinary November responses; explicit exception review is requested.
    from: cognitiveservices.json
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: AvoidAdditionalProperties
    reason: This read projection preserves the existing connection metadata string dictionary, whose keys are caller-defined and must remain extensible.
    from: cognitiveservices.json
    where:
      - $.definitions.ConnectionPropertiesV2Read.properties.metadata
  - code: AvoidAdditionalProperties
    reason: Account read endpoints are dynamically named service URLs determined by account kind, and API-specific properties retain the existing extensible kind-specific bag. The read projections exclude the named credentials while preserving these released metadata shapes; review is requested for these specific provider-owned extensible bags.
    from: cognitiveservices.json
    where:
      - $.definitions.AccountPropertiesRead.properties.endpoints
      - $.definitions.ApiPropertiesRead
  - code: PutRequestResponseSchemeArm
    reason: Account and connection credentials are accepted in PUT/PATCH inputs but deliberately omitted from ordinary resource responses. Nonsensitive metadata is preserved, the request is a superset of the response, and each resource provides PATCH for updates.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: ConsistentPatchProperties
    reason: migrationToken and the apiProperties fields qnaAzureSearchEndpointKey, eventHubConnectionString and storageAccountConnectionString are write-only secrets accepted by PATCH but intentionally omitted from the resource read model. Their existing write types, optionality and constraints are preserved.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}"].patch.parameters[4].schema
  - code: AvoidAdditionalProperties
    reason: Project endpoints are a read-only dictionary of service endpoint names to URLs, determined dynamically by project/account kind and service configuration. This preserves the released metadata map rather than constraining it to a fixed set of endpoint names; a specific exception is requested.
    from: cognitiveservices.json
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: Account and project tool-label values are dictionaries of customer-defined label names and string values. The referenced schema definitions hold those actual dictionaries; fixed properties would prevent customers from assigning their own labels.
    from: cognitiveservices.json
    where:
      - $.definitions.RaiToolLabelPropertiesAccountScope.properties.labelValues
      - $.definitions.RaiToolLabelPropertiesProjectScopesItem.properties.labelValues
  - code: TopLevelResourcesListByResourceGroup
    reason: RaiExternalSafetyProviderSchema is subscription-scoped. Its resource ID has no resource-group segment, and the API provides subscription collection GET and point GET. Listing this resource by resource group is not applicable to its declared scope.
    from: cognitiveservices.json
    where:
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: These eight exact routes already exist in released stable contracts without the requested name pattern. A new restrictive pattern can reject previously accepted names; backend validation and compatibility must be assessed before changing it. A scoped legacy exception is requested, not inferred from preview usage.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/commitmentPlans/{commitmentPlanName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/pause"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/resume"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/skus"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}/start"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}/stop"]
  - code: ParametersSchemaAsTypeObject
    reason: These two bulk blocklist POST operations accept an array of items as their existing request body, including released stable versions. Wrapping that array in an object would change the established wire payload; the generic object-body rule does not describe this bulk-input contract.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
```

### Tag: package-2026-09-15-preview

These settings apply only when `--tag=package-2026-09-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-09-15-preview'
input-file:
  - preview/2026-09-15-preview/cognitiveservices.json
suppressions:
  - code: DefinitionsPropertiesNamesCamelCase
    reason: The acs property embeds a separately versioned Agent Control Specification document. These fields retain the canonical ACS snake_case wire names so customers can import, export, validate, and round-trip ACS manifests without translation; generated SDKs expose idiomatic camelCase names through x-ms-client-name.
    from: cognitiveservices.json
    where:
      - $.definitions.RaiAcsHarmConfiguration.properties.harm_config_id
      - $.definitions.RaiAcsInterventionPoint.properties.policy_target
      - $.definitions.RaiAcsInterventionPoint.properties.policy_target_kind
      - $.definitions.RaiAcsToolInterventionPoint.properties.policy_target
      - $.definitions.RaiAcsToolInterventionPoint.properties.policy_target_kind
      - $.definitions.RaiAcsToolInterventionPoint.properties.tool_name_from
      - $.definitions.RaiAcsInterventionPoints.properties.pre_tool_call
      - $.definitions.RaiAcsInterventionPoints.properties.post_tool_call
      - $.definitions.RaiAcsManifest.properties.agent_control_specification_version
      - $.definitions.RaiAcsManifest.properties.intervention_points
      - $.definitions.RaiAcsModerationBindingExtension.properties.subject_format
      - $.definitions.RaiAcsModerationBindingExtension.properties.harm_configs
      - $.definitions.RaiAcsPolicyBinding.properties.aacs_moderation
      - $.definitions.RaiAcsToolDefinition.properties.security_labels
  - code: AvoidAdditionalProperties
    reason: The canonical ACS manifest defines metadata and tool entries as extensible JSON objects, and policies and tools as name-keyed maps. Replacing these objects with closed properties or arrays would break ACS manifest portability and round-tripping.
    from: cognitiveservices.json
    where:
      - $.definitions.RaiAcsManifest.properties.metadata
      - $.definitions.RaiAcsManifest.properties.policies
      - $.definitions.RaiAcsManifest.properties.tools
      - $.definitions.RaiAcsToolDefinition
  - code: PutResponseCodes
    reason: Compute create is a genuine long-running async operation - the service returns 202 Accepted on success (never 200/201) and 4xx on failure. Modeling 202-only reflects the real backend contract (live-validated). Preview-only bug fix correcting the contract before GA.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"].put
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Compute create returns 202 Accepted for long-running provisioning. provisioningState is present in ComputeProperties and returned in the final LRO result retrieved via GET. Preview-only bug fix.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"].put
  - code: PutGetPatchResponseSchema
    reason: Compute create PUT is 202-only with no response body, so its response schema intentionally differs from GET, which returns the Compute resource once the LRO completes. This is inherent to the async 202-only contract. Preview-only bug fix.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"]
  - code: NestedResourcesMustHaveListOperation
    reason: ComputeOperationStatus is an async operation status polling resource, listing all operations is not applicable.
    where:
      - $.definitions.ComputeOperationStatus
  - code: ArmResourcePropertiesBag
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: ManagedNetwork PUT is an async operation that returns 202 Accepted for long-running network infrastructure provisioning. The backend is shared with Machine Learning Services RP and returns 202 instead of ARM-standard 200/201. Changing response codes would be a breaking change for existing clients. provisioningState is present in the resource model and returned in the final LRO result.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This API is copied from Machine Learning Services RP where it is already established and in use.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedComputeDeployments/{deploymentName}"].patch.parameters[5].schema.properties.sku
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedComputeDeployments/{deploymentName}"].delete
  - code: AvoidAdditionalProperties
    reason: Metadata is a user-defined key-value property bag where customers store arbitrary metadata about connections (e.g. API versions, deployment config). Keys are not predefined by the service. CustomKeys.keys holds user-provided authentication credentials with user-defined key names. Both are Dictionary of string in the backend.
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Endpoints is a read-only dictionary of service endpoint names to URLs (e.g. OpenAI, Speech). Keys are dynamically determined at runtime by the account kind and region from the service API catalog. Same pattern as AccountProperties.endpoints which has shipped in stable since the original TypeSpec migration.
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: capabilities is a read-only string map of model capability flags resolved from the asset store system metadata. Keys are dynamic capability names not predefined by the service, backed by a Dictionary of string. Same pattern as the existing AccountModel.capabilities and DeploymentProperties.capabilities.
    where:
      - $.definitions.ManagedComputeDeploymentProperties.properties.capabilities
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to assign customize labels to rules.
    where:
      - $.definitions.RaiToolLabelProperties.properties.accountScope.properties.labelValues
      - $.definitions.RaiToolLabelProperties.properties.projectScopes.items.properties.labelValues
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to define custom conditions for when a rule is activated.
    where:
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: TopLevelResourcesListByResourceGroup
    reason: These are subscription level resources and are modeled after the RaiPolicy List operation
    where:
      - $.definitions.RaiExternalSafetyProvider
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: Parameter exists in previous API versions without pattern, cannot add now without breaking change.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/commitmentPlans/{commitmentPlanName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/pause"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/resume"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/skus"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{name}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}/start"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}/stop"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{name}/disable"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{name}/enable"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{name}/listAgents"]
  - code: ParametersSchemaAsTypeObject
    reason: Backend requires array type for bulk operations since 2024-04-01 API. Changing to object would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
  - code: RequiredPropertiesMissingInResourceModel
    reason: ManagedComputeUsageListResult is a usage/quota list envelope, not an ARM resource. Same pattern as existing UsageListResult. Individual ManagedComputeUsage items already include id, name, and type properties.
    where:
      - $.definitions.ManagedComputeUsageListResult
  - code: AvoidAdditionalProperties
    reason: EvaluateDeploymentPoliciesResponse.results is a dictionary keyed by deployment name, mapping each hypothetical deployment to its policy evaluation result. Keys are user-provided deployment names from the request.
    where:
      - $.definitions.EvaluateDeploymentPoliciesResponse.properties.results
  - code: AvoidAdditionalProperties
    reason: nodeSelector and capabilities are dynamic string maps with keys that are not predefined by the service. nodeSelector holds user-defined Kubernetes node label keys used for pod scheduling; capabilities is a read-only map of model/runtime capability flags resolved at runtime. Both are backed by a Dictionary of string, matching the existing ManagedComputeDeploymentProperties.capabilities pattern and the arm-no-record suppressions in the TypeSpec source.
    where:
      - $.definitions.ArcDeploymentProperties.properties.nodeSelector
      - $.definitions.ArcDeploymentProperties.properties.capabilities
      - $.definitions.ArcDeploymentUpdateProperties.properties.nodeSelector
```

### Tag: package-2026-09-01

These settings apply only when `--tag=package-2026-09-01` is specified on the command line.

```yaml $(tag) == 'package-2026-09-01'
input-file:
  - stable/2026-09-01/cognitiveservices.json
suppressions:
  - code: ArmResourcePropertiesBag
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This API is copied from Machine Learning Services RP where it is already established and in use.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to assign customize labels to rules.
    where:
      - $.definitions.RaiToolLabelProperties.properties.accountScope.properties.labelValues
      - $.definitions.RaiToolLabelProperties.properties.projectScopes.items.properties.labelValues
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to define custom conditions for when a rule is activated.
    where:
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: TopLevelResourcesListByResourceGroup
    reason: These are subscription level resources and are modeled after the RaiPolicy List operation
    where:
      - $.definitions.RaiExternalSafetyProvider
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: Parameter exists in previous API versions without pattern, cannot add now without breaking change.
    from: cognitiveservices.json
  - code: ParametersSchemaAsTypeObject
    reason: Backend requires array type for bulk operations since 2024-04-01 API. Changing to object would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
```

### Tag: package-2026-07-15-preview

These settings apply only when `--tag=package-2026-07-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-07-15-preview'
input-file:
  - preview/2026-07-15-preview/cognitiveservices.json
suppressions:
  - code: PutResponseCodes
    reason: Compute create is a genuine long-running async operation - the service returns 202 Accepted on success (never 200/201) and 4xx on failure. Modeling 202-only reflects the real backend contract (live-validated). Preview-only bug fix correcting the contract before GA.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"].put
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Compute create returns 202 Accepted for long-running provisioning. provisioningState is present in ComputeProperties and returned in the final LRO result retrieved via GET. Preview-only bug fix.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"].put
  - code: PutGetPatchResponseSchema
    reason: Compute create PUT is 202-only with no response body, so its response schema intentionally differs from GET, which returns the Compute resource once the LRO completes. This is inherent to the async 202-only contract. Preview-only bug fix.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"]
  - code: NestedResourcesMustHaveListOperation
    reason: ComputeOperationStatus is an async operation status polling resource, listing all operations is not applicable.
    where:
      - $.definitions.ComputeOperationStatus
  - code: ArmResourcePropertiesBag
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: ManagedNetwork PUT is an async operation that returns 202 Accepted for long-running network infrastructure provisioning. The backend is shared with Machine Learning Services RP and returns 202 instead of ARM-standard 200/201. Changing response codes would be a breaking change for existing clients. provisioningState is present in the resource model and returned in the final LRO result.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This API is copied from Machine Learning Services RP where it is already established and in use.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedComputeDeployments/{deploymentName}"].patch.parameters[5].schema.properties.sku
  - code: PatchBodyParametersSchema
    reason: Workbench uses PatchModel = Workbench (full resource as PATCH body). Required properties (targetClusterId, imageLink) are within the optional properties bag.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/workbenches/{workbenchName}"].patch.parameters[6].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/workbenches/{workbenchName}"].patch.parameters[6].schema
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedComputeDeployments/{deploymentName}"].delete
  - code: AvoidAdditionalProperties
    reason: Metadata is a user-defined key-value property bag where customers store arbitrary metadata about connections (e.g. API versions, deployment config). Keys are not predefined by the service. CustomKeys.keys holds user-provided authentication credentials with user-defined key names. Both are Dictionary of string in the backend.
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Endpoints is a read-only dictionary of service endpoint names to URLs (e.g. OpenAI, Speech). Keys are dynamically determined at runtime by the account kind and region from the service API catalog. Same pattern as AccountProperties.endpoints which has shipped in stable since the original TypeSpec migration.
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: capabilities is a read-only string map of model capability flags resolved from the asset store system metadata. Keys are dynamic capability names not predefined by the service, backed by a Dictionary of string. Same pattern as the existing AccountModel.capabilities and DeploymentProperties.capabilities.
    where:
      - $.definitions.ManagedComputeDeploymentProperties.properties.capabilities
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to assign customize labels to rules.
    where:
      - $.definitions.RaiToolLabelProperties.properties.accountScope.properties.labelValues
      - $.definitions.RaiToolLabelProperties.properties.projectScopes.items.properties.labelValues
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to define custom conditions for when a rule is activated.
    where:
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: TopLevelResourcesListByResourceGroup
    reason: These are subscription level resources and are modeled after the RaiPolicy List operation
    where: 
      - $.definitions.RaiExternalSafetyProvider
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: Parameter exists in previous API versions without pattern, cannot add now without breaking change.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/commitmentPlans/{commitmentPlanName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/pause"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/resume"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/skus"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{name}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}/start"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}/stop"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{name}/disable"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{name}/enable"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{name}/listAgents"]
  - code: ParametersSchemaAsTypeObject
    reason: Backend requires array type for bulk operations since 2024-04-01 API. Changing to object would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
  - code: RequiredPropertiesMissingInResourceModel
    reason: ManagedComputeUsageListResult is a usage/quota list envelope, not an ARM resource. Same pattern as existing UsageListResult. Individual ManagedComputeUsage items already include id, name, and type properties.
    where:
      - $.definitions.ManagedComputeUsageListResult
  - code: AvoidAdditionalProperties
    reason: EvaluateDeploymentPoliciesResponse.results is a dictionary keyed by deployment name, mapping each hypothetical deployment to its policy evaluation result. Keys are user-provided deployment names from the request.
    where:
      - $.definitions.EvaluateDeploymentPoliciesResponse.properties.results
  - code: AvoidAdditionalProperties
    reason: nodeSelector and capabilities are dynamic string maps with keys that are not predefined by the service. nodeSelector holds user-defined Kubernetes node label keys used for pod scheduling; capabilities is a read-only map of model/runtime capability flags resolved at runtime. Both are backed by a Dictionary of string, matching the existing ManagedComputeDeploymentProperties.capabilities pattern and the arm-no-record suppressions in the TypeSpec source.
    where:
      - $.definitions.ArcDeploymentProperties.properties.nodeSelector
      - $.definitions.ArcDeploymentProperties.properties.capabilities
      - $.definitions.ArcDeploymentUpdateProperties.properties.nodeSelector
```

### Tag: package-2026-07-01

These settings apply only when `--tag=package-2026-07-01` is specified on the command line.

```yaml $(tag) == 'package-2026-07-01'
input-file:
  - stable/2026-07-01/cognitiveservices.json
suppressions:
  - code: ArmResourcePropertiesBag
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This API is copied from Machine Learning Services RP where it is already established and in use.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to assign customize labels to rules.
    where:
      - $.definitions.RaiToolLabelProperties.properties.accountScope.properties.labelValues
      - $.definitions.RaiToolLabelProperties.properties.projectScopes.items.properties.labelValues
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to define custom conditions for when a rule is activated.
    where:
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: TopLevelResourcesListByResourceGroup
    reason: These are subscription level resources and are modeled after the RaiPolicy List operation
    where: 
      - $.definitions.RaiExternalSafetyProvider
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: Parameter exists in previous API versions without pattern, cannot add now without breaking change.
    from: cognitiveservices.json
  - code: ParametersSchemaAsTypeObject
    reason: Backend requires array type for bulk operations since 2024-04-01 API. Changing to object would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
```

### Tag: package-2026-05-15-preview

These settings apply only when `--tag=package-2026-05-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-05-15-preview'
input-file:
  - preview/2026-05-15-preview/cognitiveservices.json
suppressions:
  - code: PutResponseCodes
    reason: Compute create is a genuine long-running async operation - the service returns 202 Accepted on success (never 200/201) and 4xx on failure. Modeling 202-only reflects the real backend contract (live-validated). Preview-only bug fix correcting the contract before GA.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"].put
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Compute create returns 202 Accepted for long-running provisioning. provisioningState is present in ComputeProperties and returned in the final LRO result retrieved via GET. Preview-only bug fix.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"].put
  - code: PutGetPatchResponseSchema
    reason: Compute create PUT is 202-only with no response body, so its response schema intentionally differs from GET, which returns the Compute resource once the LRO completes. This is inherent to the async 202-only contract. Preview-only bug fix.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"]
  - code: NestedResourcesMustHaveListOperation
    reason: ComputeOperationStatus is an async operation status polling resource, listing all operations is not applicable.
    where:
      - $.definitions.ComputeOperationStatus
  - code: ArmResourcePropertiesBag
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: ManagedNetwork PUT is an async operation that returns 202 Accepted for long-running network infrastructure provisioning. The backend is shared with Machine Learning Services RP and returns 202 instead of ARM-standard 200/201. Changing response codes would be a breaking change for existing clients. provisioningState is present in the resource model and returned in the final LRO result.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This API is copied from Machine Learning Services RP where it is already established and in use.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedComputeDeployments/{deploymentName}"].patch.parameters[5].schema.properties.sku
  - code: PatchBodyParametersSchema
    reason: Workbench uses PatchModel = Workbench (full resource as PATCH body). Required properties (targetClusterId, imageLink) are within the optional properties bag.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/workbenches/{workbenchName}"].patch.parameters[6].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/workbenches/{workbenchName}"].patch.parameters[6].schema
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedComputeDeployments/{deploymentName}"].delete
  - code: AvoidAdditionalProperties
    reason: Metadata is a user-defined key-value property bag where customers store arbitrary metadata about connections (e.g. API versions, deployment config). Keys are not predefined by the service. CustomKeys.keys holds user-provided authentication credentials with user-defined key names. Both are Dictionary of string in the backend.
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Endpoints is a read-only dictionary of service endpoint names to URLs (e.g. OpenAI, Speech). Keys are dynamically determined at runtime by the account kind and region from the service API catalog. Same pattern as AccountProperties.endpoints which has shipped in stable since the original TypeSpec migration.
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: capabilities is a read-only string map of model capability flags resolved from the asset store system metadata. Keys are dynamic capability names not predefined by the service, backed by a Dictionary of string. Same pattern as the existing AccountModel.capabilities and DeploymentProperties.capabilities.
    where:
      - $.definitions.ManagedComputeDeploymentProperties.properties.capabilities
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to assign customize labels to rules.
    where:
      - $.definitions.RaiToolLabelProperties.properties.accountScope.properties.labelValues
      - $.definitions.RaiToolLabelProperties.properties.projectScopes.items.properties.labelValues
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to define custom conditions for when a rule is activated.
    where:
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: TopLevelResourcesListByResourceGroup
    reason: These are subscription level resources and are modeled after the RaiPolicy List operation
    where: 
      - $.definitions.RaiExternalSafetyProvider
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: Parameter exists in previous API versions without pattern, cannot add now without breaking change.
    from: cognitiveservices.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/commitmentPlans/{commitmentPlanName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/pause"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/resume"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/deployments/{deploymentName}/skus"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/privateEndpointConnections/{privateEndpointConnectionName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{name}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}/start"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{appName}/agentDeployments/{deploymentName}/stop"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{name}/disable"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{name}/enable"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/applications/{name}/listAgents"]
  - code: ParametersSchemaAsTypeObject
    reason: Backend requires array type for bulk operations since 2024-04-01 API. Changing to object would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
  - code: RequiredPropertiesMissingInResourceModel
    reason: ManagedComputeUsageListResult is a usage/quota list envelope, not an ARM resource. Same pattern as existing UsageListResult. Individual ManagedComputeUsage items already include id, name, and type properties.
    where:
      - $.definitions.ManagedComputeUsageListResult
  - code: AvoidAdditionalProperties
    reason: EvaluateDeploymentPoliciesResponse.results is a dictionary keyed by deployment name, mapping each hypothetical deployment to its policy evaluation result. Keys are user-provided deployment names from the request.
    where:
      - $.definitions.EvaluateDeploymentPoliciesResponse.properties.results
```

### Tag: package-2026-05-01

These settings apply only when `--tag=package-2026-05-01` is specified on the command line.

```yaml $(tag) == 'package-2026-05-01'
input-file:
  - stable/2026-05-01/cognitiveservices.json
suppressions:
  - code: ArmResourcePropertiesBag
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This API is copied from Machine Learning Services RP where it is already established and in use.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to assign customize labels to rules.
    where:
      - $.definitions.RaiToolLabelProperties.properties.accountScope.properties.labelValues
      - $.definitions.RaiToolLabelProperties.properties.projectScopes.items.properties.labelValues
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to define custom conditions for when a rule is activated.
    where:
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: TopLevelResourcesListByResourceGroup
    reason: These are subscription level resources and are modeled after the RaiPolicy List operation
    where: 
      - $.definitions.RaiExternalSafetyProvider
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: Parameter exists in previous API versions without pattern, cannot add now without breaking change.
    from: cognitiveservices.json
  - code: ParametersSchemaAsTypeObject
    reason: Backend requires array type for bulk operations since 2024-04-01 API. Changing to object would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
```


### Tag: package-2026-03-15-preview

These settings apply only when `--tag=package-2026-03-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-03-15-preview'
input-file:
  - preview/2026-03-15-preview/cognitiveservices.json
suppressions:
  - code: PutResponseCodes
    reason: Compute create is a genuine long-running async operation - the service returns 202 Accepted on success (never 200/201) and 4xx on failure. Modeling 202-only reflects the real backend contract (live-validated). Preview-only bug fix correcting the contract before GA.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"].put
  - code: ProvisioningStateSpecifiedForLROPut
    reason: Compute create returns 202 Accepted for long-running provisioning. provisioningState is present in ComputeProperties and returned in the final LRO result retrieved via GET. Preview-only bug fix.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"].put
  - code: PutGetPatchResponseSchema
    reason: Compute create PUT is 202-only with no response body, so its response schema intentionally differs from GET, which returns the Compute resource once the LRO completes. This is inherent to the async 202-only contract. Preview-only bug fix.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/computes/{computeName}"]
  - code: NestedResourcesMustHaveListOperation
    reason: ComputeOperationStatus is an async operation status polling resource, listing all operations is not applicable.
    where:
      - $.definitions.ComputeOperationStatus
  - code: ArmResourcePropertiesBag
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: ManagedNetwork PUT is an async operation that returns 202 Accepted for long-running network infrastructure provisioning. The backend is shared with Machine Learning Services RP and returns 202 instead of ARM-standard 200/201. Changing response codes would be a breaking change for existing clients. provisioningState is present in the resource model and returned in the final LRO result.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This API is copied from Machine Learning Services RP where it is already established and in use.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedComputeDeployments/{deploymentName}"].patch.parameters[5].schema.properties.sku
  - code: PatchBodyParametersSchema
    reason: Workbench uses PatchModel = Workbench (full resource as PATCH body). Required properties (targetClusterId, imageLink) are within the optional properties bag.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/workbenches/{workbenchName}"].patch.parameters[6].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/workbenches/{workbenchName}"].patch.parameters[6].schema
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedComputeDeployments/{deploymentName}"].delete
  - code: AvoidAdditionalProperties
    reason: Metadata is a user-defined key-value property bag where customers store arbitrary metadata about connections (e.g. API versions, deployment config). Keys are not predefined by the service. CustomKeys.keys holds user-provided authentication credentials with user-defined key names. Both are Dictionary of string in the backend.
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Endpoints is a read-only dictionary of service endpoint names to URLs (e.g. OpenAI, Speech). Keys are dynamically determined at runtime by the account kind and region from the service API catalog. Same pattern as AccountProperties.endpoints which has shipped in stable since the original TypeSpec migration.
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to assign customize labels to rules.
    where:
      - $.definitions.RaiToolLabelProperties.properties.accountScope.properties.labelValues
      - $.definitions.RaiToolLabelProperties.properties.projectScopes.items.properties.labelValues
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to define custom conditions for when a rule is activated.
    where:
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: TopLevelResourcesListByResourceGroup
    reason: These are subscription level resources and are modeled after the RaiPolicy List operation
    where: 
      - $.definitions.RaiExternalSafetyProvider
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: Parameter exists in previous API versions without pattern, cannot add now without breaking change.
    from: cognitiveservices.json
  - code: ParametersSchemaAsTypeObject
    reason: Backend requires array type for bulk operations since 2024-04-01 API. Changing to object would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
  - code: RequiredPropertiesMissingInResourceModel
    reason: ManagedComputeUsageListResult is a usage/quota list envelope, not an ARM resource. Same pattern as existing UsageListResult. Individual ManagedComputeUsage items already include id, name, and type properties.
    where:
      - $.definitions.ManagedComputeUsageListResult
  - code: AvoidAdditionalProperties
    reason: EvaluateDeploymentPoliciesResponse.results is a dictionary keyed by deployment name, mapping each hypothetical deployment to its policy evaluation result. Keys are user-provided deployment names from the request.
    where:
      - $.definitions.EvaluateDeploymentPoliciesResponse.properties.results
```


### Tag: package-2026-03-01

These settings apply only when `--tag=package-2026-03-01` is specified on the command line.

```yaml $(tag) == 'package-2026-03-01'
input-file:
  - stable/2026-03-01/cognitiveservices.json
suppressions:
  - code: ArmResourcePropertiesBag
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This API is copied from Machine Learning Services RP where it is already established and in use.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to assign customize labels to rules.
    where:
      - $.definitions.RaiToolLabelProperties.properties.accountScope.properties.labelValues
      - $.definitions.RaiToolLabelProperties.properties.projectScopes.items.properties.labelValues
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to define custom conditions for when a rule is activated.
    where:
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: TopLevelResourcesListByResourceGroup
    reason: These are subscription level resources and are modeled after the RaiPolicy List operation
    where: 
      - $.definitions.RaiExternalSafetyProvider
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: Parameter exists in previous API versions without pattern, cannot add now without breaking change.
    from: cognitiveservices.json
  - code: ParametersSchemaAsTypeObject
    reason: Backend requires array type for bulk operations since 2024-04-01 API. Changing to object would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
```


### Tag: package-2026-01-15-preview

These settings apply only when `--tag=package-2026-01-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-01-15-preview'
input-file:
  - preview/2026-01-15-preview/cognitiveservices.json
suppressions:
  - code: NestedResourcesMustHaveListOperation
    reason: ComputeOperationStatus is an async operation status polling resource, listing all operations is not applicable.
    where:
      - $.definitions.ComputeOperationStatus
  - code: ArmResourcePropertiesBag
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This API is copied from Machine Learning Services RP where it is already established and in use.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to assign customize labels to rules.
    where:
      - $.definitions.RaiToolLabelProperties.properties.accountScope.properties.labelValues
      - $.definitions.RaiToolLabelProperties.properties.projectScopes.items.properties.labelValues
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to define custom conditions for when a rule is activated.
    where:
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: TopLevelResourcesListByResourceGroup
    reason: These are subscription level resources and are modeled after the RaiPolicy List operation
    where: 
      - $.definitions.RaiExternalSafetyProvider
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: Parameter exists in previous API versions without pattern, cannot add now without breaking change.
    from: cognitiveservices.json
  - code: ParametersSchemaAsTypeObject
    reason: Backend requires array type for bulk operations since 2024-04-01 API. Changing to object would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
```

### Tag: package-2025-12-01

These settings apply only when `--tag=package-2025-12-01` is specified on the command line.

```yaml $(tag) == 'package-2025-12-01'
input-file:
  - stable/2025-12-01/cognitiveservices.json
suppressions:
  - code: ArmResourcePropertiesBag
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This API is copied from Machine Learning Services RP where it is already established and in use.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to assign customize labels to rules.
    where:
      - $.definitions.RaiToolLabelProperties.properties.accountScope.properties.labelValues
      - $.definitions.RaiToolLabelProperties.properties.projectScopes.items.properties.labelValues
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to define custom conditions for when a rule is activated.
    where:
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: TopLevelResourcesListByResourceGroup
    reason: These are subscription level resources and are modeled after the RaiPolicy List operation
    where: 
      - $.definitions.RaiExternalSafetyProvider
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: Parameter exists in previous API versions without pattern, cannot add now without breaking change.
    from: cognitiveservices.json
  - code: ParametersSchemaAsTypeObject
    reason: Backend requires array type for bulk operations since 2024-04-01 API. Changing to object would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
```

### Tag: package-2025-10-01-preview

These settings apply only when `--tag=package-2025-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-10-01-preview'
input-file:
  - preview/2025-10-01-preview/cognitiveservices.json
suppressions:
  - code: ArmResourcePropertiesBag
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.OutboundRuleBasicResource
  - code: AvoidAdditionalProperties
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.definitions.ManagedNetworkSettings.properties.outboundRules
  - code: ProvisioningStateSpecifiedForLROPut
    reason: This API is copied from Machine Learning Services RP where this behavior is already established.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This API is copied from Machine Learning Services RP where it is already established and in use.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}/outboundRules/{ruleName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedNetworks/{managedNetworkName}"].put
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete
  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to assign customize labels to rules.
    where:
      - $.definitions.RaiToolLabelProperties.properties.accountScope.properties.labelValues
      - $.definitions.RaiToolLabelProperties.properties.projectScopes.items.properties.labelValues
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: AvoidAdditionalProperties
    reason: Provide customers ability to define custom conditions for when a rule is activated.
    where:
      - $.definitions.RaiIfcRuleProperties.properties.conditions
  - code: TopLevelResourcesListByResourceGroup
    reason: These are subscription level resources and are modeled after the RaiPolicy List operation
    where: 
      - $.definitions.RaiExternalSafetyProvider
      - $.definitions.RaiExternalSafetyProviderSchema
  - code: ResourceNameRestriction
    reason: Parameter exists in previous API versions without pattern, cannot add now without breaking change.
    from: cognitiveservices.json
  - code: ParametersSchemaAsTypeObject
    reason: Backend requires array type for bulk operations since 2024-04-01 API. Changing to object would be a breaking change.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/addRaiBlocklistItems"].post.parameters[5].schema.type
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/raiBlocklists/{raiBlocklistName}/deleteRaiBlocklistItems"].post.parameters[5].schema.type
```

### Tag: package-2025-09-01

These settings apply only when `--tag=package-2025-09-01` is specified on the command line.

```yaml $(tag) == 'package-2025-09-01'
input-file:
  - stable/2025-09-01/cognitiveservices.json
suppressions:
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete

  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
```

### Tag: package-2025-07-01-preview

These settings apply only when `--tag=package-2025-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01-preview'
input-file:
  - preview/2025-07-01-preview/cognitiveservices.json
suppressions:
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete

  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
```

### Tag: package-2025-06-01

These settings apply only when `--tag=package-2025-06-01` is specified on the command line.

```yaml $(tag) == 'package-2025-06-01'
input-file:
  - stable/2025-06-01/cognitiveservices.json
suppressions:
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete

  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
```

### Tag: package-preview-2025-04-01-preview

These settings apply only when `--tag=package-preview-2025-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-04-01-preview'
input-file:
  - preview/2025-04-01-preview/cognitiveservices.json
suppressions:
  - code: PutResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].put
  - code: PatchResponseCodes
    reason: This is existing behavior in all other APIs and already in stable version, will keep the same.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch
  - code: PatchBodyParametersSchema
    reason: this is a required field for in a optional property this experience exist in other stable schemas as well.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/connections/{connectionName}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.parameters[3].schema.properties.sku
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}/connections/{connectionName}"].patch.parameters[6].schema.properties.properties
  - code: GuidUsage
    reason: Approved to be suppressed in AML swagger.
    where:
      - $.definitions.ConnectionOAuth2.properties.clientId.format
  - code: DeleteResponseCodes
    reason: Behavior is align with other existing API for this RP
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete

  - code: AvoidAdditionalProperties
    reason: Approved to be suppressed in AML swagger
    where:
      - $.definitions.ConnectionPropertiesV2.properties.metadata
      - $.definitions.CustomKeys.properties.keys
  - code: LroLocationHeader
    reason: Align with existing API behavior in other APIs
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].put.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].patch.responses.202
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}"].delete.responses.202
  - code: AvoidAdditionalProperties
    reason: Same as existing account resource, trying to have the same behavior
    where:
      - $.definitions.ProjectProperties.properties.endpoints
```

### Tag: package-2024-10

These settings apply only when `--tag=package-2024-10` is specified on the command line.

```yaml $(tag) == 'package-2024-10'
input-file:
  - stable/2024-10-01/cognitiveservices.json
```

### Tag: package-preview-2024-06

These settings apply only when `--tag=package-preview-2024-06` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-06'
input-file:
  - preview/2024-06-01-preview/cognitiveservices.json
```

### Tag: package-preview-2024-04

These settings apply only when `--tag=package-preview-2024-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-04'
input-file:
  - preview/2024-04-01-preview/cognitiveservices.json
```

### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-10'
input-file:
  - preview/2023-10-01-preview/cognitiveservices.json
suppressions:
  - code: ResourceNameRestriction
    reason: The resource name parameter 'deploymentName' is not a new added parameter and was already implemented in previous versions of API, we cannot add pattern now.
    from: cognitiveservices.json
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

```yaml $(tag) == 'package-2023-05'
input-file:
  - stable/2023-05-01/cognitiveservices.json
```

### Tag: package-2022-12

These settings apply only when `--tag=package-2022-12` is specified on the command line.

```yaml $(tag) == 'package-2022-12'
input-file:
  - stable/2022-12-01/cognitiveservices.json
```

### Tag: package-2022-10

These settings apply only when `--tag=package-2022-10` is specified on the command line.

```yaml $(tag) == 'package-2022-10'
input-file:
  - stable/2022-10-01/cognitiveservices.json
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

```yaml $(tag) == 'package-2022-03'
input-file:
  - stable/2022-03-01/cognitiveservices.json
```

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

```yaml $(tag) == 'package-2021-10'
input-file:
  - stable/2021-10-01/cognitiveservices.json
```

### Tag: package-2021-04

These settings apply only when `--tag=package-2021-04` is specified on the command line.

```yaml $(tag) == 'package-2021-04'
input-file:
  - stable/2021-04-30/cognitiveservices.json
```

### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.

```yaml $(tag) == 'package-2017-04'
input-file:
  - stable/2017-04-18/cognitiveservices.json
```

### Tag: package-2016-02-preview

These settings apply only when `--tag=package-2016-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2016-02-preview'
input-file:
  - preview/2016-02-01-preview/cognitiveservices.json
```

## Suppression

```yaml
directive:
  - suppress: TrackedResourcePatchOperation
    from: cognitiveservices.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/commitmentPlans/{commitmentPlanName}"]
    reason: The resource accounts/commitmentPlans is not a tracked resource
  - suppress: RPC-Patch-V1-10 
    from: cognitiveservices.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/managedComputeDeployments/{deploymentName}"].patch.parameters[5]
    reason: computeType (within properties) is mandatory for this PATCH operation to validate resource consistency.
```

---

# Code Generation

## Optional ACS Annotations (2026-11-15-preview)

November adds optional `acs.annotators` declarations and per-point `annotations`
bindings. Entries are keyed by annotator name; supplied declarations require `type`
and bindings require `from`. Other configuration is host-defined JSON. Omitting
these maps or using empty maps requests no annotations. Earlier API versions retain
their original empty-only annotation profile.

The `*AcsWithAnnotationsAndEgress.json` PUT, GET, and LIST examples combine optional
Azure OpenAI judge annotations with the eight existing November intervention points
and an optional top-level `properties.egressPolicy` sibling of `properties.acs`.
Egress uses the existing schema, is not evaluated by the ACS SDK, and uses Audit mode
in these examples. Responses omit write-only header literals. Host admission,
deployment enrollment, egress persistence, and enforcement require separate backend
readiness; these examples do not enable them.

The illustrative Azure OpenAI judge configuration explicitly selects
`result_schema: acs.judge.observation/v2` for custom labels and a 0-to-10 rubric.
In that host profile, omitting `result_schema` retains the v1 default with fixed
labels and a 0-to-1 score. The selector remains optional host-defined configuration,
not a required public property. Judge observations are inputs to Rego; Rego decides
the action.

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_cognitive_services']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

```yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.cognitiveservices
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-cognitiveservices
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: package-2017-04
  - tag: package-2016-02-preview
```

### Tag: package-2017-04 and java

These settings apply only when `--tag=package-2017-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2017-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cognitiveservices.v2017_04_18
  output-folder: $(azure-libraries-for-java-folder)/sdk/cognitiveservices/mgmt-v2017_04_18
regenerate-manager: true
generate-interface: true
```

### Tag: package-2016-02-preview and java

These settings apply only when `--tag=package-2016-02-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

```yaml $(tag) == 'package-2016-02-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.cognitiveservices.v2016_02_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/cognitiveservices/mgmt-v2016_02_01_preview
regenerate-manager: true
generate-interface: true
```
