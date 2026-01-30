import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Notification title information")
@added(Versions.v2025_05_15_preview)
model NotificationTitle {
  @doc("The name of the notification")
  name: string;

  @doc("The description of the notification")
  description: string;
}

@doc("View source action detail")
@added(Versions.v2025_05_15_preview)
model ViewSourceActionDetail {
  @doc("The type of action")
  type: string;

  @doc("The target of the action")
  target: string;
}

@doc("View source action")
@added(Versions.v2025_05_15_preview)
model ViewSourceAction {
  @doc("The ID of the action")
  id: string;

  @doc("The display name of the action")
  displayName: string;

  @doc("The description of the action")
  description: string;

  @doc("The action details")
  action: ViewSourceActionDetail;
}

@doc("Foundry notification definition")
@resource("notifications")
@added(Versions.v2025_05_15_preview)
model FoundryNotificationDto {
  @doc("NGNC version")
  ngncVersion: string;

  @doc("The time of the notification")
  time?: utcDateTime;

  @doc("The notification title")
  title: NotificationTitle;

  @doc("The unique identifier of the notification")
  @visibility(Lifecycle.Read)
  @key("id")
  id: string;

  @doc("The subscription ID")
  subscriptionId: string;

  @doc("The foundry resource name")
  foundryResourceName: string;

  @doc("The scope of the notification")
  scope: string;

  @doc("The source of the notification")
  source: string;

  @doc("The type of the notification")
  type: string;

  @doc("The data schema")
  dataschema: string;

  @doc("The severity of the notification")
  severity: string;

  @doc("The status of the notification")
  status: string;

  @doc("The view source action")
  viewSource: ViewSourceAction;

  @doc("Additional data for the notification")
  data?: {};

  @doc("Quick actions for the notification")
  quickActions?: {};

  @doc("Additional properties")
  additionalProperties?: Record<{}>;
}
