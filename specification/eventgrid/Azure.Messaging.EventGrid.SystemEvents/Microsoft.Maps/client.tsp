import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.MapsGeofenceEnteredEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MapsGeofenceEnteredEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MapsGeofenceExitedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MapsGeofenceExitedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MapsGeofenceResultEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MapsGeofenceResultEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MapsGeofenceEventProperties,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MapsGeofenceEventProperties,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MapsGeofenceGeometry, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MapsGeofenceGeometry, Access.public);
//Enums
