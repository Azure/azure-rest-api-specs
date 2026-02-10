import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.MapsGeofenceEnteredEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.MapsGeofenceEnteredEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MapsGeofenceExitedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.MapsGeofenceExitedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MapsGeofenceResultEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.MapsGeofenceResultEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MapsGeofenceEventProperties,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.MapsGeofenceEventProperties,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MapsGeofenceGeometry,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.MapsGeofenceGeometry, Access.public);
//Enums

//useSystemTextJsonConverter decorators
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.MapsGeofenceEnteredEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.MapsGeofenceExitedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.MapsGeofenceResultEventData,
  "csharp"
);
