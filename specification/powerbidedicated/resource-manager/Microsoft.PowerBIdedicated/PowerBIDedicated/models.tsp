import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.PowerBIDedicated;

/**
 * The name of the Azure pricing tier to which the SKU applies.
 */
union CapacitySkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PBIE_Azure: "PBIE_Azure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Premium: "Premium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AutoPremiumHost: "AutoPremiumHost",
}

/**
 * The current state of PowerBI Dedicated resource. The state is to indicate more states outside of resource provisioning.
 */
union State {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Paused: "Paused",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspending: "Suspending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pausing: "Pausing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Resuming: "Resuming",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Preparing: "Preparing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scaling: "Scaling",
}

/**
 * The current deployment state of PowerBI Dedicated resource. The provisioningState is to indicate states for resource provisioning.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union CapacityProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Paused: "Paused",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspending: "Suspending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pausing: "Pausing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Resuming: "Resuming",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Preparing: "Preparing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scaling: "Scaling",
}

/**
 * Specifies the generation of the Power BI Embedded capacity. If no value is specified, the default value 'Gen2' is used. [Learn More](https://docs.microsoft.com/power-bi/developer/embedded/power-bi-embedded-generation-2)
 */
union Mode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Gen1: "Gen1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Gen2: "Gen2",
}

/**
 * The type of identity that created/modified the resource.
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * The name of the Azure pricing tier to which the SKU applies.
 */
union VCoreSkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AutoScale: "AutoScale",
}

/**
 * The current deployment state of an auto scale v-core resource. The provisioningState is to indicate states for resource provisioning.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union VCoreProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
}

/**
 * Represents the SKU name and Azure pricing tier for PowerBI Dedicated capacity resource.
 */
model CapacitySku {
  /**
   * Name of the SKU level.
   */
  name: string;

  /**
   * The name of the Azure pricing tier to which the SKU applies.
   */
  tier?: CapacitySkuTier;

  /**
   * The capacity of the SKU.
   */
  capacity?: int32;
}

/**
 * Properties of Dedicated Capacity resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DedicatedCapacityProperties extends DedicatedCapacityMutableProperties {
  /**
   * The current state of PowerBI Dedicated resource. The state is to indicate more states outside of resource provisioning.
   */
  @visibility(Lifecycle.Read)
  state?: State;

  /**
   * The current deployment state of PowerBI Dedicated resource. The provisioningState is to indicate states for resource provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CapacityProvisioningState;
}

/**
 * An object that represents a set of mutable Dedicated capacity resource properties.
 */
model DedicatedCapacityMutableProperties {
  /**
   * A collection of Dedicated capacity administrators
   */
  administration?: DedicatedCapacityAdministrators;

  /**
   * Specifies the generation of the Power BI Embedded capacity. If no value is specified, the default value 'Gen2' is used. [Learn More](https://docs.microsoft.com/power-bi/developer/embedded/power-bi-embedded-generation-2)
   */
  mode?: Mode;

  /**
   * Tenant ID for the capacity. Used for creating Pro Plus capacity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Capacity name
   */
  @visibility(Lifecycle.Read)
  friendlyName?: string;
}

/**
 * An array of administrator user identities
 */
model DedicatedCapacityAdministrators {
  /**
   * An array of administrator user identities.
   */
  members?: string[];
}

/**
 * The error object
 */
@error
model ErrorResponse {
  /**
   * The error object.
   */
  error?: {
    /**
     * Error code
     */
    code?: string;

    /**
     * Error message indicating why the operation failed.
     */
    message?: string;
  };
}

/**
 * Provision request specification
 */
model DedicatedCapacityUpdateParameters {
  /**
   * The SKU of the Dedicated capacity resource.
   */
  sku?: CapacitySku;

  /**
   * Key-value pairs of additional provisioning properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Properties of the provision operation request.
   */
  properties?: DedicatedCapacityMutableProperties;
}

/**
 * An array of Dedicated capacities resources.
 */
model DedicatedCapacities {
  /**
   * An array of Dedicated capacities resources.
   */
  @pageItems
  value: DedicatedCapacity[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: string;
}

/**
 * An object that represents enumerating SKUs for new resources
 */
model SkuEnumerationForNewResourceResult {
  /**
   * The collection of available SKUs for new resources
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  value?: CapacitySku[];
}

/**
 * An object that represents enumerating SKUs for existing resources
 */
model SkuEnumerationForExistingResourceResult {
  /**
   * The collection of available SKUs for existing resources
   */
  @OpenAPI.extension("x-ms-identifiers", #["/sku/name"])
  value?: SkuDetailsForExistingResource[];
}

/**
 * An object that represents SKU details for existing resources
 */
model SkuDetailsForExistingResource {
  /**
   * The resource type
   */
  resourceType?: string;

  /**
   * The SKU in SKU details for existing resources.
   */
  sku?: CapacitySku;
}

/**
 * Additional properties to expose performance metrics to shoebox.
 */
model OperationProperties {
  /**
   * Service specification for exposing performance metrics to shoebox.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Service specification for exposing performance metrics to shoebox.
 */
model ServiceSpecification {
  /**
   * Metric specifications for exposing performance metrics to shoebox.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  metricSpecifications?: MetricSpecification[];

  /**
   * Log specifications for exposing diagnostic logs to shoebox.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  logSpecifications?: LogSpecification[];
}

/**
 * Metric specification for exposing performance metrics to shoebox.
 */
model MetricSpecification {
  /**
   * Metric name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Localizable metric name
   */
  displayName?: string;

  /**
   * Localizable description of metric
   */
  displayDescription?: string;

  /**
   * Unit for the metric
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * Aggregation type for the metric
   */
  @visibility(Lifecycle.Read)
  aggregationType?: string;

  /**
   * Pattern used to filter the metric
   */
  @visibility(Lifecycle.Read)
  metricFilterPattern?: string;

  /**
   * For describing multi dimensional metrics
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  dimensions?: MetricSpecificationDimensionsItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MetricSpecificationDimensionsItem {
  /**
   * Dimension of the metric
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Localizable dimension of the metric
   */
  displayName?: string;
}

/**
 * Log specification for exposing diagnostic logs to shoebox.
 */
model LogSpecification {
  /**
   * Name of the log
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Localizable name of the log
   */
  displayName?: string;

  /**
   * Blob duration for the log
   */
  @visibility(Lifecycle.Read)
  blobDuration?: string;
}

/**
 * Details of capacity name request body.
 */
model CheckCapacityNameAvailabilityParameters {
  /**
   * Name for checking availability.
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z][a-z0-9]*$")
  name?: string;

  /**
   * The resource type of PowerBI dedicated.
   */
  type?: string = "Microsoft.PowerBIDedicated/capacities";
}

/**
 * The checking result of capacity name availability.
 */
model CheckCapacityNameAvailabilityResult {
  /**
   * Indicator of availability of the capacity name.
   */
  nameAvailable?: boolean;

  /**
   * The reason of unavailability.
   */
  reason?: string;

  /**
   * The detailed message of the request unavailability.
   */
  message?: string;
}

/**
 * Represents the SKU name and Azure pricing tier for auto scale v-core resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutoScaleVCoreSku {
  /**
   * Name of the SKU level.
   */
  name: string;

  /**
   * The name of the Azure pricing tier to which the SKU applies.
   */
  tier?: VCoreSkuTier;

  /**
   * The capacity of an auto scale v-core resource.
   */
  capacity?: int32;
}

/**
 * Properties of an auto scale v-core resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutoScaleVCoreProperties extends AutoScaleVCoreMutableProperties {
  /**
   * The object ID of the capacity resource associated with the auto scale v-core resource.
   */
  capacityObjectId?: string;

  /**
   * The current deployment state of an auto scale v-core resource. The provisioningState is to indicate states for resource provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: VCoreProvisioningState;
}

/**
 * An object that represents a set of mutable auto scale v-core resource properties.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutoScaleVCoreMutableProperties {
  /**
   * The maximum capacity of an auto scale v-core resource.
   */
  capacityLimit?: int32;
}

/**
 * Update request specification
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutoScaleVCoreUpdateParameters {
  /**
   * The SKU of the auto scale v-core resource.
   */
  sku?: AutoScaleVCoreSku;

  /**
   * Key-value pairs of additional provisioning properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Properties of the update operation request.
   */
  properties?: AutoScaleVCoreMutableProperties;
}

/**
 * An array of auto scale v-core resources.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AutoScaleVCoreListResult {
  /**
   * An array of auto scale v-core resources.
   */
  @pageItems
  value: AutoScaleVCore[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @nextLink
  nextLink?: string;
}

/**
 * Result listing capacities. It contains a list of operations and a URL link to get the next set of results.
 */
model OperationListResult {
  /**
   * List of capacities supported by the Microsoft.PowerBIDedicated resource provider.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Operation[];

  /**
   * URL to get the next set of operation list results if there are any.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Capacities REST API operation.
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The object that represents the operation.
   */
  display?: {
    /**
     * Service provider: Microsoft.PowerBIDedicated.
     */
    @visibility(Lifecycle.Read)
    provider?: string;

    /**
     * Resource on which the operation is performed: capacity, etc.
     */
    @visibility(Lifecycle.Read)
    resource?: string;

    /**
     * Operation type: create, update, delete, etc.
     */
    @visibility(Lifecycle.Read)
    operation?: string;

    /**
     * Localized description of the operation.
     */
    description?: string;
  };

  /**
   * Origin of the operation.
   */
  @visibility(Lifecycle.Read)
  origin?: string;

  /**
   * Additional properties to expose performance metrics to shoebox.
   */
  properties?: {
    /**
     * Service specification for exposing performance metrics to shoebox.
     */
    serviceSpecification?: ServiceSpecification;
  };
}
