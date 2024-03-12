import "./model.common.shared.tsp";

using Azure.Core;
using TypeSpec.Rest;

namespace AzureHealthInsights;

/**
 * Provides status details for long running operations.
 * @template TStatusResult The type of the operation status result.
 * @template TStatusError The type of the operation status error. If not provided, the default error is used.
 */
@doc("Provides status details for long running operations.")
model HealthInsightsOperationStatus<
  TStatusResult = never,
  TStatusError = Foundations.Error
> {
  @key("operationId")
  @doc("The unique ID of the operation.")
  @visibility("read")
  id: Azure.Core.uuid;

  @doc("The status of the operation")
  @visibility("read")
  @lroStatus
  status: JobStatus;

  @doc("The date and time when the processing job was created.")
  @visibility("read")
  createdDateTime?: utcDateTime;

  @doc("The date and time when the processing job is set to expire.")
  @visibility("read")
  expirationDateTime?: utcDateTime;

  @doc("The date and time when the processing job was last updated.")
  @visibility("read")
  lastUpdateDateTime?: utcDateTime;

  @doc("Error object that describes the error when status is \"Failed\".")
  error?: TStatusError;

  @doc("The result of the operation.")
  @lroResult
  result?: TStatusResult;
}
////////////////// Inference //////////////////
@doc("An inference made by the model regarding a patient.")
model Inference {
  @doc("The value of the inference, as relevant for the given inference type.")
  value: string;

  @doc("The description corresponding to the inference value.")
  description?: string;

  @doc("Confidence score for this inference.")
  @minValue(0)
  @maxValue(1)
  confidenceScore?: float32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next version"
@doc("The status of the processing job.")
@lroStatus
union JobStatus {
  string,
  NotStarted: "notStarted",
  Running: "running",

  @lroSucceeded
  Succeeded: "succeeded",

  @lroFailed
  Failed: "failed",

  Canceled: "canceled",
}

@doc("The version of the model used for inference, expressed as the model date.")
scalar ModelVersion extends string;

@doc("A piece of evidence from a clinical note (text document).")
model ClinicalNoteEvidence {
  @doc("The identifier of the document containing the evidence.")
  id: string;

  @doc("The actual text span which is evidence for the inference.")
  text?: string;

  @doc("The start index of the evidence text span in the document (0 based).")
  @minValue(0)
  offset: int32;

  @doc("The length of the evidence text span.")
  @minValue(1)
  length: int32;
}

@doc("A piece of evidence corresponding to an inference.")
model InferenceEvidence {
  @doc("A piece of evidence from a clinical note (text document).")
  patientDataEvidence?: ClinicalNoteEvidence;

  @doc("""
A piece of clinical information, expressed as a code in a clinical coding
system.
""")
  patientInfoEvidence?: ClinicalCodedElement;

  @doc("A value indicating how important this piece of evidence is for the inference.")
  @minValue(0)
  @maxValue(1)
  importance?: float32;
}
