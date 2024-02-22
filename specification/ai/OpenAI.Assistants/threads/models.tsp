import "@typespec/versioning";
import "../common/models.tsp";
import "../messages/models.tsp";

using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

@doc("Information about a single thread associated with an assistant.")
@added(ServiceApiVersions.v2024_02_15_preview)
model AssistantThread {
  @doc("The identifier, which can be referenced in API endpoints.")
  id: string;

  @doc("The object type, which is always 'thread'.")
  object: "thread";

  @encodedName("application/json", "created_at")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  @doc("The Unix timestamp, in seconds, representing when this object was created.")
  createdAt: utcDateTime;

  ...RequiredNullableMetadata;
}

@doc("The details used to create a new assistant thread.")
@added(ServiceApiVersions.v2024_02_15_preview)
model AssistantThreadCreationOptions {
  @doc("The initial messages to associate with the new thread.")
  messages?: ThreadInitializationMessage[];

  ...OptionalNullableMetadata;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "https://github.com/Azure/autorest.csharp/issues/4041"
@doc("The status of a thread deletion operation.")
@added(ServiceApiVersions.v2024_02_15_preview)
model ThreadDeletionStatus {
  ...DeletionStatus;

  @doc("The object type, which is always 'thread.deleted'.")
  object: "thread.deleted";
}
