import "@azure-tools/typespec-azure-core";

import "./agents.tsp";
import "./completions.tsp";
import "@typespec/rest";
import "@typespec/streams";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;

/**
 * What general capabilities does our service have? Well, it doesn't support
 * OASIS repeatability requests (but maybe it should), we don't support conditional
 * requests (If-Match and friends), but we do support client request ids to make
 * it easier for callers to get help by product support.
 */
alias ServiceTraits = Azure.Core.Traits.NoRepeatableRequests &
  Azure.Core.Traits.NoConditionalRequests &
  Azure.Core.Traits.SupportsClientRequestId;

/**
 * We currently don't have any custom operations apart from the standard azure
 * core ones, but if/once we do, we can create our own interface/set of blessed
 * operations for the foundry service here.
 */
alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

@service
@Versioning.versioned(ApiVersions)
namespace AzureAIAgents {
  enum ApiVersions {
    @Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
    tbd, // TODO - update with actual api version.
  }
  interface Messages {
    sendMessage is Operations.ResourceCreateWithServiceProvidedName<ChatMessage>;
    getMessage is Operations.ResourceRead<ChatMessage>;
    updateMessage is Operations.ResourceCreateOrReplace<ChatMessage>;
    deleteMessage is Operations.ResourceDelete<ChatMessage>;
    listMessages is Operations.ResourceList<ChatMessage>;
  }

  interface Threads {
    createThread is Operations.ResourceCreateWithServiceProvidedName<Thread>;
    getThread is Operations.ResourceRead<Thread>;
    updateThread is Operations.ResourceCreateOrReplace<Thread>;
    deleteThread is Operations.ResourceDelete<Thread>;
    listThreads is Operations.ResourceList<Thread>;
  }

  interface Agents {
    createAgent is Operations.ResourceCreateWithServiceProvidedName<Agent>;
    getAgent is Operations.ResourceRead<Agent>;
    updateAgent is Operations.ResourceCreateOrReplace<Agent>;
    deleteAgent is Operations.ResourceDelete<Agent>;
    listAgents is Operations.ResourceList<Agent>;

    complete is Operations.ResourceCollectionAction<
      Agent,
      CompleteParams,
      AgentCompletion
    >;
    stream is Operations.ResourceCollectionAction<
      Agent,
      { ... CompleteParams },
      Streams.Stream<StreamingAgentCompletionUpdate>
    >;
    @Rest.action("complete")
    completeByAgent is Operations.ResourceAction<
      Agent,
      { ... AgentCompleteParams },
      AgentCompletion
    >;
    @Rest.action("stream")
    streamByAgent is Operations.ResourceAction<
      Agent,
      { ... AgentCompleteParams },
      Streams.Stream<StreamingAgentCompletionUpdate>
    >;
  }
}
