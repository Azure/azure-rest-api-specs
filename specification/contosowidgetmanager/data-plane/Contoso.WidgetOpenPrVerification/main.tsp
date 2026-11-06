import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

/** A disposable Widget service for OPEN-PR-VERIFICATION-17024. */
@service(#{ title: "Contoso Widget Open PR Verification" })
@server("{endpoint}", "Widget verification endpoint.", {
  /** The endpoint of the disposable Widget verification service. */
  endpoint: url,
})
@useAuth(AadOauth2Auth<["https://contoso.azure.com/.default"]>)
@versioned(Azure.Contoso.WidgetOpenPrVerification.Versions)
namespace Azure.Contoso.WidgetOpenPrVerification;

/** The existing sample API versions, retained for this disposable test. */
enum Versions {
  /** The 2022-11-01-preview sample API version. */
  v2022_11_01_Preview: "2022-11-01-preview",

  /** The 2022-12-01 sample API version. */
  v2022_12_01: "2022-12-01",
}

/** A widget. OPEN-PR-VERIFICATION-17024 proves this output came from the open spec PR. */
@resource("widgets")
model WidgetSuite {
  /** The widget name. */
  @key("widgetName")
  @visibility(Lifecycle.Read)
  name: string;

  /** The ID of the widget's manufacturer. */
  manufacturerId: string;

  /** The shared sample model. */
  sharedModel?: FakedSharedModel;
}

/** The shared model shape from the existing Widget sample. */
model FakedSharedModel {
  /** The tag. */
  tag: string;

  /** The creation time in UTC. */
  createdAt: utcDateTime;
}

/** Operations on the disposable Widget resources. */
interface Widgets {
  /** Fetches a Widget by name. */
  getWidget is ResourceRead<WidgetSuite>;

  /** Gets the status of a Widget operation. */
  getWidgetOperationStatus is GetResourceOperationStatus<WidgetSuite>;

  /** Creates or updates a Widget asynchronously. */
  @pollingOperation(Widgets.getWidgetOperationStatus)
  createOrUpdateWidget is StandardResourceOperations.LongRunningResourceCreateOrUpdate<WidgetSuite>;

  /** Deletes a Widget asynchronously. */
  @pollingOperation(Widgets.getWidgetOperationStatus)
  deleteWidget is LongRunningResourceDelete<WidgetSuite>;

  /** Lists Widget resources. */
  listWidgets is ResourceList<WidgetSuite, { parameters: StandardListQueryParameters }>;
}
