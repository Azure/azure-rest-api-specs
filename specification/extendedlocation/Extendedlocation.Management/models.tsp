import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ExtendedLocation;

/**
 * The identity type.
 */
union ResourceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * Type of host the Custom Locations is referencing (Kubernetes, etc...).
 */
union HostType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Kubernetes: "Kubernetes",
}

/**
 * Custom Locations operation.
 */
model CustomLocationOperation {
  /**
   * Describes the properties of a Custom Locations Operation Value Display.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  display?: CustomLocationOperationValueDisplay;

  /**
   * Is this Operation a data plane operation
   */
  @visibility(Lifecycle.Read)
  isDataAction?: boolean;

  /**
   * The name of the compute operation.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The origin of the compute operation.
   */
  @visibility(Lifecycle.Read)
  origin?: string;
}

/**
 * Describes the properties of a Custom Locations Operation Value Display.
 */
model CustomLocationOperationValueDisplay {
  /**
   * The description of the operation.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The display name of the compute operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The resource provider for the operation.
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The display name of the resource the operation applies to.
   */
  @visibility(Lifecycle.Read)
  resource?: string;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: ResourceIdentityType;
}

/**
 * Properties for a custom location.
 */
model CustomLocationProperties {
  /**
   * This is optional input that contains the authentication that should be used to generate the namespace.
   */
  authentication?: CustomLocationPropertiesAuthentication;

  /**
   * Contains the reference to the add-on that contains charts to deploy CRDs and operators.
   */
  @OpenAPI.extension("x-ms-identifiers", #["id"])
  clusterExtensionIds?: string[];

  /**
   * Display name for the Custom Locations location.
   */
  displayName?: string;

  /**
   * Connected Cluster or AKS Cluster. The Custom Locations RP will perform a checkAccess API for listAdminCredentials permissions.
   */
  hostResourceId?: string;

  /**
   * Type of host the Custom Locations is referencing (Kubernetes, etc...).
   */
  hostType?: HostType;

  /**
   * Kubernetes namespace that will be created on the specified cluster.
   */
  `namespace`?: string;

  /**
   * Provisioning State for the Custom Location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  provisioningState?: string;
}

/**
 * This is optional input that contains the authentication that should be used to generate the namespace.
 */
model CustomLocationPropertiesAuthentication {
  /**
   * The type of the Custom Locations authentication
   */
  type?: string;

  /**
   * The kubeconfig value.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  value?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The Custom Locations patchable resource definition.
 */
model PatchableCustomLocations {
  /**
   * Identity for the resource.
   */
  identity?: Identity;

  /**
   * The Custom Locations patchable properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: CustomLocationProperties;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * EnabledResourceType definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model EnabledResourceType
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * The set of properties for EnabledResourceType specific to a Custom Location
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: EnabledResourceTypeProperties;

  /**
   * Metadata pertaining to creation and last modification of the resource
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Properties for EnabledResourceType of a custom location.
 */
model EnabledResourceTypeProperties {
  /**
   * Cluster Extension ID
   */
  clusterExtensionId?: string;

  /**
   * Cluster Extension Type
   */
  extensionType?: string;

  /**
   * Metadata of the Resource Type
   */
  @OpenAPI.extension(
    "x-ms-identifiers",
    #["apiVersion", "resourceType", "resourceProviderNamespace"]
  )
  typesMetadata?: EnabledResourceTypePropertiesTypesMetadataItem[];
}

/**
 * Metadata of the Resource Type.
 */
model EnabledResourceTypePropertiesTypesMetadataItem {
  /**
   * Api Version of Resource Type
   */
  apiVersion?: string;

  /**
   * Resource Provider Namespace of Resource Type
   */
  resourceProviderNamespace?: string;

  /**
   * Resource Type
   */
  resourceType?: string;
}

/**
 * The Find Target Resource Group operation request.
 */
model CustomLocationFindTargetResourceGroupProperties {
  /**
   * Labels of the custom resource, this is a map of {key,value} pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  labels?: Record<string>;
}

/**
 * The Find Target Resource Group operation response.
 */
model CustomLocationFindTargetResourceGroupResult {
  /**
   * The matching resource sync rule is the particular resource sync rule that matched the match expressions and labels and had lowest priority. This is the rule responsible for mapping the target resource to the target resource group.
   */
  @visibility(Lifecycle.Read)
  matchedResourceSyncRule?: string;

  /**
   * The target resource group of matching resource sync rule. The labels from the request will be used to find out matching resource sync rule against the selector property of the resource sync rule. The one with highest priority will be returned if there are multiple matching rules.
   */
  @visibility(Lifecycle.Read)
  targetResourceGroup?: string;
}

/**
 * Properties for a resource sync rule. For an unmapped custom resource, its labels will be used to find out matching resource sync rules using the selector property of the resource sync rule. If this resource sync rule has highest priority among all matching rules, then the unmapped custom resource will be projected to the target resource group associated with this resource sync rule.
 */
model ResourceSyncRuleProperties {
  /**
   * Priority represents a priority of the Resource Sync Rule
   */
  priority?: int32;

  /**
   * Provisioning State for the Resource Sync Rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * A label selector is composed of two parts, matchLabels and matchExpressions. The first part, matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is 'key', the operator is 'In', and the values array contains only 'value'. The second part, matchExpressions is a list of resource selector requirements. Valid operators include In, NotIn, Exists, and DoesNotExist. The values set must be non-empty in the case of In and NotIn. The values set must be empty in the case of Exists and DoesNotExist. All of the requirements, from both matchLabels and matchExpressions must all be satisfied in order to match.
   */
  selector?: ResourceSyncRulePropertiesSelector;

  /**
   * For an unmapped custom resource, its labels will be used to find matching resource sync rules. If this resource sync rule is one of the matching rules with highest priority, then the unmapped custom resource will be projected to the target resource group associated with this resource sync rule. The user creating this resource sync rule should have write permissions on the target resource group and this write permission will be validated when creating the resource sync rule.
   */
  targetResourceGroup?: string;
}

/**
 * A label selector is composed of two parts, matchLabels and matchExpressions. The first part, matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is 'key', the operator is 'In', and the values array contains only 'value'. The second part, matchExpressions is a list of resource selector requirements. Valid operators include In, NotIn, Exists, and DoesNotExist. The values set must be non-empty in the case of In and NotIn. The values set must be empty in the case of Exists and DoesNotExist. All of the requirements, from both matchLabels and matchExpressions must all be satisfied in order to match.
 */
model ResourceSyncRulePropertiesSelector {
  /**
   * MatchExpressions is a list of resource selector requirements. Valid operators include In, NotIn, Exists, and DoesNotExist. The values set must be non-empty in the case of In and NotIn. The values set must be empty in the case of Exists and DoesNotExist.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  matchExpressions?: MatchExpressionsProperties[];

  /**
   * MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is 'key', the operator is 'In', and the values array contains only 'value'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  matchLabels?: Record<string>;
}

/**
 * Resource Sync Rules matchExpression property definition.
 */
model MatchExpressionsProperties {
  /**
   * Key is the label key that the selector applies to.
   */
  key?: string;

  /**
   * The Operator field represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.
   */
  operator?: string;

  /**
   * The label value
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  values?: string[];
}

/**
 * The Resource Sync Rules patchable resource definition.
 */
model PatchableResourceSyncRule {
  /**
   * The Resource Sync Rules patchable properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ResourceSyncRuleProperties;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}
