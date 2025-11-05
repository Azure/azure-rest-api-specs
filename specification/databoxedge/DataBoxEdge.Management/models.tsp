import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataBoxEdge;

/**
 * Metric units.
 */
union MetricUnit {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Percent
   */
  Percent: "Percent",

  /**
   * Count
   */
  Count: "Count",

  /**
   * Seconds
   */
  Seconds: "Seconds",

  /**
   * Milliseconds
   */
  Milliseconds: "Milliseconds",

  /**
   * Bytes
   */
  Bytes: "Bytes",

  /**
   * BytesPerSecond
   */
  BytesPerSecond: "BytesPerSecond",

  /**
   * CountPerSecond
   */
  CountPerSecond: "CountPerSecond",
}

/**
 * Metric aggregation type.
 */
union MetricAggregationType {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * None
   */
  None: "None",

  /**
   * Average
   */
  Average: "Average",

  /**
   * Minimum
   */
  Minimum: "Minimum",

  /**
   * Maximum
   */
  Maximum: "Maximum",

  /**
   * Total
   */
  Total: "Total",

  /**
   * Count
   */
  Count: "Count",
}

/**
 * Metric category.
 */
union MetricCategory {
  string,

  /**
   * Capacity
   */
  Capacity: "Capacity",

  /**
   * Transaction
   */
  Transaction: "Transaction",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union TimeGrain {
  string,

  /**
   * PT1M
   */
  PT1M: "PT1M",

  /**
   * PT5M
   */
  PT5M: "PT5M",

  /**
   * PT15M
   */
  PT15M: "PT15M",

  /**
   * PT30M
   */
  PT30M: "PT30M",

  /**
   * PT1H
   */
  PT1H: "PT1H",

  /**
   * PT6H
   */
  PT6H: "PT6H",

  /**
   * PT12H
   */
  PT12H: "PT12H",

  /**
   * PT1D
   */
  PT1D: "PT1D",
}

/**
 * The Sku name.
 */
union SkuName {
  string,

  /**
   * Gateway
   */
  Gateway: "Gateway",

  /**
   * Edge
   */
  Edge: "Edge",

  /**
   * TEA_1Node
   */
  TEA_1Node: "TEA_1Node",

  /**
   * TEA_1Node_UPS
   */
  TEA_1Node_UPS: "TEA_1Node_UPS",

  /**
   * TEA_1Node_Heater
   */
  TEA_1Node_Heater: "TEA_1Node_Heater",

  /**
   * TEA_1Node_UPS_Heater
   */
  TEA_1Node_UPS_Heater: "TEA_1Node_UPS_Heater",

  /**
   * TEA_4Node_Heater
   */
  TEA_4Node_Heater: "TEA_4Node_Heater",

  /**
   * TEA_4Node_UPS_Heater
   */
  TEA_4Node_UPS_Heater: "TEA_4Node_UPS_Heater",

  /**
   * TMA
   */
  TMA: "TMA",

  /**
   * TDC
   */
  TDC: "TDC",

  /**
   * TCA_Small
   */
  TCA_Small: "TCA_Small",

  /**
   * GPU
   */
  GPU: "GPU",

  /**
   * TCA_Large
   */
  TCA_Large: "TCA_Large",

  /**
   * EdgeP_Base
   */
  EdgeP_Base: "EdgeP_Base",

  /**
   * EdgeP_High
   */
  EdgeP_High: "EdgeP_High",

  /**
   * EdgePR_Base
   */
  EdgePR_Base: "EdgePR_Base",

  /**
   * EdgePR_Base_UPS
   */
  EdgePR_Base_UPS: "EdgePR_Base_UPS",

  /**
   * EP2_64_1VPU_W
   */
  EP2_64_1VPU_W: "EP2_64_1VPU_W",

  /**
   * EP2_128_1T4_Mx1_W
   */
  EP2_128_1T4_Mx1_W: "EP2_128_1T4_Mx1_W",

  /**
   * EP2_256_2T4_W
   */
  EP2_256_2T4_W: "EP2_256_2T4_W",

  /**
   * EdgeMR_Mini
   */
  EdgeMR_Mini: "EdgeMR_Mini",

  /**
   * RCA_Small
   */
  RCA_Small: "RCA_Small",

  /**
   * RCA_Large
   */
  RCA_Large: "RCA_Large",

  /**
   * RDC
   */
  RDC: "RDC",

  /**
   * Management
   */
  Management: "Management",

  /**
   * EP2_64_Mx1_W
   */
  EP2_64_Mx1_W: "EP2_64_Mx1_W",

  /**
   * EP2_128_GPU1_Mx1_W
   */
  EP2_128_GPU1_Mx1_W: "EP2_128_GPU1_Mx1_W",

  /**
   * EP2_256_GPU2_Mx1
   */
  EP2_256_GPU2_Mx1: "EP2_256_GPU2_Mx1",

  /**
   * EdgeMR_TCP
   */
  EdgeMR_TCP: "EdgeMR_TCP",
}

/**
 * The Sku tier.
 */
union SkuTier {
  string,

  /**
   * Standard
   */
  Standard: "Standard",
}

/**
 * Sku can be signed up by customer or not.
 */
union SkuSignupOption {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Available
   */
  Available: "Available",
}

/**
 * Availability of the Sku as preview/stable.
 */
union SkuVersion {
  string,

  /**
   * Stable
   */
  Stable: "Stable",

  /**
   * Preview
   */
  Preview: "Preview",
}

/**
 * Links to the next set of results
 */
union SkuAvailability {
  string,

  /**
   * Available
   */
  Available: "Available",

  /**
   * Unavailable
   */
  Unavailable: "Unavailable",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ShipmentType {
  string,

  /**
   * NotApplicable
   */
  NotApplicable: "NotApplicable",

  /**
   * ShippedToCustomer
   */
  ShippedToCustomer: "ShippedToCustomer",

  /**
   * SelfPickup
   */
  SelfPickup: "SelfPickup",
}

/**
 * Identity type
 */
union MsiIdentityType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",
}

/**
 * The kind of the device.
 */
union DataBoxEdgeDeviceKind {
  string,

  /**
   * AzureDataBoxGateway
   */
  AzureDataBoxGateway: "AzureDataBoxGateway",

  /**
   * AzureStackEdge
   */
  AzureStackEdge: "AzureStackEdge",

  /**
   * AzureStackHub
   */
  AzureStackHub: "AzureStackHub",

  /**
   * AzureModularDataCentre
   */
  AzureModularDataCentre: "AzureModularDataCentre",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * The status of the Data Box Edge/Gateway device.
 */
union DataBoxEdgeDeviceStatus {
  string,

  /**
   * ReadyToSetup
   */
  ReadyToSetup: "ReadyToSetup",

  /**
   * Online
   */
  Online: "Online",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * NeedsAttention
   */
  NeedsAttention: "NeedsAttention",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",

  /**
   * PartiallyDisconnected
   */
  PartiallyDisconnected: "PartiallyDisconnected",

  /**
   * Maintenance
   */
  Maintenance: "Maintenance",
}

/**
 * The type of the Data Box Edge/Gateway device.
 */
union DeviceType {
  string,

  /**
   * DataBoxEdgeDevice
   */
  DataBoxEdgeDevice: "DataBoxEdgeDevice",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union RoleTypes {
  string,

  /**
   * IOT
   */
  IOT: "IOT",

  /**
   * ASA
   */
  ASA: "ASA",

  /**
   * Functions
   */
  Functions: "Functions",

  /**
   * Cognitive
   */
  Cognitive: "Cognitive",

  /**
   * MEC
   */
  MEC: "MEC",

  /**
   * CloudEdgeManagement
   */
  CloudEdgeManagement: "CloudEdgeManagement",

  /**
   * Kubernetes
   */
  Kubernetes: "Kubernetes",
}

/**
 * Denotes whether move operation is in progress
 */
union ResourceMoveStatus {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * ResourceMoveInProgress
   */
  ResourceMoveInProgress: "ResourceMoveInProgress",

  /**
   * ResourceMoveFailed
   */
  ResourceMoveFailed: "ResourceMoveFailed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union SubscriptionState {
  string,

  /**
   * Registered
   */
  Registered: "Registered",

  /**
   * Warned
   */
  Warned: "Warned",

  /**
   * Suspended
   */
  Suspended: "Suspended",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * Unregistered
   */
  Unregistered: "Unregistered",
}

/**
 * DataResidencyType enum
 */
union DataResidencyType {
  string,

  /**
   * GeoZoneReplication
   */
  GeoZoneReplication: "GeoZoneReplication",

  /**
   * ZoneReplication
   */
  ZoneReplication: "ZoneReplication",
}

/**
 * Severity of the alert.
 */
union AlertSeverity {
  string,

  /**
   * Informational
   */
  Informational: "Informational",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Critical
   */
  Critical: "Critical",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union DayOfWeek {
  string,

  /**
   * Sunday
   */
  Sunday: "Sunday",

  /**
   * Monday
   */
  Monday: "Monday",

  /**
   * Tuesday
   */
  Tuesday: "Tuesday",

  /**
   * Wednesday
   */
  Wednesday: "Wednesday",

  /**
   * Thursday
   */
  Thursday: "Thursday",

  /**
   * Friday
   */
  Friday: "Friday",

  /**
   * Saturday
   */
  Saturday: "Saturday",
}

/**
 * Proactive diagnostic collection consent flag
 */
union ProactiveDiagnosticsConsent {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Remote application type
 */
union RemoteApplicationType {
  string,

  /**
   * Powershell
   */
  Powershell: "Powershell",

  /**
   * WAC
   */
  WAC: "WAC",

  /**
   * LocalUI
   */
  LocalUI: "LocalUI",

  /**
   * AllApplications
   */
  AllApplications: "AllApplications",
}

/**
 * Access level allowed for this remote application type
 */
union AccessLevel {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * ReadOnly
   */
  ReadOnly: "ReadOnly",

  /**
   * ReadWrite
   */
  ReadWrite: "ReadWrite",

  /**
   * FullAccess
   */
  FullAccess: "FullAccess",
}

/**
 * For changing or to initiate the resync to key-vault set the status to KeyVaultSyncPending, rest of the status will not be applicable.
 */
union KeyVaultSyncStatus {
  string,

  /**
   * KeyVaultSynced
   */
  KeyVaultSynced: "KeyVaultSynced",

  /**
   * KeyVaultSyncFailed
   */
  KeyVaultSyncFailed: "KeyVaultSyncFailed",

  /**
   * KeyVaultNotConfigured
   */
  KeyVaultNotConfigured: "KeyVaultNotConfigured",

  /**
   * KeyVaultSyncPending
   */
  KeyVaultSyncPending: "KeyVaultSyncPending",

  /**
   * KeyVaultSyncing
   */
  KeyVaultSyncing: "KeyVaultSyncing",

  /**
   * KeyVaultNotSynced
   */
  KeyVaultNotSynced: "KeyVaultNotSynced",
}

/**
 * The algorithm used to encrypt "Value".
 */
union EncryptionAlgorithm {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * AES256
   */
  AES256: "AES256",

  /**
   * RSAES_PKCS1_v_1_5
   */
  RSAES_PKCS1_v_1_5: "RSAES_PKCS1_v_1_5",
}

/**
 * Cluster Witness Type
 */
union ClusterWitnessType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Cloud
   */
  Cloud: "Cloud",

  /**
   * FileShare
   */
  FileShare: "FileShare",
}

/**
 * The current status of the job.
 */
union JobStatus {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Paused
   */
  Paused: "Paused",

  /**
   * Scheduled
   */
  Scheduled: "Scheduled",
}

/**
 * The type of the job.
 */
union JobType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * ScanForUpdates
   */
  ScanForUpdates: "ScanForUpdates",

  /**
   * DownloadUpdates
   */
  DownloadUpdates: "DownloadUpdates",

  /**
   * InstallUpdates
   */
  InstallUpdates: "InstallUpdates",

  /**
   * RefreshShare
   */
  RefreshShare: "RefreshShare",

  /**
   * RefreshContainer
   */
  RefreshContainer: "RefreshContainer",

  /**
   * Backup
   */
  Backup: "Backup",

  /**
   * Restore
   */
  Restore: "Restore",

  /**
   * TriggerSupportPackage
   */
  TriggerSupportPackage: "TriggerSupportPackage",
}

/**
 * Current stage of the update operation.
 */
union UpdateOperationStage {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Initial
   */
  Initial: "Initial",

  /**
   * ScanStarted
   */
  ScanStarted: "ScanStarted",

  /**
   * ScanComplete
   */
  ScanComplete: "ScanComplete",

  /**
   * ScanFailed
   */
  ScanFailed: "ScanFailed",

  /**
   * DownloadStarted
   */
  DownloadStarted: "DownloadStarted",

  /**
   * DownloadComplete
   */
  DownloadComplete: "DownloadComplete",

  /**
   * DownloadFailed
   */
  DownloadFailed: "DownloadFailed",

  /**
   * InstallStarted
   */
  InstallStarted: "InstallStarted",

  /**
   * InstallComplete
   */
  InstallComplete: "InstallComplete",

  /**
   * InstallFailed
   */
  InstallFailed: "InstallFailed",

  /**
   * RebootInitiated
   */
  RebootInitiated: "RebootInitiated",

  /**
   * Success
   */
  Success: "Success",

  /**
   * Failure
   */
  Failure: "Failure",

  /**
   * RescanStarted
   */
  RescanStarted: "RescanStarted",

  /**
   * RescanComplete
   */
  RescanComplete: "RescanComplete",

  /**
   * RescanFailed
   */
  RescanFailed: "RescanFailed",
}

/**
 * The download phase.
 */
union DownloadPhase {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Initializing
   */
  Initializing: "Initializing",

  /**
   * Downloading
   */
  Downloading: "Downloading",

  /**
   * Verifying
   */
  Verifying: "Verifying",
}

/**
 * The network group.
 */
union NetworkGroup {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * NonRDMA
   */
  NonRDMA: "NonRDMA",

  /**
   * RDMA
   */
  RDMA: "RDMA",
}

/**
 * Value indicating whether this adapter is valid.
 */
union NetworkAdapterStatus {
  string,

  /**
   * Inactive
   */
  Inactive: "Inactive",

  /**
   * Active
   */
  Active: "Active",
}

/**
 * Value indicating whether this adapter is RDMA capable.
 */
union NetworkAdapterRdmaStatus {
  string,

  /**
   * Incapable
   */
  Incapable: "Incapable",

  /**
   * Capable
   */
  Capable: "Capable",
}

/**
 * Value indicating whether this adapter has DHCP enabled.
 */
union NetworkAdapterDhcpStatus {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The current status of the individual node
 */
union NodeStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Up
   */
  Up: "Up",

  /**
   * Down
   */
  Down: "Down",

  /**
   * Rebooting
   */
  Rebooting: "Rebooting",

  /**
   * ShuttingDown
   */
  ShuttingDown: "ShuttingDown",
}

/**
 * Status of the order as per the allowed status types.
 */
union OrderState {
  string,

  /**
   * Untracked
   */
  Untracked: "Untracked",

  /**
   * AwaitingFulfillment
   */
  AwaitingFulfillment: "AwaitingFulfillment",

  /**
   * AwaitingPreparation
   */
  AwaitingPreparation: "AwaitingPreparation",

  /**
   * AwaitingShipment
   */
  AwaitingShipment: "AwaitingShipment",

  /**
   * Shipped
   */
  Shipped: "Shipped",

  /**
   * Arriving
   */
  Arriving: "Arriving",

  /**
   * Delivered
   */
  Delivered: "Delivered",

  /**
   * ReplacementRequested
   */
  ReplacementRequested: "ReplacementRequested",

  /**
   * LostDevice
   */
  LostDevice: "LostDevice",

  /**
   * Declined
   */
  Declined: "Declined",

  /**
   * ReturnInitiated
   */
  ReturnInitiated: "ReturnInitiated",

  /**
   * AwaitingReturnShipment
   */
  AwaitingReturnShipment: "AwaitingReturnShipment",

  /**
   * ShippedBack
   */
  ShippedBack: "ShippedBack",

  /**
   * CollectedAtMicrosoft
   */
  CollectedAtMicrosoft: "CollectedAtMicrosoft",

  /**
   * AwaitingPickup
   */
  AwaitingPickup: "AwaitingPickup",

  /**
   * PickupCompleted
   */
  PickupCompleted: "PickupCompleted",

  /**
   * AwaitingDrop
   */
  AwaitingDrop: "AwaitingDrop",
}

/**
 * Addon type.
 */
union AddonType {
  string,

  /**
   * IotEdge
   */
  IotEdge: "IotEdge",

  /**
   * ArcForKubernetes
   */
  ArcForKubernetes: "ArcForKubernetes",
}

/**
 * Current status of the share.
 */
union ShareStatus {
  string,

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * OK
   */
  OK: "OK",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * NeedsAttention
   */
  NeedsAttention: "NeedsAttention",
}

/**
 * Current monitoring status of the share.
 */
union MonitoringStatus {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Storage format used for the file represented by the share.
 */
union AzureContainerDataFormat {
  string,

  /**
   * BlockBlob
   */
  BlockBlob: "BlockBlob",

  /**
   * PageBlob
   */
  PageBlob: "PageBlob",

  /**
   * AzureFile
   */
  AzureFile: "AzureFile",
}

/**
 * Access protocol to be used by the share.
 */
union ShareAccessProtocol {
  string,

  /**
   * SMB
   */
  SMB: "SMB",

  /**
   * NFS
   */
  NFS: "NFS",
}

/**
 * Type of access to be allowed on the share for this user.
 */
union ShareAccessType {
  string,

  /**
   * Change
   */
  Change: "Change",

  /**
   * Read
   */
  Read: "Read",

  /**
   * Custom
   */
  Custom: "Custom",
}

/**
 * Type of access to be allowed for the client.
 */
union ClientPermissionType {
  string,

  /**
   * NoAccess
   */
  NoAccess: "NoAccess",

  /**
   * ReadOnly
   */
  ReadOnly: "ReadOnly",

  /**
   * ReadWrite
   */
  ReadWrite: "ReadWrite",
}

/**
 * Mounting type.
 */
union MountType {
  string,

  /**
   * Volume
   */
  Volume: "Volume",

  /**
   * HostPath
   */
  HostPath: "HostPath",
}

/**
 * Data policy of the share.
 */
union DataPolicy {
  string,

  /**
   * Cloud
   */
  Cloud: "Cloud",

  /**
   * Local
   */
  Local: "Local",
}

/**
 * Signifies whether SSL needs to be enabled or not.
 */
union SSLStatus {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Type of storage accessed on the storage account.
 */
union AccountType {
  string,

  /**
   * GeneralPurposeStorage
   */
  GeneralPurposeStorage: "GeneralPurposeStorage",

  /**
   * BlobStorage
   */
  BlobStorage: "BlobStorage",
}

/**
 * Current status of the storage account
 */
union StorageAccountStatus {
  string,

  /**
   * OK
   */
  OK: "OK",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * NeedsAttention
   */
  NeedsAttention: "NeedsAttention",
}

/**
 * Current status of the container.
 */
union ContainerStatus {
  string,

  /**
   * OK
   */
  OK: "OK",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * NeedsAttention
   */
  NeedsAttention: "NeedsAttention",
}

/**
 * Trigger Kind.
 */
union TriggerEventType {
  string,

  /**
   * FileEvent
   */
  FileEvent: "FileEvent",

  /**
   * PeriodicTimerEvent
   */
  PeriodicTimerEvent: "PeriodicTimerEvent",
}

/**
 * Indicates if updates are available and at least one of the updates needs a reboot.
 */
union InstallRebootBehavior {
  string,

  /**
   * NeverReboots
   */
  NeverReboots: "NeverReboots",

  /**
   * RequiresReboot
   */
  RequiresReboot: "RequiresReboot",

  /**
   * RequestReboot
   */
  RequestReboot: "RequestReboot",
}

/**
 * The current update operation.
 */
union UpdateOperation {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Scan
   */
  Scan: "Scan",

  /**
   * Download
   */
  Download: "Download",

  /**
   * Install
   */
  Install: "Install",
}

/**
 * Type of the Update
 */
union UpdateType {
  string,

  /**
   * Software
   */
  Software: "Software",

  /**
   * Kubernetes
   */
  Kubernetes: "Kubernetes",

  /**
   * Firmware
   */
  Firmware: "Firmware",
}

/**
 * Impact of Installing an updateType
 */
union InstallationImpact {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * DeviceRebooted
   */
  DeviceRebooted: "DeviceRebooted",

  /**
   * KubernetesWorkloadsDown
   */
  KubernetesWorkloadsDown: "KubernetesWorkloadsDown",
}

/**
 * Status of the update.
 */
union UpdateStatus {
  string,

  /**
   * DownloadPending
   */
  DownloadPending: "DownloadPending",

  /**
   * DownloadStarted
   */
  DownloadStarted: "DownloadStarted",

  /**
   * DownloadCompleted
   */
  DownloadCompleted: "DownloadCompleted",

  /**
   * InstallStarted
   */
  InstallStarted: "InstallStarted",

  /**
   * InstallCompleted
   */
  InstallCompleted: "InstallCompleted",
}

/**
 * The authentication type.
 */
union AuthenticationType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * AzureActiveDirectory
   */
  AzureActiveDirectory: "AzureActiveDirectory",
}

/**
 * Type of the user.
 */
union UserType {
  string,

  /**
   * Share
   */
  Share: "Share",

  /**
   * LocalManagement
   */
  LocalManagement: "LocalManagement",

  /**
   * ARM
   */
  ARM: "ARM",
}

/**
 * Host OS supported by the Arc addon.
 */
union PlatformType {
  string,

  /**
   * Windows
   */
  Windows: "Windows",

  /**
   * Linux
   */
  Linux: "Linux",
}

/**
 * Platform where the runtime is hosted.
 */
union HostPlatformType {
  string,

  /**
   * KubernetesCluster
   */
  KubernetesCluster: "KubernetesCluster",

  /**
   * LinuxVM
   */
  LinuxVM: "LinuxVM",
}

/**
 * Addon Provisioning State
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union AddonState {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Created
   */
  Created: "Created",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Reconfiguring
   */
  Reconfiguring: "Reconfiguring",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * Local Edge Management Status
 */
union RoleStatus {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Node type - Master/Worker
 */
union KubernetesNodeType {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Master
   */
  Master: "Master",

  /**
   * Worker
   */
  Worker: "Worker",
}

/**
 * State of Kubernetes deployment
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union KubernetesState {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Created
   */
  Created: "Created",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Reconfiguring
   */
  Reconfiguring: "Reconfiguring",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * If provisioned storage is posix compliant.
 */
union PosixComplianceStatus {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Operations.
 */
model Operation {
  /**
   * Name of the operation.
   */
  name?: string;

  /**
   * Is data action.
   */
  isDataAction?: boolean;

  /**
   * Properties displayed for the operation.
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation.
   */
  origin?: string;

  /**
   * Operation properties.
   */
  properties?: OperationProperties;
}

/**
 * Operation display properties.
 */
model OperationDisplay {
  /**
   * Provider name.
   */
  provider?: string;

  /**
   * The type of resource in which the operation is performed.
   */
  resource?: string;

  /**
   * Operation to be performed on the resource.
   */
  operation?: string;

  /**
   * Description of the operation to be performed.
   */
  description?: string;
}

/**
 * Operation properties.
 */
model OperationProperties {
  /**
   * Service specification.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Service specification.
 */
model ServiceSpecification {
  /**
   * Metric specification as defined by shoebox.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  metricSpecifications?: MetricSpecificationV1[];
}

/**
 * Metric specification version 1.
 */
model MetricSpecificationV1 {
  /**
   * Name of the metric.
   */
  name?: string;

  /**
   * Display name of the metric.
   */
  displayName?: string;

  /**
   * Description of the metric to be displayed.
   */
  displayDescription?: string;

  /**
   * Metric units.
   */
  unit?: MetricUnit;

  /**
   * Metric aggregation type.
   */
  aggregationType?: MetricAggregationType;

  /**
   * Metric dimensions, other than default dimension which is resource.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  dimensions?: MetricDimensionV1[];

  /**
   * Set true to fill the gaps with zero.
   */
  fillGapWithZero?: boolean;

  /**
   * Metric category.
   */
  category?: MetricCategory;

  /**
   * Resource name override.
   */
  resourceIdDimensionNameOverride?: string;

  /**
   * Support granularity of metrics.
   */
  supportedTimeGrainTypes?: TimeGrain[];

  /**
   * Support metric aggregation type.
   */
  supportedAggregationTypes?: MetricAggregationType[];
}

/**
 * Metric Dimension v1.
 */
model MetricDimensionV1 {
  /**
   * Name of the metrics dimension.
   */
  name?: string;

  /**
   * Display name of the metrics dimension.
   */
  displayName?: string;

  /**
   * To be exported to shoe box.
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * An error response from the service.
 */
@error
model CloudError {
  /**
   * The error details.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the service.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * A list of additional details about the error.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  details?: CloudErrorBody[];
}

/**
 * List of SKU Information objects.
 */
model DataBoxEdgeSkuList is Azure.Core.Page<DataBoxEdgeSku>;

/**
 * The Sku information.
 */
model DataBoxEdgeSku {
  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The Sku name.
   */
  @visibility(Lifecycle.Read)
  name?: SkuName;

  /**
   * The Sku kind.
   */
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * The Sku tier.
   */
  @visibility(Lifecycle.Read)
  tier?: SkuTier;

  /**
   * The Sku kind.
   */
  @visibility(Lifecycle.Read)
  size?: string;

  /**
   * The Sku family.
   */
  @visibility(Lifecycle.Read)
  family?: string;

  /**
   * Availability of the Sku for the region.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  locations?: string[];

  /**
   * The API versions in which Sku is available.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  apiVersions?: string[];

  /**
   * Availability of the Sku for the location/zone/site.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["location"])
  locationInfo?: SkuLocationInfo[];

  /**
   * The pricing info of the Sku.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["meterId"])
  costs?: SkuCost[];

  /**
   * Sku can be signed up by customer or not.
   */
  @visibility(Lifecycle.Read)
  signupOption?: SkuSignupOption;

  /**
   * Availability of the Sku as preview/stable.
   */
  @visibility(Lifecycle.Read)
  version?: SkuVersion;

  /**
   * Links to the next set of results
   */
  @visibility(Lifecycle.Read)
  availability?: SkuAvailability;

  /**
   * List of Shipment Types supported by this SKU
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  shipmentTypes?: ShipmentType[];

  /**
   * The capability info of the SKU.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  capabilities?: SkuCapability[];
}

/**
 * The location info.
 */
model SkuLocationInfo {
  /**
   * The location.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The zones.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  zones?: string[];

  /**
   * The sites.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  sites?: string[];
}

/**
 * The metadata for retrieving price info.
 */
model SkuCost {
  /**
   * Used for querying price from commerce.
   */
  @visibility(Lifecycle.Read)
  meterId?: string;

  /**
   * The cost quantity.
   */
  @visibility(Lifecycle.Read)
  quantity?: int64;

  /**
   * The extended unit.
   */
  @visibility(Lifecycle.Read)
  extendedUnit?: string;
}

/**
 * The metadata to describe the capability.
 */
model SkuCapability {
  /**
   * An invariant to describe the feature.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * An invariant if the feature is measured by quantity.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * The collection of Data Box Edge/Gateway devices.
 */
model DataBoxEdgeDeviceList is Azure.Core.Page<DataBoxEdgeDevice>;

/**
 * The SKU type.
 */
model Sku {
  /**
   * SKU name.
   */
  name?: SkuName;

  /**
   * The SKU tier. This is based on the SKU name.
   */
  tier?: SkuTier;
}

/**
 * Msi identity details of the resource
 */
model ResourceIdentity {
  /**
   * Identity type
   */
  type?: MsiIdentityType;

  /**
   * Service Principal Id backing the Msi
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Home Tenant Id
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * The properties of the Data Box Edge/Gateway device.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DataBoxEdgeDeviceProperties {
  /**
   * DataBoxEdge Device Properties
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * The status of the Data Box Edge/Gateway device.
   */
  @visibility(Lifecycle.Read)
  dataBoxEdgeDeviceStatus?: DataBoxEdgeDeviceStatus;

  /**
   * The Serial Number of Data Box Edge/Gateway device.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * The Description of the Data Box Edge/Gateway device.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The description of the Data Box Edge/Gateway device model.
   */
  @visibility(Lifecycle.Read)
  modelDescription?: string;

  /**
   * The type of the Data Box Edge/Gateway device.
   */
  @visibility(Lifecycle.Read)
  deviceType?: DeviceType;

  /**
   * The Data Box Edge/Gateway device name.
   */
  @visibility(Lifecycle.Read)
  friendlyName?: string;

  /**
   * The Data Box Edge/Gateway device culture.
   */
  @visibility(Lifecycle.Read)
  culture?: string;

  /**
   * The Data Box Edge/Gateway device model.
   */
  @visibility(Lifecycle.Read)
  deviceModel?: string;

  /**
   * The Data Box Edge/Gateway device software version.
   */
  @visibility(Lifecycle.Read)
  deviceSoftwareVersion?: string;

  /**
   * The Data Box Edge/Gateway device local capacity in MB.
   */
  @visibility(Lifecycle.Read)
  deviceLocalCapacity?: int64;

  /**
   * The Data Box Edge/Gateway device timezone.
   */
  @visibility(Lifecycle.Read)
  timeZone?: string;

  /**
   * The device software version number of the device (eg: 1.2.18105.6).
   */
  @visibility(Lifecycle.Read)
  deviceHcsVersion?: string;

  /**
   * Type of compute roles configured.
   */
  @visibility(Lifecycle.Read)
  configuredRoleTypes?: RoleTypes[];

  /**
   * The number of nodes in the cluster.
   */
  @visibility(Lifecycle.Read)
  nodeCount?: int32;

  /**
   * The details of the move operation on this resource.
   */
  @visibility(Lifecycle.Read)
  resourceMoveDetails?: ResourceMoveDetails;

  /**
   * The details of Edge Profile for this resource
   */
  @visibility(Lifecycle.Read)
  edgeProfile?: EdgeProfile;

  /**
   * The details of data-residency related properties for this resource
   */
  dataResidency?: DataResidency;

  /**
   * Kubernetes Workload Profile
   */
  @visibility(Lifecycle.Read)
  kubernetesWorkloadProfile?: string;
}

/**
 * Fields for tracking resource move
 */
model ResourceMoveDetails {
  /**
   * Denotes whether move operation is in progress
   */
  operationInProgress?: ResourceMoveStatus;

  /**
   * Denotes the timeout of the operation to finish
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  operationInProgressLockTimeoutInUTC?: utcDateTime;
}

/**
 * Details about Edge Profile for the resource
 */
model EdgeProfile {
  /**
   * Edge Profile Subscription
   */
  subscription?: EdgeProfileSubscription;
}

/**
 * Subscription details for the Edge Profile
 */
model EdgeProfileSubscription {
  /**
   * Edge Subscription Registration ID
   */
  registrationId?: string;

  /**
   * ARM ID of the subscription
   */
  id?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  state?: SubscriptionState;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  registrationDate?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  subscriptionId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: SubscriptionProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SubscriptionProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  tenantId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  locationPlacementId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  quotaId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  serializedDetails?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  registeredFeatures?: SubscriptionRegisteredFeatures[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SubscriptionRegisteredFeatures {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  state?: string;
}

/**
 * Wraps data-residency related information for edge-resource and this should be used with ARM layer.
 */
model DataResidency {
  /**
   * DataResidencyType enum
   */
  type?: DataResidencyType;
}

/**
 * Represents the base class for all object models.
 */
model ARMBaseModel {
  /**
   * The path ID that uniquely identifies the object.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The object name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The hierarchical type of the object.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The Data Box Edge/Gateway device patch.
 */
model DataBoxEdgeDevicePatch {
  /**
   * The tags attached to the Data Box Edge/Gateway resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Msi identity of the resource
   */
  identity?: ResourceIdentity;

  /**
   * The properties associated with the Data Box Edge/Gateway resource
   */
  properties?: DataBoxEdgeDevicePropertiesPatch;
}

/**
 * The Data Box Edge/Gateway device properties patch.
 */
model DataBoxEdgeDevicePropertiesPatch {
  /**
   * Edge Profile property of the Data Box Edge/Gateway device
   */
  edgeProfile?: EdgeProfilePatch;
}

/**
 * The Data Box Edge/Gateway Edge Profile patch.
 */
model EdgeProfilePatch {
  /**
   * The Data Box Edge/Gateway Edge Profile Subscription patch
   */
  subscription?: EdgeProfileSubscriptionPatch;
}

/**
 * The Data Box Edge/Gateway Edge Profile Subscription patch.
 */
model EdgeProfileSubscriptionPatch {
  /**
   * The path ID that uniquely identifies the subscription of the edge profile.
   */
  id?: string;
}

/**
 * Collection of alerts.
 */
model AlertList is Azure.Core.Page<Alert>;

/**
 * Properties of alert.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AlertProperties {
  /**
   * Alert title.
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * Alert type.
   */
  @visibility(Lifecycle.Read)
  alertType?: string;

  /**
   * UTC time when the alert appeared.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  appearedAtDateTime?: utcDateTime;

  /**
   * Alert recommendation.
   */
  @visibility(Lifecycle.Read)
  recommendation?: string;

  /**
   * Severity of the alert.
   */
  @visibility(Lifecycle.Read)
  severity?: AlertSeverity;

  /**
   * Error details of the alert.
   */
  @visibility(Lifecycle.Read)
  errorDetails?: AlertErrorDetails;

  /**
   * Alert details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  detailedInformation?: Record<string>;
}

/**
 * Error details for the alert.
 */
model AlertErrorDetails {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * Error Message.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * Number of occurrences.
   */
  @visibility(Lifecycle.Read)
  occurrences?: int32;
}

/**
 * The collection of bandwidth schedules.
 */
model BandwidthSchedulesList is Azure.Core.Page<BandwidthSchedule>;

/**
 * The properties of the bandwidth schedule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model BandwidthScheduleProperties {
  /**
   * The start time of the schedule in UTC.
   */
  start: string;

  /**
   * The stop time of the schedule in UTC.
   */
  stop: string;

  /**
   * The bandwidth rate in Mbps.
   */
  rateInMbps: int32;

  /**
   * The days of the week when this schedule is applicable.
   */
  days: DayOfWeek[];
}

/**
 * Object for Capturing DeviceCapacityRequestInfo
 */
model DeviceCapacityRequestInfo {
  /**
   * The properties of the Device Capacity Request.
   */
  properties: DeviceCapacityRequestInfoProperties;
}

/**
 * Properties of Device Capacity Request Info containing VM's to be checked and their corresponding results.
 */
model DeviceCapacityRequestInfoProperties {
  /**
   * Array containing the sizes of the VMs for checking if its feasible to create them on the appliance.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  vmPlacementQuery: string[][];

  /**
   * Array of the VMs of the sizes in VmSizes can be provisioned on the appliance.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  vmPlacementResults?: VmPlacementRequestResult[];
}

/**
 * List of VM sizes being checked for creation on appliance along with corresponding result.
 */
model VmPlacementRequestResult {
  /**
   * List of VM sizes being checked.
   */
  vmSize?: string[];

  /**
   * Boolean value indicating if the VM(s) in VmSize can be created.
   */
  isFeasible?: boolean;

  /**
   * MessageCode indicating reason for success or failure.
   */
  messageCode?: string;

  /**
   * Localized message to be displayed to the user to explain the check result.
   */
  message?: string;
}

/**
 * The properties of Device Capacity Info
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DeviceCapacityInfoProperties {
  /**
   * Timestamp of request in UTC
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStamp?: utcDateTime;

  /**
   * Cluster capacity data for storage resources (CSV).
   */
  clusterStorageCapacityInfo?: ClusterStorageViewData;

  /**
   * Cluster capacity data for compute resources (Memory and GPU).
   */
  clusterComputeCapacityInfo?: ClusterCapacityViewData;

  /**
   * The dictionary of individual node names and node capacities in the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  nodeCapacityInfos?: Record<HostCapacity>;
}

/**
 * Cluster Storage Data.
 */
model ClusterStorageViewData {
  /**
   * Total storage on the cluster in MB.
   */
  clusterTotalStorageMb?: float64;

  /**
   * The available or free storage on the cluster in MB.
   */
  clusterFreeStorageMb?: float64;
}

/**
 * Cluster Compute Data.
 */
model ClusterCapacityViewData {
  /**
   * The FQDN of the cluster.
   */
  fqdn?: string;

  /**
   * The cluster's GPU capacity.
   */
  gpuCapacity?: ClusterGpuCapacity;

  /**
   * The cluster's memory capacity.
   */
  memoryCapacity?: ClusterMemoryCapacity;

  /**
   * The last time at which the ClusterCapacityViewData was set.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRefreshedTime?: utcDateTime;

  /**
   * The total # of vCPUs provisioned by non-HPN VM per appliance.
   */
  totalProvisionedNonHpnCores?: int64;
}

/**
 * Cluster GPU Data.
 */
model ClusterGpuCapacity {
  /**
   * The cluster GPU Type.
   */
  gpuType?: string;

  /**
   * The used GPU units count in the cluster.
   */
  gpuUsedUnitsCount?: int32;

  /**
   * The free GPU units count in the cluster.
   */
  gpuFreeUnitsCount?: int32;

  /**
   * The GPU units count reserved for failover in the cluster.
   */
  gpuReservedForFailoverUnitsCount?: int32;

  /**
   * The total GPU units count in the cluster.
   */
  gpuTotalUnitsCount?: int32;
}

/**
 * NodeCapacityInfo defines the required information to determine the placement of a VM.
 */
model ClusterMemoryCapacity {
  /**
   * The free memory in the cluster in MB.
   */
  clusterFreeMemoryMb?: float64;

  /**
   * The used memory in the cluster in MB.
   */
  clusterUsedMemoryMb?: float64;

  /**
   * The failover memory in the cluster in MB.
   */
  clusterFailoverMemoryMb?: float64;

  /**
   * The fragmentation memory in the cluster in MB.
   */
  clusterFragmentationMemoryMb?: float64;

  /**
   * The memory reserved for Hyper-V in the cluster in MB.
   */
  clusterHypervReserveMemoryMb?: float64;

  /**
   * The memory of the Infra VM in the cluster in MB.
   */
  clusterInfraVmMemoryMb?: float64;

  /**
   * The total memory in the cluster in MB.
   */
  clusterTotalMemoryMb?: float64;

  /**
   * The non-failover memory in the cluster in MB.
   */
  clusterNonFailoverVmMb?: float64;

  /**
   * The memory used by VMs in the cluster in MB.
   */
  clusterMemoryUsedByVmsMb?: float64;
}

/**
 * Host Capacity Data.
 */
model HostCapacity {
  /**
   * The name of the host.
   */
  hostName?: string;

  /**
   * The available memory on the host accounting for VM placement size and any host VM reservations.
   */
  effectiveAvailableMemoryMbOnHost?: int64;

  /**
   * The available amount of GPUs on the host to use after accounting for GPUS used by reservations on the host.
   */
  availableGpuCount?: int32;

  /**
   * The VM used memory per VmId.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  vmUsedMemory?: Record<VmMemory>;

  /**
   * The GPU type of the VM.
   */
  gpuType?: string;

  /**
   * The numa nodes information for Hpn VMs.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  numaNodesData?: NumaNodeData[];
}

/**
 * VmMemory Data.
 */
model VmMemory {
  /**
   * The total amount of RAM in the virtual machine, as seen by the guest  operating system. For a virtual machine with dynamic memory enabled, this represents the initial memory available at startup.
   */
  startupMemoryMB?: int64;

  /**
   * The current memory used by the virtual machine.
   */
  currentMemoryUsageMB?: int64;
}

/**
 * NUMA node data.
 */
model NumaNodeData {
  /**
   * The NUMA node index.
   */
  numaNodeIndex?: int32;

  /**
   * The total memory on the NUMA node.
   */
  totalMemoryInMb?: int64;

  /**
   * The logical cores per core count.
   */
  logicalCoreCountPerCore?: int32;

  /**
   * The effective available memory on the NUMA node in MB.
   */
  effectiveAvailableMemoryInMb?: int64;

  /**
   * The free VCPU indices for the Hpn VMs.
   */
  freeVCpuIndexesForHpn?: int32[];

  /**
   * The VCPU indices for Hpn VMs
   */
  vCpuIndexesForHpn?: int32[];

  /**
   * The VCPU indices for the root.
   */
  vCpuIndexesForRoot?: int32[];
}

/**
 * The properties of proactive log collection settings.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ProactiveLogCollectionSettingsProperties {
  /**
   * Proactive diagnostic collection consent flag
   */
  userConsent: ProactiveDiagnosticsConsent;
}

/**
 * The properties of remote support settings.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DiagnosticRemoteSupportSettingsProperties {
  /**
   * Remote support settings list according to the RemoteApplicationType
   */
  @OpenAPI.extension("x-ms-identifiers", #["remoteApplicationType"])
  remoteSupportSettingsList?: RemoteSupportSettings[];
}

/**
 * RemoteApplicationType for which remote support settings is being modified
 */
model RemoteSupportSettings {
  /**
   * Remote application type
   */
  remoteApplicationType?: RemoteApplicationType;

  /**
   * Access level allowed for this remote application type
   */
  accessLevel?: AccessLevel;

  /**
   * Expiration time stamp
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeStampInUTC?: utcDateTime;
}

/**
 * Used in activation key generation flow.
 */
model GenerateCertResponse {
  /**
   * Gets or sets base64 encoded certificate raw data,
   * this is the public part needed to be uploaded to cert vault
   */
  publicKey?: string;

  /**
   * Gets or sets base64 encoded private part of the certificate,
   * needed to form the activation key
   */
  privateKey?: string;

  /**
   * Gets or sets expiry time in UTC
   */
  expiryTimeInUTC?: string;
}

/**
 * The extended Info of the Data Box Edge/Gateway device.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DataBoxEdgeDeviceExtendedInfo extends ARMBaseModel {
  /**
   * The extended info properties.
   */
  properties?: DataBoxEdgeDeviceExtendedInfoProperties;

  /**
   * Metadata pertaining to creation and last modification of DataBoxEdgeDevice
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * The properties of the Data Box Edge/Gateway device extended info.
 */
model DataBoxEdgeDeviceExtendedInfoProperties {
  /**
   * The digital signature of encrypted certificate.
   */
  encryptionKeyThumbprint?: string;

  /**
   * The public part of the encryption certificate. Client uses this to encrypt any secret.
   */
  encryptionKey?: string;

  /**
   * The Resource ID of the Resource.
   */
  @visibility(Lifecycle.Read)
  resourceKey?: string;

  /**
   * The Key Vault ARM Id for client secrets
   */
  clientSecretStoreId?: string;

  /**
   * The url to access the Client Key Vault
   */
  clientSecretStoreUrl?: string;

  /**
   * The name of Channel Integrity Key stored in the Client Key Vault
   */
  channelIntegrityKeyName?: string;

  /**
   * The version of Channel Integrity Key stored in the Client Key Vault
   */
  channelIntegrityKeyVersion?: string;

  /**
   * Key vault sync status
   */
  keyVaultSyncStatus?: KeyVaultSyncStatus;

  /**
   * Device secrets, will be returned only with ODataFilter $expand=deviceSecrets
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  deviceSecrets?: Record<Secret>;

  /**
   * Cluster Witness Type
   */
  @visibility(Lifecycle.Read)
  clusterWitnessType?: ClusterWitnessType;

  /**
   * The witness location of file share.
   */
  @visibility(Lifecycle.Read)
  fileShareWitnessLocation?: string;

  /**
   * The username of file share.
   */
  @visibility(Lifecycle.Read)
  fileShareWitnessUsername?: string;

  /**
   * The Cloud Witness Storage account name.
   */
  @visibility(Lifecycle.Read)
  cloudWitnessStorageAccountName?: string;

  /**
   * The Container for cloud witness in the storage account.
   */
  @visibility(Lifecycle.Read)
  cloudWitnessContainerName?: string;

  /**
   * The Azure service endpoint of the cloud witness storage account.
   */
  @visibility(Lifecycle.Read)
  cloudWitnessStorageEndpoint?: string;
}

/**
 * Holds device secret either as a KeyVault reference or as an encrypted value.
 */
model Secret {
  /**
   * Encrypted (using device public key) secret value.
   */
  encryptedSecret?: AsymmetricEncryptedSecret;

  /**
   * Id of the Key-Vault where secret is stored (ex: secrets/AuthClientSecret/82ef4346187a4033a10d629cde07d740).
   */
  keyVaultId?: string;
}

/**
 * Represent the secrets intended for encryption with asymmetric key pair.
 */
model AsymmetricEncryptedSecret {
  /**
   * The value of the secret.
   */
  value: string;

  /**
   * Thumbprint certificate used to encrypt \"Value\". If the value is unencrypted, it will be null.
   */
  encryptionCertThumbprint?: string;

  /**
   * The algorithm used to encrypt "Value".
   */
  encryptionAlgorithm: EncryptionAlgorithm;
}

/**
 * The job error information containing the list of job errors.
 */
model JobErrorDetails {
  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  errorDetails?: JobErrorItem[];

  /**
   * The code intended for programmatic access.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The message that describes the error in detail.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * The job error items.
 */
model JobErrorItem {
  /**
   * The recommended actions.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  recommendations?: string[];

  /**
   * The code intended for programmatic access.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The message that describes the error in detail.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * The properties for the job.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model JobProperties {
  /**
   * The type of the job.
   */
  @visibility(Lifecycle.Read)
  jobType?: JobType;

  /**
   * Current stage of the update operation.
   */
  @visibility(Lifecycle.Read)
  currentStage?: UpdateOperationStage;

  /**
   * The download progress.
   */
  @visibility(Lifecycle.Read)
  downloadProgress?: UpdateDownloadProgress;

  /**
   * The install progress.
   */
  @visibility(Lifecycle.Read)
  installProgress?: UpdateInstallProgress;

  /**
   * Total number of errors encountered during the refresh process.
   */
  @visibility(Lifecycle.Read)
  totalRefreshErrors?: int32;

  /**
   * Local share/remote container relative path to the error manifest file of the refresh.
   */
  @visibility(Lifecycle.Read)
  errorManifestFile?: string;

  /**
   * ARM ID of the entity that was refreshed.
   */
  @visibility(Lifecycle.Read)
  refreshedEntityId?: string;

  /**
   * If only subfolders need to be refreshed, then the subfolder path inside the share or container. (The path is empty if there are no subfolders.)
   */
  folder?: string;
}

/**
 * Details about the download progress of update.
 */
model UpdateDownloadProgress {
  /**
   * The download phase.
   */
  @visibility(Lifecycle.Read)
  downloadPhase?: DownloadPhase;

  /**
   * Percentage of completion.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * Total bytes to download.
   */
  @visibility(Lifecycle.Read)
  totalBytesToDownload?: float64;

  /**
   * Total bytes downloaded.
   */
  @visibility(Lifecycle.Read)
  totalBytesDownloaded?: float64;

  /**
   * Number of updates to download.
   */
  @visibility(Lifecycle.Read)
  numberOfUpdatesToDownload?: int32;

  /**
   * Number of updates downloaded.
   */
  @visibility(Lifecycle.Read)
  numberOfUpdatesDownloaded?: int32;
}

/**
 * Progress details during installation of updates.
 */
model UpdateInstallProgress {
  /**
   * Percentage completed.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * Number of updates to install.
   */
  @visibility(Lifecycle.Read)
  numberOfUpdatesToInstall?: int32;

  /**
   * Number of updates installed.
   */
  @visibility(Lifecycle.Read)
  numberOfUpdatesInstalled?: int32;
}

/**
 * The properties of network settings.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model NetworkSettingsProperties {
  /**
   * The network adapter list on the device.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["adapterId"])
  networkAdapters?: NetworkAdapter[];
}

/**
 * Represents the networkAdapter on a device.
 */
model NetworkAdapter {
  /**
   * Instance ID of network adapter.
   */
  @visibility(Lifecycle.Read)
  adapterId?: string;

  /**
   * Hardware position of network adapter.
   */
  @visibility(Lifecycle.Read)
  adapterPosition?: NetworkAdapterPosition;

  /**
   * Logical index of the adapter.
   */
  @visibility(Lifecycle.Read)
  index?: int32;

  /**
   * Node ID of the network adapter.
   */
  @visibility(Lifecycle.Read)
  nodeId?: string;

  /**
   * Network adapter name.
   */
  @visibility(Lifecycle.Read)
  networkAdapterName?: string;

  /**
   * Hardware label for the adapter.
   */
  @visibility(Lifecycle.Read)
  label?: string;

  /**
   * MAC address.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * Link speed.
   */
  @visibility(Lifecycle.Read)
  linkSpeed?: int64;

  /**
   * Value indicating whether this adapter is valid.
   */
  @visibility(Lifecycle.Read)
  status?: NetworkAdapterStatus;

  /**
   * Value indicating whether this adapter is RDMA capable.
   */
  rdmaStatus?: NetworkAdapterRdmaStatus;

  /**
   * Value indicating whether this adapter has DHCP enabled.
   */
  dhcpStatus?: NetworkAdapterDhcpStatus;

  /**
   * The IPv4 configuration of the network adapter.
   */
  @visibility(Lifecycle.Read)
  ipv4Configuration?: Ipv4Config;

  /**
   * The IPv6 configuration of the network adapter.
   */
  @visibility(Lifecycle.Read)
  ipv6Configuration?: Ipv6Config;

  /**
   * The IPv6 local address.
   */
  @visibility(Lifecycle.Read)
  ipv6LinkLocalAddress?: string;

  /**
   * The list of DNS Servers of the device.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  dnsServers?: string[];
}

/**
 * The network adapter position.
 */
model NetworkAdapterPosition {
  /**
   * The network group.
   */
  @visibility(Lifecycle.Read)
  networkGroup?: NetworkGroup;

  /**
   * The port.
   */
  @visibility(Lifecycle.Read)
  port?: int32;
}

/**
 * Details related to the IPv4 address configuration.
 */
model Ipv4Config {
  /**
   * The IPv4 address of the network adapter.
   */
  @visibility(Lifecycle.Read)
  ipAddress?: string;

  /**
   * The IPv4 subnet of the network adapter.
   */
  @visibility(Lifecycle.Read)
  subnet?: string;

  /**
   * The IPv4 gateway of the network adapter.
   */
  @visibility(Lifecycle.Read)
  gateway?: string;
}

/**
 * Details related to the IPv6 address configuration.
 */
model Ipv6Config {
  /**
   * The IPv6 address of the network adapter.
   */
  @visibility(Lifecycle.Read)
  ipAddress?: string;

  /**
   * The IPv6 prefix of the network adapter.
   */
  @visibility(Lifecycle.Read)
  prefixLength?: int32;

  /**
   * The IPv6 gateway of the network adapter.
   */
  @visibility(Lifecycle.Read)
  gateway?: string;
}

/**
 * Collection of Nodes.
 */
model NodeList is Azure.Core.Page<Node>;

/**
 * Represents a single node in a Data box Edge/Gateway device
 * Gateway devices, standalone Edge devices and a single node cluster Edge device will all have 1 node
 * Multi-node Edge devices will have more than 1 nodes
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Node extends ARMBaseModel {
  /**
   * The properties of the node
   */
  @visibility(Lifecycle.Read)
  properties?: NodeProperties;
}

/**
 * This class represents the nodes in a highly available cluster
 */
model NodeProperties {
  /**
   * The current status of the individual node
   */
  @visibility(Lifecycle.Read)
  nodeStatus?: NodeStatus;

  /**
   * Serial number of the Chassis
   */
  @visibility(Lifecycle.Read)
  nodeChassisSerialNumber?: string;

  /**
   * Serial number of the individual node
   */
  @visibility(Lifecycle.Read)
  nodeSerialNumber?: string;

  /**
   * Display Name of the individual node
   */
  @visibility(Lifecycle.Read)
  nodeDisplayName?: string;

  /**
   * Friendly software version name that is currently installed on the node
   */
  @visibility(Lifecycle.Read)
  nodeFriendlySoftwareVersion?: string;

  /**
   * HCS version that is currently installed on the node
   */
  @visibility(Lifecycle.Read)
  nodeHcsVersion?: string;

  /**
   * Guid instance id of the node
   */
  @visibility(Lifecycle.Read)
  nodeInstanceId?: string;
}

/**
 * List of order entities.
 */
model OrderList is Azure.Core.Page<Order>;

/**
 * Order properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model OrderProperties {
  /**
   * It specify the order resource id.
   */
  @visibility(Lifecycle.Read)
  orderId?: string;

  /**
   * The contact details.
   */
  contactInformation: ContactDetails;

  /**
   * The shipping address.
   */
  shippingAddress?: Address;

  /**
   * Current status of the order.
   */
  @visibility(Lifecycle.Read)
  currentStatus?: OrderStatus;

  /**
   * List of status changes in the order.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["trackingInformation/serialNumber"])
  orderHistory?: OrderStatus[];

  /**
   * Serial number of the device.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Tracking information for the package delivered to the customer whether it has an original or a replacement device.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["serialNumber"])
  deliveryTrackingInfo?: TrackingInfo[];

  /**
   * Tracking information for the package returned from the customer whether it has an original or a replacement device.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["serialNumber"])
  returnTrackingInfo?: TrackingInfo[];

  /**
   * ShipmentType of the order
   */
  shipmentType?: ShipmentType;
}

/**
 * Contains all the contact details of the customer.
 */
model ContactDetails {
  /**
   * The contact person name.
   */
  contactPerson: string;

  /**
   * The name of the company.
   */
  companyName: string;

  /**
   * The phone number.
   */
  phone: string;

  /**
   * The email list.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  emailList: string[];
}

/**
 * The shipping address of the customer.
 */
model Address {
  /**
   * The address line1.
   */
  addressLine1?: string;

  /**
   * The address line2.
   */
  addressLine2?: string;

  /**
   * The address line3.
   */
  addressLine3?: string;

  /**
   * The postal code.
   */
  postalCode?: string;

  /**
   * The city name.
   */
  city?: string;

  /**
   * The state name.
   */
  state?: string;

  /**
   * The country name.
   */
  country: string;
}

/**
 * Represents a single status change.
 */
model OrderStatus {
  /**
   * Status of the order as per the allowed status types.
   */
  status: OrderState;

  /**
   * Time of status update.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updateDateTime?: utcDateTime;

  /**
   * Comments related to this status change.
   */
  comments?: string;

  /**
   * Tracking information related to the state in the ordering flow
   */
  @visibility(Lifecycle.Read)
  trackingInformation?: TrackingInfo;

  /**
   * Dictionary to hold generic information which is not stored
   * by the already existing properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  additionalOrderDetails?: Record<string>;
}

/**
 * Tracking courier information.
 */
model TrackingInfo {
  /**
   * Serial number of the device being tracked.
   */
  serialNumber?: string;

  /**
   * Name of the carrier used in the delivery.
   */
  carrierName?: string;

  /**
   * Tracking ID of the shipment.
   */
  trackingId?: string;

  /**
   * Tracking URL of the shipment.
   */
  trackingUrl?: string;
}

/**
 * DC Access code in the case of Self Managed Shipping.
 */
model DCAccessCode {
  /**
   * DCAccessCode properties.
   */
  properties?: DCAccessCodeProperties;
}

/**
 * DCAccessCode Properties.
 */
model DCAccessCodeProperties {
  /**
   * DCAccess Code for the Self Managed shipment.
   */
  authCode?: string;
}

/**
 * Collection of all the roles on the Data Box Edge device.
 */
model RoleList is Azure.Core.Page<Role>;

/**
 * Collection of all the Role addon on the Azure Stack Edge device.
 */
model AddonList is Azure.Core.Page<Addon>;

/**
 * Collection of metric configurations.
 */
model MonitoringMetricConfigurationList
  is Azure.Core.Page<MonitoringMetricConfiguration>;

/**
 * Metrics properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model MonitoringMetricConfigurationProperties {
  /**
   * The metrics configuration details
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  metricConfigurations: MetricConfiguration[];
}

/**
 * Metric configuration.
 */
model MetricConfiguration {
  /**
   * The Resource ID on which the metrics should be pushed.
   */
  resourceId: string;

  /**
   * The MDM account to which the counters should be pushed.
   */
  mdmAccount?: string;

  /**
   * The MDM namespace to which the counters should be pushed. This is required if MDMAccount is specified
   */
  metricNameSpace?: string;

  /**
   * Host name for the IoT hub associated to the device.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  counterSets: MetricCounterSet[];
}

/**
 * The metric counter set
 */
model MetricCounterSet {
  /**
   * The counters that should be collected in this set.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  counters: MetricCounter[];
}

/**
 * The metric counter
 */
model MetricCounter {
  /**
   * The counter name.
   */
  name: string;

  /**
   * The instance from which counter should be collected.
   */
  instance?: string;

  /**
   * The dimension filter.
   */
  @OpenAPI.extension("x-ms-identifiers", #["sourceName"])
  dimensionFilter?: MetricDimension[];

  /**
   * The additional dimensions to be added to metric.
   */
  @OpenAPI.extension("x-ms-identifiers", #["sourceName"])
  additionalDimensions?: MetricDimension[];
}

/**
 * The metric dimension
 */
model MetricDimension {
  /**
   * The dimension type.
   */
  sourceType: string;

  /**
   * The dimension value.
   */
  sourceName: string;
}

/**
 * The security settings of a device.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SecuritySettings extends ARMBaseModel {
  /**
   * Properties of the security settings.
   */
  properties: SecuritySettingsProperties;
}

/**
 * The properties of security settings.
 */
model SecuritySettingsProperties {
  /**
   * Device administrator password as an encrypted string (encrypted using RSA PKCS #1) is used to sign into the  local web UI of the device. The Actual password should have at least 8 characters that are a combination of  uppercase, lowercase, numeric, and special characters.
   */
  deviceAdminPassword: AsymmetricEncryptedSecret;
}

/**
 * Collection of all the shares on the Data Box Edge/Gateway device.
 */
model ShareList is Azure.Core.Page<Share>;

/**
 * The share properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ShareProperties {
  /**
   * Description for the share.
   */
  description?: string;

  /**
   * Current status of the share.
   */
  shareStatus: ShareStatus;

  /**
   * Current monitoring status of the share.
   */
  monitoringStatus: MonitoringStatus;

  /**
   * Azure container mapping for the share.
   */
  azureContainerInfo?: AzureContainerInfo;

  /**
   * Access protocol to be used by the share.
   */
  accessProtocol: ShareAccessProtocol;

  /**
   * Mapping of users and corresponding access rights on the share (required for SMB protocol).
   */
  @OpenAPI.extension("x-ms-identifiers", #["userId"])
  userAccessRights?: UserAccessRight[];

  /**
   * List of IP addresses and corresponding access rights on the share(required for NFS protocol).
   */
  @OpenAPI.extension("x-ms-identifiers", #["client"])
  clientAccessRights?: ClientAccessRight[];

  /**
   * Details of the refresh job on this share.
   */
  refreshDetails?: RefreshDetails;

  /**
   * Share mount point to the role.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["shareId"])
  shareMappings?: MountPointMap[];

  /**
   * Data policy of the share.
   */
  dataPolicy?: DataPolicy;
}

/**
 * Azure container mapping of the endpoint.
 */
model AzureContainerInfo {
  /**
   * ID of the storage account credential used to access storage.
   */
  storageAccountCredentialId: string;

  /**
   * Container name (Based on the data format specified, this represents the name of Azure Files/Page blob/Block blob).
   */
  containerName: string;

  /**
   * Storage format used for the file represented by the share.
   */
  dataFormat: AzureContainerDataFormat;
}

/**
 * The mapping between a particular user and the access type on the SMB share.
 */
model UserAccessRight {
  /**
   * User ID (already existing in the device).
   */
  userId: string;

  /**
   * Type of access to be allowed for the user.
   */
  accessType: ShareAccessType;
}

/**
 * The mapping between a particular client IP and the type of access client has on the NFS share.
 */
model ClientAccessRight {
  /**
   * IP of the client.
   */
  client: string;

  /**
   * Type of access to be allowed for the client.
   */
  accessPermission: ClientPermissionType;
}

/**
 * Fields for tracking refresh job on the share or container.
 */
model RefreshDetails {
  /**
   * If a refresh job is currently in progress on this share or container, this field indicates the ARM resource ID of that job. The field is empty if no job is in progress.
   */
  inProgressRefreshJobId?: string;

  /**
   * Indicates the completed time for the last refresh job on this particular share or container, if any.This could be a failed job or a successful job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletedRefreshJobTimeInUTC?: utcDateTime;

  /**
   * Indicates the relative path of the error xml for the last refresh job on this particular share or container, if any. This could be a failed job or a successful job.
   */
  errorManifestFile?: string;

  /**
   * Indicates the id of the last refresh job on this particular share or container,if any. This could be a failed job or a successful job.
   */
  lastJob?: string;
}

/**
 * The share mount point.
 */
model MountPointMap {
  /**
   * ID of the share mounted to the role VM.
   */
  shareId: string;

  /**
   * ID of the role to which share is mounted.
   */
  @visibility(Lifecycle.Read)
  roleId?: string;

  /**
   * Mount point for the share.
   */
  @visibility(Lifecycle.Read)
  mountPoint?: string;

  /**
   * Mounting type.
   */
  @visibility(Lifecycle.Read)
  mountType?: MountType;

  /**
   * Role type.
   */
  @visibility(Lifecycle.Read)
  roleType?: RoleTypes;
}

/**
 * The collection of storage account credentials.
 */
model StorageAccountCredentialList is Azure.Core.Page<StorageAccountCredential>;

/**
 * The storage account credential properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model StorageAccountCredentialProperties {
  /**
   * Alias for the storage account.
   */
  `alias`: string;

  /**
   * Username for the storage account.
   */
  userName?: string;

  /**
   * Encrypted storage key.
   */
  accountKey?: AsymmetricEncryptedSecret;

  /**
   * Connection string for the storage account. Use this string if username and account key are not specified.
   */
  connectionString?: string;

  /**
   * Signifies whether SSL needs to be enabled or not.
   */
  sslStatus: SSLStatus;

  /**
   * Blob end point for private clouds.
   */
  blobDomainName?: string;

  /**
   * Type of storage accessed on the storage account.
   */
  accountType: AccountType;

  /**
   * Id of the storage account.
   */
  storageAccountId?: string;
}

/**
 * Collection of all the Storage Accounts on the Data Box Edge/Gateway device.
 */
model StorageAccountList is Azure.Core.Page<StorageAccount>;

/**
 * The storage account properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model StorageAccountProperties {
  /**
   * Description for the storage Account.
   */
  description?: string;

  /**
   * Current status of the storage account
   */
  storageAccountStatus?: StorageAccountStatus;

  /**
   * Data policy of the storage Account.
   */
  dataPolicy: DataPolicy;

  /**
   * Storage Account Credential Id
   */
  storageAccountCredentialId?: string;

  /**
   * BlobEndpoint of Storage Account
   */
  @visibility(Lifecycle.Read)
  blobEndpoint?: string;

  /**
   * The Container Count. Present only for Storage Accounts with DataPolicy set to Cloud.
   */
  @visibility(Lifecycle.Read)
  containerCount?: int32;
}

/**
 * Collection of all the containers on the Data Box Edge/Gateway device.
 */
model ContainerList is Azure.Core.Page<Container>;

/**
 * The container properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ContainerProperties {
  /**
   * Current status of the container.
   */
  @visibility(Lifecycle.Read)
  containerStatus?: ContainerStatus;

  /**
   * DataFormat for Container
   */
  dataFormat: AzureContainerDataFormat;

  /**
   * Details of the refresh job on this container.
   */
  @visibility(Lifecycle.Read)
  refreshDetails?: RefreshDetails;

  /**
   * The UTC time when container got created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;
}

/**
 * Collection of all trigger on the data box edge device.
 */
model TriggerList is Azure.Core.Page<Trigger>;

/**
 * The request object for trigger support package.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TriggerSupportPackageRequest extends ARMBaseModel {
  /**
   * The TriggerSupportPackageRequest properties.
   */
  properties: SupportPackageRequestProperties;
}

/**
 * The share properties.
 */
model SupportPackageRequestProperties {
  /**
   * MinimumTimeStamp from where logs need to be collected
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  minimumTimeStamp?: utcDateTime;

  /**
   * Start of the timespan of the log collection
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maximumTimeStamp?: utcDateTime;

  /**
   * Type of files, which need to be included in the logs
   * This will contain the type of logs (Default/DefaultWithDumps/None/All/DefaultWithArchived)
   * or a comma separated list of log types that are required
   */
  include?: string;
}

/**
 * The Data Box Edge/Gateway device extended info patch.
 */
model DataBoxEdgeDeviceExtendedInfoPatch {
  /**
   * The Key Vault ARM Id for client secrets
   */
  clientSecretStoreId?: string;

  /**
   * The url to access the Client Key Vault
   */
  clientSecretStoreUrl?: string;

  /**
   * The name for Channel Integrity Key stored in the Client Key Vault
   */
  channelIntegrityKeyName?: string;

  /**
   * The version of Channel Integrity Key stored in the Client Key Vault
   */
  channelIntegrityKeyVersion?: string;

  /**
   * For changing or to initiate the resync to key-vault set the status to KeyVaultSyncPending, rest of the status will not be applicable.
   */
  syncStatus?: KeyVaultSyncStatus;
}

/**
 * The device update information summary.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model UpdateSummaryProperties {
  /**
   * The current version of the device in format: 1.2.17312.13.",
   */
  deviceVersionNumber?: string;

  /**
   * The current version of the device in text format.
   */
  friendlyDeviceVersionName?: string;

  /**
   * The last time when a scan was done on the device.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deviceLastScannedDateTime?: utcDateTime;

  /**
   * The time when the last scan job was completed (success/cancelled/failed) on the appliance.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletedScanJobDateTime?: utcDateTime;

  /**
   * Time when the last scan job is successfully completed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulScanJobTime?: utcDateTime;

  /**
   * The time when the last Download job was completed (success/cancelled/failed) on the appliance.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletedDownloadJobDateTime?: utcDateTime;

  /**
   * JobId of the last ran download job.(Can be success/cancelled/failed)
   */
  @visibility(Lifecycle.Read)
  lastCompletedDownloadJobId?: string;

  /**
   * JobStatus of the last ran download job.
   */
  @visibility(Lifecycle.Read)
  lastDownloadJobStatus?: JobStatus;

  /**
   * The time when the Last Install job was completed successfully on the appliance
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSuccessfulInstallJobDateTime?: utcDateTime;

  /**
   * The time when the last Install job was completed (success/cancelled/failed) on the appliance.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastCompletedInstallJobDateTime?: utcDateTime;

  /**
   * JobId of the last ran install job.(Can be success/cancelled/failed)
   */
  @visibility(Lifecycle.Read)
  lastCompletedInstallJobId?: string;

  /**
   * JobStatus of the last ran install job.
   */
  @visibility(Lifecycle.Read)
  lastInstallJobStatus?: JobStatus;

  /**
   * The number of updates available for the current device version as per the last device scan.
   */
  @visibility(Lifecycle.Read)
  totalNumberOfUpdatesAvailable?: int32;

  /**
   * The total number of items pending download.
   */
  @visibility(Lifecycle.Read)
  totalNumberOfUpdatesPendingDownload?: int32;

  /**
   * The total number of items pending install.
   */
  @visibility(Lifecycle.Read)
  totalNumberOfUpdatesPendingInstall?: int32;

  /**
   * Indicates if updates are available and at least one of the updates needs a reboot.
   */
  @visibility(Lifecycle.Read)
  rebootBehavior?: InstallRebootBehavior;

  /**
   * The current update operation.
   */
  @visibility(Lifecycle.Read)
  ongoingUpdateOperation?: UpdateOperation;

  /**
   * The job ID of the download job in progress.
   */
  @visibility(Lifecycle.Read)
  inProgressDownloadJobId?: string;

  /**
   * The job ID of the install job in progress.
   */
  @visibility(Lifecycle.Read)
  inProgressInstallJobId?: string;

  /**
   * The time when the currently running download (if any) started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  inProgressDownloadJobStartedDateTime?: utcDateTime;

  /**
   * The time when the currently running install (if any) started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  inProgressInstallJobStartedDateTime?: utcDateTime;

  /**
   * The list of updates available for install.
   */
  @visibility(Lifecycle.Read)
  updateTitles?: string[];

  /**
   * The list of updates available for install.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["updateTitle"])
  updates?: UpdateDetails[];

  /**
   * The total size of updates available for download in bytes.
   */
  @visibility(Lifecycle.Read)
  totalUpdateSizeInBytes?: float64;

  /**
   * The total time in Minutes
   */
  @visibility(Lifecycle.Read)
  totalTimeInMinutes?: int32;
}

/**
 * Update Specific attributes
 */
model UpdateDetails {
  /**
   * Title of the Update
   */
  updateTitle?: string;

  /**
   * Size of the update(In Bytes)
   */
  updateSize?: float64;

  /**
   * Type of the Update
   */
  updateType?: UpdateType;

  /**
   * Target Version number
   */
  targetVersion?: string;

  /**
   * Friendly Version Number
   */
  friendlyVersionNumber?: string;

  /**
   * Estimated Install Time for the update
   */
  estimatedInstallTimeInMins?: int32;

  /**
   * Indicates if updates are available and at least one of the updates needs a reboot.
   */
  rebootBehavior?: InstallRebootBehavior;

  /**
   * Impact of Installing an updateType
   */
  installationImpact?: InstallationImpact;

  /**
   * Status of the update.
   */
  status?: UpdateStatus;
}

/**
 * The upload certificate request.
 */
model UploadCertificateRequest {
  /**
   * The Base 64 encoded certificate raw data.
   */
  properties: RawCertificateData;
}

/**
 * Raw Certificate Data.
 */
model RawCertificateData {
  /**
   * The authentication type.
   */
  authenticationType?: AuthenticationType;

  /**
   * The base64 encoded certificate raw data.
   */
  certificate: string;
}

/**
 * The upload registration certificate response.
 */
model UploadCertificateResponse {
  /**
   * Specifies authentication type.
   */
  authType?: AuthenticationType;

  /**
   * The resource ID of the Data Box Edge/Gateway device.
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * Azure Active Directory tenant authority.
   */
  @visibility(Lifecycle.Read)
  aadAuthority?: string;

  /**
   * Azure Active Directory tenant ID.
   */
  @visibility(Lifecycle.Read)
  aadTenantId?: string;

  /**
   * Azure Active Directory service principal client ID.
   */
  @visibility(Lifecycle.Read)
  servicePrincipalClientId?: string;

  /**
   * Azure Active Directory service principal object ID.
   */
  @visibility(Lifecycle.Read)
  servicePrincipalObjectId?: string;

  /**
   * The azure management endpoint audience.
   */
  @visibility(Lifecycle.Read)
  azureManagementEndpointAudience?: string;

  /**
   * Identifier of the target resource that is the recipient of the requested token.
   */
  @visibility(Lifecycle.Read)
  aadAudience?: string;
}

/**
 * Collection of users.
 */
model UserList is Azure.Core.Page<User>;

/**
 * The user properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model UserProperties {
  /**
   * The password details.
   */
  encryptedPassword?: AsymmetricEncryptedSecret;

  /**
   * List of shares that the user has rights on. This field should not be specified during user creation.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["shareId"])
  shareAccessRights?: ShareAccessRight[];

  /**
   * Type of the user.
   */
  userType: UserType;
}

/**
 * Specifies the mapping between this particular user and the type of access he has on shares on this device.
 */
model ShareAccessRight {
  /**
   * The share ID.
   */
  shareId: string;

  /**
   * Type of access to be allowed on the share for this user.
   */
  accessType: ShareAccessType;
}

/**
 * Arc Addon.
 */
model ArcAddon extends Addon {
  /**
   * Properties specific to Arc addon.
   */
  properties: ArcAddonProperties;

  /**
   * Addon type.
   */
  kind: "ArcForKubernetes";
}

/**
 * Arc addon properties.
 */
model ArcAddonProperties {
  /**
   * Arc resource subscription Id
   */
  subscriptionId: string;

  /**
   * Arc resource group name
   */
  resourceGroupName: string;

  /**
   * Arc resource Name
   */
  resourceName: string;

  /**
   * Arc resource location
   */
  resourceLocation: string;

  /**
   * Arc resource version
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Host OS supported by the Arc addon.
   */
  @visibility(Lifecycle.Read)
  hostPlatform?: PlatformType;

  /**
   * Platform where the runtime is hosted.
   */
  @visibility(Lifecycle.Read)
  hostPlatformType?: HostPlatformType;

  /**
   * Addon Provisioning State
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AddonState;
}

/**
 * Authentication mechanism for IoT devices.
 */
model Authentication {
  /**
   * Symmetric key for authentication.
   */
  symmetricKey?: SymmetricKey;
}

/**
 * Symmetric key for authentication.
 */
model SymmetricKey {
  /**
   * Connection string based on the symmetric key.
   */
  connectionString?: AsymmetricEncryptedSecret;
}

/**
 * The preview of Virtual Machine Cloud Management from the Azure supports deploying and managing VMs on your Azure Stack Edge device from Azure Portal.
 * For more information, refer to: https://docs.microsoft.com/en-us/azure/databox-online/azure-stack-edge-gpu-virtual-machine-overview
 * By using this feature, you agree to the preview legal terms. See the https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/ for additional details.
 */
model CloudEdgeManagementRole extends Role {
  /**
   * Properties specific to CloudEdgeManagementRole role.
   */
  properties?: CloudEdgeManagementRoleProperties;

  /**
   * Role type.
   */
  kind: "CloudEdgeManagement";
}

/**
 * CloudEdgeManagement Role properties.
 */
model CloudEdgeManagementRoleProperties {
  /**
   * Local Edge Management Status
   */
  @visibility(Lifecycle.Read)
  localManagementStatus?: RoleStatus;

  /**
   * Edge Profile of the resource
   */
  @visibility(Lifecycle.Read)
  edgeProfile?: EdgeProfile;

  /**
   * Role status.
   */
  roleStatus: RoleStatus;
}

/**
 * Cni configuration
 */
model CniConfig {
  /**
   * Cni type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Cni version
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Pod Subnet
   */
  @visibility(Lifecycle.Read)
  podSubnet?: string;

  /**
   * Service subnet
   */
  @visibility(Lifecycle.Read)
  serviceSubnet?: string;
}

/**
 * Compute infrastructure Resource
 */
model ComputeResource {
  /**
   * Processor count
   */
  processorCount: int32;

  /**
   * Memory in GB
   */
  memoryInGB: int64;
}

/**
 * Resource Move details
 */
model DataBoxEdgeMoveRequest {
  /**
   * Target resource group ARMId
   */
  targetResourceGroup: string;

  /**
   * List of resources to be moved
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  resources: string[];
}

/**
 * Etcd configuration
 */
model EtcdInfo {
  /**
   * Etcd type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Etcd version
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * Trigger details.
 */
model FileEventTrigger extends Trigger {
  /**
   * File trigger properties.
   */
  properties: FileTriggerProperties;

  /**
   * Trigger Kind.
   */
  kind: "FileEvent";
}

/**
 * File trigger properties.
 */
model FileTriggerProperties {
  /**
   * File event source details.
   */
  sourceInfo: FileSourceInfo;

  /**
   * Role sink info.
   */
  sinkInfo: RoleSinkInfo;

  /**
   * A custom context tag typically used to correlate the trigger against its usage. For example, if a periodic timer trigger is intended for certain specific IoT modules in the device, the tag can be the name or the image URL of the module.
   */
  @maxLength(192)
  customContextTag?: string;
}

/**
 * File source details.
 */
model FileSourceInfo {
  /**
   * File share ID.
   */
  shareId: string;
}

/**
 * Compute role against which events will be raised.
 */
model RoleSinkInfo {
  /**
   * Compute role ID.
   */
  roleId: string;
}

/**
 * Image repository credential.
 */
model ImageRepositoryCredential {
  /**
   * Image repository url (e.g.: mcr.microsoft.com).
   */
  imageRepositoryUrl: string;

  /**
   * Repository user name.
   */
  userName: string;

  /**
   * Repository user password.
   */
  password?: AsymmetricEncryptedSecret;
}

/**
 * IoT Addon.
 */
model IoTAddon extends Addon {
  /**
   * Properties specific to IOT addon.
   */
  properties: IoTAddonProperties;

  /**
   * Addon type.
   */
  kind: "IotEdge";
}

/**
 * IoT addon properties.
 */
model IoTAddonProperties {
  /**
   * IoT device metadata to which appliance needs to be connected.
   */
  ioTDeviceDetails: IoTDeviceInfo;

  /**
   * IoT edge device to which the IoT Addon needs to be configured.
   */
  ioTEdgeDeviceDetails: IoTDeviceInfo;

  /**
   * Version of IoT running on the appliance.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Host OS supported by the IoT addon.
   */
  @visibility(Lifecycle.Read)
  hostPlatform?: PlatformType;

  /**
   * Platform where the runtime is hosted.
   */
  @visibility(Lifecycle.Read)
  hostPlatformType?: HostPlatformType;

  /**
   * Addon Provisioning State
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AddonState;
}

/**
 * Metadata of IoT device/IoT Edge device to be configured.
 */
model IoTDeviceInfo {
  /**
   * ID of the IoT device/edge device.
   */
  deviceId: string;

  /**
   * Host name for the IoT hub associated to the device.
   */
  ioTHostHub: string;

  /**
   * Id for the IoT hub associated to the device.
   */
  ioTHostHubId?: string;

  /**
   * Encrypted IoT device/IoT edge device connection string.
   */
  authentication?: Authentication;
}

/**
 * IoT edge agent details is optional, this will be used for download system Agent module while bootstrapping IoT Role if specified.
 */
model IoTEdgeAgentInfo {
  /**
   * Name of the IoT edge agent image.
   */
  imageName: string;

  /**
   * Image Tag.
   */
  tag: string;

  /**
   * Image repository details.
   */
  imageRepository?: ImageRepositoryCredential;
}

/**
 * Compute role.
 */
model IoTRole extends Role {
  /**
   * Properties specific to IoT role.
   */
  properties?: IoTRoleProperties;

  /**
   * Role type.
   */
  kind: "IOT";
}

/**
 * IoT role properties.
 */
model IoTRoleProperties {
  /**
   * Host OS supported by the IoT role.
   */
  hostPlatform: PlatformType;

  /**
   * IoT device metadata to which data box edge device needs to be connected.
   */
  ioTDeviceDetails: IoTDeviceInfo;

  /**
   * IoT edge device to which the IoT role needs to be configured.
   */
  ioTEdgeDeviceDetails: IoTDeviceInfo;

  /**
   * Mount points of shares in role(s).
   */
  @OpenAPI.extension("x-ms-identifiers", #["shareId"])
  shareMappings?: MountPointMap[];

  /**
   * Iot edge agent details to download the agent and bootstrap iot runtime.
   */
  ioTEdgeAgentInfo?: IoTEdgeAgentInfo;

  /**
   * Platform where the Iot runtime is hosted.
   */
  @visibility(Lifecycle.Read)
  hostPlatformType?: HostPlatformType;

  /**
   * Resource allocation
   */
  computeResource?: ComputeResource;

  /**
   * Role status.
   */
  roleStatus: RoleStatus;
}

/**
 * Kubernetes cluster configuration
 */
model KubernetesClusterInfo {
  /**
   * Etcd configuration
   */
  @visibility(Lifecycle.Read)
  etcdInfo?: EtcdInfo;

  /**
   * Kubernetes cluster nodes
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name", "type"])
  nodes?: NodeInfo[];

  /**
   * Kubernetes cluster version
   */
  version: string;
}

/**
 * Kubernetes node info
 */
model NodeInfo {
  /**
   * Node name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Node type - Master/Worker
   */
  @visibility(Lifecycle.Read)
  type?: KubernetesNodeType;

  /**
   * IP Configuration of the Kubernetes node.
   */
  @OpenAPI.extension("x-ms-identifiers", #["ipAddress", "port"])
  ipConfiguration?: KubernetesIPConfiguration[];
}

/**
 * Kubernetes node IP configuration
 */
model KubernetesIPConfiguration {
  /**
   * Port of the Kubernetes node.
   */
  @visibility(Lifecycle.Read)
  port?: string;

  /**
   * IP address of the Kubernetes node.
   */
  ipAddress?: string;
}

/**
 * The limited preview of Kubernetes Cluster Management from the Azure supports:
 * 1. Using a simple turn-key option in Azure Portal, deploy a Kubernetes cluster on your Azure Stack Edge device.
 * 2. Configure Kubernetes cluster running on your device with Arc enabled Kubernetes with a click of a button in the Azure Portal.
 *  Azure Arc enables organizations to view, manage, and govern their on-premises Kubernetes clusters using the Azure Portal, command line tools, and APIs.
 * 3. Easily configure Persistent Volumes using SMB and NFS shares for storing container data.
 *  For more information, refer to the document here: https://databoxupdatepackages.blob.core.windows.net/documentation/Microsoft-Azure-Stack-Edge-K8-Cloud-Management-20210323.pdf
 *  Or Demo: https://databoxupdatepackages.blob.core.windows.net/documentation/Microsoft-Azure-Stack-Edge-K8S-Cloud-Management-20210323.mp4
 *  By using this feature, you agree to the preview legal terms. See the https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/
 */
model KubernetesRole extends Role {
  /**
   * Properties specific to Kubernetes role.
   */
  properties?: KubernetesRoleProperties;

  /**
   * Role type.
   */
  kind: "Kubernetes";
}

/**
 * Kubernetes role properties.
 */
model KubernetesRoleProperties {
  /**
   * Host OS supported by the Kubernetes role.
   */
  hostPlatform: PlatformType;

  /**
   * State of Kubernetes deployment
   */
  @visibility(Lifecycle.Read)
  provisioningState?: KubernetesState;

  /**
   * Platform where the runtime is hosted.
   */
  @visibility(Lifecycle.Read)
  hostPlatformType?: HostPlatformType;

  /**
   * Kubernetes cluster configuration
   */
  kubernetesClusterInfo: KubernetesClusterInfo;

  /**
   * Kubernetes role resources
   */
  kubernetesRoleResources: KubernetesRoleResources;

  /**
   * Role status.
   */
  roleStatus: RoleStatus;
}

/**
 * Kubernetes role resources
 */
model KubernetesRoleResources {
  /**
   * Kubernetes role storage resource
   */
  storage?: KubernetesRoleStorage;

  /**
   * Kubernetes role compute resource
   */
  compute: KubernetesRoleCompute;

  /**
   * Kubernetes role network resource
   */
  @visibility(Lifecycle.Read)
  network?: KubernetesRoleNetwork;
}

/**
 * Kubernetes role storage resource
 */
model KubernetesRoleStorage {
  /**
   * Kubernetes storage class info.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name", "type"])
  storageClasses?: KubernetesRoleStorageClassInfo[];

  /**
   * Mount points of shares in role(s).
   */
  @OpenAPI.extension("x-ms-identifiers", #["shareId"])
  endpoints?: MountPointMap[];
}

/**
 * Kubernetes storage class info.
 */
model KubernetesRoleStorageClassInfo {
  /**
   * Storage class name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Storage class type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * If provisioned storage is posix compliant.
   */
  @visibility(Lifecycle.Read)
  posixCompliant?: PosixComplianceStatus;
}

/**
 * Kubernetes role compute resource
 */
model KubernetesRoleCompute {
  /**
   * VM profile
   */
  vmProfile: string;

  /**
   * Memory in bytes
   */
  @visibility(Lifecycle.Read)
  memoryInBytes?: int64;

  /**
   * Processor count
   */
  @visibility(Lifecycle.Read)
  processorCount?: int32;
}

/**
 * Kubernetes role network resource
 */
model KubernetesRoleNetwork {
  /**
   * Cni configuration
   */
  @visibility(Lifecycle.Read)
  cniConfig?: CniConfig;

  /**
   * Load balancer configuration
   */
  @visibility(Lifecycle.Read)
  loadBalancerConfig?: LoadBalancerConfig;
}

/**
 * Load balancer configuration
 */
model LoadBalancerConfig {
  /**
   * Load balancer type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Load balancer version
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Load balancer ipconfig
   */
  ipRange?: string[];
}

/**
 * MEC role.
 */
model MECRole extends Role {
  /**
   * Properties specific to MEC role.
   */
  properties?: MECRoleProperties;

  /**
   * Role type.
   */
  kind: "MEC";
}

/**
 * MEC role properties.
 */
model MECRoleProperties {
  /**
   * Activation key of the MEC.
   */
  connectionString?: AsymmetricEncryptedSecret;

  /**
   * Controller Endpoint.
   */
  controllerEndpoint?: string;

  /**
   * Unique Id of the Resource.
   */
  resourceUniqueId?: string;

  /**
   * Role status.
   */
  roleStatus: RoleStatus;
}

/**
 * Trigger details.
 */
model PeriodicTimerEventTrigger extends Trigger {
  /**
   * Periodic timer trigger properties.
   */
  properties: PeriodicTimerProperties;

  /**
   * Trigger Kind.
   */
  kind: "PeriodicTimerEvent";
}

/**
 * Periodic timer trigger properties.
 */
model PeriodicTimerProperties {
  /**
   * Periodic timer details.
   */
  sourceInfo: PeriodicTimerSourceInfo;

  /**
   * Role Sink information.
   */
  sinkInfo: RoleSinkInfo;

  /**
   * A custom context tag typically used to correlate the trigger against its usage. For example, if a periodic timer trigger is intended for certain specific IoT modules in the device, the tag can be the name or the image URL of the module.
   */
  @maxLength(192)
  customContextTag?: string;
}

/**
 * Periodic timer event source.
 */
model PeriodicTimerSourceInfo {
  /**
   * The time of the day that results in a valid trigger. Schedule is computed with reference to the time specified upto seconds. If timezone is not specified the time will considered to be in device timezone. The value will always be returned as UTC time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  /**
   * Periodic frequency at which timer event needs to be raised. Supports daily, hourly, minutes, and seconds.
   */
  schedule: string;

  /**
   * Topic where periodic events are published to IoT device.
   */
  topic?: string;
}
