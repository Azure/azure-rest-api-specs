import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model LanguageDetectionAnalysisInput {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  documents?: Array<LanguageInput>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextLanguageDetectionInput extends AnalyzeTextTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskKind.LanguageDetection;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  analysisInput?: LanguageDetectionAnalysisInput;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: LanguageDetectionTaskParameters;
}

@doc("Supported parameters for a Language Detection task.")
model LanguageDetectionTaskParameters is PreBuiltTaskParameters;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model LanguageDetectionTaskResult extends AnalyzeTextTaskResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskResultsKind.LanguageDetectionResults;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: LanguageDetectionResult;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model LanguageDetectionResult is PreBuiltResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  documents: Array<LanguageDetectionDocumentResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model LanguageDetectionDocumentResult is DocumentResult {
  @doc("Detected Language.")
  detectedLanguage: DetectedLanguage;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model DetectedLanguage {
  @doc("Long name of a detected language (e.g. English, French).")
  name: string;

  @doc("A two letter representation of the detected language according to the ISO 639-1 standard (e.g. en, fr).")
  iso6391Name: string;

  @doc("A confidence score between 0 and 1. Scores close to 1 indicate 100% certainty that the identified language is true.")
  confidenceScore: float64;

  @added(Versions.v2023_04_15_preview)
  @doc("Identifies the script of the input document.")
  script?: ScriptKind;

  @added(Versions.v2023_11_15_preview)
  @doc("Identifies the script of the input document.")
  scriptCode?: ScriptCode;
}

@added(Versions.v2023_04_15_preview)
@doc("Identifies the script of the input document. Maps to the ISO 15924 standard formal name.")
enum ScriptKind {
  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Arabic script.")
  Arabic,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Armenian script.")
  Armenian,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Bangla script.")
  Bangla,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the UnifiedCanadianAboriginalSyllabics script.")
  UnifiedCanadianAboriginalSyllabics,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Cyrillic script.")
  Cyrillic,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Devanagari script.")
  Devanagari,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Ethiopic script.")
  Ethiopic,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Georgian script.")
  Georgian,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Greek script.")
  Greek,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Gujarati script.")
  Gujarati,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Gurmukhi script.")
  Gurmukhi,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Hangul script.")
  Hangul,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the HanSimplified script.")
  HanSimplified,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the HanTraditional script.")
  HanTraditional,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Hebrew script.")
  Hebrew,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Japanese script.")
  Japanese,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Khmer script.")
  Khmer,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Kannada script.")
  Kannada,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Lao script.")
  Lao,

  @added(Versions.v2023_04_15_preview)
  @doc("Script name for the Latin script.")
  Latin,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Malayalam script.")
  Malayalam,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Myanmar script.")
  Myanmar,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Odia script.")
  Odia,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Sinhala script.")
  Sinhala,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Tamil script.")
  Tamil,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Telugu script.")
  Telugu,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Thaana script.")
  Thaana,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Thai script.")
  Thai,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Tibetan script.")
  Tibetan,
}

@added(Versions.v2023_11_15_preview)
@doc("Identifies the script of the input document. Maps to the ISO 15924 standard script code.")
enum ScriptCode {
  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Arabic script.")
  Arab,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Armenian script.")
  Armn,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Bangla script.")
  Beng,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the UnifiedCanadianAboriginalSyllabics script.")
  Cans,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Cyrillic script.")
  Cyrl,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Devanagari script.")
  Deva,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Ethiopic script.")
  Ethi,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Georgian script.")
  Geor,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Greek script.")
  Grek,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Gujarati script.")
  Gujr,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Gurmukhi script.")
  Guru,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Hangul script.")
  Hang,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the HanSimplified script.")
  Hans,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the HanTraditional script.")
  Hant,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Hebrew script.")
  Hebr,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Japanese script.")
  Jpan,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Khmer script.")
  Khmr,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Kannada script.")
  Knda,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Lao script.")
  Laoo,

  @added(Versions.v2023_04_15_preview)
  @doc("Script code for the Latin script.")
  Latn,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Malayalam script.")
  Mlym,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Myanmar script.")
  Mymr,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Odia script.")
  Orya,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Sinhala script.")
  Sinh,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Tamil script.")
  Taml,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Telugu script.")
  Telu,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Thaana script.")
  Thaa,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Thai script.")
  Thai,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Tibetan script.")
  Tibt,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model LanguageInput {
  @doc("A unique, non-empty document identifier.")
  id: string;

  @doc("The input text to process.")
  text: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  countryHint?: string;
}
