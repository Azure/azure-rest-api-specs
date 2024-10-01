import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@access(Azure.AI.Client.Agents.createAgent, Access.internal);
@@access(Azure.AI.Client.Agents.listAgents, Access.internal);
@@access(Azure.AI.Client.Agents.updateAgent, Access.internal);

@@access(Azure.AI.Client.Agents.Agent, Access.internal);
@@access(Azure.AI.Client.Agents.CreateAgentOptions, Access.internal);
@@access(Azure.AI.Client.Agents.UpdateAgentOptions, Access.internal);