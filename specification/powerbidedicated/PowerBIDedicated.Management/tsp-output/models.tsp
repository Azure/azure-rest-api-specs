import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.PowerBIDedicated;

interface Operations extends Azure.ResourceManager.Operations {}

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

@doc("Represents the SKU name and Azure pricing tier for PowerBI Dedicated capacity resource.")
model CapacitySku {
  @doc("Name of the SKU level.")
  name: string;

  @doc("The name of the Azure pricing tier to which the SKU applies.")
  tier?: CapacitySkuTier;

  @doc("The capacity of the SKU.")
  capacity?: int32;
}

@doc("Properties of Dedicated Capacity resource.")
model DedicatedCapacityProperties extends DedicatedCapacityMutableProperties {
  @doc("The current state of PowerBI Dedicated resource. The state is to indicate more states outside of resource provisioning.")
  @visibility("read")
  state?: State;

  @doc("The current deployment state of PowerBI Dedicated resource. The provisioningState is to indicate states for resource provisioning.")
  @visibility("read")
  provisioningState?: CapacityProvisioningState;
}

@doc("An array of administrator user identities")
model DedicatedCapacityAdministrators {
  @doc("An array of administrator user identities.")
  members?: string[];
}

@doc("The error object")
model ErrorResponseError {
  @doc("Error code")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  message?: string;
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
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z][a-z0-9]*$")
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
model AutoScaleVCoreProperties extends AutoScaleVCoreMutableProperties {
  @doc("The object ID of the capacity resource associated with the auto scale v-core resource.")
  capacityObjectId?: string;

  @doc("The current deployment state of an auto scale v-core resource. The provisioningState is to indicate states for resource provisioning.")
  @visibility("read")
  provisioningState?: VCoreProvisioningState;
}
