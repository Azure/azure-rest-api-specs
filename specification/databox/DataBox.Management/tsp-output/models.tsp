import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataBox;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Name of the stage which is in progress.
 */
enum StageName {
  /**
   * An order has been created.
   */
  DeviceOrdered,

  /**
   * A device has been prepared for the order.
   */
  DevicePrepared,

  /**
   * Device has been dispatched to the user of the order.
   */
  Dispatched,

  /**
   * Device has been delivered to the user of the order.
   */
  Delivered,

  /**
   * Device has been picked up from user and in transit to Azure datacenter.
   */
  PickedUp,

  /**
   * Device has been received at Azure datacenter from the user.
   */
  AtAzureDC,

  /**
   * Data copy from the device at Azure datacenter.
   */
  DataCopy,

  /**
   * Order has completed.
   */
  Completed,

  /**
   * Order has completed with errors.
   */
  CompletedWithErrors,

  /**
   * Order has been cancelled.
   */
  Cancelled,

  /**
   * Order has failed due to issue reported by user.
   */
  Failed_IssueReportedAtCustomer,

  /**
   * Order has failed due to issue detected at Azure datacenter.
   */
  Failed_IssueDetectedAtAzureDC,

  /**
   * Order has been aborted.
   */
  Aborted,

  /**
   * Order has completed with warnings.
   */
  CompletedWithWarnings,

  /**
   * Device is ready to be handed to customer from Azure DC.
   */
  ReadyToDispatchFromAzureDC,

  /**
   * Device can be dropped off at Azure DC.
   */
  ReadyToReceiveAtAzureDC,

  /**
   * Job created by the customer.
   */
  Created,

  /**
   * User shipped the device to AzureDC.
   */
  ShippedToAzureDC,

  /**
   * Awaiting shipment details of device from customer.
   */
  AwaitingShipmentDetails,

  /**
   * Preparing the device to ship to customer.
   */
  PreparingToShipFromAzureDC,

  /**
   * Shipped the device to customer.
   */
  ShippedToCustomer,
}

/**
 * Name of the stage.
 */
enum NotificationStageName {
  /**
   * Notification at device prepared stage.
   */
  DevicePrepared,

  /**
   * Notification at device dispatched stage.
   */
  Dispatched,

  /**
   * Notification at device delivered stage.
   */
  Delivered,

  /**
   * Notification at device picked up from user stage.
   */
  PickedUp,

  /**
   * Notification at device received at Azure datacenter stage.
   */
  AtAzureDC,

  /**
   * Notification at data copy started stage.
   */
  DataCopy,

  /**
   * Notification at job created stage.
   */
  Created,

  /**
   * Notification at shipped devices to customer stage.
   */
  ShippedToCustomer,
}

/**
 * DataCenter code.
 */
enum DataCenterCode {
  Invalid,
  BY2,
  BY1,
  ORK70,
  AM2,
  AMS20,
  BY21,
  BY24,
  MWH01,
  AMS06,
  SSE90,
  SYD03,
  SYD23,
  CBR20,
  YTO20,
  CWL20,
  LON24,
  BOM01,
  BL20,
  BL7,
  SEL20,
  TYO01,
  BN1,
  SN5,
  CYS04,
  TYO22,
  YTO21,
  YQB20,
  FRA22,
  MAA01,
  CPQ02,
  CPQ20,
  SIN20,
  HKG20,
  SG2,
  MEL23,
  SEL21,
  OSA20,
  SHA03,
  BJB,
  JNB22,
  JNB21,
  MNZ21,
  SN8,
  AUH20,
  ZRH20,
  PUS20,
  AdHoc,
  CH1,
  DSM05,
  DUB07,
  PNQ01,
  SVG20,
  OSA02,
  OSA22,
  PAR22,
  BN7,
  SN6,
  BJS20,
}

/**
 * The Status of the copy
 */
enum CopyStatus {
  /**
   * Data copy hasn't started yet.
   */
  NotStarted,

  /**
   * Data copy is in progress.
   */
  InProgress,

  /**
   * Data copy completed.
   */
  Completed,

  /**
   * Data copy completed with errors.
   */
  CompletedWithErrors,

  /**
   * Data copy failed. No data was copied.
   */
  Failed,

  /**
   * No copy triggered as device was not returned.
   */
  NotReturned,

  /**
   * The Device has hit hardware issues.
   */
  HardwareError,

  /**
   * Data copy failed. The Device was formatted by user.
   */
  DeviceFormatted,

  /**
   * Data copy failed. Device metadata was modified by user.
   */
  DeviceMetadataModified,

  /**
   * Data copy failed. Storage Account was not accessible during copy.
   */
  StorageAccountNotAccessible,

  /**
   * Data copy failed. The Device data content is not supported.
   */
  UnsupportedData,

  /**
   * No copy triggered as device was not received.
   */
  DriveNotReceived,

  /**
   * No copy triggered as device type is not supported.
   */
  UnsupportedDrive,

  /**
   * Copy failed due to service error.
   */
  OtherServiceError,

  /**
   * Copy failed due to user error.
   */
  OtherUserError,

  /**
   * Copy failed due to disk detection error.
   */
  DriveNotDetected,

  /**
   * Copy failed due to corrupted drive.
   */
  DriveCorrupted,

  /**
   * Copy failed due to modified or removed metadata files.
   */
  MetadataFilesModifiedOrRemoved,
}

/**
 * Type of the transfer.
 */
@fixed
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
@fixed
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
@fixed
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
@fixed
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
@fixed
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
@fixed
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
@fixed
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
@fixed
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
@fixed
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
@fixed
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
@fixed
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
@fixed
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
 * Defines Hardware level encryption (Only for disk)
 */
@fixed
enum HardwareEncryption {
  /**
   * Hardware-based encryption is enabled.
   */
  Enabled,

  /**
   * Hardware-based encryption is enabled.
   */
  Disabled,
}

/**
 * Type of encryption key used for key encryption.
 */
@fixed
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

@fixed
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
@fixed
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
@fixed
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

@fixed
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
 * Reason why the Sku is disabled.
 */
@fixed
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
 * Identifies the type of validation request.
 */
@fixed
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
@fixed
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
@fixed
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
 * Type of the share.
 */
@fixed
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

@fixed
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
@fixed
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

@error
model ApiError {
  error: ErrorDetail;
}

model Details {
  code: string;
  message: string;
}

/**
 * Job Properties
 */
model JobProperties {
  /**
   * Type of the data transfer.
   */
  transferType: TransferType;

  /**
   * Describes whether the job is cancellable or not.
   */
  @visibility("read")
  isCancellable?: boolean;

  /**
   * Describes whether the job is deletable or not.
   */
  @visibility("read")
  isDeletable?: boolean;

  /**
   * Describes whether the shipping address is editable or not.
   */
  @visibility("read")
  isShippingAddressEditable?: boolean;

  /**
   * The Editable status for Reverse Shipping Address and Contact Info
   */
  @visibility("read")
  reverseShippingDetailsUpdate?: ReverseShippingDetailsEditStatus;

  /**
   * The Editable status for Reverse Transport preferences
   */
  @visibility("read")
  reverseTransportPreferenceUpdate?: ReverseTransportPreferenceEditStatus;

  /**
   * Is Prepare To Ship Enabled on this job
   */
  @visibility("read")
  isPrepareToShipEnabled?: boolean;

  /**
   * Name of the stage which is in progress.
   */
  @visibility("read")
  status?: StageName;

  /**
   * Time at which the job was started in UTC ISO 8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Top level error for the job.
   */
  @visibility("read")
  error?: CloudError;

  /**
   * Details of a job run. This field will only be sent for expand details filter.
   */
  details?: JobDetails;

  /**
   * Reason for cancellation.
   */
  @visibility("read")
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
  @visibility("read")
  isCancellableWithoutFee?: boolean;
}

/**
 * Provides additional information about an http error response.
 */
model CloudError {
  /**
   * Gets or sets additional error info.
   */
  @visibility("read")
  additionalInfo?: AdditionalErrorInfo[];

  /**
   * Error code.
   */
  code?: string;

  /**
   * Gets or sets details for the error.
   */
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
  deliveryPackage?: PackageShippingDetails;

  /**
   * Return package shipping details.
   */
  @visibility("read")
  returnPackage?: PackageShippingDetails;

  /**
   * Details of the data to be imported into azure.
   */
  dataImportDetails?: DataImportDetails[];

  /**
   * Details of the data to be exported from azure.
   */
  dataExportDetails?: DataExportDetails[];

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
  @visibility("read")
  copyLogDetails?: CopyLogDetails[];

  /**
   * Shared access key to download the return shipment label
   */
  @visibility("read")
  reverseShipmentLabelSasKey?: string;

  /**
   * Shared access key to download the chain of custody logs
   */
  @visibility("read")
  chainOfCustodySasKey?: string;

  /**
   * Holds device data erasure details
   */
  @visibility("read")
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
  @visibility("read")
  actions?: CustomerResolutionCode[];

  /**
   * Last mitigation action performed on the job.
   */
  @visibility("read")
  lastMitigationActionOnJob?: LastMitigationActionOnJob;

  /**
   * Datacenter address to ship to, for the given sku and storage location.
   */
  @visibility("read")
  datacenterAddress?: DatacenterAddressResponse;

  /**
   * DataCenter code.
   */
  @visibility("read")
  dataCenterCode?: DataCenterCode;
}

/**
 * Job stages.
 */
model JobStages {
  /**
   * Name of the job stage.
   */
  @visibility("read")
  stageName?: StageName;

  /**
   * Display name of the job stage.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Status of the job stage.
   */
  @visibility("read")
  stageStatus?: StageStatus;

  /**
   * Time for the job stage in UTC ISO 8601 format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  stageTime?: utcDateTime;

  /**
   * Job Stage Details
   */
  @visibility("read")
  jobStageDetails?: Record<unknown>;
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
  @visibility("read")
  trackingUrl?: string;

  /**
   * Name of the carrier.
   */
  @visibility("read")
  carrierName?: string;

  /**
   * Tracking Id of shipment.
   */
  @visibility("read")
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
  logCollectionLevel?: LogCollectionLevel;
}

/**
 * Account details of the data to be transferred
 */
@discriminator("dataAccountType")
model DataAccountDetails {
  /**
   * Password for all the shares to be created on the device. Should not be passed for TransferType:ExportFromAzure jobs. If this is not passed, the service will generate password itself. This will not be returned in Get Call. Password Requirements :  Password must be minimum of 12 and maximum of 64 characters. Password must have at least one uppercase alphabet, one number and one special character. Password cannot have the following characters : IilLoO0 Password can have only alphabets, numbers and these characters : @#\-$%^!+=;:_()]+
   */
  @visibility("create")
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
  logCollectionLevel?: LogCollectionLevel;

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
  dataAccountType: DataAccountType;

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
  dataAccountType: DataAccountType;

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
  storageAccountAccessTierPreferences?: "Archive"[];
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
  @visibility("read")
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
Read only field
*/
  @visibility("read")
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
model CopyLogDetails {}

/**
 * Device erasure details with erasure completion status and erasureordestructionlog sas key
 */
model DeviceErasureDetails {
  /**
   * Holds the device erasure completion status
   */
  @visibility("read")
  deviceErasureStatus?: StageStatus;

  /**
   * Shared access key to download cleanup or destruction certificate for device
   */
  @visibility("read")
  erasureOrDestructionCertificateSasKey?: string;
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
possibility is that mitigation might happen by customer or service or by ops
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
   * List of supported carriers for return shipment.
   */
  @visibility("read")
  supportedCarriersForReturnShipment?: string[];

  /**
   * Azure Location where the Data Center serves primarily.
   */
  @visibility("read")
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

/**
 * Model of the Resource.
 */
model Resource {
  /**
   * The location of the resource. This will be one of the supported and registered Azure Regions (e.g. West US, East US, Southeast Asia, etc.). The region of a resource cannot be changed once it is created, but if an identical region is specified on update the request will succeed.
   */
  @visibility("read", "create")
  location: string;

  /**
   * The list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups).
   */
  tags?: Record<string>;

  /**
   * The sku type.
   */
  sku: Sku;

  /**
   * Msi identity of the resource
   */
  identity?: ResourceIdentity;
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
  @visibility("read")
  principalId?: string;

  /**
   * Home Tenant Id
   */
  @visibility("read")
  tenantId?: string;

  /**
   * User Assigned Identities
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * The Mitigate Job captured from request body for Mitigate API
 */
model MitigateJobRequest {
  /**
   * Resolution code for the job
   */
  customerResolutionCode: CustomerResolutionCode;

  /**
   * Serial number and the customer resolution code corresponding to each serial number
   */
  serialNumberCustomerResolutionMap?: Record<CustomerResolutionCode>;
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
model AvailableSkusResult is Azure.Core.Page<SkuInformation>;

/**
 * Information of the sku.
 */
model SkuInformation {
  /**
   * The Sku.
   */
  @visibility("read")
  sku?: Sku;

  /**
   * The sku is enabled or not.
   */
  @visibility("read")
  enabled?: boolean;

  /**
   * Properties of the sku.
   */
  @visibility("read")
  properties?: SkuProperties;
}

/**
 * Properties of the sku.
 */
model SkuProperties {
  /**
   * The map of data location to service location.
   */
  @visibility("read")
  dataLocationToServiceLocationMap?: DataLocationToServiceLocationMap[];

  /**
   * Capacity of the Sku.
   */
  @visibility("read")
  capacity?: SkuCapacity;

  /**
   * Cost of the Sku.
   */
  @visibility("read")
  costs?: SkuCost[];

  /**
   * Api versions that support this Sku.
   */
  @visibility("read")
  apiVersions?: string[];

  /**
   * Reason why the Sku is disabled.
   */
  @visibility("read")
  disabledReason?: SkuDisabledReason;

  /**
   * Message for why the Sku is disabled.
   */
  @visibility("read")
  disabledReasonMessage?: string;

  /**
   * Required feature to access the sku.
   */
  @visibility("read")
  requiredFeature?: string;

  /**
   * List of all the Countries in the SKU specific commerce boundary
   */
  @visibility("read")
  countriesWithinCommerceBoundary?: string[];
}

/**
 * Map of data location to service location
 */
model DataLocationToServiceLocationMap {
  /**
   * Location of the data.
   */
  @visibility("read")
  dataLocation?: string;

  /**
   * Location of the service.
   */
  @visibility("read")
  serviceLocation?: string;
}

/**
 * Capacity of the sku.
 */
model SkuCapacity {
  /**
   * Usable capacity in TB.
   */
  @visibility("read")
  usable?: string;

  /**
   * Maximum capacity in TB.
   */
  @visibility("read")
  maximum?: string;
}

/**
 * Describes metadata for retrieving price info.
 */
model SkuCost {
  /**
   * Meter id of the Sku.
   */
  @visibility("read")
  meterId?: string;

  /**
   * The type of the meter.
   */
  @visibility("read")
  meterType?: string;

  /**
   * Multiplier specifies the region specific value to be multiplied with 1$ guid. Eg: Our new regions will be using 1$ shipping guid with appropriate multiplier specific to region.
   */
  @visibility("read")
  multiplier?: float64;
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
   * Identifies the type of validation request.
   */
  validationType: "ValidateAddress";
}

/**
 * Minimum fields that must be present in any type of validation request.
 */
@discriminator("validationType")
model ValidationInputRequest {}

/**
 * Output of the address validation api.
 */
model AddressValidationOutput {
  /**
   * The address validation properties.
   */
  @visibility("read")
  properties?: AddressValidationProperties;
}

/**
 * The address validation output.
 */
model AddressValidationProperties extends ValidationInputResponse {
  /**
   * The address validation status.
   */
  @visibility("read")
  validationStatus?: AddressValidationStatus;

  /**
   * List of alternate addresses.
   */
  @visibility("read")
  alternateAddresses?: ShippingAddress[];

  /**
   * Identifies the type of validation response.
   */
  validationType: "ValidateAddress";
}

/**
 * Minimum properties that should be present in each individual validation response.
 */
@discriminator("validationType")
model ValidationInputResponse {
  /**
   * Error code and message of validation response.
   */
  @visibility("read")
  error?: CloudError;
}

/**
 * Minimum request requirement of any validation category.
 */
@discriminator("validationCategory")
model ValidationRequest {
  /**
   * List of request details contain validationType and its request as key and value respectively.
   */
  individualRequestDetails: ValidationInputRequest[];
}

/**
 * Response of pre job creation validations.
 */
model ValidationResponse {
  /**
   * Properties of pre job creation validation response.
   */
  @visibility("read")
  properties?: ValidationResponseProperties;
}

/**
 * Properties of pre job creation validation response.
 */
model ValidationResponseProperties {
  /**
   * Overall validation status.
   */
  @visibility("read")
  status?: OverallValidationStatus;

  /**
   * List of response details contain validationType and its response as key and value respectively.
   */
  @visibility("read")
  individualResponseDetails?: ValidationInputResponse[];
}

/**
 * The JobResourceUpdateParameter.
 */
model JobResourceUpdateParameter {
  /**
   * Properties of a job to be updated.
   */
  properties?: UpdateJobProperties;

  /**
   * The list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups).
   */
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
  @visibility("read")
  confirmationNumber?: string;

  /**
   * Time by which shipment should be ready for pick up, this is in local time of pick up area.
   */
  @visibility("read")
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
  @visibility("read")
  jobName?: string;

  /**
   * Secrets related to this job.
   */
  @visibility("read")
  jobSecrets?: JobSecrets;
}

/**
 * The base class for the secrets
 */
@discriminator("jobSecretsType")
model JobSecrets {
  /**
   * Dc Access Security Code for Customer Managed Shipping
   */
  @visibility("read")
  dcAccessSecurityCode?: DcAccessSecurityCode;

  /**
   * Error while fetching the secrets.
   */
  @visibility("read")
  error?: CloudError;
}

/**
 * Dc access security code
 */
model DcAccessSecurityCode {
  /**
   * Reverse Dc access security code.
   */
  reverseDCAccessCode?: string;

  /**
   * Forward Dc access security code.
   */
  forwardDCAccessCode?: string;
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
   * Country in which storage location should be supported.
   */
  country?: string;
}

/**
 * Request body to get the transport availability for given sku.
 */
model TransportAvailabilityRequest {
  /**
   * Type of the device.
   */
  skuName?: SkuName;
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
}

/**
 * Configuration response specific to a region.
 */
model RegionConfigurationResponse {
  /**
   * Schedule availability for given sku in a region.
   */
  @visibility("read")
  scheduleAvailabilityResponse?: ScheduleAvailabilityResponse;

  /**
   * Transport options available for given sku in a region.
   */
  @visibility("read")
  transportAvailabilityResponse?: TransportAvailabilityResponse;

  /**
   * Datacenter address for given sku in a region.
   */
  @visibility("read")
  datacenterAddressResponse?: DatacenterAddressResponse;
}

/**
 * Schedule availability for given sku in a region.
 */
model ScheduleAvailabilityResponse {
  /**
   * List of dates available to schedule
   */
  @visibility("read")
  availableDates?: utcDateTime[];
}

/**
 * Transport options available for given sku in a region.
 */
model TransportAvailabilityResponse {
  /**
   * List of transport availability details for given region
   */
  @visibility("read")
  transportAvailabilityDetails?: TransportAvailabilityDetails[];
}

/**
 * Transport options availability details for given region.
 */
model TransportAvailabilityDetails {
  /**
   * Transport Shipment Type supported for given region.
   */
  @visibility("read")
  shipmentType?: TransportShipmentTypes;
}

/**
 * Credential details of the account.
 */
model AccountCredentialDetails {
  /**
   * Name of the account.
   */
  @visibility("read")
  accountName?: string;

  /**
   * Type of the account.
   */
  @visibility("read")
  dataAccountType?: DataAccountType;

  /**
   * Connection string of the account endpoint to use the account as a storage endpoint on the device.
   */
  @visibility("read")
  accountConnectionString?: string;

  /**
   * Per share level unencrypted access credentials.
   */
  @visibility("read")
  shareCredentialDetails?: ShareCredentialDetails[];
}

/**
 * Credential details of the shares in account.
 */
model ShareCredentialDetails {
  /**
   * Name of the share.
   */
  @visibility("read")
  shareName?: string;

  /**
   * Type of the share.
   */
  @visibility("read")
  shareType?: ShareDestinationFormatType;

  /**
   * User name for the share.
   */
  @visibility("read")
  userName?: string;

  /**
   * Password for the share.
   */
  @visibility("read")
  password?: string;

  /**
   * Access protocols supported on the device.
   */
  @visibility("read")
  supportedAccessProtocols?: AccessProtocol[];
}

/**
 * The Network Adapter configuration of a DataBox.
 */
model ApplianceNetworkConfiguration {
  /**
   * Name of the network.
   */
  @visibility("read")
  name?: string;

  /**
   * Mac Address.
   */
  @visibility("read")
  macAddress?: string;
}

/**
 * Base class for all objects under resource.
 */
model ArmBaseObject {
  /**
   * Name of the object.
   */
  @visibility("read")
  name?: string;

  /**
   * Id of the object.
   */
  @visibility("read")
  id?: string;

  /**
   * Type of the object.
   */
  @visibility("read")
  type?: string;
}

/**
 * Granular Details for log generated during copy.
 */
@discriminator("copyLogDetailsType")
model GranularCopyLogDetails {}

/**
 * DataBox CustomerDisk Copy Progress
 */
model DataBoxCustomerDiskCopyProgress extends CopyProgress {
  /**
   * Disk Serial Number.
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * The Status of the copy
   */
  @visibility("read")
  copyStatus?: CopyStatus;
}

/**
 * Copy progress.
 */
model CopyProgress {
  /**
   * Name of the storage account. This will be empty for data account types other than storage account.
   */
  @visibility("read")
  storageAccountName?: string;

  /**
   * Transfer type of data
   */
  @visibility("read")
  transferType?: TransferType;

  /**
   * Data Account Type.
   */
  @visibility("read")
  dataAccountType?: DataAccountType;

  /**
   * Id of the account where the data needs to be uploaded.
   */
  @visibility("read")
  accountId?: string;

  /**
   * To indicate bytes transferred.
   */
  @visibility("read")
  bytesProcessed?: int64;

  /**
   * Total amount of data to be processed by the job.
   */
  @visibility("read")
  totalBytesToProcess?: int64;

  /**
   * Number of files processed
   */
  @visibility("read")
  filesProcessed?: int64;

  /**
   * Total files to process
   */
  @visibility("read")
  totalFilesToProcess?: int64;

  /**
   * Number of files not adhering to azure naming conventions which were processed by automatic renaming
   */
  @visibility("read")
  invalidFilesProcessed?: int64;

  /**
   * Total amount of data not adhering to azure naming conventions which were processed by automatic renaming
   */
  @visibility("read")
  invalidFileBytesUploaded?: int64;

  /**
   * Number of folders not adhering to azure naming conventions which were processed by automatic renaming
   */
  @visibility("read")
  renamedContainerCount?: int64;

  /**
   * Number of files which could not be copied
   */
  @visibility("read")
  filesErroredOut?: int64;

  /**
   * To indicate directories errored out in the job.
   */
  @visibility("read")
  directoriesErroredOut?: int64;

  /**
   * To indicate directories renamed
   */
  @visibility("read")
  invalidDirectoriesProcessed?: int64;

  /**
* To indicate if enumeration of data is in progress. 
Until this is true, the TotalBytesToProcess may not be valid.
*/
  @visibility("read")
  isEnumerationInProgress?: boolean;

  /**
   * Error, if any, in the stage
   */
  @visibility("read")
  error?: CloudError;

  /**
   * Available actions on the job.
   */
  @visibility("read")
  actions?: CustomerResolutionCode[];
}

/**
 * Granular Copy progress.
 */
model GranularCopyProgress {
  /**
   * Name of the storage account. This will be empty for data account types other than storage account.
   */
  @visibility("read")
  storageAccountName?: string;

  /**
   * Transfer type of data
   */
  @visibility("read")
  transferType?: TransferType;

  /**
   * Data Account Type.
   */
  @visibility("read")
  dataAccountType?: DataAccountType;

  /**
   * Id of the account where the data needs to be uploaded.
   */
  @visibility("read")
  accountId?: string;

  /**
   * To indicate bytes transferred.
   */
  @visibility("read")
  bytesProcessed?: int64;

  /**
   * Total amount of data to be processed by the job.
   */
  @visibility("read")
  totalBytesToProcess?: int64;

  /**
   * Number of files processed
   */
  @visibility("read")
  filesProcessed?: int64;

  /**
   * Total files to process
   */
  @visibility("read")
  totalFilesToProcess?: int64;

  /**
   * Number of files not adhering to azure naming conventions which were processed by automatic renaming
   */
  @visibility("read")
  invalidFilesProcessed?: int64;

  /**
   * Total amount of data not adhering to azure naming conventions which were processed by automatic renaming
   */
  @visibility("read")
  invalidFileBytesUploaded?: int64;

  /**
   * Number of folders not adhering to azure naming conventions which were processed by automatic renaming
   */
  @visibility("read")
  renamedContainerCount?: int64;

  /**
   * Number of files which could not be copied
   */
  @visibility("read")
  filesErroredOut?: int64;

  /**
   * To indicate directories errored out in the job.
   */
  @visibility("read")
  directoriesErroredOut?: int64;

  /**
   * To indicate directories renamed
   */
  @visibility("read")
  invalidDirectoriesProcessed?: int64;

  /**
* To indicate if enumeration of data is in progress. 
Until this is true, the TotalBytesToProcess may not be valid.
*/
  @visibility("read")
  isEnumerationInProgress?: boolean;

  /**
   * Error, if any, in the stage
   */
  @visibility("read")
  error?: CloudError;

  /**
   * Available actions on the job.
   */
  @visibility("read")
  actions?: CustomerResolutionCode[];
}

/**
 * It does all pre-job creation validations.
 */
model CreateJobValidations extends ValidationRequest {
  /**
   * Identify the nature of validation.
   */
  validationCategory: "JobCreationValidation";
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
   * Identifies the type of validation request.
   */
  validationType: "ValidateCreateOrderLimit";
}

/**
 * Properties of create order limit for subscription validation response.
 */
model CreateOrderLimitForSubscriptionValidationResponseProperties
  extends ValidationInputResponse {
  /**
   * Create order limit validation status.
   */
  @visibility("read")
  status?: ValidationStatus;

  /**
   * Identifies the type of validation response.
   */
  validationType: "ValidateCreateOrderLimit";
}

/**
 * Customer disk job details.
 */
model DataBoxCustomerDiskJobDetails extends JobDetails {
  /**
   * Contains the map of disk serial number to the disk details for import jobs.
   */
  importDiskDetailsCollection?: Record<ImportDiskDetails>;

  /**
   * Contains the map of disk serial number to the disk details for export jobs.
   */
  @visibility("read")
  exportDiskDetailsCollection?: Record<ExportDiskDetails>;

  /**
   * Copy progress per disk.
   */
  @visibility("read")
  copyProgress?: DataBoxCustomerDiskCopyProgress[];

  /**
   * Delivery package shipping details.
   */
  @visibility("read")
  deliverToDcPackageDetails?: PackageCarrierInfo;

  /**
   * Return package shipping details.
   */
  returnToCustomerPackageDetails: PackageCarrierDetails;

  /**
   * Flag to indicate if disk manifest should be backed-up in the Storage Account.
   */
  enableManifestBackup?: boolean;

  /**
   * Indicates the type of job details.
   */
  jobDetailsType: "DataBoxCustomerDisk";
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
  bitLockerKey: string;

  /**
   * Path to backed up manifest, only returned if enableManifestBackup is true.
   */
  @visibility("read")
  backupManifestCloudPath?: string;
}

/**
 * Export disk details
 */
model ExportDiskDetails {
  /**
   * The relative path of the manifest file on the disk.
   */
  @visibility("read")
  manifestFile?: string;

  /**
   * The Base16-encoded MD5 hash of the manifest file on the disk.
   */
  @visibility("read")
  manifestHash?: string;

  /**
   * Path to backed up manifest, only returned if enableManifestBackup is true.
   */
  @visibility("read")
  backupManifestCloudPath?: string;
}

/**
 * The secrets related to customer disk job.
 */
model CustomerDiskJobSecrets extends JobSecrets {
  /**
   * Contains the list of secrets object for that device.
   */
  @visibility("read")
  diskSecrets?: DiskSecret[];

  /**
   * Carrier Account Number of the customer
   */
  @visibility("read")
  carrierAccountNumber?: string;

  /**
   * Used to indicate what type of job secrets object.
   */
  jobSecretsType: "DataBoxCustomerDisk";
}

/**
 * Contains all the secrets of a Disk.
 */
model DiskSecret {
  /**
   * Serial number of the assigned disk.
   */
  @visibility("read")
  diskSerialNumber?: string;

  /**
   * Bit Locker key of the disk which can be used to unlock the disk to copy data.
   */
  @visibility("read")
  bitLockerKey?: string;
}

/**
 * Datacenter instruction for given storage location.
 */
model DatacenterAddressInstructionResponse extends DatacenterAddressResponse {
  /**
   * Data center communication instruction
   */
  @visibility("read")
  communicationInstruction?: string;

  /**
   * Data center address type
   */
  datacenterAddressType: "DatacenterAddressInstruction";
}

/**
 * Datacenter address for given storage location.
 */
model DatacenterAddressLocationResponse extends DatacenterAddressResponse {
  /**
   * Contact person name
   */
  @visibility("read")
  contactPersonName?: string;

  /**
   * Company name
   */
  @visibility("read")
  company?: string;

  /**
   * Street address line 1
   */
  @visibility("read")
  street1?: string;

  /**
   * Street address line 2
   */
  @visibility("read")
  street2?: string;

  /**
   * Street address line 3
   */
  @visibility("read")
  street3?: string;

  /**
   * City name
   */
  @visibility("read")
  city?: string;

  /**
   * name of the state
   */
  @visibility("read")
  state?: string;

  /**
   * Zip code
   */
  @visibility("read")
  zip?: string;

  /**
   * name of the country
   */
  @visibility("read")
  country?: string;

  /**
   * Phone number
   */
  @visibility("read")
  phone?: string;

  /**
   * Phone extension
   */
  @visibility("read")
  phoneExtension?: string;

  /**
   * Address type
   */
  @visibility("read")
  addressType?: string;

  /**
   * Special instruction for shipping
   */
  @visibility("read")
  additionalShippingInformation?: string;

  /**
   * Data center address type
   */
  datacenterAddressType: "DatacenterAddressLocation";
}

/**
 * Copy log details for a storage account of a DataBox job
 */
model DataBoxAccountCopyLogDetails extends CopyLogDetails {
  /**
   * Account name.
   */
  @visibility("read")
  accountName?: string;

  /**
   * Link for copy logs.
   */
  @visibility("read")
  copyLogLink?: string;

  /**
   * Link for copy verbose logs. This will be set only when LogCollectionLevel is set to Verbose.
   */
  @visibility("read")
  copyVerboseLogLink?: string;

  /**
   * Indicates the type of job details.
   */
  copyLogDetailsType: "DataBox";
}

/**
 * Copy Log Details for customer disk
 */
model DataBoxCustomerDiskCopyLogDetails extends CopyLogDetails {
  /**
   * Disk Serial Number.
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * Link for copy error logs.
   */
  @visibility("read")
  errorLogLink?: string;

  /**
   * Link for copy verbose logs.
   */
  @visibility("read")
  verboseLogLink?: string;

  /**
   * Indicates the type of job details.
   */
  copyLogDetailsType: "DataBoxCustomerDisk";
}

/**
 * Copy Log Details for a disk
 */
model DataBoxDiskCopyLogDetails extends CopyLogDetails {
  /**
   * Disk Serial Number.
   */
  @visibility("read")
  diskSerialNumber?: string;

  /**
   * Link for copy error logs.
   */
  @visibility("read")
  errorLogLink?: string;

  /**
   * Link for copy verbose logs.
   */
  @visibility("read")
  verboseLogLink?: string;

  /**
   * Indicates the type of job details.
   */
  copyLogDetailsType: "DataBoxDisk";
}

/**
 * Granular Copy Log Details for customer disk
 */
model DataBoxDiskGranularCopyLogDetails extends GranularCopyLogDetails {
  /**
   * Disk Serial Number.
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * Account id.
   */
  @visibility("read")
  accountId?: string;

  /**
   * Link for copy error logs.
   */
  @visibility("read")
  errorLogLink?: string;

  /**
   * Link for copy verbose logs.
   */
  @visibility("read")
  verboseLogLink?: string;

  /**
   * Indicates the type of job details.
   */
  copyLogDetailsType: "DataBoxCustomerDisk";
}

/**
 * DataBox Disk Copy Progress
 */
model DataBoxDiskCopyProgress {
  /**
   * The serial number of the disk
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * Bytes copied during the copy of disk.
   */
  @visibility("read")
  bytesCopied?: int64;

  /**
   * Indicates the percentage completed for the copy of the disk.
   */
  @visibility("read")
  percentComplete?: int32;

  /**
   * The Status of the copy
   */
  @visibility("read")
  status?: CopyStatus;

  /**
   * Error, if any, in the stage
   */
  @visibility("read")
  error?: CloudError;

  /**
   * Available actions on the job.
   */
  @visibility("read")
  actions?: CustomerResolutionCode[];
}

/**
 * DataBox Disk Granular Copy Progress
 */
model DataBoxDiskGranularCopyProgress extends GranularCopyProgress {
  /**
   * Disk Serial Number.
   */
  @visibility("read")
  serialNumber?: string;

  /**
   * The Status of the copy
   */
  @visibility("read")
  copyStatus?: CopyStatus;
}

/**
 * DataBox Disk Job Details.
 */
model DataBoxDiskJobDetails extends JobDetails {
  /**
   * User preference on what size disks are needed for the job. The map is from the disk size in TB to the count. Eg. {2,5} means 5 disks of 2 TB size. Key is string but will be checked against an int.
   */
  preferredDisks?: Record<int32>;

  /**
   * Copy progress per disk.
   */
  @visibility("read")
  copyProgress?: DataBoxDiskCopyProgress[];

  /**
   * Copy progress per disk.
   */
  @visibility("read")
  granularCopyProgress?: DataBoxDiskGranularCopyProgress[];

  /**
   * Copy progress per disk.
   */
  @visibility("read")
  granularCopyLogDetails?: DataBoxDiskGranularCopyLogDetails[];

  /**
   * Contains the map of disk serial number to the disk size being used for the job. Is returned only after the disks are shipped to the customer.
   */
  @visibility("read")
  disksAndSizeDetails?: Record<int32>;

  /**
   * User entered passkey for DataBox Disk job.
   */
  passkey?: string;

  /**
   * Indicates the type of job details.
   */
  jobDetailsType: "DataBoxDisk";
}

/**
 * The secrets related to disk job.
 */
model DataBoxDiskJobSecrets extends JobSecrets {
  /**
   * Contains the list of secrets object for that device.
   */
  @visibility("read")
  diskSecrets?: DiskSecret[];

  /**
   * PassKey for the disk Job.
   */
  @visibility("read")
  passKey?: string;

  /**
   * Whether passkey was provided by user.
   */
  @visibility("read")
  isPasskeyUserDefined?: boolean;

  /**
   * Used to indicate what type of job secrets object.
   */
  jobSecretsType: "DataBoxDisk";
}

/**
 * Copy log details for a storage account for Databox heavy
 */
model DataBoxHeavyAccountCopyLogDetails extends CopyLogDetails {
  /**
   * Account name.
   */
  @visibility("read")
  accountName?: string;

  /**
   * Link for copy logs.
   */
  @visibility("read")
  copyLogLink?: string[];

  /**
   * Link for copy verbose logs. This will be set only when the LogCollectionLevel is set to verbose.
   */
  @visibility("read")
  copyVerboseLogLink?: string[];

  /**
   * Indicates the type of job details.
   */
  copyLogDetailsType: "DataBoxHeavy";
}

/**
 * Databox Heavy Device Job Details
 */
model DataBoxHeavyJobDetails extends JobDetails {
  /**
   * Copy progress per account.
   */
  @visibility("read")
  copyProgress?: CopyProgress[];

  /**
   * Set Device password for unlocking Databox Heavy. Should not be passed for TransferType:ExportFromAzure jobs. If this is not passed, the service will generate password itself. This will not be returned in Get Call. Password Requirements :  Password must be minimum of 12 and maximum of 64 characters. Password must have at least one uppercase alphabet, one number and one special character. Password cannot have the following characters : IilLoO0 Password can have only alphabets, numbers and these characters : @#\-$%^!+=;:_()]+
   */
  devicePassword?: string;

  /**
   * Indicates the type of job details.
   */
  jobDetailsType: "DataBoxHeavy";
}

/**
 * The secrets related to a databox heavy job.
 */
model DataBoxHeavyJobSecrets extends JobSecrets {
  /**
   * Contains the list of secret objects for a databox heavy job.
   */
  @visibility("read")
  cabinetPodSecrets?: DataBoxHeavySecret[];

  /**
   * Used to indicate what type of job secrets object.
   */
  jobSecretsType: "DataBoxHeavy";
}

/**
 * The secrets related to a databox heavy.
 */
model DataBoxHeavySecret {
  /**
   * Serial number of the assigned device.
   */
  @visibility("read")
  deviceSerialNumber?: string;

  /**
   * Password for out of the box experience on device.
   */
  @visibility("read")
  devicePassword?: string;

  /**
   * Network configuration of the appliance.
   */
  @visibility("read")
  networkConfigurations?: ApplianceNetworkConfiguration[];

  /**
   * The base 64 encoded public key to authenticate with the device
   */
  @visibility("read")
  encodedValidationCertPubKey?: string;

  /**
   * Per account level access credentials.
   */
  @visibility("read")
  accountCredentialDetails?: AccountCredentialDetails[];
}

/**
 * Databox Job Details
 */
model DataBoxJobDetails extends JobDetails {
  /**
   * Copy progress per storage account.
   */
  @visibility("read")
  copyProgress?: CopyProgress[];

  /**
   * Set Device password for unlocking Databox. Should not be passed for TransferType:ExportFromAzure jobs. If this is not passed, the service will generate password itself. This will not be returned in Get Call. Password Requirements :  Password must be minimum of 12 and maximum of 64 characters. Password must have at least one uppercase alphabet, one number and one special character. Password cannot have the following characters : IilLoO0 Password can have only alphabets, numbers and these characters : @#\-$%^!+=;:_()]+
   */
  devicePassword?: string;

  /**
   * Indicates the type of job details.
   */
  jobDetailsType: "DataBox";
}

/**
 * The secrets related to a databox job.
 */
model DataboxJobSecrets extends JobSecrets {
  /**
   * Contains the list of secret objects for a job.
   */
  podSecrets?: DataBoxSecret[];

  /**
   * Used to indicate what type of job secrets object.
   */
  jobSecretsType: "DataBox";
}

/**
 * The secrets related to a DataBox.
 */
model DataBoxSecret {
  /**
   * Serial number of the assigned device.
   */
  @visibility("read")
  deviceSerialNumber?: string;

  /**
   * Password for out of the box experience on device.
   */
  @visibility("read")
  devicePassword?: string;

  /**
   * Network configuration of the appliance.
   */
  @visibility("read")
  networkConfigurations?: ApplianceNetworkConfiguration[];

  /**
   * The base 64 encoded public key to authenticate with the device
   */
  @visibility("read")
  encodedValidationCertPubKey?: string;

  /**
   * Per account level access credentials.
   */
  @visibility("read")
  accountCredentialDetails?: AccountCredentialDetails[];
}

/**
 * Request body to get the availability for scheduling data box orders orders.
 */
model DataBoxScheduleAvailabilityRequest extends ScheduleAvailabilityRequest {
  /**
   * Sku Name for which the order is to be scheduled.
   */
  skuName: "DataBox";
}

/**
 * Request to validate export and import data details.
 */
model DataTransferDetailsValidationRequest extends ValidationInputRequest {
  /**
   * List of DataTransfer details to be used to export data from azure.
   */
  dataExportDetails?: DataExportDetails[];

  /**
   * List of DataTransfer details to be used to import data to azure.
   */
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
   * Identifies the type of validation request.
   */
  validationType: "ValidateDataTransferDetails";
}

/**
 * Properties of data transfer details validation response.
 */
model DataTransferDetailsValidationResponseProperties
  extends ValidationInputResponse {
  /**
   * Data transfer details validation status.
   */
  @visibility("read")
  status?: ValidationStatus;

  /**
   * Identifies the type of validation response.
   */
  validationType: "ValidateDataTransferDetails";
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
  skuName: "DataBoxDisk";
}

/**
 * Request body to get the availability for scheduling heavy orders.
 */
model HeavyScheduleAvailabilityRequest extends ScheduleAvailabilityRequest {
  /**
   * Sku Name for which the order is to be scheduled.
   */
  skuName: "DataBoxHeavy";
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
  dataAccountType: "ManagedDisk";
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
   * Identifies the type of validation request.
   */
  validationType: "ValidatePreferences";
}

/**
 * Properties of data center and transport preference validation response.
 */
model PreferencesValidationResponseProperties extends ValidationInputResponse {
  /**
   * Validation status of requested data center and transport.
   */
  @visibility("read")
  status?: ValidationStatus;

  /**
   * Identifies the type of validation response.
   */
  validationType: "ValidatePreferences";
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
   * Identifies the type of validation request.
   */
  validationType: "ValidateSkuAvailability";
}

/**
 * Properties of sku availability validation response.
 */
model SkuAvailabilityValidationResponseProperties
  extends ValidationInputResponse {
  /**
   * Sku availability validation status.
   */
  @visibility("read")
  status?: ValidationStatus;

  /**
   * Identifies the type of validation response.
   */
  validationType: "ValidateSkuAvailability";
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
  dataAccountType: "StorageAccount";
}

/**
 * Request to validate subscription permission to create jobs.
 */
model SubscriptionIsAllowedToCreateJobValidationRequest
  extends ValidationInputRequest {
  /**
   * Identifies the type of validation request.
   */
  validationType: "ValidateSubscriptionIsAllowedToCreateJob";
}

/**
 * Properties of subscription permission to create job validation response.
 */
model SubscriptionIsAllowedToCreateJobValidationResponseProperties
  extends ValidationInputResponse {
  /**
   * Validation status of subscription permission to create job.
   */
  @visibility("read")
  status?: ValidationStatus;

  /**
   * Identifies the type of validation response.
   */
  validationType: "ValidateSubscriptionIsAllowedToCreateJob";
}
