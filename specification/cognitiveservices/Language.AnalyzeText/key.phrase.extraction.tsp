
import "@typespec/rest";
import "@typespec/http";
import "./main.tsp";
import "../Language/common.tsp";

namespace Language.AnalyzeText;

model AnalyzeTextKeyPhraseExtractionInput extends AnalyzeTextTask{
    kind: AnalyzeTextTaskKind.KeyPhraseExtraction;

    analysisInput?: MultiLanguageAnalysisInput;

    parameters?: KeyPhraseTaskParameters;
}