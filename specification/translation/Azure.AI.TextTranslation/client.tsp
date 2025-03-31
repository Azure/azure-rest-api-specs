import "./main.tsp";
import "./models-languages.tsp";
import "./models-translate.tsp";
import "./models-transliterate.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(TextTranslation.TranslationLanguage.dir,
  "Directionality",
  "dotnet"
);
@@clientName(TextTranslation.TranslationLanguage.dir, "Directionality", "java");

@@clientName(TextTranslation.SourceDictionaryLanguage.dir,
  "Directionality",
  "dotnet"
);
@@clientName(TextTranslation.SourceDictionaryLanguage.dir,
  "Directionality",
  "java"
);

@@clientName(TextTranslation.TargetDictionaryLanguage.dir,
  "Directionality",
  "dotnet"
);
@@clientName(TextTranslation.TargetDictionaryLanguage.dir,
  "Directionality",
  "java"
);

@@clientName(TextTranslation.LanguageScript.dir, "Directionality", "dotnet");
@@clientName(TextTranslation.LanguageScript.dir, "Directionality", "java");

@@clientName(TextTranslation.TranslationText.to, "TargetLanguage", "dotnet");
@@clientName(TextTranslation.TranslationText.to, "TargetLanguage", "java");

@@clientName(TextTranslation.DetectedLanguage.score, "Confidence", "dotnet");
@@clientName(TextTranslation.DetectedLanguage.score, "Confidence", "java");

@@clientName(TextTranslation.TranslateParameters.from,
  "SourceLanguage",
  "dotnet"
);
@@clientName(TextTranslation.TranslateParameters.from,
  "SourceLanguage",
  "java"
);
@@clientName(TextTranslation.TranslateParameters.from,
  "from_language",
  "python"
);

@@clientName(TextTranslation.TranslateParameters.to,
  "TargetLanguages",
  "dotnet"
);
@@clientName(TextTranslation.TranslateParameters.to, "TargetLanguages", "java");
@@clientName(TextTranslation.TranslateParameters.to, "to_language", "python");

@@clientName(TextTranslation.TranslateParameters.fromScript,
  "SourceLanguageScript",
  "dotnet"
);
@@clientName(TextTranslation.TranslateParameters.fromScript,
  "SourceLanguageScript",
  "java"
);

@@clientName(TextTranslation.TranslateParameters.toScript,
  "TargetLanguageScript",
  "dotnet"
);
@@clientName(TextTranslation.TranslateParameters.toScript,
  "TargetLanguageScript",
  "java"
);

@@clientName(TextTranslation.TransliterateParameters.fromScript,
  "SourceLanguageScript",
  "dotnet"
);
@@clientName(TextTranslation.TransliterateParameters.fromScript,
  "SourceLanguageScript",
  "java"
);

@@clientName(TextTranslation.TransliterateParameters.toScript,
  "TargetLanguageScript",
  "dotnet"
);
@@clientName(TextTranslation.TransliterateParameters.toScript,
  "TargetLanguageScript",
  "java"
);

@@clientName(TextTranslation.TransliterableScript.toScripts,
  "TargetLanguageScripts",
  "dotnet"
);
@@clientName(TextTranslation.TransliterableScript.toScripts,
  "TargetLanguageScripts",
  "java"
);
