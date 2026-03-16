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
@@clientName(Microsoft.Edge,
  "DisconnectedOperationsManagementClient",
  "javascript"
);

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
@@clientName(ImageDownloadResult.linkExpiry, "LinkExpiresOn", "csharp");
@@clientName(ArtifactDownloadResult.linkExpiry, "LinkExpiresOn", "csharp");
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

@@alternateType(DisconnectedOperationDeploymentManifest.location,
  azureLocation,
  "csharp"
);
@@alternateType(HardwareSettingProperties.deviceId, uuid, "csharp");

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace Microsoft.Edge {
  @doc("Disconnected operation resource for create or update.")
  model DisconnectedOperationCreateOrUpdate
    is TrackedResource<DisconnectedOperationPropertiesCreateOrUpdate> {
    @doc("Name of the resource")
    @path
    @key("name")
    @segment("disconnectedOperations")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
    name: string;
  }
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  model DisconnectedOperationPropertiesCreateOrUpdate {
    @renamedFrom(Microsoft.Edge.Versions.v2026_03_15, "connectionIntent")
    @removed(Microsoft.Edge.Versions.v2026_03_15)
    @doc("The connection intent")
    oldConnectionIntent: ConnectionIntent;

    @added(Microsoft.Edge.Versions.v2026_03_15)
    @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
    @doc("The connection intent")
    connectionIntent: ConnectionIntent;

    @doc("The device version")
    @visibility(Lifecycle.Update, Lifecycle.Read)
    deviceVersion?: string;

    @doc("The billing configuration")
    @added(Microsoft.Edge.Versions.v2026_03_15)
    billingConfiguration?: BillingConfigurationCreateOrUpdate;

    @doc("The benefit plans")
    @added(Microsoft.Edge.Versions.v2026_03_15)
    benefitPlans?: BenefitPlans;
  }

  @doc("The billing configuration")
  @added(Microsoft.Edge.Versions.v2026_03_15)
  model BillingConfigurationCreateOrUpdate {
    @doc("The auto renew setting")
    autoRenew: AutoRenew;

    @doc("The current billing configuration")
    current: BillingPeriod;
  }
}

// JavaScript SDK: use CreateOrUpdate-specific resource model for write operations,
// which omits server-side read-only fields (stampId, billingModel, etc.)
@@alternateType(DisconnectedOperations.createOrUpdate::parameters.resource,
  DisconnectedOperationCreateOrUpdate,
  "javascript"
);
