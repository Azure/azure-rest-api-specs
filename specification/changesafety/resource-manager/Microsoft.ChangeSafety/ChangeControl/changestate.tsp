import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commonmodels.tsp";
import "./stageprogression.tsp";
import "./stagemap.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.ChangeSafety;

@doc("Resource allows the user to define the change that they intended to execute & indicate the progression it will use.")
model ChangeState is ProxyResource<ChangeStateProperties> {
  @pattern("^[a-zA-Z0-9-]{3,100}$")
  @key("changeStateName")
  @segment("changeStates")
  @path
  @minLength(3)
  @maxLength(100)
  @doc("The name of the ChangeState resource.")
  name: string;
}

@doc("Detailed properties of the ChangeState resource.")
model ChangeStateProperties {
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
  @doc("Current status of the ChangeStatus resource.")
  status?: ChangeStatus;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Comments about the last update to the changeState resource.")
  @maxLength(2000)
  comments?: string;

  #suppress "@azure-tools/typespec-autorest/union-unsupported" "The wire snapshot contains resource ID strings and StageMap objects. The Swagger 2 emitter emits untyped items for this union; retain the existing representation for compatibility pending ARM review."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "The wire snapshot contains resource ID strings and StageMap objects. The Swagger 2 emitter emits untyped items for this union; retain the existing representation for compatibility pending ARM review."
  @doc("Referenced stagemap snapshot.")
  @visibility(Lifecycle.Read)
  stageMapSnapshot?: Array<string | StageMap>;

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
  @doc("change request body and/or resource selection criteria used to identify the targeted resources.")
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
}

@doc("RetrieveNextStages POST Action response.")
model RetrieveNextStagesResponse {
  @doc("ChangeState resource Id.")
  changeStateResourceId: ChangeStateResourceId;

  @doc("Sequence of last StageProgression completed within the ChangeState.")
  lastStageProgressionSequence: int32;

  @doc("StageProgression resources that are ready to put in 'InProgress' state.")
  @Azure.ResourceManager.identifiers(#["stageReference"])
  nextStages: Array<RetrieveNextStagesResponseItem>;
}

@doc("StageProgression data comes from RetrieveNextStages API.")
model RetrieveNextStagesResponseItem {
  @doc("Stage name relevant to the hierarchical StageMap. Identifies the stage uniquely within a changestate resource.")
  @visibility(Lifecycle.Read)
  stageReference: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Stage specific key value pairs of parameter names & their values."
  @doc("Variables to apply on the change for the stage. Key value pairs supporting any JSON values.")
  @visibility(Lifecycle.Read)
  stageVariables?: Record<unknown>;

  @doc("Current state of the stage progression.")
  @visibility(Lifecycle.Read)
  status?: StageProgressionState;

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

@doc("Internal status of the ChangeState resource.")
union ChangeStatus {
  string,

  @doc("Resource initialized status.")
  Initialized: "Initialized",

  @doc("Resource is currently In progress.")
  InProgress: "InProgress",

  @doc("Resource is completed the execution.")
  Completed: "Completed",

  @doc("Resource is Cancelled.")
  Cancelled: "Cancelled",

  @doc("Resource is in Paused state.")
  Paused: "Paused",

  @doc("Resource is in NotApplicable state, when no stagemap is associated with the change.")
  NotApplicable: "NotApplicable",
}

@doc("Defines the Kind of the intended Change.")
union ChangeType {
  string,

  @doc("Application deployment change.")
  AppDeployment: "AppDeployment",

  @doc("Configuration change.")
  Config: "Config",

  @doc("Policy deployment change.")
  PolicyDeployment: "PolicyDeployment",

  @doc("Manual touch change.")
  ManualTouch: "ManualTouch",
}

/* ChangeArtifact for InlineArmTemplate. */

/* ChangeArtifact for InlineBicep. */

/* ChangeArtifact for ArmOperation. */

/* ChangeArtifact for external ARM Template.*/

/* ChangeArtifact for external bicep file.*/

/* ChangeArtifact for TemplateSpec.*/

/* Various content type definitions, based on the artifactType. */

@doc("Artifact content model for Inline ArmOperations.")
model ArmResourceOperation {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The uri of the operation.")
  uri: url;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The http method of the operation.")
  httpMethod: ArmOperation;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The target ARM resource provider and API version define the request body's properties and value types."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The resource operation request body.")
  body?: Record<unknown>;
}

@doc("VerifyChangeValidity POST Action request.")
model VerifyChangeValidityRequest {
  @doc("The resource operation.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  operation: ArmResourceOperation;

  @doc("The change safety resource Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  changeSafetyReferenceId?: armResourceIdentifier;

  @doc("The context of the verify change validity request.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  context?: VerifyChangeValidityRequestContext;
}

@doc("The context object of the verify change validity request.")
model VerifyChangeValidityRequestContext {
  @doc("The application Id performing the ARM operation.")
  clientId: string;
}

@doc("Resource operation content model.")
model OperationContent {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The name of the resource.")
  name?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The location of the resource.")
  location?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Properties are defined by the target resource provider, not by ChangeSafety."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The properties of the resource.")
  properties: {};
}

@doc("VerifyChangeValidity POST Action response.")
model VerifyChangeValidityResponse {
  @doc("The outcome of the verification.")
  outcome: ValidationOutcome;

  @doc("The explanation message of the verification.")
  message: string;

  @doc("The time when the validation result expires.")
  validUntil?: utcDateTime;
}

/* Different ChangeArtifact types */

@doc("Supported ARM Operations.")
union ArmOperation {
  string,

  @doc("DELETE ARM Operation.")
  DELETE: "DELETE",

  @doc("PUT ARM Operation.")
  PUT: "PUT",

  @doc("PATCH ARM Operation.")
  PATCH: "PATCH",

  @doc("POST ARM Operation.")
  POST: "POST",
}

@doc("Supported validation outcomes.")
union ValidationOutcome {
  string,

  @doc("Represents a Succeeded outcome.")
  Succeeded: "Succeeded",

  @doc("Represents a Failed outcome.")
  Failed: "Failed",

  @doc("Represents a Deferred outcome.")
  Deferred: "Deferred",
}

@doc("Azure resource Id of a ChangeState.")
scalar ChangeStateResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/changeStates",
    }
  ]>;

@armResourceOperations
@doc("The operations of the ChangeState resource.")
interface ChangeStates {
  get is ArmResourceRead<ChangeState>;
  getAtSubscriptionLevel is ArmResourceRead<
    ChangeState,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  createOrUpdate is ArmResourceCreateOrReplaceSync<ChangeState>;
  createOrUpdateAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    ChangeState,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  update is ArmResourcePatchSync<ChangeState, ChangeStateProperties>;
  updateAtSubscriptionLevel is ArmResourcePatchSync<
    ChangeState,
    ChangeStateProperties,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  delete is ArmResourceDeleteWithoutOkAsync<ChangeState>;
  deleteAtSubscriptionLevel is ArmResourceDeleteWithoutOkAsync<
    ChangeState,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  list is ArmResourceListAtScope<ChangeState>;
  listBySubscription is ArmListBySubscription<ChangeState>;

  @doc("Gets list of next stages that are eligible to put in 'InProgress' state in a changestate resource.")
  @action("retrieveNextStages")
  retrieveNextStages is ArmResourceActionSync<
    ChangeState,
    void,
    RetrieveNextStagesResponse
  >;

  @doc("Gets list of next stages that are eligible to put in 'InProgress' state in a changestate resource at subscription level.")
  @action("retrieveNextStages")
  retrieveNextStagesAtSubscriptionLevel is ArmResourceActionSync<
    ChangeState,
    void,
    RetrieveNextStagesResponse,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Verify the change validity.")
  @action("verifyChangeValidity")
  verifyChangeValidity is ArmResourceActionSync<
    ChangeState,
    VerifyChangeValidityRequest,
    VerifyChangeValidityResponse
  >;

  @doc("Verify the change validity at subscription level.")
  @action("verifyChangeValidity")
  verifyChangeValidityAtSubscriptionLevel is ArmResourceActionSync<
    ChangeState,
    VerifyChangeValidityRequest,
    VerifyChangeValidityResponse,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @doc("Retrieve the audit trail action, for a change state.")
  @action("retrieveAuditTrail")
  retrieveAuditTrail is ArmResourceActionSync<
    ChangeState,
    void,
    RetrieveAuditTrailResponse
  >;

  @doc("Retrieve the audit trail action, for a change state at subscription level.")
  @action("retrieveAuditTrail")
  retrieveAuditTrailAtSubscriptionLevel is ArmResourceActionSync<
    ChangeState,
    void,
    RetrieveAuditTrailResponse,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
}

@doc("The retrieve audit trail response model.")
model RetrieveAuditTrailResponse {
  @doc("Number of records in the response.")
  @visibility(Lifecycle.Read)
  totalRecords: int32;

  @doc("List of Audit trail records")
  @visibility(Lifecycle.Read)
  auditRecords: AuditRecord[];
}

@doc("Audit record model.")
model AuditRecord {
  @doc("Identifier for event as defined by source in the format of ARM resource Id.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The ARM formatted type of the record.")
  @visibility(Lifecycle.Read)
  type: string;

  @doc("Timestamp indicating when the event occurred.")
  @visibility(Lifecycle.Read)
  timestamp: utcDateTime;

  @doc("Identifier of the actor that triggered the event")
  @visibility(Lifecycle.Read)
  initiatedBy: string;

  @doc("Categorical type of the initiator \"User\", \"Application\", \"System\", etc.")
  @visibility(Lifecycle.Read)
  initiatedByType: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Provides flexible object schema as the The structure varies depending on the record type."
  @doc("A property bag containing detailed, record-specific data. The structure varies depending on the record type.")
  @visibility(Lifecycle.Read)
  properties: {};
}

@doc("Defines the type of rollout for the change.")
union RolloutType {
  string,

  @doc("Normal rollout type.")
  Normal: "Normal",

  @doc("Hotfix rollout type.")
  Hotfix: "Hotfix",

  @doc("Emergency rollout type.")
  Emergency: "Emergency",
}

@doc("Model that defines the change definition with name, type, and details.")
model ChangeDefinition {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Name of the change definition.")
  name: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Kind of the change definition.")
  kind: ChangeDefinitionType;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Allows for an extensible object structure to support diverse change scenarios."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Free form object containing additional details for the change definition.")
  details: {};
}

@doc("Defines the type of change definition.")
union ChangeDefinitionType {
  string,

  @doc("API operation change definition type.")
  ApiOperations: "ApiOperations",

  @doc("Target selection criteria change definition type.")
  Targets: "Targets",
}
