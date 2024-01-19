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

@doc("Name of the stage which is in progress.")
enum StageName {
  @doc("An order has been created.") DeviceOrdered,
  @doc("A device has been prepared for the order.") DevicePrepared,
  @doc("Device has been dispatched to the user of the order.") Dispatched,
  @doc("Device has been delivered to the user of the order.") Delivered,
  @doc("Device has been picked up from user and in transit to Azure datacenter.")
  PickedUp,
  @doc("Device has been received at Azure datacenter from the user.") AtAzureDC,
  @doc("Data copy from the device at Azure datacenter.") DataCopy,
  @doc("Order has completed.") Completed,
  @doc("Order has completed with errors.") CompletedWithErrors,
  @doc("Order has been cancelled.") Cancelled,
  @doc("Order has failed due to issue reported by user.")
  Failed_IssueReportedAtCustomer,
  @doc("Order has failed due to issue detected at Azure datacenter.")
  Failed_IssueDetectedAtAzureDC,
  @doc("Order has been aborted.") Aborted,
  @doc("Order has completed with warnings.") CompletedWithWarnings,
  @doc("Device is ready to be handed to customer from Azure DC.")
  ReadyToDispatchFromAzureDC,
  @doc("Device can be dropped off at Azure DC.") ReadyToReceiveAtAzureDC,
  @doc("Job created by the customer.") Created,
  @doc("User shipped the device to AzureDC.") ShippedToAzureDC,
  @doc("Awaiting shipment details of device from customer.")
  AwaitingShipmentDetails,
  @doc("Preparing the device to ship to customer.") PreparingToShipFromAzureDC,
  @doc("Shipped the device to customer.") ShippedToCustomer,
}

@doc("Name of the stage.")
enum NotificationStageName {
  @doc("Notification at device prepared stage.") DevicePrepared,
  @doc("Notification at device dispatched stage.") Dispatched,
  @doc("Notification at device delivered stage.") Delivered,
  @doc("Notification at device picked up from user stage.") PickedUp,
  @doc("Notification at device received at Azure datacenter stage.") AtAzureDC,
  @doc("Notification at data copy started stage.") DataCopy,
  @doc("Notification at job created stage.") Created,
  @doc("Notification at shipped devices to customer stage.") ShippedToCustomer,
}

@doc("DataCenter code.")
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

@doc("The Status of the copy")
enum CopyStatus {
  @doc("Data copy hasn't started yet.") NotStarted,
  @doc("Data copy is in progress.") InProgress,
  @doc("Data copy completed.") Completed,
  @doc("Data copy completed with errors.") CompletedWithErrors,
  @doc("Data copy failed. No data was copied.") Failed,
  @doc("No copy triggered as device was not returned.") NotReturned,
  @doc("The Device has hit hardware issues.") HardwareError,
  @doc("Data copy failed. The Device was formatted by user.") DeviceFormatted,
  @doc("Data copy failed. Device metadata was modified by user.")
  DeviceMetadataModified,
  @doc("Data copy failed. Storage Account was not accessible during copy.")
  StorageAccountNotAccessible,
  @doc("Data copy failed. The Device data content is not supported.")
  UnsupportedData,
  @doc("No copy triggered as device was not received.") DriveNotReceived,
  @doc("No copy triggered as device type is not supported.") UnsupportedDrive,
  @doc("Copy failed due to service error.") OtherServiceError,
  @doc("Copy failed due to user error.") OtherUserError,
  @doc("Copy failed due to disk detection error.") DriveNotDetected,
  @doc("Copy failed due to corrupted drive.") DriveCorrupted,
  @doc("Copy failed due to modified or removed metadata files.")
  MetadataFilesModifiedOrRemoved,
}

@doc("Type of the transfer.")
@fixed
enum TransferType {
  @doc("Import data to azure.") ImportToAzure,
  @doc("Export data from azure.") ExportFromAzure,
}

@doc("The Editable status for Reverse Shipping Address and Contact Info")
@fixed
enum ReverseShippingDetailsEditStatus {
  @doc("Reverse shipping details can be edited.") Enabled,
  @doc("Edit is disabled for Reverse shipping details.") Disabled,
  @doc("Edit is not supported for Reverse shipping details. Either subscription feature is not available or SKU doesn't support this feature.")
  NotSupported,
}

@doc("The Editable status for Reverse Transport preferences")
@fixed
enum ReverseTransportPreferenceEditStatus {
  @doc("Reverse Transport Preferences can be edited.") Enabled,
  @doc("Edit is disabled for Reverse Transport Preferences.") Disabled,
  @doc("Edit is not supported for Reverse Transport Preferences. Either subscription feature is not available or SKU doesn't support this feature.")
  NotSupported,
}

@doc("Holds the device erasure completion status")
@fixed
enum StageStatus {
  @doc("No status available yet.") None,
  @doc("Stage is in progress.") InProgress,
  @doc("Stage has succeeded.") Succeeded,
  @doc("Stage has failed.") Failed,
  @doc("Stage has been cancelled.") Cancelled,
  @doc("Stage is cancelling.") Cancelling,
  @doc("Stage has succeeded with errors.") SucceededWithErrors,
  @doc("Stage is stuck until customer takes some action.")
  WaitingForCustomerAction,
  @doc("Stage has succeeded with warnings.") SucceededWithWarnings,
  @doc("Stage is waiting for customer action for kek action items.")
  WaitingForCustomerActionForKek,
  @doc("Stage is waiting for customer action for clean up.")
  WaitingForCustomerActionForCleanUp,
  @doc("Stage has performed customer action for clean up.")
  CustomerActionPerformedForCleanUp,
  @doc("Stage has performed customer action for clean up.")
  CustomerActionPerformed,
}

@doc("Type of address.")
@fixed
enum AddressType {
  @doc("Address type not known.") None,
  @doc("Residential Address.") Residential,
  @doc("Commercial Address.") Commercial,
}

@doc("Type of the account.")
@fixed
enum DataAccountType {
  @doc("Storage Accounts .") StorageAccount,
  @doc("Azure Managed disk storage.") ManagedDisk,
}

@doc("Level of the logs to be collected.")
@fixed
enum LogCollectionLevel {
  @doc("Only Errors will be collected in the logs.") Error,
  @doc("Verbose logging (includes Errors, CRC, size information and others).")
  Verbose,
}

@doc("Type of the configuration for transfer.")
@fixed
enum TransferConfigurationType {
  @doc("Transfer all the data.") TransferAll,
  @doc("Transfer using filter.") TransferUsingFilter,
}

@doc("Type of the filter file.")
@fixed
enum FilterFileType {
  @doc("Filter file is of the type AzureBlob.") AzureBlob,
  @doc("Filter file is of the type AzureFiles.") AzureFile,
}

@doc("Indicates the type of job details.")
@fixed
enum ClassDiscriminator {
  @doc("Data Box orders.") DataBox,
  @doc("Data Box Disk orders.") DataBoxDisk,
  @doc("Data Box Heavy orders.") DataBoxHeavy,
  @doc("Data Box Customer Disk orders.") DataBoxCustomerDisk,
}

@doc("Transport Shipment Type supported for given region.")
@fixed
enum TransportShipmentTypes {
  @doc("Shipment Logistics is handled by the customer.") CustomerManaged,
  @doc("Shipment Logistics is handled by Microsoft.") MicrosoftManaged,
}

@doc("Defines secondary layer of software-based encryption enablement.")
@fixed
enum DoubleEncryption {
  @doc("Software-based encryption is enabled.") Enabled,
  @doc("Software-based encryption is disabled.") Disabled,
}

@doc("Defines Hardware level encryption (Only for disk)")
@fixed
enum HardwareEncryption {
  @doc("Hardware-based encryption is enabled.") Enabled,
  @doc("Hardware-based encryption is enabled.") Disabled,
}

@doc("Type of encryption key used for key encryption.")
@fixed
enum KekType {
  @doc("Key encryption key is managed by Microsoft.") MicrosoftManaged,
  @doc("Key encryption key is managed by the Customer.") CustomerManaged,
}

@fixed
enum CustomerResolutionCode {
  @doc("No Resolution Yet") None,
  @doc("Clean the device") MoveToCleanUpDevice,
  @doc("Resume the job to same stage") Resume,
  @doc("Restart whole action.") Restart,
  @doc("Reach out to operation for further action.") ReachOutToOperation,
}

@doc("Data center address type")
@fixed
enum DatacenterAddressType {
  @doc("Data center address location.") DatacenterAddressLocation,
  @doc("Data center address instruction.") DatacenterAddressInstruction,
}

@doc("Delivery type of Job.")
@fixed
enum JobDeliveryType {
  @doc("Non Scheduled job.") NonScheduled,
  @doc("Scheduled job.") Scheduled,
}

@fixed
enum SkuName {
  @doc("Data Box.") DataBox,
  @doc("Data Box Disk.") DataBoxDisk,
  @doc("Data Box Heavy.") DataBoxHeavy,
  @doc("Data Box Customer Disk") DataBoxCustomerDisk,
}

@doc("Reason why the Sku is disabled.")
@fixed
enum SkuDisabledReason {
  @doc("SKU is not disabled.") None,
  @doc("SKU is not available in the requested country.") Country,
  @doc("SKU is not available to push data to the requested Azure region.")
  Region,
  @doc("Required features are not enabled for the SKU.") Feature,
  @doc("Subscription does not have required offer types for the SKU.")
  OfferType,
  @doc("Subscription has not registered to Microsoft.DataBox and Service does not have the subscription notification.")
  NoSubscriptionInfo,
}

@doc("Identifies the type of validation request.")
@fixed
enum ValidationInputDiscriminator {
  @doc("Identify request and response of address validation.") ValidateAddress,
  @doc("Identify request and response for validation of subscription permission to create job.")
  ValidateSubscriptionIsAllowedToCreateJob,
  @doc("Identify request and response of preference validation.")
  ValidatePreferences,
  @doc("Identify request and response of create order limit for subscription validation.")
  ValidateCreateOrderLimit,
  @doc("Identify request and response of active job limit for sku availability.")
  ValidateSkuAvailability,
  @doc("Identify request and response of data transfer details validation.")
  ValidateDataTransferDetails,
}

@doc("The address validation status.")
@fixed
enum AddressValidationStatus {
  @doc("Address provided is valid.") Valid,
  @doc("Address provided is invalid or not supported.") Invalid,
  @doc("Address provided is ambiguous, please choose one of the alternate addresses returned.")
  Ambiguous,
}

@doc("Overall validation status.")
@fixed
enum OverallValidationStatus {
  @doc("Every input request is valid.") AllValidToProceed,
  @doc("Some input requests are not valid.") InputsRevisitRequired,
  @doc("Certain input validations skipped.") CertainInputValidationsSkipped,
}

@doc("Type of the share.")
@fixed
enum ShareDestinationFormatType {
  @doc("Unknown format.") UnknownType,
  @doc("Storsimple data format.") HCS,
  @doc("Azure storage block blob format.") BlockBlob,
  @doc("Azure storage page blob format.") PageBlob,
  @doc("Azure storage file format.") AzureFile,
  @doc("Azure Compute Disk.") ManagedDisk,
}

@fixed
enum AccessProtocol {
  @doc("Server Message Block protocol(SMB).") SMB,
  @doc("Network File System protocol(NFS).") NFS,
}

@doc("Create order limit validation status.")
@fixed
enum ValidationStatus {
  @doc("Validation is successful") Valid,
  @doc("Validation is not successful") Invalid,
  @doc("Validation is skipped") Skipped,
}

@error
model ApiError {
  error: ErrorDetail;
}

model Details {
  code: string;
  message: string;
}

@doc("Job Properties")
model JobProperties {
  @doc("Type of the data transfer.")
  transferType: TransferType;

  @doc("Describes whether the job is cancellable or not.")
  @visibility("read")
  isCancellable?: boolean;

  @doc("Describes whether the job is deletable or not.")
  @visibility("read")
  isDeletable?: boolean;

  @doc("Describes whether the shipping address is editable or not.")
  @visibility("read")
  isShippingAddressEditable?: boolean;

  @doc("The Editable status for Reverse Shipping Address and Contact Info")
  @visibility("read")
  reverseShippingDetailsUpdate?: ReverseShippingDetailsEditStatus;

  @doc("The Editable status for Reverse Transport preferences")
  @visibility("read")
  reverseTransportPreferenceUpdate?: ReverseTransportPreferenceEditStatus;

  @doc("Is Prepare To Ship Enabled on this job")
  @visibility("read")
  isPrepareToShipEnabled?: boolean;

  @doc("Name of the stage which is in progress.")
  @visibility("read")
  status?: StageName;

  @doc("Time at which the job was started in UTC ISO 8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Top level error for the job.")
  @visibility("read")
  error?: CloudError;

  @doc("Details of a job run. This field will only be sent for expand details filter.")
  details?: JobDetails;

  @doc("Reason for cancellation.")
  @visibility("read")
  cancellationReason?: string;

  @doc("Delivery type of Job.")
  deliveryType?: JobDeliveryType;

  @doc("Delivery Info of Job.")
  deliveryInfo?: JobDeliveryInfo;

  @doc("Flag to indicate cancellation of scheduled job.")
  @visibility("read")
  isCancellableWithoutFee?: boolean;
}

@doc("Provides additional information about an http error response.")
model CloudError {
  @doc("Gets or sets additional error info.")
  @visibility("read")
  additionalInfo?: AdditionalErrorInfo[];

  @doc("Error code.")
  code?: string;

  @doc("Gets or sets details for the error.")
  @visibility("read")
  details?: CloudError[];

  @doc("The error message parsed from the body of the http error response.")
  message?: string;

  @doc("Gets or sets the target of the error.")
  target?: string;
}

@doc("This class represents additional info which Resource Providers pass when an error occurs.")
model AdditionalErrorInfo {
  @doc("Additional information of the type of error.")
  info?: Record<unknown>;

  @doc("Type of error (e.g. CustomerIntervention, PolicyViolation, SecurityViolation).")
  type?: string;
}

@doc("Job details.")
@discriminator("jobDetailsType")
model JobDetails {
  @doc("List of stages that run in the job.")
  @visibility("read")
  jobStages?: JobStages[];

  @doc("Contact details for notification and shipping.")
  contactDetails: ContactDetails;

  @doc("Shipping address of the customer.")
  shippingAddress?: ShippingAddress;

  @doc("Delivery package shipping details.")
  @visibility("read")
  deliveryPackage?: PackageShippingDetails;

  @doc("Return package shipping details.")
  @visibility("read")
  returnPackage?: PackageShippingDetails;

  @doc("Details of the data to be imported into azure.")
  dataImportDetails?: DataImportDetails[];

  @doc("Details of the data to be exported from azure.")
  dataExportDetails?: DataExportDetails[];

  @doc("Preferences for the order.")
  preferences?: Preferences;

  @doc("Optional Reverse Shipping details for order.")
  reverseShippingDetails?: ReverseShippingDetails;

  @doc("List of copy log details.")
  @visibility("read")
  copyLogDetails?: CopyLogDetails[];

  @doc("Shared access key to download the return shipment label")
  @visibility("read")
  reverseShipmentLabelSasKey?: string;

  @doc("Shared access key to download the chain of custody logs")
  @visibility("read")
  chainOfCustodySasKey?: string;

  @doc("Holds device data erasure details")
  @visibility("read")
  deviceErasureDetails?: DeviceErasureDetails;

  @doc("Details about which key encryption type is being used.")
  keyEncryptionKey?: KeyEncryptionKey;

  @doc("The expected size of the data, which needs to be transferred in this job, in terabytes.")
  expectedDataSizeInTeraBytes?: int32;

  @doc("Available actions on the job.")
  @visibility("read")
  actions?: CustomerResolutionCode[];

  @doc("Last mitigation action performed on the job.")
  @visibility("read")
  lastMitigationActionOnJob?: LastMitigationActionOnJob;

  @doc("Datacenter address to ship to, for the given sku and storage location.")
  @visibility("read")
  datacenterAddress?: DatacenterAddressResponse;

  @doc("DataCenter code.")
  @visibility("read")
  dataCenterCode?: DataCenterCode;
}

@doc("Job stages.")
model JobStages {
  @doc("Name of the job stage.")
  @visibility("read")
  stageName?: StageName;

  @doc("Display name of the job stage.")
  @visibility("read")
  displayName?: string;

  @doc("Status of the job stage.")
  @visibility("read")
  stageStatus?: StageStatus;

  @doc("Time for the job stage in UTC ISO 8601 format.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  stageTime?: utcDateTime;

  @doc("Job Stage Details")
  @visibility("read")
  jobStageDetails?: Record<unknown>;
}

@doc("Contact Details.")
model ContactDetails {
  @doc("Contact name of the person.")
  contactName: string;

  @doc("Phone number of the contact person.")
  phone: string;

  @doc("Phone extension number of the contact person.")
  phoneExtension?: string;

  @doc("Mobile number of the contact person.")
  mobile?: string;

  @doc("List of Email-ids to be notified about job progress.")
  emailList: string[];

  @doc("Notification preference for a job stage.")
  notificationPreference?: NotificationPreference[];
}

@doc("Notification preference for a job stage.")
model NotificationPreference {
  @doc("Name of the stage.")
  stageName: NotificationStageName;

  @doc("Notification is required or not.")
  sendNotification: boolean;
}

@doc("Shipping address where customer wishes to receive the device.")
model ShippingAddress {
  @doc("Street Address line 1.")
  streetAddress1: string;

  @doc("Street Address line 2.")
  streetAddress2?: string;

  @doc("Street Address line 3.")
  streetAddress3?: string;

  @doc("Name of the City.")
  city?: string;

  @doc("Name of the State or Province.")
  stateOrProvince?: string;

  @doc("Name of the Country.")
  country: string;

  @doc("Postal code.")
  postalCode?: string;

  @doc("Extended Zip Code.")
  zipExtendedCode?: string;

  @doc("Name of the company.")
  companyName?: string;

  @doc("Type of address.")
  addressType?: AddressType;

  @doc("Flag to indicate if customer has chosen to skip default address validation")
  skipAddressValidation?: boolean;

  @doc("Tax Identification Number")
  taxIdentificationNumber?: string;
}

@doc("package shipping details")
model PackageShippingDetails {
  @doc("Url where shipment can be tracked.")
  @visibility("read")
  trackingUrl?: string;

  @doc("Name of the carrier.")
  @visibility("read")
  carrierName?: string;

  @doc("Tracking Id of shipment.")
  @visibility("read")
  trackingId?: string;
}

@doc("Details of the data to be used for importing data to azure.")
model DataImportDetails {
  @doc("Account details of the data to be transferred")
  accountDetails: DataAccountDetails;

  @doc("Level of the logs to be collected.")
  logCollectionLevel?: LogCollectionLevel;
}

@doc("Account details of the data to be transferred")
@discriminator("dataAccountType")
model DataAccountDetails {
  @doc("Password for all the shares to be created on the device. Should not be passed for TransferType:ExportFromAzure jobs. If this is not passed, the service will generate password itself. This will not be returned in Get Call. Password Requirements :  Password must be minimum of 12 and maximum of 64 characters. Password must have at least one uppercase alphabet, one number and one special character. Password cannot have the following characters : IilLoO0 Password can have only alphabets, numbers and these characters : @#\\-$%^!+=;:_()]+")
  @visibility("create")
  sharePassword?: string;
}

@doc("Details of the data to be used for exporting data from azure.")
model DataExportDetails {
  @doc("Configuration for the data transfer.")
  transferConfiguration: TransferConfiguration;

  @doc("Level of the logs to be collected.")
  logCollectionLevel?: LogCollectionLevel;

  @doc("Account details of the data to be transferred")
  accountDetails: DataAccountDetails;
}

@doc("Configuration for defining the transfer of data.")
model TransferConfiguration {
  @doc("Type of the configuration for transfer.")
  transferConfigurationType: TransferConfigurationType;

  @doc("Map of filter type and the details to filter. This field is required only if the TransferConfigurationType is given as TransferUsingFilter.")
  transferFilterDetails?: TransferConfigurationTransferFilterDetails;

  @doc("Map of filter type and the details to transfer all data. This field is required only if the TransferConfigurationType is given as TransferAll")
  transferAllDetails?: TransferConfigurationTransferAllDetails;
}

@doc("Map of filter type and the details to filter. This field is required only if the TransferConfigurationType is given as TransferUsingFilter.")
model TransferConfigurationTransferFilterDetails {
  @doc("Details of the filtering the transfer of data.")
  include?: TransferFilterDetails;
}

@doc("Details of the filtering the transfer of data.")
model TransferFilterDetails {
  @doc("Type of the account of data.")
  dataAccountType: DataAccountType;

  @doc("Filter details to transfer blobs.")
  blobFilterDetails?: BlobFilterDetails;

  @doc("Filter details to transfer Azure files.")
  azureFileFilterDetails?: AzureFileFilterDetails;

  @doc("Details of the filter files to be used for data transfer.")
  filterFileDetails?: FilterFileDetails[];
}

@doc("Filter details to transfer Azure Blobs")
model BlobFilterDetails {
  @doc("Prefix list of the Azure blobs to be transferred.")
  blobPrefixList?: string[];

  @doc("List of full path of the blobs to be transferred.")
  blobPathList?: string[];

  @doc("List of blob containers to be transferred.")
  containerList?: string[];
}

@doc("Filter details to transfer Azure files")
model AzureFileFilterDetails {
  @doc("Prefix list of the Azure files to be transferred.")
  filePrefixList?: string[];

  @doc("List of full path of the files to be transferred.")
  filePathList?: string[];

  @doc("List of file shares to be transferred.")
  fileShareList?: string[];
}

@doc("Details of the filter files to be used for data transfer.")
model FilterFileDetails {
  @doc("Type of the filter file.")
  filterFileType: FilterFileType;

  @doc("Path of the file that contains the details of all items to transfer.")
  filterFilePath: string;
}

@doc("Map of filter type and the details to transfer all data. This field is required only if the TransferConfigurationType is given as TransferAll")
model TransferConfigurationTransferAllDetails {
  @doc("Details to transfer all data.")
  include?: TransferAllDetails;
}

@doc("Details to transfer all data.")
model TransferAllDetails {
  @doc("Type of the account of data")
  dataAccountType: DataAccountType;

  @doc("To indicate if all Azure blobs have to be transferred")
  transferAllBlobs?: boolean;

  @doc("To indicate if all Azure Files have to be transferred")
  transferAllFiles?: boolean;
}

@doc("Preferences related to the order")
model Preferences {
  @doc("Preferred data center region.")
  preferredDataCenterRegion?: string[];

  @doc("Preferences related to the shipment logistics of the sku.")
  transportPreferences?: TransportPreferences;

  @doc("Optional Preferences related to the reverse shipment logistics of the sku.")
  reverseTransportPreferences?: TransportPreferences;

  @doc("Preferences related to the Encryption.")
  encryptionPreferences?: EncryptionPreferences;

  @doc("Preferences related to the Access Tier of storage accounts.")
  storageAccountAccessTierPreferences?: "Archive"[];
}

@doc("Preferences related to the shipment logistics of the sku")
model TransportPreferences {
  @doc("Indicates Shipment Logistics type that the customer preferred.")
  preferredShipmentType: TransportShipmentTypes;

  @doc("Read only property which indicates whether transport preferences has been updated or not after device is prepared.")
  @visibility("read")
  isUpdated?: boolean;
}

@doc("Preferences related to the Encryption.")
model EncryptionPreferences {
  @doc("Defines secondary layer of software-based encryption enablement.")
  doubleEncryption?: DoubleEncryption;

  @doc("Defines Hardware level encryption (Only for disk)")
  hardwareEncryption?: HardwareEncryption;
}

@doc("Reverse Shipping Address and contact details for a job.")
model ReverseShippingDetails {
  @doc("Contact Info.")
  contactDetails?: ContactInfo;

  @doc("Shipping address where customer wishes to receive the device.")
  shippingAddress?: ShippingAddress;

  @doc("""
A flag to indicate whether Reverse Shipping details are updated or not after device has been prepared.
Read only field
""")
  @visibility("read")
  isUpdated?: boolean;
}

@doc("Contact Info.")
model ContactInfo {
  @doc("Contact name of the person.")
  @minLength(1)
  contactName: string;

  @doc("Phone number of the contact person.")
  @minLength(1)
  phone: string;

  @doc("Phone extension number of the contact person.")
  phoneExtension?: string;

  @doc("Mobile number of the contact person.")
  mobile?: string;
}

@doc("Details for log generated during copy.")
@discriminator("copyLogDetailsType")
model CopyLogDetails {}

@doc("Device erasure details with erasure completion status and erasureordestructionlog sas key")
model DeviceErasureDetails {
  @doc("Holds the device erasure completion status")
  @visibility("read")
  deviceErasureStatus?: StageStatus;

  @doc("Shared access key to download cleanup or destruction certificate for device")
  @visibility("read")
  erasureOrDestructionCertificateSasKey?: string;
}

@doc("Encryption key containing details about key to encrypt different keys.")
model KeyEncryptionKey {
  @doc("Type of encryption key used for key encryption.")
  kekType: KekType;

  @doc("Managed identity properties used for key encryption.")
  identityProperties?: IdentityProperties;

  @doc("Key encryption key. It is required in case of Customer managed KekType.")
  kekUrl?: string;

  @doc("Kek vault resource id. It is required in case of Customer managed KekType.")
  kekVaultResourceID?: string;
}

@doc("Managed identity properties.")
model IdentityProperties {
  @doc("Managed service identity type.")
  type?: string;

  @doc("User assigned identity properties.")
  userAssigned?: UserAssignedProperties;
}

@doc("User assigned identity properties.")
model UserAssignedProperties {
  @doc("Arm resource id for user assigned identity to be used to fetch MSI token.")
  resourceId?: string;
}

@doc("Last Mitigation Action Performed On Job")
model LastMitigationActionOnJob {
  @doc("Action performed date time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  actionDateTimeInUtc?: utcDateTime;

  @doc("""
Action performed by customer,
possibility is that mitigation might happen by customer or service or by ops
""")
  isPerformedByCustomer?: boolean;

  @doc("Resolution code provided by customer")
  customerResolution?: CustomerResolutionCode;
}

@doc("Datacenter address for given storage location.")
@discriminator("datacenterAddressType")
model DatacenterAddressResponse {
  @doc("List of supported carriers for return shipment.")
  @visibility("read")
  supportedCarriersForReturnShipment?: string[];

  @doc("Azure Location where the Data Center serves primarily.")
  @visibility("read")
  dataCenterAzureLocation?: string;
}

@doc("Additional delivery info.")
model JobDeliveryInfo {
  @doc("Scheduled date time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledDateTime?: utcDateTime;
}

@doc("Model of the Resource.")
model Resource {
  @doc("The location of the resource. This will be one of the supported and registered Azure Regions (e.g. West US, East US, Southeast Asia, etc.). The region of a resource cannot be changed once it is created, but if an identical region is specified on update the request will succeed.")
  @visibility("read", "create")
  location: string;

  @doc("The list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups).")
  tags?: Record<string>;

  @doc("The sku type.")
  sku: Sku;

  @doc("Msi identity of the resource")
  identity?: ResourceIdentity;
}

@doc("The Sku.")
model Sku {
  @doc("The sku name.")
  name: SkuName;

  @doc("The display name of the sku.")
  displayName?: string;

  @doc("The sku family.")
  family?: string;
}

@doc("Msi identity details of the resource")
model ResourceIdentity {
  @doc("Identity type")
  type?: string;

  @doc("Service Principal Id backing the Msi")
  @visibility("read")
  principalId?: string;

  @doc("Home Tenant Id")
  @visibility("read")
  tenantId?: string;

  @doc("User Assigned Identities")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("The Mitigate Job captured from request body for Mitigate API")
model MitigateJobRequest {
  @doc("Resolution code for the job")
  customerResolutionCode: CustomerResolutionCode;

  @doc("Serial number and the customer resolution code corresponding to each serial number")
  serialNumberCustomerResolutionMap?: Record<CustomerResolutionCode>;
}

@doc("The request body to provide the delivery package details of job")
model MarkDevicesShippedRequest {
  @doc("Delivery package details")
  deliverToDcPackageDetails: PackageCarrierInfo;
}

@doc("package carrier info")
model PackageCarrierInfo {
  @doc("Name of the carrier.")
  carrierName?: string;

  @doc("Tracking Id of shipment.")
  trackingId?: string;
}

@doc("The filters for showing the available skus.")
model AvailableSkuRequest {
  @doc("Type of the transfer.")
  transferType: TransferType;

  @doc("ISO country code. Country for hardware shipment. For codes check: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements")
  country: string;

  @doc("Location for data transfer. For locations check: https://management.azure.com/subscriptions/SUBSCRIPTIONID/locations?api-version=2018-01-01")
  location: string;

  @doc("Sku Names to filter for available skus")
  skuNames?: SkuName[];
}

@doc("The available skus operation response.")
model AvailableSkusResult is Azure.Core.Page<SkuInformation>;

@doc("Information of the sku.")
model SkuInformation {
  @doc("The Sku.")
  @visibility("read")
  sku?: Sku;

  @doc("The sku is enabled or not.")
  @visibility("read")
  enabled?: boolean;

  @doc("Properties of the sku.")
  @visibility("read")
  properties?: SkuProperties;
}

@doc("Properties of the sku.")
model SkuProperties {
  @doc("The map of data location to service location.")
  @visibility("read")
  dataLocationToServiceLocationMap?: DataLocationToServiceLocationMap[];

  @doc("Capacity of the Sku.")
  @visibility("read")
  capacity?: SkuCapacity;

  @doc("Cost of the Sku.")
  @visibility("read")
  costs?: SkuCost[];

  @doc("Api versions that support this Sku.")
  @visibility("read")
  apiVersions?: string[];

  @doc("Reason why the Sku is disabled.")
  @visibility("read")
  disabledReason?: SkuDisabledReason;

  @doc("Message for why the Sku is disabled.")
  @visibility("read")
  disabledReasonMessage?: string;

  @doc("Required feature to access the sku.")
  @visibility("read")
  requiredFeature?: string;

  @doc("List of all the Countries in the SKU specific commerce boundary")
  @visibility("read")
  countriesWithinCommerceBoundary?: string[];
}

@doc("Map of data location to service location")
model DataLocationToServiceLocationMap {
  @doc("Location of the data.")
  @visibility("read")
  dataLocation?: string;

  @doc("Location of the service.")
  @visibility("read")
  serviceLocation?: string;
}

@doc("Capacity of the sku.")
model SkuCapacity {
  @doc("Usable capacity in TB.")
  @visibility("read")
  usable?: string;

  @doc("Maximum capacity in TB.")
  @visibility("read")
  maximum?: string;
}

@doc("Describes metadata for retrieving price info.")
model SkuCost {
  @doc("Meter id of the Sku.")
  @visibility("read")
  meterId?: string;

  @doc("The type of the meter.")
  @visibility("read")
  meterType?: string;

  @doc("Multiplier specifies the region specific value to be multiplied with 1$ guid. Eg: Our new regions will be using 1$ shipping guid with appropriate multiplier specific to region.")
  @visibility("read")
  multiplier?: float32;
}

@doc("The requirements to validate customer address where the device needs to be shipped.")
model ValidateAddress extends ValidationInputRequest {
  @doc("Shipping address of the customer.")
  shippingAddress: ShippingAddress;

  @doc("Device type to be used for the job.")
  deviceType: SkuName;

  @doc("Preferences related to the shipment logistics of the sku.")
  transportPreferences?: TransportPreferences;

  @doc("Identifies the type of validation request.")
  validationType: "ValidateAddress";
}

@doc("Minimum fields that must be present in any type of validation request.")
@discriminator("validationType")
model ValidationInputRequest {}

@doc("Output of the address validation api.")
model AddressValidationOutput {
  @doc("The address validation properties.")
  @visibility("read")
  properties?: AddressValidationProperties;
}

@doc("The address validation output.")
model AddressValidationProperties extends ValidationInputResponse {
  @doc("The address validation status.")
  @visibility("read")
  validationStatus?: AddressValidationStatus;

  @doc("List of alternate addresses.")
  @visibility("read")
  alternateAddresses?: ShippingAddress[];

  @doc("Identifies the type of validation response.")
  validationType: "ValidateAddress";
}

@doc("Minimum properties that should be present in each individual validation response.")
@discriminator("validationType")
model ValidationInputResponse {
  @doc("Error code and message of validation response.")
  @visibility("read")
  error?: CloudError;
}

@doc("Minimum request requirement of any validation category.")
@discriminator("validationCategory")
model ValidationRequest {
  @doc("List of request details contain validationType and its request as key and value respectively.")
  individualRequestDetails: ValidationInputRequest[];
}

@doc("Response of pre job creation validations.")
model ValidationResponse {
  @doc("Properties of pre job creation validation response.")
  @visibility("read")
  properties?: ValidationResponseProperties;
}

@doc("Properties of pre job creation validation response.")
model ValidationResponseProperties {
  @doc("Overall validation status.")
  @visibility("read")
  status?: OverallValidationStatus;

  @doc("List of response details contain validationType and its response as key and value respectively.")
  @visibility("read")
  individualResponseDetails?: ValidationInputResponse[];
}

@doc("The JobResourceUpdateParameter.")
model JobResourceUpdateParameter {
  @doc("Properties of a job to be updated.")
  properties?: UpdateJobProperties;

  @doc("The list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups).")
  tags?: Record<string>;

  @doc("Msi identity of the resource")
  identity?: ResourceIdentity;
}

@doc("Job Properties for update")
model UpdateJobProperties {
  @doc("Details of a job to be updated.")
  details?: UpdateJobDetails;
}

@doc("Job details for update.")
model UpdateJobDetails {
  @doc("Contact details for notification and shipping.")
  contactDetails?: ContactDetails;

  @doc("Shipping address of the customer.")
  shippingAddress?: ShippingAddress;

  @doc("Reverse Shipping Address and contact details for a job.")
  reverseShippingDetails?: ReverseShippingDetails;

  @doc("Preferences related to the order")
  preferences?: Preferences;

  @doc("Key encryption key for the job.")
  keyEncryptionKey?: KeyEncryptionKey;

  @doc("Return package details of job.")
  returnToCustomerPackageDetails?: PackageCarrierDetails;
}

@doc("Package carrier details.")
model PackageCarrierDetails {
  @doc("Carrier Account Number of customer for customer disk.")
  carrierAccountNumber?: string;

  @doc("Name of the carrier.")
  carrierName?: string;

  @doc("Tracking Id of shipment.")
  trackingId?: string;
}

@doc("Shipment pick up request details.")
model ShipmentPickUpRequest {
  @doc("Minimum date after which the pick up should commence, this must be in local time of pick up area.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  @doc("Maximum date before which the pick up should commence, this must be in local time of pick up area.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime: utcDateTime;

  @doc("Shipment Location in the pickup place. Eg.front desk")
  shipmentLocation: string;
}

@doc("Shipment pick up response.")
model ShipmentPickUpResponse {
  @doc("Confirmation number for the pick up request.")
  @visibility("read")
  confirmationNumber?: string;

  @doc("Time by which shipment should be ready for pick up, this is in local time of pick up area.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  readyByTime?: utcDateTime;
}

@doc("Reason for cancellation.")
model CancellationReason {
  @doc("Reason for cancellation.")
  reason: string;
}

@doc("List of unencrypted credentials for accessing device.")
model UnencryptedCredentialsList is Azure.Core.Page<UnencryptedCredentials>;

@doc("Unencrypted credentials for accessing device.")
model UnencryptedCredentials {
  @doc("Name of the job.")
  @visibility("read")
  jobName?: string;

  @doc("Secrets related to this job.")
  @visibility("read")
  jobSecrets?: JobSecrets;
}

@doc("The base class for the secrets")
@discriminator("jobSecretsType")
model JobSecrets {
  @doc("Dc Access Security Code for Customer Managed Shipping")
  @visibility("read")
  dcAccessSecurityCode?: DcAccessSecurityCode;

  @doc("Error while fetching the secrets.")
  @visibility("read")
  error?: CloudError;
}

@doc("Dc access security code")
model DcAccessSecurityCode {
  @doc("Reverse Dc access security code.")
  reverseDCAccessCode?: string;

  @doc("Forward Dc access security code.")
  forwardDCAccessCode?: string;
}

@doc("Request body to get the configuration for the region.")
model RegionConfigurationRequest {
  @doc("Request body to get the availability for scheduling orders.")
  scheduleAvailabilityRequest?: ScheduleAvailabilityRequest;

  @doc("Request body to get the transport availability for given sku.")
  transportAvailabilityRequest?: TransportAvailabilityRequest;

  @doc("Request body to get the datacenter address for given sku.")
  datacenterAddressRequest?: DatacenterAddressRequest;
}

@doc("Request body to get the availability for scheduling orders.")
@discriminator("skuName")
model ScheduleAvailabilityRequest {
  @doc("Location for data transfer. For locations check: https://management.azure.com/subscriptions/SUBSCRIPTIONID/locations?api-version=2018-01-01")
  storageLocation: string;

  @doc("Country in which storage location should be supported.")
  country?: string;
}

@doc("Request body to get the transport availability for given sku.")
model TransportAvailabilityRequest {
  @doc("Type of the device.")
  skuName?: SkuName;
}

@doc("Request body to get the datacenter address.")
model DatacenterAddressRequest {
  @doc("Storage location. For locations check: https://management.azure.com/subscriptions/SUBSCRIPTIONID/locations?api-version=2018-01-01")
  storageLocation: string;

  @doc("Sku Name for which the data center address requested.")
  skuName: SkuName;
}

@doc("Configuration response specific to a region.")
model RegionConfigurationResponse {
  @doc("Schedule availability for given sku in a region.")
  @visibility("read")
  scheduleAvailabilityResponse?: ScheduleAvailabilityResponse;

  @doc("Transport options available for given sku in a region.")
  @visibility("read")
  transportAvailabilityResponse?: TransportAvailabilityResponse;

  @doc("Datacenter address for given sku in a region.")
  @visibility("read")
  datacenterAddressResponse?: DatacenterAddressResponse;
}

@doc("Schedule availability for given sku in a region.")
model ScheduleAvailabilityResponse {
  @doc("List of dates available to schedule")
  @visibility("read")
  availableDates?: utcDateTime[];
}

@doc("Transport options available for given sku in a region.")
model TransportAvailabilityResponse {
  @doc("List of transport availability details for given region")
  @visibility("read")
  transportAvailabilityDetails?: TransportAvailabilityDetails[];
}

@doc("Transport options availability details for given region.")
model TransportAvailabilityDetails {
  @doc("Transport Shipment Type supported for given region.")
  @visibility("read")
  shipmentType?: TransportShipmentTypes;
}

@doc("Credential details of the account.")
model AccountCredentialDetails {
  @doc("Name of the account.")
  @visibility("read")
  accountName?: string;

  @doc("Type of the account.")
  @visibility("read")
  dataAccountType?: DataAccountType;

  @doc("Connection string of the account endpoint to use the account as a storage endpoint on the device.")
  @visibility("read")
  accountConnectionString?: string;

  @doc("Per share level unencrypted access credentials.")
  @visibility("read")
  shareCredentialDetails?: ShareCredentialDetails[];
}

@doc("Credential details of the shares in account.")
model ShareCredentialDetails {
  @doc("Name of the share.")
  @visibility("read")
  shareName?: string;

  @doc("Type of the share.")
  @visibility("read")
  shareType?: ShareDestinationFormatType;

  @doc("User name for the share.")
  @visibility("read")
  userName?: string;

  @doc("Password for the share.")
  @visibility("read")
  password?: string;

  @doc("Access protocols supported on the device.")
  @visibility("read")
  supportedAccessProtocols?: AccessProtocol[];
}

@doc("The Network Adapter configuration of a DataBox.")
model ApplianceNetworkConfiguration {
  @doc("Name of the network.")
  @visibility("read")
  name?: string;

  @doc("Mac Address.")
  @visibility("read")
  macAddress?: string;
}

@doc("Base class for all objects under resource.")
model ArmBaseObject {
  @doc("Name of the object.")
  @visibility("read")
  name?: string;

  @doc("Id of the object.")
  @visibility("read")
  id?: string;

  @doc("Type of the object.")
  @visibility("read")
  type?: string;
}

@doc("Granular Details for log generated during copy.")
@discriminator("copyLogDetailsType")
model GranularCopyLogDetails {}

@doc("DataBox CustomerDisk Copy Progress")
model DataBoxCustomerDiskCopyProgress extends CopyProgress {
  @doc("Disk Serial Number.")
  @visibility("read")
  serialNumber?: string;

  @doc("The Status of the copy")
  @visibility("read")
  copyStatus?: CopyStatus;
}

@doc("Copy progress.")
model CopyProgress {
  @doc("Name of the storage account. This will be empty for data account types other than storage account.")
  @visibility("read")
  storageAccountName?: string;

  @doc("Transfer type of data")
  @visibility("read")
  transferType?: TransferType;

  @doc("Data Account Type.")
  @visibility("read")
  dataAccountType?: DataAccountType;

  @doc("Id of the account where the data needs to be uploaded.")
  @visibility("read")
  accountId?: string;

  @doc("To indicate bytes transferred.")
  @visibility("read")
  bytesProcessed?: int32;

  @doc("Total amount of data to be processed by the job.")
  @visibility("read")
  totalBytesToProcess?: int32;

  @doc("Number of files processed")
  @visibility("read")
  filesProcessed?: int32;

  @doc("Total files to process")
  @visibility("read")
  totalFilesToProcess?: int32;

  @doc("Number of files not adhering to azure naming conventions which were processed by automatic renaming")
  @visibility("read")
  invalidFilesProcessed?: int32;

  @doc("Total amount of data not adhering to azure naming conventions which were processed by automatic renaming")
  @visibility("read")
  invalidFileBytesUploaded?: int32;

  @doc("Number of folders not adhering to azure naming conventions which were processed by automatic renaming")
  @visibility("read")
  renamedContainerCount?: int32;

  @doc("Number of files which could not be copied")
  @visibility("read")
  filesErroredOut?: int32;

  @doc("To indicate directories errored out in the job.")
  @visibility("read")
  directoriesErroredOut?: int32;

  @doc("To indicate directories renamed")
  @visibility("read")
  invalidDirectoriesProcessed?: int32;

  @doc("""
To indicate if enumeration of data is in progress. 
Until this is true, the TotalBytesToProcess may not be valid.
""")
  @visibility("read")
  isEnumerationInProgress?: boolean;

  @doc("Error, if any, in the stage")
  @visibility("read")
  error?: CloudError;

  @doc("Available actions on the job.")
  @visibility("read")
  actions?: CustomerResolutionCode[];
}

@doc("Granular Copy progress.")
model GranularCopyProgress {
  @doc("Name of the storage account. This will be empty for data account types other than storage account.")
  @visibility("read")
  storageAccountName?: string;

  @doc("Transfer type of data")
  @visibility("read")
  transferType?: TransferType;

  @doc("Data Account Type.")
  @visibility("read")
  dataAccountType?: DataAccountType;

  @doc("Id of the account where the data needs to be uploaded.")
  @visibility("read")
  accountId?: string;

  @doc("To indicate bytes transferred.")
  @visibility("read")
  bytesProcessed?: int32;

  @doc("Total amount of data to be processed by the job.")
  @visibility("read")
  totalBytesToProcess?: int32;

  @doc("Number of files processed")
  @visibility("read")
  filesProcessed?: int32;

  @doc("Total files to process")
  @visibility("read")
  totalFilesToProcess?: int32;

  @doc("Number of files not adhering to azure naming conventions which were processed by automatic renaming")
  @visibility("read")
  invalidFilesProcessed?: int32;

  @doc("Total amount of data not adhering to azure naming conventions which were processed by automatic renaming")
  @visibility("read")
  invalidFileBytesUploaded?: int32;

  @doc("Number of folders not adhering to azure naming conventions which were processed by automatic renaming")
  @visibility("read")
  renamedContainerCount?: int32;

  @doc("Number of files which could not be copied")
  @visibility("read")
  filesErroredOut?: int32;

  @doc("To indicate directories errored out in the job.")
  @visibility("read")
  directoriesErroredOut?: int32;

  @doc("To indicate directories renamed")
  @visibility("read")
  invalidDirectoriesProcessed?: int32;

  @doc("""
To indicate if enumeration of data is in progress. 
Until this is true, the TotalBytesToProcess may not be valid.
""")
  @visibility("read")
  isEnumerationInProgress?: boolean;

  @doc("Error, if any, in the stage")
  @visibility("read")
  error?: CloudError;

  @doc("Available actions on the job.")
  @visibility("read")
  actions?: CustomerResolutionCode[];
}

@doc("It does all pre-job creation validations.")
model CreateJobValidations extends ValidationRequest {
  @doc("Identify the nature of validation.")
  validationCategory: "JobCreationValidation";
}

@doc("Request to validate create order limit for current subscription.")
model CreateOrderLimitForSubscriptionValidationRequest
  extends ValidationInputRequest {
  @doc("Device type to be used for the job.")
  deviceType: SkuName;

  @doc("Identifies the type of validation request.")
  validationType: "ValidateCreateOrderLimit";
}

@doc("Properties of create order limit for subscription validation response.")
model CreateOrderLimitForSubscriptionValidationResponseProperties
  extends ValidationInputResponse {
  @doc("Create order limit validation status.")
  @visibility("read")
  status?: ValidationStatus;

  @doc("Identifies the type of validation response.")
  validationType: "ValidateCreateOrderLimit";
}

@doc("Customer disk job details.")
model DataBoxCustomerDiskJobDetails extends JobDetails {
  @doc("Contains the map of disk serial number to the disk details for import jobs.")
  importDiskDetailsCollection?: Record<ImportDiskDetails>;

  @doc("Contains the map of disk serial number to the disk details for export jobs.")
  @visibility("read")
  exportDiskDetailsCollection?: Record<ExportDiskDetails>;

  @doc("Copy progress per disk.")
  @visibility("read")
  copyProgress?: DataBoxCustomerDiskCopyProgress[];

  @doc("Delivery package shipping details.")
  @visibility("read")
  deliverToDcPackageDetails?: PackageCarrierInfo;

  @doc("Return package shipping details.")
  returnToCustomerPackageDetails: PackageCarrierDetails;

  @doc("Flag to indicate if disk manifest should be backed-up in the Storage Account.")
  enableManifestBackup?: boolean;

  @doc("Indicates the type of job details.")
  jobDetailsType: "DataBoxCustomerDisk";
}

@doc("Import disk details")
model ImportDiskDetails {
  @doc("The relative path of the manifest file on the disk.")
  manifestFile: string;

  @doc("The Base16-encoded MD5 hash of the manifest file on the disk.")
  manifestHash: string;

  @doc("BitLocker key used to encrypt the disk.")
  bitLockerKey: string;

  @doc("Path to backed up manifest, only returned if enableManifestBackup is true.")
  @visibility("read")
  backupManifestCloudPath?: string;
}

@doc("Export disk details")
model ExportDiskDetails {
  @doc("The relative path of the manifest file on the disk.")
  @visibility("read")
  manifestFile?: string;

  @doc("The Base16-encoded MD5 hash of the manifest file on the disk.")
  @visibility("read")
  manifestHash?: string;

  @doc("Path to backed up manifest, only returned if enableManifestBackup is true.")
  @visibility("read")
  backupManifestCloudPath?: string;
}

@doc("The secrets related to customer disk job.")
model CustomerDiskJobSecrets extends JobSecrets {
  @doc("Contains the list of secrets object for that device.")
  @visibility("read")
  diskSecrets?: DiskSecret[];

  @doc("Carrier Account Number of the customer")
  @visibility("read")
  carrierAccountNumber?: string;

  @doc("Used to indicate what type of job secrets object.")
  jobSecretsType: "DataBoxCustomerDisk";
}

@doc("Contains all the secrets of a Disk.")
model DiskSecret {
  @doc("Serial number of the assigned disk.")
  @visibility("read")
  diskSerialNumber?: string;

  @doc("Bit Locker key of the disk which can be used to unlock the disk to copy data.")
  @visibility("read")
  bitLockerKey?: string;
}

@doc("Datacenter instruction for given storage location.")
model DatacenterAddressInstructionResponse extends DatacenterAddressResponse {
  @doc("Data center communication instruction")
  @visibility("read")
  communicationInstruction?: string;

  @doc("Data center address type")
  datacenterAddressType: "DatacenterAddressInstruction";
}

@doc("Datacenter address for given storage location.")
model DatacenterAddressLocationResponse extends DatacenterAddressResponse {
  @doc("Contact person name")
  @visibility("read")
  contactPersonName?: string;

  @doc("Company name")
  @visibility("read")
  company?: string;

  @doc("Street address line 1")
  @visibility("read")
  street1?: string;

  @doc("Street address line 2")
  @visibility("read")
  street2?: string;

  @doc("Street address line 3")
  @visibility("read")
  street3?: string;

  @doc("City name")
  @visibility("read")
  city?: string;

  @doc("name of the state")
  @visibility("read")
  state?: string;

  @doc("Zip code")
  @visibility("read")
  zip?: string;

  @doc("name of the country")
  @visibility("read")
  country?: string;

  @doc("Phone number")
  @visibility("read")
  phone?: string;

  @doc("Phone extension")
  @visibility("read")
  phoneExtension?: string;

  @doc("Address type")
  @visibility("read")
  addressType?: string;

  @doc("Special instruction for shipping")
  @visibility("read")
  additionalShippingInformation?: string;

  @doc("Data center address type")
  datacenterAddressType: "DatacenterAddressLocation";
}

@doc("Copy log details for a storage account of a DataBox job")
model DataBoxAccountCopyLogDetails extends CopyLogDetails {
  @doc("Account name.")
  @visibility("read")
  accountName?: string;

  @doc("Link for copy logs.")
  @visibility("read")
  copyLogLink?: string;

  @doc("Link for copy verbose logs. This will be set only when LogCollectionLevel is set to Verbose.")
  @visibility("read")
  copyVerboseLogLink?: string;

  @doc("Indicates the type of job details.")
  copyLogDetailsType: "DataBox";
}

@doc("Copy Log Details for customer disk")
model DataBoxCustomerDiskCopyLogDetails extends CopyLogDetails {
  @doc("Disk Serial Number.")
  @visibility("read")
  serialNumber?: string;

  @doc("Link for copy error logs.")
  @visibility("read")
  errorLogLink?: string;

  @doc("Link for copy verbose logs.")
  @visibility("read")
  verboseLogLink?: string;

  @doc("Indicates the type of job details.")
  copyLogDetailsType: "DataBoxCustomerDisk";
}

@doc("Copy Log Details for a disk")
model DataBoxDiskCopyLogDetails extends CopyLogDetails {
  @doc("Disk Serial Number.")
  @visibility("read")
  diskSerialNumber?: string;

  @doc("Link for copy error logs.")
  @visibility("read")
  errorLogLink?: string;

  @doc("Link for copy verbose logs.")
  @visibility("read")
  verboseLogLink?: string;

  @doc("Indicates the type of job details.")
  copyLogDetailsType: "DataBoxDisk";
}

@doc("Granular Copy Log Details for customer disk")
model DataBoxDiskGranularCopyLogDetails extends GranularCopyLogDetails {
  @doc("Disk Serial Number.")
  @visibility("read")
  serialNumber?: string;

  @doc("Account id.")
  @visibility("read")
  accountId?: string;

  @doc("Link for copy error logs.")
  @visibility("read")
  errorLogLink?: string;

  @doc("Link for copy verbose logs.")
  @visibility("read")
  verboseLogLink?: string;

  @doc("Indicates the type of job details.")
  copyLogDetailsType: "DataBoxCustomerDisk";
}

@doc("DataBox Disk Copy Progress")
model DataBoxDiskCopyProgress {
  @doc("The serial number of the disk")
  @visibility("read")
  serialNumber?: string;

  @doc("Bytes copied during the copy of disk.")
  @visibility("read")
  bytesCopied?: int32;

  @doc("Indicates the percentage completed for the copy of the disk.")
  @visibility("read")
  percentComplete?: int32;

  @doc("The Status of the copy")
  @visibility("read")
  status?: CopyStatus;

  @doc("Error, if any, in the stage")
  @visibility("read")
  error?: CloudError;

  @doc("Available actions on the job.")
  @visibility("read")
  actions?: CustomerResolutionCode[];
}

@doc("DataBox Disk Granular Copy Progress")
model DataBoxDiskGranularCopyProgress extends GranularCopyProgress {
  @doc("Disk Serial Number.")
  @visibility("read")
  serialNumber?: string;

  @doc("The Status of the copy")
  @visibility("read")
  copyStatus?: CopyStatus;
}

@doc("DataBox Disk Job Details.")
model DataBoxDiskJobDetails extends JobDetails {
  @doc("User preference on what size disks are needed for the job. The map is from the disk size in TB to the count. Eg. {2,5} means 5 disks of 2 TB size. Key is string but will be checked against an int.")
  preferredDisks?: Record<int32>;

  @doc("Copy progress per disk.")
  @visibility("read")
  copyProgress?: DataBoxDiskCopyProgress[];

  @doc("Copy progress per disk.")
  @visibility("read")
  granularCopyProgress?: DataBoxDiskGranularCopyProgress[];

  @doc("Copy progress per disk.")
  @visibility("read")
  granularCopyLogDetails?: DataBoxDiskGranularCopyLogDetails[];

  @doc("Contains the map of disk serial number to the disk size being used for the job. Is returned only after the disks are shipped to the customer.")
  @visibility("read")
  disksAndSizeDetails?: Record<int32>;

  @doc("User entered passkey for DataBox Disk job.")
  passkey?: string;

  @doc("Indicates the type of job details.")
  jobDetailsType: "DataBoxDisk";
}

@doc("The secrets related to disk job.")
model DataBoxDiskJobSecrets extends JobSecrets {
  @doc("Contains the list of secrets object for that device.")
  @visibility("read")
  diskSecrets?: DiskSecret[];

  @doc("PassKey for the disk Job.")
  @visibility("read")
  passKey?: string;

  @doc("Whether passkey was provided by user.")
  @visibility("read")
  isPasskeyUserDefined?: boolean;

  @doc("Used to indicate what type of job secrets object.")
  jobSecretsType: "DataBoxDisk";
}

@doc("Copy log details for a storage account for Databox heavy")
model DataBoxHeavyAccountCopyLogDetails extends CopyLogDetails {
  @doc("Account name.")
  @visibility("read")
  accountName?: string;

  @doc("Link for copy logs.")
  @visibility("read")
  copyLogLink?: string[];

  @doc("Link for copy verbose logs. This will be set only when the LogCollectionLevel is set to verbose.")
  @visibility("read")
  copyVerboseLogLink?: string[];

  @doc("Indicates the type of job details.")
  copyLogDetailsType: "DataBoxHeavy";
}

@doc("Databox Heavy Device Job Details")
model DataBoxHeavyJobDetails extends JobDetails {
  @doc("Copy progress per account.")
  @visibility("read")
  copyProgress?: CopyProgress[];

  @doc("Set Device password for unlocking Databox Heavy. Should not be passed for TransferType:ExportFromAzure jobs. If this is not passed, the service will generate password itself. This will not be returned in Get Call. Password Requirements :  Password must be minimum of 12 and maximum of 64 characters. Password must have at least one uppercase alphabet, one number and one special character. Password cannot have the following characters : IilLoO0 Password can have only alphabets, numbers and these characters : @#\\-$%^!+=;:_()]+")
  devicePassword?: string;

  @doc("Indicates the type of job details.")
  jobDetailsType: "DataBoxHeavy";
}

@doc("The secrets related to a databox heavy job.")
model DataBoxHeavyJobSecrets extends JobSecrets {
  @doc("Contains the list of secret objects for a databox heavy job.")
  @visibility("read")
  cabinetPodSecrets?: DataBoxHeavySecret[];

  @doc("Used to indicate what type of job secrets object.")
  jobSecretsType: "DataBoxHeavy";
}

@doc("The secrets related to a databox heavy.")
model DataBoxHeavySecret {
  @doc("Serial number of the assigned device.")
  @visibility("read")
  deviceSerialNumber?: string;

  @doc("Password for out of the box experience on device.")
  @visibility("read")
  devicePassword?: string;

  @doc("Network configuration of the appliance.")
  @visibility("read")
  networkConfigurations?: ApplianceNetworkConfiguration[];

  @doc("The base 64 encoded public key to authenticate with the device")
  @visibility("read")
  encodedValidationCertPubKey?: string;

  @doc("Per account level access credentials.")
  @visibility("read")
  accountCredentialDetails?: AccountCredentialDetails[];
}

@doc("Databox Job Details")
model DataBoxJobDetails extends JobDetails {
  @doc("Copy progress per storage account.")
  @visibility("read")
  copyProgress?: CopyProgress[];

  @doc("Set Device password for unlocking Databox. Should not be passed for TransferType:ExportFromAzure jobs. If this is not passed, the service will generate password itself. This will not be returned in Get Call. Password Requirements :  Password must be minimum of 12 and maximum of 64 characters. Password must have at least one uppercase alphabet, one number and one special character. Password cannot have the following characters : IilLoO0 Password can have only alphabets, numbers and these characters : @#\\-$%^!+=;:_()]+")
  devicePassword?: string;

  @doc("Indicates the type of job details.")
  jobDetailsType: "DataBox";
}

@doc("The secrets related to a databox job.")
model DataboxJobSecrets extends JobSecrets {
  @doc("Contains the list of secret objects for a job.")
  podSecrets?: DataBoxSecret[];

  @doc("Used to indicate what type of job secrets object.")
  jobSecretsType: "DataBox";
}

@doc("The secrets related to a DataBox.")
model DataBoxSecret {
  @doc("Serial number of the assigned device.")
  @visibility("read")
  deviceSerialNumber?: string;

  @doc("Password for out of the box experience on device.")
  @visibility("read")
  devicePassword?: string;

  @doc("Network configuration of the appliance.")
  @visibility("read")
  networkConfigurations?: ApplianceNetworkConfiguration[];

  @doc("The base 64 encoded public key to authenticate with the device")
  @visibility("read")
  encodedValidationCertPubKey?: string;

  @doc("Per account level access credentials.")
  @visibility("read")
  accountCredentialDetails?: AccountCredentialDetails[];
}

@doc("Request body to get the availability for scheduling data box orders orders.")
model DataBoxScheduleAvailabilityRequest extends ScheduleAvailabilityRequest {
  @doc("Sku Name for which the order is to be scheduled.")
  skuName: "DataBox";
}

@doc("Request to validate export and import data details.")
model DataTransferDetailsValidationRequest extends ValidationInputRequest {
  @doc("List of DataTransfer details to be used to export data from azure.")
  dataExportDetails?: DataExportDetails[];

  @doc("List of DataTransfer details to be used to import data to azure.")
  dataImportDetails?: DataImportDetails[];

  @doc("Device type.")
  deviceType: SkuName;

  @doc("Type of the transfer.")
  transferType: TransferType;

  @doc("Identifies the type of validation request.")
  validationType: "ValidateDataTransferDetails";
}

@doc("Properties of data transfer details validation response.")
model DataTransferDetailsValidationResponseProperties
  extends ValidationInputResponse {
  @doc("Data transfer details validation status.")
  @visibility("read")
  status?: ValidationStatus;

  @doc("Identifies the type of validation response.")
  validationType: "ValidateDataTransferDetails";
}

@doc("Request body to get the availability for scheduling disk orders.")
model DiskScheduleAvailabilityRequest extends ScheduleAvailabilityRequest {
  @doc("The expected size of the data, which needs to be transferred in this job, in terabytes.")
  expectedDataSizeInTeraBytes: int32;

  @doc("Sku Name for which the order is to be scheduled.")
  skuName: "DataBoxDisk";
}

@doc("Request body to get the availability for scheduling heavy orders.")
model HeavyScheduleAvailabilityRequest extends ScheduleAvailabilityRequest {
  @doc("Sku Name for which the order is to be scheduled.")
  skuName: "DataBoxHeavy";
}

@doc("Details of the managed disks.")
model ManagedDiskDetails extends DataAccountDetails {
  @doc("Resource Group Id of the compute disks.")
  resourceGroupId: string;

  @doc("Resource Id of the storage account that can be used to copy the vhd for staging.")
  stagingStorageAccountId: string;

  @doc("Account Type of the data to be transferred.")
  dataAccountType: "ManagedDisk";
}

@doc("Request to validate preference of transport and data center.")
model PreferencesValidationRequest extends ValidationInputRequest {
  @doc("Preference of transport and data center.")
  preference?: Preferences;

  @doc("Device type to be used for the job.")
  deviceType: SkuName;

  @doc("Identifies the type of validation request.")
  validationType: "ValidatePreferences";
}

@doc("Properties of data center and transport preference validation response.")
model PreferencesValidationResponseProperties extends ValidationInputResponse {
  @doc("Validation status of requested data center and transport.")
  @visibility("read")
  status?: ValidationStatus;

  @doc("Identifies the type of validation response.")
  validationType: "ValidatePreferences";
}

@doc("Request to validate sku availability.")
model SkuAvailabilityValidationRequest extends ValidationInputRequest {
  @doc("Device type to be used for the job.")
  deviceType: SkuName;

  @doc("Type of the transfer.")
  transferType: TransferType;

  @doc("ISO country code. Country for hardware shipment. For codes check: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements")
  country: string;

  @doc("Location for data transfer. For locations check: https://management.azure.com/subscriptions/SUBSCRIPTIONID/locations?api-version=2018-01-01")
  location: string;

  @doc("Identifies the type of validation request.")
  validationType: "ValidateSkuAvailability";
}

@doc("Properties of sku availability validation response.")
model SkuAvailabilityValidationResponseProperties
  extends ValidationInputResponse {
  @doc("Sku availability validation status.")
  @visibility("read")
  status?: ValidationStatus;

  @doc("Identifies the type of validation response.")
  validationType: "ValidateSkuAvailability";
}

@doc("Details for the storage account.")
model StorageAccountDetails extends DataAccountDetails {
  @doc("Storage Account Resource Id.")
  storageAccountId: string;

  @doc("Account Type of the data to be transferred.")
  dataAccountType: "StorageAccount";
}

@doc("Request to validate subscription permission to create jobs.")
model SubscriptionIsAllowedToCreateJobValidationRequest
  extends ValidationInputRequest {
  @doc("Identifies the type of validation request.")
  validationType: "ValidateSubscriptionIsAllowedToCreateJob";
}

@doc("Properties of subscription permission to create job validation response.")
model SubscriptionIsAllowedToCreateJobValidationResponseProperties
  extends ValidationInputResponse {
  @doc("Validation status of subscription permission to create job.")
  @visibility("read")
  status?: ValidationStatus;

  @doc("Identifies the type of validation response.")
  validationType: "ValidateSubscriptionIsAllowedToCreateJob";
}
