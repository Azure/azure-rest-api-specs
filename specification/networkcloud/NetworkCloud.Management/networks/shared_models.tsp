namespace Microsoft.NetworkCloud;

/**
 * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
 */
union HybridAksPluginType {
  string,

  /**
   * The DPDK plugin type.
   */
  DPDK: "DPDK",

  /**
   * The SRIOV plugin type.
   */
  SRIOV: "SRIOV",

  /**
   * The OSDevice plugin type.
   */
  OSDevice: "OSDevice",
}
