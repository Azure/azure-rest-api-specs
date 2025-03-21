model JSONSchema {
    type: string;
    properties: Record<JSONSchema>;
    required?: string[];
}


model AgentToolOptions {}


model AgentToolDefinition {
    type: string;
    options?: AgentToolOptions;
    override?: {
        name?: string;
        description?: string;
        parameters?: JSONSchema;
    };
}

model FunctionToolOptions extends AgentToolOptions {
    type: "Function";
    name: string;
    description?: string;
    parameters?: JSONSchema;
    strict?: boolean;
}

model BingGroundingToolDefinition extends AgentToolDefinition {
    type: "Microsoft.BingGrounding";
    connectionName: string;
}

model CodeInterpreterToolDefinition extends AgentToolDefinition {
    type: "OpenAI.CodeInterpreter";
    fileIds: string[];
}

model FileSearchToolDefinition extends AgentToolDefinition {
    type: "OpenAI.FileSearch";
    maxNumResults?: int32;
    rankingOptions?: {
        scoreThreshold?: float32;
        ranker: string;
    };
    fileIds: string[];
}

model OpenApiToolDefinition extends AgentToolDefinition {
    type: "OpenAI.OpenApi";
    name: string;
    description?: string;
    openApiSpec: string; // Should be binary data
    // TODO: add auth 
}