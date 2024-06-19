import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;

/**
 * Network Interface Properties defines the properties of the resource.
 */
model NetworkInterfaceProperties {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

  /**
   * Physical Identifier of the network interface.
   */
  @visibility("read")
  physicalIdentifier?: string;

  /**
   * The ARM resource id of the interface or compute server its connected to.
   */
  @visibility("read")
  connectedTo?: string;

  /**
   * The Interface Type. Example: Management/Data
   */
  @visibility("read")
  interfaceType?: InterfaceType;

  /**
   * IPv4Address of the interface.
   */
  @visibility("read")
  ipv4Address?: string;

  /**
   * IPv6Address of the interface.
   */
  @visibility("read")
  ipv6Address?: string;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Administrative state of the resource.
   */
  @visibility("read")
  administrativeState?: AdministrativeState;
}

/**
 * The NetworkInterfacePatch resource definition.
 */
model NetworkInterfacePatch {
  /**
   * Network Interface Patch properties.
   */
  properties?: NetworkInterfacePatchProperties;
}

/**
 * Network Interface Patch properties.
 */
model NetworkInterfacePatchProperties is AnnotationResource;

/**
 * The Interface Type. Example: Management/Data
 */
union InterfaceType {
  @doc("InterfaceType-Management")
  Management: "Management",

  @doc("InterfaceType-Data")
  Data: "Data",

  string,
}
