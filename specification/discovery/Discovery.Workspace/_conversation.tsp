import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

using Microsoft.Discovery.Common;

@versioned(Microsoft.Discovery.Workspace.Versions)
namespace Microsoft.Discovery.Workspace;

@doc("A conversation.")
@resource("conversations")
model Conversation {
  @doc("The conversation name.")
  @visibility(Lifecycle.Read)
  @key("conversationName")
  @pattern(conversationNamePattern)
  name: string;

  ...DataPlaneResource;
  ...WithTitle;
  ...WithInvestigationNameOptional;
  ...WithProjectNameOptional;
}

@doc("Request body for creating a conversation.")
model CreateConversationRequest {
  ...WithProjectName;
  ...WithInvestigationNameOptional;
}

// TODO: Remove un-needed route prefix!
//@route("copilot")
interface Conversations {
  @doc("Fetch a Conversation by name.")
  get is ResourceRead<Conversation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a Conversation.")
  @createsOrReplacesResource(Conversation)
  @route("/conversations")
  @post
  create is Azure.Core.Foundations.Operation<
    CreateConversationRequest,
    Conversation
  >;

  @doc("Updates a Conversation.")
  update is StandardResourceOperations.ResourceCreateOrUpdate<Conversation>;

  @doc("Deletes a Conversation.")
  delete is ResourceDelete<Conversation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation returns a bare array per service behavior, not a paged result"
  @doc("List Conversation resources")
  @route("/conversations")
  @get
  list is Azure.Core.Foundations.Operation<
    WithQueryInvestigationName & WithQueryProjectName & WithQueryCreatedSince,
    Conversation[]
  >;
}
