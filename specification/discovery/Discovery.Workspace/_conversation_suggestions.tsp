import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./_conversation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Discovery.DataPlane.Shared;

@versioned(Microsoft.Discovery.Workspace.Versions)
namespace Microsoft.Discovery.Workspace;

@doc("A suggestion for prompts in a conversation.")
model Suggestion {
  @doc("The unique identifier for the suggestion (UUID format).")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The suggested prompt text that the user can use.")
  @visibility(Lifecycle.Read)
  text?: string;

  @doc("The reasoning or explanation for why this suggestion was generated.")
  @visibility(Lifecycle.Read)
  reasoning?: string;

  @doc("The confidence score for this suggestion, typically between 0.0 and 1.0.")
  @visibility(Lifecycle.Read)
  confidence: float64;

  @doc("The ranking position of this suggestion relative to other suggestions.")
  @visibility(Lifecycle.Read)
  rank: int32;
}

@doc("Response model for conversation suggestions.")
model ConversationSuggestionsResponse {
  @doc("The name of the conversation these suggestions are for.")
  @visibility(Lifecycle.Read)
  conversationName: string;

  @doc("Array of suggestions for the conversation.")
  @visibility(Lifecycle.Read)
  suggestions: Suggestion[];

  @doc("The timestamp when the suggestions were generated.")
  @visibility(Lifecycle.Read)
  @renamedFrom(Versions.`2026-02-01-preview`, "generatedAt")
  createdAt: utcDateTime;

  @removed(Versions.`2026-02-01-preview`)
  @doc("Indicates whether the suggestion generation was successful.")
  @visibility(Lifecycle.Read)
  success?: boolean;

  @removed(Versions.`2026-02-01-preview`)
  @doc("Message describing the suggestion generation result.")
  @visibility(Lifecycle.Read)
  message?: string;
}

@doc("Operations for conversation suggestions.")
interface ConversationSuggestions {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get suggestions for the specified conversation.")
  @route("/conversations/{conversationName}/suggestions")
  @get
  getSuggestions is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the conversation.")
      @path
      conversationName: string;
    },
    ConversationSuggestionsResponse
  >;
}
