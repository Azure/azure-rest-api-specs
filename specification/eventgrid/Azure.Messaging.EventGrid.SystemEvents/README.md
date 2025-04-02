# EventGrid Typespec Guide

## Guidelines for defining a new event in Typespec

 **_NOTE:_** New events must not be delivered to Event Grid production endpoints until the events have been reviewed with the Azure SDK Architecture board and the PR is merged into main. Once the PR is merged to main, the events are considered GA regardless of whether docs list them as being in preview. This is because customers cannot control which version of events they consume - it is entirely up to the service publishing the events. Any breaking changes to events would need to be implemented as a new event type. Full details can be found in the [Azure Breaking Changes Policy](http://aka.ms/AzBreakingChangesPolicy/), Section 4.

## Write in Typespec

Under the `Azure.Messaging.EventGrid.SystemEvents` folder find or create your service's `.tsp` file. This is where you will add your new event. For help with typespec conventions refer to [this doc](https://microsoft.github.io/typespec/) about typespec basics. Each new event will be represented as a typespec `model`. After you create your new event, in the `client.tsp` file, you need to add `@@usage(EventGrid.YourEventName, Usage.output)` and `@@access(EventGrid.YourEventName, Access.public)`.

### Versioning

When an event or a new property is added to the typespec it requires a release version. This is the first day of the coming month, of the current year, that you want your event to be released in. 

For example, `v2025-02-01`, February 1st 2025 is targeting a release in February that will contain all work and PRs reviewed in January. 

To add this release version:
- In the `main.tsp` in the `enum ServiceApiVersions` place your intended release version. For example, `v2025_02_01: "2025-02-01"`.
- When adding new properties or events to the TypeSpec, use the [@added](https://github.com/microsoft/typespec/blob/main/packages/versioning/README.md) decorator, i.e. `@added(YOUR_RELEASE_VERSION)`.

#### Example Event


A sample valid event definition is shown below with `required` and `optional` properties:
~~~ markdown

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceived event. */
model AcsChatMessageReceivedEventData {
  ...AcsChatMessageEventBaseProperties;

  @added(ServiceApiVersions.v2025_02_01)
  /** Required. Field is always present in the event. */
  requiredProperty : string;    

  @added(ServiceApiVersions.v2025_02_01)
  /** Optional. Field may not be present in some events. */
  optionalProperty ?: string;
}
~~~

Adding `@usage` and `@access` to `client.tsp`:
~~~ markdown

@@usage(EventGrid.AcsChatMessageReceivedEventData, Usage.output);
@@access(EventGrid.AcsChatMessageReceivedEventData, Access.public)
~~~



# For Service System Events PR Approval

1) Write your service's system events in TypeSpec.
1) Ensure that you have assigned a **release version** to your changes.
1) Generate the swagger for your service's system events off of TypeSpec, following the steps below:
    - Install TypeSpec `npm install @typespec/compiler`
    - Install the emitter `npm install @azure-tools/typespec-autorest`
    - Under `/Azure.Messaging.EventGrid.SystemEvents/`:
        - Run `npx tsp compile main.tsp --emit @azure-tools/typespec-autorest`
1) Verify the generated swagger under `/data-plane/Microsoft.EventGrid/YOUR_RELEASE_VERSION/` accurately depicts your system events and commit it.
1) Final PR must contain the TypeSpec and the Swagger generated from the TypeSpec.