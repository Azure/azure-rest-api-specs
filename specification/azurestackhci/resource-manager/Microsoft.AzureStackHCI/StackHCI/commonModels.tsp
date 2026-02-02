import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

/**
 * Represents the Confidential Virtual Machine (CVM) support intent and current status for the cluster resource.
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
model ConfidentialVmProperties {
  /**
   * Captures the customer's intent to enable or disable CVM support on the cluster, either during initial deployment (Day-0) or at a later stage (Day-N).
   */
  @visibility(Lifecycle.Read)
  confidentialVmIntent?: ConfidentialVmIntent = ConfidentialVmIntent.Disable;

  /**
   * Captures the current status of CVM support on the cluster.
   */
  @visibility(Lifecycle.Read)
  confidentialVmStatus?: ConfidentialVmStatus = ConfidentialVmStatus.Disabled;

  /**
   * Additional context about CVM support on the cluster, such as reasons for partial enablement or hardware constraints.
   */
  @visibility(Lifecycle.Read)
  confidentialVmStatusSummary?: string;
}

/**
 * Captures the customer's intent to enable or disable Confidential Virtual Machine (CVM) support on the cluster, either during initial deployment (Day-0) or at a later stage (Day-N).
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
union ConfidentialVmIntent {
  string,

  /**
   * Indicates that the customer intends to enable CVM support on the cluster.
   */
  Enable: "Enable",

  /**
   * Indicates that the customer intends to disable CVM support on the cluster.
   */
  Disable: "Disable",
}

/**
 * Captures the current status of Confidential Virtual Machine (CVM) support on the cluster.
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
union ConfidentialVmStatus {
  string,

  /**
   * CVM support is fully enabled on the cluster. All nodes are CVM capable.
   */
  Enabled: "Enabled",

  /**
   * CVM support is partially enabled. At least one node in the cluster is CVM capable.
   */
  PartiallyEnabled: "PartiallyEnabled",

  /**
   * CVM support is disabled. None of the nodes in the cluster are CVM capable.
   */
  Disabled: "Disabled",
}

/**
 * Represents the Confidential Virtual Machine (CVM) configuration status for an edge device. It includes the current IGVM support state and detailed component-level status information.
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
model ConfidentialVmProfile {
  /**
   * Indicates whether Independent Guest Virtual Machine (IGVM) support is available on the device. This will be 'Enabled' if the device supports CVMs, 'Disabled' if not, and 'Unknown' if the status cannot be determined.
   */
  @visibility(Lifecycle.Read)
  igvmStatus?: IgvmStatus;

  /**
   * Provides detailed status entries for IGVM-related components, including deployment status, compatibility checks, and error diagnostics.
   */
  @Azure.ResourceManager.identifiers(#["code"])
  statusDetails?: IgvmStatusDetail[];
}

/**
 * Provides component-level status information related to IGVM enablement on the device.
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
model IgvmStatusDetail {
  /**
   * A machine-readable status code indicating the result or condition of a specific IGVM-related check or operation.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * A human-readable message providing context or explanation for the associated status code.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Represents the IGVM support status for the device.
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
union IgvmStatus {
  string,

  /**
   * The IGVM status could not be determined due to a query failure or inconsistent system state.
   */
  Unknown: "Unknown",

  /**
   * IGVM support is enabled, indicating that confidential VM features are available on this device.
   */
  Enabled: "Enabled",

  /**
   * IGVM status is disabled, indicating that confidential VM features are not supported on this device.
   */
  Disabled: "Disabled",
}

/**
 * Represents the Software Defined Networking (SDN) configuration state of the Azure Stack HCI cluster.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
model ClusterSdnProperties extends SdnProperties {
  /**
   * Indicates whether Software Defined Networking (SDN) integration should be enabled or disabled for this deployment.
   */
  @visibility(Lifecycle.Read)
  sdnIntegrationIntent?: SdnIntegrationIntent;
}

/**
 * Indicates whether Software Defined Networking (SDN) integration should be enabled or disabled for this deployment.
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
union SdnIntegrationIntent {
  string,

  /**
   * Enable SDN integration for the deployment.
   */
  Enable: "Enable",

  /**
   * Disable SDN integration for the deployment.
   */
  Disable: "Disable",
}

/**
 * Represents the Software Defined Networking (SDN) configuration state.
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
model SdnProperties {
  /**
   * Indicates the current Software Defined Networking (SDN) status of the resource, which may be an individual device or a cluster.
   */
  @visibility(Lifecycle.Read)
  sdnStatus?: SdnStatus;

  /**
   * The fully qualified domain name (FQDN) associated with the SDN deployment. This value is propagated from the Device Management Extension to the cluster resource. It is typically in the format `<sdnPrefix>-nc.<domain>` when SDN is enabled. May be null or absent in unsupported or disabled states.
   */
  @visibility(Lifecycle.Read)
  sdnDomainName?: string;

  /**
   * Represents the API address for the SDN deployment.
   */
  @visibility(Lifecycle.Read)
  sdnApiAddress?: string;
}

/**
 * Indicates the current Software Defined Networking (SDN) status of the resource, which may be an individual device or a cluster.
 */
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
union SdnStatus {
  string,

  /**
   * The SDN status could not be determined due to a failure in querying the SDN API service. This may occur if the query script fails or if the system is in an inconsistent state. The domain name will be null in this case.
   */
  Unknown: "Unknown",

  /**
   * SDN is not enabled on the resource. The domain name will be null. This is the default state when SDN has not been configured.
   */
  Disabled: "Disabled",

  /**
   * SDN is successfully enabled on the resource. The domain name will be populated in the format `<sdnPrefix>-nc.<domain>`. Customers may need to manage DNS settings to ensure proper resolution.
   */
  Enabled: "Enabled",
}
