import "@typespec/openapi";
import "./items.tsp";

using TypeSpec.OpenAPI;

namespace OpenAI;

/** The collection of valid roles for responses message items. */
union ResponsesMessageRole {
  system: "system",
  developer: "developer",
  user: "user",
  assistant: "assistant",
}

/** A response message item, representing a role and content, as provided as client request parameters. */
@discriminator("role")
model ResponsesMessageItemParam extends ItemParam {
  /** The type of the responses item, which is always 'message'. */
  type: ItemType.message;

  /** The role associated with the message. */
  role: ResponsesMessageRole;
}

/** A message parameter item with the `user` role. */
model ResponsesUserMessageItemParam extends ResponsesMessageItemParam {
  /** The role of the message, which is always `user`. */
  role: ResponsesMessageRole.user;

  /** The content associated with the message. */
  content: InputContent[];
}

/** A message parameter item with the `system` role. */
model ResponsesSystemMessageItemParam extends ResponsesMessageItemParam {
  /** The role of the message, which is always `system`. */
  role: ResponsesMessageRole.system;

  /** The content associated with the message. */
  content: InputContent[];
}

/** A message parameter item with the `developer` role. */
model ResponsesDeveloperMessageItemParam extends ResponsesMessageItemParam {
  /** The role of the message, which is always `developer`. */
  role: ResponsesMessageRole.developer;

  /** The content associated with the message. */
  content: InputContent[];
}

/** A message parameter item with the `assistant` role. */
model ResponsesAssistantMessageItemParam extends ResponsesMessageItemParam {
  /** The role of the message, which is always `assistant`. */
  role: ResponsesMessageRole.assistant;

  /** The content associated with the message. */
  content: OutputContent[];
}

/** A response message resource item, representing a role and content, as provided on service responses. */
@discriminator("role")
model ResponsesMessageItemResource extends ItemResource {
  /** The type of the responses item, which is always 'message'. */
  type: ItemType.message;

  @doc("""
    The status of the item. One of `in_progress`, `completed`, or
    `incomplete`. Populated when items are returned via API.
    """)
  status: "in_progress" | "completed" | "incomplete";

  /** The role associated with the message. */
  role: ResponsesMessageRole;
}

/** A message resource item with the `user` role. */
model ResponsesUserMessageItemResource extends ResponsesMessageItemResource {
  /** The role of the message, which is always `user`. */
  role: ResponsesMessageRole.user;

  /** The content associated with the message. */
  content: InputContent[];
}

/** A message resource item with the `system` role. */
model ResponsesSystemMessageItemResource extends ResponsesMessageItemResource {
  /** The role of the message, which is always `system`. */
  role: ResponsesMessageRole.system;

  /** The content associated with the message. */
  content: InputContent[];
}

/** A message resource item with the `developer` role. */
model ResponsesDeveloperMessageItemResource
  extends ResponsesMessageItemResource {
  /** The role of the message, which is always `developer`. */
  role: ResponsesMessageRole.developer;

  /** The content associated with the message. */
  content: InputContent[];
}

/** A message resource item with the `assistant` role. */
model ResponsesAssistantMessageItemResource
  extends ResponsesMessageItemResource {
  /** The role of the message, which is always `assistant`. */
  role: ResponsesMessageRole.assistant;

  /** The content associated with the message. */
  content: OutputContent[];
}

model ImplicitUserMessage {
  content: string | ItemContent[];
}
