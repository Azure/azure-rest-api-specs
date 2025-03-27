namespace Azure.AI.Projects;

/**
 * Represents a JSON schema describing object properties and required fields.
 */
@doc("Represents a JSON schema describing object properties and required fields.")
model JSONSchema {
  /**
   * The JSON schema type (e.g., 'object', 'string', 'number').
   */
  @doc("The JSON schema type (e.g., 'object', 'string', 'number').")
  type: string;

  /**
   * The properties defined in this JSON schema.
   */
  @doc("The properties defined in this JSON schema.")
  properties: Record<JSONSchema>;

  /**
   * A list of required property names in this schema.
   */
  @doc("A list of required property names in this schema.")
  required?: string[];
}

/**
 * Base type for any agent tool options, made polymorphic via discriminator.
 */
@discriminator("type")
@doc("Base type for any agent tool-specific options, used in a polymorphic manner.")
model AgentToolOptions {
  /**
   * Discriminates the various child "tool options" types.
   */
  @doc("Discriminates the various child 'tool options' types.")
  type: string;
}

/**
 * Represents a definition of a tool that an agent may use, made polymorphic via discriminator.
 */
@discriminator("type")
@doc("Represents a definition of a tool that an agent may use, used in a polymorphic manner.")
model AgentToolDefinition {
  /**
   * Discriminates the various child "tool definition" types.
   */
  @doc("Discriminates the various child 'tool definition' types.")
  type: string;

  /**
   * Additional options that specify the behavior of this tool (also polymorphic).
   */
  @doc("Additional options that specify the behavior of this tool (also polymorphic).")
  options?: AgentToolOptions;

  /**
   * A set of overrides for the tool's name, description, or parameters.
   */
  @doc("A set of overrides for the tool's name, description, or parameters.")
  override?: {
    /**
     * An alternate name for the tool.
     */
    name?: string;

    /**
     * An alternate description for the tool.
     */
    description?: string;

    /**
     * An alternate JSON schema for the tool's parameters.
     */
    parameters?: JSONSchema;
  };
}

/**
 * Options for a function-based tool behavior.
 */
@doc("Options for a function-based tool behavior.")
model FunctionToolOptions extends AgentToolOptions {
  /**
   * Indicates this tool options type is specifically for functions.
   */
  @doc("Indicates this tool is function-based.")
  type: "Function";

  /**
   * The function/tool name.
   */
  @doc("The function/tool name.")
  name: string;

  /**
   * An optional description for the function-based tool.
   */
  @doc("An optional description for the function-based tool.")
  description?: string;

  /**
   * A JSON schema describing the function's parameters.
   */
  @doc("A JSON schema describing the function's parameters.")
  parameters?: JSONSchema;

  /**
   * Indicates whether strict validation is required.
   */
  @doc("Indicates whether strict validation is required.")
  strict?: boolean;
}

/**
 * A tool definition for Microsoft Bing grounding.
 */
@doc("A tool definition for Microsoft Bing grounding.")
model BingGroundingToolDefinition extends AgentToolDefinition {
  /**
   * Identifies this as a Bing grounding tool definition.
   */
  @doc("Identifies this as a Bing grounding tool definition.")
  type: "Microsoft.BingGrounding";

  /**
   * The name of the Bing grounding connection.
   */
  @doc("The name of the Bing grounding connection.")
  connectionName: string;
}

/**
 * A tool definition for the OpenAI Code Interpreter.
 */
@doc("A tool definition for the OpenAI Code Interpreter.")
model CodeInterpreterToolDefinition extends AgentToolDefinition {
  /**
   * Identifies this as an OpenAI Code Interpreter tool definition.
   */
  @doc("Identifies this as an OpenAI Code Interpreter tool definition.")
  type: "OpenAI.CodeInterpreter";

  /**
   * A list of file IDs this code interpreter requires.
   */
  @doc("A list of file IDs this code interpreter requires.")
  fileIds: string[];
}

/**
 * A tool definition for the OpenAI File Search feature.
 */
@doc("A tool definition for the OpenAI File Search feature.")
model FileSearchToolDefinition extends AgentToolDefinition {
  /**
   * Identifies this as an OpenAI File Search tool definition.
   */
  @doc("Identifies this as an OpenAI File Search tool definition.")
  type: "OpenAI.FileSearch";

  /**
   * The maximum number of search results to return (optional).
   */
  @doc("The maximum number of search results to return (optional).")
  maxNumResults?: int32;

  /**
   * Extra ranking options, including a threshold and a ranker.
   */
  @doc("Extra ranking options, including a threshold and a ranker.")
  rankingOptions?: {
    /**
     * The minimum score to include (optional).
     */
    @doc("The minimum score to include (optional).")
    scoreThreshold?: float32;

    /**
     * The name of the ranker algorithm.
     */
    @doc("The name of the ranker algorithm.")
    ranker: string;
  };

  /**
   * A list of file IDs to be searched.
   */
  @doc("A list of file IDs to be searched.")
  fileIds: string[];
}

/**
 * A tool definition for an OpenAI-based API described by an OpenAPI specification.
 */
@doc("A tool definition for an OpenAI-based API described by an OpenAPI specification.")
model OpenApiToolDefinition extends AgentToolDefinition {
  /**
   * Identifies this as an OpenAI OpenAPI-based tool definition.
   */
  @doc("Identifies this as an OpenAI OpenAPI-based tool definition.")
  type: "OpenAI.OpenApi";

  /**
   * The name of the OpenAPI-based tool.
   */
  @doc("The name of the OpenAPI-based tool.")
  name: string;

  /**
   * A description for the tool.
   */
  @doc("A description for the tool.")
  description?: string;

  /**
   * A string containing the raw OpenAPI specification data.
   */
  @doc("A string containing the raw OpenAPI specification data.")
  openApiSpec: string;
}
