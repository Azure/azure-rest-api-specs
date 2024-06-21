import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.Maps.MapsGeofenceEnteredEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Maps.MapsGeofenceEnteredEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Maps.MapsGeofenceExitedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Maps.MapsGeofenceExitedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Maps.MapsGeofenceResultEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Maps.MapsGeofenceResultEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Maps.MapsGeofenceEventProperties,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Maps.MapsGeofenceEventProperties,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Maps.MapsGeofenceGeometry, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.Maps.MapsGeofenceGeometry, Access.public);
//Enums
