import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;

/** Contains the language detection document analysis input. */
model LanguageDetectionAnalysisInput {
  /** List of documents to be analyzed. */
  documents?: Array<LanguageInput>;
}

/** Contains the language detection document analysis task input. */
model AnalyzeTextLanguageDetectionInput extends AnalyzeTextTask {
  /** Kind of the task. */
  kind: AnalyzeTextTaskKind.LanguageDetection;

  /** Documents to be analyzed. */
  analysisInput?: LanguageDetectionAnalysisInput;

  /** task parameters. */
  parameters?: LanguageDetectionTaskParameters;
}

/** Supported parameters for a Language Detection task. */
model LanguageDetectionTaskParameters is PreBuiltTaskParameters;

/** Contains the language detection task result for the request. */
model LanguageDetectionTaskResult extends AnalyzeTextTaskResult {
  /** Kind of the task result. */
  kind: AnalyzeTextTaskResultsKind.LanguageDetectionResults;

  /** Contains the language detection results. */
  results: LanguageDetectionResult;
}

/** Contains the language detection result for the request. */
model LanguageDetectionResult is PreBuiltResult {
  /** Enumeration of language detection results for each input document. */
  documents: Array<LanguageDetectionDocumentResult>;
}

/** Contains the language detection for a document. */
model LanguageDetectionDocumentResult is DocumentResult {
  /** Detected Language. */
  detectedLanguage: DetectedLanguage;
}

/** Contains the details of the detected language for the text. */
model DetectedLanguage {
  /** Long name of a detected language (e.g. English, French). */
  name: string;

  /** A two letter representation of the detected language according to the ISO 639-1 standard (e.g. en, fr). */
  iso6391Name: string;

  /** A confidence score between 0 and 1. Scores close to 1 indicate 100% certainty that the identified language is true. */
  confidenceScore: float64;

  /** Identifies the script of the input document. */
  @added(Versions.v2023_11_15_preview)
  script?: ScriptKind;

  /** Identifies the script of the input document. */
  @added(Versions.v2023_11_15_preview)
  scriptCode?: ScriptCode;
}

/** Identifies the script of the input document. Maps to the ISO 15924 standard formal name. */
@added(Versions.v2023_11_15_preview)
union ScriptKind {
  string,

  /** Script name for the Arabic script. */
  @added(Versions.v2023_11_15_preview)
  Arabic: "Arabic",

  /** Script name for the Armenian script. */
  @added(Versions.v2023_11_15_preview)
  Armenian: "Armenian",

  /** Script name for the Bangla script. */
  @added(Versions.v2023_11_15_preview)
  Bangla: "Bangla",

  /** Script name for the UnifiedCanadianAboriginalSyllabics script. */
  @added(Versions.v2023_11_15_preview)
  UnifiedCanadianAboriginalSyllabics: "UnifiedCanadianAboriginalSyllabics",

  /** Script name for the Cyrillic script. */
  @added(Versions.v2023_11_15_preview)
  Cyrillic: "Cyrillic",

  /** Script name for the Devanagari script. */
  @added(Versions.v2023_11_15_preview)
  Devanagari: "Devanagari",

  /** Script name for the Ethiopic script. */
  @added(Versions.v2023_11_15_preview)
  Ethiopic: "Ethiopic",

  /** Script name for the Georgian script. */
  @added(Versions.v2023_11_15_preview)
  Georgian: "Georgian",

  /** Script name for the Greek script. */
  @added(Versions.v2023_11_15_preview)
  Greek: "Greek",

  /** Script name for the Gujarati script. */
  @added(Versions.v2023_11_15_preview)
  Gujarati: "Gujarati",

  /** Script name for the Gurmukhi script. */
  @added(Versions.v2023_11_15_preview)
  Gurmukhi: "Gurmukhi",

  /** Script name for the Hangul script. */
  @added(Versions.v2023_11_15_preview)
  Hangul: "Hangul",

  /** Script name for the HanSimplified script. */
  @added(Versions.v2023_11_15_preview)
  HanSimplified: "HanSimplified",

  /** Script name for the HanTraditional script. */
  @added(Versions.v2023_11_15_preview)
  HanTraditional: "HanTraditional",

  /** Script name for the Hebrew script. */
  @added(Versions.v2023_11_15_preview)
  Hebrew: "Hebrew",

  /** Script name for the Japanese script. */
  @added(Versions.v2023_11_15_preview)
  Japanese: "Japanese",

  /** Script name for the Khmer script. */
  @added(Versions.v2023_11_15_preview)
  Khmer: "Khmer",

  /** Script name for the Kannada script. */
  @added(Versions.v2023_11_15_preview)
  Kannada: "Kannada",

  /** Script name for the Lao script. */
  @added(Versions.v2023_11_15_preview)
  Lao: "Lao",

  /** Script name for the Latin script. */
  @added(Versions.v2023_11_15_preview)
  Latin: "Latin",

  /** Script name for the Malayalam script. */
  @added(Versions.v2023_11_15_preview)
  Malayalam: "Malayalam",

  /** Script name for the Myanmar script. */
  @added(Versions.v2023_11_15_preview)
  Myanmar: "Myanmar",

  /** Script name for the Odia script. */
  @added(Versions.v2023_11_15_preview)
  Odia: "Odia",

  /** Script name for the Sinhala script. */
  @added(Versions.v2023_11_15_preview)
  Sinhala: "Sinhala",

  /** Script name for the Tamil script. */
  @added(Versions.v2023_11_15_preview)
  Tamil: "Tamil",

  /** Script name for the Telugu script. */
  @added(Versions.v2023_11_15_preview)
  Telugu: "Telugu",

  /** Script name for the Thaana script. */
  @added(Versions.v2023_11_15_preview)
  Thaana: "Thaana",

  /** Script name for the Thai script. */
  @added(Versions.v2023_11_15_preview)
  Thai: "Thai",

  /** Script name for the Tibetan script. */
  @added(Versions.v2023_11_15_preview)
  Tibetan: "Tibetan",
}

/** Identifies the script of the input document. Maps to the ISO 15924 standard script code. */
@added(Versions.v2023_11_15_preview)
union ScriptCode {
  string,

  /** Script code for the Arabic script. */
  @added(Versions.v2023_11_15_preview)
  Arab: "Arab",

  /** Script code for the Armenian script. */
  @added(Versions.v2023_11_15_preview)
  Armn: "Armn",

  /** Script code for the Bangla script. */
  @added(Versions.v2023_11_15_preview)
  Beng: "Beng",

  /** Script code for the UnifiedCanadianAboriginalSyllabics script. */
  @added(Versions.v2023_11_15_preview)
  Cans: "Cans",

  /** Script code for the Cyrillic script. */
  @added(Versions.v2023_11_15_preview)
  Cyrl: "Cyrl",

  /** Script code for the Devanagari script. */
  @added(Versions.v2023_11_15_preview)
  Deva: "Deva",

  /** Script code for the Ethiopic script. */
  @added(Versions.v2023_11_15_preview)
  Ethi: "Ethi",

  /** Script code for the Georgian script. */
  @added(Versions.v2023_11_15_preview)
  Geor: "Geor",

  /** Script code for the Greek script. */
  @added(Versions.v2023_11_15_preview)
  Grek: "Grek",

  /** Script code for the Gujarati script. */
  @added(Versions.v2023_11_15_preview)
  Gujr: "Gujr",

  /** Script code for the Gurmukhi script. */
  @added(Versions.v2023_11_15_preview)
  Guru: "Guru",

  /** Script code for the Hangul script. */
  @added(Versions.v2023_11_15_preview)
  Hang: "Hang",

  /** Script code for the HanSimplified script. */
  @added(Versions.v2023_11_15_preview)
  Hans: "Hans",

  /** Script code for the HanTraditional script. */
  @added(Versions.v2023_11_15_preview)
  Hant: "Hant",

  /** Script code for the Hebrew script. */
  @added(Versions.v2023_11_15_preview)
  Hebr: "Hebr",

  /** Script code for the Japanese script. */
  @added(Versions.v2023_11_15_preview)
  Jpan: "Jpan",

  /** Script code for the Khmer script. */
  @added(Versions.v2023_11_15_preview)
  Khmr: "Khmr",

  /** Script code for the Kannada script. */
  @added(Versions.v2023_11_15_preview)
  Knda: "Knda",

  /** Script code for the Lao script. */
  @added(Versions.v2023_11_15_preview)
  Laoo: "Laoo",

  /** Script code for the Latin script. */
  @added(Versions.v2023_11_15_preview)
  Latn: "Latn",

  /** Script code for the Malayalam script. */
  @added(Versions.v2023_11_15_preview)
  Mlym: "Mlym",

  /** Script code for the Myanmar script. */
  @added(Versions.v2023_11_15_preview)
  Mymr: "Mymr",

  /** Script code for the Odia script. */
  @added(Versions.v2023_11_15_preview)
  Orya: "Orya",

  /** Script code for the Sinhala script. */
  @added(Versions.v2023_11_15_preview)
  Sinh: "Sinh",

  /** Script code for the Tamil script. */
  @added(Versions.v2023_11_15_preview)
  Taml: "Taml",

  /** Script code for the Telugu script. */
  @added(Versions.v2023_11_15_preview)
  Telu: "Telu",

  /** Script code for the Thaana script. */
  @added(Versions.v2023_11_15_preview)
  Thaa: "Thaa",

  /** Script code for the Thai script. */
  @added(Versions.v2023_11_15_preview)
  Thai: "Thai",

  /** Script code for the Tibetan script. */
  @added(Versions.v2023_11_15_preview)
  Tibt: "Tibt",
}

/** Contains the language detection input. */
model LanguageInput {
  /** A unique, non-empty document identifier. */
  id: string;

  /** The input text to process. */
  text: string;

  /** The country hint to help with language detection of the text. */
  countryHint?: string;
}
