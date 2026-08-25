import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service(#{ title: "Document Catalog" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://documentcatalog.azure.com/.default"],
    }
  ]>
)
@server(
  "{endpoint}",
  "Document Catalog service",
  {
    endpoint: url,
  }
)
namespace DocumentCatalog;

@doc("Service API versions.")
enum Versions {
  @doc("The 2025-01-01 stable version.")
  v2025_01_01: "2025-01-01",
}

@doc("A document registered in the catalog.")
@resource("documents")
model Document {
  @doc("Name of the document. Unique within the calling account.")
  @key("documentName")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Title shown to catalog users.")
  title: string;

  @doc("Lifecycle state of the document.")
  state: DocumentState;

  @doc("Time at which the document was registered, in UTC.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;
}

@doc("Lifecycle state of a catalog document.")
union DocumentState {
  string,

  @doc("The document is available to catalog users.")
  Active: "Active",

  @doc("The document is hidden while its content is reviewed.")
  Reviewing: "Reviewing",
}

@doc("Operations on catalog documents.")
interface Documents {
  @doc("Gets a document by name.")
  get is StandardResourceOperations.ResourceRead<Document>;

  @doc("Creates a document, or replaces an existing document with the same name.")
  createOrReplace is StandardResourceOperations.ResourceCreateOrReplace<Document>;

  @doc("Deletes a document. Deleting a document that does not exist succeeds.")
  delete is StandardResourceOperations.ResourceDelete<Document>;

  @doc("Lists documents in the catalog.")
  list is StandardResourceOperations.ResourceList<
    Document,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}
