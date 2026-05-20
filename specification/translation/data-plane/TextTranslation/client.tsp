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

// customization for naming & access in java client
@@clientName(TextTranslation.translate::parameters.body,
  "translateInput",
  "java"
);
@@clientName(TextTranslation.transliterate::parameters.body,
  "transliterateInput",
  "java"
);

@@access(TextTranslation.translate, Access.internal, "java");
@@access(TextTranslation.TranslateInputItem, Access.public, "java");
@@access(TextTranslation.TranslatedTextItem, Access.public, "java");

@@access(TextTranslation.transliterate, Access.internal, "java");
@@access(TextTranslation.TransliteratedText, Access.public, "java");
