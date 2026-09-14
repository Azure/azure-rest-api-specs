import "./main.tsp";
import "./BaseType.tsp";

using Azure.ResourceManager.BaseTypes;

namespace Azure.ResourceManager.Agents;

/** The base type specification for agents */
model AgentBaseType extends BaseTypeInfo {
  /** The baseType implemented */
  baseType: BaseTypeValues.Agent;

  /** Version of the base type */
  version: "2024-06-01";
}

union FoundryToolType {
  /** ChatGPT agent */
  ChatGPT: "chatgpt",

  /** Anthropic Agent */
  Claude: "claude",

  string,
}

model AgentToolTypeEntry {
  type: FoundryToolType;
  name: string;
}

model AgentToolProperty<ToolType extends AgentToolTypeEntry = AgentToolTypeEntry> {
  /** The tools used for this agent */
  tools?: ToolType[];
}

/**
 * @dev May add ...ModelDeploymentRef or ...Instructions
 */
model AgentDefinition {
  `model`: string;
}

/**
 * @dev mix-in for AgentDefinition
 */
model ModelDeploymentRefProperty {
  /** Agent model deployment reference */
  modelDeploymentRef?: string;
}

/**
 * @dev mix-in for Agent Definition
 */
model AgentInstructionsProperty {
  /** The instructions */
  instructions: string;
}

// need a decorator that identifies the base types for this agent,
// serves as a key to enforce the base types and populates this list
// the baseTypes from this list
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
model AgentProperties {
  /** Implemented base types */
  @visibility(Lifecycle.Read)
  baseTypes: [AgentBaseType];

  /** The Agent Display Name */
  displayName: string;

  /** The Agent description */
  description: string;

  /** The Agent Definition */
  definition: AgentDefinition;
}

/**
 * Properties for a Conversation
 */
model ConversationProperties {
  /** The conversation id */
  @visibility(Lifecycle.Read)
  conversationId: string;

  /** Creation date */
  @visibility(Lifecycle.Read)
  createdAt: unixTimestamp32;
}

/** OpenAI Message roles */
union AgentRole {
  /** The user */
  User: "user",

  /** A developer */
  Developer: "developer",

  /** An assistant */
  Assistant: "assistant",

  string,
}

/** Input to a conversation */
model ConversationInput {
  /** The role */
  role: AgentRole;

  /** The input content */
  content: string;
}

/**
 * @dev Optional type property for input
 */
model InputTypeProperty {
  /** The input discriminator */
  type?: string = "message";
}

model ConversationOutput {
  id: string;
}

/** Status for responses */
@Azure.Core.lroStatus
union Status {
  /** Successful completion */
  @Azure.Core.lroSucceeded
  Completed: "completed",

  /** Terminated with failure */
  @Azure.Core.lroFailed
  Failed: "failed",

  /** Cancelled by user */
  @Azure.Core.lroCanceled
  Cancelled: "cancelled",

  /** Not finished */
  Incomplete: "incomplete",

  /** Ready for processing */
  Queued: "queued",

  /** Working */
  InProgress: "in_progress",

  string,
}

/** Properties for an agent response */
model ResponseProperties {
  /** The response Id */
  @visibility(Lifecycle.Read)
  responseId: string;

  /** Creation date */
  @visibility(Lifecycle.Read)
  createdAt: unixTimestamp32;

  /** The model */
  `model`?: string;

  /** Response status */
  @visibility(Lifecycle.Read)
  status: Status;

  /** Input for this response */
  input: ConversationInput;
}

model ResponseOutput {
  /** Identifier */
  @visibility(Lifecycle.Read)
  id: string;

  /** The type of response */
  @visibility(Lifecycle.Read)
  type: string;

  /** The agent role */
  @visibility(Lifecycle.Read)
  role: AgentRole;

  /** working status */
  @visibility(Lifecycle.Read)
  status: Status;

  /** response content */
  @visibility(Lifecycle.Read)
  content: string;
}

/** Mix-in for the output property */
model ResponseOutputProperty {
  /** The output */
  @visibility(Lifecycle.Read)
  property: ResponseOutput[];
}

/** mix-in for the previous_response_id property */
model PreviousResponseProperty {
  /** The previous response identifier */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Wire property name"
  previous_response_id?: string;
}

/**
 * Mix-in for response instructions
 */
model ResponseInstructionsProperty {
  /** The instructions */
  instructions?: string;
}

/**
 * Resource Type for Agents
 * @param Properties RP-specific properties for the agent (must use AgentProperties)
 */
alias Agent<Properties extends AgentProperties> = TrackedResource<Properties>;
