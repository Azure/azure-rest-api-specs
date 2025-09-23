import "@typespec/rest";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;

@doc("A Gate controls the progression during a staged rollout, e.g. in an Update Run.")
@added(Versions.v2025_04_01_preview)
@resource("gates")
@parentResource(Fleet)
model Gate is ProxyResource<GateProperties> {
  @doc("The name of the Gate resource, a GUID.")
  @pattern("^[0-9a-f]{8}[-][0-9a-f]{4}[-][0-9a-f]{4}[-][0-9a-f]{4}[-][0-9a-f]{12}$")
  @minLength(36)
  @maxLength(36)
  @key("gateName")
  @path
  @segment("gates")
  @visibility(Lifecycle.Read)
  name: string;

  ...EntityTagProperty;
}

@doc("The type of the Gate determines how it is completed.")
@added(Versions.v2025_04_01_preview)
union GateType {
  string,

  @doc("An approval gate is completed by setting its state to be Completed.")
  Approval: "Approval",
}

@doc("The state of the Gate.")
@added(Versions.v2025_04_01_preview)
union GateState {
  string,

  @doc("A Pending Gate will continue to block the staged rollout process it is controlling.")
  Pending: "Pending",

  @doc("A Skipped Gate means that the staged rollout process it is controlling was skipped.")
  Skipped: "Skipped",

  @doc("An Completed Gate allows the staged rollout process to continue.")
  Completed: "Completed",
}

@doc("A Gate controls the progression during a staged rollout, e.g. in an Update Run.")
@added(Versions.v2025_04_01_preview)
model GateProperties {
  // adding a response header in the model currently impacts the model used in the List result model.
  // omitting it for now as response headers do not impact SDK generation.
  // ...EtagResponseEnvelope;

  @doc("The provisioning state of the Gate resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: GateProvisioningState;

  @doc("The human-readable display name of the Gate.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(100)
  displayName?: string;

  @doc("The type of the Gate determines how it is completed.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  gateType: GateType;

  @doc("The target that the Gate is controlling, e.g. an Update Run.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  target: GateTarget;

  @doc("The state of the Gate.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  state: GateState;
}

@doc("The type of the Gate target.")
@added(Versions.v2025_04_01_preview)
union GateTargetType {
  string,

  @doc("The Gate targets an Update Run.")
  UpdateRun: "UpdateRun",
}

@doc("The properties of the Update Run that the Gate is targeting.")
@added(Versions.v2025_04_01_preview)
model UpdateRunGateTargetProperties {
  @doc("The name of the Update Run.")
  @visibility(Lifecycle.Read)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(50)
  name: string;

  @doc("The Update Stage of the Update Run.")
  @visibility(Lifecycle.Read)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(50)
  stage?: string;

  @doc("The Update Group of the Update Run.")
  @visibility(Lifecycle.Read)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(50)
  group?: string;

  @doc("Whether the Gate is placed before or after the update itself.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  timing: Timing;
}

@doc("Whether the Gate is placed before or after the target.")
@added(Versions.v2025_04_01_preview)
union Timing {
  string,

  @doc("The Gate is before the target.")
  Before: "Before",

  @doc("The Gate is after the target.")
  After: "After",
}

scalar UpdateRunResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/fleets/updateRuns",
    }
  ]>;

alias GateTargetId = UpdateRunResourceId;

@doc("The target that the Gate is controlling, e.g. an Update Run. Exactly one of the properties objects will be set.")
@added(Versions.v2025_04_01_preview)
model GateTarget {
  @doc("The resource id that the Gate is controlling the rollout of.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  id: GateTargetId;

  @doc("The properties of the Update Run that the Gate is targeting.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  updateRunProperties?: UpdateRunGateTargetProperties;
}

@doc("The provisioning state of the Gate resource.")
@lroStatus
union GateProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("Patch a Gate resource.")
@added(Versions.v2025_04_01_preview)
model GatePatch {
  // adding a response header in the model currently impacts the model used in the List result model.
  // omitting it for now as response headers do not impact SDK generation.
  // ...EtagResponseEnvelope;

  @doc("Properties of a Gate that can be patched.")
  properties: GatePatchProperties;
}

@doc("Properties of a Gate that can be patched.")
@added(Versions.v2025_04_01_preview)
model GatePatchProperties {
  @doc("The state of the Gate.")
  state: GateState;
}

@armResourceOperations
@added(Versions.v2025_04_01_preview)
interface Gates {
  get is ArmResourceRead<Gate>;

  // The create and delete APIs are both internal-only as Gates are created by the Update Run during
  // its processing. As such, we only expose the update API here.
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "must change at next release"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    Gate,
    GatePatch,
    Azure.ResourceManager.Foundations.BaseParameters<Gate> &
      IfMatchParameters<Gate> &
      IfNoneMatchParameters<Gate>
  >;

  listByFleet is ArmResourceListByParent<Gate>;
}
