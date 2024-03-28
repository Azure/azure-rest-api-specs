import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../models/completions/completions_create.tsp";
import "../models/completions/chat_completions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

using Azure.Core;

namespace Azure.OpenAI;

@doc("""
Gets completions for the provided input prompts.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
@actionSeparator("/")
@action("completions") //@convenientAPI(true)
op getCompletions is Azure.Core.ResourceAction<
  Deployment,
  CompletionsOptions,
  Completions
>;

@doc("""
Gets chat completions for the provided chat messages.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
@added(ServiceApiVersions.v2023_05_15)
@actionSeparator("/")
@action("chat/completions") //@convenientAPI(true)
op getChatCompletions is ResourceAction<
  Deployment,
  ChatCompletionsOptions,
  ChatCompletions
>;

@doc("""
Gets chat completions for the provided chat messages.
This is an Azure-specific version of chat completions that supports integration with configured data sources and
other augmentations to the base chat completions capabilities.
""")
// Note: client libraries should abstract the existence of this as a distinct REST route and instead perform dynamic
//        selection of the appropriate request URL structure based on the presence or non-presence of matching
//        chat extensions configuration in the request options model. Future service API versions may merge this
//        capability into the standard /chat/completions route.
@added(ServiceApiVersions.v2023_08_01_Preview)
@actionSeparator("/")
@action("extensions/chat/completions")
op getChatCompletionsWithAzureExtensions is ResourceAction<
  Deployment,
  ChatCompletionsOptions,
  ChatCompletions
>;
