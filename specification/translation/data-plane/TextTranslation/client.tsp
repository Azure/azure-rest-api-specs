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

@@access(TextTranslation.TranslateBody, Access.internal, "java");
@@usage(TextTranslation.TranslateBody, Usage.input, "java");

@@access(TextTranslation.TranslationResult, Access.internal, "java");
@@usage(TextTranslation.TranslationResult, Usage.output, "java");

@@access(TextTranslation.TransliterateBody, Access.internal, "java");
@@usage(TextTranslation.TransliterateBody, Usage.input, "java");

@@access(TextTranslation.TransliterateResult, Access.internal, "java");
@@usage(TextTranslation.TransliterateResult, Usage.output, "java");
