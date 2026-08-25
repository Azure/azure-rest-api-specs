import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service(#{ title: "Document Analysis" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://documentanalysis.azure.com/.default"],
    }
  ]>
)
@server(
  "https://{endpoint}",
  "Document Analysis service",
  {
    endpoint: string,
  }
)
namespace DocumentAnalysis;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01 stable version.")
  v2026_01_01: "2026-01-01",
}

@doc("A document retained by the service.")
@resource("documents")
model Document {
  @doc("Name of the document.")
  @key("documentName")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Document text.")
  content: string;
}

@doc("Input to document analysis.")
model AnalysisInput {
  @doc("Text to analyze.")
  text: string;
}

@doc("Result of document analysis.")
model AnalysisResult {
  @doc("Detected language.")
  language: string;
}

@doc("Operations on documents.")
interface Documents {
  @doc("Gets a document by name.")
  get is StandardResourceOperations.ResourceRead<Document>;

  @doc("Creates or replaces a document.")
  createOrReplace is StandardResourceOperations.ResourceCreateOrReplace<Document>;

  @doc("Deletes a document.")
  delete is StandardResourceOperations.ResourceDelete<Document>;

  @doc("Lists documents.")
  list is StandardResourceOperations.ResourceList<
    Document,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("Analyzes supplied text without retaining the analysis result.")
  @route("/documents/analyze")
  analyze is Azure.Core.RpcOperation<AnalysisInput, AnalysisResult>;
}
