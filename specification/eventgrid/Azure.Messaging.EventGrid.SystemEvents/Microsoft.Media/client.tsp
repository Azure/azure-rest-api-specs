import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobStateChangeEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobStateChangeEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobError, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobError, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobErrorDetail, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobErrorDetail, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutput, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutput, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputAsset, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputAsset, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputProgressEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputProgressEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputStateChangeEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputStateChangeEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobScheduledEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobScheduledEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobProcessingEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobProcessingEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobCancelingEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobCancelingEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobFinishedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobFinishedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobCanceledEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobCanceledEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobErroredEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobErroredEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputCanceledEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputCanceledEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputCancelingEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputCancelingEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputErroredEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputErroredEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputFinishedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputFinishedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputProcessingEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputProcessingEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputScheduledEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobOutputScheduledEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventEncoderConnectedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventEncoderConnectedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventConnectionRejectedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventConnectionRejectedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventEncoderDisconnectedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventEncoderDisconnectedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventIncomingStreamReceivedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventIncomingStreamReceivedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventIncomingStreamsOutOfSyncEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventIncomingStreamsOutOfSyncEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventIncomingVideoStreamsOutOfSyncEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventIncomingVideoStreamsOutOfSyncEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventIncomingDataChunkDroppedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventIncomingDataChunkDroppedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventIngestHeartbeatEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventIngestHeartbeatEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventTrackDiscontinuityDetectedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventTrackDiscontinuityDetectedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventChannelArchiveHeartbeatEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaLiveEventChannelArchiveHeartbeatEventData,
  Access.public
);
//Enums
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobState, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobState, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobErrorCode, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobErrorCode, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobErrorCategory, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobErrorCategory, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobRetry, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MediaServices.MediaJobRetry, Access.public);
