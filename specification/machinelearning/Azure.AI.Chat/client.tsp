import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;

@@internal(Azure.AI.Chat.Chat.createStreaming, "csharp");
