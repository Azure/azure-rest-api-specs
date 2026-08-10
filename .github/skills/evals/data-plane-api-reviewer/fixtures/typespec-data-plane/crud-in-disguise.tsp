import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Widget Catalog" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://widgetcatalog.azure.com/.default"],
    }
  ]>
)
@server("https://{endpoint}", "Widget Catalog service", { endpoint: string })
namespace WidgetCatalog;

enum Versions {
  v2026_01_01: "2026-01-01",
}

@doc("A widget in the catalog.")
@resource("widgets")
model Widget {
  @doc("The unique name of the widget within the catalog.")
  @key
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Human-readable display name shown in the portal.")
  displayName: string;

  @doc("Physical width of the widget in millimeters.")
  widthInMillimeters: int32;

  @doc("Current lifecycle state of the widget.")
  state: WidgetState;
}

@doc("Lifecycle state of a widget.")
union WidgetState {
  string,

  @doc("The widget is available for use.")
  Active: "Active",

  @doc("The widget is retired and cannot be used in new requests.")
  Retired: "Retired",
}

@doc("Payload for updating a widget.")
model WidgetUpdate {
  @doc("Human-readable display name shown in the portal.")
  displayName?: string;

  @doc("Physical width of the widget in millimeters.")
  widthInMillimeters?: int32;
}

interface Widgets {
  @doc("Gets a widget by name.")
  get is StandardResourceOperations.ResourceRead<Widget>;

  @doc("Updates an existing widget.")
  @route("/widgets/{name}:updateWidget")
  @post
  updateWidget(@path name: string, @body body: WidgetUpdate): Widget;

  @doc("Removes a widget from the catalog.")
  @route("/widgets/{name}:removeWidget")
  @post
  removeWidget(@path name: string): void;

  @doc("Queries widgets in the catalog.")
  @route("/widgets:query")
  @post
  queryWidgets(@body body: WidgetQuery): Widget[];
}

@doc("Filter criteria for a widget query.")
model WidgetQuery {
  @doc("Only return widgets in this state.")
  state?: WidgetState;
}
