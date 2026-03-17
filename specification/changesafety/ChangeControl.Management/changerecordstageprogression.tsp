import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./commonmodels.tsp";
import "./changerecord.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ChangeSafety;

@added(Versions.v2026_01_01_preview)
@doc("Defines the progression of a change using these child resources, with ChangeRecord parent resource.")
@parentResource(ChangeRecord)
model ChangeRecordStageProgression
  is ProxyResource<ChangeRecordStageProgressionProperties> {
  @doc("Name of the stageProgression")
  @key("stageProgressionName")
  @segment("stageProgressions")
  @pattern("^[a-zA-Z0-9-|]{3,100}$")
  @minLength(3)
  @maxLength(100)
  @path
  name: string;
}

@added(Versions.v2026_01_01_preview)
@doc("Detailed properties of the ChangeRecord StageProgression resource.")
model ChangeRecordStageProgressionProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Stage name relevant to hierarchical StageMap.")
  @minLength(3)
  @maxLength(200)
  stageReference: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("StageProgression resource status.")
  status: ChangeRecordStageProgressionState;

  @visibility(Lifecycle.Read)
  @doc("The sequence of the stage within the ChangeRecord parent resource.")
  @minValue(1)
  sequence?: int32;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Stage specific key value pairs of parameter names & their values, which can be any type"
  @doc("Variables to apply on the change of that stage. Key value pairs supporting any JSON values.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  stageVariables?: Record<unknown>;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Comments about the update to the resource.")
  @maxLength(2000)
  comments?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Collection of related links for the change.")
  links?: Link[];

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Defines a flexible placeholder for stage specific meta data for diverse orchestration and change scenarios."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Additional metadata for the stageProgression resource.")
  additionalData?: {};

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Key value pairs of parameter names & their values for the current Stage.Value can be any type, hence using Unknown type."
  @doc("Stage specific key value pairs of parameter names & their values for the current Stage, If any.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  parameters?: Record<unknown>;
}

@added(Versions.v2026_01_01_preview)
@doc("Indicates the current status of the progression of the change within the stage for ChangeRecord.")
union ChangeRecordStageProgressionState {
  string,

  @doc("Change is initialized to be applied within the stage.")
  Initialized: "Initialized",

  @doc("Change is being applied within the stage.")
  InProgress: "InProgress",

  @doc("Change has successfully been applied to the stage.")
  Completed: "Completed",

  @doc("Change apply operation was cancelled.")
  Cancelled: "Cancelled",

  @doc("Change apply operation was paused.")
  Paused: "Paused",

  @doc("Change apply operation was failed.")
  Failed: "Failed",

  @doc("Change is not applied to the stage.")
  Skipped: "Skipped",

  @doc("Change has not yet been initialized for the stage.")
  Uninitialized: "Uninitialized",
}

@added(Versions.v2026_01_01_preview)
@doc("Azure resource Id of a ChangeRecord StageProgression.")
scalar ChangeRecordStageProgressionResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/changeRecords/stageProgressions",
    }
  ]>;

@added(Versions.v2026_01_01_preview)
@armResourceOperations
@doc("The operations of the ChangeRecord stageProgression resource.")
interface ChangeRecordStageProgressions {
  get is ArmResourceRead<ChangeRecordStageProgression>;

  getAtSubscriptionLevel is ArmResourceRead<
    ChangeRecordStageProgression,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  createOrUpdate is ArmResourceCreateOrReplaceSync<ChangeRecordStageProgression>;
  createOrUpdateAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    ChangeRecordStageProgression,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  delete is ArmResourceDeleteSync<ChangeRecordStageProgression>;
  deleteAtSubscriptionLevel is ArmResourceDeleteSync<
    ChangeRecordStageProgression,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  update is ArmResourcePatchSync<
    ChangeRecordStageProgression,
    ChangeRecordStageProgressionProperties
  >;
  updateAtSubscriptionLevel is ArmResourcePatchSync<
    ChangeRecordStageProgression,
    ChangeRecordStageProgressionProperties,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  listByParent is ArmResourceListByParent<ChangeRecordStageProgression>;
  listByParentAtSubscriptionLevel is ArmResourceListByParent<
    ChangeRecordStageProgression,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Retrieve the audit trail action for a ChangeRecord StageProgression.")
  @action("retrieveAuditTrail")
  retrieveAuditTrail is ArmResourceActionSync<
    ChangeRecordStageProgression,
    void,
    ChangeRecordRetrieveAuditTrailResponse
  >;

  @doc("Retrieve the audit trail action for a ChangeRecord StageProgression at subscription level.")
  @action("retrieveAuditTrail")
  retrieveAuditTrailAtSubscriptionLevel is ArmResourceActionSync<
    ChangeRecordStageProgression,
    void,
    ChangeRecordRetrieveAuditTrailResponse,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
}
