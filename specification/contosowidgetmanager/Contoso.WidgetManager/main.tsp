import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../Contoso.WidgetManager.Shared";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(AadOauth2Auth<["https://contoso.azure.com/.default"]>)
@service(#{ title: "Contoso Widget Manager" })
@versioned(Contoso.WidgetManager.Versions)
namespace Azure.Contoso.WidgetManager;

@doc("Versions info.")
enum Versions {
  @doc("The 2022-11-01-preview version.")
  v2022_11_01_Preview: "2022-11-01-preview",

  @doc("The 2022-12-01 version.")
  v2022_12_01: "2022-12-01",

  @doc("The 2026-08-01-preview version.")
  @previewVersion
  v2026_08_01_Preview: "2026-08-01-preview",
}

@doc("A widget.")
@resource("widgets")
model WidgetSuite {
  @key("widgetName")
  @doc("The widget name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The ID of the widget's manufacturer.")
  manufacturerId: string;

  @doc("The faked shared model.")
  sharedModel?: FakedSharedModel;
}

/** The fixed size categories available for a widget. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "This example intentionally demonstrates the enum keyword with a fixed set of widget sizes."
@added(Versions.v2026_08_01_Preview)
enum WidgetSize {
  /** A small widget. */
  Small: "Small",

  /** A medium widget. */
  Medium: "Medium",

  /** A large widget. */
  Large: "Large",
}

/** The size category assigned to a widget. */
@added(Versions.v2026_08_01_Preview)
model WidgetSizeResult {
  /** The widget's size category. */
  size: WidgetSize;
}

interface Widgets {
  @doc("Fetch a Widget by name.")
  getWidget is ResourceRead<WidgetSuite>;

  /** Gets the size category of a widget. */
  @added(Versions.v2026_08_01_Preview)
  @get
  @route("/widget-size")
  getWidgetSize is RpcOperation<
    {
      /** The widget name. */
      @query widgetName: string;
    },
    WidgetSizeResult
  >;

  @doc("Gets status of a Widget operation.")
  getWidgetOperationStatus is GetResourceOperationStatus<WidgetSuite>;

  @doc("Creates or updates a Widget asynchronously.")
  @pollingOperation(Widgets.getWidgetOperationStatus)
  createOrUpdateWidget is StandardResourceOperations.LongRunningResourceCreateOrUpdate<WidgetSuite>;

  @doc("Delete a Widget asynchronously.")
  @pollingOperation(Widgets.getWidgetOperationStatus)
  deleteWidget is LongRunningResourceDelete<WidgetSuite>;

  @doc("List Widget resources")
  listWidgets is ResourceList<
    WidgetSuite,
    {
      parameters: StandardListQueryParameters;
    }
  >;
}
