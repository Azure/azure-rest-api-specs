import "../common/service.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

@doc("A reusable knowledge source in the current Foundry project.")
model KnowledgeSourceObject {
  @doc("The name and identifier of the knowledge source.")
  @maxLength(256)
  name: string;

  @doc("The kind of knowledge source. Always `web`.")
  kind: "web";

  /** Additional properties map to the Azure AI Search web knowledge source contract. */
  ...Record<unknown>;
}

alias CreateKnowledgeSourceRequest = {
  @doc("The name and identifier of the knowledge source.")
  @maxLength(256)
  name: string;

  @doc("The kind of knowledge source. Always `web`.")
  kind: "web";

  /** Additional properties map to the Azure AI Search web knowledge source contract. */
  ...Record<unknown>;
};

alias UpdateKnowledgeSourceRequest = {
  @doc("The name and identifier of the knowledge source.")
  @path
  name: string;

  @doc("The kind of knowledge source. Always `web`.")
  kind?: "web";

  /** Additional properties map to the Azure AI Search web knowledge source contract. */
  ...Record<unknown>;
};

alias GetKnowledgeSourceRequest = {
  @doc("The name of the knowledge source.")
  @path
  name: string;
};

alias ListKnowledgeSourcesRequest = {
  ...CommonPageQueryParameters;
};

alias DeleteKnowledgeSourceRequest = {
  @doc("The name of the knowledge source.")
  @path
  name: string;
};
