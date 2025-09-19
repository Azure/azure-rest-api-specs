import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commontypes.tsp";

using Azure.ResourceManager;

namespace Microsoft.AppLink;

@doc("AppLink resource")
model AppLink is TrackedResource<AppLinkProperties> {
  ...ResourceNameParameter<AppLink>;
  ...ManagedServiceIdentityProperty;
}

@doc("AppLink properties")
model AppLinkProperties {
  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Observability profile")
  observabilityProfile?: ObservabilityProfile;
}

@doc("AppLink metrics profile")
model MetricsProfile {
  @doc("Monitor workspace resource ID")
  monitorWorkspaceResourceId: string;

  @doc("Grafana dashboard URL")
  @visibility(Lifecycle.Read)
  grafanaDashboard?: string;
}

@doc("AppLink logs profile")
model LogsProfile {
  @doc("Logs workspace resource ID")
  logsWorkspaceResourceId: string;
}

@doc("AppLink traces profile")
model TracesProfile {
  @doc("Insights resource ID")
  insightsResourceId: string;
}

@doc("AppLink observability profile")
model ObservabilityProfile {
  @doc("Metrics profile")
  metrics?: MetricsProfile;

  @doc("Logs profile")
  logs?: LogsProfile;

  @doc("Traces profile")
  traces?: TracesProfile;
}

@armResourceOperations
interface AppLinks {
  get is ArmResourceRead<AppLink>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<AppLink>;
  update is ArmResourcePatchAsync<AppLink, AppLinkProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AppLink>;
  listByResourceGroup is ArmResourceListByParent<AppLink>;
  listBySubscription is ArmListBySubscription<AppLink>;
}
