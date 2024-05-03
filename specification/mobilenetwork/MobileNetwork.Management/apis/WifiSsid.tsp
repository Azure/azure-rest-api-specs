import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

import "../models/WifiSsidModels.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@removed(Versions.v2024_06_01)
@doc("Wi-Fi SSID resource. Must be created in the same location as its parent mobile network.")
@resource("wifiSsids")
@parentResource(MobileNetwork)
model WifiSsid is TrackedResource<WifiSsidPropertiesFormat> {
  @doc("The name of the Wi-Fi SSID.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("wifiSsidName")
  @segment("wifiSsids")
  @visibility("read")
  name: string;
}

@removed(Versions.v2024_06_01)
@armResourceOperations
interface WifiSsids {
  @doc("Gets information about the specified Wi-Fi SSID.")
  get is ArmResourceRead<WifiSsid>;

  @doc("Creates or updates a Wi-Fi SSID. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WifiSsid>;

  @doc("Updates Wi-Fi SSID.")
  @parameterVisibility("read")
  update is ArmCustomPatchSync<WifiSsid, TagsObject>;

  @doc("Deletes the specified Wi-Fi SSID.")
  delete is ArmResourceDeleteWithoutOkAsync<WifiSsid>;

  @doc("Lists all Wi-Fi SSIDs in the mobile network.")
  listByMobileNetwork is ArmResourceListByParent<WifiSsid>;
}

@@doc(WifiSsids.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Wi-Fi SSID operation."
);
@@doc(WifiSsids.update::parameters.properties,
  "Parameters supplied to update Wi-Fi SSID tags."
);
