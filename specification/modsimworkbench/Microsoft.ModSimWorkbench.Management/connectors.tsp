import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common-types.tsp";
import "./chambers.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.ModSimWorkbench")
@service({
  title: "ModSimWorkbench Control Plane API",
})
@armProviderNamespace
@versioned(Microsoft.ModSimWorkbench.Versions)
namespace Microsoft.ModSimWorkbench;

@doc("Access type enumeration")
union AccessType {
  string,

  @doc("Graphical User Interface")
  GUI: "GUI",
}

@doc("Gateway type enumeration")
union GatewayType {
  string,

  @doc("ExpressRoute virtual network gateway")
  ExpressRoute: "ExpressRoute",

  @doc("No gateway")
  None: "None",

  @doc("Virtual Private Network")
  VPN: "VPN",
}

@doc("Access configuration")
model AccessConfiguration {
  @visibility("read", "create")
  @doc("Access type")
  accessType: AccessType;

  @visibility("read", "create")
  @doc("Gateway type.")
  gatewayType: GatewayType;

  @visibility("read")
  @doc("Access URL.")
  accessUrl?: string;

  @visibility("read") // TODO: Remove from RP code then delete from spec
  @doc("Load balancer IP address.")
  ipAddress?: string;

  @visibility("read", "create", "update") // TODO: Determine how RP handles patch connectorSubnetId which is not yet implemented.
  @doc("Connector subnet ID.")
  connectorSubnetId?: string;
}

@doc("Enumeration for license activated")
union LicenseActivated {
  string,

  @doc("Activated")
  True: "True",

  @doc("Not activated")
  False: "False",
}

@doc("Enumeration for copy and paste permissions")
union CopyPasteSetting {
  string,

  @doc("Copy and paste enabled.")
  enabled: "enabled",

  @doc("Copy and paste disabled.")
  disabled: "disabled",
}

@doc("ETX configuration")
model Etx {
  @visibility("read")
  @doc("Connection node count")
  connectionNodeCount?: int32;

  @visibility("read")
  @doc("License activated")
  licenseActivated?: LicenseActivated;

  @visibility("read")
  @doc("URL of ETX Server for Azure AD app.")
  replyUrlEtx?: string;

  @visibility("read")
  @doc("URL of OTDS for Azure AD app.")
  replyUrlOtds?: string;

  @visibility("read", "create")
  @doc("License key URI.")
  licenseKeyUri?: string;
}

@doc("Remote desktop configuration")
model RemoteDesktop {
  @visibility("read", "create")
  @doc("ETX configuration")
  etx?: Etx;
}

@doc("Access configuration properties.")
model NetworkAcls {
  @visibility("read", "create", "update")
  @doc("Allowed address spaces")
  allowedAddressSpaces: Array<string>;
}

@doc("Property for copy and paste permission")
model CopyPasteParameters {
  @doc("Copy and paste permissions")
  copyPasteSetting: CopyPasteSetting;
}

@doc("License key parameters")
model LicenseKeyParameters {
  @doc("Key vault URI for license key")
  licenseKey: string;
}

@doc("Connector properties.")
model ConnectorProperties {
  ...ProvisioningStateProperty;
  ...PowerStateProperty;
  ...RestartAtProperty;

  @visibility("read", "create", "update")
  @doc("Connector access configuration")
  accessConfigurations: AccessConfiguration;

  @visibility("read", "create")
  @doc("Copy and paste permissions.")
  copyPasteSetting?: CopyPasteSetting = CopyPasteSetting.disabled;

  @visibility("read", "create")
  @doc("Remote desktop configuration.")
  remoteDesktop?: RemoteDesktop;

  @visibility("read", "create", "update")
  @doc("Access configuration properties.")
  networkAcls: NetworkAcls;
}

@doc("Connector tracked resource.")
@parentResource(Chamber)
model Connector is TrackedResource<ConnectorProperties> {
  @doc("The name of the Connector")
  @segment("connectors")
  @key("connectorName")
  @TypeSpec.Http.path
  @pattern("^(?!-)(?!.*--)[a-zA-Z][A-Za-z0-9-]{0,63}(?<!-)$")
  name: string;
}

@armResourceOperations
interface Connectors
  extends NestedResourceOperations<Connector, ConnectorProperties>,
    Restartable<Connector> {
  @doc("Add license key to connector")
  licenseAdd is ArmResourceActionAsync<Connector, LicenseKeyParameters, never>;

  @doc("Set copy and paste permissions")
  setCopyPaste is ArmResourceActionAsync<Connector, CopyPasteParameters, never>;
}
