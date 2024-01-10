

``` yaml

library-name: DataBox
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/8e20af0463637085b47a018ec9c8372a2242bdac/specification/databox/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  'dataCenterAzureLocation': 'azure-location'
  'dataLocation': 'azure-location'
  'serviceLocation': 'azure-location'
  'storageLocation': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'
  '*AccountId': 'arm-id'
  '*ResourceId': 'arm-id'
  'resourceGroupId': 'arm-id'
  'meterId': 'uuid'


prepend-rp-prefix:
  - CopyStatus
  - CopyProgress
  - KeyEncryptionKey
  - ShippingAddress
  - StageName
  - AccessProtocol
  - AccountCredentialDetails
  - ContactDetails
  - DiskSecret
  - DoubleEncryption
  - EncryptionPreferences
  - SkuCapacity
  - SkuCost
  - StageStatus
  - StorageAccountDetails
  - ValidationStatus
  - ValidationCategory
  - ValidationInputDiscriminator

rename-mapping:
  JobResource: DataBoxJob
  JobResourceUpdateParameter: DataBoxJobPatch
  JobResourceList: DataBoxJobListResult
  CreateJobValidations: CreateJobValidationContent
  CreateOrderLimitForSubscriptionValidationRequest: CreateOrderLimitForSubscriptionValidationContent
  CreateOrderLimitForSubscriptionValidationResponseProperties: CreateOrderLimitForSubscriptionValidationResult
  DataTransferDetailsValidationResponseProperties: DataTransferDetailsValidationResult
  PreferencesValidationResponseProperties: PreferencesValidationResult
  SkuAvailabilityValidationResponseProperties: SkuAvailabilityValidationResult
  SubscriptionIsAllowedToCreateJobValidationResponseProperties: SubscriptionIsAllowedToCreateJobValidationResult
  AddressValidationProperties: AddressValidationResult
  ValidationInputResponse: DataBoxValidationInputResult
  DataBoxCustomerDiskJobDetails.deliverToDcPackageDetails: DeliverToDataCenterPackageDetails
  DataBoxCustomerDiskJobDetails.exportDiskDetailsCollection: ExportDiskDetails
  DataBoxCustomerDiskJobDetails.importDiskDetailsCollection: ImportDiskDetails
  DataBoxDiskJobSecrets.passKey: Passkey
  DataBoxScheduleAvailabilityRequest: DataBoxScheduleAvailabilityContent
  DiskScheduleAvailabilityRequest: DiskScheduleAvailabilityContent
  HeavyScheduleAvailabilityRequest: HeavyScheduleAvailabilityContent
  ScheduleAvailabilityRequest: ScheduleAvailabilityContent
  SkuInformation.enabled: IsEnabled
  DatacenterAddressInstructionResponse: DataCenterAddressInstructionResult
  DatacenterAddressLocationResponse: DataCenterAddressLocationResult
  DatacenterAddressResponse: DataCenterAddressResult
  DatacenterAddressRequest: DataCenterAddressContent
  DataTransferDetailsValidationRequest: DataTransferDetailsValidationContent
  PreferencesValidationRequest: PreferencesValidationContent
  SkuAvailabilityValidationRequest: SkuAvailabilityValidationContent
  SubscriptionIsAllowedToCreateJobValidationRequest: SubscriptionIsAllowedToCreateJobValidationContent
  ValidateAddress: DataBoxValidateAddressContent
  DcAccessSecurityCode: DataCenterAccessSecurityCode
  DcAccessSecurityCode.forwardDCAccessCode: ForwardDataCenterAccessCode
  DcAccessSecurityCode.reverseDCAccessCode: ReverseDataCenterAccessCode
  KekType: DataBoxKeyEncryptionKeyType
  IdentityProperties: DataBoxManagedIdentity
  KeyEncryptionKey.identityProperties: ManagedIdentity
  IdentityProperties.type: IdentityType
  UserAssignedProperties: DataBoxUserAssignedIdentity
  JobDetails: DataBoxBasicJobDetails
  JobStages: DataBoxJobStage
  Preferences: DataBoxOrderPreferences
  RegionConfigurationRequest: RegionConfigurationContent
  RegionConfigurationResponse: RegionConfigurationResult
  ShipmentPickUpResponse: DataBoxShipmentPickUpResult
  ShipmentPickUpResponse.readyByTime: ReadyBy
  ValidationInputRequest: DataBoxValidationInputContent
  ValidationRequest: DataBoxValidationContent
  ValidationResponse: DataBoxValidationResult
  AddressType: DataBoxShippingAddressType
  AvailableSkuRequest: AvailableSkusContent
  CancellationReason: DataBoxJobCancellationReason
  ClassDiscriminator: DataBoxOrderType
  TransferType: DataBoxJobTransferType
  JobSecrets.dcAccessSecurityCode: DataCenterAccessSecurityCode
  MarkDevicesShippedRequest.deliverToDcPackageDetails: DeliverToDataCenterPackageDetails
  LastMitigationActionOnJob.actionDateTimeInUtc: ActionPerformedOn

override-operation-name:
  Service_ListAvailableSkusByResourceGroup: GetAvailableSkus
  Service_RegionConfigurationByResourceGroup: GetRegionConfiguration
  Service_RegionConfiguration: GetRegionConfiguration
  Service_ValidateAddress: ValidateAddress
  Service_ValidateInputs: ValidateInputs
  Service_ValidateInputsByResourceGroup: ValidateInputs

directive:
  - from: databox.json
    where: $.definitions
    transform: >
      $.MitigateJobRequest.required = ["customerResolutionCode"]
```
