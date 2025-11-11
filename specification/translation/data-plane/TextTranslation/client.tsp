import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(TextTranslation.TranslationLanguage.dir,
  "Directionality",
  "dotnet"
);
@@clientName(TextTranslation.TranslationLanguage.dir, "Directionality", "java");

@@clientName(TextTranslation.LanguageScript.dir, "Directionality", "dotnet");
@@clientName(TextTranslation.LanguageScript.dir, "Directionality", "java");

@@clientName(TextTranslation.TranslateInputItem.targets,
  "TranslationTargets",
  "dotnet"
);
@@clientName(TextTranslation.TranslateInputItem.targets,
  "TranslationTargets",
  "java"
);
