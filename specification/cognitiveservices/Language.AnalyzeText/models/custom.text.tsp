
import "@typespec/rest";
import "@typespec/http";
import "../main.tsp";
import "../../Language/common.models.tsp";
import "./entity.recognition.tsp";

namespace Language.AnalyzeText;

@doc("Parameters object for a text analysis task using custom models.")
model CustomTaskParameters extends TaskParameters{

  @doc("This field indicates the project name for the model.")
  projectName: string;

  @doc("This field indicates the deployment name for the model.")
  deploymentName: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomResult {
  @doc("Errors by document id.")
  errors: Array<DocumentError>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  statistics?: RequestStatistics;

  @doc("This field indicates the project name for the model.")
  projectName: string;

  @doc("This field indicates the deployment name for the model.")
  deploymentName: string;
}

@doc("Supported parameters for a Custom Entities task.")
model CustomEntitiesTaskParameters extends CustomTaskParameters{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType?: StringIndexType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomEntitiesLroTask extends AnalyzeTextLroTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroTaskKind.CustomEntityRecognition;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: CustomEntitiesTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomEntitiesResult extends CustomResult{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  documents: Array<EntitiesDocumentResult>;
}

@doc("Supported parameters for a Custom Single Classification task.")
model CustomSingleLabelClassificationTaskParameters extends CustomTaskParameters{
}

@doc("Use custom models to classify text into single label taxonomy")
model CustomSingleLabelClassificationLroTask extends AnalyzeTextLroTask{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroTaskKind.CustomSingleLabelClassification;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: CustomSingleLabelClassificationTaskParameters
}
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomLabelClassificationResult extends CustomResult{
  @doc( "Response by document")
  documents: Array<ClassificationDocumentResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ClassificationResult {
  @doc("Classification type.")
  category: string;

  @doc("Confidence score between 0 and 1 of the recognized class.")
  confidenceScore: float64;
}

@doc("Supported parameters for a Custom Multi Classification task.")
model CustomMultiLabelClassificationTaskParameters extends CustomTaskParameters{
}

@doc("Use custom models to classify text into multi label taxonomy",)
model CustomMultiLabelClassificationLroTask extends AnalyzeTextLroTask{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroTaskKind.CustomMultiLabelClassification;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: CustomMultiLabelClassificationTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ClassificationDocumentResult extends DocumentResult{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  class: Array<ClassificationResult>
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomEntityRecognitionLroResult extends AnalyzeTextLroResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroResultsKind.CustomEntityRecognitionLroResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: CustomEntitiesResult;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomSingleLabelClassificationLroResult extends AnalyzeTextLroResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroResultsKind.CustomSingleLabelClassificationLroResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: CustomLabelClassificationResult;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model CustomMultiLabelClassificationLroResult extends AnalyzeTextLroResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroResultsKind.CustomMultiLabelClassificationLroResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: CustomLabelClassificationResult;
}