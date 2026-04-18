import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;

namespace Microsoft.Network;

/**
 * SmartGroup resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "New resource type for grouping multiple source selectors (KubeSelector, GeoLocation, etc.)"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheriting from Resource for consistency with existing Network top-level resources"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Using custom resource model for consistency with existing Network resources"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.smartGroup)
@Http.Private.includeInapplicableMetadataInPayload(false)
@added(Versions.v2025_07_01)
model SmartGroup extends Common.Resource {
  properties?: SmartGroupProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("smartGroupName")
  @segment("smartGroups")
  @pattern("^[a-zA-Z0-9_.-]*$")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Standard etag pattern for Network resources"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.smartGroup)
@added(Versions.v2025_07_01)
@armResourceOperations
interface SmartGroups {
  /**
   * Gets the specified SmartGroup.
   */
  get is ArmResourceRead<SmartGroup, Error = CloudError>;

  /**
   * Creates or updates a SmartGroup.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SmartGroup,
    Error = CloudError
  >;

  /**
   * Updates tags of a SmartGroup resource.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    SmartGroup,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified SmartGroup.
   */
  delete is ArmResourceDeleteWithoutOkAsync<SmartGroup, Error = CloudError>;

  /**
   * Gets all the SmartGroups in a resource group.
   */
  list is ArmResourceListByParent<SmartGroup, Error = CloudError>;

  /**
   * Gets all the SmartGroups in a subscription.
   */
  listAll is ArmListBySubscription<SmartGroup, Error = CloudError>;
}

@@doc(SmartGroup.name, "The name of the SmartGroup.");
@@doc(SmartGroup.properties, "Properties of the SmartGroup resource.");
@@doc(SmartGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SmartGroup operation."
);
@@doc(SmartGroups.updateTags::parameters.properties,
  "Parameters supplied to update SmartGroup tags."
);

/**
 * Properties of the SmartGroup resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.smartGroup)
@added(Versions.v2025_07_01)
model SmartGroupProperties {
  /**
   * The collection of group entries. Each entry has a name, type, and type-specific properties.
   */
  @identifiers(#["name"])
  groups?: SmartGroupEntry[];

  /**
   * The firewall policy IDs referencing this SmartGroup. System-managed, read-only.
   */
  @visibility(Lifecycle.Read)
  firewallPolicyIds?: SubResource[];

  /**
   * The provisioning state of the SmartGroup resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * A single entry in a SmartGroup. Each entry has a name, a discriminator type, and type-specific properties.
 * Currently supported types: KubeSelector.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.smartGroup)
@added(Versions.v2025_07_01)
model SmartGroupEntry {
  /**
   * The name of this group entry.
   */
  name?: string;

  /**
   * The type discriminator (e.g. "KubeSelector").
   */
  type?: string;

  /**
   * The type-specific properties for this group entry.
   */
  properties?: SmartGroupEntryProperties;
}

/**
 * Type-specific properties for a SmartGroupEntry. Currently only KubeSelector fields are populated.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.smartGroup)
@added(Versions.v2025_07_01)
model SmartGroupEntryProperties {
  /**
   * The ARM resource IDs of the managedClusters. Used when type is KubeSelector.
   */
  clusterIds?: string[];

  /**
   * The label selector for matching Kubernetes pods. Used when type is KubeSelector.
   */
  selector?: KubeSelectorGroupSelector;
}

/**
 * Label selector for matching Kubernetes pods.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.smartGroup)
@added(Versions.v2025_07_01)
model KubeSelectorGroupSelector {
  /**
   * Pod label key-value pairs (AND semantics).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "matchLabels is a free-form key-value map of Kubernetes labels"
  matchLabels?: Record<string>;

  /**
   * Set-based label selector requirements (AND semantics with matchLabels).
   */
  @identifiers(#["key"])
  matchExpressions?: KubeSelectorMatchExpression[];

  /**
   * The namespace selector for scoping by namespace labels.
   */
  namespaceSelector?: KubeSelectorGroupNamespaceSelector;
}

/**
 * Namespace selector for scoping by namespace labels.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.smartGroup)
@added(Versions.v2025_07_01)
model KubeSelectorGroupNamespaceSelector {
  /**
   * Namespace label key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "matchLabels is a free-form key-value map of Kubernetes labels"
  matchLabels?: Record<string>;

  /**
   * Set-based namespace label selector requirements.
   */
  @identifiers(#["key"])
  matchExpressions?: KubeSelectorMatchExpression[];
}

/**
 * A set-based label selector requirement for matching Kubernetes labels.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.smartGroup)
@added(Versions.v2025_07_01)
model KubeSelectorMatchExpression {
  /**
   * The label key that the selector applies to.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "This is a Kubernetes label key, not a secret"
  key?: string;

  /**
   * The operator representing the relationship between the label key and values. Supported values are In, NotIn, Exists, and DoesNotExist.
   */
  operator?: KubeSelectorMatchExpressionOperator;

  /**
   * The set of values. Required for In and NotIn operators, must be empty for Exists and DoesNotExist.
   */
  values?: string[];
}

/**
 * The operator for a KubeSelectorMatchExpression.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Using Legacy.feature for consistency with existing Network resources"
@Azure.ResourceManager.Legacy.feature(Features.smartGroup)
@added(Versions.v2025_07_01)
union KubeSelectorMatchExpressionOperator {
  string,

  /** Matches when the label value is in the specified set. */
  In: "In",

  /** Matches when the label value is not in the specified set. */
  NotIn: "NotIn",

  /** Matches when the label key exists, regardless of value. */
  Exists: "Exists",

  /** Matches when the label key does not exist. */
  DoesNotExist: "DoesNotExist",
}
