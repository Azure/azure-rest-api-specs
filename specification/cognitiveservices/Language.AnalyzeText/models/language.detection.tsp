
import "@typespec/rest";
import "@typespec/http";


namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model LanguageDetectionAnalysisInput {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  documents?: Array<LanguageInput>
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextLanguageDetectionInput {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskKind.LanguageDetection;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  analysisInput?: LanguageDetectionAnalysisInput;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: LanguageDetectionTaskParameters;
}

@doc("Supported parameters for a Language Detection task.")
model LanguageDetectionTaskParameters extends PreBuiltTaskParameters {}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model LanguageDetectionTaskResult extends AnalyzeTextTaskResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskResultsKind.LanguageDetectionResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: LanguageDetectionResult;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model LanguageDetectionResult extends AnalyzeTextPreBuiltResult{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  documents?: Array<LanguageDetectionDocumentResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model LanguageDetectionDocumentResult extends DocumentResult {
  @doc("Detected Language.")
  detectedLanguage: DetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model DetectedLanguage {
  @doc("Long name of a detected language (e.g. English, French).")
  name: string;

  @doc("A two letter representation of the detected language according to the ISO 639-1 standard (e.g. en, fr).")
  iso6391Name: string;

  @doc("A confidence score between 0 and 1. Scores close to 1 indicate 100% certainty that the identified language is true.")
  confidenceScore: float64;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model LanguageInput {
  @doc("A unique, non-empty document identifier.")
  id: string;

  @doc("The input text to process.")
  text: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  countryHint?: string;
}