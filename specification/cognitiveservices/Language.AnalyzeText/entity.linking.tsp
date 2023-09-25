
import "@typespec/rest";
import "@typespec/http";
import "./main.tsp";
import "../Language/common.tsp";

namespace Language.AnalyzeText;

model AnalyzeTextEntityLinkingInput extends AnalyzeTextTask{
  kind: AnalyzeTextTaskKind.EntityLinking;

  analysisInput?: MultiLanguageAnalysisInput;

  parameters?: EntityLinkingTaskParameters;
}
