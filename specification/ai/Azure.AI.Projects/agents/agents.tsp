import "@azure-tools/typespec-azure-core";

import "./messages.tsp";
import "./tools.tsp";
import "./model-options/openai.tsp";
import "./model-options/azure.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

alias AgentCompletionProperties = {
    @doc("The name of the agent; used for display purposes and sent to the LLM to identify the agent.")
    name?: string;
    `model`: AgentModel;
    instructions?: ChatMessage[];

    // TODO: Add when supported
    //closingInstructions?: ChatMessage[];

    tools?: AgentToolDefinition[];
    toolChoice?: ToolChoiceBehavior;
};

@Rest.resource("agents")
model Agent {
    @key
    @visibility(Lifecycle.Read)
    agentId: string;

    @doc("A description of the agent; used for display purposes and sent to the LLM to describe the agent.")
    description?: string;

    metadata?: Record<string>;

    ... AgentCompletionProperties
}

model AgentOptions {
    ... AgentCompletionProperties
}

@discriminator("provider")
model AgentModel {
    id: string;
    provider?: string;
    endpoint?: string;
    options?: unknown;
}

@discriminator("type")
model ToolChoiceBehavior {
    type: string;
}

model AutoToolChoiceBehavior extends ToolChoiceBehavior {
    type: "auto";
    toolNames: string[];
}

model RequiredToolChoiceBehavior extends ToolChoiceBehavior {
    type: "required";
    toolNames: string[];
}

model NoneToolChoiceBehavior extends ToolChoiceBehavior {
    type: "none";
}