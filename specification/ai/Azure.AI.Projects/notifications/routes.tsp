import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias NotificationServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias NotificationOperations = Azure.Core.ResourceOperations<NotificationServiceTraits>;

@doc("Sort order for notifications")
union SortOrder {
  @doc("Ascending order")
  asc: "asc",

  @doc("Descending order")
  desc: "desc",
}

@added(Versions.v2025_05_15_preview)
interface Notifications {
  @doc("List notifications of a specific project.")
  list is NotificationOperations.ResourceList<
    FoundryNotificationDto,
    ListQueryParametersTrait<{
      @doc("Whether dismissed notifications should be included")
      @query("includeDismissed")
      includeDismissed?: boolean;

      @doc("Only notifications with the given agentName will be returned")
      @query("agentName")
      agentName?: string;

      @doc("Only notifications with the given evaluator name will be returned")
      @query("evaluatorName")
      evaluatorName?: string;

      @doc("Top count of notifications. All notifications will be returned if not specified")
      @query("top")
      top?: int32;

      @doc("The expression evaluates to true are included in the response")
      @query("filter")
      filter?: string;

      @doc("The list of resource properties to use for sorting the requested resources")
      @query("orderby")
      orderby?: string[];

      @doc("Sort order")
      @query("sortorder")
      sortorder?: SortOrder;
    }>
  >;

  @doc("Dismiss all notifications of a specific project for a given user.")
  @TypeSpec.Http.post
  @Rest.actionSeparator("/")
  @Rest.action("dismiss")
  dismiss is NotificationOperations.ResourceCollectionAction<
    FoundryNotificationDto,
    {},
    OkResponse<{}>
  >;
}
