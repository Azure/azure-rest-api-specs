import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(TextTranslation.TranslationLanguage.dir,
  "Directionality",
  "csharp"
);
@@clientName(TextTranslation.TranslationLanguage.dir, "Directionality", "java");

@@clientName(TextTranslation.LanguageScript.dir, "Directionality", "csharp");
@@clientName(TextTranslation.LanguageScript.dir, "Directionality", "java");

@@clientName(TextTranslation.TranslateInputItem.targets,
  "TranslationTargets",
  "csharp"
);
@@clientName(TextTranslation.TranslateInputItem.targets,
  "TranslationTargets",
  "java"
);

@@clientName(TextTranslation.TranslateBody, "TranslateInputs", "java");
@@clientName(TextTranslation.TransliterateBody, "TransliterateInputs", "java");
