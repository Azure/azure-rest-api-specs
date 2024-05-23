import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using Microsoft.EventGrid;



@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
// NEED TO CHANGE THIS VERSION TO THE LATEST VERSION
@TypeSpec.Versioning.useDependency(ServiceApiVersions.v2024_06_01)
namespace Customizations{

    // Python specific customizations
    @client({ name: "EventGridPublisherClient", service: Microsoft.EventGrid}, "python")
    interface Client1 {
    send is publishCloudEvent;
    sendEvents is publishCloudEvents;
    }

    @client({
    name: "EventGridConsumerClient",
    service: Microsoft.EventGrid
    }, "python")
    interface Client2 {
    receive is receiveCloudEvents;
    acknowledge is acknowledgeCloudEvents;
    release is releaseCloudEvents;
    reject is rejectCloudEvents;
    renewLock is renewCloudEventLocks;
    }

    // Other Language specific customizations
    @client({ name: "EventGridSenderClient", service: Microsoft.EventGrid}, "csharp")
    interface ClientSender {
    send is publishCloudEvent;
    sendEvents is publishCloudEvents;
    }

    @client({
    name: "EventGridReceiverClient",
    service: Microsoft.EventGrid
    }, "csharp")
    interface ClientReceiver {
    receive is receiveCloudEvents;
    acknowledge is acknowledgeCloudEvents;
    release is releaseCloudEvents;
    reject is rejectCloudEvents;
    renewLock is renewCloudEventLocks;
    }

    @client({ name: "EventGridSenderClient", service: Microsoft.EventGrid}, "js")
    interface ClientSender1 {
    send is publishCloudEvent;
    sendEvents is publishCloudEvents;
    }

    @client({
    name: "EventGridReceiverClient",
    service: Microsoft.EventGrid
    }, "js")
    interface ClientReceiver1 {
    receive is receiveCloudEvents;
    acknowledge is acknowledgeCloudEvents;
    release is releaseCloudEvents;
    reject is rejectCloudEvents;
    renewLock is renewCloudEventLocks;
    }

    @client({ name: "EventGridSenderClient", service: Microsoft.EventGrid}, "java")
    interface ClientSender2 {
    send is publishCloudEvent;
    sendEvents is publishCloudEvents;
    }

    @client({
    name: "EventGridReceiverClient",
    service: Microsoft.EventGrid
    }, "java")
    interface ClientReceiver2 {
    receive is receiveCloudEvents;
    acknowledge is acknowledgeCloudEvents;
    release is releaseCloudEvents;
    reject is rejectCloudEvents;
    renewLock is renewCloudEventLocks;
    }

    @client({ name: "SenderClient", service: Microsoft.EventGrid}, "go")
    interface ClientSender3 {
    send is publishCloudEvent;
    sendEvents is publishCloudEvents;
    }

    @client({
    name: "ReceiverClient",
    service: Microsoft.EventGrid
    }, "go")
    interface ClientReceiver3 {
    receive is receiveCloudEvents;
    acknowledge is acknowledgeCloudEvents;
    release is releaseCloudEvents;
    reject is rejectCloudEvents;
    renewLock is renewCloudEventLocks;
    }

}

// All Language customizations
@@access(publishCloudEvent, Access.internal);
@@access(publishCloudEvents, Access.internal);
@@access(receiveCloudEvents, Access.internal);

@@access(acknowledgeCloudEvents, Access.internal);
@@access(releaseCloudEvents, Access.internal);
@@access(rejectCloudEvents, Access.internal);
@@access(renewCloudEventLocks, Access.internal);

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