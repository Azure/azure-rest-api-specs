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

    @client({ name: "EventGridSenderClient", service: Microsoft.EventGrid}, "go")
    interface ClientSender3 {
    send is publishCloudEvent;
    sendEvents is publishCloudEvents;
    }

    @client({
    name: "EventGridReceiverClient",
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


// Python specific customizations
@@access(publishCloudEvent, Access.internal, "python");
@@access(publishCloudEvents, Access.internal, "python");
@@access(receiveCloudEvents, Access.internal, "python");

@@access(acknowledgeCloudEvents, Access.internal, "python");
@@access(releaseCloudEvents, Access.internal, "python");
@@access(rejectCloudEvents, Access.internal, "python");
@@access(renewCloudEventLocks, Access.internal, "python");

@@access(AcknowledgeOptions, Access.internal, "python");
@@access(ReleaseOptions, Access.internal, "python");
@@access(RejectOptions, Access.internal, "python");
@@access(RenewLockOptions, Access.internal, "python");

@@access(AcknowledgeResult, Access.public, "python");
@@access(ReleaseResult, Access.public, "python");
@@access(RejectResult, Access.public, "python");
@@access(RenewCloudEventLocksResult, Access.public, "python");
@@access(ReleaseDelay, Access.public, "python");
@@access(FailedLockToken, Access.public, "python");


// All Language customizations
@@clientName(ReleaseDelay.By0Seconds, "NoDelay");
@@clientName(ReleaseDelay.By10Seconds, "TenSeconds");
@@clientName(ReleaseDelay.By3600Seconds, "OneHour");
@@clientName(ReleaseDelay.By600Seconds, "TenMinutes");
@@clientName(ReleaseDelay.By60Seconds, "OneMinute");

@@clientName(RenewCloudEventLocksResult, "RenewLocksResult");

@@clientName(ReceiveResult.value, "details");