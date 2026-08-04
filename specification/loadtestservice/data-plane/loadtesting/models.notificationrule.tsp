import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.LoadTestService;

@added(APIVersions.v2024_12_01_preview)
@doc("Scope type of a notification rule.")
union NotificationScopeType {
  string,

  @doc("Notification rule is for Tests.")
  Tests: "Tests",
}

@added(APIVersions.v2024_12_01_preview)
@doc("Notification event type.")
union NotificationEventType {
  string,

  @doc("Test run ended event. This event would occur when a test run reaches terminal state.")
  TestRunEnded: "TestRunEnded",

  @doc("Test run started event. This event would occur when a new test run is triggered.")
  TestRunStarted: "TestRunStarted",

  @doc("Trigger completed event. This event would occur when a trigger completes.")
  TriggerCompleted: "TriggerCompleted",

  @doc("Trigger disabled event. This event would occur when a trigger is disabled.")
  TriggerDisabled: "TriggerDisabled",
}

@added(APIVersions.v2024_12_01_preview)
@discriminator("kind")
@doc("The notification event filter for Tests scope.")
model TestsNotificationEventFilter {
  @doc("The event type")
  kind: NotificationEventType;
}

@added(APIVersions.v2024_12_01_preview)
@doc("The notification event filter when the event type is TestRunEnded and scope is Tests.")
model TestRunEndedNotificationEventFilter extends TestsNotificationEventFilter {
  @doc("Event type for test run ended event.")
  kind: NotificationEventType.TestRunEnded;

  @doc("Event filtering condition.")
  condition?: TestRunEndedEventCondition;
}

@added(APIVersions.v2024_12_01_preview)
@doc("The notification event filter when the event type is TestRunStarted and scope is Tests.")
model TestRunStartedNotificationEventFilter
  extends TestsNotificationEventFilter {
  @doc("Event type for test run started event.")
  kind: NotificationEventType.TestRunStarted;
}

@added(APIVersions.v2024_12_01_preview)
@doc("The notification event filter when the event type is TriggerCompleted.")
model TriggerCompletedNotificationEventFilter
  extends TestsNotificationEventFilter {
  @doc("Event type for trigger ended event.")
  kind: NotificationEventType.TriggerCompleted;
}

@added(APIVersions.v2024_12_01_preview)
@doc("The notification event filter when the event type is TriggerDisabled.")
model TriggerDisabledNotificationEventFilter
  extends TestsNotificationEventFilter {
  @doc("Event type for trigger disabled event.")
  kind: NotificationEventType.TriggerDisabled;
}

@added(APIVersions.v2024_12_01_preview)
@doc("TestRunEnded Event condition.")
model TestRunEndedEventCondition {
  @doc("The test run statuses to send notification for.")
  testRunStatuses?: TestRunStatus[];

  @doc("The test run results to send notification for.")
  testRunResults?: PassFailTestResult[];
}

@added(APIVersions.v2024_12_01_preview)
@resource("notification-rules")
@discriminator("scope")
@doc("Notification rule model.")
model NotificationRule {
  @key
  @maxLength(50)
  @minLength(2)
  @pattern("^[a-z0-9_-]*$")
  @doc("The unique identifier of the notification rule.")
  @visibility(Lifecycle.Read)
  notificationRuleId: string;

  @maxLength(50)
  @minLength(2)
  @doc("The name of the notification rule.")
  displayName: string;

  @doc("The action groups to notify.")
  actionGroupIds: string[];

  @doc("The scope of the notification rule.")
  scope: NotificationScopeType;

  ...SystemMetaData;
}

@added(APIVersions.v2024_12_01_preview)
@doc("Tests Notification rule model.")
model TestsNotificationRule extends NotificationRule {
  @doc("Scope of type Tests.")
  scope: NotificationScopeType.Tests;

  @doc("The test ids to include. If not provided, notification will be sent for all testIds.")
  testIds?: string[];

  @doc("""
    The event to receive notifications for along with filtering conditions.
    Key is a user-assigned identifier for the event filter.
    """)
  eventFilters: Record<TestsNotificationEventFilter>;
}

@added(APIVersions.v2024_12_01_preview)
@doc("Parameters for list notification rule operation.")
model ListNotificationRuleQueryParams {
  @doc("Search based on notification rules associated with the provided test ids.")
  @query
  testIds?: string;

  @doc("Search based on notification rules for the provided scopes.")
  @query
  scopes?: string;

  @doc("""
    Start DateTime(RFC 3339 literal format) of the last updated time range to filter notification rules.
    """)
  @query
  lastModifiedStartTime?: utcDateTime;

  @doc("""
    End DateTime(RFC 3339 literal format) of the last updated time range to filter notification rules.
    """)
  @query
  lastModifiedEndTime?: utcDateTime;

  @doc("Number of results in response. Default page size is 50.")
  @query
  maxpagesize?: int32 = 50;
}
