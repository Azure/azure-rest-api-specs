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
    renewLocks is renewCloudEventLocks;
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
    renewLocks is renewCloudEventLocks;
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
    renewLocks is renewCloudEventLocks;
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

//Operation Access Level
@@access(publishCloudEvent, Access.internal, "python");
@@access(publishCloudEvent, Access.internal, "csharp");
@@access(publishCloudEvent, Access.internal, "java");
@@access(publishCloudEvent, Access.internal, "javascript");

@@access(publishCloudEvents, Access.internal, "python");
@@access(publishCloudEvents, Access.internal, "csharp");
@@access(publishCloudEvents, Access.internal, "java");
@@access(publishCloudEvents, Access.internal, "javascript");

@@access(receiveCloudEvents, Access.internal, "python");
@@access(acknowledgeCloudEvents, Access.internal, "python");
@@access(releaseCloudEvents, Access.internal, "python");
@@access(rejectCloudEvents, Access.internal, "python");
@@access(renewCloudEventLocks, Access.internal, "python");

@@access(receiveCloudEvents, Access.internal, "csharp");
@@access(acknowledgeCloudEvents, Access.internal, "csharp");
@@access(releaseCloudEvents, Access.internal, "csharp");
@@access(rejectCloudEvents, Access.internal, "csharp");
@@access(renewCloudEventLocks, Access.internal, "csharp");

@@access(receiveCloudEvents, Access.internal, "java");
@@access(acknowledgeCloudEvents, Access.internal, "java");
@@access(releaseCloudEvents, Access.internal, "java");
@@access(rejectCloudEvents, Access.internal, "java");
@@access(renewCloudEventLocks, Access.internal, "java");

@@access(receiveCloudEvents, Access.internal, "javascript");
@@access(acknowledgeCloudEvents, Access.internal, "javascript");
@@access(releaseCloudEvents, Access.internal, "javascript");
@@access(rejectCloudEvents, Access.internal, "javascript");
@@access(renewCloudEventLocks, Access.internal, "javascript");

//Mark models as public (except ReceiveResult, which is made public through customization in languages other than Java.)
//BUG: Bypassing Go for now as it marks all models as internal
@@access(AcknowledgeResult, Access.public);
@@access(ReceiveResult, Access.public, "java");
@@access(ReleaseResult, Access.public);
@@access(RejectResult, Access.public);
@@access(RenewCloudEventLocksResult, Access.public);
@@access(ReleaseDelay, Access.public);
@@access(FailedLockToken, Access.public);

//Rename Enum
@@clientName(ReleaseDelay.By0Seconds, "NoDelay");
@@clientName(ReleaseDelay.By10Seconds, "TenSeconds");
@@clientName(ReleaseDelay.By3600Seconds, "OneHour");
@@clientName(ReleaseDelay.By600Seconds, "TenMinutes");
@@clientName(ReleaseDelay.By60Seconds, "OneMinute");

//Rename RenewLocksResult
@@clientName(RenewCloudEventLocksResult, "RenewLocksResult");

//Rename value to details (ReceiveResult internal)
@@clientName(ReceiveResult.value, "details");
