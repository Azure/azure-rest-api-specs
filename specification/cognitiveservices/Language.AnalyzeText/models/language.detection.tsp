import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;

@doc("Contains the language detection document analysis input.")
model LanguageDetectionAnalysisInput {
  @doc("List of documents to be analyzed.")
  documents?: Array<LanguageInput>;
}

@doc("Contains the language detection document analysis task input.")
model AnalyzeTextLanguageDetectionInput extends AnalyzeTextTask {
  @doc("Kind of the task.")
  kind: AnalyzeTextTaskKind.LanguageDetection;

  @doc("Documents to be analyzed.")
  analysisInput?: LanguageDetectionAnalysisInput;

  @doc("task parameters.")
  parameters?: LanguageDetectionTaskParameters;
}

@clientName("LanguageDetectionTaskContent", "csharp")
@doc("Supported parameters for a Language Detection task.")
model LanguageDetectionTaskParameters is PreBuiltTaskParameters;

@doc("Contains the language detection task result for the request.")
model LanguageDetectionTaskResult extends AnalyzeTextTaskResult {
  @doc("Kind of the task result.")
  kind: AnalyzeTextTaskResultsKind.LanguageDetectionResults;

  @doc("Contains the language detection results.")
  results: LanguageDetectionResult;
}

@doc("Contains the language detection result for the request.")
model LanguageDetectionResult is PreBuiltResult {
  @doc("Enumeration of language detection results for each input document.")
  documents: Array<LanguageDetectionDocumentResult>;
}

@doc("Contains the language detection for a document.")
model LanguageDetectionDocumentResult is DocumentResult {
  @doc("Detected Language.")
  detectedLanguage: DetectedLanguage;
}

@doc("Contains the details of the detected language for the text.")
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
union ScriptKind {
  string,

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Arabic script.")
  Arabic: "Arabic",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Armenian script.")
  Armenian: "Armenian",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Bangla script.")
  Bangla: "Bangla",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the UnifiedCanadianAboriginalSyllabics script.")
  UnifiedCanadianAboriginalSyllabics: "UnifiedCanadianAboriginalSyllabics",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Cyrillic script.")
  Cyrillic: "Cyrillic",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Devanagari script.")
  Devanagari: "Devanagari",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Ethiopic script.")
  Ethiopic: "Ethiopic",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Georgian script.")
  Georgian: "Georgian",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Greek script.")
  Greek: "Greek",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Gujarati script.")
  Gujarati: "Gujarati",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Gurmukhi script.")
  Gurmukhi: "Gurmukhi",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Hangul script.")
  Hangul: "Hangul",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the HanSimplified script.")
  HanSimplified: "HanSimplified",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the HanTraditional script.")
  HanTraditional: "HanTraditional",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Hebrew script.")
  Hebrew: "Hebrew",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Japanese script.")
  Japanese: "Japanese",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Khmer script.")
  Khmer: "Khmer",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Kannada script.")
  Kannada: "Kannada",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Lao script.")
  Lao: "Lao",

  @added(Versions.v2023_04_15_preview)
  @doc("Script name for the Latin script.")
  Latin: "Latin",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Malayalam script.")
  Malayalam: "Malayalam",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Myanmar script.")
  Myanmar: "Myanmar",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Odia script.")
  Odia: "Odia",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Sinhala script.")
  Sinhala: "Sinhala",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Tamil script.")
  Tamil: "Tamil",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Telugu script.")
  Telugu: "Telugu",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Thaana script.")
  Thaana: "Thaana",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Thai script.")
  Thai: "Thai",

  @added(Versions.v2023_11_15_preview)
  @doc("Script name for the Tibetan script.")
  Tibetan: "Tibetan",
}

@added(Versions.v2023_11_15_preview)
@doc("Identifies the script of the input document. Maps to the ISO 15924 standard script code.")
union ScriptCode {
  string,

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Arabic script.")
  Arab: "Arab",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Armenian script.")
  Armn: "Armn",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Bangla script.")
  Beng: "Beng",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the UnifiedCanadianAboriginalSyllabics script.")
  Cans: "Cans",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Cyrillic script.")
  Cyrl: "Cyrl",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Devanagari script.")
  Deva: "Deva",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Ethiopic script.")
  Ethi: "Ethi",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Georgian script.")
  Geor: "Geor",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Greek script.")
  Grek: "Grek",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Gujarati script.")
  Gujr: "Gujr",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Gurmukhi script.")
  Guru: "Guru",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Hangul script.")
  Hang: "Hang",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the HanSimplified script.")
  Hans: "Hans",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the HanTraditional script.")
  Hant: "Hant",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Hebrew script.")
  Hebr: "Hebr",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Japanese script.")
  Jpan: "Jpan",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Khmer script.")
  Khmr: "Khmr",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Kannada script.")
  Knda: "Knda",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Lao script.")
  Laoo: "Laoo",

  @added(Versions.v2023_04_15_preview)
  @doc("Script code for the Latin script.")
  Latn: "Latn",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Malayalam script.")
  Mlym: "Mlym",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Myanmar script.")
  Mymr: "Mymr",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Odia script.")
  Orya: "Orya",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Sinhala script.")
  Sinh: "Sinh",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Tamil script.")
  Taml: "Taml",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Telugu script.")
  Telu: "Telu",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Thaana script.")
  Thaa: "Thaa",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Thai script.")
  Thai: "Thai",

  @added(Versions.v2023_11_15_preview)
  @doc("Script code for the Tibetan script.")
  Tibt: "Tibt",
}

@doc("Contains the language detection input.")
model LanguageInput {
  @doc("A unique, non-empty document identifier.")
  id: string;

  @doc("The input text to process.")
  text: string;

  @doc("The country hint to help with language detection of the text.")
  countryHint?: string;
}
