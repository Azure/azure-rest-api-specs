import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@tag("Knowledge Sources")
interface KnowledgeSources {
  /** Creates a knowledge source in the current project. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Create a knowledge source")
  @operationId("createKnowledgeSource")
  @post
  @route("/knowledge_sources")
  createKnowledgeSource is FoundryDataPlaneOperation<
    CreateKnowledgeSourceRequest,
    KnowledgeSourceObject
  >;

  /** Updates the specified knowledge source. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Update a knowledge source")
  @operationId("updateKnowledgeSource")
  @post
  @route("/knowledge_sources/{name}")
  updateKnowledgeSource is FoundryDataPlaneOperation<
    UpdateKnowledgeSourceRequest,
    KnowledgeSourceObject
  >;

  /** Retrieves the specified knowledge source. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Get a knowledge source")
  @operationId("getKnowledgeSource")
  @get
  @route("/knowledge_sources/{name}")
  getKnowledgeSource is FoundryDataPlaneOperation<
    GetKnowledgeSourceRequest,
    KnowledgeSourceObject
  >;

  /** Lists knowledge sources in the current project. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("List knowledge sources")
  @operationId("listKnowledgeSources")
  @get
  @list
  @route("/knowledge_sources")
  listKnowledgeSources is FoundryDataPlaneOperation<
    ListKnowledgeSourcesRequest,
    AgentsPagedResult<KnowledgeSourceObject>
  >;

  /** Deletes the specified knowledge source. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete a knowledge source")
  @operationId("deleteKnowledgeSource")
  @delete
  @route("/knowledge_sources/{name}")
  deleteKnowledgeSource is FoundryDataPlaneOperation<
    DeleteKnowledgeSourceRequest,
    void
  >;
}
