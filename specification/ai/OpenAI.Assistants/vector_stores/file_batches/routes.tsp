import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "../../main.tsp";
import "../../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

/**
 * Create a vector store file batch.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
@post
@route("/vector_stores/{vectorStoreId}/file_batches")
@added(ServiceApiVersions.v2024_05_01_preview)
op createVectorStoreFileBatch(
  /**  */
  @path vectorStoreId: string,
): VectorStoreFileBatch;
