import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using Microsoft.EventGrid;

@TypeSpec.Versioning.useDependency(ServiceApiVersions.v2024_06_01)
namespace Customizations {
  @client(
    {
      name: "EventGridPublisherClient",
      service: Microsoft.EventGrid,
    },
    "python"
  )
  interface Client1 {
    send is publishCloudEvent;
    sendEvents is publishCloudEvents;
  }

  @client(
    {
      name: "EventGridConsumerClient",
      service: Microsoft.EventGrid,
    },
    "python"
  )
  interface Client2 {
    receive is receiveCloudEvents;
    acknowledge is acknowledgeCloudEvents;
    release is releaseCloudEvents;
    reject is rejectCloudEvents;
    renewLock is renewCloudEventLocks;
  }

  @client(
    {
      name: "EventGridSenderClient",
      service: Microsoft.EventGrid,
    },
    "csharp"
  )
  interface ClientSender {
    send is publishCloudEvent;
    sendEvents is publishCloudEvents;
  }

  @client(
    {
      name: "EventGridReceiverClient",
      service: Microsoft.EventGrid,
    },
    "csharp"
  )
  interface ClientReceiver {
    receive is receiveCloudEvents;
    acknowledge is acknowledgeCloudEvents;
    release is releaseCloudEvents;
    reject is rejectCloudEvents;
    renewLock is renewCloudEventLocks;
  }

  @client(
    {
      name: "EventGridSenderClient",
      service: Microsoft.EventGrid,
    },
    "java"
  )
  interface ClientSender2 {
    send is publishCloudEvent;
    sendEvents is publishCloudEvents;
  }

  @client(
    {
      name: "EventGridReceiverClient",
      service: Microsoft.EventGrid,
    },
    "java"
  )
  interface ClientReceiver2 {
    receive is receiveCloudEvents;
    acknowledge is acknowledgeCloudEvents;
    release is releaseCloudEvents;
    reject is rejectCloudEvents;
    renewLock is renewCloudEventLocks;
  }

  @client(
    {
      name: "SenderClient",
      service: Microsoft.EventGrid,
    },
    "go"
  )
  interface ClientSenderGo {
    sendEvent is publishCloudEvent;
    sendEvents is publishCloudEvents;
  }

  @client(
    {
      name: "ReceiverClient",
      service: Microsoft.EventGrid,
    },
    "go"
  )
  interface ClientReceiverGo {
    receiveEvents is receiveCloudEvents;
    acknowledgeEvents is acknowledgeCloudEvents;
    releaseEvents is releaseCloudEvents;
    rejectEvents is rejectCloudEvents;
    renewEventLocks is renewCloudEventLocks;
  }
}

// All Language customizations

// publishCloudEvent access level
@@access(publishCloudEvent, Access.public, "go"); // making public for Go, it's a simpler fix on the backend than generating it as internal
@@access(publishCloudEvent, Access.internal);

// publishCloudEvents access level
@@access(publishCloudEvents, Access.public, "go"); // making public for Go, it's a simpler fix on the backend than generating it as internal
@@access(publishCloudEvents, Access.internal);

@@access(receiveCloudEvents, Access.internal, "python");
@@access(acknowledgeCloudEvents, Access.internal, "python");
@@access(releaseCloudEvents, Access.internal, "python");
@@access(rejectCloudEvents, Access.internal, "python");
@@access(renewCloudEventLocks, Access.internal, "python");

@@access(AcknowledgeResult, Access.public);
@@access(ReleaseResult, Access.public);
@@access(RejectResult, Access.public);
@@access(RenewCloudEventLocksResult, Access.public);
@@access(ReleaseDelay, Access.public);
@@access(FailedLockToken, Access.public);

@@clientName(ReleaseDelay.By0Seconds, "NoDelay");
@@clientName(ReleaseDelay.By10Seconds, "TenSeconds");
@@clientName(ReleaseDelay.By3600Seconds, "OneHour");
@@clientName(ReleaseDelay.By600Seconds, "TenMinutes");
@@clientName(ReleaseDelay.By60Seconds, "OneMinute");

@@clientName(RenewCloudEventLocksResult, "RenewLocksResult");

@@clientName(ReceiveResult.value, "details");
