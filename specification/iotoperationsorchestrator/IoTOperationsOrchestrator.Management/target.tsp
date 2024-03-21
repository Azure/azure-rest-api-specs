import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsOrchestrator;

@doc("A Target resource belonging to an Instance resource.")
model Target is TrackedResource<TargetProperties> {
  @doc("Name of target.")
  @key
  @segment("targets")
  @pattern("^[a-z0-9][a-z0-9-]{1,60}[a-z0-9]$")
  @path
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("The properties of a Target resource.")
model TargetProperties {
  @doc("A list of components.")
  @OpenAPI.extension("x-ms-identifiers", [])
  components?: ComponentProperties[];

  @doc("Deployment scope (such as Kubernetes namespace).")
  scope?: string;

  @doc("Defines the device topology for a target or instance.")
  @OpenAPI.extension("x-ms-identifiers", [])
  topologies?: TopologiesProperties[];

  @doc("Reconciliation Policy.")
  reconciliationPolicy?: ReconciliationPolicy;

  @doc("Version of the particular resource.")
  version?: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Defines a desired runtime component.")
model TopologiesProperties {
  @doc("bindings description.")
  @OpenAPI.extension("x-ms-identifiers", [])
  bindings?: BindingProperties[];
}

@doc("Defines a component binding for a provider.")
model BindingProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("Configuration values for the binding.")
  config: Record<unknown>;

  @doc("Name of the provider.")
  provider: string;

  @doc("Role that the provider binds to with the component.")
  role: string;
}

@armResourceOperations
interface Targets {
  get is ArmResourceRead<Target>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Target>;
  update is ArmCustomPatchSync<Target>;
  delete is ArmResourceDeleteWithoutOkAsync<Target>;
  listByResourceGroup is ArmResourceListByParent<Target>;
  listBySubscription is ArmListBySubscription<Target>;
}
