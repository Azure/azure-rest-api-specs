import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ToolchainOrchestrator;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Extended location is an extension of Azure locations. They provide a way to use their Azure ARC enabled Kubernetes clusters as target locations for deploying Azure services instances.")
model ExtendedLocation {
  @doc("The name of the extended location.")
  name: string;

  @doc("The type of the extended location.")
  type: string;
}

/** The provisioning state of the resource */
union ProvisioningState {
  string,
  Azure.ResourceManager.ResourceProvisioningState,
}

@doc("Defines a desired runtime component.")
model ComponentProperties {
  @doc("Name of the component.")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  @doc("Metadata information of the component.")
  metadata?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  @doc("Properties of the component.")
  properties?: Record<unknown>;

  @doc("Constraints of the component.")
  constraints?: string;

  @doc("Dependencies of the component.")
  @OpenAPI.extension("x-ms-identifiers", [])
  dependencies?: Array<string>;

  @doc("Component type.")
  type: string;
}

@doc("Defines a binding for a provider.")
model BindingProperties {
  @doc("Name of the provider.")
  provider: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  @doc("Configuration values for the binding.")
  config?: Record<string>;

  @doc("Role that the provider binds to with the component.")
  role: string;
}

@doc("Defines a desired runtime topology")
model TopologyProperties {
  @doc("The bindings of the Topology")
  @OpenAPI.extension("x-ms-identifiers", [])
  bindings?: Array<BindingProperties>;
}

@doc("Defines a state of the reconciliation policy.")
union ReconciliationState {
  string,

  @doc("Reconciliation is inactive")
  inactive: "inactive",

  @doc("Reconciliation is active")
  active: "active",
}

@doc("Defines a ReconciliationPolicy")
model ReconciliationPolicyProperties {
  @doc("The state of the ReconciliationPolicy")
  state: ReconciliationState;

  @doc("Policy interval.")
  interval: string;
}

@doc("Properties of the reference target.")
model TargetSelectorProperties {
  @doc("Name of the TargetVersion resource.")
  name?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The selector of the TargetVersion resource.")
  selector?: Record<string>;
}

@doc("Defines a Stage")
model StageProperties {
  @doc("The contexts of the Stage")
  contexts?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  @doc("The config of the Stage")
  config?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  @doc("The inputs of the Stage")
  inputs?: Record<unknown>;

  @doc("The name of the Stage")
  name?: string;

  @doc("The provider of the Stage")
  provider?: string;

  @doc("The stageSelector of the Stage")
  stageSelector?: string;

  @doc("The schedule of the Stage")
  schedule?: utcDateTime;
}

@doc("Defines a ActivationStatus")
model ActivationStatusProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The inputs of the ActivationStatus, Inputs holds a key-value map of user-defined parameters for the initial stage")
  inputs?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The outputs of the ActivationStatus, it is different as the different input stages.")
  outputs?: Record<unknown>;

  @doc("The stage of the ActivationStatus")
  stage: string;

  @doc("The state of the ActivationStatus")
  isActive?: boolean;

  @doc("The nextStage of the ActivationStatus")
  nextStage?: string;

  @doc("The errorMessage of the ActivationStatus")
  errorMessage?: string;

  @doc("The activationGeneration of the ActivationStatus")
  activationGeneration?: string;

  @doc("The updateTime of the ActivationStatus")
  updateTime?: string;

  @doc("The status code of the ActivationStatus")
  status?: int32;

  @doc("The status message of the ActivationStatus")
  statusMessage?: string;
}

@doc("Defines a CatalogStatus")
model CatalogStatusProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The properties of the CatalogStatus")
  properties: Record<string>;
}

@doc("Defines a status for Target and Instance deployment")
model InstanceTargetStatusProperties {
  @doc("The lastModified of the Status")
  lastModified: utcDateTime;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The state properties of the Status")
  properties?: Record<string>;
}
