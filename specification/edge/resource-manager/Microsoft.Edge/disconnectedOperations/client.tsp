import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager;
using Microsoft.Edge;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;

@@clientName(Microsoft.Edge, "DisconnectedOperationsMgmtClient", "python");
@@clientName(
  Microsoft.Edge,
  "DisconnectedOperationsManagementClient",
  "javascript"
);

@@clientName(Artifact, "DisconnectedOperationsArtifact", "csharp");
@@clientName(Image, "DisconnectedOperationsImage", "csharp");
@@clientName(
  HardwareSetting,
  "DisconnectedOperationsHardwareSetting",
  "csharp"
);
@@clientName(
  ArtifactDownloadResult,
  "DisconnectedOperationsArtifactDownloadResult",
  "csharp"
);
@@clientName(
  ArtifactProperties,
  "DisconnectedOperationsArtifactProperties",
  "csharp"
);
@@clientName(AutoRenew, "DisconnectedOperationsAutoRenew", "csharp");
@@clientName(BenefitPlans, "DisconnectedOperationsBenefitPlans", "csharp");
@@clientName(
  BenefitPlanStatus,
  "DisconnectedOperationsBenefitPlanStatus",
  "csharp"
);
@@clientName(
  BillingConfiguration,
  "DisconnectedOperationsBillingConfiguration",
  "csharp"
);
@@clientName(BillingModel, "DisconnectedOperationsBillingModel", "csharp");
@@clientName(BillingPeriod, "DisconnectedOperationsBillingPeriod", "csharp");
@@clientName(BillingStatus, "DisconnectedOperationsBillingStatus", "csharp");
@@clientName(
  ConnectionIntent,
  "DisconnectedOperationsConnectionIntent",
  "csharp"
);
@@clientName(
  ConnectionStatus,
  "DisconnectedOperationsConnectionStatus",
  "csharp"
);
@@clientName(
  HardwareSettingProperties,
  "DisconnectedOperationsHardwareSettingProperties",
  "csharp"
);
@@clientName(
  ImageDownloadResult,
  "DisconnectedOperationsImageDownloadResult",
  "csharp"
);
@@clientName(
  ImageProperties,
  "DisconnectedOperationsImageProperties",
  "csharp"
);
@@clientName(
  ImageUpdateProperties,
  "DisconnectedOperationsImageUpdateProperties",
  "csharp"
);
@@clientName(ImageDownloadResult.linkExpiry, "LinkExpiresOn", "csharp");
@@clientName(ArtifactDownloadResult.linkExpiry, "LinkExpiresOn", "csharp");
@@clientName(PricingModel, "DisconnectedOperationsPricingModel", "csharp");
@@clientName(
  RegistrationStatus,
  "DisconnectedOperationsRegistrationStatus",
  "csharp"
);
@@clientName(ReleaseType, "DisconnectedOperationsReleaseType", "csharp");
@@clientName(
  ResourceProvisioningState,
  "DisconnectedOperationsResourceProvisioningState",
  "csharp"
);
@@clientName(SystemReboot, "DisconnectedOperationsSystemReboot", "csharp");
@@clientName(DisconnectedOperations, "Disconnected", "csharp");

@@alternateType(
  DisconnectedOperationDeploymentManifest.location,
  azureLocation,
  "csharp"
);
@@alternateType(HardwareSettingProperties.deviceId, uuid, "csharp");
