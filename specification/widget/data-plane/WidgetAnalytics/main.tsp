import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(AadOauth2Auth<["https://azure.com/.default"]>)
@service(#{ title: "WidgetAnalytics" })
@versioned(WidgetAnalytics.Versions)
namespace WidgetAnalytics;

@doc("Versions info.")
enum Versions {
  @doc("The 2022-11-01-preview version.")
  v2022_11_01_Preview: "2022-11-01-preview",

  @doc("The 2022-12-01 version.")
  v2022_12_01: "2022-12-01",

  @doc("The 2023-01-01-preview version.")
  v2023_01_01_Preview: "2023-01-01-preview",

  @doc("The 2023-02-01 version.")
  v2023_02_01: "2023-02-01",
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

  @doc("The widget description. Added in version 2023-01-01-preview.")
  @added(Versions.v2023_01_01_Preview)
  description?: string;

  @doc("The widget status. Added in version 2023-02-01.")
  @added(Versions.v2023_02_01)
  status?: WidgetStatus;
}

@doc("The status of a widget.")
@added(Versions.v2023_02_01)
union WidgetStatus {
  string,

  @doc("Widget is active.")
  Active: "Active",

  @doc("Widget is inactive.")
  Inactive: "Inactive",

  @doc("Widget is under maintenance.")
  Maintenance: "Maintenance",
}

interface Widgets {
  @doc("Fetch a Widget by name.")
  getWidget is ResourceRead<WidgetSuite>;

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

  @doc("Get widget analytics summary. Added in version 2023-01-01-preview.")
  @added(Versions.v2023_01_01_Preview)
  @route("/widgets/{widgetName}/analytics")
  @get
  op getWidgetAnalytics(
    @doc("The widget name.")
    @path
    widgetName: string,

    @doc("The API version to use for this operation.")
    @query("api-version")
    apiVersion: string,
  ): WidgetAnalyticsSummary;
}

@doc("Widget analytics summary.")
@added(Versions.v2023_01_01_Preview)
model WidgetAnalyticsSummary {
  @doc("The widget name.")
  widgetName: string;

  @doc("Total number of operations.")
  totalOperations: int32;

  @doc("Last updated timestamp.")
  lastUpdated: utcDateTime;
}
