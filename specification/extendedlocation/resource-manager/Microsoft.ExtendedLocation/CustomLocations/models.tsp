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

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * None
   */
  None: "None",
}

/**
 * Type of host the Custom Locations is referencing (Kubernetes, etc...).
 */
union HostType {
  string,

  /**
   * Kubernetes
   */
  Kubernetes: "Kubernetes",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Custom Locations operation.
 */
model customLocationOperation {
  /**
   * Describes the properties of a Custom Locations Operation Value Display.
   */
  display?: customLocationOperationValueDisplay;

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
model customLocationOperationValueDisplay {
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing swagger uses camelCase"
model customLocationProperties {
  /**
   * This is optional input that contains the authentication that should be used to generate the namespace.
   */
  authentication?: customLocationPropertiesAuthentication;

  /**
   * Contains the reference to the add-on that contains charts to deploy CRDs and operators.
   */
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
model customLocationPropertiesAuthentication {
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
 * The Custom Locations patchable resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing swagger uses camelCase"
model patchableCustomLocations {
  /**
   * Identity for the resource.
   */
  identity?: Identity;

  /**
   * The Custom Locations patchable properties.
   */
  properties?: customLocationProperties;

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
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The set of properties for EnabledResourceType specific to a Custom Location
   */
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
  @identifiers(#["apiVersion", "resourceType", "resourceProviderNamespace"])
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing swagger uses camelCase"
model customLocationFindTargetResourceGroupProperties {
  /**
   * Labels of the custom resource, this is a map of {key,value} pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  labels?: Record<string>;
}

/**
 * The Find Target Resource Group operation response.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing swagger uses camelCase"
model customLocationFindTargetResourceGroupResult {
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing swagger uses camelCase"
model resourceSyncRuleProperties {
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
  matchExpressions?: matchExpressionsProperties[];

  /**
   * MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is 'key', the operator is 'In', and the values array contains only 'value'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  matchLabels?: Record<string>;
}

/**
 * Resource Sync Rules matchExpression property definition.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing swagger uses camelCase"
model matchExpressionsProperties {
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
  values?: string[];
}

/**
 * The Resource Sync Rules patchable resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing swagger uses camelCase"
model patchableResourceSyncRule {
  /**
   * The Resource Sync Rules patchable properties.
   */
  properties?: resourceSyncRuleProperties;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Collection of CustomLocationOperation items
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing swagger uses camelCase"
model customLocationOperationsList {
  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: url;

  /**
   * The CustomLocationOperation items
   */
  @identifiers(#["name"])
  @pageItems
  value: customLocationOperation[];
}

/**
 * List of EnabledResourceTypes definition.
 */
model EnabledResourceTypesListResult {
  /**
   * The URL to use for getting the next set of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;

  /**
   * The list of EnabledResourceTypes available for a customLocation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  @pageItems
  value?: EnabledResourceType[];
}
