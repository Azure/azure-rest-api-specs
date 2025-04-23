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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PBIE_Azure: "PBIE_Azure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Premium: "Premium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutoPremiumHost: "AutoPremiumHost",
}

/**
 * The current state of PowerBI Dedicated resource. The state is to indicate more states outside of resource provisioning.
 */
union State {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Paused: "Paused",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspending: "Suspending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pausing: "Pausing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Resuming: "Resuming",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Preparing: "Preparing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Scaling: "Scaling",
}

/**
 * The current deployment state of PowerBI Dedicated resource. The provisioningState is to indicate states for resource provisioning.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union CapacityProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Paused: "Paused",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspending: "Suspending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pausing: "Pausing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Resuming: "Resuming",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Preparing: "Preparing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Scaling: "Scaling",
}

/**
 * Specifies the generation of the Power BI Embedded capacity. If no value is specified, the default value 'Gen2' is used. [Learn More](https://docs.microsoft.com/power-bi/developer/embedded/power-bi-embedded-generation-2)
 */
union Mode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Gen1: "Gen1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Gen2: "Gen2",
}

/**
 * The type of identity that created/modified the resource.
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * The name of the Azure pricing tier to which the SKU applies.
 */
union VCoreSkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutoScale: "AutoScale",
}

/**
 * The current deployment state of an auto scale v-core resource. The provisioningState is to indicate states for resource provisioning.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union VCoreProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
 * Represents an instance of an PowerBI Dedicated resource.
 */
model Resource {
  /**
   * An identifier that represents the PowerBI Dedicated resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the PowerBI Dedicated resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the PowerBI Dedicated resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Location of the PowerBI Dedicated resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Key-value pairs of additional resource provisioning properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  systemData?: SystemData;
}

/**
 * The error object
 */
model ErrorResponseError {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Properties of the provision operation request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: DedicatedCapacityMutableProperties;
}

/**
 * An array of Dedicated capacities resources.
 */
@pagedResult
model DedicatedCapacities {
  /**
   * An array of Dedicated capacities resources.
   */
  @items
  value: DedicatedCapacity[];
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
model AutoScaleVCoreMutableProperties {
  /**
   * The maximum capacity of an auto scale v-core resource.
   */
  capacityLimit?: int32;
}

/**
 * Update request specification
 */
model AutoScaleVCoreUpdateParameters {
  /**
   * The SKU of the auto scale v-core resource.
   */
  sku?: AutoScaleVCoreSku;

  /**
   * Key-value pairs of additional provisioning properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Properties of the update operation request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: AutoScaleVCoreMutableProperties;
}

/**
 * An array of auto scale v-core resources.
 */
@pagedResult
model AutoScaleVCoreListResult {
  /**
   * An array of auto scale v-core resources.
   */
  @items
  value: AutoScaleVCore[];
}
