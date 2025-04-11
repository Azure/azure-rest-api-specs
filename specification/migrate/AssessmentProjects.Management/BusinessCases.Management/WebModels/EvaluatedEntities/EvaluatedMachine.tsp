import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../../../Common/ArmModels/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Evaluated machine resource.")
@parentResource(BusinessCase)
model EvaluatedMachine is ProxyResource<EvaluatedMachineProperties> {
  @doc("Business case Evaluated machine ARM name")
  @key("evaluatedMachineName")
  @segment("evaluatedMachines")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a hydrated resource with no PUT call."
@doc("Evaluated machine properties class.")
model EvaluatedMachineProperties {
  @doc("Machine Id.")
  @visibility(Lifecycle.Read)
  machineId?: string;

  @doc("Server Name.")
  @visibility(Lifecycle.Read)
  serverName?: string;

  @doc("Virtualization type.")
  @visibility(Lifecycle.Read)
  virtualizationType?: string;

  @doc("Activity state.")
  @visibility(Lifecycle.Read)
  activityState?: string;

  @doc("Operating System (OS) name.")
  @visibility(Lifecycle.Read)
  operatingSystemName?: string;

  @doc("Recommended Azure target.")
  @visibility(Lifecycle.Read)
  recommendedAzureTarget?: string;

  @doc("Qualifying offer.")
  @visibility(Lifecycle.Read)
  qualifyingOffer?: string;

  @doc("Is machine ready for migration.")
  @visibility(Lifecycle.Read)
  readyForMigration?: string;

  @doc("End of Support status.")
  @visibility(Lifecycle.Read)
  supportStatus?: SupportabilityStatus;
}
