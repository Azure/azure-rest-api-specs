import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ConfigurationStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.AppConfiguration;

/**
 * The feature flag resource along with all resource properties.
 */
@added(Versions.v2026_09_01_preview)
@parentResource(ConfigurationStore)
model FeatureFlag
  is Azure.ResourceManager.ProxyResource<FeatureFlagProperties> {
  ...ResourceNameParameter<
    Resource = FeatureFlag,
    KeyName = "featureFlagName",
    SegmentName = "featureFlags",
    NamePattern = "^[\\s\\S]{1,10000}$"
  >;
}

/**
 * Operations for managing feature flags through the data plane proxy.
 */
@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface FeatureFlags {
  /**
   * Gets the properties of the specified feature flag through the data plane proxy.
   */
  get is ArmResourceRead<FeatureFlag>;

  /**
   * Creates or updates a feature flag through the data plane proxy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<FeatureFlag>;

  /**
   * Deletes a feature flag through the data plane proxy.
   */
  delete is ArmResourceDeleteWithoutOkAsync<FeatureFlag>;
}

/**
 * All feature flag properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Feature flags are data plane proxy resources and do not have a provisioning state."
@added(Versions.v2026_09_01_preview)
model FeatureFlagProperties {
  /**
   * The enabled state of the feature flag.
   */
  enabled: boolean;

  /**
   * The label the feature flag belongs to.
   */
  @visibility(Lifecycle.Read)
  label?: string;

  /**
   * The description of the feature flag.
   */
  description?: string;

  /**
   * The conditions that must be met for the feature flag to be enabled.
   */
  conditions?: FeatureFlagConditions;

  /**
   * The variants of the feature flag.
   */
  @identifiers(#["name"])
  variants?: FeatureFlagVariantDefinition[];

  /**
   * The allocation of the feature flag.
   */
  allocation?: FeatureFlagAllocation;

  /**
   * The telemetry settings of the feature flag.
   */
  telemetry?: FeatureFlagTelemetryConfiguration;

  /**
   * The tags of the feature flag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Feature flag tags are an open dictionary defined by the data plane contract."
  tags?: Record<string>;

  /**
   * The last time the feature flag was modified.
   */
  @visibility(Lifecycle.Read)
  lastModified?: utcDateTime;

  /**
   * An ETag indicating the state of the feature flag.
   */
  @visibility(Lifecycle.Read)
  eTag?: string;
}

/**
 * The conditions that must be met for a feature flag to be enabled.
 */
@added(Versions.v2026_09_01_preview)
model FeatureFlagConditions {
  /**
   * The requirement type for the conditions.
   */
  requirementType?: FeatureFlagRequirementType;

  /**
   * The filters that conditionally enable or disable the feature flag.
   */
  @identifiers(#["name"])
  filters?: FeatureFlagFilter[];
}

/**
 * The requirement type for feature flag conditions.
 */
@added(Versions.v2026_09_01_preview)
union FeatureFlagRequirementType {
  /**
   * Any condition can enable the feature flag.
   */
  Any: "Any",

  /**
   * All conditions must enable the feature flag.
   */
  All: "All",

  string,
}

/**
 * A filter that conditionally enables or disables a feature flag.
 */
@added(Versions.v2026_09_01_preview)
model FeatureFlagFilter {
  /**
   * The name of the filter.
   */
  name: string;

  /**
   * The parameters used by the filter.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Feature flag filter parameters are an open dictionary defined by each filter."
  parameters?: Record<string>;
}

/**
 * A feature flag variant.
 */
@added(Versions.v2026_09_01_preview)
model FeatureFlagVariantDefinition {
  /**
   * The name of the variant.
   */
  name: string;

  /**
   * The value of the variant.
   */
  value?: string;

  /**
   * The content type of the variant value.
   */
  contentType?: string;

  /**
   * The status override for the variant.
   */
  statusOverride?: FeatureFlagStatusOverride;
}

/**
 * The status override for a feature flag variant.
 */
@added(Versions.v2026_09_01_preview)
union FeatureFlagStatusOverride {
  /**
   * The variant does not override the feature flag status.
   */
  None: "None",

  /**
   * The variant enables the feature flag.
   */
  Enabled: "Enabled",

  /**
   * The variant disables the feature flag.
   */
  Disabled: "Disabled",

  string,
}

/**
 * The allocation of feature flag variants.
 */
@added(Versions.v2026_09_01_preview)
model FeatureFlagAllocation {
  /**
   * The default variant to use when the feature flag is disabled.
   */
  defaultWhenDisabled?: string;

  /**
   * The default variant to use when the feature flag is enabled but not allocated.
   */
  defaultWhenEnabled?: string;

  /**
   * The percentile allocations for variants.
   */
  @identifiers(#["variant"])
  percentile?: FeatureFlagPercentileAllocation[];

  /**
   * The user allocations for variants.
   */
  @identifiers(#["variant"])
  user?: FeatureFlagUserAllocation[];

  /**
   * The group allocations for variants.
   */
  @identifiers(#["variant"])
  group?: FeatureFlagGroupAllocation[];

  /**
   * The seed used for random allocation.
   */
  seed?: string;
}

/**
 * A percentile allocation for a feature flag variant.
 */
@added(Versions.v2026_09_01_preview)
model FeatureFlagPercentileAllocation {
  /**
   * The variant to allocate the percentile range to.
   */
  variant: string;

  /**
   * The inclusive lower bound of the percentile range.
   */
  @minValue(0)
  @maxValue(100)
  from: float64;

  /**
   * The exclusive upper bound of the percentile range.
   */
  @minValue(0)
  @maxValue(100)
  to: float64;
}

/**
 * A user allocation for a feature flag variant.
 */
@added(Versions.v2026_09_01_preview)
model FeatureFlagUserAllocation {
  /**
   * The variant to allocate to the users.
   */
  variant: string;

  /**
   * The users that receive the variant.
   */
  users: string[];
}

/**
 * A group allocation for a feature flag variant.
 */
@added(Versions.v2026_09_01_preview)
model FeatureFlagGroupAllocation {
  /**
   * The variant to allocate to the groups.
   */
  variant: string;

  /**
   * The groups that receive the variant.
   */
  groups: string[];
}

/**
 * The telemetry configuration for a feature flag.
 */
@added(Versions.v2026_09_01_preview)
model FeatureFlagTelemetryConfiguration {
  /**
   * Whether telemetry is enabled.
   */
  enabled: boolean;

  /**
   * The metadata included on outbound telemetry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Feature flag telemetry metadata is an open dictionary defined by the data plane contract."
  metadata?: Record<string>;
}

@@doc(
  FeatureFlag.name,
  "Identifier of feature flag name and label combination. The name and label are joined by the $ character. The label is optional."
);
@@doc(FeatureFlag.properties, "All feature flag properties.");
@@doc(
  FeatureFlags.createOrUpdate::parameters.resource,
  "The parameters for creating or updating a feature flag."
);
