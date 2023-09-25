
import "@typespec/rest";
import "@typespec/http";
import "./main.tsp";
import "../Language/common.tsp";
import "./entity.recognition.tsp";

namespace Language.AnalyzeText;

@doc("Parameters object for a text analysis task using custom models.")
model CustomTaskParameters extends TaskParameters{

  @doc("This field indicates the project name for the model.")
  projectName: string;

  @doc("This field indicates the deployment name for the model.")
  deploymentName: string;
}

model CustomResult {
  @doc("Errors by document id.")
  errors: Array<DocumentError>;

  statistics?: RequestStatistics;

  @doc("This field indicates the project name for the model.")
  projectName: string;

  @doc("This field indicates the deployment name for the model.")
  deploymentName: string;
}

@doc("Supported parameters for a Custom Entities task.")
model CustomEntitiesTaskParameters extends CustomTaskParameters{
  stringIndexType?: StringIndexType;
}

model CustomEntitiesLROTask extends AnalyzeTextLROTask {
  kind: AnalyzeTextLROTaskKind.CustomEntityRecognition;

  parameters?: CustomEntitiesTaskParameters;
}

model CustomEntitesResult extends CustomResult{
  documents: Array<EntitiesDocumentResult>;
}

@doc("Supported parameters for a Custom Single Classification task.")
model CustomSingleLabelClassificationTaskParameters extends CustomTaskParameters{
}

@doc("Use custom models to classify text into single label taxonomy")
model CustomSingleLabelClassificationLROTask extends AnalyzeTextLROTask{
  kind: AnalyzeTextLROTaskKind.CustomSingleLabelClassification;

  parameters?: CustomSingleLabelClassificationTaskParameters
}

model CustomLabelClassificationResult extends CustomResult{
  @doc( "Response by document")
  documents: Array<ClassificationDocumentResult>;
}

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
model CustomMultiLabelClassificationLROTask extends AnalyzeTextLROTask{
  kind: AnalyzeTextLROTaskKind.CustomMultiLabelClassification;

  parameters?: CustomMultiLabelClassificationTaskParameters;
}

model ClassificationDocumentResult extends DocumentResult{
  class: Array<ClassificationResult>


}