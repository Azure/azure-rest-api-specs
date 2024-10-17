import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

// InlineArmTemplate
// InlineBicep
// ArmOperation
// ExternalArmTemplate
// ExternalBicep
// TemplateSpec

@doc("Base type for the ChangeArtifact, which is polymorphic based on ArtifactType")
@discriminator("artifactType")
model ChangeArtifact {
  @visibility("read", "create")
  @doc("Artifact label.")
  name: string;

  @visibility("read", "create")
  @doc("The type of the artifact.")
  artifactType: ArtifactType;
}

/* ChangeArtifact for InlineArmTemplate or InlineBicep. */
@doc("Describes the change payload for InlineArmTemplate or InlineBicep")
model InlineTemaplateChangeArtifact extends ChangeArtifact {
  @visibility("read", "create")
  @doc("The type of the artifact.")
  artifactType: ArtifactType.InlineArmTemplate | ArtifactType.InlineBicep;

  @visibility("read", "create")
  @doc("The actual payload content.")
  artifactPayload: InlineTemplateArtifactContent;
}

/* ChangeArtifact for ArmOperation. */
@doc("Describes the change payload for Kind=Inline & artifactType='ArmOperation'")
model ArmOperationChangeArtifact extends ChangeArtifact {
  @visibility("read", "create")
  @doc("The type of the artifact.")
  artifactType: ArtifactType.ArmOperation;

  @visibility("read", "create")
  @doc("The actual payload content.")
  artifactPayload: ArmOperationArtifactContent;
}

/* ChangeArtifact for external ARM Template or bicep file.*/
@doc("Describes the change payload for External ArmTemplate or Bicep file.")
model ExternalArmTemplateChangeArtifact extends ChangeArtifact {
  @visibility("read", "create")
  @doc("The type of the artifact.")
  artifactType: ArtifactType.ExternalArmTemplate | ArtifactType.ExternalBicep;

  @visibility("read", "create")
  @doc("The actual payload content.")
  artifactPayload: ExternalArmTemplateArtifactContent;
}

/* ChangeArtifact for TemplateSpec.*/
@doc("Describes the change payload for Kind=External & artifactType='ArmTemplate' or Bicep.")
model TemplateSpecChangeArtifact extends ChangeArtifact {
  @visibility("read", "create")
  @doc("TemplateSpec Artifact type.")
  artifactType: ArtifactType.TemplateSpec;

  @visibility("read", "create")
  @doc("The actual payload content.")
  artifactPayload: TemplateSpecArtifactContent;
}

/* Various content type definitions, based on the artifactType. */
@doc("Artifact content model for Inline template or bicep content.")
model InlineTemplateArtifactContent {
  @doc("Inline ArmTemplate string or Bicep content.")
  script: string;
}

@doc("Artifact model when artifactType is ArmOperation.")
model ArmOperationArtifactContent {
  @doc("Arm Operation array.")
  @OpenAPI.extension("x-ms-identifiers", ["resourceId"])
  operations: ArmOperationResource[];
}

@doc("Artifact content model for Inline ArmOperations.")
model ArmOperationResource {
  @doc("Target resource Id that needs to be changed.")
  @visibility("read", "create")
  resourceId: string;

  @doc("ARM operation. eg: DELETE")
  @visibility("read", "create")
  operation: ArmOperation;
}

@doc("Artifact content model for External ArmTemplates.")
model ExternalArmTemplateArtifactContent {
  @doc("URI for the external ARM template or Bicep file.")
  @visibility("read", "create")
  uri: url;
}

@doc("Artifact content model for TemplateSpec resource.")
model TemplateSpecArtifactContent {
  @doc("TemplateSpec resource Id in ARM.")
  @visibility("read", "create")
  resourceId: string;
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
