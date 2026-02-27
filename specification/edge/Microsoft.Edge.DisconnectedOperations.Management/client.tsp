import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.Edge;
using TypeSpec.Versioning;

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

@doc("The billing configuration")
model CustomizedBillingConfiguration {
  @doc("The auto renew setting")
  autoRenew: AutoRenew;

  @visibility(Lifecycle.Read)
  @doc("The billing status")
  billingStatus?: BillingStatus;

  @doc("The current billing configuration")
  current: BillingPeriod;

  @doc("The upcoming billing configuration")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  upcoming?: BillingPeriod;
}

@@clientName(CustomizedBillingConfiguration,
  "BillingConfiguration",
  "javascript"
);

@@alternateType(DisconnectedOperationProperties.billingConfiguration,
  CustomizedBillingConfiguration,
  "javascript"
);
@@alternateType(DisconnectedOperationDeploymentManifest.billingConfiguration,
  CustomizedBillingConfiguration,
  "javascript"
);

@doc("The disconnected operation properties")
model CustomizedDisconnectedOperationProperties {
  @visibility(Lifecycle.Read)
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The unique GUID of the stamp")
  stampId?: string;

  @visibility(Lifecycle.Read)
  @doc("The billing model")
  billingModel?: BillingModel;

  @renamedFrom(Microsoft.Edge.Versions.v2026_03_15, "connectionIntent")
  @removed(Microsoft.Edge.Versions.v2026_03_15)
  @doc("The connection intent")
  oldConnectionIntent: ConnectionIntent;

  @added(Microsoft.Edge.Versions.v2026_03_15)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The connection intent")
  connectionIntent: ConnectionIntent;

  @visibility(Lifecycle.Read)
  @doc("The connection status")
  connectionStatus?: ConnectionStatus;

  @doc("The registration intent")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  registrationStatus?: RegistrationStatus;

  @doc("The device version")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  deviceVersion?: string;

  @doc("The billing configuration")
  @added(Microsoft.Edge.Versions.v2026_03_15)
  billingConfiguration?: CustomizedBillingConfiguration;

  @doc("The benefit plans")
  @added(Microsoft.Edge.Versions.v2026_03_15)
  benefitPlans?: BenefitPlans;
}

@@clientName(CustomizedDisconnectedOperationProperties,
  "DisconnectedOperationProperties",
  "javascript"
);

@@alternateType(DisconnectedOperation.properties,
  CustomizedDisconnectedOperationProperties,
  "javascript"
);
