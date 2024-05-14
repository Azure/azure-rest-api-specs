import "./main.tsp";
import "./models-breaksentence.tsp";
import "./models-dictionary.tsp";
import "./models-languages.tsp";
import "./models-translate.tsp";
import "./models-transliterate.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(TextTranslation.BreakSentenceItem.sentLen, "SentencesLengths");

@@clientName(TextTranslation.BackTranslation.numExamples, "ExamplesCount");

@@clientName(TextTranslation.DictionaryLookupParameters.from, "SourceLanguage");

@@clientName(TextTranslation.DictionaryLookupParameters.to, "TargetLanguage");

@@clientName(TextTranslation.DictionaryExamplesParameters.from,
  "SourceLanguage"
);

@@clientName(TextTranslation.DictionaryExamplesParameters.to, "TargetLanguage");

@@clientName(TextTranslation.TranslationLanguage.dir, "Directionality");

@@clientName(TextTranslation.SourceDictionaryLanguage.dir, "Directionality");

@@clientName(TextTranslation.TargetDictionaryLanguage.dir, "Directionality");

@@clientName(TextTranslation.LanguageScript.dir, "Directionality");

@@clientName(TextTranslation.TranslationText.sentLen, "SentenceBoundaries");

@@clientName(TextTranslation.SentenceBoundaries.srcSentLen,
  "SourceSentencesLengths"
);

@@clientName(TextTranslation.SentenceBoundaries.transSentLen,
  "TranslatedSentencesLengths"
);

@@clientName(TextTranslation.DetectedLanguage.score, "Confidence");

@@clientName(TextTranslation.TranslateParameters.from, "SourceLanguage");

@@clientName(TextTranslation.TranslateParameters.to, "TargetLanguages");

@@clientName(TextTranslation.TranslateParameters.fromScript,
  "SourceLanguageScript"
);

@@clientName(TextTranslation.TranslateParameters.toScript,
  "TargetLanguageScript"
);

@@clientName(TextTranslation.TranslateParameters.suggestedFrom,
  "SuggestedSourceLanguage"
);

@@clientName(TextTranslation.TranslatedTextAlignment.proj, "Projections");

@@clientName(TextTranslation.TransliterateParameters.fromScript,
  "SourceLanguageScript"
);

@@clientName(TextTranslation.TransliterateParameters.toScript,
  "TargetLanguageScript"
);
