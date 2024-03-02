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
@@usage(Azure.OpenAI.ImageGenerations, Usage.input | Usage.output);

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
@@projectedName(Azure.OpenAI.ImageGenerationOptions.`model`,
  "csharp",
  "DeploymentName"
);

@@projectedName(Azure.OpenAI.ChatResponseMessage.context,
  "csharp",
  "AzureExtensionsContext"
);

@@projectedName(Azure.OpenAI.AudioTranscriptionFormat.json, "csharp", "Simple");

@@projectedName(Azure.OpenAI.AudioTranscriptionFormat.verbose_json,
  "csharp",
  "Verbose"
);

@@projectedName(Azure.OpenAI.AudioTranscriptionFormat.text,
  "csharp",
  "InternalPlainText"
);

@@projectedName(Azure.OpenAI.AudioTranslationFormat.json, "csharp", "Simple");

@@projectedName(Azure.OpenAI.AudioTranslationFormat.verbose_json,
  "csharp",
  "Verbose"
);

@@projectedName(Azure.OpenAI.AudioTranslationFormat.text,
  "csharp",
  "InternalPlainText"
);

@@projectedName(Azure.OpenAI.ChatCompletionsOptions.logprobs,
  "csharp",
  "EnableLogProbabilities"
);
@@projectedName(Azure.OpenAI.ChatCompletionsOptions.top_logprobs,
  "csharp",
  "LogProbabilitiesPerToken"
);

@@projectedName(Azure.OpenAI.ChatChoice.logprobs,
  "csharp",
  "LogProbabilityInfo"
);
@@projectedName(Azure.OpenAI.ChatChoiceLogProbabilityInfo.content,
  "csharp",
  "TokenLogProbabilityResults"
);
@@projectedName(Azure.OpenAI.ChatTokenLogProbabilityResult.top_logprobs,
  "csharp",
  "TopLogProbabilityEntries"
);
@@projectedName(Azure.OpenAI.ChatTokenLogProbabilityInfo.logprob,
  "csharp",
  "LogProbability"
);
@@projectedName(Azure.OpenAI.ChatTokenLogProbabilityInfo.bytes,
  "csharp",
  "Utf8ByteValues"
);
