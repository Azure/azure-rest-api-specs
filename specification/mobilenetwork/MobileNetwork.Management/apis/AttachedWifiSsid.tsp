import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

import "../models/AttachedWifiSsidModels.tsp";
import "./PacketCoreDataPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@removed(Versions.v2024_06_01)
@doc("Wi-Fi Attached SSID resource. Must be created in the same location as its parent packet core data plane.")
@resource("attachedWifiSsids")
@parentResource(PacketCoreDataPlane)
model AttachedWifiSsid is TrackedResource<AttachedWifiSsidPropertiesFormat> {
  @doc("The name of the Wi-Fi Attached SSID.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("attachedWifiSsidName")
  @segment("attachedWifiSsids")
  @visibility("read")
  name: string;
}

@removed(Versions.v2024_06_01)
@armResourceOperations
interface AttachedWifiSsids {
  @doc("Gets information about the specified Wi-Fi Attached SSID.")
  get is ArmResourceRead<AttachedWifiSsid>;

  @doc("Creates or updates an Wi-Fi Attached SSID. Must be created in the same location as its parent packet core data plane.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AttachedWifiSsid>;

  @doc("Updates an Wi-Fi Attached SSID.")
  @parameterVisibility("read")
  update is ArmCustomPatchSync<AttachedWifiSsid, TagsObject>;

  @doc("Deletes the specified Wi-Fi Attached SSID.")
  delete is ArmResourceDeleteWithoutOkAsync<AttachedWifiSsid>;

  @doc("Gets all the Wi-Fi Attached SSIDs associated with a packet core data plane.")
  listByPacketCoreDataPlane is ArmResourceListByParent<AttachedWifiSsid>;
}

@@doc(AttachedWifiSsids.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Wi-Fi Attached SSID operation."
);
@@doc(AttachedWifiSsids.update::parameters.properties,
  "Parameters supplied to update Wi-Fi Attached SSID tags."
);
