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
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read", "create")
  @doc("Describes the type of the change.")
  changeType: ChangeType;

  @visibility("read", "create", "update")
  @doc("Brief description about the change.")
  @maxLength(2000)
  description?: string;

  @visibility("read", "create")
  @doc("Azure resource Id of the referenced StageMap.")
  stageMapResourceId: StageMapResourceId;

  @visibility("read", "create")
  @doc("Object that describes the change payload.")
  changeArtifact: ChangeArtifact;

  @visibility("read", "create")
  @doc("Change is expected to be expired by date, in ISO 8601 format.")
  expirationDate: utcDateTime;

  @visibility("read", "create", "update")
  @doc("URI to the external service catalog reference.")
  serviceCatalogReference?: url;

  @visibility("read", "create", "update")
  @doc("URI to the work item related to this change.")
  workItemReference?: url;

  @visibility("read", "create", "update")
  @doc("Internal status of the changestate resource.")
  state: ChangeStatus;

  @visibility("read", "create", "update")
  @doc("Comments about the last update to the changeState resource.")
  @maxLength(2000)
  comments?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: We need list of parameters in key:value format."
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need the Parameters to be strong type. So need to provide all the supported types which are string & int for now."
  @doc("Schema of parameters that will be provided for each stageProgression.")
  @visibility("read", "create")
  stageParameters: Record<Parameter>;

  @doc("Referenced stagemap snapshot.")
  @visibility("hidden")
  stageMapSnapshot?: string;
}

@doc("RetrieveNextStage POST Action response.")
model RetrieveNextStagesResponse {
  @doc("ChangeState resource Id.")
  changeStateResourceId: ChangeStateResourceId;

  @doc("Last stage sequence in the StageProgression.")
  lastStageSequence: int32;

  @doc("StageProgression resources that are ready to put in 'InProgress' state.")
  @OpenAPI.extension("x-ms-identifiers", ["stageReference"])
  nextStages: RetrieveNextStagesResponseItem[];
}

@doc("StageProgression data comes from RetrieveNextStages API.")
model RetrieveNextStagesResponseItem {
  @doc("Stage name relevant to the hierarchical StageMap. Identifies the stage uniquely within a changestate resource.")
  @visibility("read")
  stageReference: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: We need list of parameters in key:value format."
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need the Parameters to be strong type. So need to provide all the supported types which are string & int for now."
  @doc("Parameters to apply on the change for the stage.")
  @visibility("read")
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
  @visibility("read", "create", "update")
  @doc("Artifact label.")
  name: string;

  @visibility("read", "create", "update")
  @doc("The type of the artifact.")
  artifactType: ArtifactType;
}

/* ChangeArtifact for InlineArmTemplate. */
@doc("Describes the change payload for InlineArmTemplate or InlineBicep")
model InlineArmTemplateChangeArtifact extends ChangeArtifact {
  @visibility("read", "create", "update")
  @doc("The type of the artifact.")
  artifactType: ArtifactType.InlineArmTemplate;

  @visibility("read", "create")
  @doc("The actual payload content.")
  artifactPayload: InlineArtifactContent;
}

/* ChangeArtifact for InlineBicep. */
@doc("Describes the change payload for InlineBicep")
model InlineBicepTemplateChangeArtifact extends ChangeArtifact {
  @visibility("read", "create", "update")
  @doc("The type of the artifact.")
  artifactType: ArtifactType.InlineBicep;

  @visibility("read", "create", "update")
  @doc("The actual payload content.")
  artifactPayload: InlineArtifactContent;
}

/* ChangeArtifact for ArmOperation. */
@doc("Describes the change payload for artifactType='ArmOperation'")
model ArmOperationChangeArtifact extends ChangeArtifact {
  @visibility("read", "create", "update")
  @doc("The type of the artifact.")
  artifactType: ArtifactType.ArmOperation;

  @visibility("read", "create", "update")
  @doc("The actual payload content.")
  artifactPayload: ArmOperationArtifactContent;
}

/* ChangeArtifact for external ARM Template.*/
@doc("Describes the change payload for External ArmTemplate file.")
model ExternalArmTemplateChangeArtifact extends ChangeArtifact {
  @visibility("read", "create", "update")
  @doc("The type of the artifact.")
  artifactType: ArtifactType.ExternalArmTemplate;

  @visibility("read", "create", "update")
  @doc("The actual payload content.")
  artifactPayload: ExternalArtifactContent;
}

/* ChangeArtifact for external bicep file.*/
@doc("Describes the change payload for External Bicep file.")
model ExternalBicepTemplateChangeArtifact extends ChangeArtifact {
  @visibility("read", "create", "update")
  @doc("The type of the artifact.")
  artifactType: ArtifactType.ExternalBicep;

  @visibility("read", "create", "update")
  @doc("The actual payload content.")
  artifactPayload: ExternalArtifactContent;
}

/* ChangeArtifact for TemplateSpec.*/
@doc("Describes the change payload for artifactType=External & artifactType='ArmTemplate' or Bicep.")
model TemplateSpecChangeArtifact extends ChangeArtifact {
  @visibility("read", "create", "update")
  @doc("TemplateSpec Artifact type.")
  artifactType: ArtifactType.TemplateSpec;

  @visibility("read", "create", "update")
  @doc("The actual payload content.")
  artifactPayload: TemplateSpecArtifactContent;
}

/* Various content type definitions, based on the artifactType. */
@doc("Artifact content model for Inline template or bicep content.")
model InlineArtifactContent {
  @visibility("read", "create", "update")
  @doc("Inline ArmTemplate string or Bicep content.")
  script: string;
}

@doc("Artifact model when artifactType is ArmOperation.")
model ArmOperationArtifactContent {
  @doc("Arm Operation array.")
  @visibility("read", "create", "update")
  @OpenAPI.extension("x-ms-identifiers", ["resourceId"])
  operations: ArmOperationResource[];
}

@doc("Artifact content model for Inline ArmOperations.")
model ArmOperationResource {
  @doc("Target resource Id that needs to be changed.")
  @visibility("read", "create", "update")
  resourceId: string;

  @doc("ARM operation. eg: DELETE")
  @visibility("read", "create", "update")
  operation: ArmOperation;
}

@doc("Artifact content model for External ArmTemplates or Bicep files.")
model ExternalArtifactContent {
  @doc("URI for the external ARM template or Bicep file.")
  @visibility("read", "create", "update")
  uri: url;
}

@doc("Artifact content model for TemplateSpec resource.")
model TemplateSpecArtifactContent {
  @doc("TemplateSpec resource Id in ARM.")
  @visibility("read", "create", "update")
  resourceId: armResourceIdentifier;
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

  list is ArmResourceListAtScope<ChangeState>;
  listBySubscription is ArmListBySubscription<ChangeState>;
}
