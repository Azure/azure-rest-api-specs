import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataBox;

/**
 * Name of the stage which is in progress.
 */
union StageName {
  string,

  /**
   * An order has been created.
   */
  DeviceOrdered: "DeviceOrdered",

  /**
   * A device has been prepared for the order.
   */
  DevicePrepared: "DevicePrepared",

  /**
   * Device has been dispatched to the user of the order.
   */
  Dispatched: "Dispatched",

  /**
   * Device has been delivered to the user of the order.
   */
  Delivered: "Delivered",

  /**
   * Device has been picked up from user and in transit to Azure datacenter.
   */
  PickedUp: "PickedUp",

  /**
   * Device has been received at Azure datacenter from the user.
   */
  AtAzureDC: "AtAzureDC",

  /**
   * Data copy from the device at Azure datacenter.
   */
  DataCopy: "DataCopy",

  /**
   * Order has completed.
   */
  Completed: "Completed",

  /**
   * Order has completed with errors.
   */
  CompletedWithErrors: "CompletedWithErrors",

  /**
   * Order has been cancelled.
   */
  Cancelled: "Cancelled",

  /**
   * Order has failed due to issue reported by user.
   */
  Failed_IssueReportedAtCustomer: "Failed_IssueReportedAtCustomer",

  /**
   * Order has failed due to issue detected at Azure datacenter.
   */
  Failed_IssueDetectedAtAzureDC: "Failed_IssueDetectedAtAzureDC",

  /**
   * Order has been aborted.
   */
  Aborted: "Aborted",

  /**
   * Order has completed with warnings.
   */
  CompletedWithWarnings: "CompletedWithWarnings",

  /**
   * Device is ready to be handed to customer from Azure DC.
   */
  ReadyToDispatchFromAzureDC: "ReadyToDispatchFromAzureDC",

  /**
   * Device can be dropped off at Azure DC.
   */
  ReadyToReceiveAtAzureDC: "ReadyToReceiveAtAzureDC",

  /**
   * Job created by the customer.
   */
  Created: "Created",

  /**
   * User shipped the device to AzureDC.
   */
  ShippedToAzureDC: "ShippedToAzureDC",

  /**
   * Awaiting shipment details of device from customer.
   */
  AwaitingShipmentDetails: "AwaitingShipmentDetails",

  /**
   * Preparing the device to ship to customer.
   */
  PreparingToShipFromAzureDC: "PreparingToShipFromAzureDC",

  /**
   * Shipped the device to customer.
   */
  ShippedToCustomer: "ShippedToCustomer",
}

/**
 * Status of notification
 */
union DelayNotificationStatus {
  string,

  /**
   * Delay is still active
   */
  Active: "Active",

  /**
   * Delay has been resolved
   */
  Resolved: "Resolved",
}

/**
 * Delay Error code
 */
union PortalDelayErrorCode {
  string,

  /**
   * Delay due to any internal reasons
   */
  InternalIssueDelay: "InternalIssueDelay",

  /**
   * Active Order limit breached.
   */
  ActiveOrderLimitBreachedDelay: "ActiveOrderLimitBreachedDelay",

  /**
   * High demand
   */
  HighDemandDelay: "HighDemandDelay",

  /**
   * Slow copy due to large number of files
   */
  LargeNumberOfFilesDelay: "LargeNumberOfFilesDelay",
}

/**
 * Name of the stage.
 */
union NotificationStageName {
  string,

  /**
   * Notification at device prepared stage.
   */
  DevicePrepared: "DevicePrepared",

  /**
   * Notification at device dispatched stage.
   */
  Dispatched: "Dispatched",

  /**
   * Notification at device delivered stage.
   */
  Delivered: "Delivered",

  /**
   * Notification at device picked up from user stage.
   */
  PickedUp: "PickedUp",

  /**
   * Notification at device received at Azure datacenter stage.
   */
  AtAzureDC: "AtAzureDC",

  /**
   * Notification at data copy started stage.
   */
  DataCopy: "DataCopy",

  /**
   * Notification at job created stage.
   */
  Created: "Created",

  /**
   * Notification at shipped devices to customer stage.
   */
  ShippedToCustomer: "ShippedToCustomer",
}

/**
 * DataCenter code.
 */
union DataCenterCode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BY2: "BY2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BY1: "BY1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ORK70: "ORK70",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AM2: "AM2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AMS20: "AMS20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BY21: "BY21",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BY24: "BY24",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MWH01: "MWH01",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AMS06: "AMS06",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SSE90: "SSE90",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SYD03: "SYD03",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SYD23: "SYD23",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CBR20: "CBR20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  YTO20: "YTO20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CWL20: "CWL20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LON24: "LON24",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BOM01: "BOM01",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BL20: "BL20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BL7: "BL7",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SEL20: "SEL20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TYO01: "TYO01",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BN1: "BN1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SN5: "SN5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CYS04: "CYS04",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TYO22: "TYO22",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  YTO21: "YTO21",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  YQB20: "YQB20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FRA22: "FRA22",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MAA01: "MAA01",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CPQ02: "CPQ02",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CPQ20: "CPQ20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SIN20: "SIN20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HKG20: "HKG20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SG2: "SG2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MEL23: "MEL23",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SEL21: "SEL21",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OSA20: "OSA20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SHA03: "SHA03",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BJB: "BJB",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  JNB22: "JNB22",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  JNB21: "JNB21",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MNZ21: "MNZ21",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SN8: "SN8",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AUH20: "AUH20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ZRH20: "ZRH20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PUS20: "PUS20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AdHoc: "AdHoc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CH1: "CH1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DSM05: "DSM05",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DUB07: "DUB07",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PNQ01: "PNQ01",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SVG20: "SVG20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OSA02: "OSA02",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OSA22: "OSA22",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PAR22: "PAR22",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BN7: "BN7",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SN6: "SN6",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BJS20: "BJS20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BL24: "BL24",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IDC5: "IDC5",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TYO23: "TYO23",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NTG20: "NTG20",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DXB23: "DXB23",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DSM11: "DSM11",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AMS25: "AMS25",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CPQ21: "CPQ21",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OSA23: "OSA23",
}

/**
 * The Status of the copy
 */
union CopyStatus {
  string,

  /**
   * Data copy hasn't started yet.
   */
  NotStarted: "NotStarted",

  /**
   * Data copy is in progress.
   */
  InProgress: "InProgress",

  /**
   * Data copy completed.
   */
  Completed: "Completed",

  /**
   * Data copy completed with errors.
   */
  CompletedWithErrors: "CompletedWithErrors",

  /**
   * Data copy failed. No data was copied.
   */
  Failed: "Failed",

  /**
   * No copy triggered as device was not returned.
   */
  NotReturned: "NotReturned",

  /**
   * The Device has hit hardware issues.
   */
  HardwareError: "HardwareError",

  /**
   * Data copy failed. The Device was formatted by user.
   */
  DeviceFormatted: "DeviceFormatted",

  /**
   * Data copy failed. Device metadata was modified by user.
   */
  DeviceMetadataModified: "DeviceMetadataModified",

  /**
   * Data copy failed. Storage Account was not accessible during copy.
   */
  StorageAccountNotAccessible: "StorageAccountNotAccessible",

  /**
   * Data copy failed. The Device data content is not supported.
   */
  UnsupportedData: "UnsupportedData",

  /**
   * No copy triggered as device was not received.
   */
  DriveNotReceived: "DriveNotReceived",

  /**
   * No copy triggered as device type is not supported.
   */
  UnsupportedDrive: "UnsupportedDrive",

  /**
   * Copy failed due to service error.
   */
  OtherServiceError: "OtherServiceError",

  /**
   * Copy failed due to user error.
   */
  OtherUserError: "OtherUserError",

  /**
   * Copy failed due to disk detection error.
   */
  DriveNotDetected: "DriveNotDetected",

  /**
   * Copy failed due to corrupted drive.
   */
  DriveCorrupted: "DriveCorrupted",

  /**
   * Copy failed due to modified or removed metadata files.
   */
  MetadataFilesModifiedOrRemoved: "MetadataFilesModifiedOrRemoved",
}

/**
 * Type of the transfer.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum TransferType {
  /**
   * Import data to azure.
   */
  ImportToAzure,

  /**
   * Export data from azure.
   */
  ExportFromAzure,
}

/**
 * The Editable status for Reverse Shipping Address and Contact Info
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ReverseShippingDetailsEditStatus {
  /**
   * Reverse shipping details can be edited.
   */
  Enabled,

  /**
   * Edit is disabled for Reverse shipping details.
   */
  Disabled,

  /**
   * Edit is not supported for Reverse shipping details. Either subscription feature is not available or SKU doesn't support this feature.
   */
  NotSupported,
}

/**
 * The Editable status for Reverse Transport preferences
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ReverseTransportPreferenceEditStatus {
  /**
   * Reverse Transport Preferences can be edited.
   */
  Enabled,

  /**
   * Edit is disabled for Reverse Transport Preferences.
   */
  Disabled,

  /**
   * Edit is not supported for Reverse Transport Preferences. Either subscription feature is not available or SKU doesn't support this feature.
   */
  NotSupported,
}

/**
 * Holds the device erasure completion status
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum StageStatus {
  /**
   * No status available yet.
   */
  None,

  /**
   * Stage is in progress.
   */
  InProgress,

  /**
   * Stage has succeeded.
   */
  Succeeded,

  /**
   * Stage has failed.
   */
  Failed,

  /**
   * Stage has been cancelled.
   */
  Cancelled,

  /**
   * Stage is cancelling.
   */
  Cancelling,

  /**
   * Stage has succeeded with errors.
   */
  SucceededWithErrors,

  /**
   * Stage is stuck until customer takes some action.
   */
  WaitingForCustomerAction,

  /**
   * Stage has succeeded with warnings.
   */
  SucceededWithWarnings,

  /**
   * Stage is waiting for customer action for kek action items.
   */
  WaitingForCustomerActionForKek,

  /**
   * Stage is waiting for customer action for clean up.
   */
  WaitingForCustomerActionForCleanUp,

  /**
   * Stage has performed customer action for clean up.
   */
  CustomerActionPerformedForCleanUp,

  /**
   * Stage has performed customer action for clean up.
   */
  CustomerActionPerformed,
}

/**
 * Type of address.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AddressType {
  /**
   * Address type not known.
   */
  None,

  /**
   * Residential Address.
   */
  Residential,

  /**
   * Commercial Address.
   */
  Commercial,
}

/**
 * Type of the account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DataAccountType {
  /**
   * Storage Accounts .
   */
  StorageAccount,

  /**
   * Azure Managed disk storage.
   */
  ManagedDisk,
}

/**
 * Level of the logs to be collected.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum LogCollectionLevel {
  /**
   * Only Errors will be collected in the logs.
   */
  Error,

  /**
   * Verbose logging (includes Errors, CRC, size information and others).
   */
  Verbose,
}

/**
 * Type of the configuration for transfer.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum TransferConfigurationType {
  /**
   * Transfer all the data.
   */
  TransferAll,

  /**
   * Transfer using filter.
   */
  TransferUsingFilter,
}

/**
 * Type of the filter file.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum FilterFileType {
  /**
   * Filter file is of the type AzureBlob.
   */
  AzureBlob,

  /**
   * Filter file is of the type AzureFiles.
   */
  AzureFile,
}

/**
 * Indicates the type of job details.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ClassDiscriminator {
  /**
   * Data Box orders.
   */
  DataBox,

  /**
   * Data Box Disk orders.
   */
  DataBoxDisk,

  /**
   * Data Box Heavy orders.
   */
  DataBoxHeavy,

  /**
   * Data Box Customer Disk orders.
   */
  DataBoxCustomerDisk,
}

/**
 * Transport Shipment Type supported for given region.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum TransportShipmentTypes {
  /**
   * Shipment Logistics is handled by the customer.
   */
  CustomerManaged,

  /**
   * Shipment Logistics is handled by Microsoft.
   */
  MicrosoftManaged,
}

/**
 * Defines secondary layer of software-based encryption enablement.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DoubleEncryption {
  /**
   * Software-based encryption is enabled.
   */
  Enabled,

  /**
   * Software-based encryption is disabled.
   */
  Disabled,
}

/**
 * Hardware encryption support for a given sku for a given region.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum HardwareEncryption {
  /**
   * Hardware-based encryption is enabled.
   */
  Enabled,

  /**
   * Hardware-based encryption is disabled.
   */
  Disabled,
}

/**
 * Type of encryption key used for key encryption.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KekType {
  /**
   * Key encryption key is managed by Microsoft.
   */
  MicrosoftManaged,

  /**
   * Key encryption key is managed by the Customer.
   */
  CustomerManaged,
}

/**
 * Resolution code provided by customer.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum CustomerResolutionCode {
  /**
   * No Resolution Yet
   */
  None,

  /**
   * Clean the device
   */
  MoveToCleanUpDevice,

  /**
   * Resume the job to same stage
   */
  Resume,

  /**
   * Restart whole action.
   */
  Restart,

  /**
   * Reach out to operation for further action.
   */
  ReachOutToOperation,
}

/**
 * Data center address type
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DatacenterAddressType {
  /**
   * Data center address location.
   */
  DatacenterAddressLocation,

  /**
   * Data center address instruction.
   */
  DatacenterAddressInstruction,
}

/**
 * Delivery type of Job.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum JobDeliveryType {
  /**
   * Non Scheduled job.
   */
  NonScheduled,

  /**
   * Scheduled job.
   */
  Scheduled,
}

/**
 * SKU names.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SkuName {
  /**
   * Data Box.
   */
  DataBox,

  /**
   * Data Box Disk.
   */
  DataBoxDisk,

  /**
   * Data Box Heavy.
   */
  DataBoxHeavy,

  /**
   * Data Box Customer Disk
   */
  DataBoxCustomerDisk,
}

/**
 * The customer friendly name of the combination of version and capacity of the device. This field is necessary only at the time of ordering the newer generation device i.e. AzureDataBox120 and AzureDataBox525 as of Feb/2025
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ModelName {
  /**
   * Data Box.
   */
  DataBox,

  /**
   * Data Box Disk.
   */
  DataBoxDisk,

  /**
   * Data Box Heavy.
   */
  DataBoxHeavy,

  /**
   * Data Box Customer Disk
   */
  DataBoxCustomerDisk,

  /**
   * Data Box V2 with 120TB usable capacity.
   */
  AzureDataBox120,

  /**
   * Data Box V2 with 525TB usable capacity.
   */
  AzureDataBox525,
}

/**
 * Identifies the type of validation request.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ValidationInputDiscriminator {
  /**
   * Identify request and response of address validation.
   */
  ValidateAddress,

  /**
   * Identify request and response for validation of subscription permission to create job.
   */
  ValidateSubscriptionIsAllowedToCreateJob,

  /**
   * Identify request and response of preference validation.
   */
  ValidatePreferences,

  /**
   * Identify request and response of create order limit for subscription validation.
   */
  ValidateCreateOrderLimit,

  /**
   * Identify request and response of active job limit for sku availability.
   */
  ValidateSkuAvailability,

  /**
   * Identify request and response of data transfer details validation.
   */
  ValidateDataTransferDetails,
}

/**
 * The address validation status.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AddressValidationStatus {
  /**
   * Address provided is valid.
   */
  Valid,

  /**
   * Address provided is invalid or not supported.
   */
  Invalid,

  /**
   * Address provided is ambiguous, please choose one of the alternate addresses returned.
   */
  Ambiguous,
}

/**
 * Overall validation status.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum OverallValidationStatus {
  /**
   * Every input request is valid.
   */
  AllValidToProceed,

  /**
   * Some input requests are not valid.
   */
  InputsRevisitRequired,

  /**
   * Certain input validations skipped.
   */
  CertainInputValidationsSkipped,
}

/**
 * Reason why the Sku is disabled.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SkuDisabledReason {
  /**
   * SKU is not disabled.
   */
  None,

  /**
   * SKU is not available in the requested country.
   */
  Country,

  /**
   * SKU is not available to push data to the requested Azure region.
   */
  Region,

  /**
   * Required features are not enabled for the SKU.
   */
  Feature,

  /**
   * Subscription does not have required offer types for the SKU.
   */
  OfferType,

  /**
   * Subscription has not registered to Microsoft.DataBox and Service does not have the subscription notification.
   */
  NoSubscriptionInfo,
}

/**
 * Type of the share.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ShareDestinationFormatType {
  /**
   * Unknown format.
   */
  UnknownType,

  /**
   * Storsimple data format.
   */
  HCS,

  /**
   * Azure storage block blob format.
   */
  BlockBlob,

  /**
   * Azure storage page blob format.
   */
  PageBlob,

  /**
   * Azure storage file format.
   */
  AzureFile,

  /**
   * Azure Compute Disk.
   */
  ManagedDisk,
}

/**
 * Access protocols supported on the device.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AccessProtocol {
  /**
   * Server Message Block protocol(SMB).
   */
  SMB,

  /**
   * Network File System protocol(NFS).
   */
  NFS,
}

/**
 * Create order limit validation status.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ValidationStatus {
  /**
   * Validation is successful
   */
  Valid,

  /**
   * Validation is not successful
   */
  Invalid,

  /**
   * Validation is skipped
   */
  Skipped,
}

/**
 * Job Resource Collection
 */
model JobResourceList is Azure.Core.Page<JobResource>;

/**
 * Job Properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JobProperties {
  /**
   * Type of the data transfer.
   */
  transferType: TransferType;

  /**
   * Describes whether the job is cancellable or not.
   */
  @visibility(Lifecycle.Read)
  isCancellable?: boolean;

  /**
   * Describes whether the job is deletable or not.
   */
  @visibility(Lifecycle.Read)
  isDeletable?: boolean;

  /**
   * Describes whether the shipping address is editable or not.
   */
  @visibility(Lifecycle.Read)
  isShippingAddressEditable?: boolean;

  /**
   * The Editable status for Reverse Shipping Address and Contact Info
   */
  @visibility(Lifecycle.Read)
  reverseShippingDetailsUpdate?: ReverseShippingDetailsEditStatus;

  /**
   * The Editable status for Reverse Transport preferences
   */
  @visibility(Lifecycle.Read)
  reverseTransportPreferenceUpdate?: ReverseTransportPreferenceEditStatus;

  /**
   * Is Prepare To Ship Enabled on this job
   */
  @visibility(Lifecycle.Read)
  isPrepareToShipEnabled?: boolean;

  /**
   * Name of the stage which is in progress.
   */
  @visibility(Lifecycle.Read)
  status?: StageName;

  /**
   * Name of the stage where delay might be present.
   */
  @visibility(Lifecycle.Read)
  delayedStage?: StageName;

  /**
   * Time at which the job was started in UTC ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Top level error for the job.
   */
  @visibility(Lifecycle.Read)
  error?: CloudError;

  /**
   * Details of a job run. This field will only be sent for expand details filter.
   */
  details?: JobDetails;

  /**
   * Reason for cancellation.
   */
  @visibility(Lifecycle.Read)
  cancellationReason?: string;

  /**
   * Delivery type of Job.
   */
  deliveryType?: JobDeliveryType = JobDeliveryType.NonScheduled;

  /**
   * Delivery Info of Job.
   */
  deliveryInfo?: JobDeliveryInfo;

  /**
   * Flag to indicate cancellation of scheduled job.
   */
  @visibility(Lifecycle.Read)
  isCancellableWithoutFee?: boolean;

  /**
   * Flag to indicate if all devices associated with the job are lost.
   */
  @visibility(Lifecycle.Read)
  allDevicesLost?: boolean;
}

/**
 * Provides additional information about an http error response.
 */
model CloudError {
  /**
   * Gets or sets additional error info.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  additionalInfo?: AdditionalErrorInfo[];

  /**
   * Error code.
   */
  code?: string;

  /**
   * Gets or sets details for the error.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  details?: CloudError[];

  /**
   * The error message parsed from the body of the http error response.
   */
  message?: string;

  /**
   * Gets or sets the target of the error.
   */
  target?: string;
}

/**
 * This class represents additional info which Resource Providers pass when an error occurs.
 */
model AdditionalErrorInfo {
  /**
   * Additional information of the type of error.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  info?: Record<unknown>;

  /**
   * Type of error (e.g. CustomerIntervention, PolicyViolation, SecurityViolation).
   */
  type?: string;
}

/**
 * Job details.
 */
@discriminator("jobDetailsType")
model JobDetails {
  /**
   * List of stages that run in the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  jobStages?: JobStages[];

  /**
   * Contact details for notification and shipping.
   */
  contactDetails: ContactDetails;

  /**
   * Shipping address of the customer.
   */
  shippingAddress?: ShippingAddress;

  /**
   * Delivery package shipping details.
   */
  @visibility(Lifecycle.Read)
  deliveryPackage?: PackageShippingDetails;

  /**
   * Return package shipping details.
   */
  @visibility(Lifecycle.Read)
  returnPackage?: PackageShippingDetails;

  /**
   * Details of the data to be imported into azure.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataImportDetails?: DataImportDetails[];

  /**
   * Details of the data to be exported from azure.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataExportDetails?: DataExportDetails[];

  /**
   * Indicates the type of job details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  jobDetailsType: ClassDiscriminator;

  /**
   * Preferences for the order.
   */
  preferences?: Preferences;

  /**
   * Optional Reverse Shipping details for order.
   */
  reverseShippingDetails?: ReverseShippingDetails;

  /**
   * List of copy log details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  copyLogDetails?: CopyLogDetails[];

  /**
   * Shared access key to download the return shipment label
   */
  @visibility(Lifecycle.Read)
  reverseShipmentLabelSasKey?: string;

  /**
   * Shared access key to download the chain of custody logs
   */
  @visibility(Lifecycle.Read)
  chainOfCustodySasKey?: string;

  /**
   * Holds device data erasure details
   */
  @visibility(Lifecycle.Read)
  deviceErasureDetails?: DeviceErasureDetails;

  /**
   * Details about which key encryption type is being used.
   */
  keyEncryptionKey?: KeyEncryptionKey;

  /**
   * The expected size of the data, which needs to be transferred in this job, in terabytes.
   */
  expectedDataSizeInTeraBytes?: int32;

  /**
   * Available actions on the job.
   */
  @visibility(Lifecycle.Read)
  actions?: CustomerResolutionCode[];

  /**
   * Last mitigation action performed on the job.
   */
  @visibility(Lifecycle.Read)
  lastMitigationActionOnJob?: LastMitigationActionOnJob;

  /**
   * Datacenter address to ship to, for the given sku and storage location.
   */
  @visibility(Lifecycle.Read)
  datacenterAddress?: DatacenterAddressResponse;

  /**
   * DataCenter code.
   */
  @visibility(Lifecycle.Read)
  dataCenterCode?: DataCenterCode;
}

/**
 * Job stages.
 */
model JobStages {
  /**
   * Name of the job stage.
   */
  @visibility(Lifecycle.Read)
  stageName?: StageName;

  /**
   * Display name of the job stage.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Status of the job stage.
   */
  @visibility(Lifecycle.Read)
  stageStatus?: StageStatus;

  /**
   * Time for the job stage in UTC ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  stageTime?: utcDateTime;

  /**
   * Job Stage Details
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  jobStageDetails?: unknown;

  /**
   * Delay information for the job stages.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  delayInformation?: JobDelayDetails[];
}

/**
 * Job Delay Notification details
 */
model JobDelayDetails {
  /**
   * Status of notification
   */
  @visibility(Lifecycle.Read)
  status?: DelayNotificationStatus;

  /**
   * Delay Error code
   */
  @visibility(Lifecycle.Read)
  errorCode?: PortalDelayErrorCode;

  /**
   * Description of the delay.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Timestamp when the delay notification was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Timestamp when the delay notification was resolved.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resolutionTime?: utcDateTime;
}

/**
 * Contact Details.
 */
model ContactDetails {
  /**
   * Contact name of the person.
   */
  contactName: string;

  /**
   * Phone number of the contact person.
   */
  phone: string;

  /**
   * Phone extension number of the contact person.
   */
  phoneExtension?: string;

  /**
   * Mobile number of the contact person.
   */
  mobile?: string;

  /**
   * List of Email-ids to be notified about job progress.
   */
  emailList: string[];

  /**
   * Notification preference for a job stage.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  notificationPreference?: NotificationPreference[];
}

/**
 * Notification preference for a job stage.
 */
model NotificationPreference {
  /**
   * Name of the stage.
   */
  stageName: NotificationStageName;

  /**
   * Notification is required or not.
   */
  sendNotification: boolean = true;
}

/**
 * Shipping address where customer wishes to receive the device.
 */
model ShippingAddress {
  /**
   * Street Address line 1.
   */
  streetAddress1: string;

  /**
   * Street Address line 2.
   */
  streetAddress2?: string;

  /**
   * Street Address line 3.
   */
  streetAddress3?: string;

  /**
   * Name of the City.
   */
  city?: string;

  /**
   * Name of the State or Province.
   */
  stateOrProvince?: string;

  /**
   * Name of the Country.
   */
  country: string;

  /**
   * Postal code.
   */
  postalCode?: string;

  /**
   * Extended Zip Code.
   */
  zipExtendedCode?: string;

  /**
   * Name of the company.
   */
  companyName?: string;

  /**
   * Type of address.
   */
  addressType?: AddressType = AddressType.None;

  /**
   * Flag to indicate if customer has chosen to skip default address validation
   */
  skipAddressValidation?: boolean;

  /**
   * Tax Identification Number
   */
  taxIdentificationNumber?: string;
}

/**
 * package shipping details
 */
model PackageShippingDetails {
  /**
   * Url where shipment can be tracked.
   */
  @visibility(Lifecycle.Read)
  trackingUrl?: string;

  /**
   * Name of the carrier.
   */
  @visibility(Lifecycle.Read)
  carrierName?: string;

  /**
   * Tracking Id of shipment.
   */
  @visibility(Lifecycle.Read)
  trackingId?: string;
}

/**
 * Details of the data to be used for importing data to azure.
 */
model DataImportDetails {
  /**
   * Account details of the data to be transferred
   */
  accountDetails: DataAccountDetails;

  /**
   * Level of the logs to be collected.
   */
  logCollectionLevel?: LogCollectionLevel = LogCollectionLevel.Error;
}

/**
 * Account details of the data to be transferred
 */
@discriminator("dataAccountType")
model DataAccountDetails {
  /**
   * Account Type of the data to be transferred.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataAccountType: DataAccountType = DataAccountType.StorageAccount;

  @doc("Password for all the shares to be created on the device. Should not be passed for TransferType:ExportFromAzure jobs. If this is not passed, the service will generate password itself. This will not be returned in Get Call. Password Requirements :  Password must be minimum of 12 and maximum of 64 characters. Password must have at least one uppercase alphabet, one number and one special character. Password cannot have the following characters : IilLoO0 Password can have only alphabets, numbers and these characters : @#\\-$%^!+=;:_()]+")
  @visibility(Lifecycle.Create)
  @secret
  sharePassword?: string;
}

/**
 * Details of the data to be used for exporting data from azure.
 */
model DataExportDetails {
  /**
   * Configuration for the data transfer.
   */
  transferConfiguration: TransferConfiguration;

  /**
   * Level of the logs to be collected.
   */
  logCollectionLevel?: LogCollectionLevel = LogCollectionLevel.Error;

  /**
   * Account details of the data to be transferred
   */
  accountDetails: DataAccountDetails;
}

/**
 * Configuration for defining the transfer of data.
 */
model TransferConfiguration {
  /**
   * Type of the configuration for transfer.
   */
  transferConfigurationType: TransferConfigurationType;

  /**
   * Map of filter type and the details to filter. This field is required only if the TransferConfigurationType is given as TransferUsingFilter.
   */
  transferFilterDetails?: TransferConfigurationTransferFilterDetails;

  /**
   * Map of filter type and the details to transfer all data. This field is required only if the TransferConfigurationType is given as TransferAll
   */
  transferAllDetails?: TransferConfigurationTransferAllDetails;
}

/**
 * Map of filter type and the details to filter. This field is required only if the TransferConfigurationType is given as TransferUsingFilter.
 */
model TransferConfigurationTransferFilterDetails {
  /**
   * Details of the filtering the transfer of data.
   */
  include?: TransferFilterDetails;
}

/**
 * Details of the filtering the transfer of data.
 */
model TransferFilterDetails {
  /**
   * Type of the account of data.
   */
  dataAccountType: DataAccountType = DataAccountType.StorageAccount;

  /**
   * Filter details to transfer blobs.
   */
  blobFilterDetails?: BlobFilterDetails;

  /**
   * Filter details to transfer Azure files.
   */
  azureFileFilterDetails?: AzureFileFilterDetails;

  /**
   * Details of the filter files to be used for data transfer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  filterFileDetails?: FilterFileDetails[];
}

/**
 * Filter details to transfer Azure Blobs
 */
model BlobFilterDetails {
  /**
   * Prefix list of the Azure blobs to be transferred.
   */
  blobPrefixList?: string[];

  /**
   * List of full path of the blobs to be transferred.
   */
  blobPathList?: string[];

  /**
   * List of blob containers to be transferred.
   */
  containerList?: string[];
}

/**
 * Filter details to transfer Azure files
 */
model AzureFileFilterDetails {
  /**
   * Prefix list of the Azure files to be transferred.
   */
  filePrefixList?: string[];

  /**
   * List of full path of the files to be transferred.
   */
  filePathList?: string[];

  /**
   * List of file shares to be transferred.
   */
  fileShareList?: string[];
}

/**
 * Details of the filter files to be used for data transfer.
 */
model FilterFileDetails {
  /**
   * Type of the filter file.
   */
  filterFileType: FilterFileType;

  /**
   * Path of the file that contains the details of all items to transfer.
   */
  filterFilePath: string;
}

/**
 * Map of filter type and the details to transfer all data. This field is required only if the TransferConfigurationType is given as TransferAll
 */
model TransferConfigurationTransferAllDetails {
  /**
   * Details to transfer all data.
   */
  include?: TransferAllDetails;
}

/**
 * Details to transfer all data.
 */
model TransferAllDetails {
  /**
   * Type of the account of data
   */
  dataAccountType: DataAccountType = DataAccountType.StorageAccount;

  /**
   * To indicate if all Azure blobs have to be transferred
   */
  transferAllBlobs?: boolean;

  /**
   * To indicate if all Azure Files have to be transferred
   */
  transferAllFiles?: boolean;
}

/**
 * Preferences related to the order
 */
model Preferences {
  /**
   * Preferred data center region.
   */
  preferredDataCenterRegion?: string[];

  /**
   * Preferences related to the shipment logistics of the sku.
   */
  transportPreferences?: TransportPreferences;

  /**
   * Optional Preferences related to the reverse shipment logistics of the sku.
   */
  reverseTransportPreferences?: TransportPreferences;

  /**
   * Preferences related to the Encryption.
   */
  encryptionPreferences?: EncryptionPreferences;

  /**
   * Preferences related to the Access Tier of storage accounts.
   */
  storageAccountAccessTierPreferences?: "Archive"[]; // FIXME: `modelAsExtensible` is not supported anymore.
}

/**
 * Preferences related to the shipment logistics of the sku
 */
model TransportPreferences {
  /**
   * Indicates Shipment Logistics type that the customer preferred.
   */
  preferredShipmentType: TransportShipmentTypes;

  /**
   * Read only property which indicates whether transport preferences has been updated or not after device is prepared.
   */
  @visibility(Lifecycle.Read)
  isUpdated?: boolean;
}

/**
 * Preferences related to the Encryption.
 */
model EncryptionPreferences {
  /**
   * Defines secondary layer of software-based encryption enablement.
   */
  doubleEncryption?: DoubleEncryption = DoubleEncryption.Disabled;

  /**
   * Defines Hardware level encryption (Only for disk)
   */
  hardwareEncryption?: HardwareEncryption;
}

/**
 * Reverse Shipping Address and contact details for a job.
 */
model ReverseShippingDetails {
  /**
   * Contact Info.
   */
  contactDetails?: ContactInfo;

  /**
   * Shipping address where customer wishes to receive the device.
   */
  shippingAddress?: ShippingAddress;

  /**
   * A flag to indicate whether Reverse Shipping details are updated or not after device has been prepared.
   * Read only field
   */
  @visibility(Lifecycle.Read)
  isUpdated?: boolean;
}

/**
 * Contact Info.
 */
model ContactInfo {
  /**
   * Contact name of the person.
   */
  @minLength(1)
  contactName: string;

  /**
   * Phone number of the contact person.
   */
  @minLength(1)
  phone: string;

  /**
   * Phone extension number of the contact person.
   */
  phoneExtension?: string;

  /**
   * Mobile number of the contact person.
   */
  mobile?: string;
}

/**
 * Details for log generated during copy.
 */
@discriminator("copyLogDetailsType")
model CopyLogDetails {
  /**
   * Indicates the type of job details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  copyLogDetailsType: ClassDiscriminator;
}

/**
 * Device erasure details with erasure completion status, secure erasure sas key and erasureordestructionlog sas key
 */
model DeviceErasureDetails {
  /**
   * Holds the device erasure completion status
   */
  @visibility(Lifecycle.Read)
  deviceErasureStatus?: StageStatus;

  /**
   * Shared access key to download cleanup or destruction certificate for device
   */
  @visibility(Lifecycle.Read)
  erasureOrDestructionCertificateSasKey?: string;

  /**
   * Shared access key to download secure erasure certificate for the device
   */
  @visibility(Lifecycle.Read)
  secureErasureCertificateSasKey?: string;
}

/**
 * Encryption key containing details about key to encrypt different keys.
 */
model KeyEncryptionKey {
  /**
   * Type of encryption key used for key encryption.
   */
  kekType: KekType = KekType.MicrosoftManaged;

  /**
   * Managed identity properties used for key encryption.
   */
  identityProperties?: IdentityProperties;

  /**
   * Key encryption key. It is required in case of Customer managed KekType.
   */
  kekUrl?: string;

  /**
   * Kek vault resource id. It is required in case of Customer managed KekType.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kekVaultResourceID?: string;
}

/**
 * Managed identity properties.
 */
model IdentityProperties {
  /**
   * Managed service identity type.
   */
  type?: string;

  /**
   * User assigned identity properties.
   */
  userAssigned?: UserAssignedProperties;
}

/**
 * User assigned identity properties.
 */
model UserAssignedProperties {
  /**
   * Arm resource id for user assigned identity to be used to fetch MSI token.
   */
  resourceId?: string;
}

/**
 * Last Mitigation Action Performed On Job
 */
model LastMitigationActionOnJob {
  /**
   * Action performed date time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  actionDateTimeInUtc?: utcDateTime;

  /**
   * Action performed by customer,
   * possibility is that mitigation might happen by customer or service or by ops
   */
  isPerformedByCustomer?: boolean;

  /**
   * Resolution code provided by customer
   */
  customerResolution?: CustomerResolutionCode;
}

/**
 * Datacenter address for given storage location.
 */
@discriminator("datacenterAddressType")
model DatacenterAddressResponse {
  /**
   * Data center address type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  datacenterAddressType: DatacenterAddressType;

  /**
   * List of supported carriers for return shipment.
   */
  @visibility(Lifecycle.Read)
  supportedCarriersForReturnShipment?: string[];

  /**
   * Azure Location where the Data Center serves primarily.
   */
  @visibility(Lifecycle.Read)
  dataCenterAzureLocation?: string;
}

/**
 * Additional delivery info.
 */
model JobDeliveryInfo {
  /**
   * Scheduled date time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledDateTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Details {
  /**
   * Error code.
   */
  code: string;

  /**
   * Error message.
   */
  message: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ErrorDetail {
  /**
   * Error code.
   */
  code: string;

  /**
   * Error message.
   */
  message: string;

  /**
   * Error target.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  details?: Details[];

  /**
   * Additional error info.
   */
  target?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
model ApiError {
  /**
   * The error detail.
   */
  error: ErrorDetail;
}

/**
 * Request body to get the configuration for the region.
 */
model RegionConfigurationRequest {
  /**
   * Request body to get the availability for scheduling orders.
   */
  scheduleAvailabilityRequest?: ScheduleAvailabilityRequest;

  /**
   * Request body to get the transport availability for given sku.
   */
  transportAvailabilityRequest?: TransportAvailabilityRequest;

  /**
   * Request body to get the datacenter address for given sku.
   */
  datacenterAddressRequest?: DatacenterAddressRequest;

  /**
   * Request body to get the device capabilities for a given sku.
   */
  deviceCapabilityRequest?: DeviceCapabilityRequest;
}

/**
 * Request body to get the availability for scheduling orders.
 */
@discriminator("skuName")
model ScheduleAvailabilityRequest {
  /**
   * Location for data transfer. For locations check: https://management.azure.com/subscriptions/SUBSCRIPTIONID/locations?api-version=2018-01-01
   */
  storageLocation: string;

  /**
   * Sku Name for which the order is to be scheduled.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  skuName: SkuName;

  /**
   * Country in which storage location should be supported.
   */
  country?: string;

  /**
   * The customer friendly name of the combination of version and capacity of the device. This field is necessary only at the time of ordering the newer generation device i.e. AzureDataBox120 and AzureDataBox525 as of Feb/2025
   */
  `model`?: ModelName;
}

/**
 * Request body to get the transport availability for given sku.
 */
model TransportAvailabilityRequest {
  /**
   * Type of the device.
   */
  skuName?: SkuName;

  /**
   * The customer friendly name of the combination of version and capacity of the device. This field is necessary only at the time of ordering the newer generation device i.e. AzureDataBox120 and AzureDataBox525 as of Feb/2025
   */
  `model`?: ModelName;
}

/**
 * Request body to get the datacenter address.
 */
model DatacenterAddressRequest {
  /**
   * Storage location. For locations check: https://management.azure.com/subscriptions/SUBSCRIPTIONID/locations?api-version=2018-01-01
   */
  storageLocation: string;

  /**
   * Sku Name for which the data center address requested.
   */
  skuName: SkuName;

  /**
   * The customer friendly name of the combination of version and capacity of the device. This field is necessary only at the time of ordering the newer generation device i.e. AzureDataBox120 and AzureDataBox525 as of Feb/2025
   */
  `model`?: ModelName;
}

/**
 * Request body to get the device capabilities for given sku.
 */
model DeviceCapabilityRequest {
  /**
   * Type of the device.
   */
  skuName?: SkuName;

  /**
   * The customer friendly name of the combination of version and capacity of the device. This field is necessary only at the time of ordering the newer generation device i.e. AzureDataBox120 and AzureDataBox525 as of Feb/2025
   */
  `model`?: ModelName;
}

/**
 * Configuration response specific to a region.
 */
model RegionConfigurationResponse {
  /**
   * Schedule availability for given sku in a region.
   */
  @visibility(Lifecycle.Read)
  scheduleAvailabilityResponse?: ScheduleAvailabilityResponse;

  /**
   * Transport options available for given sku in a region.
   */
  @visibility(Lifecycle.Read)
  transportAvailabilityResponse?: TransportAvailabilityResponse;

  /**
   * Datacenter address for given sku in a region.
   */
  @visibility(Lifecycle.Read)
  datacenterAddressResponse?: DatacenterAddressResponse;

  /**
   * Device capabilities available for a given sku in a region.
   */
  @visibility(Lifecycle.Read)
  deviceCapabilityResponse?: DeviceCapabilityResponse;
}

/**
 * Schedule availability for given sku in a region.
 */
model ScheduleAvailabilityResponse {
  /**
   * List of dates available to schedule
   */
  @visibility(Lifecycle.Read)
  availableDates?: utcDateTime[];
}

/**
 * Transport options available for given sku in a region.
 */
model TransportAvailabilityResponse {
  /**
   * List of transport availability details for given region
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  transportAvailabilityDetails?: TransportAvailabilityDetails[];
}

/**
 * Transport options availability details for given region.
 */
model TransportAvailabilityDetails {
  /**
   * Transport Shipment Type supported for given region.
   */
  @visibility(Lifecycle.Read)
  shipmentType?: TransportShipmentTypes;
}

/**
 * Device capabilities for given sku in a region
 */
model DeviceCapabilityResponse {
  /**
   * List of device capabilities available for a given region and a given sku
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  deviceCapabilityDetails?: DeviceCapabilityDetails[];
}

/**
 * Device capability details for a given sku for a given region.
 */
model DeviceCapabilityDetails {
  /**
   * Hardware encryption support for a given sku for a given region.
   */
  @visibility(Lifecycle.Read)
  hardwareEncryption?: HardwareEncryption;
}

/**
 * The requirements to validate customer address where the device needs to be shipped.
 */
model ValidateAddress extends ValidationInputRequest {
  /**
   * Shipping address of the customer.
   */
  shippingAddress: ShippingAddress;

  /**
   * Device type to be used for the job.
   */
  deviceType: SkuName;

  /**
   * Preferences related to the shipment logistics of the sku.
   */
  transportPreferences?: TransportPreferences;

  /**
   * The customer friendly name of the combination of version and capacity of the device. This field is necessary only at the time of ordering the newer generation device i.e. AzureDataBox120 and AzureDataBox525 as of Feb/2025
   */
  `model`?: ModelName;

  /**
   * Identifies the type of validation request.
   */
  validationType: ValidationInputDiscriminator.ValidateAddress;
}

/**
 * Minimum fields that must be present in any type of validation request.
 */
@discriminator("validationType")
model ValidationInputRequest {
  /**
   * Identifies the type of validation request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validationType: ValidationInputDiscriminator;
}

/**
 * Output of the address validation api.
 */
model AddressValidationOutput {
  /**
   * The address validation properties.
   */
  @visibility(Lifecycle.Read)
  properties?: AddressValidationProperties;
}

/**
 * The address validation output.
 */
model AddressValidationProperties extends ValidationInputResponse {
  /**
   * The address validation status.
   */
  @visibility(Lifecycle.Read)
  validationStatus?: AddressValidationStatus;

  /**
   * List of alternate addresses.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  alternateAddresses?: ShippingAddress[];

  /**
   * Identifies the type of validation response.
   */
  validationType: ValidationInputDiscriminator.ValidateAddress;
}

/**
 * Minimum properties that should be present in each individual validation response.
 */
@discriminator("validationType")
model ValidationInputResponse {
  /**
   * Identifies the type of validation response.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validationType: ValidationInputDiscriminator;

  /**
   * Error code and message of validation response.
   */
  @visibility(Lifecycle.Read)
  error?: CloudError;
}

/**
 * Minimum request requirement of any validation category.
 */
@discriminator("validationCategory")
model ValidationRequest {
  /**
   * Identify the nature of validation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validationCategory: "JobCreationValidation"; // FIXME: `modelAsExtensible` is not supported anymore.

  /**
   * List of request details contain validationType and its request as key and value respectively.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  individualRequestDetails: ValidationInputRequest[];
}

/**
 * Response of pre job creation validations.
 */
model ValidationResponse {
  /**
   * Properties of pre job creation validation response.
   */
  @visibility(Lifecycle.Read)
  properties?: ValidationResponseProperties;
}

/**
 * Properties of pre job creation validation response.
 */
model ValidationResponseProperties {
  /**
   * Overall validation status.
   */
  @visibility(Lifecycle.Read)
  status?: OverallValidationStatus;

  /**
   * List of response details contain validationType and its response as key and value respectively.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  individualResponseDetails?: ValidationInputResponse[];
}

/**
 * The JobResourceUpdateParameter.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model JobResourceUpdateParameter {
  /**
   * Properties of a job to be updated.
   */
  properties?: UpdateJobProperties;

  /**
   * The list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Msi identity of the resource
   */
  identity?: ResourceIdentity;
}

/**
 * Job Properties for update
 */
model UpdateJobProperties {
  /**
   * Details of a job to be updated.
   */
  details?: UpdateJobDetails;
}

/**
 * Job details for update.
 */
model UpdateJobDetails {
  /**
   * Contact details for notification and shipping.
   */
  contactDetails?: ContactDetails;

  /**
   * Shipping address of the customer.
   */
  shippingAddress?: ShippingAddress;

  /**
   * Reverse Shipping Address and contact details for a job.
   */
  reverseShippingDetails?: ReverseShippingDetails;

  /**
   * Preferences related to the order
   */
  preferences?: Preferences;

  /**
   * Key encryption key for the job.
   */
  keyEncryptionKey?: KeyEncryptionKey;

  /**
   * Return package details of job.
   */
  returnToCustomerPackageDetails?: PackageCarrierDetails;
}

/**
 * Package carrier details.
 */
model PackageCarrierDetails {
  /**
   * Carrier Account Number of customer for customer disk.
   */
  @secret
  carrierAccountNumber?: string;

  /**
   * Name of the carrier.
   */
  carrierName?: string;

  /**
   * Tracking Id of shipment.
   */
  trackingId?: string;
}

/**
 * Msi identity details of the resource
 */
model ResourceIdentity {
  /**
   * Identity type
   */
  type?: string = "None";

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

  /**
   * User Assigned Identities
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Shipment pick up request details.
 */
model ShipmentPickUpRequest {
  /**
   * Minimum date after which the pick up should commence, this must be in local time of pick up area.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  /**
   * Maximum date before which the pick up should commence, this must be in local time of pick up area.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime: utcDateTime;

  /**
   * Shipment Location in the pickup place. Eg.front desk
   */
  shipmentLocation: string;
}

/**
 * Shipment pick up response.
 */
model ShipmentPickUpResponse {
  /**
   * Confirmation number for the pick up request.
   */
  @visibility(Lifecycle.Read)
  confirmationNumber?: string;

  /**
   * Time by which shipment should be ready for pick up, this is in local time of pick up area.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  readyByTime?: utcDateTime;
}

/**
 * Reason for cancellation.
 */
model CancellationReason {
  /**
   * Reason for cancellation.
   */
  reason: string;
}

/**
 * List of unencrypted credentials for accessing device.
 */
model UnencryptedCredentialsList is Azure.Core.Page<UnencryptedCredentials>;

/**
 * Unencrypted credentials for accessing device.
 */
model UnencryptedCredentials {
  /**
   * Name of the job.
   */
  @visibility(Lifecycle.Read)
  jobName?: string;

  /**
   * Secrets related to this job.
   */
  @visibility(Lifecycle.Read)
  jobSecrets?: JobSecrets;
}

/**
 * The base class for the secrets
 */
@discriminator("jobSecretsType")
model JobSecrets {
  /**
   * Used to indicate what type of job secrets object.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  jobSecretsType: ClassDiscriminator;

  /**
   * Dc Access Security Code for Customer Managed Shipping
   */
  @visibility(Lifecycle.Read)
  dcAccessSecurityCode?: DcAccessSecurityCode;

  /**
   * Error while fetching the secrets.
   */
  @visibility(Lifecycle.Read)
  error?: CloudError;
}

/**
 * Dc access security code
 */
model DcAccessSecurityCode {
  /**
   * Reverse Dc access security code.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reverseDCAccessCode?: string;

  /**
   * Forward Dc access security code.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  forwardDCAccessCode?: string;
}

/**
 * The request body to provide the delivery package details of job
 */
model MarkDevicesShippedRequest {
  /**
   * Delivery package details
   */
  deliverToDcPackageDetails: PackageCarrierInfo;
}

/**
 * package carrier info
 */
model PackageCarrierInfo {
  /**
   * Name of the carrier.
   */
  carrierName?: string;

  /**
   * Tracking Id of shipment.
   */
  trackingId?: string;
}

/**
 * The Mitigate Job captured from request body for Mitigate API
 */
model MitigateJobRequest {
  /**
   * Resolution code for the job
   */
  customerResolutionCode?: CustomerResolutionCode;

  /**
   * Serial number and the customer resolution code corresponding to each serial number
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serialNumberCustomerResolutionMap?: Record<CustomerResolutionCode>;
}

/**
 * The filters for showing the available skus.
 */
model AvailableSkuRequest {
  /**
   * Type of the transfer.
   */
  transferType: TransferType;

  /**
   * ISO country code. Country for hardware shipment. For codes check: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements
   */
  country: string;

  /**
   * Location for data transfer. For locations check: https://management.azure.com/subscriptions/SUBSCRIPTIONID/locations?api-version=2018-01-01
   */
  location: string;

  /**
   * Sku Names to filter for available skus
   */
  skuNames?: SkuName[];
}

/**
 * The available skus operation response.
 */
model AvailableSkusResult {
  /**
   * [Placeholder] Description for page model
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @pageItems
  value: SkuInformation[];

  /**
   * [Placeholder] Description for nextLink property
   */
  @nextLink
  nextLink?: string;
}

/**
 * Information of the sku.
 */
model SkuInformation {
  /**
   * The Sku.
   */
  @visibility(Lifecycle.Read)
  sku?: Sku;

  /**
   * The sku is enabled or not.
   */
  @visibility(Lifecycle.Read)
  enabled?: boolean;

  /**
   * Properties of the sku.
   */
  @visibility(Lifecycle.Read)
  properties?: SkuProperties;
}

/**
 * The Sku.
 */
model Sku {
  /**
   * The sku name.
   */
  name: SkuName;

  /**
   * The display name of the sku.
   */
  displayName?: string;

  /**
   * The sku family.
   */
  family?: string;

  /**
   * The customer friendly name of the combination of version and capacity of the device. This field is necessary only at the time of ordering the newer generation device i.e. AzureDataBox120 and AzureDataBox525 as of Feb/2025
   */
  `model`?: ModelName;
}

/**
 * Properties of the sku.
 */
model SkuProperties {
  /**
   * The map of data location to service location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  dataLocationToServiceLocationMap?: DataLocationToServiceLocationMap[];

  /**
   * Capacity of the Sku.
   */
  @visibility(Lifecycle.Read)
  capacity?: SkuCapacity;

  /**
   * Cost of the Sku.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  costs?: SkuCost[];

  /**
   * Api versions that support this Sku.
   */
  @visibility(Lifecycle.Read)
  apiVersions?: string[];

  /**
   * Reason why the Sku is disabled.
   */
  @visibility(Lifecycle.Read)
  disabledReason?: SkuDisabledReason;

  /**
   * Message for why the Sku is disabled.
   */
  @visibility(Lifecycle.Read)
  disabledReasonMessage?: string;

  /**
   * Required feature to access the sku.
   */
  @visibility(Lifecycle.Read)
  requiredFeature?: string;

  /**
   * List of all the Countries in the SKU specific commerce boundary
   */
  @visibility(Lifecycle.Read)
  countriesWithinCommerceBoundary?: string[];
}

/**
 * Map of data location to service location
 */
model DataLocationToServiceLocationMap {
  /**
   * Location of the data.
   */
  @visibility(Lifecycle.Read)
  dataLocation?: string;

  /**
   * Location of the service.
   */
  @visibility(Lifecycle.Read)
  serviceLocation?: string;
}

/**
 * Capacity of the sku.
 */
model SkuCapacity {
  /**
   * Usable capacity in TB.
   */
  @visibility(Lifecycle.Read)
  usable?: string;

  /**
   * Maximum capacity in TB.
   */
  @visibility(Lifecycle.Read)
  maximum?: string;

  /**
   * Maximum capacity per device in TB.
   */
  @visibility(Lifecycle.Read)
  individualSkuUsable?: string;
}

/**
 * Describes metadata for retrieving price info.
 */
model SkuCost {
  /**
   * Meter id of the Sku.
   */
  @visibility(Lifecycle.Read)
  meterId?: string;

  /**
   * The type of the meter.
   */
  @visibility(Lifecycle.Read)
  meterType?: string;

  /**
   * Multiplier specifies the region specific value to be multiplied with 1$ guid. Eg: Our new regions will be using 1$ shipping guid with appropriate multiplier specific to region.
   */
  @visibility(Lifecycle.Read)
  multiplier?: float64;
}

/**
 * Credential details of the account.
 */
model AccountCredentialDetails {
  /**
   * Name of the account.
   */
  @visibility(Lifecycle.Read)
  accountName?: string;

  /**
   * Type of the account.
   */
  @visibility(Lifecycle.Read)
  dataAccountType?: DataAccountType;

  /**
   * Connection string of the account endpoint to use the account as a storage endpoint on the device.
   */
  @visibility(Lifecycle.Read)
  accountConnectionString?: string;

  /**
   * Per share level unencrypted access credentials.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  shareCredentialDetails?: ShareCredentialDetails[];
}

/**
 * Credential details of the shares in account.
 */
model ShareCredentialDetails {
  /**
   * Name of the share.
   */
  @visibility(Lifecycle.Read)
  shareName?: string;

  /**
   * Type of the share.
   */
  @visibility(Lifecycle.Read)
  shareType?: ShareDestinationFormatType;

  /**
   * User name for the share.
   */
  @visibility(Lifecycle.Read)
  userName?: string;

  /**
   * Password for the share.
   */
  @visibility(Lifecycle.Read)
  password?: string;

  /**
   * Access protocols supported on the device.
   */
  @visibility(Lifecycle.Read)
  supportedAccessProtocols?: AccessProtocol[];
}

/**
 * The Network Adapter configuration of a DataBox.
 */
model ApplianceNetworkConfiguration {
  /**
   * Name of the network.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Mac Address.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;
}

/**
 * Base class for all objects under resource.
 */
model ArmBaseObject {
  /**
   * Name of the object.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Id of the object.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Type of the object.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Copy progress.
 */
model CopyProgress {
  /**
   * Name of the storage account. This will be empty for data account types other than storage account.
   */
  @visibility(Lifecycle.Read)
  storageAccountName?: string;

  /**
   * Transfer type of data
   */
  @visibility(Lifecycle.Read)
  transferType?: TransferType;

  /**
   * Data Account Type.
   */
  @visibility(Lifecycle.Read)
  dataAccountType?: DataAccountType;

  /**
   * Id of the account where the data needs to be uploaded.
   */
  @visibility(Lifecycle.Read)
  accountId?: string;

  /**
   * To indicate bytes transferred.
   */
  @visibility(Lifecycle.Read)
  bytesProcessed?: int64;

  /**
   * Total amount of data to be processed by the job.
   */
  @visibility(Lifecycle.Read)
  totalBytesToProcess?: int64;

  /**
   * Number of files processed
   */
  @visibility(Lifecycle.Read)
  filesProcessed?: int64;

  /**
   * Total files to process
   */
  @visibility(Lifecycle.Read)
  totalFilesToProcess?: int64;

  /**
   * Number of files not adhering to azure naming conventions which were processed by automatic renaming
   */
  @visibility(Lifecycle.Read)
  invalidFilesProcessed?: int64;

  /**
   * Total amount of data not adhering to azure naming conventions which were processed by automatic renaming
   */
  @visibility(Lifecycle.Read)
  invalidFileBytesUploaded?: int64;

  /**
   * Number of folders not adhering to azure naming conventions which were processed by automatic renaming
   */
  @visibility(Lifecycle.Read)
  renamedContainerCount?: int64;

  /**
   * Number of files which could not be copied
   */
  @visibility(Lifecycle.Read)
  filesErroredOut?: int64;

  /**
   * To indicate directories errored out in the job.
   */
  @visibility(Lifecycle.Read)
  directoriesErroredOut?: int64;

  /**
   * To indicate directories renamed
   */
  @visibility(Lifecycle.Read)
  invalidDirectoriesProcessed?: int64;

  /**
   * To indicate if enumeration of data is in progress.
   * Until this is true, the TotalBytesToProcess may not be valid.
   */
  @visibility(Lifecycle.Read)
  isEnumerationInProgress?: boolean;

  /**
   * Error, if any, in the stage
   */
  @visibility(Lifecycle.Read)
  error?: CloudError;

  /**
   * Available actions on the job.
   */
  @visibility(Lifecycle.Read)
  actions?: CustomerResolutionCode[];
}

/**
 * It does all pre-job creation validations.
 */
model CreateJobValidations extends ValidationRequest {
  /**
   * Identify the nature of validation.
   */
  validationCategory: "JobCreationValidation"; // FIXME: `modelAsExtensible` is not supported anymore.
}

/**
 * Request to validate create order limit for current subscription.
 */
model CreateOrderLimitForSubscriptionValidationRequest
  extends ValidationInputRequest {
  /**
   * Device type to be used for the job.
   */
  deviceType: SkuName;

  /**
   * The customer friendly name of the combination of version and capacity of the device. This field is necessary only at the time of ordering the newer generation device i.e. AzureDataBox120 and AzureDataBox525 as of Feb/2025
   */
  `model`?: ModelName;

  /**
   * Identifies the type of validation request.
   */
  validationType: ValidationInputDiscriminator.ValidateCreateOrderLimit;
}

/**
 * Properties of create order limit for subscription validation response.
 */
model CreateOrderLimitForSubscriptionValidationResponseProperties
  extends ValidationInputResponse {
  /**
   * Create order limit validation status.
   */
  @visibility(Lifecycle.Read)
  status?: ValidationStatus;

  /**
   * Identifies the type of validation response.
   */
  validationType: ValidationInputDiscriminator.ValidateCreateOrderLimit;
}

/**
 * The secrets related to customer disk job.
 */
model CustomerDiskJobSecrets extends JobSecrets {
  /**
   * Contains the list of secrets object for that device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  diskSecrets?: DiskSecret[];

  /**
   * Carrier Account Number of the customer
   */
  @visibility(Lifecycle.Read)
  @secret
  carrierAccountNumber?: string;

  /**
   * Used to indicate what type of job secrets object.
   */
  jobSecretsType: ClassDiscriminator.DataBoxCustomerDisk;
}

/**
 * Contains all the secrets of a Disk.
 */
model DiskSecret {
  /**
   * Serial number of the assigned disk.
   */
  @visibility(Lifecycle.Read)
  diskSerialNumber?: string;

  /**
   * Bit Locker key of the disk which can be used to unlock the disk to copy data.
   */
  @visibility(Lifecycle.Read)
  bitLockerKey?: string;
}

/**
 * Copy log details for a storage account of a DataBox job
 */
model DataBoxAccountCopyLogDetails extends CopyLogDetails {
  /**
   * Account name.
   */
  @visibility(Lifecycle.Read)
  accountName?: string;

  /**
   * Link for copy logs.
   */
  @visibility(Lifecycle.Read)
  copyLogLink?: string;

  /**
   * Link for copy verbose logs. This will be set only when LogCollectionLevel is set to Verbose.
   */
  @visibility(Lifecycle.Read)
  copyVerboseLogLink?: string;

  /**
   * Indicates the type of job details.
   */
  copyLogDetailsType: ClassDiscriminator.DataBox;
}

/**
 * Copy Log Details for customer disk
 */
model DataBoxCustomerDiskCopyLogDetails extends CopyLogDetails {
  /**
   * Disk Serial Number.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Link for copy error logs.
   */
  @visibility(Lifecycle.Read)
  errorLogLink?: string;

  /**
   * Link for copy verbose logs.
   */
  @visibility(Lifecycle.Read)
  verboseLogLink?: string;

  /**
   * Indicates the type of job details.
   */
  copyLogDetailsType: ClassDiscriminator.DataBoxCustomerDisk;
}

/**
 * DataBox CustomerDisk Copy Progress
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataBoxCustomerDiskCopyProgress extends CopyProgress {
  /**
   * Disk Serial Number.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * The Status of the copy
   */
  @visibility(Lifecycle.Read)
  copyStatus?: CopyStatus;
}

/**
 * Customer disk job details.
 */
model DataBoxCustomerDiskJobDetails extends JobDetails {
  /**
   * Contains the map of disk serial number to the disk details for import jobs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  importDiskDetailsCollection?: Record<ImportDiskDetails>;

  /**
   * Contains the map of disk serial number to the disk details for export jobs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  exportDiskDetailsCollection?: Record<ExportDiskDetails>;

  /**
   * Copy progress per disk.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  copyProgress?: DataBoxCustomerDiskCopyProgress[];

  /**
   * Delivery package shipping details.
   */
  @visibility(Lifecycle.Read)
  deliverToDcPackageDetails?: PackageCarrierInfo;

  /**
   * Return package shipping details.
   */
  returnToCustomerPackageDetails: PackageCarrierDetails;

  /**
   * Flag to indicate if disk manifest should be backed-up in the Storage Account.
   */
  enableManifestBackup?: boolean = false;

  /**
   * Indicates the type of job details.
   */
  jobDetailsType: ClassDiscriminator.DataBoxCustomerDisk;
}

/**
 * Import disk details
 */
model ImportDiskDetails {
  /**
   * The relative path of the manifest file on the disk.
   */
  manifestFile: string;

  /**
   * The Base16-encoded MD5 hash of the manifest file on the disk.
   */
  manifestHash: string;

  /**
   * BitLocker key used to encrypt the disk.
   */
  @secret
  bitLockerKey: string;

  /**
   * Path to backed up manifest, only returned if enableManifestBackup is true.
   */
  @visibility(Lifecycle.Read)
  backupManifestCloudPath?: string;
}

/**
 * Export disk details
 */
model ExportDiskDetails {
  /**
   * The relative path of the manifest file on the disk.
   */
  @visibility(Lifecycle.Read)
  manifestFile?: string;

  /**
   * The Base16-encoded MD5 hash of the manifest file on the disk.
   */
  @visibility(Lifecycle.Read)
  manifestHash?: string;

  /**
   * Path to backed up manifest, only returned if enableManifestBackup is true.
   */
  @visibility(Lifecycle.Read)
  backupManifestCloudPath?: string;
}

/**
 * Copy Log Details for a disk
 */
model DataBoxDiskCopyLogDetails extends CopyLogDetails {
  /**
   * Disk Serial Number.
   */
  @visibility(Lifecycle.Read)
  diskSerialNumber?: string;

  /**
   * Link for copy error logs.
   */
  @visibility(Lifecycle.Read)
  errorLogLink?: string;

  /**
   * Link for copy verbose logs.
   */
  @visibility(Lifecycle.Read)
  verboseLogLink?: string;

  /**
   * Indicates the type of job details.
   */
  copyLogDetailsType: ClassDiscriminator.DataBoxDisk;
}

/**
 * DataBox Disk Copy Progress
 */
model DataBoxDiskCopyProgress {
  /**
   * The serial number of the disk
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Bytes copied during the copy of disk.
   */
  @visibility(Lifecycle.Read)
  bytesCopied?: int64;

  /**
   * Indicates the percentage completed for the copy of the disk.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * The Status of the copy
   */
  @visibility(Lifecycle.Read)
  status?: CopyStatus;

  /**
   * Error, if any, in the stage
   */
  @visibility(Lifecycle.Read)
  error?: CloudError;

  /**
   * Available actions on the job.
   */
  @visibility(Lifecycle.Read)
  actions?: CustomerResolutionCode[];
}

/**
 * Granular Copy Log Details for customer disk
 */
model DataBoxDiskGranularCopyLogDetails extends GranularCopyLogDetails {
  /**
   * Disk Serial Number.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Account id.
   */
  @visibility(Lifecycle.Read)
  accountId?: string;

  /**
   * Link for copy error logs.
   */
  @visibility(Lifecycle.Read)
  errorLogLink?: string;

  /**
   * Link for copy verbose logs.
   */
  @visibility(Lifecycle.Read)
  verboseLogLink?: string;

  /**
   * Indicates the type of job details.
   */
  copyLogDetailsType: ClassDiscriminator.DataBoxCustomerDisk;
}

/**
 * Granular Details for log generated during copy.
 */
@discriminator("copyLogDetailsType")
model GranularCopyLogDetails {
  /**
   * Indicates the type of job details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  copyLogDetailsType: ClassDiscriminator;
}

/**
 * DataBox Disk Granular Copy Progress
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataBoxDiskGranularCopyProgress extends GranularCopyProgress {
  /**
   * Disk Serial Number.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * The Status of the copy
   */
  @visibility(Lifecycle.Read)
  copyStatus?: CopyStatus;
}

/**
 * Granular Copy progress.
 */
model GranularCopyProgress {
  /**
   * Name of the storage account. This will be empty for data account types other than storage account.
   */
  @visibility(Lifecycle.Read)
  storageAccountName?: string;

  /**
   * Transfer type of data
   */
  @visibility(Lifecycle.Read)
  transferType?: TransferType;

  /**
   * Data Account Type.
   */
  @visibility(Lifecycle.Read)
  dataAccountType?: DataAccountType;

  /**
   * Id of the account where the data needs to be uploaded.
   */
  @visibility(Lifecycle.Read)
  accountId?: string;

  /**
   * To indicate bytes transferred.
   */
  @visibility(Lifecycle.Read)
  bytesProcessed?: int64;

  /**
   * Total amount of data to be processed by the job.
   */
  @visibility(Lifecycle.Read)
  totalBytesToProcess?: int64;

  /**
   * Number of files processed
   */
  @visibility(Lifecycle.Read)
  filesProcessed?: int64;

  /**
   * Total files to process
   */
  @visibility(Lifecycle.Read)
  totalFilesToProcess?: int64;

  /**
   * Number of files not adhering to azure naming conventions which were processed by automatic renaming
   */
  @visibility(Lifecycle.Read)
  invalidFilesProcessed?: int64;

  /**
   * Total amount of data not adhering to azure naming conventions which were processed by automatic renaming
   */
  @visibility(Lifecycle.Read)
  invalidFileBytesUploaded?: int64;

  /**
   * Number of folders not adhering to azure naming conventions which were processed by automatic renaming
   */
  @visibility(Lifecycle.Read)
  renamedContainerCount?: int64;

  /**
   * Number of files which could not be copied
   */
  @visibility(Lifecycle.Read)
  filesErroredOut?: int64;

  /**
   * To indicate directories errored out in the job.
   */
  @visibility(Lifecycle.Read)
  directoriesErroredOut?: int64;

  /**
   * To indicate directories renamed
   */
  @visibility(Lifecycle.Read)
  invalidDirectoriesProcessed?: int64;

  /**
   * To indicate if enumeration of data is in progress.
   * Until this is true, the TotalBytesToProcess may not be valid.
   */
  @visibility(Lifecycle.Read)
  isEnumerationInProgress?: boolean;

  /**
   * Error, if any, in the stage
   */
  @visibility(Lifecycle.Read)
  error?: CloudError;

  /**
   * Available actions on the job.
   */
  @visibility(Lifecycle.Read)
  actions?: CustomerResolutionCode[];
}

/**
 * DataBox Disk Job Details.
 */
model DataBoxDiskJobDetails extends JobDetails {
  /**
   * User preference on what size disks are needed for the job. The map is from the disk size in TB to the count. Eg. {2,5} means 5 disks of 2 TB size. Key is string but will be checked against an int.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  preferredDisks?: Record<int32>;

  /**
   * Copy progress per disk.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  copyProgress?: DataBoxDiskCopyProgress[];

  /**
   * Copy progress per disk.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  granularCopyProgress?: DataBoxDiskGranularCopyProgress[];

  /**
   * Copy progress per disk.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  granularCopyLogDetails?: DataBoxDiskGranularCopyLogDetails[];

  /**
   * Contains the map of disk serial number to the disk size being used for the job. Is returned only after the disks are shipped to the customer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  disksAndSizeDetails?: Record<int32>;

  /**
   * User entered passkey for DataBox Disk job.
   */
  passkey?: string;

  /**
   * Indicates the type of job details.
   */
  jobDetailsType: ClassDiscriminator.DataBoxDisk;
}

/**
 * The secrets related to disk job.
 */
model DataBoxDiskJobSecrets extends JobSecrets {
  /**
   * Contains the list of secrets object for that device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  diskSecrets?: DiskSecret[];

  /**
   * PassKey for the disk Job.
   */
  @visibility(Lifecycle.Read)
  passKey?: string;

  /**
   * Whether passkey was provided by user.
   */
  @visibility(Lifecycle.Read)
  isPasskeyUserDefined?: boolean;

  /**
   * Used to indicate what type of job secrets object.
   */
  jobSecretsType: ClassDiscriminator.DataBoxDisk;
}

/**
 * Copy log details for a storage account for Databox heavy
 */
model DataBoxHeavyAccountCopyLogDetails extends CopyLogDetails {
  /**
   * Account name.
   */
  @visibility(Lifecycle.Read)
  accountName?: string;

  /**
   * Link for copy logs.
   */
  @visibility(Lifecycle.Read)
  copyLogLink?: string[];

  /**
   * Link for copy verbose logs. This will be set only when the LogCollectionLevel is set to verbose.
   */
  @visibility(Lifecycle.Read)
  copyVerboseLogLink?: string[];

  /**
   * Indicates the type of job details.
   */
  copyLogDetailsType: ClassDiscriminator.DataBoxHeavy;
}

/**
 * Databox Heavy Device Job Details
 */
model DataBoxHeavyJobDetails extends JobDetails {
  /**
   * Copy progress per account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  copyProgress?: CopyProgress[];

  @doc("Set Device password for unlocking Databox Heavy. Should not be passed for TransferType:ExportFromAzure jobs. If this is not passed, the service will generate password itself. This will not be returned in Get Call. Password Requirements :  Password must be minimum of 12 and maximum of 64 characters. Password must have at least one uppercase alphabet, one number and one special character. Password cannot have the following characters : IilLoO0 Password can have only alphabets, numbers and these characters : @#\\-$%^!+=;:_()]+")
  devicePassword?: string;

  /**
   * Indicates the type of job details.
   */
  jobDetailsType: ClassDiscriminator.DataBoxHeavy;
}

/**
 * The secrets related to a databox heavy job.
 */
model DataBoxHeavyJobSecrets extends JobSecrets {
  /**
   * Contains the list of secret objects for a databox heavy job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  cabinetPodSecrets?: DataBoxHeavySecret[];

  /**
   * Used to indicate what type of job secrets object.
   */
  jobSecretsType: ClassDiscriminator.DataBoxHeavy;
}

/**
 * The secrets related to a databox heavy.
 */
model DataBoxHeavySecret {
  /**
   * Serial number of the assigned device.
   */
  @visibility(Lifecycle.Read)
  deviceSerialNumber?: string;

  /**
   * Password for out of the box experience on device.
   */
  @visibility(Lifecycle.Read)
  devicePassword?: string;

  /**
   * Network configuration of the appliance.
   */
  @visibility(Lifecycle.Read)
  networkConfigurations?: ApplianceNetworkConfiguration[];

  /**
   * The base 64 encoded public key to authenticate with the device
   */
  @visibility(Lifecycle.Read)
  encodedValidationCertPubKey?: string;

  /**
   * Per account level access credentials.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  accountCredentialDetails?: AccountCredentialDetails[];
}

/**
 * Databox Job Details
 */
model DataBoxJobDetails extends JobDetails {
  /**
   * Copy progress per storage account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  copyProgress?: CopyProgress[];

  @doc("Set Device password for unlocking Databox. Should not be passed for TransferType:ExportFromAzure jobs. If this is not passed, the service will generate password itself. This will not be returned in Get Call. Password Requirements :  Password must be minimum of 12 and maximum of 64 characters. Password must have at least one uppercase alphabet, one number and one special character. Password cannot have the following characters : IilLoO0 Password can have only alphabets, numbers and these characters : @#\\-$%^!+=;:_()]+")
  devicePassword?: string;

  /**
   * Indicates the type of job details.
   */
  jobDetailsType: ClassDiscriminator.DataBox;
}

/**
 * Request body to get the availability for scheduling data box orders orders.
 */
model DataBoxScheduleAvailabilityRequest extends ScheduleAvailabilityRequest {
  /**
   * Sku Name for which the order is to be scheduled.
   */
  skuName: SkuName.DataBox;
}

/**
 * The secrets related to a DataBox.
 */
model DataBoxSecret {
  /**
   * Serial number of the assigned device.
   */
  @visibility(Lifecycle.Read)
  deviceSerialNumber?: string;

  /**
   * Password for out of the box experience on device.
   */
  @visibility(Lifecycle.Read)
  devicePassword?: string;

  /**
   * Network configuration of the appliance.
   */
  @visibility(Lifecycle.Read)
  networkConfigurations?: ApplianceNetworkConfiguration[];

  /**
   * The base 64 encoded public key to authenticate with the device
   */
  @visibility(Lifecycle.Read)
  encodedValidationCertPubKey?: string;

  /**
   * Per account level access credentials.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  accountCredentialDetails?: AccountCredentialDetails[];
}

/**
 * Request to validate export and import data details.
 */
model DataTransferDetailsValidationRequest extends ValidationInputRequest {
  /**
   * List of DataTransfer details to be used to export data from azure.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataExportDetails?: DataExportDetails[];

  /**
   * List of DataTransfer details to be used to import data to azure.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataImportDetails?: DataImportDetails[];

  /**
   * Device type.
   */
  deviceType: SkuName;

  /**
   * Type of the transfer.
   */
  transferType: TransferType;

  /**
   * The customer friendly name of the combination of version and capacity of the device. This field is necessary only at the time of ordering the newer generation device i.e. AzureDataBox120 and AzureDataBox525 as of Feb/2025
   */
  `model`?: ModelName;

  /**
   * Identifies the type of validation request.
   */
  validationType: ValidationInputDiscriminator.ValidateDataTransferDetails;
}

/**
 * Properties of data transfer details validation response.
 */
model DataTransferDetailsValidationResponseProperties
  extends ValidationInputResponse {
  /**
   * Data transfer details validation status.
   */
  @visibility(Lifecycle.Read)
  status?: ValidationStatus;

  /**
   * Identifies the type of validation response.
   */
  validationType: ValidationInputDiscriminator.ValidateDataTransferDetails;
}

/**
 * The secrets related to a databox job.
 */
model DataboxJobSecrets extends JobSecrets {
  /**
   * Contains the list of secret objects for a job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  podSecrets?: DataBoxSecret[];

  /**
   * Used to indicate what type of job secrets object.
   */
  jobSecretsType: ClassDiscriminator.DataBox;
}

/**
 * Datacenter instruction for given storage location.
 */
model DatacenterAddressInstructionResponse extends DatacenterAddressResponse {
  /**
   * Data center communication instruction
   */
  @visibility(Lifecycle.Read)
  communicationInstruction?: string;

  /**
   * Data center address type
   */
  datacenterAddressType: DatacenterAddressType.DatacenterAddressInstruction;
}

/**
 * Datacenter address for given storage location.
 */
model DatacenterAddressLocationResponse extends DatacenterAddressResponse {
  /**
   * Contact person name
   */
  @visibility(Lifecycle.Read)
  contactPersonName?: string;

  /**
   * Company name
   */
  @visibility(Lifecycle.Read)
  company?: string;

  /**
   * Street address line 1
   */
  @visibility(Lifecycle.Read)
  street1?: string;

  /**
   * Street address line 2
   */
  @visibility(Lifecycle.Read)
  street2?: string;

  /**
   * Street address line 3
   */
  @visibility(Lifecycle.Read)
  street3?: string;

  /**
   * City name
   */
  @visibility(Lifecycle.Read)
  city?: string;

  /**
   * name of the state
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * Zip code
   */
  @visibility(Lifecycle.Read)
  zip?: string;

  /**
   * name of the country
   */
  @visibility(Lifecycle.Read)
  country?: string;

  /**
   * Phone number
   */
  @visibility(Lifecycle.Read)
  phone?: string;

  /**
   * Phone extension
   */
  @visibility(Lifecycle.Read)
  phoneExtension?: string;

  /**
   * Address type
   */
  @visibility(Lifecycle.Read)
  addressType?: string;

  /**
   * Special instruction for shipping
   */
  @visibility(Lifecycle.Read)
  additionalShippingInformation?: string;

  /**
   * Data center address type
   */
  datacenterAddressType: DatacenterAddressType.DatacenterAddressLocation;
}

/**
 * Request body to get the availability for scheduling disk orders.
 */
model DiskScheduleAvailabilityRequest extends ScheduleAvailabilityRequest {
  /**
   * The expected size of the data, which needs to be transferred in this job, in terabytes.
   */
  expectedDataSizeInTeraBytes: int32;

  /**
   * Sku Name for which the order is to be scheduled.
   */
  skuName: SkuName.DataBoxDisk;
}

/**
 * Request body to get the availability for scheduling heavy orders.
 */
model HeavyScheduleAvailabilityRequest extends ScheduleAvailabilityRequest {
  /**
   * Sku Name for which the order is to be scheduled.
   */
  skuName: SkuName.DataBoxHeavy;
}

/**
 * Details of the managed disks.
 */
model ManagedDiskDetails extends DataAccountDetails {
  /**
   * Resource Group Id of the compute disks.
   */
  resourceGroupId: string;

  /**
   * Resource Id of the storage account that can be used to copy the vhd for staging.
   */
  stagingStorageAccountId: string;

  /**
   * Account Type of the data to be transferred.
   */
  dataAccountType: DataAccountType.ManagedDisk;
}

/**
 * Request to validate preference of transport and data center.
 */
model PreferencesValidationRequest extends ValidationInputRequest {
  /**
   * Preference of transport and data center.
   */
  preference?: Preferences;

  /**
   * Device type to be used for the job.
   */
  deviceType: SkuName;

  /**
   * The customer friendly name of the combination of version and capacity of the device. This field is necessary only at the time of ordering the newer generation device i.e. AzureDataBox120 and AzureDataBox525 as of Feb/2025
   */
  `model`?: ModelName;

  /**
   * Identifies the type of validation request.
   */
  validationType: ValidationInputDiscriminator.ValidatePreferences;
}

/**
 * Properties of data center and transport preference validation response.
 */
model PreferencesValidationResponseProperties extends ValidationInputResponse {
  /**
   * Validation status of requested data center and transport.
   */
  @visibility(Lifecycle.Read)
  status?: ValidationStatus;

  /**
   * Identifies the type of validation response.
   */
  validationType: ValidationInputDiscriminator.ValidatePreferences;
}

/**
 * Request to validate sku availability.
 */
model SkuAvailabilityValidationRequest extends ValidationInputRequest {
  /**
   * Device type to be used for the job.
   */
  deviceType: SkuName;

  /**
   * Type of the transfer.
   */
  transferType: TransferType;

  /**
   * ISO country code. Country for hardware shipment. For codes check: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements
   */
  country: string;

  /**
   * Location for data transfer. For locations check: https://management.azure.com/subscriptions/SUBSCRIPTIONID/locations?api-version=2018-01-01
   */
  location: string;

  /**
   * The customer friendly name of the combination of version and capacity of the device. This field is necessary only at the time of ordering the newer generation device i.e. AzureDataBox120 and AzureDataBox525 as of Feb/2025
   */
  `model`?: ModelName;

  /**
   * Identifies the type of validation request.
   */
  validationType: ValidationInputDiscriminator.ValidateSkuAvailability;
}

/**
 * Properties of sku availability validation response.
 */
model SkuAvailabilityValidationResponseProperties
  extends ValidationInputResponse {
  /**
   * Sku availability validation status.
   */
  @visibility(Lifecycle.Read)
  status?: ValidationStatus;

  /**
   * Identifies the type of validation response.
   */
  validationType: ValidationInputDiscriminator.ValidateSkuAvailability;
}

/**
 * Details for the storage account.
 */
model StorageAccountDetails extends DataAccountDetails {
  /**
   * Storage Account Resource Id.
   */
  storageAccountId: string;

  /**
   * Account Type of the data to be transferred.
   */
  dataAccountType: DataAccountType.StorageAccount;
}

/**
 * Request to validate subscription permission to create jobs.
 */
model SubscriptionIsAllowedToCreateJobValidationRequest
  extends ValidationInputRequest {
  /**
   * Identifies the type of validation request.
   */
  validationType: ValidationInputDiscriminator.ValidateSubscriptionIsAllowedToCreateJob;
}

/**
 * Properties of subscription permission to create job validation response.
 */
model SubscriptionIsAllowedToCreateJobValidationResponseProperties
  extends ValidationInputResponse {
  /**
   * Validation status of subscription permission to create job.
   */
  @visibility(Lifecycle.Read)
  status?: ValidationStatus;

  /**
   * Identifies the type of validation response.
   */
  validationType: ValidationInputDiscriminator.ValidateSubscriptionIsAllowedToCreateJob;
}
/**
 * Operation properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationProperties {}

/**
 * Operation display
 */
model OperationDisplay {
  /**
   * Provider name.
   */
  provider?: string;

  /**
   * Resource name.
   */
  resource?: string;

  /**
   * Localized name of the operation for display purpose.
   */
  operation?: string;

  /**
   * Localized description of the operation for display purpose.
   */
  description?: string;
}

/**
 * Operation entity.
 */
model Operation {
  /** 
    Name of the operation. Format: {resourceProviderNamespace}/{resourceType}/{read|write|delete|action}
  */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Operation display values.
   */
  @visibility(Lifecycle.Read)
  display?: OperationDisplay;

  /**
   * Operation properties.
   */
  @visibility(Lifecycle.Read)
  properties?: OperationProperties;

  /**
   * Origin of the operation. Can be : user|system|user,system
   */
  @visibility(Lifecycle.Read)
  origin?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;
}

/**
 * The paginated list of connected cluster API operations.
 */
model OperationList {
  /**
   * The list of connected cluster API operations.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Operation[];

  /**
   * The link to fetch the next page of connected cluster API operations.
   */
  @nextLink
  nextLink?: string;
}
