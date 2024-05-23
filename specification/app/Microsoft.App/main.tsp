import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.contoso.com/common/oauth2/v2.0/authorize",
      scopes: ["https://widget.contoso.com/.default"],
    }
  ]>
)
@service({
  title: "Microsoft.App service",
})
@versioned(Microsoft.App.Versions)
namespace Microsoft.App;

@doc("The Microsoft.App service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2022-11-01-preview version of the Microsoft.App service.")
  `2022-11-01-preview`,
}

// @doc("A widget.")
// @resource("widgets")
// model Widget {
//   @key("widgetName")
//   @doc("The widget name.")
//   @visibility("read")
//   name: string;

//   @doc("The ID of the manufacturer.")
//   manufacturerId: string;

//   @doc("The faked shared model.")
//   sharedModel?: FakedSharedModel;
// }

// @doc("Faked shared model")
// model FakedSharedModel {
//   @doc("The tag.")
//   tag: string;

//   @doc("The created date.")
//   createdDate: utcDateTime;
// }

// interface Widgets {
//   @doc("Fetch a Widget by name.")
//   getWidget is ResourceRead<Widget>;

//   @doc("Gets status of a Widget operation.")
//   getWidgetOperationStatus is GetResourceOperationStatus<Widget>;

//   @doc("Creates or updates a Widget asynchronously.")
//   @pollingOperation(Widgets.getWidgetOperationStatus)
//   createOrUpdateWidget is LongRunningResourceCreateOrUpdate<Widget>;

//   @doc("Delete a Widget asynchronously.")
//   @pollingOperation(Widgets.getWidgetOperationStatus)
//   deleteWidget is LongRunningResourceDelete<Widget>;

//   @doc("List Widget resources")
//   listWidgets is ResourceList<
//     Widget,
//     {
//       parameters: StandardListQueryParameters;
//     }
//   >;
// }
