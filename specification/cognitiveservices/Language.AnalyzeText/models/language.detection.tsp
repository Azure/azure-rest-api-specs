import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.Text;

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

  /** Identifies the script name of the input document according to the ISO 15924 standard. */
  @added(Versions.v2024_11_01)
  scriptName?: ScriptKind;

  /** Identifies the script code of the input document according to the ISO 15924 standard. */
  @added(Versions.v2024_11_01)
  scriptIso15924Code?: ScriptCode;
}

/** Identifies the script of the input document. Maps to the ISO 15924 standard formal name. */
@added(Versions.v2024_11_01)
union ScriptKind {
  string,

  /** Script name for the Arabic script. */
  @added(Versions.v2024_11_01)
  Arabic: "Arabic",

  /** Script name for the Armenian script. */
  @added(Versions.v2024_11_01)
  Armenian: "Armenian",

  /** Script name for the Bangla script. */
  @added(Versions.v2024_11_01)
  Bangla: "Bangla",

  /** Script name for the UnifiedCanadianAboriginalSyllabics script. */
  @added(Versions.v2024_11_01)
  UnifiedCanadianAboriginalSyllabics: "UnifiedCanadianAboriginalSyllabics",

  /** Script name for the Cyrillic script. */
  @added(Versions.v2024_11_01)
  Cyrillic: "Cyrillic",

  /** Script name for the Devanagari script. */
  @added(Versions.v2024_11_01)
  Devanagari: "Devanagari",

  /** Script name for the Ethiopic script. */
  @added(Versions.v2024_11_01)
  Ethiopic: "Ethiopic",

  /** Script name for the Georgian script. */
  @added(Versions.v2024_11_01)
  Georgian: "Georgian",

  /** Script name for the Greek script. */
  @added(Versions.v2024_11_01)
  Greek: "Greek",

  /** Script name for the Gujarati script. */
  @added(Versions.v2024_11_01)
  Gujarati: "Gujarati",

  /** Script name for the Gurmukhi script. */
  @added(Versions.v2024_11_01)
  Gurmukhi: "Gurmukhi",

  /** Script name for the Hangul script. */
  @added(Versions.v2024_11_01)
  Hangul: "Hangul",

  /** Script name for the HanLiteral script. */
  @added(Versions.v2024_11_01)
  HanLiteral: "HanLiteral",

  /** Script name for the HanSimplified script. */
  @added(Versions.v2024_11_01)
  HanSimplified: "HanSimplified",

  /** Script name for the HanTraditional script. */
  @added(Versions.v2024_11_01)
  HanTraditional: "HanTraditional",

  /** Script name for the Hebrew script. */
  @added(Versions.v2024_11_01)
  Hebrew: "Hebrew",

  /** Script name for the Japanese script. */
  @added(Versions.v2024_11_01)
  Japanese: "Japanese",

  /** Script name for the Khmer script. */
  @added(Versions.v2024_11_01)
  Khmer: "Khmer",

  /** Script name for the Kannada script. */
  @added(Versions.v2024_11_01)
  Kannada: "Kannada",

  /** Script name for the Lao script. */
  @added(Versions.v2024_11_01)
  Lao: "Lao",

  /** Script name for the Latin script. */
  @added(Versions.v2024_11_01)
  Latin: "Latin",

  /** Script name for the Malayalam script. */
  @added(Versions.v2024_11_01)
  Malayalam: "Malayalam",

  /** Script name for the Meitei script. */
  @added(Versions.v2024_11_01)
  Meitei: "Meitei",

  /** Script name for the Mongolian script. */
  @added(Versions.v2024_11_01)
  Mongolian: "Mongolian",

  /** Script name for the Myanmar script. */
  @added(Versions.v2024_11_01)
  Myanmar: "Myanmar",

  /** Script name for the Odia script. */
  @added(Versions.v2024_11_01)
  Odia: "Odia",

  /** Script name for the Santali script. */
  @added(Versions.v2024_11_01)
  Santali: "Santali",

  /** Script name for the Sharada script. */
  @added(Versions.v2024_11_01)
  Sharada: "Sharada",

  /** Script name for the Sinhala script. */
  @added(Versions.v2024_11_01)
  Sinhala: "Sinhala",

  /** Script name for the Tamil script. */
  @added(Versions.v2024_11_01)
  Tamil: "Tamil",

  /** Script name for the Telugu script. */
  @added(Versions.v2024_11_01)
  Telugu: "Telugu",

  /** Script name for the Thaana script. */
  @added(Versions.v2024_11_01)
  Thaana: "Thaana",

  /** Script name for the Thai script. */
  @added(Versions.v2024_11_01)
  Thai: "Thai",

  /** Script name for the Tibetan script. */
  @added(Versions.v2024_11_01)
  Tibetan: "Tibetan",
}

/** Identifies the script of the input document. Maps to the ISO 15924 standard script code. */
@added(Versions.v2024_11_01)
union ScriptCode {
  string,

  /** Script code for the Arabic script. */
  @added(Versions.v2024_11_01)
  Arab: "Arab",

  /** Script code for the Armenian script. */
  @added(Versions.v2024_11_01)
  Armn: "Armn",

  /** Script code for the Bangla script. */
  @added(Versions.v2024_11_01)
  Beng: "Beng",

  /** Script code for the UnifiedCanadianAboriginalSyllabics script. */
  @added(Versions.v2024_11_01)
  Cans: "Cans",

  /** Script code for the Cyrillic script. */
  @added(Versions.v2024_11_01)
  Cyrl: "Cyrl",

  /** Script code for the Devanagari script. */
  @added(Versions.v2024_11_01)
  Deva: "Deva",

  /** Script code for the Ethiopic script. */
  @added(Versions.v2024_11_01)
  Ethi: "Ethi",

  /** Script code for the Georgian script. */
  @added(Versions.v2024_11_01)
  Geor: "Geor",

  /** Script code for the Greek script. */
  @added(Versions.v2024_11_01)
  Grek: "Grek",

  /** Script code for the Gujarati script. */
  @added(Versions.v2024_11_01)
  Gujr: "Gujr",

  /** Script code for the Gurmukhi script. */
  @added(Versions.v2024_11_01)
  Guru: "Guru",

  /** Script code for the Hangul script. */
  @added(Versions.v2024_11_01)
  Hang: "Hang",

  /** Script code for the HanLiteral script. */
  @added(Versions.v2024_11_01)
  Hani: "Hani",

  /** Script code for the HanSimplified script. */
  @added(Versions.v2024_11_01)
  Hans: "Hans",

  /** Script code for the HanTraditional script. */
  @added(Versions.v2024_11_01)
  Hant: "Hant",

  /** Script code for the Hebrew script. */
  @added(Versions.v2024_11_01)
  Hebr: "Hebr",

  /** Script code for the Japanese script. */
  @added(Versions.v2024_11_01)
  Jpan: "Jpan",

  /** Script code for the Khmer script. */
  @added(Versions.v2024_11_01)
  Khmr: "Khmr",

  /** Script code for the Kannada script. */
  @added(Versions.v2024_11_01)
  Knda: "Knda",

  /** Script code for the Lao script. */
  @added(Versions.v2024_11_01)
  Laoo: "Laoo",

  /** Script code for the Latin script. */
  @added(Versions.v2024_11_01)
  Latn: "Latn",

  /** Script code for the Malayalam script. */
  @added(Versions.v2024_11_01)
  Mlym: "Mlym",

  /** Script code for the Mongolian script. */
  @added(Versions.v2024_11_01)
  Mong: "Mong",

  /** Script code for the Meitei script. */
  @added(Versions.v2024_11_01)
  Mtei: "Mtei",

  /** Script code for the Myanmar script. */
  @added(Versions.v2024_11_01)
  Mymr: "Mymr",

  /** Script code for the Santali script. */
  @added(Versions.v2024_11_01)
  Olck: "Olck",

  /** Script code for the Odia script. */
  @added(Versions.v2024_11_01)
  Orya: "Orya",

  /** Script code for the Sinhala script. */
  @added(Versions.v2024_11_01)
  Sinh: "Sinh",

  /** Script code for the Sharada script. */
  @added(Versions.v2024_11_01)
  Shrd: "Shrd",

  /** Script code for the Tamil script. */
  @added(Versions.v2024_11_01)
  Taml: "Taml",

  /** Script code for the Telugu script. */
  @added(Versions.v2024_11_01)
  Telu: "Telu",

  /** Script code for the Thaana script. */
  @added(Versions.v2024_11_01)
  Thaa: "Thaa",

  /** Script code for the Thai script. */
  @added(Versions.v2024_11_01)
  Thai: "Thai",

  /** Script code for the Tibetan script. */
  @added(Versions.v2024_11_01)
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
