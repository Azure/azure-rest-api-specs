import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./shared.tsp";
import "./client.tsp";

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

interface Widgets {
  @doc("Fetch a Widget by name.")
  getWidget is ResourceRead<WidgetSuite>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The template doesn't work for this operation, we dont use api-version here"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This operation doesn't use an api-version"
  @doc("Fetch a Widget by name without using a standard Azure operation.")
  @route("/widgets/{widgetName}/manual")
  @get
  getWidgetManually(
    /** The name of the widget to fetch manually. */
    @path widgetName: string,
  ): WidgetSuite | Azure.Core.Foundations.ErrorResponse;

  @doc("Gets status of a Widget operation.")
  getWidgetOperationStatus is GetResourceOperationStatus<WidgetSuite>;

  @doc("Creates or updates a Widget asynchronously.")
  @pollingOperation(Widgets.getWidgetOperationStatus)
  createOrUpdateWidget is StandardResourceOperations.LongRunningResourceCreateOrUpdate<WidgetSuite>;

  @doc("Delete a Widget asynchronously.")
  @pollingOperation(Widgets.getWidgetOperationStatus)
  deleteWidget is LongRunningResourceDelete<WidgetSuite>;
}
