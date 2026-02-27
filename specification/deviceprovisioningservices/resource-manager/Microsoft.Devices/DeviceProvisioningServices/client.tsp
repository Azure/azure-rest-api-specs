import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";
using Http;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.Devices;

@@clientName(Microsoft.Devices, "IotDpsClient", "javascript");
@@clientName(Microsoft.Devices, "IotDpsClient", "python");
@@clientName(Microsoft.Devices.CertificateNameQuery1.`certificate.name`,
  "certificate_name1",
  "python"
);
@@clientName(Microsoft.Devices.CertificateNameQuery2.`certificate.name`,
  "certificate_name1",
  "python"
);
@@clientName(Microsoft.Devices.CertificateNameQuery1.`certificate.name`,
  "certificateName1",
  "go"
);
@@clientName(Microsoft.Devices.CertificateNameQuery2.`certificate.name`,
  "certificateName1",
  "go"
);
@@clientName(IotDpsResourceOperationGroup.checkProvisioningServiceNameAvailability,
  "CheckDeviceProvisioningServicesNameAvailability",
  "csharp"
);

@@clientName(Microsoft.Devices.CertificateNameQuery1.`certificate.name`,
  "certificateCommonName",
  "csharp"
);
@@clientName(Microsoft.Devices.CertificateNameQuery2.`certificate.name`,
  "certificateCommonName",
  "csharp"
);
@@clientName(Microsoft.Devices.CertificateNameQuery3.certificateCreated,
  "certificateCreatedOn",
  "csharp"
);
@@clientName(Microsoft.Devices.CertificateNameQuery4.certificateLastUpdated,
  "certificateLastUpdatedOn",
  "csharp"
);
@@clientName(CertificateResponse,
  "DeviceProvisioningServicesCertificate",
  "csharp"
);
@@alternateType(CertificateResponse.etag, eTag, "csharp");

@@clientName(CertificateProperties,
  "DeviceProvisioningServicesCertificateProperties",
  "csharp"
);
@@alternateType(CertificateProperties.certificate, unknown, "csharp");
@@alternateType(CertificateProperties.created, offsetDateTime, "csharp");
@@alternateType(CertificateProperties.expiry, offsetDateTime, "csharp");
@@alternateType(CertificateProperties.thumbprint, unknown, "csharp");
@@alternateType(CertificateProperties.updated, offsetDateTime, "csharp");
@@clientName(CertificateProperties.expiry, "ExpireOn", "csharp");
@@clientName(CertificateProperties.created, "CreatedOn", "csharp");
@@clientName(CertificateProperties.updated, "UpdatedOn", "csharp");
@@clientName(VerificationCodeResponse,
  "CertificateVerificationCodeResult",
  "csharp"
);
@@alternateType(VerificationCodeResponse.etag, eTag, "csharp");

@@alternateType(VerificationCodeResponseProperties.certificate,
  unknown,
  "csharp"
);
@@alternateType(VerificationCodeResponseProperties.created,
  offsetDateTime,
  "csharp"
);
@@alternateType(VerificationCodeResponseProperties.expiry,
  offsetDateTime,
  "csharp"
);
@@alternateType(VerificationCodeResponseProperties.thumbprint,
  unknown,
  "csharp"
);
@@alternateType(VerificationCodeResponseProperties.updated,
  offsetDateTime,
  "csharp"
);
@@clientName(VerificationCodeResponseProperties.expiry, "ExpireOn", "csharp");
@@clientName(VerificationCodeResponseProperties.created, "CreatedOn", "csharp");
@@clientName(VerificationCodeResponseProperties.updated, "UpdatedOn", "csharp");
@@clientName(VerificationCodeResponseProperties,
  "CertificateVerificationCodeProperties",
  "csharp"
);
@@clientName(VerificationCodeRequest,
  "CertificateVerificationCodeContent",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProperties,
  "DeviceProvisioningServicesPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);

@@clientName(GroupIdInformation,
  "DeviceProvisioningServicesPrivateLinkResource",
  "csharp"
);
@@clientName(GroupIdInformationProperties,
  "DeviceProvisioningServicesPrivateLinkResourceProperties",
  "csharp"
);
@@clientName(ProvisioningServiceDescription,
  "DeviceProvisioningService",
  "csharp"
);
@@alternateType(ProvisioningServiceDescription.etag, eTag, "csharp");

@@clientName(IotDpsPropertiesDescription,
  "DeviceProvisioningServiceProperties",
  "csharp"
);
@@clientName(IotDpsPropertiesDescription.enableDataResidency,
  "IsDataResidencyEnabled",
  "csharp"
);
@@clientName(IotDpsSkuInfo, "DeviceProvisioningServicesSkuInfo", "csharp");
@@clientName(IotDpsSku, "DeviceProvisioningServicesSku", "csharp");
@@clientName(IotDpsSkuDefinition,
  "DeviceProvisioningServicesSkuDefinition",
  "csharp"
);
@@clientName(SharedAccessSignatureAuthorizationRuleAccessRightsDescription,
  "DeviceProvisioningServicesSharedAccessKey",
  "csharp"
);
@@clientName(OperationInputs,
  "DeviceProvisioningServicesNameAvailabilityContent",
  "csharp"
);
@@clientName(NameAvailabilityInfo,
  "DeviceProvisioningServicesNameAvailabilityResult",
  "csharp"
);
@@clientName(NameAvailabilityInfo.nameAvailable, "IsNameAvailable", "csharp");
@@clientName(NameUnavailabilityReason,
  "DeviceProvisioningServicesNameUnavailableReason",
  "csharp"
);
@@clientName(AccessRightsDescription,
  "DeviceProvisioningServicesAccessKeyRight",
  "csharp"
);
@@clientName(AllocationPolicy,
  "DeviceProvisioningServicesAllocationPolicy",
  "csharp"
);
@@clientName(PrivateLinkServiceConnectionStatus,
  "DeviceProvisioningServicesPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(IpFilterRule, "DeviceProvisioningServicesIPFilterRule", "csharp");
@@clientName(IpFilterActionType,
  "DeviceProvisioningServicesIPFilterActionType",
  "csharp"
);
@@clientName(IpFilterTargetType,
  "DeviceProvisioningServicesIPFilterTargetType",
  "csharp"
);
@@clientName(PublicNetworkAccess,
  "DeviceProvisioningServicesPublicNetworkAccess",
  "csharp"
);
@@clientName(State, "DeviceProvisioningServicesState", "csharp");
@@clientName(CertificatePurpose,
  "DeviceProvisioningServicesCertificatePurpose",
  "csharp"
);
@@scope(ProvisioningServiceDescriptionOperations.getOperationResult, "!csharp");
@@scope(Operations.list, "!csharp");
@@alternateType(IotHubDefinitionDescription.location, azureLocation, "csharp");
@@clientName(ProvisioningServiceDescriptions.listKeysForKeyName,
  "GetKey",
  "csharp"
);
@@clientName(ProvisioningServiceDescription.subscriptionid,
  "subscriptionId",
  "csharp"
);
@@clientName(ProvisioningServiceDescription.resourcegroup,
  "resourceGroup",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op IotDpsResourceDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<ProvisioningServiceDescription>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provisioningServiceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(ProvisioningServiceDescriptions.delete,
  IotDpsResourceDeleteCustomized,
  "python,go,java"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op IotDpsResourceListKeysCustomized(
  ...Azure.ResourceManager.ProviderNamespace<ProvisioningServiceDescription>,
  @body body: void,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provisioningServiceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): SharedAccessSignatureAuthorizationRuleListResult;

@@override(ProvisioningServiceDescriptions.listKeys,
  IotDpsResourceListKeysCustomized,
  "python,go,java,javascript"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op IotDpsResourceGetOperationResultCustomized(
  ...Azure.ResourceManager.ProviderNamespace<ProvisioningServiceDescription>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  operationId: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provisioningServiceName: string,

  ...GetOperationResultParameters,
): AsyncOperationResult;

@@override(ProvisioningServiceDescriptionOperations.getOperationResult,
  IotDpsResourceGetOperationResultCustomized,
  "python,go,java,javascript"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op IotDpsResourceListKeysForKeyNameCustomized(
  ...Azure.ResourceManager.ProviderNamespace<ProvisioningServiceDescription>,
  @body body: void,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provisioningServiceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  keyName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): SharedAccessSignatureAuthorizationRuleAccessRightsDescription;

@@override(ProvisioningServiceDescriptions.listKeysForKeyName,
  IotDpsResourceListKeysForKeyNameCustomized,
  "python,go,java,javascript"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op IotDpsResourceListValidSkusCustomized(
  ...Azure.ResourceManager.ProviderNamespace<ProvisioningServiceDescription>,
  @body body: void,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provisioningServiceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): IotDpsSkuDefinitionListResult;

@@override(ProvisioningServiceDescriptions.listValidSkus,
  IotDpsResourceListValidSkusCustomized,
  "python,go,java,javascript"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op IotDpsResourceGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<ProvisioningServiceDescription>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provisioningServiceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): ProvisioningServiceDescription;

@@override(ProvisioningServiceDescriptions.get,
  IotDpsResourceGetCustomized,
  "python,go,java"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op CertificateResponseDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<ProvisioningServiceDescription>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,
  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  ifMatch: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provisioningServiceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  certificateName: string,

  ...CertificateNameQuery2,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("certificate.rawBytes")
  certificateRawBytes?: bytes,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("certificate.isVerified")
  certificateIsVerified?: boolean,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("certificate.purpose")
  certificatePurpose?: CertificatePurpose,

  ...CertificateNameQuery3,
  ...CertificateNameQuery4,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("certificate.hasPrivateKey")
  certificateHasPrivateKey?: boolean,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("certificate.nonce")
  certificateNonce?: string,
): void;

@@override(CertificateResponses.delete,
  CertificateResponseDeleteCustomized,
  "python,go,java"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op CertificateResponseGenerateVerificationCodeCustomized(
  ...Azure.ResourceManager.ProviderNamespace<ProvisioningServiceDescription>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  certificateName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  ifMatch: string,
  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provisioningServiceName: string,

  ...CertificateNameQuery1,

  /**
   * Raw data of certificate.
   */
  @query("certificate.rawBytes")
  certificateRawBytes?: bytes,

  /**
   * Indicates if the certificate has been verified by owner of the private key.
   */
  @query("certificate.isVerified")
  certificateIsVerified?: boolean,

  /**
   * Description mentioning the purpose of the certificate.
   */
  @query("certificate.purpose")
  certificatePurpose?: CertificatePurpose,

  ...CertificateNameQuery3,
  ...CertificateNameQuery4,

  /**
   * Indicates if the certificate contains private key.
   */
  @query("certificate.hasPrivateKey")
  certificateHasPrivateKey?: boolean,

  /**
   * Random number generated to indicate Proof of Possession.
   */
  @query("certificate.nonce")
  certificateNonce?: string,

  @body
  body: void,
): VerificationCodeResponse;

@@override(CertificateResponses.generateVerificationCode,
  CertificateResponseGenerateVerificationCodeCustomized,
  "python,go,java,javascript"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op CertificateResponseVerifyCertificateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<CertificateResponse>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  certificateName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  ifMatch: string,
  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provisioningServiceName: string,

  ...CertificateNameQuery1,

  /**
   * Raw data of certificate.
   */
  @query("certificate.rawBytes")
  certificateRawBytes?: bytes,

  /**
   * Indicates if the certificate has been verified by owner of the private key.
   */
  @query("certificate.isVerified")
  certificateIsVerified?: boolean,

  /**
   * Describe the purpose of the certificate.
   */
  @query("certificate.purpose")
  certificatePurpose?: CertificatePurpose,

  ...CertificateNameQuery3,
  ...CertificateNameQuery4,

  /**
   * Indicates if the certificate contains private key.
   */
  @query("certificate.hasPrivateKey")
  certificateHasPrivateKey?: boolean,

  /**
   * Random number generated to indicate Proof of Possession.
   */
  @query("certificate.nonce")
  certificateNonce?: string,

  @body
  request: VerificationCodeRequest,
): CertificateListDescription;

@@override(CertificateResponses.verifyCertificate,
  CertificateResponseVerifyCertificateCustomized,
  "python,go,java,javascript"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op CertificateResponseGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<ProvisioningServiceDescription>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  certificateName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provisioningServiceName: string,

  /**
   * ETag of the certificate.
   */
  @header("If-Match")
  ifMatch?: string,
): CertificateResponse;

@@override(CertificateResponses.get,
  CertificateResponseGetCustomized,
  "python,go,java,javascript"
);

// Java-specific client name fixes to mitigate TypeSpec migration breaks
@@clientName(Microsoft.Devices.IotDpsPropertiesDescription.deviceProvisioningHostName,
  "deviceProvisioningHostname",
  "java"
);
@@clientName(Microsoft.Devices.IotDpsPropertiesDescription.serviceOperationsHostName,
  "serviceOperationsHostname",
  "java"
);
@@clientName(Microsoft.Devices.ProvisioningServiceDescription.resourcegroup,
  "resourceGroup",
  "java"
);
@@clientName(SharedAccessSignatureAuthorizationRuleAccessRightsDescription,
  "SharedAccessSignatureAuthorizationRule",
  "java"
);
