import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/** ******************* */
/**
 * dataflowProfile resource type model details.
 */
@doc("Instance dataflowProfile resource")
@parentResource(InstanceResource)
model DataflowProfileResource is ProxyResource<DataflowProfileProperties> {
  @doc("Name of Instance dataflowProfile resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("dataflowProfileName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("dataflowProfiles")
  name: string;

  // Extended location is not included in ProxyResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

@doc("DataflowProfile Resource properties")
model DataflowProfileProperties {
  @doc("Spec defines the desired identities of NBC diagnostics settings.")
  diagnostics?: ProfileDiagnostics;

  @doc("To manually scale the dataflow profile, specify the maximum number of instances you want to run.")
  @minValue(1)
  @maxValue(20)
  instanceCount?: int32 = 1;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("DataflowProfile Diagnostics properties")
model ProfileDiagnostics {
  ...MetricProperties;
}
