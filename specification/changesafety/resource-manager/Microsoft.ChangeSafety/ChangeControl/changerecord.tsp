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

@doc("Resource allows the user to define the change that they intended to execute & indicate the progression it will use. ChangeRecord replaces the deprecated ChangeState resource.")
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

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Current Status of the ChangeRecord resource.")
  status?: ChangeRecordStatus;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Comments about the last update to the ChangeRecord resource.")
  @maxLength(2000)
  comments?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Reference to the StageMap, defining progression.")
  stageMap?: NestedStageMap;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Key value pairs of parameter names & their values for the current Stage.Value can be any type, hence using Unknown type."
  @doc("Schema of parameters that will be provided for each stageProgression.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  parameters?: Record<Parameter>;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Describes the type of the rollout used for the change.")
  rolloutType: RolloutType;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Change request body and/or resource selection criteria used to identify the targeted resources.")
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
  links?: Link[];

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Defines a flexible placeholder for tool-specific metadata for diverse orchestration and change scenarios."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Additional metadata for the change required for various orchestration tools.")
  additionalData?: {};

  @doc("Captured StageMap references and optional resource contents.")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  @visibility(Lifecycle.Read)
  stageMapSnapshot?: StageMapSnapshot[];
}

@doc("RetrieveNextStages POST Action response for ChangeRecord.")
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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Stage specific key value pairs of parameter names & their values."
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
  links?: Link[];

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Provides flexible object schema for stage-specific orchestration metadata and dynamic tool-specific configuration data."
  @visibility(Lifecycle.Read)
  @doc("Additional metadata related to the StageProgression resource.")
  additionalData?: {};

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Parameters can be any type and can have an arbitrary name as key, hence using a Record."
  @doc("List of Parameters & their schemas for the current Stage that user supposed to provide.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  parameters?: Record<Parameter>;
}

@doc("Internal status of the ChangeRecord resource.")
union ChangeRecordStatus {
  string,

  @doc("Resource initialized status.")
  Initialized: "Initialized",

  @doc("Resource is currently In progress.")
  InProgress: "InProgress",

  @doc("Resource is completed the execution.")
  Completed: "Completed",

  @doc("Resource is Cancelled.")
  Cancelled: "Cancelled",

  @doc("Resource is in NotApplicable state, when no stagemap is associated with the change.")
  NotApplicable: "NotApplicable",

  @doc("Resource is in Paused state.")
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

  @doc("The change safety resource Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  changeSafetyReferenceId?: armResourceIdentifier;

  @doc("The context of the verify change validity request.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  context?: ChangeRecordVerifyChangeValidityRequestContext;
}

@doc("The context object of the verify change validity request for ChangeRecord.")
model ChangeRecordVerifyChangeValidityRequestContext {
  @doc("The application Id performing the ARM operation.")
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
  listBySubscription is ArmListBySubscription<ChangeRecord>;

  @doc("Gets list of next stages that are eligible to put in 'InProgress' state in a ChangeRecord resource.")
  @action("retrieveNextStages")
  retrieveNextStages is ArmResourceActionSync<
    ChangeRecord,
    void,
    ChangeRecordRetrieveNextStagesResponse
  >;

  @doc("Gets list of next stages that are eligible to put in 'InProgress' state in a ChangeRecord resource at subscription level.")
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
