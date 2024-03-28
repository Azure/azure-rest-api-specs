# EventGrid Typespec Guide

## Guidelines for defining a new event in Typespec

 **_NOTE:_** New events must not be delivered to Event Grid production endpoints until the events have been reviewed with the Azure SDK Architecture board and the PR is merged into main. Once the PR is merged to main, the events are considered GA regardless of whether docs list them as being in preview. This is because customers cannot control which version of events they consume - it is entirely up to the service publishing the events. Any breaking changes to events would need to be implemented as a new event type. Full details can be found in the [Azure Breaking Changes Policy](http://aka.ms/AzBreakingChangesPolicy/), Section 4.

In order to automate the mapping of event definition with event type, please follow the guidelines below when adding new events to your typespec:
- The name of a new event definition should have `EventData` suffix. For e.g. `AcsChatMessageReceivedEventData`.
- The description of the new event should include the event type. This is the `eventType` name in an `EventGridEvent` or `type` name in `CloudEvent`. For e.g. `"Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceived event."` Here `Microsoft.Communication.ChatMessageReceived` is the event name. If your event is in preview, you may add the word preview: `"Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceived preview event."`
- Make sure to add add your service's SystemEvent CloudEvent Schema examples under `samples/stable/2024-01-01/YOUR_SERVICE_NAME/`.

### Write in Typespec

Under the `Azure.Messaging.EventGrid.SystemEvents` folder find or create your service's `.tsp` file. This is where you will add your new event. For help with typespec conventions refer to [this doc](https://microsoft.github.io/typespec/) about typespec basics. Each new event will be represented as a typespec `model`. After you create your new event, in the `client.tsp` file, you need to add `@@usage(EventGrid.YourEventName, Usage.output)` and `@@access(EventGrid.YourEventName, Access.public)`.

A sample valid event definition is shown below:
~~~ markdown

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceived event. */
model AcsChatMessageReceivedEventData {
  ...AcsChatMessageEventBaseProperties;

  /** The body of the chat message. */
  messageBody ?: string;
}
~~~

Adding `@usage` and `@access` to `client.tsp`:
~~~ markdown

@@usage(EventGrid.AcsChatMessageReceivedEventData, Usage.output);
@@access(EventGrid.AcsChatMessageReceivedEventData, Access.public)
~~~

# How To Run

Within Azure.Messaging.EventGrid.SystemEvents:


To generate the EventGrid SystemEvents from TypeSpec:

With `Azure.Messaging.EventGrid.SystemEvents` as your root directory:

    `tsp compile client.tsp --emit YOUR_EMITTER`

To generate the swagger file YOUR_EMITTER would be @azure-tools/typespec-autorest.