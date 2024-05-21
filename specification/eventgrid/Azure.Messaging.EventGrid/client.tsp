import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;




@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(Microsoft.EventGrid.ServiceApiVersions.v2023_10_01_preview)
namespace Customizations{

    // Python specific customizations
    @client({ name: "EventGridPublisherClient", service: Microsoft.EventGrid}, "python")
    interface Client1 {
    publishCloudEvent is Microsoft.EventGrid.publishCloudEvent;
    publishCloudEvents is Microsoft.EventGrid.publishCloudEvents;
    }

    @client({
    name: "EventGridConsumerClient",
    service: Microsoft.EventGrid
    }, "python")
    interface Client2 {
    receive is Microsoft.EventGrid.receiveCloudEvents;
    acknowledge is Microsoft.EventGrid.acknowledgeCloudEvents;
    release is Microsoft.EventGrid.releaseCloudEvents;
    reject is Microsoft.EventGrid.rejectCloudEvents;
    renewLock is Microsoft.EventGrid.renewCloudEventLocks;
    }

    // Other Language specific customizations
    @client({ name: "EventGridSenderClient", service: Microsoft.EventGrid}, "csharp")
    interface ClientSender {
    publishCloudEvent is Microsoft.EventGrid.publishCloudEvent;
    publishCloudEvents is Microsoft.EventGrid.publishCloudEvents;
    }

    @client({
    name: "EventGridReceiverClient",
    service: Microsoft.EventGrid
    }, "csharp")
    interface ClientReceiver {
    receive is Microsoft.EventGrid.receiveCloudEvents;
    acknowledge is Microsoft.EventGrid.acknowledgeCloudEvents;
    release is Microsoft.EventGrid.releaseCloudEvents;
    reject is Microsoft.EventGrid.rejectCloudEvents;
    renewLock is Microsoft.EventGrid.renewCloudEventLocks;
    }

    @client({ name: "EventGridSenderClient", service: Microsoft.EventGrid}, "js")
    interface ClientSender1 {
    publishCloudEvent is Microsoft.EventGrid.publishCloudEvent;
    publishCloudEvents is Microsoft.EventGrid.publishCloudEvents;
    }

    @client({
    name: "EventGridReceiverClient",
    service: Microsoft.EventGrid
    }, "js")
    interface ClientReceiver1 {
    receive is Microsoft.EventGrid.receiveCloudEvents;
    acknowledge is Microsoft.EventGrid.acknowledgeCloudEvents;
    release is Microsoft.EventGrid.releaseCloudEvents;
    reject is Microsoft.EventGrid.rejectCloudEvents;
    renewLock is Microsoft.EventGrid.renewCloudEventLocks;
    }

    @client({ name: "EventGridSenderClient", service: Microsoft.EventGrid}, "java")
    interface ClientSender2 {
    publishCloudEvent is Microsoft.EventGrid.publishCloudEvent;
    publishCloudEvents is Microsoft.EventGrid.publishCloudEvents;
    }

    @client({
    name: "EventGridReceiverClient",
    service: Microsoft.EventGrid
    }, "java")
    interface ClientReceiver2 {
    receive is Microsoft.EventGrid.receiveCloudEvents;
    acknowledge is Microsoft.EventGrid.acknowledgeCloudEvents;
    release is Microsoft.EventGrid.releaseCloudEvents;
    reject is Microsoft.EventGrid.rejectCloudEvents;
    renewLock is Microsoft.EventGrid.renewCloudEventLocks;
    }

    @client({ name: "EventGridSenderClient", service: Microsoft.EventGrid}, "go")
    interface ClientSender3 {
    publishCloudEvent is Microsoft.EventGrid.publishCloudEvent;
    publishCloudEvents is Microsoft.EventGrid.publishCloudEvents;
    }

    @client({
    name: "EventGridReceiverClient",
    service: Microsoft.EventGrid
    }, "go")
    interface ClientReceiver3 {
    receive is Microsoft.EventGrid.receiveCloudEvents;
    acknowledge is Microsoft.EventGrid.acknowledgeCloudEvents;
    release is Microsoft.EventGrid.releaseCloudEvents;
    reject is Microsoft.EventGrid.rejectCloudEvents;
    renewLock is Microsoft.EventGrid.renewCloudEventLocks;
    }

}



// Python specific customizations
@@access(Microsoft.EventGrid.publishCloudEvent, Access.internal, "python");
@@access(Microsoft.EventGrid.publishCloudEvents, Access.internal, "python");
@@access(Microsoft.EventGrid.receiveCloudEvents, Access.internal, "python");

@@access(Microsoft.EventGrid.acknowledgeCloudEvents, Access.internal, "python");
@@access(Microsoft.EventGrid.releaseCloudEvents, Access.internal, "python");
@@access(Microsoft.EventGrid.rejectCloudEvents, Access.internal, "python");
@@access(Microsoft.EventGrid.renewCloudEventLocks, Access.internal, "python");

@@access(Microsoft.EventGrid.AcknowledgeOptions, Access.internal, "python");
@@access(Microsoft.EventGrid.ReleaseOptions, Access.internal, "python");
@@access(Microsoft.EventGrid.RejectOptions, Access.internal, "python");
@@access(Microsoft.EventGrid.RenewLockOptions, Access.internal, "python");

@@access(Microsoft.EventGrid.AcknowledgeResult, Access.public, "python");
@@access(Microsoft.EventGrid.ReleaseResult, Access.public, "python");
@@access(Microsoft.EventGrid.RejectResult, Access.public, "python");
@@access(Microsoft.EventGrid.RenewCloudEventLocksResult, Access.public, "python");
@@access(Microsoft.EventGrid.ReleaseDelay, Access.public, "python");
@@access(Microsoft.EventGrid.FailedLockToken, Access.public, "python");
