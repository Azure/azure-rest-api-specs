import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.IoTFirmwareDefense;

@@clientName(
  Microsoft.IoTFirmwareDefense,
  "IoTFirmwareDefenseMgmtClient",
  "python"
);

@@clientName(
  Microsoft.IoTFirmwareDefense,
  "IoTFirmwareDefenseMgmtClient",
  "java"
);

@@clientName(Workspace, "FirmwareAnalysisWorkspace", "csharp");
@@clientName(Firmware, "IotFirmware", "csharp");
@@clientName(SummaryResource, "FirmwareAnalysisSummary", "csharp");
@@clientName(BinaryHardeningResource, "BinaryHardeningResult", "csharp");
@@clientName(CryptoCertificateResource, "CryptoCertificateResult", "csharp");
@@clientName(CryptoKeyResource, "CryptoKeyResult", "csharp");
@@clientName(CveResource, "CveResult", "csharp");
@@clientName(PasswordHashResource, "PasswordHashResult", "csharp");
@@clientName(SbomComponentResource, "SbomComponentResult", "csharp");
@@clientName(
  UnsafeFunctionCallsResource,
  "UnsafeFunctionCallsResult",
  "csharp"
);

@@clientName(
  SummaryResourceProperties,
  "FirmwareAnalysisSummaryProperties",
  "csharp"
);
@@clientName(
  BinaryHardeningSummaryResource,
  "BinaryHardeningSummary",
  "csharp"
);
@@clientName(
  CryptoCertificateSummaryResource,
  "CryptoCertificateSummary",
  "csharp"
);
@@clientName(CryptoKeySummaryResource, "CryptoKeySummary", "csharp");
@@clientName(ProvisioningState, "FirmwareProvisioningState", "csharp");
@@clientName(Status, "FirmwareAnalysisStatus", "csharp");
@@clientName(StatusMessage, "FirmwareAnalysisStatusMessage", "csharp");
@@clientName(SummaryType, "FirmwareAnalysisSummaryType", "csharp");
@@clientName(PairedKey, "CryptoPairedKey", "csharp");
@@clientName(UrlToken, "FirmwareUriToken", "csharp");
@@clientName(GenerateUploadUrlRequest, "FirmwareUploadUriContent", "csharp");
@@clientName(FirmwareUpdateDefinition, "IotFirmwarePatch", "csharp");
@@clientName(
  Azure.ResourceManager.CommonTypes.Sku,
  "IotFirmwareDefenseSku",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.SkuTier,
  "IotFirmwareDefenseSkuTier",
  "csharp"
);
@@clientName(
  BinaryHardeningResult,
  "BinaryHardeningResultProperties",
  "csharp"
);
@@clientName(CveResult, "CveResultProperties", "csharp");
@@clientName(
  UnsafeFunctionCallsResult,
  "UnsafeFunctionCallsResultProperties",
  "csharp"
);

@@clientName(Workspaces.generateUploadUrl, "GenerateUploadUri", "csharp");
@@clientName(
  BinaryHardening.listByFirmware,
  "GetBinaryHardeningResults",
  "csharp"
);
@@clientName(
  CryptoCertificates.listByFirmware,
  "GetCryptoCertificates",
  "csharp"
);
@@clientName(CryptoKeys.listByFirmware, "GetCryptoKeys", "csharp");
@@clientName(Cves.listByFirmware, "GetCves", "csharp");
@@clientName(
  LegacyCves.listByFirmware,
  "GetCommonVulnerabilitiesAndExposures",
  "csharp"
);
@@clientName(PasswordHashes.listByFirmware, "GetPasswordHashes", "csharp");
@@clientName(SbomComponents.listByFirmware, "GetSbomComponents", "csharp");
@@clientName(
  UnsafeFunctionCalls.listByFirmware,
  "GetUnsafeFunctionCalls",
  "csharp"
);

@@clientName(UrlToken.url, "Uri", "csharp");
@@clientName(CryptoCertificate.issuedDate, "IssuedOn", "csharp");
@@clientName(CryptoCertificate.expirationDate, "ExpireOn", "csharp");
@@clientName(CryptoKey.keyType, "CryptoKeyType", "csharp");
@@clientName(CryptoKey.usage, "CryptoKeyUsage", "csharp");
@@clientName(PairedKey.type, "PairedKeyType", "csharp");
@@clientName(CertificateUsage.OCSPSigning, "OcspSigning", "csharp");

@@usage(Workspace, Usage.input, "csharp");
@@usage(Firmware, Usage.input, "csharp");
@@usage(SummaryResource, Usage.input, "csharp");
@@usage(UsageMetric, Usage.input, "csharp");
@@usage(BinaryHardeningResource, Usage.input, "csharp");
@@usage(CryptoCertificateResource, Usage.input, "csharp");
@@usage(CryptoKeyResource, Usage.input, "csharp");
@@usage(CveResource, Usage.input, "csharp");
@@usage(LegacyCveResource, Usage.input, "csharp");
@@usage(PasswordHashResource, Usage.input, "csharp");
@@usage(SbomComponentResource, Usage.input, "csharp");
@@usage(UnsafeFunctionCallsResource, Usage.input, "csharp");
@@usage(BinaryHardeningResult, Usage.input, "csharp");
@@usage(BinaryHardeningFeatures, Usage.input, "csharp");
@@usage(FunctionCall, Usage.input, "csharp");
@@usage(UnsafeFunctionCallsResult, Usage.input, "csharp");
@@usage(CryptoCertificate, Usage.input, "csharp");
@@usage(CryptoCertificateEntity, Usage.input, "csharp");
@@usage(PairedKey, Usage.input, "csharp");
@@usage(CryptoKey, Usage.input, "csharp");
@@usage(CvssScore, Usage.input, "csharp");
@@usage(CveComponent, Usage.input, "csharp");
@@usage(CveResult, Usage.input, "csharp");
@@usage(CveLink, Usage.input, "csharp");
@@usage(EpssProperties, Usage.input, "csharp");
@@usage(CweProperties, Usage.input, "csharp");
@@usage(KevProperties, Usage.input, "csharp");
@@usage(FirmwareProperties, Usage.input, "csharp");
@@usage(StatusMessage, Usage.input, "csharp");
@@usage(FirmwareUpdateDefinition, Usage.input, "csharp");
@@usage(UrlToken, Usage.input, "csharp");
@@usage(PasswordHash, Usage.input, "csharp");
@@usage(SbomComponent, Usage.input, "csharp");
@@usage(SummaryResourceProperties, Usage.input, "csharp");
@@usage(SbomFileProperties, Usage.input, "csharp");
@@usage(WorkspaceProperties, Usage.input, "csharp");
@@usage(GenerateUploadUrlRequest, Usage.input, "csharp");
@@usage(FirmwareSummary, Usage.input, "csharp");
@@usage(CveSummary, Usage.input, "csharp");
@@usage(BinaryHardeningSummaryResource, Usage.input, "csharp");
@@usage(CryptoCertificateSummaryResource, Usage.input, "csharp");
@@usage(CryptoKeySummaryResource, Usage.input, "csharp");
@@usage(CveSummaryResource, Usage.input, "csharp");
@@usage(SbomSummaryResource, Usage.input, "csharp");
@@usage(PasswordHashSummaryResource, Usage.input, "csharp");
@@usage(UnsafeFunctionCallsSummaryResource, Usage.input, "csharp");
@@usage(UsageMetricProperties, Usage.input, "csharp");

// flatten
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Azure.ResourceManager.TrackedResource.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Azure.ResourceManager.Foundations.ProxyResourceUpdateModel.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.IoTFirmwareDefense.BinaryHardeningResource.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.IoTFirmwareDefense.CryptoCertificateResource.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.IoTFirmwareDefense.CryptoKeyResource.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.IoTFirmwareDefense.CveResource.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.IoTFirmwareDefense.Firmware.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.IoTFirmwareDefense.PasswordHashResource.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.IoTFirmwareDefense.SbomComponentResource.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.IoTFirmwareDefense.UsageMetric.properties,
  "java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.IoTFirmwareDefense.FirmwareUpdateDefinition.properties,
  "java,python,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Microsoft.IoTFirmwareDefense.UnsafeFunctionCallsResource.properties,
  "csharp"
);
