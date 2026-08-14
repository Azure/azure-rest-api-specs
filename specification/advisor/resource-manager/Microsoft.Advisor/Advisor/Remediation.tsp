import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Advisor;

/** The type of an inline remediation artifact. */
@added(Versions.v2026_08_12_preview)
union RemediationArtifactType {
  string,

  /** Markdown guidance that is always included in a successful response. */
  RemediationSteps: "remediationSteps",

  /** An Azure CLI script. */
  Cli: "cli",

  /** An Azure PowerShell script. */
  PowerShell: "powershell",

  /** A Bicep template. */
  Bicep: "bicep",

  /** An Azure Resource Manager template. */
  Arm: "arm",
}

/** The confidence assigned to remediation guidance. */
@added(Versions.v2026_08_12_preview)
union RemediationConfidence {
  string,

  /** The remediation has high confidence. */
  High: "high",

  /** The remediation has medium confidence. */
  Medium: "medium",

  /** The remediation has low confidence. */
  Low: "low",
}

/** The kind of remediation output. */
@added(Versions.v2026_08_12_preview)
union RemediationOutputType {
  string,

  /** The remediation can be applied by using an executable artifact. */
  Executable: "executable",
}

/** The relationship of a method to the primary remediation. */
@added(Versions.v2026_08_12_preview)
union RemediationMethodRelation {
  string,

  /** The primary remediation method. */
  Primary: "primary",

  /** An alternative remediation method. */
  Alternative: "alternative",

  /** A prerequisite for another remediation method. */
  Prerequisite: "prerequisite",

  /** A method to perform after the primary remediation. */
  FollowUp: "followUp",
}

/** The kind of an individual remediation step. */
@added(Versions.v2026_08_12_preview)
union RemediationStepKind {
  string,

  /** A command that can be run by the customer. */
  Command: "command",

  /** A manual instruction for the customer. */
  Instruction: "instruction",

  /** A validation step that confirms the remediation result. */
  Validation: "validation",
}

/** An inline artifact that can apply a remediation. */
@added(Versions.v2026_08_12_preview)
model RemediationArtifact {
  /** The artifact format. */
  artifactType: RemediationArtifactType;

  /** The media type of the inline artifact content. */
  contentType: string;

  /** The confidence assigned to the artifact. */
  confidence: RemediationConfidence;

  /** The complete artifact content to apply the remediation. */
  content: string;
}

/** The reason an executable artifact filter value was rejected. */
@added(Versions.v2026_08_12_preview)
union RemediationFilterRejectionReason {
  string,

  /** The requested artifact type is not supported. */
  UnsupportedArtifactType: "UnsupportedArtifactType",

  /** The requested artifact type is supported but is not available. */
  ArtifactUnavailable: "ArtifactUnavailable",
}

/** An executable artifact filter value that could not be fulfilled. */
@added(Versions.v2026_08_12_preview)
model RemediationRejectedFilterValue {
  /** The rejected filter value. */
  value: string;

  /** The reason the filter value was rejected. */
  reason: RemediationFilterRejectionReason;
}

/** Details about how an executable artifact filter was fulfilled. */
@added(Versions.v2026_08_12_preview)
model RemediationFilterResult {
  /** The executable artifact types requested by the client. */
  requestedValues: string[];

  /** The requested executable artifact types included in the response. */
  fulfilledValues: RemediationArtifactType[];

  /** The requested executable artifact types that were not included. */
  @identifiers(#["value"])
  rejectedValues: RemediationRejectedFilterValue[];
}

/** A parameter used by a remediation method. */
@added(Versions.v2026_08_12_preview)
model RemediationMethodParameter {
  /** The parameter name. */
  name: string;

  /** A description of the parameter's purpose. */
  description: string;

  /** An example value for the parameter. */
  example: string;

  /** Whether the customer must provide the parameter. */
  required: boolean;
}

/** An ordered action in a remediation method. */
@added(Versions.v2026_08_12_preview)
model RemediationStep {
  /** The one-based position of the step. */
  @minValue(1)
  number: int32;

  /** The instruction for completing the step. */
  text: string;

  /** The type of action represented by the step. */
  kind: RemediationStepKind;

  /** The command to run for a command step. */
  command?: string;
}

/** A method for applying a remediation. */
@added(Versions.v2026_08_12_preview)
model RemediationMethod {
  /** The display heading for the method. */
  heading: string;

  /** The remediation method identifier. */
  method: string;

  /** The method's relationship to the primary remediation. */
  relation: RemediationMethodRelation;

  /** Whether the method can be executed directly. */
  executable: boolean;

  /** The inputs used by the method. */
  @identifiers(#["name"])
  parameters: RemediationMethodParameter[];

  /** The ordered steps for applying the method. */
  @identifiers(#["number"])
  steps: RemediationStep[];

  /** The command that verifies the remediation result. */
  verification?: string;
}

/** The remediation details for an Advisor recommendation type. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This read-only metadata resource describes remediation content and has no provisioning lifecycle."
@added(Versions.v2026_08_12_preview)
model RemediationProperties {
  /** The recommendation type identifier associated with the remediation. */
  recommendationTypeId: string;

  /** The kind of remediation output. */
  outputType: RemediationOutputType;

  /** Whether applying the remediation can delete or replace customer data. */
  destructive: boolean;

  /** Whether the remediation can be reverted. */
  reversible: boolean;

  /** Whether the remediation is grounded in the target resource's current state. */
  grounded: boolean;

  /** The overall confidence assigned to the remediation. */
  confidence: RemediationConfidence;

  /** The version of the remediation content. */
  @minValue(1)
  version: int32;

  /** The approved inline artifacts available for the remediation. */
  @identifiers(#["artifactType"])
  artifacts: RemediationArtifact[];

  /** The methods available for applying the remediation. */
  @identifiers(#[])
  methods: RemediationMethod[];

  /** Details about partially fulfilled executable artifact filters. */
  filterResult?: RemediationFilterResult;
}

/** The remediation information for an Advisor recommendation type. */
@tenantResource
@added(Versions.v2026_08_12_preview)
model Remediation
  is Azure.ResourceManager.ProxyResource<RemediationProperties> {
  ...ResourceNameParameter<
    Resource = Remediation,
    KeyName = "recommendationTypeId",
    SegmentName = "remediations",
    NamePattern = "[^/]+"
  >;
}

@armResourceOperations
@added(Versions.v2026_08_12_preview)
interface Remediations {
  /** Gets the approved remediation information for a recommendation type. */
  get is ArmResourceRead<
    Remediation,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * An optional OData filter for executable artifacts. The filter supports `artifactType`, the `eq` operator, and `or`, with values `cli`, `powershell`, `bicep`, and `arm`. The `remediationSteps` artifact is always returned. When omitted, all approved executable artifacts are returned. A partially fulfilled filter returns 200 with details in `filterResult`; an entirely invalid filter, unsupported field, or unsupported operator returns `InvalidRequest` through the default error response.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(Remediation.name, "The recommendation type identifier.");
@@doc(
  Remediation.properties,
  "The remediation properties for the recommendation type."
);
