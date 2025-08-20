import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Devices;
using Azure.Core;

@@clientName(Microsoft.Devices, "IotDpsClient", "javascript");
@@clientName(Microsoft.Devices.CertificateNameQuery1.`certificate.name`,
  "certificate_name1",
  "python"
);
@@clientName(Microsoft.Devices.CertificateNameQuery2.`certificate.name`,
  "certificate_name1",
  "python"
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
