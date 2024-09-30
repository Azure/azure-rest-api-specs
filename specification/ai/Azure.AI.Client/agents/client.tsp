import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@access(Azure.AI.Client.Agents.createAgent, Access.internal);
@@access(Azure.AI.Client.Agents.listAgents, Access.internal);
@@access(Azure.AI.Client.Agents.getAgent, Access.internal);
@@access(Azure.AI.Client.Agents.updateAgent, Access.internal);
@@access(Azure.AI.Client.Agents.deleteAgent, Access.internal);
