// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "./models/feedback.tsp";
import "./models/installation.tsp";
import "./models/notification.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using NotificationHubs.Models;

@doc("The Azure Notification Hubs service")
@service({
  title: "Azure Notification Hubs Service",
  version: "2020-06"
})
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
@server("https://{namespaceName}.servicebus.windows.net/{hubName}", "Notification Hubs Namespace", {
  @doc("Notification Hubs Namespace")
  namespaceName?: string,
  @doc("Notification Hub Name")
  hubName?: string,
})

namespace NotificationHubs;

@doc("Azure Notification Hubs registration installation operations")
@route("/installations")
interface Installations {
  @doc("Get an installation by ID")
  @summary("Gets an Azure Notification Hubs installation by Installation ID.")
  op getInstallation is Azure.Core.ResourceRead<Installation>;

  @doc("Delete an installation by ID")
  op deleteInstallation is Azure.Core.ResourceDelete<Installation>;

  @doc("Creates or updates an Installation")
  @summary("Creates or overwrites an existing installation in the Notification Hub.")
  op createOrUpdateInstallation is Azure.Core.ResourceCreateOrReplace<Installation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not conform to standard operations."
  @doc("Update an Azure Notification Hubs installation using JSON Patch semantics")
  @patch
  op updateInstallation(
    ...InstallationPatchRequest
  ): NotificationResponse;
}

@doc("Azure Notification Hubs message operations")
@route("/messages")
interface Notifications {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not conform to standard operations."
  @doc("Send a notification using Azure Notification Hubs")
  @post
  op sendNotification(
    ...NotificationSendRequest
    ): NotificationResponse;
}

@doc("Azure Notification Hubs scheduled send operations")
@route("/schedulednotifications")
interface ScheduledNotifications {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not conform to standard operations."
  @doc("Cancel a scheduled notification")
  @delete
  op cancelNotification(
    ...CancelScheduledNotificationRequest
  ): NotificationResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not conform to standard operations."
  @doc("Schedule a notification")
  @post
  op scheduleNotification(
    ...ScheduledNotificationSendRequest
  ): NotificationResponse;
}

@doc("Azure Notification Hubs PNS Feedback Operations")
@route("/feedbackcontainer")
interface Feedback {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "No keys required for this operation."
  @doc("Get the feedback for a notification hub")
  @get
  op getFeedbackContainerUrl(): FeedbackContainerResponse;
}