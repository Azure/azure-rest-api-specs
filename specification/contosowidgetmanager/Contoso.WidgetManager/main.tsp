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
@service({
  title: "Contoso Widget Manager",
})
@useDependency(Azure.Core.Versions.v1_0_Preview_1)
namespace Azure.Contoso.WidgetManager;

@doc("A widget.")
@resource("widgets")
model WidgetResponse {
  @key("widgetName")
  @doc("The widget name.")
  @visibility("read")
  name: string;

  @doc("The ID of the widget's manufacturer.")
  manufacturerId: string;

  @doc("The faked shared model.")
  sharedModel?: FakedSharedModel;
}

@resource("widgets")
model CreateWidgetRequest {
  @key("widgetName")
  @doc("The widget name.")
  name: string;

  @doc("The ID of the widget's manufacturer.")
  manufacturerId: string;

  @doc("The faked shared model.")
  sharedModel?: FakedSharedModel;
}

@doc("Fetch a Widget by name.")
op getWidget is ResourceRead<WidgetResponse>;

@doc("Gets status of a Widget operation.")
op getWidgetOperationStatus is GetResourceOperationStatus<WidgetResponse>;

@doc("Creates or updates a Widget asynchronously.")
@pollingOperation(getWidgetOperationStatus)
op newWidget is LongRunningResourceCreateOrUpdate<CreateWidgetRequest>;

@doc("Delete a Widget asynchronously.")
@pollingOperation(getWidgetOperationStatus)
op eraseWidget is LongRunningResourceDelete<WidgetResponse>;

@doc("List Widget resources")
op retrieveAllWidgets is ResourceList<
  WidgetResponse,
  {
    parameters: StandardListQueryParameters;
  }
>;