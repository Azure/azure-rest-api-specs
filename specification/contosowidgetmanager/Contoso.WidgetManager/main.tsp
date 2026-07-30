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
#suppress "@azure-tools/typespec-azure-core/no-enum" "test: checked rule suppression with justification for workflow validation"
enum Versions {
  @doc("The 2022-11-01-preview version.")
  v2022_11_01_Preview: "2022-11-01-preview",

  @doc("The 2022-12-01 version.")
  v2022_12_01: "2022-12-01",
}

@doc("A widget.")
@resource("widgets")
#suppress "@azure-tools/typespec-azure-core/casing-style" "test: unchecked rule suppression with justification (not in check-rules.json)"
model WidgetSuite {
  @key("widgetName")
  @doc("The widget name.")
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "test: checked rule suppression with justification for workflow validation"
  @visibility(Lifecycle.Read)
  name: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "test: checked rule suppression with justification for workflow validation"
  @doc("The ID of the widget's manufacturer.")
  manufacturerId: string;

  #suppress "@azure-tools/typespec-azure-core/use-extensible-enum"
  @doc("The faked shared model.")
  sharedModel?: FakedSharedModel;
}

interface Widgets {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "test: checked rule suppression with justification for workflow validation"
  @doc("Fetch a Widget by name.")
  getWidget is ResourceRead<WidgetSuite>;

  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "test: checked rule suppression with justification for workflow validation"
  @doc("Gets status of a Widget operation.")
  getWidgetOperationStatus is GetResourceOperationStatus<WidgetSuite>;

  #suppress "@azure-tools/typespec-azure-core/no-error-status-codes" "test: checked rule suppression with justification for workflow validation"
  @doc("Creates or updates a Widget asynchronously.")
  @pollingOperation(Widgets.getWidgetOperationStatus)
  createOrUpdateWidget is StandardResourceOperations.LongRunningResourceCreateOrUpdate<WidgetSuite>;

  #suppress "@azure-tools/typespec-azure-core/require-versioned" "test: checked rule suppression with justification for workflow validation"
  @doc("Delete a Widget asynchronously.")
  @pollingOperation(Widgets.getWidgetOperationStatus)
  deleteWidget is LongRunningResourceDelete<WidgetSuite>;

  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "test: checked rule suppression with justification for workflow validation"
  @doc("List Widget resources")
  listWidgets is ResourceList<
    WidgetSuite,
    {
      parameters: StandardListQueryParameters;
    }
  >;
}
