import "./model.common.shared.tsp";

using TypeSpec.Rest;

namespace AzureHealthInsights;

alias Response = {
  #suppress "@azure-tools/typespec-azure-core/no-format" "This is an old spec"
  @doc("A processing job identifier.")
  @visibility("read")
  @key
  jobId: Azure.Core.uuid;

  @doc("The date and time when the processing job was created.")
  @visibility("read")
  createdDateTime: utcDateTime;

  @doc("The date and time when the processing job is set to expire.")
  @visibility("read")
  expirationDateTime: utcDateTime;

  @doc("The date and time when the processing job was last updated.")
  @visibility("read")
  lastUpdateDateTime: utcDateTime;

  @doc("The status of the processing job.")
  @visibility("read")
  status: JobStatus;

  @doc("An array of errors, if any errors occurred during the processing job.")
  @visibility("read")
  errors?: Azure.Core.Foundations.Error[];
};

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

@doc("A piece of evidence corresponding to a Trial Matcher inference.")
model TrialMatcherInferenceEvidence {
  @doc("A piece of evidence from the eligibility criteria text of a clinical trial.")
  eligibilityCriteriaEvidence?: string;

  ...InferenceEvidence;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next version"
@doc("The status of the processing job.")
enum JobStatus {
  NotStarted: "notStarted",
  Running: "running",
  Succeeded: "succeeded",
  Failed: "failed",
  PartiallyCompleted: "partiallyCompleted",
}

@doc("The version of the model used for inference, expressed as the model date.")
scalar ModelVersion extends string;
