import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;

@@access(Azure.AI.ChatProtocol.createStreaming, Access.internal, "csharp");
@@access(Azure.AI.ChatProtocol.ChatRole, Access.public, "csharp");
