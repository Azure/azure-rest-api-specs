import "./ApiManagement.tsp";
import "./AppConfiguration.tsp";
import "./AzureCommunicationServices.tsp";
import "./ContainerRegistry.tsp";
import "./ContainerService.tsp";
import "./DataBox.tsp";
import "./EventHub.tsp";
import "./Maps.tsp";
import "./IotHub.tsp";
import "./HealthcareApis.tsp";
import "./KeyVault.tsp";
import "./MachineLearningServices.tsp";
import "./MediaServices.tsp";
import "./PolicyInsights.tsp";
import "./RedisCache.tsp";
import "./Resources.tsp";
import "./ServiceBus.tsp";
import "./SignalRService.tsp";
import "./Storage.tsp";
import "./Web.tsp";
import "./EventGrid.tsp";

//Uncomment for testing out typed events with ApiManagement

// import "./ApiManagementTypedReference.tsp";

// @service({ title: "Glory to the event grid!" })
// namespace EventGrid {
//   @discriminator("eventType")
//   model EventGridEvent {
//     id: string;
//     topic: string;
//     subject: string;
//     eventType: string;
//     dataVersion: string;
//     metadataVersion: string,
//     eventTime: zonedDateTime;
//   }

//   model TypedEventGridEvent<TEventType extends string, TData extends object> extends EventGridEvent {
//     eventType: TEventType;
//     dataType: TData;
//   }

//   @discriminator("type")
//   model CloudEvent {
//     id: string;
//     source: string;
//     data?: string;
//     data_base64?: bytes;
//     type: string;
//     time?: zonedDateTime;
//     specversion: string;
//     dataschema?: string;
//     datacontenttype?: string;
//     subject?: string;
//   }

//   model TypedCloudEvent<TEventType extends string, TData extends object> extends CloudEvent {
//     type: TEventType;
//     dataType: TData;
//   }

// }
