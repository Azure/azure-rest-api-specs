import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@access(Azure.AI.Client.Agents.createAssistant, Access.internal);
@@access(Azure.AI.Client.Agents.CreateAssistantOptions, Access.internal);
@@access(Azure.AI.Client.Agents.Assistant, Access.internal);