
import "@typespec/rest";
import "@typespec/http";
import "./main.tsp";
import "../Language/common.tsp";

namespace Language.AnalyzeText;

model LanguageDetectionAnalysisInput {
  documents?: Array<LanguageInput>
}

model AnalyzeTextLanguageDetectionInput {
  kind: AnalyzeTextTaskKind.LanguageDetection;

  analysisInput?: LanguageDetectionAnalysisInput;

  parameters?: LanguageDetectionTaskParameters;
}