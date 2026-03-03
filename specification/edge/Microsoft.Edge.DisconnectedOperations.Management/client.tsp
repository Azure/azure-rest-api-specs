import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.Edge;

@@clientName(Microsoft.Edge, "DisconnectedOperationsMgmtClient", "python");

@@clientName(Artifact, "DisconnectedOperationsArtifact", "csharp");
@@clientName(Image, "DisconnectedOperationsImage", "csharp");
@@clientName(HardwareSetting,
  "DisconnectedOperationsHardwareSetting",
  "csharp"
);
@@clientName(ArtifactDownloadResult,
  "DisconnectedOperationsArtifactDownloadResult",
  "csharp"
);
@@clientName(ArtifactProperties,
  "DisconnectedOperationsArtifactProperties",
  "csharp"
);
@@clientName(AutoRenew, "DisconnectedOperationsAutoRenew", "csharp");
@@clientName(BenefitPlans, "DisconnectedOperationsBenefitPlans", "csharp");
@@clientName(BenefitPlanStatus,
  "DisconnectedOperationsBenefitPlanStatus",
  "csharp"
);
@@clientName(BillingConfiguration,
  "DisconnectedOperationsBillingConfiguration",
  "csharp"
);
@@clientName(BillingModel, "DisconnectedOperationsBillingModel", "csharp");
@@clientName(BillingPeriod, "DisconnectedOperationsBillingPeriod", "csharp");
@@clientName(BillingStatus, "DisconnectedOperationsBillingStatus", "csharp");
@@clientName(ConnectionIntent,
  "DisconnectedOperationsConnectionIntent",
  "csharp"
);
@@clientName(ConnectionStatus,
  "DisconnectedOperationsConnectionStatus",
  "csharp"
);
@@clientName(HardwareSettingProperties,
  "DisconnectedOperationsHardwareSettingProperties",
  "csharp"
);
@@clientName(ImageDownloadResult,
  "DisconnectedOperationsImageDownloadResult",
  "csharp"
);
@@clientName(ImageProperties,
  "DisconnectedOperationsImageProperties",
  "csharp"
);
@@clientName(ImageUpdateProperties,
  "DisconnectedOperationsImageUpdateProperties",
  "csharp"
);
@@clientName(PricingModel, "DisconnectedOperationsPricingModel", "csharp");
@@clientName(RegistrationStatus,
  "DisconnectedOperationsRegistrationStatus",
  "csharp"
);
@@clientName(ReleaseType, "DisconnectedOperationsReleaseType", "csharp");
@@clientName(ResourceProvisioningState,
  "DisconnectedOperationsResourceProvisioningState",
  "csharp"
);
@@clientName(SystemReboot, "DisconnectedOperationsSystemReboot", "csharp");
@@clientName(DisconnectedOperations, "Disconnected", "csharp");
