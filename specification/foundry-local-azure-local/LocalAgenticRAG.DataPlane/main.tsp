import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./models.common.tsp";
import "./models.agents-runtime.tsp";
import "./models.collections.tsp";
import "./models.inference.tsp";
import "./models.ingestion.tsp";
import "./models.knowledge-bases.tsp";
import "./models.knowledge-sources.tsp";
import "./models.mcp-server.tsp";

import "./routes.agents-runtime.tsp";
import "./routes.collections.tsp";
import "./routes.inference.tsp";
import "./routes.ingestion.tsp";
import "./routes.knowledge-bases.tsp";
import "./routes.knowledge-sources.tsp";
import "./routes.mcp-server.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

/**
 * Foundry Local Agentic RAG service. Provides agents runtime, collections,
 * inference (RAG and model-only chat), ingestion, knowledge base management,
 * knowledge source management, and MCP server capabilities.
 */
@useAuth(AadOauth2Auth<["https://cognitiveservices.azure.com/.default"]>)
@service(#{ title: "FoundryLocal.AgenticRAG" })
@versioned(Versions)
@server(
  "{endpoint}",
  "Foundry Local Agentic RAG service endpoint.",
  {
    endpoint: url,
  }
)
#suppress "@azure-tools/typespec-azure-core/casing-style" "RAG is an acronym in the service namespace"
namespace FoundryLocal.AgenticRAG;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-06-01-preview API version.
   */
  v2026_06_01_preview: "2026-06-01-preview",
}
