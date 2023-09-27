
import "@typespec/rest";
import "@typespec/http";
import "../common.tsp";
import "./common.models.tsp";

namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextEntityRecognitionInput extends AnalyzeTextTask{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskKind.EntityRecognition;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  analysisInput?: MultiLanguageAnalysisInput;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: EntitiesTaskParameters;
}

@doc("Supported parameters for an Entity Recognition task.")
model EntitiesTaskParameters extends PreBuiltTaskParameters{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
 stringIndexType: StringIndexType;
}

@doc("An object representing the task definition for an Entities Recognition task.")
model EntitiesLroTask extends AnalyzeTextLroTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroTaskKind.EntityRecognition;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: EntitiesTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntitiesTaskResult extends AnalyzeTextTaskResult{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskResultsKind.EntityRecognitionResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: Array<EntitiesResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntitiesResult extends AnalyzeTextPreBuiltResult {
  @doc("Response by document")
  documents: Array<EntitiesDocumentResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntitiesDocumentResult extends DocumentResult {
  @doc("Recognized entities in the document.")
  entities: Array<Entity>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model Entity {
  @doc("Entity text as appears in the request.")
  text: string;

  @doc("Entity type.")
  category: string;

  @doc("(Optional) Entity sub type.")
  subcategory?: string;

  @doc("Start position for the entity text. Use of different 'stringIndexType' values can affect the offset returned.")
  offset: int32;

  @doc("Length for the entity text. Use of different 'stringIndexType' values can affect the length returned.")
  length: int32;

  @doc("Confidence score between 0 and 1 of the extracted entity.")
  confidenceScore: float64;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntityRecognitionLroResult extends AnalyzeTextLroResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroResultsKind.EntityRecognitionLroResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: EntitiesResult;
}