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
