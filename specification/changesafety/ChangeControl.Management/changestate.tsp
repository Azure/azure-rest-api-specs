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
  changeType: ChangeType;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Brief description about the change.")
  @maxLength(2000)
  description?: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Azure resource Id of the referenced StageMap.")
  stageMapResourceId: StageMapResourceId;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Object that describes the change payload.")
  changeArtifact: ChangeArtifact;

  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Change is expected to be expired by date, in ISO 8601 format.")
  expirationDate: utcDateTime;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("URI to the external service catalog reference.")
  serviceCatalogReference?: url;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("URI to the work item related to this change.")
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
  stageParameters: Record<Parameter>;

  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need to have a strong type for the stagemap snapshot. So need to provide all the supported types which are string & StageMap for now."
  @added(Versions.v2025_03_01_preview)
  @doc("Referenced stagemap snapshot.")
  @visibility(Lifecycle.Read)
  stageMapSnapshot?: Array<string | StageMap>;
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
  parameterValues: Record<string | int32>;
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
  Abandoned: "Abandoned",

  @doc("Resource is in Paused state.")
  Paused: "Paused",

  @doc("Resource is in Failed state.")
  Failed: "Failed",
}

@doc("Defines the Kind of the intended Change.")
union ChangeType {
  string,

  @doc("Regular resource change.")
  Normal: "Normal",

  @doc("An Emergency type resource change.")
  Emergency: "Emergency",

  @doc("Breakglass level resource change.")
  Breakglass: "Breakglass",
}

@doc("Base type for the ChangeArtifact, which is polymorphic based on ArtifactType")
@discriminator("artifactType")
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
  stageProgressionId?: armResourceIdentifier;
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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: This properties are varying based on different resources. We need list of parameters in key:value format."
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need to provide the paramters of the properties to be string and int."
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("The properties of the resource.")
  properties: Record<string | int32>;
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

/* Supported ARM Operations Enum string. */
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

/* Supported validation outcome Enum string. */
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
