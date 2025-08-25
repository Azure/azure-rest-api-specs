import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../Contoso.WidgetManager.Shared";

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
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_11_01_Preview: "2022-11-01-preview",

  @doc("The 2022-12-01 version.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
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

  @doc("Optional widget status indicating current state.")
  status?: WidgetStatus;
}

@doc("Widget status options.")
union WidgetStatus {
  string,

  @doc("Widget is active and operational")
  Active: "Active",

  @doc("Widget is inactive")
  Inactive: "Inactive",

  @doc("Widget requires maintenance")
  Maintenance: "Maintenance",
}

interface Widgets {
  @doc("Fetch a Widget by name.")
  getWidget is ResourceRead<WidgetSuite>;

  @doc("Gets status of a Widget operation.")
  getWidgetOperationStatus is GetResourceOperationStatus<WidgetSuite>;

  @doc("Creates or updates a Widget asynchronously. Use this operation to manage widget lifecycle.")
  @pollingOperation(Widgets.getWidgetOperationStatus)
  createOrUpdateWidget is StandardResourceOperations.LongRunningResourceCreateOrUpdate<WidgetSuite>;

  @doc("Delete a Widget asynchronously. This operation permanently removes the widget.")
  @pollingOperation(Widgets.getWidgetOperationStatus)
  deleteWidget is LongRunningResourceDelete<WidgetSuite>;

  @doc("List Widget resources with optional filtering and pagination support.")
  listWidgets is ResourceList<
    WidgetSuite,
    {
      parameters: StandardListQueryParameters;
    }
  >;
}
