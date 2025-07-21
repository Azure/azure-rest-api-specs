import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commonmodels.tsp";
import "./stageprogression.tsp";
import "./stagemap.tsp";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

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

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Describes the type of the change.")
  @renamedFrom(Versions.v2025_07_01_preview, "changeType")
  @removed(Versions.v2025_07_01_preview)
  changeTypeOld: ChangeType;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.v2025_07_01_preview)
  @doc("Describes the nature of the change.")
  changeType: ChangeType;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Brief description about the change.")
  @maxLength(2000)
  description?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Azure resource Id of the referenced StageMap.")
  @removed(Versions.v2025_07_01_preview)
  stageMapResourceId: StageMapResourceId;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Object that describes the change payload.")
  @removed(Versions.v2025_07_01_preview)
  changeArtifact: ChangeArtifact;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Change is expected to be expired by date, in ISO 8601 format.")
  @removed(Versions.v2025_07_01_preview)
  expirationDate: utcDateTime;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("URI to the external service catalog reference.")
  @removed(Versions.v2025_07_01_preview)
  serviceCatalogReference?: url;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("URI to the work item related to this change.")
  @removed(Versions.v2025_07_01_preview)
  workItemReference?: url;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Internal status of the changestate resource.")
  state: ChangeStatus;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Comments about the last update to the changeState resource.")
  @maxLength(2000)
  comments?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: We need list of parameters in key:value format."
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need the Parameters to be strong type. So need to provide all the supported types which are string & int for now."
  @doc("Schema of parameters that will be provided for each stageProgression.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @removed(Versions.v2025_07_01_preview)
  stageParameters: Record<Parameter>;

  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need to have a strong type for the stagemap snapshot. So need to provide all the supported types which are string & StageMap for now."
  @added(Versions.v2025_03_01_preview)
  @doc("Referenced stagemap snapshot.")
  @visibility(Lifecycle.Read)
  @renamedFrom(Versions.v2025_07_01_preview, "stageMapSnapshot")
  @removed(Versions.v2025_07_01_preview)
  stageMapSnapshotOld?: Array<string | StageMap>;

  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need to have a strong type for the stagemap snapshot. So need to provide all the supported types which are string & StageMap for now."
  @added(Versions.v2025_07_01_preview)
  @doc("Referenced stagemap snapshot.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read)
  stageMapSnapshot?: Array<string | StageMap>;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Reference to the StageMap, defining progression.")
  @added(Versions.v2025_07_01_preview)
  stageMap: NestedStageMap;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning of operation parameters should not be of type Record as per ARM."
  @doc("Schema of parameters that will be provided for each stageProgression.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.v2025_07_01_preview)
  parameters?: Record<Parameter>;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Describes the type of the rollout used for the change.")
  @added(Versions.v2025_07_01_preview)
  rolloutType: RolloutType;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Collection of payloads defining what will be deployed.")
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  @added(Versions.v2025_07_01_preview)
  changeDefinitions: ChangeDefinition[];

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Label for the release associated with this change.")
  @added(Versions.v2025_07_01_preview)
  releaseLabel?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Expected start time when the change execution should begin, in ISO 8601 format.")
  @added(Versions.v2025_07_01_preview)
  anticipatedStartTime: utcDateTime;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Expected completion time when the change should be finished, in ISO 8601 format.")
  @added(Versions.v2025_07_01_preview)
  anticipatedEndTime: utcDateTime;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Tool used for deployment orchestration of this change.")
  @added(Versions.v2025_07_01_preview)
  orchestrationTool?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Collection of related links for the change.")
  @added(Versions.v2025_07_01_preview)
  links?: ChangeLinks;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Defines a flexible placeholder for tool-specific metadata for diverse orchestration and change scenarios."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Additional metadata for the change required for various orchestration tools.")
  @added(Versions.v2025_07_01_preview)
  additionalData?: {};
}

@doc("RetrieveNextStages POST Action response.")
model RetrieveNextStagesResponse {
  @doc("ChangeState resource Id.")
  changeStateResourceId: ChangeStateResourceId;

  @removed(Versions.v2025_03_01_preview)
  @doc("Last stage sequence in the StageProgression.")
  lastStageSequence: int32;

  @added(Versions.v2025_03_01_preview)
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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: We need list of parameters in key:value format."
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need the Parameters to be strong type. So need to provide all the supported types which are string & int for now."
  @doc("Parameters to apply on the change for the stage.")
  @visibility(Lifecycle.Read)
  @removed(Versions.v2025_07_01_preview)
  parameterValues: Record<string | int32>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Stage specific key value pairs of parameter names & their values."
  @doc("Variables to apply on the change for the stage. Key value pairs supporting any JSON values.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  stageVariables?: Record<unknown>;

  @doc("Current state of the stage progression.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  state?: StageProgressionState;

  @visibility(Lifecycle.Read)
  @doc("The sequence of the stageProgression resource.")
  @added(Versions.v2025_07_01_preview)
  sequence?: int32;

  @doc("Comments about the stage progression.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  comments?: string;

  @doc("Collection of related links for the stageprogression.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  links?: ChangeLinks;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Provides flexible object schema for stage-specific orchestration metadata and dynamic tool-specific configuration data."
  @visibility(Lifecycle.Read)
  @doc("Additional metadata related to the StageProgression resource.")
  @added(Versions.v2025_07_01_preview)
  additionalData?: {};
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

  @doc("Resource is Abandoned.")
  @removed(Versions.v2025_07_01_preview)
  Abandoned: "Abandoned",

  @doc("Resource is Cancelled.")
  @added(Versions.v2025_07_01_preview)
  Cancelled: "Cancelled",

  @doc("Resource is in Paused state.")
  Paused: "Paused",

  @doc("Resource is in Failed state.")
  Failed: "Failed",
}

@doc("Defines the Kind of the intended Change.")
union ChangeType {
  string,

  @doc("Regular resource change.")
  @removed(Versions.v2025_07_01_preview)
  Normal: "Normal",

  @doc("An Emergency type resource change.")
  @removed(Versions.v2025_07_01_preview)
  Emergency: "Emergency",

  @doc("Breakglass level resource change.")
  @removed(Versions.v2025_07_01_preview)
  Breakglass: "Breakglass",

  @doc("Application deployment change.")
  @added(Versions.v2025_07_01_preview)
  AppDeployment: "AppDeployment",

  @doc("Configuration change.")
  @added(Versions.v2025_07_01_preview)
  Config: "Config",

  @doc("Policy deployment change.")
  @added(Versions.v2025_07_01_preview)
  PolicyDeployment: "PolicyDeployment",

  @doc("Manual touch change.")
  @added(Versions.v2025_07_01_preview)
  ManualTouch: "ManualTouch",
}

@doc("Base type for the ChangeArtifact, which is polymorphic based on ArtifactType")
@discriminator("artifactType")
@removed(Versions.v2025_07_01_preview)
model ChangeArtifact {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Artifact label.")
  name: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The type of the artifact.")
  artifactType: ArtifactType;
}

/* ChangeArtifact for InlineArmTemplate. */
@doc("Describes the change payload for InlineArmTemplate or InlineBicep")
@removed(Versions.v2025_07_01_preview)
model InlineArmTemplateChangeArtifact extends ChangeArtifact {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The type of the artifact.")
  artifactType: ArtifactType.InlineArmTemplate;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The actual payload content.")
  artifactPayload: InlineArtifactContent;
}

/* ChangeArtifact for InlineBicep. */
@doc("Describes the change payload for InlineBicep")
@removed(Versions.v2025_07_01_preview)
model InlineBicepTemplateChangeArtifact extends ChangeArtifact {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The type of the artifact.")
  artifactType: ArtifactType.InlineBicep;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The actual payload content.")
  artifactPayload: InlineArtifactContent;
}

/* ChangeArtifact for ArmOperation. */
@doc("Describes the change payload for artifactType='ArmOperation'")
@removed(Versions.v2025_07_01_preview)
model ArmOperationChangeArtifact extends ChangeArtifact {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The type of the artifact.")
  artifactType: ArtifactType.ArmOperation;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The actual payload content.")
  artifactPayload: ArmOperationArtifactContent;
}

/* ChangeArtifact for external ARM Template.*/
@doc("Describes the change payload for External ArmTemplate file.")
@removed(Versions.v2025_07_01_preview)
model ExternalArmTemplateChangeArtifact extends ChangeArtifact {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The type of the artifact.")
  artifactType: ArtifactType.ExternalArmTemplate;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The actual payload content.")
  artifactPayload: ExternalArtifactContent;
}

/* ChangeArtifact for external bicep file.*/
@doc("Describes the change payload for External Bicep file.")
@removed(Versions.v2025_07_01_preview)
model ExternalBicepTemplateChangeArtifact extends ChangeArtifact {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The type of the artifact.")
  artifactType: ArtifactType.ExternalBicep;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The actual payload content.")
  artifactPayload: ExternalArtifactContent;
}

/* ChangeArtifact for TemplateSpec.*/
@doc("Describes the change payload for artifactType=External & artifactType='ArmTemplate' or Bicep.")
@removed(Versions.v2025_07_01_preview)
model TemplateSpecChangeArtifact extends ChangeArtifact {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("TemplateSpec Artifact type.")
  artifactType: ArtifactType.TemplateSpec;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The actual payload content.")
  artifactPayload: TemplateSpecArtifactContent;
}

/* Various content type definitions, based on the artifactType. */
@doc("Artifact content model for Inline template or bicep content.")
@removed(Versions.v2025_07_01_preview)
model InlineArtifactContent {
  @removed(Versions.v2025_03_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Inline ArmTemplate string or Bicep content.")
  script: string;

  @added(Versions.v2025_03_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Inline ArmTemplate string or Bicep content.")
  inlineScript: string;
}

@doc("Artifact model when artifactType is ArmOperation.")
@removed(Versions.v2025_07_01_preview)
model ArmOperationArtifactContent {
  #suppress "deprecated" "back compat"
  @removed(Versions.v2025_03_01_preview)
  @doc("Arm Operation Array.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @renamedFrom(Versions.v2025_03_01_preview, "operations")
  @Azure.ResourceManager.identifiers(#["resourceId"])
  operationsOld: ArmOperationResource[];

  @added(Versions.v2025_03_01_preview)
  @doc("Arm Operation Array.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @Azure.ResourceManager.identifiers(#["uri"])
  operations: ArmResourceOperation[];
}

@added(Versions.v2025_03_01_preview)
@doc("Artifact content model for Inline ArmOperations.")
model ArmResourceOperation {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The uri of the operation.")
  uri: url;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The http method of the operation.")
  httpMethod: ArmOperation;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The resource operation content.")
  content?: OperationContent;
}

@removed(Versions.v2025_03_01_preview)
@doc("Artifact content model for Inline ArmOperations.")
model ArmOperationResource {
  @doc("Target resource Id that needs to be changed.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  resourceId: string;

  @doc("ARM operation. eg: DELETE")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  operation: ArmOperation;
}

@doc("Artifact content model for External ArmTemplates or Bicep files.")
@removed(Versions.v2025_07_01_preview)
model ExternalArtifactContent {
  @removed(Versions.v2025_03_01_preview)
  @doc("URI for the external ARM template or Bicep file.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  uri: url;

  @added(Versions.v2025_03_01_preview)
  @doc("URI for the external ARM template or Bicep file.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  externalArtifactUri: url;
}

@doc("Artifact content model for TemplateSpec resource.")
@removed(Versions.v2025_07_01_preview)
model TemplateSpecArtifactContent {
  @removed(Versions.v2025_03_01_preview)
  @doc("TemplateSpec resource Id in ARM.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  resourceId: armResourceIdentifier;

  @added(Versions.v2025_03_01_preview)
  @doc("TemplateSpec artifact resource Id in ARM.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  artifactResourceId: armResourceIdentifier;
}

@added(Versions.v2025_03_01_preview)
@doc("VerifyChangeValidity POST Action request.")
model VerifyChangeValidityRequest {
  @doc("The resource operation.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  operation: ArmResourceOperation;

  @doc("The stage progression Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @removed(Versions.v2025_07_01_preview)
  stageProgressionId?: armResourceIdentifier;

  @added(Versions.v2025_03_01_preview)
  @doc("The stage progression resource Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  stageProgressionResourceId?: armResourceIdentifier;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Enables an extensible object schema to provide additional context data for the verification request."
  @doc("The context of the verify change validity request.")
  @added(Versions.v2025_07_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  context?: {};
}

@added(Versions.v2025_03_01_preview)
@doc("Resource operation content model.")
model OperationContent {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The name of the resource.")
  name?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The location of the resource.")
  location?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The properties of the resource.")
  properties: {};
}

@added(Versions.v2025_03_01_preview)
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
@doc("Defines the type of change artifact.")
@removed(Versions.v2025_07_01_preview)
union ArtifactType {
  string,

  /* InlineArmTemplate - Defines the arm template as a inline string. */
  @doc("Artifact is in the format of an ARM template specified inline.")
  InlineArmTemplate: "InlineArmTemplate",

  /* InlineBicep - Defines the Bicep file as an inline string */
  @doc("Artifact is in the format of inline Bicep file.")
  InlineBicep: "InlineBicep",

  @doc("Artifact is in the format of ARM API operations.")
  ArmOperation: "ArmOperation",

  @doc("Artifact is in the format of URI to an ArmTemplate stored in blob or other location.")
  ExternalArmTemplate: "ExternalArmTemplate",

  @doc("Artifact is in the format of URI to an Bicep stored in blob or other location.")
  ExternalBicep: "ExternalBicep",

  @doc("Artifact is in the format of TemplateSpec.")
  TemplateSpec: "TemplateSpec",
}

@doc("Supported ARM Operations.")
union ArmOperation {
  string,

  @doc("DELETE ARM Operation.")
  DELETE: "DELETE",

  @added(Versions.v2025_03_01_preview)
  @doc("PUT ARM Operation.")
  PUT: "PUT",

  @added(Versions.v2025_03_01_preview)
  @doc("PATCH ARM Operation.")
  PATCH: "PATCH",
}

@added(Versions.v2025_03_01_preview)
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
  @added(Versions.v2025_03_01_preview)
  verifyChangeValidity is ArmResourceActionSync<
    ChangeState,
    VerifyChangeValidityRequest,
    VerifyChangeValidityResponse
  >;

  @doc("Verify the change validity at subscription level.")
  @action("verifyChangeValidity")
  @added(Versions.v2025_03_01_preview)
  verifyChangeValidityAtSubscriptionLevel is ArmResourceActionSync<
    ChangeState,
    VerifyChangeValidityRequest,
    VerifyChangeValidityResponse,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
}

@doc("Defines the type of rollout for the change.")
@added(Versions.v2025_07_01_preview)
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
@added(Versions.v2025_07_01_preview)
model ChangeDefinition {
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Name of the change definition.")
  name: string;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Type of the change definition.")
  type: ChangeDefinitionType;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Allows for an extensible object structure to support diverse change scenarios."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Free form object containing additional details for the change definition.")
  details: {};
}

@doc("Defines the type of change definition.")
@added(Versions.v2025_07_01_preview)
union ChangeDefinitionType {
  string,

  @doc("ARM operation type.")
  ArmOperation: "ArmOperation",

  @doc("Scope type with ARM resource selectors.")
  ArmScope: "ArmScope",
}
