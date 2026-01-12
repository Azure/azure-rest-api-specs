import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.Edge;

@@clientName(Microsoft.Edge, "DisconnectedOperationsMgmtClient", "python");

@@clientName(Artifact, "DisconnectedOperationsArtifact", "csharp");
@@clientName(Image, "DisconnectedOperationsImage", "csharp");
@@clientName(ArtifactDownloadResult,
  "DisconnectedOperationsArtifactDownloadResult",
  "csharp"
);
@@clientName(ArtifactProperties,
  "DisconnectedOperationsArtifactProperties",
  "csharp"
);
@@clientName(BillingModel, "DisconnectedOperationsBillingModel", "csharp");
@@clientName(ConnectionIntent,
  "DisconnectedOperationsConnectionIntent",
  "csharp"
);
@@clientName(ConnectionStatus,
  "DisconnectedOperationsConnectionStatus",
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
@@clientName(RegistrationStatus,
  "DisconnectedOperationsRegistrationStatus",
  "csharp"
);
@@clientName(ReleaseType, "DisconnectedOperationsReleaseType", "csharp");
@@clientName(ResourceProvisioningState,
  "DisconnectedOperationsResourceProvisioningState",
  "csharp"
);
@@clientName(DisconnectedOperations, "Disconnected", "csharp");
