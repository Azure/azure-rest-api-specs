using TypeSpec.OpenAPI;

namespace VoiceLive;

/**
 * The supported tool type discriminators for voicelive tools.
 * Currently, only 'function' tools are supported.
 */
union ToolType {
  string,
  function: "function",
}

/**
 * The base representation of a voicelive tool definition.
 */
@discriminator("type")
model Tool {
  type: ToolType;
}

/**
 * The definition of a function tool as used by the voicelive endpoint.
 */
model FunctionTool extends Tool {
  type: ToolType.function;
  name: string;
  description?: string;
  parameters?: unknown;
}

/**
 * The combined set of available representations for a voicelive tool_choice parameter, encompassing both string
 * literal options like 'auto' as well as structured references to defined tools.
 */
union ToolChoice {
  ToolChoiceLiteral,
  ToolChoiceObject,
}

/**
 * The available set of mode-level, string literal tool_choice options for the voicelive endpoint.
 */
union ToolChoiceLiteral {
  string,

  /** Specifies that the model should freely determine which tool or tools, if any, to call. */
  auto: "auto",

  /** Specifies that the model should call no tools whatsoever. */
  none: "none",

  /** Specifies that the model should call at least one tool. */
  required: "required",
}

/**
 * A base representation for a voicelive tool_choice selecting a named tool.
 */
@discriminator("type")
model ToolChoiceObject {
  type: ToolType;
}

/**
 * The representation of a voicelive tool_choice selecting a named function tool.
 */
model ToolChoiceFunctionObject extends ToolChoiceObject {
  type: ToolType.function;
  name: string;
}
