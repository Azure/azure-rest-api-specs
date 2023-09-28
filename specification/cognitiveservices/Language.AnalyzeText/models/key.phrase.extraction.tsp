
import "@typespec/rest";
import "@typespec/http";

namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextKeyPhraseExtractionInput extends AnalyzeTextTask{
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskKind.KeyPhraseExtraction;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  analysisInput?: MultiLanguageAnalysisInput;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: KeyPhraseTaskParameters;
}

@doc("Supported parameters for a Key Phrase Extraction task.")
model KeyPhraseTaskParameters extends PreBuiltTaskParameters {}

@doc("An object representing the task definition for a Key Phrase Extraction task.")
model KeyPhraseLroTask extends AnalyzeTextLroTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroTaskKind.KeyPhraseExtraction;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: KeyPhraseTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model KeyPhraseTaskResult extends AnalyzeTextTaskResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskResultsKind.KeyPhraseExtractionResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: KeyPhraseResult;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model KeyPhraseResult extends AnalyzeTextPreBuiltResult{
  @doc("Response by document")
  documents: Array<KeyPhrasesDocumentResult>
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model KeyPhrasesDocumentResult extends DocumentResult {
  @doc("A list of representative words or phrases. The number of key phrases returned is proportional to the number of words in the input document.")
  keyPhrases: Array<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model KeyPhraseExtractionLroResult extends AnalyzeTextLroResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLroResultsKind.KeyPhraseExtractionLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: KeyPhraseResult;
}