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

@doc("A Instance resource belonging to an Instance resource.")
model Instance is TrackedResource<InstanceProperties> {
  @doc("Name of Instance.")
  @key
  @segment("instances")
  @pattern("^[a-z0-9][a-z0-9-]{1,60}[a-z0-9]$")
  @path
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("The properties of an Instance resource.")
model InstanceProperties {
  @doc("Deployment scope (such as Kubernetes namespace).")
  scope?: string;

  @doc("Name of the solution.")
  solution?: string;

  @doc("Defines the Target the Instance will deploy to.")
  target?: TargetSelectorProperties;

  @doc("Reconciliation Policy.")
  reconciliationPolicy?: ReconciliationPolicy;

  @doc("Version of the particular resource.")
  version?: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Properties of the reference target.")
model TargetSelectorProperties {
  @doc("Name of the target.")
  name?: string;
}

@armResourceOperations
interface Instances {
  get is ArmResourceRead<Instance>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Instance>;
  update is ArmCustomPatchSync<Instance>;
  delete is ArmResourceDeleteWithoutOkAsync<Instance>;
  listByResourceGroup is ArmResourceListByParent<Instance>;
  listBySubscription is ArmListBySubscription<Instance>;
}
