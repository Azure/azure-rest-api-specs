import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";

using Azure.ClientGenerator.Core;
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

namespace Microsoft.Edge {
  @@scope(DisconnectedOperations.createOrUpdate, "!javascript");
  @@scope(DisconnectedOperations.get, "!javascript");
  @@scope(DisconnectedOperations.delete, "!javascript");
  @@scope(DisconnectedOperations.listDeploymentManifest, "!javascript");
  model DisconnectedOperationCreateOrUpdate
    is TrackedResource<DisconnectedOperationPropertiesCreateOrUpdate> {
    @doc("Name of the resource")
    @path
    @key("name")
    @segment("disconnectedOperations")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
    name: string;
  }

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
    billingConfiguration?: BillingConfigurationCreateCreateOrUpdate;

    @doc("The benefit plans")
    @added(Microsoft.Edge.Versions.v2026_03_15)
    benefitPlans?: BenefitPlans;
  }

  @doc("The billing configuration")
  @added(Microsoft.Edge.Versions.v2026_03_15)
  model BillingConfigurationCreateCreateOrUpdate {
    @doc("The auto renew setting")
    autoRenew: AutoRenew;

    @doc("The current billing configuration")
    current: BillingPeriod;
  }

  @armResourceOperations
  interface DisconnectedOperationsJs
    extends Azure.ResourceManager.TrackedResourceOperations<
        DisconnectedOperation,
        DisconnectedOperationProperties
      > {
    createOrUpdate is ArmResourceCreateOrUpdateAsync<DisconnectedOperationCreateOrUpdate>;
  }

  @@scope(DisconnectedOperationsJs.createOrUpdate, "javascript");

  @@clientLocation(DisconnectedOperationsJs.createOrUpdate,
    "DisconnectedOperations",
    "javascript"
  );
}
