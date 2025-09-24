import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.DataBox;

@@scope(Operations.list, "!csharp");

@@clientName(JobDetails, "CommonJobDetails", "go");
@@clientName(JobSecrets, "CommonJobSecrets", "go");
@@clientName(ScheduleAvailabilityRequest,
  "CommonScheduleAvailabilityRequest",
  "go"
);
@@clientName(Microsoft.DataBox, "DataBoxManagementClient", "javascript");
@@clientName(Microsoft.DataBox, "DataBoxManagementClient", "python");

@@clientName(JobResource, "DataBoxJob", "csharp");
@@clientName(JobResourceUpdateParameter, "DataBoxJobPatch", "csharp");
@@clientName(JobResourceList, "DataBoxJobListResult", "csharp");
@@clientName(CreateJobValidations, "CreateJobValidationContent", "csharp");
@@clientName(CreateOrderLimitForSubscriptionValidationRequest,
  "CreateOrderLimitForSubscriptionValidationContent",
  "csharp"
);
@@clientName(CreateOrderLimitForSubscriptionValidationResponseProperties,
  "CreateOrderLimitForSubscriptionValidationResult",
  "csharp"
);
@@clientName(DataTransferDetailsValidationResponseProperties,
  "DataTransferDetailsValidationResult",
  "csharp"
);
@@clientName(PreferencesValidationResponseProperties,
  "PreferencesValidationResult",
  "csharp"
);
@@clientName(SkuAvailabilityValidationResponseProperties,
  "SkuAvailabilityValidationResult",
  "csharp"
);
@@clientName(SubscriptionIsAllowedToCreateJobValidationResponseProperties,
  "SubscriptionIsAllowedToCreateJobValidationResult",
  "csharp"
);
@@clientName(AddressValidationProperties, "AddressValidationResult", "csharp");
@@clientName(ValidationInputResponse, "DataBoxValidationInputResult", "csharp");
@@clientName(DataBoxCustomerDiskJobDetails.deliverToDcPackageDetails,
  "DeliverToDataCenterPackageDetails",
  "csharp"
);
@@clientName(DataBoxCustomerDiskJobDetails.exportDiskDetailsCollection,
  "ExportDiskDetails",
  "csharp"
);
@@clientName(DataBoxCustomerDiskJobDetails.importDiskDetailsCollection,
  "ImportDiskDetails",
  "csharp"
);
@@clientName(DataBoxDiskJobSecrets.passKey, "Passkey", "csharp");
@@clientName(DataBoxScheduleAvailabilityRequest,
  "DataBoxScheduleAvailabilityContent",
  "csharp"
);
@@clientName(DiskScheduleAvailabilityRequest,
  "DiskScheduleAvailabilityContent",
  "csharp"
);
@@clientName(HeavyScheduleAvailabilityRequest,
  "HeavyScheduleAvailabilityContent",
  "csharp"
);
@@clientName(ScheduleAvailabilityRequest,
  "ScheduleAvailabilityContent",
  "csharp"
);
@@clientName(SkuInformation.enabled, "IsEnabled", "csharp");
@@clientName(DatacenterAddressInstructionResponse,
  "DataCenterAddressInstructionResult",
  "csharp"
);
@@clientName(DatacenterAddressLocationResponse,
  "DataCenterAddressLocationResult",
  "csharp"
);
@@clientName(DatacenterAddressResponse, "DataCenterAddressResult", "csharp");
@@clientName(DatacenterAddressRequest, "DataCenterAddressContent", "csharp");
@@clientName(DataTransferDetailsValidationRequest,
  "DataTransferDetailsValidationContent",
  "csharp"
);
@@clientName(PreferencesValidationRequest,
  "PreferencesValidationContent",
  "csharp"
);
@@clientName(SkuAvailabilityValidationRequest,
  "SkuAvailabilityValidationContent",
  "csharp"
);
@@clientName(SubscriptionIsAllowedToCreateJobValidationRequest,
  "SubscriptionIsAllowedToCreateJobValidationContent",
  "csharp"
);
@@clientName(ValidateAddress, "DataBoxValidateAddressContent", "csharp");
@@clientName(DcAccessSecurityCode, "DataCenterAccessSecurityCode", "csharp");
@@clientName(DcAccessSecurityCode.forwardDCAccessCode,
  "ForwardDataCenterAccessCode",
  "csharp"
);
@@clientName(DcAccessSecurityCode.reverseDCAccessCode,
  "ReverseDataCenterAccessCode",
  "csharp"
);
@@clientName(KekType, "DataBoxKeyEncryptionKeyType", "csharp");
@@clientName(IdentityProperties, "DataBoxManagedIdentity", "csharp");
@@clientName(KeyEncryptionKey.identityProperties, "ManagedIdentity", "csharp");
@@clientName(IdentityProperties.type, "IdentityType", "csharp");
@@clientName(UserAssignedProperties, "DataBoxUserAssignedIdentity", "csharp");
@@clientName(JobDetails, "DataBoxBasicJobDetails", "csharp");
@@clientName(JobDetails.datacenterAddress, "DataCenterAddress", "csharp");
@@clientName(JobDetails.expectedDataSizeInTeraBytes,
  "ExpectedDataSizeInTerabytes",
  "csharp"
);
@@clientName(JobStages, "DataBoxJobStage", "csharp");
@@clientName(Preferences, "DataBoxOrderPreferences", "csharp");
@@clientName(RegionConfigurationRequest,
  "RegionConfigurationContent",
  "csharp"
);
@@clientName(RegionConfigurationResponse,
  "RegionConfigurationResult",
  "csharp"
);
@@clientName(ShipmentPickUpResponse, "DataBoxShipmentPickUpResult", "csharp");
@@clientName(ShipmentPickUpResponse.readyByTime, "ReadyBy", "csharp");
@@clientName(ValidationInputRequest, "DataBoxValidationInputContent", "csharp");
@@clientName(ValidationRequest, "DataBoxValidationContent", "csharp");
@@clientName(ValidationResponse, "DataBoxValidationResult", "csharp");
@@clientName(AddressType, "DataBoxShippingAddressType", "csharp");
@@clientName(AvailableSkuRequest, "AvailableSkusContent", "csharp");
@@clientName(CancellationReason, "DataBoxJobCancellationReason", "csharp");
@@clientName(ClassDiscriminator, "DataBoxOrderType", "csharp");
@@clientName(TransferType, "DataBoxJobTransferType", "csharp");
@@clientName(JobSecrets.dcAccessSecurityCode,
  "DataCenterAccessSecurityCode",
  "csharp"
);
@@clientName(MarkDevicesShippedRequest.deliverToDcPackageDetails,
  "DeliverToDataCenterPackageDetails",
  "csharp"
);
@@clientName(LastMitigationActionOnJob.actionDateTimeInUtc,
  "ActionPerformedOn",
  "csharp"
);
@@clientName(TransportAvailabilityRequest,
  "TransportAvailabilityContent",
  "csharp"
);
@@clientName(DeviceCapabilityRequest, "DeviceCapabilityContent", "csharp");
@@clientName(JobProperties.allDevicesLost, "AreAllDevicesLost", "csharp");
@@clientName(ModelName, "DeviceModelName", "csharp");
@@clientName(DataboxJobSecrets, "DataBoxJobSecrets", "csharp");

@@clientName(CopyStatus, "DataBoxCopyStatus", "csharp");
@@clientName(CopyProgress, "DataBoxCopyProgress", "csharp");
@@clientName(KeyEncryptionKey, "DataBoxKeyEncryptionKey", "csharp");
@@clientName(ShippingAddress, "DataBoxShippingAddress", "csharp");
@@clientName(StageName, "DataBoxStageName", "csharp");
@@clientName(AccessProtocol, "DataBoxAccessProtocol", "csharp");
@@clientName(AccessProtocol.SMB, "Smb", "csharp");
@@clientName(AccessProtocol.NFS, "Nfs", "csharp");
@@clientName(AccountCredentialDetails,
  "DataBoxAccountCredentialDetails",
  "csharp"
);
@@clientName(ContactDetails, "DataBoxContactDetails", "csharp");
@@clientName(DiskSecret, "DataBoxDiskSecret", "csharp");
@@clientName(DoubleEncryption, "DataBoxDoubleEncryption", "csharp");
@@clientName(EncryptionPreferences, "DataBoxEncryptionPreferences", "csharp");
@@clientName(SkuCapacity, "DataBoxSkuCapacity", "csharp");
@@clientName(SkuCost, "DataBoxSkuCost", "csharp");
@@clientName(StageStatus, "DataBoxStageStatus", "csharp");
@@clientName(StorageAccountDetails, "DataBoxStorageAccountDetails", "csharp");
@@clientName(ValidationStatus, "DataBoxValidationStatus", "csharp");
@@clientName(ValidationInputDiscriminator,
  "DataBoxValidationInputDiscriminator",
  "csharp"
);
@@clientName(StageName.AtAzureDC, "AtAzureDataCenter", "csharp");
@@clientName(StageName.Failed_IssueDetectedAtAzureDC,
  "FailedIssueDetectedAtAzureDataCenter",
  "csharp"
);
@@clientName(StageName.ReadyToDispatchFromAzureDC,
  "ReadyToDispatchFromAzureDataCenter",
  "csharp"
);
@@clientName(StageName.ReadyToReceiveAtAzureDC,
  "ReadyToReceiveAtAzureDataCenter",
  "csharp"
);
@@clientName(StageName.ShippedToAzureDC, "ShippedToAzureDataCenter", "csharp");
@@clientName(StageName.PreparingToShipFromAzureDC,
  "PreparingToShipFromAzureDataCenter",
  "csharp"
);
@@clientName(NotificationStageName.AtAzureDC, "AtAzureDataCenter", "csharp");
@@clientName(DiskScheduleAvailabilityRequest.expectedDataSizeInTeraBytes,
  "ExpectedDataSizeInTerabytes",
  "csharp"
);
@@clientName(RegionConfigurationRequest.datacenterAddressRequest,
  "DataCenterAddressRequest",
  "csharp"
);
@@clientName(RegionConfigurationResponse.datacenterAddressResponse,
  "DataCenterAddressResponse",
  "csharp"
);
@@clientName(JobDetails.datacenterAddress, "DataCenterAddress", "csharp");
@@clientName(ShareDestinationFormatType.HCS, "Hcs", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Confirmed overload operations"
@@clientName(ServiceOperationGroup.regionConfiguration,
  "GetRegionConfiguration",
  "csharp"
);
@@clientName(ServiceOperationGroup.validateAddress,
  "ValidateAddress",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Confirmed overload operations"
@@clientName(ServiceOperationGroup.validateInputs, "ValidateInputs", "csharp");
@@clientName(ServiceOperationGroup.listAvailableSkusByResourceGroup,
  "GetAvailableSkus",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Confirmed overload operations"
@@clientName(ServiceOperationGroup.regionConfigurationByResourceGroup,
  "GetRegionConfiguration",
  "csharp"
);
@@clientName(mitigate, "Mitigate", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Confirmed overload operations"
@@clientName(ServiceOperationGroup.validateInputsByResourceGroup,
  "ValidateInputs",
  "csharp"
);
@@alternateType(KeyEncryptionKey.kekVaultResourceID,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(UserAssignedProperties.resourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CopyProgress.accountId, armResourceIdentifier, "csharp");
@@alternateType(DataBoxDiskGranularCopyLogDetails.accountId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(StorageAccountDetails.storageAccountId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(GranularCopyProgress.accountId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ManagedDiskDetails.resourceGroupId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ManagedDiskDetails.stagingStorageAccountId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AvailableSkuRequest.location, azureLocation, "csharp");
@@alternateType(SkuAvailabilityValidationRequest.location,
  azureLocation,
  "csharp"
);
@@alternateType(ScheduleAvailabilityRequest.storageLocation,
  azureLocation,
  "csharp"
);
@@alternateType(DatacenterAddressRequest.storageLocation,
  azureLocation,
  "csharp"
);
@@alternateType(DatacenterAddressResponse.dataCenterAzureLocation,
  azureLocation,
  "csharp"
);
@@alternateType(DataLocationToServiceLocationMap.dataLocation,
  azureLocation,
  "csharp"
);
@@alternateType(DataLocationToServiceLocationMap.serviceLocation,
  azureLocation,
  "csharp"
);
@@alternateType(KeyEncryptionKey.kekUrl, url, "csharp");
@@alternateType(PackageShippingDetails.trackingUrl, url, "csharp");
@@alternateType(SkuCost.meterId, uuid, "csharp");

@@clientName(KeyEncryptionKey.kekVaultResourceID, "kekVaultResourceId", "java");
@@clientName(ShareCredentialDetails.userName, "username", "java");
@@alternateType(AdditionalErrorInfo.info, unknown, "java");
@@alternateType(JobStages.jobStageDetails, unknown, "java");
