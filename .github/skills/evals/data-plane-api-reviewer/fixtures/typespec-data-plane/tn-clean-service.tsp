import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service(#{ title: "Contoso Notebook" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://contosonotebook.azure.com/.default"],
    }
  ]>
)
@server("https://{endpoint}", "Contoso Notebook service", { endpoint: string })
namespace ContosoNotebook;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01 stable version.")
  v2026_01_01: "2026-01-01",
}

@doc("A notebook that groups related notes for a single user.")
@resource("notebooks")
model Notebook {
  @doc("Name of the notebook. Unique within the calling user's account and immutable after creation. 1-64 characters; letters, digits, and hyphens.")
  @key("notebookName")
  @visibility(Lifecycle.Read)
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]+$")
  name: string;

  @doc("Title shown to the user. May be changed at any time and need not be unique.")
  @maxLength(256)
  title: string;

  @doc("Color used to render the notebook in client applications.")
  color: NotebookColor;

  @doc("Number of notes currently in the notebook. Maintained by the service.")
  @visibility(Lifecycle.Read)
  noteCount: int32;

  @doc("Time at which the notebook was created, in UTC.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("Time at which the notebook or any of its notes was last modified, in UTC.")
  @visibility(Lifecycle.Read)
  updatedAt: utcDateTime;
}

@doc("Color used to render a notebook. The set of colors may grow in future API versions.")
union NotebookColor {
  string,

  @doc("The default color, used when the caller does not choose one.")
  Blue: "Blue",

  @doc("A green notebook.")
  Green: "Green",

  @doc("A red notebook, conventionally used for urgent material.")
  Red: "Red",
}

@doc("A single note within a notebook.")
@parentResource(Notebook)
@resource("notes")
model Note {
  @doc("Name of the note. Unique within its notebook and immutable after creation.")
  @key("noteName")
  @visibility(Lifecycle.Read)
  @maxLength(64)
  @minLength(1)
  name: string;

  @doc("Body of the note, as CommonMark-formatted text. Maximum 100,000 characters.")
  @maxLength(100000)
  content: string;

  @doc("Time at which the note was created, in UTC.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;
}

@doc("Operations on notebooks.")
interface Notebooks {
  @doc("Gets a single notebook by name.")
  get is StandardResourceOperations.ResourceRead<Notebook>;

  @doc("Creates a notebook, or replaces an existing notebook with the same name.")
  createOrReplace is StandardResourceOperations.ResourceCreateOrReplace<Notebook>;

  @doc("Deletes a notebook and every note it contains. Deleting a notebook that does not exist succeeds.")
  delete is StandardResourceOperations.ResourceDelete<Notebook>;

  @doc("Lists the notebooks in the calling user's account.")
  list is StandardResourceOperations.ResourceList<
    Notebook,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}

@doc("Operations on notes within a notebook.")
interface Notes {
  @doc("Gets a single note by name.")
  get is StandardResourceOperations.ResourceRead<Note>;

  @doc("Creates a note, or replaces an existing note with the same name.")
  createOrReplace is StandardResourceOperations.ResourceCreateOrReplace<Note>;

  @doc("Deletes a note. Deleting a note that does not exist succeeds.")
  delete is StandardResourceOperations.ResourceDelete<Note>;

  @doc("Lists the notes in a notebook, most recently created first.")
  list is StandardResourceOperations.ResourceList<
    Note,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}
