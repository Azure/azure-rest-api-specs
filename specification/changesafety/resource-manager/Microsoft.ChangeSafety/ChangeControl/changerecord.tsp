import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commonmodels.tsp";
import "./changerecordstageprogression.tsp";
import "./stagemap.tsp";
import "./changemodels.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.ChangeSafety;

@doc("Resource allows the user to define the change that they intended to execute and indicate the progression it will use.")
model ChangeRecord is ProxyResource<ChangeRecordProperties> {
  @pattern("^[a-zA-Z0-9-]{3,100}$")
  @key("changeRecordName")
  @segment("changeRecords")
  @path
  @minLength(3)
  @maxLength(100)
  @doc("The name of the ChangeRecord resource.")
  name: string;
}

@doc("Detailed properties of the ChangeRecord resource.")
model ChangeRecordProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Describes the nature of the change.")
  changeType: ChangeType;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Brief description about the change.")
  @maxLength(2000)
  description?: string;

  @visibility(Lifecycle.Read)
  @doc("Server-observed lifecycle status. The service updates this value from accepted requestedStatus transitions and StageProgression activity.")
  status?: ChangeRecordStatus;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The last lifecycle transition requested by the client. The service preserves this value during automatic status updates. Create permits Initialized or InProgress. On update, a valid transition is applied even when this value is unchanged. An unchanged request whose transition has been superseded is acknowledged without changing observed status. NotApplicable cannot be requested.")
  requestedStatus?: ChangeRecordRequestedStatus;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Comments about the last update to the ChangeRecord resource.")
  @maxLength(2000)
  comments?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Reference to the StageMap, defining progression.")
  stageMap?: NestedStageMap;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Parameter names are customer-defined; ChangeSafety cannot enumerate the keys. Values use the typed Parameter schema."
  @doc("Schema of parameters that will be provided for each stageProgression.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  parameters?: Record<Parameter>;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Describes the type of the rollout used for the change.")
  rolloutType: RolloutType;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Planned operation references or resource-selection criteria used to identify the targeted resources.")
  changeDefinition: ChangeDefinition;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Label for the release associated with this change.")
  releaseLabel?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Expected start time when the change execution should begin, in ISO 8601 format.")
  anticipatedStartTime: utcDateTime;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Expected completion time when the change should be finished, in ISO 8601 format.")
  anticipatedEndTime: utcDateTime;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Tool used for deployment orchestration of this change.")
  orchestrationTool?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Collection of related links for the change.")
  @Azure.ResourceManager.identifiers(#[])
  links?: Link[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Orchestration tools define the keys and JSON value types of change metadata. A dictionary preserves their values in generated SDK serializers."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Additional metadata for the change required for various orchestration tools.")
  additionalData?: Record<unknown>;

  @doc("Captured StageMap references and optional properties.")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  @visibility(Lifecycle.Read)
  stageMapSnapshots?: StageMapSnapshot[];
}

@doc("Computed next-stage planning response for a ChangeRecord.")
model ChangeRecordRetrieveNextStagesResponse {
  @doc("ChangeRecord resource Id.")
  changeRecordResourceId: ChangeRecordResourceId;

  @doc("Sequence of last StageProgression completed within the ChangeRecord.")
  lastStageProgressionSequence: int32;

  @doc("StageProgression resources that are ready to put in 'InProgress' state.")
  @Azure.ResourceManager.identifiers(#["stageReference"])
  nextStages: Array<ChangeRecordRetrieveNextStagesResponseItem>;
}

@doc("StageProgression data comes from RetrieveNextStages API for ChangeRecord.")
model ChangeRecordRetrieveNextStagesResponseItem {
  @doc("Stage name relevant to the hierarchical StageMap. Identifies the stage uniquely within a ChangeRecord resource.")
  @visibility(Lifecycle.Read)
  stageReference: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Stage-variable names come from the StageMap, not fixed properties of this response. Values may be JSON scalars, arrays, or objects."
  @doc("Variables to apply on the change for the stage. Key value pairs supporting any JSON values.")
  @visibility(Lifecycle.Read)
  stageVariables?: Record<unknown>;

  @doc("Current state of the stage progression.")
  @visibility(Lifecycle.Read)
  status?: ChangeRecordStageProgressionState;

  @visibility(Lifecycle.Read)
  @doc("The sequence of the stageProgression resource.")
  sequence?: int32;

  @doc("Comments about the stage progression.")
  @visibility(Lifecycle.Read)
  comments?: string;

  @visibility(Lifecycle.Read)
  @doc("Collection of related links for the change.")
  @Azure.ResourceManager.identifiers(#[])
  links?: Link[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The response carries stage metadata defined by orchestration tools. A dictionary preserves the existing JSON values without inventing fixed metadata fields."
  @visibility(Lifecycle.Read)
  @doc("Additional metadata related to the StageProgression resource.")
  additionalData?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Parameter names are customer-defined; ChangeSafety cannot enumerate the keys. Values use the typed Parameter schema."
  @doc("List of Parameters & their schemas for the current Stage that user supposed to provide.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  parameters?: Record<Parameter>;
}

@doc("Server-observed lifecycle status of the ChangeRecord resource.")
union ChangeRecordStatus {
  string,

  @doc("Resource initialized status.")
  Initialized: "Initialized",

  @doc("Resource is currently In progress.")
  InProgress: "InProgress",

  @doc("The resource has completed execution.")
  Completed: "Completed",

  @doc("Resource is Cancelled.")
  Cancelled: "Cancelled",

  @doc("Resource is in NotApplicable state, when no stagemap is associated with the change.")
  NotApplicable: "NotApplicable",

  @doc("Resource is in Paused state.")
  Paused: "Paused",
}

@doc("A lifecycle transition requested by the client. NotApplicable is derived by the service and cannot be requested.")
union ChangeRecordRequestedStatus {
  string,

  @doc("Initialize the resource. This value is accepted on create.")
  Initialized: "Initialized",

  @doc("Start or resume execution.")
  InProgress: "InProgress",

  @doc("Complete execution, subject to the service's completion checks.")
  Completed: "Completed",

  @doc("Cancel execution.")
  Cancelled: "Cancelled",

  @doc("Pause execution.")
  Paused: "Paused",
}

@doc("Azure resource Id of a ChangeRecord.")
scalar ChangeRecordResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/changeRecords",
    }
  ]>;

@doc("VerifyChangeValidity POST Action request for ChangeRecord.")
model ChangeRecordVerifyChangeValidityRequest {
  @doc("The resource operation.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  operation: ArmResourceOperation;

  @doc("Optional resource ID of the StageProgression used for verification when the ChangeRecord has a StageMap. The ChangeRecord identified by the request path remains the verification target.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  changeSafetyReferenceId?: ChangeRecordStageProgressionResourceId;

  @doc("The context of the verify change validity request.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  context?: ChangeRecordVerifyChangeValidityRequestContext;
}

@doc("The context object of the verify change validity request for ChangeRecord.")
model ChangeRecordVerifyChangeValidityRequestContext {
  @doc("The application ID performing the Azure Resource Manager operation.")
  clientId: string;
}

@doc("VerifyChangeValidity POST Action response for ChangeRecord.")
model ChangeRecordVerifyChangeValidityResponse {
  @doc("The outcome of the verification.")
  outcome: ValidationOutcome;

  @doc("The explanation message of the verification.")
  message: string;

  @doc("The time when the validation result expires.")
  validUntil?: utcDateTime;
}

@armResourceOperations
@doc("The operations of the ChangeRecord resource.")
interface ChangeRecords {
  get is ArmResourceRead<ChangeRecord>;
  getAtSubscriptionLevel is ArmResourceRead<
    ChangeRecord,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  createOrUpdate is ArmResourceCreateOrReplaceSync<ChangeRecord>;
  createOrUpdateAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    ChangeRecord,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  update is ArmCustomPatchSync<
    ChangeRecord,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ChangeRecord,
      ChangeDefinitionPatchProperties<ChangeRecordProperties>
    >
  >;
  updateAtSubscriptionLevel is ArmCustomPatchSync<
    ChangeRecord,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ChangeRecord,
      ChangeDefinitionPatchProperties<ChangeRecordProperties>
    >,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  delete is ArmResourceDeleteWithoutOkAsync<ChangeRecord>;
  deleteAtSubscriptionLevel is ArmResourceDeleteWithoutOkAsync<
    ChangeRecord,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  list is ArmResourceListAtScope<ChangeRecord>;

  @doc("List ChangeRecord resources in the subscription. The list aggregates subscription-scoped and resource-group-scoped resources.")
  listBySubscription is ArmListBySubscription<ChangeRecord>;

  @doc("Gets list of next stages that are eligible to put in 'InProgress' state in a ChangeRecord resource.")
  @get
  @action("retrieveNextStages")
  retrieveNextStages is ArmResourceActionSync<
    ChangeRecord,
    void,
    ChangeRecordRetrieveNextStagesResponse
  >;

  @doc("Gets list of next stages that are eligible to put in 'InProgress' state in a ChangeRecord resource at subscription level.")
  @get
  @action("retrieveNextStages")
  retrieveNextStagesAtSubscriptionLevel is ArmResourceActionSync<
    ChangeRecord,
    void,
    ChangeRecordRetrieveNextStagesResponse,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Verify the change validity for a ChangeRecord.")
  @action("verifyChangeValidity")
  verifyChangeValidity is ArmResourceActionSync<
    ChangeRecord,
    ChangeRecordVerifyChangeValidityRequest,
    ChangeRecordVerifyChangeValidityResponse
  >;

  @doc("Verify the change validity at subscription level for a ChangeRecord.")
  @action("verifyChangeValidity")
  verifyChangeValidityAtSubscriptionLevel is ArmResourceActionSync<
    ChangeRecord,
    ChangeRecordVerifyChangeValidityRequest,
    ChangeRecordVerifyChangeValidityResponse,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
}
