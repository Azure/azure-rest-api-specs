import "@azure-tools/typespec-client-generator-core";
import "../main.tsp";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
namespace Azure.OpenAI;

// Azure-specific Chat Completions with extensions should be handled by clients as a conditional selection within the
// shared Chat Completions route, with the selection gated by the presence or non-presence of additional child
// configuration options on the request payload options model.
@@access(getChatCompletionsWithAzureExtensions, Access.internal);

// In C#, the functionality provided by the `response_format` property used in image generations is handled by unique
// method signatures for the different response types (i.e. blob URL versus base64 methods).
@@access(ImageGenerationResponseFormat, Access.internal, "csharp");

// Some models from routes with suppressed visibility are still desired for custom public surface.
@@access(ImageGenerationOptions, Access.public);
@@usage(ImageGenerationOptions, Usage.input | Usage.output);
@@access(ImageSize, Access.public);
@@usage(ImageGenerations, Usage.input | Usage.output);

// The purpose of this enum is to identify the type of a given result. In C#, this is redundant because we have
// strongly-typed classes for each possible result.
@@access(AudioTaskLabel, Access.internal, "csharp");

// Java will need to have those models expose in public surface.
@@access(AudioTranscription, Access.public, "java");
@@access(AudioTranscriptionOptions, Access.public, "java");
@@access(AudioTranslation, Access.public, "java");
@@access(AudioTranslationOptions, Access.public, "java");

@@access(AzureCognitiveSearchIndexFieldMappingOptions,
  Access.public
);
@@usage(AzureCognitiveSearchIndexFieldMappingOptions, Usage.input);

@@access(AzureCognitiveSearchQueryType, Access.public);
@@usage(AzureCognitiveSearchQueryType, Usage.input);

@@access(AzureCognitiveSearchChatExtensionConfiguration,
  Access.public
);
@@usage(AzureCognitiveSearchChatExtensionConfiguration,
  Usage.input
);

// .NET maps the input bifurcation of URL vs. image data via distinct parameterization; it should hide the combined
// string-based container used on the wire and plumb the relevant information through the parent content item.
@@access(ChatMessageImageUrl, Access.internal, "csharp");

// Remap "model" nomenclature to "DeploymentName" in appropriate containers; comments should clarify the dual use
@@projectedName(ImageGenerationOptions.`model`,
  "csharp",
  "DeploymentName"
);

@@projectedName(ChatResponseMessage.context,
  "csharp",
  "AzureExtensionsContext"
);

@@projectedName(AudioTranscriptionFormat.json, "csharp", "Simple");

@@projectedName(AudioTranscriptionFormat.verbose_json,
  "csharp",
  "Verbose"
);

@@projectedName(AudioTranscriptionFormat.text,
  "csharp",
  "InternalPlainText"
);

@@projectedName(AudioTranslationFormat.json, "csharp", "Simple");

@@projectedName(AudioTranslationFormat.verbose_json,
  "csharp",
  "Verbose"
);

@@projectedName(AudioTranslationFormat.text,
  "csharp",
  "InternalPlainText"
);

// .NET maps the input bifurcation of URL vs. image data via distinct parameterization; it should hide the combined
// string-based container used on the wire and plumb the relevant information through the parent content item.
@@projectedName(ChatMessageImageUrl, "csharp", "InternalChatMessageImageUrl");
@@projectedName(ChatMessageImageContentItem.imageUrl, "csharp", "InternalImageUrlOrData");
