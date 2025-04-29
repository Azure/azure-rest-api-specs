using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20250101_preview)
@doc("FlexComponent Resource Definition")
@parentResource(SubscriptionLocationResource)
model FlexComponent is ProxyResource<FlexComponentProperties> {
  ...ResourceNameParameter<FlexComponent>;
}

@added(Versions.v20250101_preview)
@doc("Hardware Type enum")
union HardwareType {
  @doc("Hardware type is Database Server")
  COMPUTE: "COMPUTE",

  @doc("Hardware type is Storage Server")
  CELL: "CELL",

  string,
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@added(Versions.v20250101_preview)
@doc("FlexComponent resource model")
model FlexComponentProperties {
  @doc("The minimum number of CPU cores that can be enabled on the DB Server for this Flex Component.")
  @visibility(Lifecycle.Read)
  minimumCoreCount?: int32;

  @doc("The maximum number of CPU cores that can be enabled on the DB Server for this Flex Component.")
  @visibility(Lifecycle.Read)
  availableCoreCount?: int32;

  @doc("The maximum storage that can be enabled on the Storage Server for this Flex Component.")
  @visibility(Lifecycle.Read)
  availableDbStorageInGbs?: int32;

  @doc("The runtime minimum number of CPU cores that can be enabled for this Flex Component.")
  @visibility(Lifecycle.Read)
  runtimeMinimumCoreCount?: int32;

  @doc("The name of the DB system shape for this Flex Component.")
  @minLength(1)
  @maxLength(255)
  @visibility(Lifecycle.Read)
  shape?: string;

  @doc("The maximum memory size that can be enabled on the DB Server for this Flex Component.")
  @visibility(Lifecycle.Read)
  availableMemoryInGbs?: int32;

  @doc("The maximum local storage that can be enabled on the DB Server for this Flex Component.")
  @visibility(Lifecycle.Read)
  availableLocalStorageInGbs?: int32;

  @doc("The compute model of the DB Server for this Flex Component.")
  @visibility(Lifecycle.Read)
  computeModel?: string;

  @doc("The hardware type of the DB (Compute) or Storage (Cell) Server for this Flex Component.")
  @visibility(Lifecycle.Read)
  hardwareType?: HardwareType;

  @doc("The description summary for this Flex Component.")
  @minLength(1)
  @maxLength(255)
  @visibility(Lifecycle.Read)
  descriptionSummary?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@added(Versions.v20250101_preview)
@doc("FlexComponents filter")
model FlexComponentsFilter {
  @query
  @doc("If provided, filters the results for the given shape")
  @minLength(1)
  @maxLength(255)
  shape?: SystemShapes;
}
