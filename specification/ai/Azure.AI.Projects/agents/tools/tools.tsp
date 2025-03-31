namespace Azure.AI.Projects;

@doc("Represents a JSON schema describing object properties and required fields.")
model JSONSchema {
  @doc("The JSON schema type (e.g., 'object', 'string', 'number').")
  type: string;

  @doc("The properties defined in this JSON schema.")
  properties: Record<JSONSchema>;

  @doc("A list of required property names in this schema.")
  required?: string[];
}

@discriminator("type")
@doc("Base type for any agent tool-specific options, used in a polymorphic manner.")
model AgentToolOptions {
  @doc("Discriminates the various child 'tool options' types.")
  type: string;
}

@discriminator("type")
@doc("Represents a definition of a tool that an agent may use, used in a polymorphic manner.")
model AgentToolDefinition {
  @doc("Discriminates the various child 'tool definition' types.")
  type: string;

  @doc("Additional options that specify the behavior of this tool (also polymorphic).")
  options?: AgentToolOptions;

  @doc("A set of overrides for the tool's name, description, or parameters.")
  override?: {
    @doc("An alternate name for the tool.")
    name?: string;

    @doc("An alternate description for the tool.")
    description?: string;

    @doc("An alternate JSON schema for the tool's parameters.")
    parameters?: JSONSchema;
  };
}

@doc("Options for a function-based tool behavior.")
model FunctionToolOptions extends AgentToolOptions {
  @doc("Indicates this tool is function-based.")
  type: "Function";

  @doc("The function/tool name.")
  name: string;

  @doc("An optional description for the function-based tool.")
  description?: string;

  @doc("A JSON schema describing the function's parameters.")
  parameters?: JSONSchema;

  @doc("Indicates whether strict validation is required.")
  strict?: boolean;
}

@doc("A tool definition for Microsoft Bing grounding.")
model BingGroundingToolDefinition extends AgentToolDefinition {
  @doc("Identifies this as a Bing grounding tool definition.")
  type: "Microsoft.BingGrounding";

  @doc("The name of the Bing grounding connection.")
  connectionName: string;
}

@doc("A tool definition for the OpenAI Code Interpreter.")
model CodeInterpreterToolDefinition extends AgentToolDefinition {
  @doc("Identifies this as an OpenAI Code Interpreter tool definition.")
  type: "OpenAI.CodeInterpreter";

  @doc("A list of file IDs this code interpreter requires.")
  fileIds: string[];
}

@doc("A tool definition for the OpenAI File Search feature.")
model FileSearchToolDefinition extends AgentToolDefinition {
  @doc("Identifies this as an OpenAI File Search tool definition.")
  type: "OpenAI.FileSearch";

  @doc("The maximum number of search results to return (optional).")
  maxNumResults?: int32;

  @doc("Extra ranking options, including a threshold and a ranker.")
  rankingOptions?: {
    @doc("The minimum score to include (optional).")
    scoreThreshold?: float32;

    @doc("The name of the ranker algorithm.")
    ranker: string;
  };

  @doc("A list of file IDs to be searched.")
  fileIds: string[];
}

@doc("A tool definition for an OpenAI-based API described by an OpenAPI specification.")
model OpenApiToolDefinition extends AgentToolDefinition {
  @doc("Identifies this as an OpenAI OpenAPI-based tool definition.")
  type: "OpenAI.OpenApi";

  @doc("The name of the OpenAPI-based tool.")
  name: string;

  @doc("A description for the tool.")
  description?: string;

  @doc("A string containing the raw OpenAPI specification data.")
  openApiSpec: string;
}
