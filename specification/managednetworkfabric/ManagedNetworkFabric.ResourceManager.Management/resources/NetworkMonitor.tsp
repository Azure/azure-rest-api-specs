import "../models/common.tsp";
import "../models/NetworkMonitor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The NetworkMonitor resource definition.")
@added(Versions.v2024_06_15_preview)
@Azure.ResourceManager.Private.armResourceInternal(NetworkMonitorProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkMonitor extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Network Monitor.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkMonitorName")
  @segment("networkMonitors")
  @visibility(Lifecycle.Read)
  name: string;

  /** The NetworkFabric Properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  properties: NetworkMonitorProperties;
}

@armResourceOperations
@added(Versions.v2024_06_15_preview)
interface NetworkMonitors {
  @doc("Implements NetworkMonitor GET method.")
  get is ArmResourceRead<NetworkMonitor>;

  @doc("Creates NetworkMonitor resource.")
  create is ArmResourceCreateOrReplaceAsync<NetworkMonitor>;

  @doc("API to update certain properties of the NetworkMonitor resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NetworkMonitor, NetworkMonitorPatch>;

  @doc("Deletes layer 2 connectivity between compute nodes by managed by named NetworkMonitor name.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkMonitor>;

  @doc("Displays NetworkMonitors list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkMonitor>;

  @doc("Displays NetworkMonitors list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkMonitor>;

  @doc("Enables isolation domain across the fabric or on specified racks.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkMonitor,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;
}

@@doc(NetworkMonitors.updateAdministrativeState::parameters.body,
  "Request payload."
);
