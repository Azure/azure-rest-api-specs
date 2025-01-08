import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.Text;

@doc("Contains the analyze text KeyPhraseExtraction task input.")
model AnalyzeTextKeyPhraseExtractionInput extends AnalyzeTextTask {
  @doc("Kind of the task.")
  kind: AnalyzeTextTaskKind.KeyPhraseExtraction;

  @doc("Contains the input documents.")
  analysisInput?: MultiLanguageAnalysisInput;

  @doc("Key phrase extraction task parameters.")
  parameters?: KeyPhraseTaskParameters;
}

@doc("Supported parameters for a Key Phrase Extraction task.")
model KeyPhraseTaskParameters is PreBuiltTaskParameters;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("An object representing the task definition for a Key Phrase Extraction task.")
model KeyPhraseLROTask extends AnalyzeTextLROTask {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROTaskKind.KeyPhraseExtraction;

  @doc("Key phrase extraction task parameters.")
  parameters?: KeyPhraseTaskParameters;
}

@doc("Contains the analyze text KeyPhraseExtraction task result.")
model KeyPhraseTaskResult extends AnalyzeTextTaskResult {
  @doc("Kind of the task results.")
  kind: AnalyzeTextTaskResultsKind.KeyPhraseExtractionResults;

  @doc("The list of Key phrase extraction results")
  results: KeyPhraseResult;
}

@doc("Contains the KeyPhraseResult.")
model KeyPhraseResult is PreBuiltResult {
  @doc("Response by document")
  @typeChangedFrom(
    Versions.v2024_11_15_preview,
    Array<KeyPhrasesDocumentResult>
  )
  documents: Array<KeyPhrasesDocumentResultWithDetectedLanguage>;
}

@doc("Contains the Key phrase extraction results for a document.")
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

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the analyze text KeyPhraseExtraction LRO task.")
model KeyPhraseExtractionLROResult extends AnalyzeTextLROResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind.KeyPhraseExtractionLROResults;

  @doc("The list of Key phrase extraction results")
  results: KeyPhraseResult;
}
