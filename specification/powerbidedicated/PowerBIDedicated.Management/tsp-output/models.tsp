import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.PowerBIDedicated;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The name of the Azure pricing tier to which the SKU applies.
 */
enum CapacitySkuTier {
  PBIE_Azure,
  Premium,
  AutoPremiumHost,
}

/**
 * The current state of PowerBI Dedicated resource. The state is to indicate more states outside of resource provisioning.
 */
enum State {
  Deleting,
  Succeeded,
  Failed,
  Paused,
  Suspended,
  Provisioning,
  Updating,
  Suspending,
  Pausing,
  Resuming,
  Preparing,
  Scaling,
}

/**
 * The current deployment state of PowerBI Dedicated resource. The provisioningState is to indicate states for resource provisioning.
 */
enum CapacityProvisioningState {
  Deleting,
  Succeeded,
  Failed,
  Paused,
  Suspended,
  Provisioning,
  Updating,
  Suspending,
  Pausing,
  Resuming,
  Preparing,
  Scaling,
}

/**
 * Specifies the generation of the Power BI Embedded capacity. If no value is specified, the default value 'Gen2' is used. [Learn More](https://docs.microsoft.com/power-bi/developer/embedded/power-bi-embedded-generation-2)
 */
enum Mode {
  Gen1,
  Gen2,
}

/**
 * The type of identity that created/modified the resource.
 */
enum IdentityType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

/**
 * The name of the Azure pricing tier to which the SKU applies.
 */
enum VCoreSkuTier {
  AutoScale,
}

/**
 * The current deployment state of an auto scale v-core resource. The provisioningState is to indicate states for resource provisioning.
 */
enum VCoreProvisioningState {
  Succeeded,
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
model DedicatedCapacityProperties extends DedicatedCapacityMutableProperties {
  /**
   * The current state of PowerBI Dedicated resource. The state is to indicate more states outside of resource provisioning.
   */
  @visibility("read")
  state?: State;

  /**
   * The current deployment state of PowerBI Dedicated resource. The provisioningState is to indicate states for resource provisioning.
   */
  @visibility("read")
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
  @visibility("read")
  tenantId?: string;

  /**
   * Capacity name
   */
  @visibility("read")
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
  @visibility("read")
  id?: string;

  /**
   * The name of the PowerBI Dedicated resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the PowerBI Dedicated resource.
   */
  @visibility("read")
  type?: string;

  /**
   * Location of the PowerBI Dedicated resource.
   */
  @visibility("read", "create")
  location: string;

  /**
   * Key-value pairs of additional resource provisioning properties.
   */
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
  tags?: Record<string>;

  /**
   * Properties of the provision operation request.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DedicatedCapacityMutableProperties;
}

/**
 * An object that represents enumerating SKUs for existing resources
 */
model SkuEnumerationForExistingResourceResult {
  /**
   * The collection of available SKUs for existing resources
   */
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
  metricSpecifications?: MetricSpecification[];

  /**
   * Log specifications for exposing diagnostic logs to shoebox.
   */
  logSpecifications?: LogSpecification[];
}

/**
 * Metric specification for exposing performance metrics to shoebox.
 */
model MetricSpecification {
  /**
   * Metric name
   */
  @visibility("read")
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
  @visibility("read")
  unit?: string;

  /**
   * Aggregation type for the metric
   */
  @visibility("read")
  aggregationType?: string;

  /**
   * Pattern used to filter the metric
   */
  @visibility("read")
  metricFilterPattern?: string;

  /**
   * For describing multi dimensional metrics
   */
  dimensions?: MetricSpecificationDimensionsItem[];
}

model MetricSpecificationDimensionsItem {
  /**
   * Dimension of the metric
   */
  @visibility("read")
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
  @visibility("read")
  name?: string;

  /**
   * Localizable name of the log
   */
  displayName?: string;

  /**
   * Blob duration for the log
   */
  @visibility("read")
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
model AutoScaleVCoreProperties extends AutoScaleVCoreMutableProperties {
  /**
   * The object ID of the capacity resource associated with the auto scale v-core resource.
   */
  capacityObjectId?: string;

  /**
   * The current deployment state of an auto scale v-core resource. The provisioningState is to indicate states for resource provisioning.
   */
  @visibility("read")
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
  tags?: Record<string>;

  /**
   * Properties of the update operation request.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AutoScaleVCoreMutableProperties;
}
