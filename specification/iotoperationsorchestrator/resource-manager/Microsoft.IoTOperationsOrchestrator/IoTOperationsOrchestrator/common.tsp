import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsOrchestrator;

@doc("Extended location is an extension of Azure locations. They provide a way to use their Azure ARC enabled Kubernetes clusters as target locations for deploying Azure services instances.")
model ExtendedLocation {
  @doc("The name of the extended location.")
  name: string;

  @doc("The type of the extended location.")
  type: string;
}

@lroStatus
@doc("The provisioning status of the resource.")
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource is being updated.")
  Reconciling: "Reconciling",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",

  @doc("The resource was accepted by the server.")
  Accepted: "Accepted",
}

@doc("Defines a desired runtime component.")
model ComponentProperties {
  @doc("Component dependencies.")
  dependencies?: string[];

  @doc("Name of the component.")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "properties field is loosely defined and are dependent on customer scenarios"
  @doc("Properties of the component.")
  properties?: Record<unknown>;

  @doc("Component type.")
  type: string;
}

@doc("Reconciliation Policy.")
model ReconciliationPolicy {
  @doc("Policy type")
  type: ReconciliationPolicies;

  @minLength(1)
  @doc("Policy interval.")
  interval?: string;
}

@doc("Policies to control how the resource should reconcile.")
union ReconciliationPolicies {
  string,

  @doc("Allows resource to reconcile periodically.")
  periodic: "periodic",
}
