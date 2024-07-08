import "@azure-tools/typespec-client-generator-core";
import "../main.tsp";

using Azure.ClientGenerator.Core;

// In C#, the functionality provided by the `response_format` property used in image generations is handled by unique
// method signatures for the different response types (i.e. blob URL versus base64 methods).
@@access(Azure.OpenAI.ImageGenerationResponseFormat, Access.internal, "csharp");

// Some models from routes with suppressed visibility are still desired for custom public surface.
@@access(Azure.OpenAI.ImageGenerationOptions, Access.public);
@@usage(Azure.OpenAI.ImageGenerationOptions, Usage.input | Usage.output);
@@access(Azure.OpenAI.ImageSize, Access.public);
@@usage(Azure.OpenAI.ImageGenerations, Usage.output);

// The purpose of this enum is to identify the type of a given result. In C#, this is redundant because we have
// strongly-typed classes for each possible result.
@@access(Azure.OpenAI.AudioTaskLabel, Access.internal, "csharp");

// Java will need to have those models expose in public surface.
@@access(Azure.OpenAI.AudioTranscription, Access.public, "java");
@@access(Azure.OpenAI.AudioTranscriptionOptions, Access.public, "java");
@@access(Azure.OpenAI.AudioTranslation, Access.public, "java");
@@access(Azure.OpenAI.AudioTranslationOptions, Access.public, "java");

@@access(Azure.OpenAI.AzureSearchIndexFieldMappingOptions, Access.public);
@@usage(Azure.OpenAI.AzureSearchIndexFieldMappingOptions, Usage.input);

@@access(Azure.OpenAI.AzureSearchQueryType, Access.public);
@@usage(Azure.OpenAI.AzureSearchQueryType, Usage.input);

@@access(Azure.OpenAI.AzureSearchChatExtensionConfiguration, Access.public);
@@usage(Azure.OpenAI.AzureSearchChatExtensionConfiguration, Usage.input);

// Remap "model" nomenclature to "DeploymentName" in appropriate containers; comments should clarify the dual use
@@clientName(Azure.OpenAI.ImageGenerationOptions.`model`,
  "DeploymentName",
  "csharp"
);

@@clientName(Azure.OpenAI.ChatResponseMessage.context,
  "AzureExtensionsContext",
  "csharp"
);

@@clientName(Azure.OpenAI.AudioTranscriptionFormat.json, "Simple", "csharp");

@@clientName(Azure.OpenAI.AudioTranscriptionFormat.verbose_json,
  "Verbose",
  "csharp"
);

@@clientName(Azure.OpenAI.AudioTranscriptionFormat.text,
  "InternalPlainText",
  "csharp"
);

@@clientName(Azure.OpenAI.AudioTranslationFormat.json, "Simple", "csharp");

@@clientName(Azure.OpenAI.AudioTranslationFormat.verbose_json,
  "Verbose",
  "csharp"
);

@@clientName(Azure.OpenAI.AudioTranslationFormat.text,
  "InternalPlainText",
  "csharp"
);

@@clientName(Azure.OpenAI.ChatCompletionsOptions.logprobs,
  "EnableLogProbabilities",
  "csharp"
);
@@clientName(Azure.OpenAI.ChatCompletionsOptions.top_logprobs,
  "LogProbabilitiesPerToken",
  "csharp"
);

@@clientName(Azure.OpenAI.ChatChoice.logprobs, "LogProbabilityInfo", "csharp");
@@clientName(Azure.OpenAI.ChatChoiceLogProbabilityInfo.content,
  "TokenLogProbabilityResults",
  "csharp"
);
@@clientName(Azure.OpenAI.ChatTokenLogProbabilityResult.top_logprobs,
  "TopLogProbabilityEntries",
  "csharp"
);
@@clientName(Azure.OpenAI.ChatTokenLogProbabilityInfo.logprob,
  "LogProbability",
  "csharp"
);
@@clientName(Azure.OpenAI.ChatTokenLogProbabilityInfo.bytes,
  "Utf8ByteValues",
  "csharp"
);
