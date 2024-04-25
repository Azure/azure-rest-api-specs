import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Symphony;

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

@doc("The properties of the route.")
model FilterProperties {
  @doc("The direction of the Filter.")
  direction: string;

  @doc("The type of the Filter.")
  type: string;

  @doc("The parameters of the Filter.")
  parameters?: Record<string>;
}

@doc("Defines a desired runtime component")
model ComponentProperties {
  @doc("Array of field values.")
  name: string;

  @doc("Metadata of Component")
  metadata?: Record<string>;

  @doc("Properties of Component")
  properties?: Record<unknown>;

  @doc("Constraints of Component")
  constraints?: string;

  @doc("Dependencies of Component")
  @OpenAPI.extension("x-ms-identifiers", [])
  dependencies?: Array<string>;

  @doc("Type of Component")
  type: string;
}

@doc("Defines a desired runtime binding")
model BindingProperties {
  @doc("The provider of the Binding.")
  provider: string;

  @doc("The config of the Binding.")
  //@extension("x-ms-identifiers", [])
  config?: Record<string>;

  @doc("The role of the Binding.")
  role: string;
}

@doc("Defines a desired runtime topology")
model TopologyProperties {

  @doc("The bindings of the Topology")
  @OpenAPI.extension("x-ms-identifiers", [])
  bindings?: Array<BindingProperties>;
}

@doc("Defines the ReconciliationPolicy")
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

  @doc("The interval of the ReconciliationPolicy")
  interval: string;
}

@doc("Defines a InstanceTarget")
model InstanceTargetProperties {

  @doc("The name of the InstanceTarget")
  name?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The selector of the InstanceTarget")
  selector?: Record<string>;
}

@doc("Defines a Schedule")
model ScheduleProperties {
  @doc("The date of the Schedule")
  date: string;

  @doc("The time of the Schedule")
  time: string;

  @doc("The zone of the Schedule")
  zone: string;
}

@doc("Defines a Stage")
model StageProperties {

  @doc("The contexts of the Stage")
  contexts?: string;

  @doc("The config of the Stage")
  config?: Record<unknown>;

  @doc("The inputs of the Stage")
  inputs?: Record<unknown>;

  @doc("The name of the Stage")
  name?: string;

  @doc("The provider of the Stage")
  provider?: string;

  @doc("The stageSelector of the Stage")
  stageSelector?: string;

  @doc("The schedule of the Stage")
  schedule: ScheduleProperties
}

@doc("Defines a ActivationStatus")
model ActivationStatusProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The inputs of the ActivationStatus")
  inputs?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The outputs of the ActivationStatus")
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

  @doc("The status of the ActivationStatus")
  status?: int32;
}

@doc("Defines a CatalogStatus")
model CatalogStatusProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The properties of the CatalogStatus")
  properties: Record<string>;
}