import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;

// The "Update" models are used by the hand-written operation method that supports streaming.
// We need to declare their usage and public access, otherwise they won't be emited in the generated code.
@@access(ModelClient.ChatCompletionsUpdate, Access.public);
@@usage(ModelClient.ChatCompletionsUpdate, Usage.output);
@@access(ModelClient.ChatChoiceUpdate, Access.public);
@@usage(ModelClient.ChatChoiceUpdate, Usage.output);
