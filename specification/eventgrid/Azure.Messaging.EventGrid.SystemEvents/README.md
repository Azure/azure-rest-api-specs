# EventGrid Typespec Guide

## Guidelines for defining a new event in Typespec

 **_NOTE:_** New events must not be delivered to Event Grid production endpoints until the events have been reviewed with the Azure SDK Architecture board and the PR is merged into main. Once the PR is merged to main, the events are considered GA regardless of whether docs list them as being in preview. This is because customers cannot control which version of events they consume - it is entirely up to the service publishing the events. Any breaking changes to events would need to be implemented as a new event type. Full details can be found in the [Azure Breaking Changes Policy](http://aka.ms/AzBreakingChangesPolicy/), Section 4.

## Write in Typespec

Under the `Azure.Messaging.EventGrid.SystemEvents` folder find or create your service's `.tsp` file. This is where you will add your new event. For help with typespec conventions refer to [this doc](https://microsoft.github.io/typespec/) about typespec basics. Each new event will be represented as a typespec `model`. After you create your new event, in the `client.tsp` file, you need to add `@@usage(EventGrid.YourEventName, Usage.output | Usage.json)` and `@@access(EventGrid.YourEventName, Access.public)`.

#### Example Event


A sample valid event definition is shown below with `required` and `optional` properties:
~~~ markdown

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceived event. */
model AcsChatMessageReceivedEventData {
  ...AcsChatMessageEventBaseProperties;

  /** Required. Field is always present in the event. */
  requiredProperty : string;    

  /** Optional. Field may not be present in some events. */
  optionalProperty ?: string;

  /** Array properties must be decorated as read-only */
  @visibility(Lifecycle.Read)
  arrayProperty: string[]
}
~~~

Adding `@usage` and `@access` to `client.tsp`:
~~~ markdown

@@usage(EventGrid.AcsChatMessageReceivedEventData, Usage.output | Usage.json);
@@access(EventGrid.AcsChatMessageReceivedEventData, Access.public)
~~~

### Add Examples

Using the `@example` decorator in TypeSpec, add an example for your event. A sample valid example is show below:

~~~ typespec
const MicrosoftCachePatchingCompletedExample: RedisPatchingCompletedEventData = #{
  name: "PatchingCompleted",
  timestamp: utcDateTime.fromISO("2020-12-09T13:50:19.9995668-08:00"),
  status: "Succeeded",
  propertyList: #[],
  exampleIndicatorWrapping: #{
    `dash-value`: "myString";
    `https://something.com` : "myUrl"
  }

};

/** Schema of the Data property of an EventGridEvent for a Microsoft.Cache.PatchingCompleted event. */

@example(MicrosoftCachePatchingCompletedExample)
model RedisPatchingCompletedEventData {
  ...RedisBaseEventData;

  propertyList: string[];
  exampleIndicatorWrapping: Record<string>;
}
~~~

A few things to keep in mind when formatting a TypeSpec example:

1. As shown above, for scalar types such as `utcDateTime` you will need to wrap the value with the scalar constructor.
2. When defining a dictionary or an array you must preface it with a `#`.
3. For properties and keys that have a wording style that TypeSpec does not agree with, for example `iothub-encoding-value`, you can surround the key with ` indicators. 

More on `@example` can be found [here](https://typespec.io/docs/standard-library/examples/#define-typed-examples-using-const)

# For Service System Events PR Approval

1) Write your service's system events in TypeSpec.
1) Generate the swagger for your service's system events off of TypeSpec, following the steps below:
    - Install TypeSpec `npm install -g @typespec/compiler`
    - Install the emitter `npm install @azure-tools/typespec-autorest`
    - Under `/Azure.Messaging.EventGrid.SystemEvents/`:
        - Run `tsp compile .`
1) Verify the generated swaggers `/data-plane/Microsoft.EventGrid/2018-01-01/GeneratedSystemEvents.json` and `/data-plane/Microsoft.EventGrid/2024-01-01/GeneratedSystemEvents.json` accurately depicts your system events.
1) Copy the delta from `/data-plane/Microsoft.EventGrid/2018-01-01/GeneratedSystemEvents.json` into your resource provider-specific swagger, e.g. `data-plane/Microsoft.Communication/stable/2018-01-01/AzureCommunicationServices.json`. Make any manual adjustments as needed.
1) Final PR must contain the TypeSpec and the Swagger generated from the TypeSpec.