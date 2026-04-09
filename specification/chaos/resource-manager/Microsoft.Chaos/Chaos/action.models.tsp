import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * Model that represents an Action resource.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
model Action is Azure.ResourceManager.ProxyResource<ActionProperties, false> {
  ...ResourceNameParameter<
    Resource = Action,
    KeyName = "actionName",
    SegmentName = "actions",
    NamePattern = "^[a-zA-Z0-9\\-]+$"
  >;
}

/**
 * Model that represents an Action Version resource.
 */
@parentResource(Action)
@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
model ActionVersion
  is Azure.ResourceManager.ProxyResource<ActionProperties, false> {
  ...ResourceNameParameter<
    Resource = ActionVersion,
    KeyName = "versionName",
    SegmentName = "versions",
    NamePattern = "^[a-zA-Z0-9\\.]+$"
  >;
}

/**
 * Union of action types.
 */
@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
union ActionKind {
  string,

  /** Discrete action type. */
  Discrete: "Discrete",

  /** Continuous action type. */
  Continuous: "Continuous",

  /** Cancelable action type. */
  Cancelable: "Cancelable",
}

/**
 * Model that represents the properties of an Action resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only metadata resource."
@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
model ActionProperties {
  /**
   * Canonical identifier of the action (e.g., "microsoft-compute-shutdown/1.0").
   */
  @visibility(Lifecycle.Read)
  canonicalId?: string;

  /**
   * Human-readable display name of the action.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Description of what this action does.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The short name of the action (e.g., "Shutdown").
   */
  @visibility(Lifecycle.Read)
  actionName?: string;

  /**
   * The version of the action (e.g., "1.0.0").
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The type of the action.
   */
  @visibility(Lifecycle.Read)
  actionType?: ActionKind;

  /**
   * List of target types supported by this action.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["targetType"])
  supportedTargetTypes?: ActionSupportedTargetType[];

  /**
   * JSON Schema describing the parameters for this action.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "parametersSchema is a dynamic JSON Schema object whose structure varies per action."
  @visibility(Lifecycle.Read)
  parametersSchema?: Record<unknown>;

  /**
   * Recommended Azure RBAC role definition GUIDs for this action.
   */
  @visibility(Lifecycle.Read)
  recommendedRoles?: string[];
}

/**
 * Model that represents a target type supported by an action.
 */
@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
model ActionSupportedTargetType {
  /**
   * The ARM resource type (e.g., "Microsoft.Compute/virtualMachines").
   */
  targetType?: string;

  /**
   * List of ARM permissions required for this target type.
   */
  requiredPermissions?: string[];
}

/**
 * Model that represents a list of Action resources and a link for pagination.
 */
@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
model ActionListResult is Azure.Core.Page<Action>;

/**
 * Model that represents a list of Action Version resources and a link for pagination.
 */
@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
model ActionVersionListResult is Azure.Core.Page<ActionVersion>;
