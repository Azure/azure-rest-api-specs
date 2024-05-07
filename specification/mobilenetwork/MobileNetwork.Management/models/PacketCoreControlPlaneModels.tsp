import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

import "../common/CommonModels.tsp";

using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "For backward compatibility."
@removed(Versions.v2024_06_01)
@doc("The deployment type of the packet core software (Single Node / Multi Node).")
union DeploymentType {
  @doc("The packet core software will be deployed on single standalone server.")
  `Single Node`: "Single Node",

  @doc("The packet core software will be deployed on multiple servers and supports high availability.")
  `Multi Node`: "Multi Node",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "For backward compatibility."
@doc("The core network technology generation (5G core, EPC / 4G core or EPC / 4G + 5G core).")
union CoreNetworkType {
  @doc("5G core")
  `5GC`: "5GC",

  @doc("EPC / 4G core")
  EPC: "EPC",

  @doc("Combined EPC / 4G and 5G core")
  `EPC + 5GC`: "EPC + 5GC",
}

@doc("The SKU of the packet core control plane resource. The SKU list may change over time when a new SKU gets added or an exiting SKU gets removed.")
union BillingSku {
  @doc("100 Mbps, 20 active SIMs plan, 2 RANs")
  G0: "G0",

  @doc("1 Gbps, 100 active SIMs plan, 5 RANs")
  G1: "G1",

  @doc("2 Gbps, 200 active SIMs plan, 10 RANs")
  G2: "G2",

  @doc("5 Gbps, 500 active SIMs plan")
  G5: "G5",

  @doc("10 Gbps, 1000 active SIMs plan")
  G10: "G10",

  string,
}

@doc("The desired installation state of the packet core.")
union DesiredInstallationState {
  @doc("Don't install the packet core.")
  Uninstalled: "Uninstalled",

  @doc("Install the packet core.")
  Installed: "Installed",

  string,
}

@doc("The installation state of the packet core.")
union InstallationState {
  @doc("The packet core is uninstalled.")
  Uninstalled: "Uninstalled",

  @doc("The packet core is installing.")
  Installing: "Installing",

  @doc("The packet core is installed.")
  Installed: "Installed",

  @doc("The packet core is updating its configuration.")
  Updating: "Updating",

  @doc("The packet core is upgrading to a different software version.")
  Upgrading: "Upgrading",

  @doc("The packet core is uninstalling.")
  Uninstalling: "Uninstalling",

  @doc("The packet core is reinstalling.")
  Reinstalling: "Reinstalling",

  @doc("The packet core is rolling back to its previous version.")
  RollingBack: "RollingBack",

  @doc("The packet core is in failed state.")
  Failed: "Failed",

  string,
}

@doc("Whether a reinstall of the packet core is required to pick up the latest configuration changes.")
union ReinstallRequired {
  @doc("A reinstall of the packet core is required.")
  Required: "Required",

  @doc("A reinstall of the packet core is not required.")
  NotRequired: "NotRequired",

  string,
}

@doc("The reason or list of reasons why a packet core has not been installed or requires a reinstall.")
union InstallationReason {
  @doc("The packet core has not been installed as the mobile network does not have any applicable configured slices.")
  NoSlices: "NoSlices",

  @doc("The packet core has not been installed as there is no configured data plane for this packet core.")
  NoPacketCoreDataPlane: "NoPacketCoreDataPlane",

  @doc("The packet core has not been installed as the packet core has no attached data networks.")
  NoAttachedDataNetworks: "NoAttachedDataNetworks",

  @doc("A reinstall is required as the packet core is running with out-of-date PLMN ID.")
  PublicLandMobileNetworkIdentifierHasChanged: "PublicLandMobileNetworkIdentifierHasChanged",

  @doc("A reinstall is required as the packet core is running with out-of-date control plane access interface information.")
  ControlPlaneAccessInterfaceHasChanged: "ControlPlaneAccessInterfaceHasChanged",

  @doc("A reinstall is required as the packet core is running with out-of-date user plane core interface.")
  UserPlaneAccessInterfaceHasChanged: "UserPlaneAccessInterfaceHasChanged",

  @doc("A reinstall is required as the packet core is running with out-of-date user plane access interface.")
  UserPlaneDataInterfaceHasChanged: "UserPlaneDataInterfaceHasChanged",

  @doc("A reinstall is required as the packet core is running with out-of-date control plane access network virtual IP address.")
  ControlPlaneAccessVirtualIpv4AddressesHasChanged: "ControlPlaneAccessVirtualIpv4AddressesHasChanged",

  @doc("A reinstall is required as the packet core is running with out-of-date user plane access network virtual IP address.")
  UserPlaneAccessVirtualIpv4AddressesHasChanged: "UserPlaneAccessVirtualIpv4AddressesHasChanged",

  string,
}

@doc("How to authenticate users who access local diagnostics APIs.")
union AuthenticationType {
  @doc("Use AAD SSO to authenticate the user (this requires internet access).")
  AAD: "AAD",

  @doc("Use locally stored passwords to authenticate the user.")
  Password: "Password",

  string,
}

@doc("The certificate's provisioning state")
union CertificateProvisioningState {
  @doc("The certificate has not been provisioned.")
  NotProvisioned: "NotProvisioned",

  @doc("The certificate has been provisioned.")
  Provisioned: "Provisioned",

  @doc("The certificate failed to be provisioned. The \"reason\" property explains why.")
  Failed: "Failed",

  string,
}

@doc("The provisioning state of the private keys for SUPI concealment.")
union HomeNetworkPrivateKeysProvisioningState {
  @doc("Provisioning of the private keys for SUPI concealment has not been attempted.")
  NotProvisioned: "NotProvisioned",

  @doc("The private keys for SUPI concealment are successfully provisioned.")
  Provisioned: "Provisioned",

  @doc("Provisioning of the private keys for SUPI concealment has failed.")
  Failed: "Failed",

  string,
}

@doc("Packet core control plane properties.")
model PacketCoreControlPlanePropertiesFormat {
  @doc("The provisioning state of the packet core control plane resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The installation state of the packet core control plane resource.")
  installation?: Installation;

  @doc("Site(s) under which this packet core control plane should be deployed. The sites must be in the same location as the packet core control plane.")
  @minItems(1)
  sites: SiteResourceId[];

  @removed(Versions.v2024_06_01)
  @doc("The deployment type of the packet core software (Single Node / Multi Node). This is an optional property, valid only for the packet core deployments on Nexus.")
  deploymentType?: DeploymentType = DeploymentType.`Single Node`;

  @doc("The platform where the packet core is deployed.")
  platform: PlatformConfiguration;

  @doc("The core network technology generation (5G core or EPC / 4G core).")
  coreNetworkTechnology?: CoreNetworkType = CoreNetworkType.`5GC`;

  @doc("The desired version of the packet core software.")
  version?: string;

  @doc("The currently installed version of the packet core software.")
  @visibility("read")
  installedVersion?: string;

  @doc("The previous version of the packet core software that was deployed. Used when performing the rollback action.")
  @visibility("read")
  rollbackVersion?: string;

  @doc("The control plane interface on the access network. For 5G networks, this is the N2 interface. For 4G networks, this is the S1-MME interface.")
  controlPlaneAccessInterface: InterfaceProperties;

  @doc("The virtual IP address(es) for the control plane on the access network in a High Availability (HA) system. In an HA deployment the access network router should be configured to anycast traffic for this address to the control plane access interfaces on the active and standby nodes. In non-HA system this list should be omitted or empty.")
  controlPlaneAccessVirtualIpv4Addresses?: Ipv4Addr[];

  @doc("The SKU defining the throughput and SIM allowances for this packet core control plane deployment.")
  sku: BillingSku;

  @doc("The MTU (in bytes) signaled to the UE. The same MTU is set on the user plane data links for all data networks. The MTU set on the user plane access link is calculated to be 60 bytes greater than this value to allow for GTP encapsulation.")
  @maxValue(1930)
  @minValue(1280)
  ueMtu?: int32 = 1440;

  @doc("The kubernetes ingress configuration to control access to packet core diagnostics over local APIs.")
  localDiagnosticsAccess: LocalDiagnosticsAccessConfiguration;

  @doc("Configuration for uploading packet core diagnostics")
  diagnosticsUpload?: DiagnosticsUploadConfiguration;

  @doc("Configuration for sending packet core events to an Azure Event Hub.")
  eventHub?: EventHubConfiguration;

  @doc("Signaling configuration for the packet core.")
  signaling?: SignalingConfiguration;

  @doc("Settings to allow interoperability with third party components e.g. RANs and UEs.")
  interopSettings?: {};

  @doc("The provisioning state of the secret containing private keys and keyIds for SUPI concealment.")
  @visibility("read")
  homeNetworkPrivateKeysProvisioning?: HomeNetworkPrivateKeysProvisioning;

  @removed(Versions.v2024_06_01)
  @doc("Managed-On-Behalf-Of configuration for packet core to manage the kubernetes cluster resources on behalf of the resource owner for the deployment on Nexus. This is a read-only property, valid only for the packet core deployments on Nexus.")
  @visibility("read")
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  @added(Versions.v2024_06_01)
  @doc("The user consent configuration for the packet core.")
  userConsent?: UserConsentConfiguration;
}

@doc("The installation state of the packet core.")
model Installation {
  @doc("The desired installation state")
  desiredState?: DesiredInstallationState = DesiredInstallationState.Installed;

  @doc("Installation state")
  @visibility("read")
  state?: InstallationState;

  @doc("Whether a reinstall of the packet core is required to pick up the latest configuration changes.")
  @visibility("read")
  reinstallRequired?: ReinstallRequired;

  @doc("Reason(s) for the current installation state of the packet core.")
  @visibility("read")
  reasons?: InstallationReason[];

  @doc("A reference to an in-progress installation operation")
  @visibility("read")
  operation?: AsyncOperationId;
}

@doc("Reference to an Azure Async Operation ID.")
model AsyncOperationId {
  @doc("Azure Async Operation ID.")
  @pattern("^/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[^/?#]+/[lL][oO][cC][aA][tT][iI][oO][nN][sS]/[^/?#]+/[oO][pP][eE][rR][aA][tT][iI][oO][nN][sS][tT][aA][tT][uU][sS][eE][sS]/[^/?#]+$")
  id: string;
}

@doc("The platform where the packet core is deployed.")
model PlatformConfiguration {
  @doc("The platform type where packet core is deployed.")
  type: PlatformType;

  @doc("The Azure Stack Edge device where the packet core is deployed. If the device is part of a fault tolerant pair, either device in the pair can be specified.")
  azureStackEdgeDevice?: AzureStackEdgeDeviceResourceId;

  @doc("The Azure Stack Edge devices where the packet core is deployed. If the packet core is deployed across multiple devices, all devices will appear in this list.")
  @visibility("read")
  azureStackEdgeDevices?: AzureStackEdgeDeviceResourceId[];

  @doc("The Azure Stack HCI cluster where the packet core is deployed.")
  azureStackHciCluster?: AzureStackHCIClusterResourceId;

  @removed(Versions.v2024_06_01)
  @doc("The Nexus Edge Cluster where the packet core is deployed.")
  nexusEdgeCluster?: NexusEdgeClusterResourceId;

  @doc("Azure Arc connected cluster where the packet core is deployed.")
  connectedCluster?: ConnectedClusterResourceId;

  @doc("Azure Arc custom location where the packet core is deployed.")
  customLocation?: CustomLocationResourceId;

  @removed(Versions.v2024_06_01)
  @doc("The Nexus network configuration to deploy the Nexus Azure Kubernetes Service and the packet core.")
  nexusNetworkConfiguration?: NexusNetworkConfiguration;
}

@removed(Versions.v2024_06_01)
@doc("The Nexus network configuration to deploy the Nexus Azure Kubernetes Service and the packet core.")
model NexusNetworkConfiguration {
  @doc("The list of IP address ranges. Each range can be a either a subnet in CIDR format or an explicit start-end range of IP addresses.")
  loadBalancerIpAddresses?: string[];

  @doc("The Cloud Services Network that provides VMs/Kubernetes clusters access to cloud services such as DNS, NTP, and user-specified Azure PaaS services")
  cloudServicesNetwork?: NexusCloudServicesNetworkResourceId;

  @doc("The Layer 3 Network that is used for creation of the container networking interface network.")
  containerNetworkInterface?: NexusL3NetworkResourceId;
}

@doc("The kubernetes ingress configuration to control access to packet core diagnostics over local APIs.")
model LocalDiagnosticsAccessConfiguration {
  @doc("How to authenticate users who access local diagnostics APIs.")
  authenticationType: AuthenticationType;

  @doc("The HTTPS server TLS certificate used to secure local access to diagnostics.")
  httpsServerCertificate?: HttpsServerCertificate;
}

@doc("HTTPS server certificate configuration.")
model HttpsServerCertificate {
  @doc("The certificate URL, unversioned. For example: https://contosovault.vault.azure.net/certificates/ingress.")
  certificateUrl: string;

  @doc("The provisioning state of the certificate.")
  @visibility("read")
  provisioning?: CertificateProvisioning;
}

@doc("Certificate provisioning state")
model CertificateProvisioning {
  @doc("The certificate's provisioning state")
  @visibility("read")
  state?: CertificateProvisioningState;

  @doc("Reason for certificate provisioning failure.")
  @visibility("read")
  reason?: string;
}

@doc("Configuration for uploading packet core diagnostics.")
model DiagnosticsUploadConfiguration {
  @doc("The Storage Account Container URL to upload diagnostics to.")
  storageAccountContainerUrl: string;
}

@doc("Configuration for sending packet core events to Azure Event Hub.")
model EventHubConfiguration {
  @doc("Resource ID  of Azure Event Hub to send packet core events to.")
  @pattern("^/[sS][uU][bB][sS][cC][rR][iI][pP][tT][iI][oO][nN][sS]/[^/?#]+/[rR][eE][sS][oO][uU][rR][cC][eE][gG][rR][oO][uU][pP][sS]/[^/?#]+/[pP][rR][oO][vV][iI][dD][eE][rR][sS]/[mM][iI][cC][rR][oO][sS][oO][fF][tT]\\.[eE][vV][eE][nN][tT][hH][uU][bB]/[nN][aA][mM][eE][sS][pP][aA][cC][eE][sS]/[^/?#]+/[eV][vV][eE][nN][tT][hH][uU][bB][sS]/[^/?#]+$")
  id: string;

  @doc("The duration (in seconds) between UE usage reports.")
  @maxValue(3600)
  @minValue(30)
  reportingInterval?: int32 = 1800;
}

@doc("Signaling configuration for the packet core.")
model SignalingConfiguration {
  @doc("Configuration enabling 4G NAS reroute.")
  nasReroute?: NASRerouteConfiguration;

  @added(Versions.v2024_06_01)
  @doc("An ordered list of NAS encryption algorithms, used to encrypt control plane traffic between the UE and packet core, in order from most to least preferred. If not specified, the packet core will use a built-in default ordering.")
  @minItems(1)
  @maxItems(3)
  nasEncryption?: NASEncryptionType[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility."
@doc("Configuration enabling NAS reroute.")
model NASRerouteConfiguration {
  @doc("The macro network's MME group ID. This is where unknown UEs are sent to via NAS reroute.")
  @maxValue(65535)
  macroMmeGroupId: int32;
}

@doc("Home network private keys provisioning state.")
model HomeNetworkPrivateKeysProvisioning {
  @doc("The provisioning state of the private keys for SUPI concealment.")
  @visibility("read")
  state: HomeNetworkPrivateKeysProvisioningState;
}

@doc("Packet core control plane collect diagnostics package options")
model PacketCoreControlPlaneCollectDiagnosticsPackage {
  @doc("The Storage Account Blob URL to upload the diagnostics package to.")
  storageAccountBlobUrl: string;
}

@doc("The user consent configuration for the packet core")
model UserConsentConfiguration {
  @doc("Allow Microsoft to access non-PII telemetry information from the packet core.")
  allowSupportTelemetryAccess?: boolean;
}
