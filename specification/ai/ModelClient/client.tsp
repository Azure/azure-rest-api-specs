import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;

// The "Delta" models are used by the hand-written operation method that supports streaming.
// We need to declare their usage and public access, otherwise they won't be emited in the generated code.
@@access(ModelClient.ChatCompletionsDelta, Access.public);
@@usage(ModelClient.ChatCompletionsDelta, Usage.output);
@@access(ModelClient.ChatChoiceDelta, Access.public);
@@usage(ModelClient.ChatChoiceDelta, Usage.output);
