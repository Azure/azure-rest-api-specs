import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../main.tsp";
import "../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

/**
 * Returns a list of vector stores.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@get
@route("/vector_stores")
@added(ServiceApiVersions.v2024_05_01_preview)
op listVectorStores(
    ...OpenAIListRequestOptions
): OpenAIPageableListOf<VectorStore>;
