import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace PowerBIDedicated;

enum CapacitySkuTier {
  PBIE_Azure,
  Premium,
  AutoPremiumHost,
}

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

enum Mode {
  Gen1,
  Gen2,
}

enum IdentityType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum VCoreSkuTier {
  AutoScale,
}

enum VCoreProvisioningState {
  Succeeded,
}

@doc("Represents an instance of a Dedicated Capacity resource.")
model DedicatedCapacity {
  ...Resource;

  @doc("The SKU of the PowerBI Dedicated capacity resource.")
  sku: CapacitySku;

  @doc("Properties of the provision operation request.")
  properties?: DedicatedCapacityProperties;
}

@doc("""
Represents the SKU name and Azure pricing tier for PowerBI Dedicated capacity
resource.
""")
model CapacitySku {
  @doc("Name of the SKU level.")
  name: string;

  @doc("The name of the Azure pricing tier to which the SKU applies.")
  tier?: CapacitySkuTier;

  @doc("The capacity of the SKU.")
  capacity?: int32;
}

@doc("Properties of Dedicated Capacity resource.")
model DedicatedCapacityProperties {
  ...DedicatedCapacityMutableProperties;

  @doc("""
The current state of PowerBI Dedicated resource. The state is to indicate more
states outside of resource provisioning.
""")
  @visibility("read")
  state?: State;

  @doc("""
The current deployment state of PowerBI Dedicated resource. The
provisioningState is to indicate states for resource provisioning.
""")
  @visibility("read")
  provisioningState?: CapacityProvisioningState;
}

@doc("""
An object that represents a set of mutable Dedicated capacity resource
properties.
""")
model DedicatedCapacityMutableProperties {
  @doc("A collection of Dedicated capacity administrators")
  administration?: DedicatedCapacityAdministrators;

  @doc("""
Specifies the generation of the Power BI Embedded capacity. If no value is
specified, the default value 'Gen2' is used. [Learn
More](https://docs.microsoft.com/power-bi/developer/embedded/power-bi-embedded-generation-2)
""")
  mode?: Mode;

  @doc("Tenant ID for the capacity. Used for creating Pro Plus capacity.")
  @visibility("read")
  tenantId?: string;

  @doc("Capacity name")
  @visibility("read")
  friendlyName?: string;
}

@doc("An array of administrator user identities")
model DedicatedCapacityAdministrators {
  @doc("An array of administrator user identities.")
  members?: string[];
}

@doc("Represents an instance of an PowerBI Dedicated resource.")
model Resource {
  @doc("An identifier that represents the PowerBI Dedicated resource.")
  @visibility("read")
  id?: string;

  @doc("The name of the PowerBI Dedicated resource.")
  @visibility("read")
  name?: string;

  @doc("The type of the PowerBI Dedicated resource.")
  @visibility("read")
  type?: string;

  @doc("Location of the PowerBI Dedicated resource.")
  location: string;

  @doc("Key-value pairs of additional resource provisioning properties.")
  tags?: Record<string>;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  systemData?: SystemData;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("An identifier for the identity that created the resource")
  createdBy?: string;

  @doc("The type of identity that created the resource")
  createdByType?: IdentityType;

  @doc("The timestamp of resource creation (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("An identifier for the identity that last modified the resource")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource")
  lastModifiedByType?: IdentityType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("Describes the format of Error response.")
@error
model ErrorResponse {
  @doc("The error object")
  error?: ErrorResponseError;
}

@doc("The error object")
model ErrorResponseError {
  @doc("Error code")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  message?: string;
}

@doc("Provision request specification")
model DedicatedCapacityUpdateParameters {
  @doc("The SKU of the Dedicated capacity resource.")
  sku?: CapacitySku;

  @doc("Key-value pairs of additional provisioning properties.")
  tags?: Record<string>;

  @doc("Properties of the provision operation request.")
  properties?: DedicatedCapacityMutableProperties;
}

@doc("An array of Dedicated capacities resources.")
@pagedResult
model DedicatedCapacities {
  @doc("An array of Dedicated capacities resources.")
  @items
  value: DedicatedCapacity[];
}

@doc("An object that represents enumerating SKUs for new resources")
model SkuEnumerationForNewResourceResult {
  @doc("The collection of available SKUs for new resources")
  value?: CapacitySku[];
}

@doc("An object that represents enumerating SKUs for existing resources")
model SkuEnumerationForExistingResourceResult {
  @doc("The collection of available SKUs for existing resources")
  value?: SkuDetailsForExistingResource[];
}

@doc("An object that represents SKU details for existing resources")
model SkuDetailsForExistingResource {
  @doc("The resource type")
  resourceType?: string;

  @doc("The SKU in SKU details for existing resources.")
  sku?: CapacitySku;
}

@doc("""
Result listing capacities. It contains a list of operations and a URL link to
get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("Capacities REST API operation.")
model Operation {
  @doc("Operation name: {provider}/{resource}/{operation}.")
  @visibility("read")
  name?: string;

  @doc("The object that represents the operation.")
  display?: OperationDisplay;

  @doc("Origin of the operation.")
  @visibility("read")
  origin?: string;

  @doc("Additional properties to expose performance metrics to shoebox.")
  properties?: OperationProperties;
}

@doc("The object that represents the operation.")
model OperationDisplay {
  @doc("Service provider: Microsoft.PowerBIDedicated.")
  @visibility("read")
  provider?: string;

  @doc("Resource on which the operation is performed: capacity, etc.")
  @visibility("read")
  resource?: string;

  @doc("Operation type: create, update, delete, etc.")
  @visibility("read")
  operation?: string;

  @doc("Localized description of the operation.")
  description?: string;
}

@doc("Additional properties to expose performance metrics to shoebox.")
model OperationProperties {
  @doc("Service specification for exposing performance metrics to shoebox.")
  serviceSpecification?: ServiceSpecification;
}

@doc("Service specification for exposing performance metrics to shoebox.")
model ServiceSpecification {
  @doc("Metric specifications for exposing performance metrics to shoebox.")
  metricSpecifications?: MetricSpecification[];

  @doc("Log specifications for exposing diagnostic logs to shoebox.")
  logSpecifications?: LogSpecification[];
}

@doc("Metric specification for exposing performance metrics to shoebox.")
model MetricSpecification {
  @doc("Metric name")
  @visibility("read")
  name?: string;

  @doc("Localizable metric name")
  displayName?: string;

  @doc("Localizable description of metric")
  displayDescription?: string;

  @doc("Unit for the metric")
  @visibility("read")
  unit?: string;

  @doc("Aggregation type for the metric")
  @visibility("read")
  aggregationType?: string;

  @doc("Pattern used to filter the metric")
  @visibility("read")
  metricFilterPattern?: string;

  @doc("For describing multi dimensional metrics")
  dimensions?: MetricSpecificationDimensionsItem[];
}

model MetricSpecificationDimensionsItem {
  @doc("Dimension of the metric")
  @visibility("read")
  name?: string;

  @doc("Localizable dimension of the metric")
  displayName?: string;
}

@doc("Log specification for exposing diagnostic logs to shoebox.")
model LogSpecification {
  @doc("Name of the log")
  @visibility("read")
  name?: string;

  @doc("Localizable name of the log")
  displayName?: string;

  @doc("Blob duration for the log")
  @visibility("read")
  blobDuration?: string;
}

@doc("Details of capacity name request body.")
model CheckCapacityNameAvailabilityParameters {
  @doc("Name for checking availability.")
  name?: string;

  @doc("The resource type of PowerBI dedicated.")
  type?: string;
}

@doc("The checking result of capacity name availability.")
model CheckCapacityNameAvailabilityResult {
  @doc("Indicator of availability of the capacity name.")
  nameAvailable?: boolean;

  @doc("The reason of unavailability.")
  reason?: string;

  @doc("The detailed message of the request unavailability.")
  message?: string;
}

@doc("Represents an instance of an auto scale v-core resource.")
model AutoScaleVCore {
  ...Resource;

  @doc("The SKU of the auto scale v-core resource.")
  sku: AutoScaleVCoreSku;

  @doc("Properties of an auto scale v-core resource.")
  properties?: AutoScaleVCoreProperties;
}

@doc("Represents the SKU name and Azure pricing tier for auto scale v-core resource.")
model AutoScaleVCoreSku {
  @doc("Name of the SKU level.")
  name: string;

  @doc("The name of the Azure pricing tier to which the SKU applies.")
  tier?: VCoreSkuTier;

  @doc("The capacity of an auto scale v-core resource.")
  capacity?: int32;
}

@doc("Properties of an auto scale v-core resource.")
model AutoScaleVCoreProperties {
  ...AutoScaleVCoreMutableProperties;

  @doc("""
The object ID of the capacity resource associated with the auto scale v-core
resource.
""")
  capacityObjectId?: string;

  @doc("""
The current deployment state of an auto scale v-core resource. The
provisioningState is to indicate states for resource provisioning.
""")
  @visibility("read")
  provisioningState?: VCoreProvisioningState;
}

@doc("""
An object that represents a set of mutable auto scale v-core resource
properties.
""")
model AutoScaleVCoreMutableProperties {
  @doc("The maximum capacity of an auto scale v-core resource.")
  capacityLimit?: int32;
}

@doc("Update request specification")
model AutoScaleVCoreUpdateParameters {
  @doc("The SKU of the auto scale v-core resource.")
  sku?: AutoScaleVCoreSku;

  @doc("Key-value pairs of additional provisioning properties.")
  tags?: Record<string>;

  @doc("Properties of the update operation request.")
  properties?: AutoScaleVCoreMutableProperties;
}

@doc("An array of auto scale v-core resources.")
@pagedResult
model AutoScaleVCoreListResult {
  @doc("An array of auto scale v-core resources.")
  @items
  value: AutoScaleVCore[];
}
