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
  direction: string;

  type: string;

  parameters?: Record<string>;
}

@doc("Defines a desired runtime component")
model ComponentProperties {
  @doc("Array of field values.")
  name: string;

  metadata?: Record<string>;

  properties?: Record<unknown>;

  constraints?: string;

  dependencies?: Array<string>;

  type: string;
}

@doc("Defines a desired runtime binding")
model BindingProperties {
  provider: string;
  //@extension("x-ms-identifiers", [])
  config?: Record<string>;

  role: string;
}

@doc("Defines a desired runtime topology")
model TopologyProperties {
  //@extension("x-ms-identifiers", [])
  bindings?: Array<BindingProperties>;
}

enum ReconciliationState {
  inactive: "inactive",
  active: "active",
}

// to do: need to confirm
model ReconciliationPolicyProperties {
  state: ReconciliationState;
  //@extension("x-ms-identifiers", [])
  interval: string;
}

model InstanceTargetProperties {
  name?: string;
  //@extension("x-ms-identifiers", [])
  selector?: Record<string>;
}

model ScheduleProperties {
  date: string;

  time: string;

  zone: string;
}

model StageProperties {
  contexts?: string;
  //@extension("x-ms-identifiers", [])
  config?: Record<unknown>;

  inputs?: Record<unknown>;

  name?: string;

  provider?: string;

  stageSelector?: string;

  schedule: ScheduleProperties
}

model ActivationStatusProperties {
  inputs?: Record<unknown>;

  outputs?: Record<unknown>;
  //@extension("x-ms-identifiers", [])
  stage: string;

  isActive?: boolean;

  nextStage?: string;

  errorMessage?: string;

  activationGeneration?: string;

  updateTime?: string;

  status?: int32;
}

model CatalogStatusProperties {
  properties: Record<string>;
}