import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Discovery.DataPlane.Shared;

@versioned(Microsoft.Discovery.Workspace.Versions)
namespace Microsoft.Discovery.Workspace;

@doc("A conversation.")
@resource("conversations")
model Conversation {
  @doc("The conversation name.")
  @visibility(Lifecycle.Read)
  @key("conversationName")
  @maxLength(24)
  @pattern(resourceNamePattern)
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

  @doc("List Conversation resources")
  list is ResourceList<
    Conversation,
    QueryParametersTrait<WithQueryInvestigationName & WithQueryCreatedSince>
  >;
}
