
import "@typespec/rest";
import "@typespec/http";
import "./main.tsp";
import "../Language/common.tsp";

namespace Language.AnalyzeText;

model AnalyzeTextEntityRecognitionInput extends AnalyzeTextTask{
    kind: AnalyzeTextTaskKind.EntityRecognition;

    analysisInput?: MultiLanguageAnalysisInput;

    parameters?: EntitiesTaskParameters;
}

model AnalyzeTextPiiEntitiesRecognitionInput {
    kind: AnalyzeTextTaskKind.PiiEntitiesRecognition;

    analysisInput?: MultiLanguageAnalysisInput;

    parameters?: PiiEntitiesTaskParameters;
}