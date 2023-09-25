import "../HealthInsights.Common/model.common.request.tsp";
import "../HealthInsights.Common/model.common.response.tsp";
import "../HealthInsights.Common/model.common.shared.tsp";

using TypeSpec.Rest;

namespace AzureHealthInsights;

@doc("The body of the Onco Phenotype request.")
model OncoPhenotypeData {
  ...Request;

  @doc("Configuration affecting the Onco Phenotype model's inference.")
  configuration?: OncoPhenotypeModelConfiguration;
}

@resource("oncophenotype/jobs")
@doc("The response for the Onco Phenotype request.")
model OncoPhenotypeResult {
  ...Response;

  @doc("The inference results for the Onco Phenotype request.")
  @visibility("read")
  results?: OncoPhenotypeResults;
}

@doc("The inference results for the Onco Phenotype request.")
model OncoPhenotypeResults {
  @doc("Results for the patients given in the request.")
  patients: OncoPhenotypePatientResult[];

  @doc("The version of the model used for inference, expressed as the model date.")
  modelVersion: ModelVersion;
}

@doc("The results of the model's work for a single patient.")
model OncoPhenotypePatientResult {
  @doc("The identifier given for the patient in the request.")
  id: string;

  @doc("The model's inferences for the given patient.")
  inferences: OncoPhenotypeInference[];
}

@doc("An inference made by the Onco Phenotype model regarding a patient.")
model OncoPhenotypeInference {
  @doc("The type of the Onco Phenotype inference")
  type: OncoPhenotypeInferenceType;

  ...Inference;

  @doc("The evidence corresponding to the inference value.")
  evidence?: InferenceEvidence[];

  @doc("""
An identifier for a clinical case, if there are multiple clinical cases regarding the same patient.
""")
  caseId?: string;
}

@doc("Configuration affecting the Onco Phenotype model's inference.")
model OncoPhenotypeModelConfiguration {
  ...ModelConfiguration;

  @doc("""
A list of inference types to be inferred for the current request.
This could be used if only part of the Onco Phenotype inferences are required.
If this list is omitted or empty, the model will return all the inference types.
""")
  inferenceTypes?: OncoPhenotypeInferenceType[];

  @doc("""
An indication whether to perform a preliminary step on the patient's documents to determine whether they relate to a Cancer case.
""")
  checkForCancerCase?: boolean = false;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("The type of the Onco Phenotype inference.")
enum OncoPhenotypeInferenceType {
  TumorSite: "tumorSite",
  Histology: "histology",
  ClinicalStageT: "clinicalStageT",
  ClinicalStageN: "clinicalStageN",
  ClinicalStageM: "clinicalStageM",
  PathologicStageT: "pathologicStageT",
  PathologicStageN: "pathologicStageN",
  PathologicStageM: "pathologicStageM",
}
