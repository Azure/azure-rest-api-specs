import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextKeyPhraseExtractionInput extends AnalyzeTextTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskKind.KeyPhraseExtraction;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  analysisInput?: MultiLanguageAnalysisInput;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: KeyPhraseTaskParameters;
}

@clientName("KeyPhraseTaskContent", "csharp")
@doc("Supported parameters for a Key Phrase Extraction task.")
model KeyPhraseTaskParameters is PreBuiltTaskParameters;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("An object representing the task definition for a Key Phrase Extraction task.")
model KeyPhraseLROTask extends AnalyzeTextLROTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROTaskKind.KeyPhraseExtraction;
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
model KeyPhraseResult is PreBuiltResult {
  @doc("Response by document")
  @typeChangedFrom(
    Versions.v2023_04_15_preview,
    Array<KeyPhrasesDocumentResult>
  )
  documents: Array<KeyPhrasesDocumentResultWithDetectedLanguage>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model KeyPhrasesDocumentResult is DocumentResult {
  @doc("A list of representative words or phrases. The number of key phrases returned is proportional to the number of words in the input document.")
  keyPhrases: Array<string>;
}

@added(Versions.v2023_04_01)
@doc("A ranked list of sentences representing the extracted summary.")
model KeyPhrasesDocumentResultWithDetectedLanguage {
  ...KeyPhrasesDocumentResult;
  ...DocumentDetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
model KeyPhraseExtractionLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.KeyPhraseExtractionLROResults;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: KeyPhraseResult;
}
