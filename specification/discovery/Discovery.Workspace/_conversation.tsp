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
  @pattern(resourceNamePattern)
  name: string;

  ...DataPlaneResource;
  ...WithTitle;
  ...WithInvestigationNameOptional;
  ...WithProjectNameOptional;
}

// TODO: Remove un-needed route prefix!
//@route("copilot")
interface Conversations {
  @doc("Fetch a Conversation by name.")
  getConversation is ResourceRead<Conversation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a Conversation.")
  @createsOrReplacesResource(Conversation)
  @route("/conversations")
  @post
  createConversation is Azure.Core.Foundations.Operation<
    WithProjectName & WithInvestigationNameOptional,
    Conversation
  >;

  @doc("Updates a Conversation.")
  updateConversation is StandardResourceOperations.ResourceCreateOrUpdate<Conversation>;

  @doc("List Conversation resources")
  listConversations is ResourceList<
    Conversation,
    QueryParametersTrait<WithQueryInvestigationName & WithQueryCreatedSince>
  >;
}
