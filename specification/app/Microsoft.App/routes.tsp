import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "./main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

// @versioned(Microsoft.App.Versions)
namespace Microsoft.App;

interface Widgets {
  @doc("Fetch a Widget by name.")
  getWidget is ResourceRead<Widget>;

  @doc("Gets status of a Widget operation.")
  getWidgetOperationStatus is GetResourceOperationStatus<Widget>;

  @doc("Creates or updates a Widget asynchronously.")
  @pollingOperation(Widgets.getWidgetOperationStatus)
  createOrUpdateWidget is LongRunningResourceCreateOrUpdate<Widget>;

  @doc("Delete a Widget asynchronously.")
  @pollingOperation(Widgets.getWidgetOperationStatus)
  deleteWidget is LongRunningResourceDelete<Widget>;

  @doc("List Widget resources")
  listWidgets is ResourceList<
    Widget,
    {
      parameters: StandardListQueryParameters;
    }
  >;
}
