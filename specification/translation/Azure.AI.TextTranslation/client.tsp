import "./main.tsp";
import "./models-breaksentence.tsp";
import "./models-dictionary.tsp";
import "./models-languages.tsp";
import "./models-translate.tsp";
import "./models-transliterate.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(TextTranslation.BreakSentenceItem.sentLen, "SentencesLengths");
@@clientName(TextTranslation.BreakSentenceItem.sentLen, "sentLen", "python");

@@clientName(TextTranslation.BackTranslation.numExamples, "ExamplesCount");
@@clientName(TextTranslation.BackTranslation.numExamples,
  "numExamples",
  "python"
);

@@clientName(TextTranslation.DictionaryLookupParameters.from, "SourceLanguage");
@@clientName(TextTranslation.DictionaryLookupParameters.from, "from", "python");

@@clientName(TextTranslation.DictionaryLookupParameters.to, "TargetLanguage");
@@clientName(TextTranslation.DictionaryLookupParameters.to, "to", "python");

@@clientName(TextTranslation.DictionaryExamplesParameters.from,
  "SourceLanguage"
);
@@clientName(TextTranslation.DictionaryExamplesParameters.from,
  "from",
  "python"
);

@@clientName(TextTranslation.DictionaryExamplesParameters.to, "TargetLanguage");
@@clientName(TextTranslation.DictionaryExamplesParameters.to, "to", "python");

@@clientName(TextTranslation.TranslationLanguage.dir, "Directionality");
@@clientName(TextTranslation.TranslationLanguage.dir, "dir", "python");

@@clientName(TextTranslation.SourceDictionaryLanguage.dir, "Directionality");
@@clientName(TextTranslation.SourceDictionaryLanguage.dir, "dir", "python");

@@clientName(TextTranslation.TargetDictionaryLanguage.dir, "Directionality");
@@clientName(TextTranslation.TargetDictionaryLanguage.dir, "dir", "python");

@@clientName(TextTranslation.LanguageScript.dir, "Directionality");
@@clientName(TextTranslation.LanguageScript.dir, "dir", "python");

@@clientName(TextTranslation.TranslationText.sentLen, "SentenceBoundaries");
@@clientName(TextTranslation.TranslationText.sentLen, "sentLen", "python");

@@clientName(TextTranslation.TranslationText.to, "TargetLanguage");
@@clientName(TextTranslation.TranslationText.to, "to", "python");

@@clientName(TextTranslation.SentenceBoundaries.srcSentLen,
  "SourceSentencesLengths"
);
@@clientName(TextTranslation.SentenceBoundaries.srcSentLen,
  "srcSentLen",
  "python"
);

@@clientName(TextTranslation.SentenceBoundaries.transSentLen,
  "TranslatedSentencesLengths"
);
@@clientName(TextTranslation.SentenceBoundaries.transSentLen,
  "transSentLen",
  "python"
);

@@clientName(TextTranslation.DetectedLanguage.score, "Confidence");
@@clientName(TextTranslation.DetectedLanguage.score, "score", "python");

@@clientName(TextTranslation.TranslateParameters.from, "SourceLanguage");
@@clientName(TextTranslation.TranslateParameters.from, "from", "python");

@@clientName(TextTranslation.TranslateParameters.to, "TargetLanguages");
@@clientName(TextTranslation.TranslateParameters.to, "to", "python");

@@clientName(TextTranslation.TranslateParameters.fromScript,
  "SourceLanguageScript"
);
@@clientName(TextTranslation.TranslateParameters.fromScript,
  "fromScript",
  "python"
);

@@clientName(TextTranslation.TranslateParameters.toScript,
  "TargetLanguageScript"
);
@@clientName(TextTranslation.TranslateParameters.toScript,
  "toScript",
  "python"
);

@@clientName(TextTranslation.TranslateParameters.suggestedFrom,
  "SuggestedSourceLanguage"
);
@@clientName(TextTranslation.TranslateParameters.suggestedFrom,
  "suggestedFrom",
  "python"
);

@@clientName(TextTranslation.TranslatedTextAlignment.proj, "Projections");
@@clientName(TextTranslation.TranslatedTextAlignment.proj, "proj", "python");

@@clientName(TextTranslation.TransliterateParameters.fromScript,
  "SourceLanguageScript"
);
@@clientName(TextTranslation.TransliterateParameters.fromScript,
  "fromScript",
  "python"
);

@@clientName(TextTranslation.TransliterateParameters.toScript,
  "TargetLanguageScript"
);
@@clientName(TextTranslation.TransliterateParameters.toScript,
  "toScript",
  "python"
);

@@clientName(TextTranslation.TransliterableScript.toScripts,
  "TargetLanguageScripts"
);
@@clientName(TextTranslation.TransliterableScript.toScripts,
  "toScripts",
  "python"
);
