import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme" "SharedAccessKey is not supported by typespec-autorest"
@useAuth(
  {
    type: AuthType.http,
    scheme: "SharedAccessKey",
  } | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://eventgrid.azure.net/.default"],
    }
  ]>
)
@service(#{ title: "Azure.Messaging.EventGridClient" })

//
// Supported operations.
//
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}:publish?api-version={apiVersion}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:receive?api-Version={apiVersion}&maxWaitTime=60&maxEvents={maxEvents}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:acknowledge?api-Version={apiVersion}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:release?api-version={apiVersion}&releaseDelayInSeconds={delay}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:reject?api-version={apiVersion}
@server(
  "{endpoint}",
  "The host name of the namespace",
  {
    @doc("The host name of the namespace, e.g. namespaceName1.westus-1.eventgrid.azure.net")
    endpoint: url,
  }
)
@doc("Azure Messaging EventGrid Client")
@versioned(ServiceApiVersions)
namespace Microsoft.EventGrid {
  using TypeSpec.Http;
  using TypeSpec.Rest;
  using TypeSpec.Versioning;
  using Azure.Core;
  using Azure.Core.Foundations;
  using Azure;

  enum ServiceApiVersions {
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    v2023_11_01: "2023-11-01",

    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    v2024_06_01: "2024-06-01",
  }

  alias StandardOperations = Azure.Core.StandardResourceOperations;

  @doc("Properties of an event published to an Azure Messaging EventGrid Namespace topic using the CloudEvent 1.0 Schema.")
  model CloudEvent {
    @doc("An identifier for the event. The combination of id and source must be unique for each distinct event.")
    id: string;

    @doc("Identifies the context in which an event happened. The combination of id and source must be unique for each distinct event.")
    source: string;

    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Using 'unknown' for data is intentional. Following CloudEvent spec."
    @doc("Event data specific to the event type.")
    data?: unknown;

    #suppress "@azure-tools/typespec-azure-core/casing-style" "Using 'data_base64' is intentional. Following CloudEvent spec."
    @doc("Event data specific to the event type, encoded as a base64 string.")
    data_base64?: bytes;

    @doc("Type of event related to the originating occurrence.")
    type: string;

    @doc("The time (in UTC) the event was generated, in RFC3339 format.")
    time?: utcDateTime;

    @doc("The version of the CloudEvents specification which the event uses.")
    specversion: string;

    @doc("Identifies the schema that data adheres to.")
    dataschema?: string;

    @doc("Content type of data value.")
    datacontenttype?: string;

    @doc("This describes the subject of the event in the context of the event producer (identified by source).")
    subject?: string;
  }

  @doc("Properties of the Event Broker operation.")
  model BrokerProperties {
    @doc("The token of the lock on the event.")
    lockToken: string;

    @doc("The attempt count for delivering the event.")
    deliveryCount: int32;
  }

  @doc("Receive operation details per Cloud Event.")
  model ReceiveDetails {
    @doc("The Event Broker details.")
    brokerProperties: BrokerProperties;

    @doc("Cloud Event details.")
    event: CloudEvent;
  }

  @doc("Details of the Receive operation response.")
  model ReceiveResult {
    @doc("Array of receive responses, one per cloud event.")
    value: ReceiveDetails[];
  }

  @doc("Failed LockToken information.")
  model FailedLockToken {
    @doc("The lock token of an entry in the request.")
    lockToken: string;

    @doc("Error information of the failed operation result for the lock token in the request.")
    error: Azure.Core.Foundations.Error;
  }

  @doc("Supported delays for release operation.")
  union ReleaseDelay {
    string,

    @doc("Release the event after 0 seconds.")
    By0Seconds: "0",

    @doc("Release the event after 10 seconds.")
    By10Seconds: "10",

    @doc("Release the event after 60 seconds.")
    By60Seconds: "60",

    @doc("Release the event after 600 seconds.")
    By600Seconds: "600",

    @doc("Release the event after 3600 seconds.")
    By3600Seconds: "3600",
  }

  @doc("The result of the Publish operation.")
  model PublishResult {}

  @doc("The result of the Acknowledge operation.")
  model AcknowledgeResult {
    @doc("Array of FailedLockToken for failed cloud events. Each FailedLockToken includes the lock token along with the related error information (namely, the error code and description).")
    failedLockTokens: FailedLockToken[];

    @doc("Array of lock tokens for the successfully acknowledged cloud events.")
    succeededLockTokens: string[];
  }

  @doc("The result of the Release operation.")
  model ReleaseResult {
    @doc("Array of FailedLockToken for failed cloud events. Each FailedLockToken includes the lock token along with the related error information (namely, the error code and description).")
    failedLockTokens: FailedLockToken[];

    @doc("Array of lock tokens for the successfully released cloud events.")
    succeededLockTokens: string[];
  }

  @doc("The result of the Reject operation.")
  model RejectResult {
    @doc("Array of FailedLockToken for failed cloud events. Each FailedLockToken includes the lock token along with the related error information (namely, the error code and description).")
    failedLockTokens: FailedLockToken[];

    @doc("Array of lock tokens for the successfully rejected cloud events.")
    succeededLockTokens: string[];
  }

  @doc("The result of the RenewLock operation.")
  model RenewCloudEventLocksResult {
    @doc("Array of FailedLockToken for failed cloud events. Each FailedLockToken includes the lock token along with the related error information (namely, the error code and description).")
    failedLockTokens: FailedLockToken[];

    @doc("Array of lock tokens for the successfully renewed locks.")
    succeededLockTokens: string[];
  }

  alias ReleaseOptions = {
    @doc("Array of lock tokens.")
    lockTokens: string[];
  };

  alias AcknowledgeOptions = {
    @doc("Array of lock tokens.")
    lockTokens: string[];
  };

  alias RejectOptions = {
    @doc("Array of lock tokens.")
    lockTokens: string[];
  };

  alias RenewLockOptions = {
    @doc("Array of lock tokens.")
    lockTokens: string[];
  };

  @doc("Topic Resource.")
  @resource("topics")
  model Topic {
    @key
    @doc("Topic Name.")
    @visibility(Lifecycle.Read)
    topicName: string;
  }

  @doc("Event Subscription Resource.")
  @resource("eventsubscriptions")
  @parentResource(Topic)
  model EventSubscription {
    @key
    @doc("Event Subscription Name.")
    @visibility(Lifecycle.Read)
    eventSubscriptionName: string;
  }

  // Publish Operation:
  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}:publish?api-version={apiVersion}}

  @doc("Publish a single Cloud Event to a namespace topic.")
  @sharedRoute
  @action("publish")
  op publishCloudEvent is StandardOperations.ResourceAction<
    Topic,
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/cloudevents+json; charset=utf-8";

      @doc("Single Cloud Event being published.")
      @bodyRoot
      event: CloudEvent;
    },
    {
      @bodyRoot _: PublishResult;
    }
  >;

  @doc("Publish a batch of Cloud Events to a namespace topic.")
  @sharedRoute
  @action("publish")
  op publishCloudEvents is StandardOperations.ResourceAction<
    Topic,
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/cloudevents-batch+json; charset=utf-8";

      #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Not using a container model for CloudEvent is intentional. Went through Stewardship Board review (#21880)."
      @doc("Array of Cloud Events being published.")
      @bodyRoot
      events: CloudEvent[];
    },
    {
      @bodyRoot _: PublishResult;
    }
  >;

  // Receive Operation:
  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:receive?api-Version={apiVersion}&maxWaitTime=60&maxEvents={maxEvents}

  @doc("Receive a batch of Cloud Events from a subscription.")
  @action("receive")
  op receiveCloudEvents is StandardOperations.ResourceAction<
    EventSubscription,
    {
      @doc("Max Events count to be received. Minimum value is 1, while maximum value is 100 events. If not specified, the default value is 1.")
      @query
      @minValue(1)
      @maxValue(100)
      maxEvents?: int32 = 1;

      @doc("Max wait time value for receive operation in Seconds. It is the time in seconds that the server approximately waits for the availability of an event and responds to the request. If an event is available, the broker responds immediately to the client. Minimum value is 10 seconds, while maximum value is 120 seconds. If not specified, the default value is 60 seconds.")
      @encode("seconds", int32)
      @query
      maxWaitTime?: duration;
    },
    ReceiveResult
  >;

  // Acknowledge Operation:
  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:acknowledge&apiVersion={apiVersion}

  @doc("Acknowledge a batch of Cloud Events. The response will include the set of successfully acknowledged lock tokens, along with other failed lock tokens with their corresponding error information. Successfully acknowledged events will no longer be available to be received by any consumer.")
  @action("acknowledge")
  op acknowledgeCloudEvents is StandardOperations.ResourceAction<
    EventSubscription,
    {
      ...AcknowledgeOptions;
    },
    AcknowledgeResult
  >;

  // Release Operation:
  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:release?api-version={apiVersion}&releaseDelayInSeconds={delay}

  @doc("Release a batch of Cloud Events. The response will include the set of successfully released lock tokens, along with other failed lock tokens with their corresponding error information. Successfully released events can be received by consumers.")
  @action("release")
  op releaseCloudEvents is StandardOperations.ResourceAction<
    EventSubscription,
    {
      ...ReleaseOptions;

      @added(ServiceApiVersions.v2024_06_01)
      @doc("Release cloud events with the specified delay in seconds.")
      @query
      releaseDelayInSeconds?: ReleaseDelay;
    },
    ReleaseResult
  >;

  // Reject Operation:
  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:reject?api-version={apiVersion}

  @doc("Reject a batch of Cloud Events. The response will include the set of successfully rejected lock tokens, along with other failed lock tokens with their corresponding error information. Successfully rejected events will be dead-lettered and can no longer be received by a consumer.")
  @action("reject")
  op rejectCloudEvents is StandardOperations.ResourceAction<
    EventSubscription,
    {
      ...RejectOptions;
    },
    RejectResult
  >;

  // RenewLock Operation:
  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:renewLock?api-version={apiVersion}
  @added(ServiceApiVersions.v2024_06_01)
  @doc("Renew locks for a batch of Cloud Events. The response will include the set of successfully renewed lock tokens, along with other failed lock tokens with their corresponding error information. Successfully renewed locks will ensure that the associated event is only available to the consumer that holds the renewed lock.")
  @action("renewLock")
  op renewCloudEventLocks is StandardOperations.ResourceAction<
    EventSubscription,
    {
      ...RenewLockOptions;
    },
    RenewCloudEventLocksResult
  >;
}
