/** Describes the schema of the Azure Media Services events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  /** State of a Media Job. */
  union MediaJobState {
    /** The job was canceled. This is a final state for the job. */
    "Canceled",

    /** The job is in the process of being canceled. This is a transient state for the job. */
    "Canceling",

    /** The job has encountered an error. This is a final state for the job. */
    "Error",

    /** The job is finished. This is a final state for the job. */
    "Finished",

    /** The job is processing. This is a transient state for the job. */
    "Processing",

    /** The job is in a queued state, waiting for resources to become available. This is a transient state. */
    "Queued",

    /** The job is being scheduled to run on an available resource. This is a transient state, between queued and processing states. */
    "Scheduled",

    string,
  }

  /** Media Job Error Codes. */
  union MediaJobErrorCode {
    /** Fatal service error, please contact support. */
    "ServiceError",

    /** Transient error, please retry, if retry is unsuccessful, please contact support. */
    "ServiceTransientError",

    /** While trying to download the input files, the files were not accessible, please check the availability of the source. */
    "DownloadNotAccessible",

    /** While trying to download the input files, there was an issue during transfer (storage service, network errors), see details and check your source. */
    "DownloadTransientError",

    /** While trying to upload the output files, the destination was not reachable, please check the availability of the destination. */
    "UploadNotAccessible",

    /** While trying to upload the output files, there was an issue during transfer (storage service, network errors), see details and check your destination. */
    "UploadTransientError",

    /** There was a problem with the combination of input files and the configuration settings applied, fix the configuration settings and retry with the same input, or change input to match the configuration. */
    "ConfigurationUnsupported",

    /** There was a problem with the input content (for example: zero byte files, or corrupt/non-decodable files), check the input files. */
    "ContentMalformed",

    /** There was a problem with the format of the input (not valid media file, or an unsupported file/codec), check the validity of the input files. */
    "ContentUnsupported",

    /** There is an error verifying to the account identity. Check and fix the identity configurations and retry. If unsuccessful, please contact support. */
    "IdentityUnsupported",

    string,
  }

  /** Error categories for Media Job Errors. */
  union MediaJobErrorCategory {
    /** The error is service related. */
    "Service",

    /** The error is download related. */
    "Download",

    /** The error is upload related. */
    "Upload",

    /** The error is configuration related. */
    "Configuration",

    /** The error is related to data in the input files. */
    "Content",

    /** The error is related to account information. */
    "Account",

    string,
  }

  /** Media Job Retry Options. */
  union MediaJobRetry {
    /** Issue needs to be investigated and then the job resubmitted with corrections or retried once the underlying issue has been corrected. */
    "DoNotRetry",

    /** Issue may be resolved after waiting for a period of time and resubmitting the same Job. */
    "MayRetry",

    string,
  }

  /**
  Schema of the Data property of an EventGridEvent for a
  Microsoft.Media.JobStateChange event.
  */
  model MediaJobStateChangeEventData {
    /** The previous state of the Job. */
    previousState?: MediaJobState;

    /** The new state of the Job. */
    state?: MediaJobState;

    /** Gets the Job correlation data. */
    correlationData?: Record<string>;
  }

  /** Details of JobOutput errors. */
  model MediaJobError {
    /** Error code describing the error. */
    code?: MediaJobErrorCode;

    /** A human-readable language-dependent representation of the error. */
    message?: string;

    /** Helps with categorization of errors. */
    category?: MediaJobErrorCategory;

    /** Indicates that it may be possible to retry the Job. If retry is unsuccessful, please contact Azure support via Azure Portal. */
    retry?: MediaJobRetry;

    /** An array of details about specific errors that led to this reported error. */
    details?: MediaJobErrorDetail[];
  }

  /** Details of JobOutput errors. */
  model MediaJobErrorDetail {
    /** Code describing the error detail. */
    code?: string;

    /** A human-readable representation of the error. */
    message?: string;
  }

  /** The event data for a Job output. */
  @discriminator("@odataType")
  model MediaJobOutput {
    /** The discriminator for derived types. */
    `@odataType`: string;

    /** Gets the Job output error. */
    error?: MediaJobError;

    /** Gets the Job output label. */
    label?: string;

    /** Gets the Job output progress. */
    progress: int64;

    /** Gets the Job output state. */
    state: MediaJobState;
  }

  /** The event data for a Job output asset. */
  model MediaJobOutputAsset extends MediaJobOutput {
    /** Gets the Job output asset name. */
    assetName?: string;

    /** The discriminator for derived types. */
    `@odataType`: "#Microsoft.Media.JobOutputAsset";
  }

  /**
  Job Output Progress Event Data. Schema of the Data property of an
  EventGridEvent for a Microsoft.Media.JobOutputProgress event.
  */
  model MediaJobOutputProgressEventData {
    /** Gets the Job output label. */
    label?: string;

    /** Gets the Job output progress. */
    progress?: int64;

    /** Gets the Job correlation data. */
    jobCorrelationData?: Record<string>;
  }

  /**
  Schema of the Data property of an EventGridEvent for a
  Microsoft.Media.JobOutputStateChange event.
  */
  model MediaJobOutputStateChangeEventData {
    /** The previous state of the Job. */
    previousState?: MediaJobState;

    /** Gets the output. */
    output?: MediaJobOutput;

    /** Gets the Job correlation data. */
    jobCorrelationData?: Record<string>;
  }

  /**
Job scheduled event data. Schema of the data property of an EventGridEvent for
a Microsoft.Media.JobScheduled event.
*/
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  model MediaJobScheduledEventData extends MediaJobStateChangeEventData {}

  /**
Job processing event data. Schema of the data property of an EventGridEvent for
a Microsoft.Media.JobProcessing event.
*/
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  model MediaJobProcessingEventData extends MediaJobStateChangeEventData {}

  /**
Job canceling event data. Schema of the data property of an EventGridEvent for
a Microsoft.Media.JobCanceling event.
*/
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  model MediaJobCancelingEventData extends MediaJobStateChangeEventData {}

  /**
Job finished event data. Schema of the data property of an EventGridEvent for a
Microsoft.Media.JobFinished event.
*/
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  model MediaJobFinishedEventData extends MediaJobStateChangeEventData {
    /** Gets the Job outputs. */
    outputs?: MediaJobOutput[];
  }

  /**
Job canceled event data. Schema of the data property of an EventGridEvent for a
Microsoft.Media.JobCanceled event.
*/
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  model MediaJobCanceledEventData extends MediaJobStateChangeEventData {
    /** Gets the Job outputs. */
    outputs?: MediaJobOutput[];
  }

  /**
Job error state event data. Schema of the data property of an EventGridEvent
for a Microsoft.Media.JobErrored event.
*/
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  model MediaJobErroredEventData extends MediaJobStateChangeEventData {
    /** Gets the Job outputs. */
    outputs?: MediaJobOutput[];
  }

  /**
Job output canceled event data. Schema of the data property of an
EventGridEvent for a Microsoft.Media.JobOutputCanceled event.
*/
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  model MediaJobOutputCanceledEventData
    extends MediaJobOutputStateChangeEventData {}

  /**
Job output canceling event data. Schema of the data property of an
EventGridEvent for a Microsoft.Media.JobOutputCanceling event.
*/
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  model MediaJobOutputCancelingEventData
    extends MediaJobOutputStateChangeEventData {}

  /**
Job output error event data. Schema of the data property of an EventGridEvent
for a Microsoft.Media.JobOutputErrored event.
*/
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  model MediaJobOutputErroredEventData
    extends MediaJobOutputStateChangeEventData {}

  /**
Job output finished event data. Schema of the data property of an
EventGridEvent for a Microsoft.Media.JobOutputFinished event.
*/
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  model MediaJobOutputFinishedEventData
    extends MediaJobOutputStateChangeEventData {}

  /**
Job output processing event data. Schema of the data property of an
EventGridEvent for a Microsoft.Media.JobOutputProcessing event.
*/
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  model MediaJobOutputProcessingEventData
    extends MediaJobOutputStateChangeEventData {}

  /**
Job output scheduled event data. Schema of the data property of an
EventGridEvent for a Microsoft.Media.JobOutputScheduled event.
*/
  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  model MediaJobOutputScheduledEventData
    extends MediaJobOutputStateChangeEventData {}

  /** Encoder connect event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventEncoderConnected event. */
  model MediaLiveEventEncoderConnectedEventData {
    ...MediaLiveEventConnectionBaseData;
  }

  /** Encoder connection rejected event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventConnectionRejected event. */
  model MediaLiveEventConnectionRejectedEventData {
    ...MediaLiveEventConnectionBaseData;

    /** Gets the result code. */
    resultCode?: string;
  }

  /** Encoder disconnected event data. Schema of the Data property of an EventGridEvent for a Microsoft.Media.LiveEventEncoderDisconnected event. */
  model MediaLiveEventEncoderDisconnectedEventData {
    ...MediaLiveEventConnectionBaseData;

    /** Gets the result code. */
    resultCode?: string;
  }

  /** Encoder connect event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingStreamReceived event. */
  model MediaLiveEventIncomingStreamReceivedEventData {
    /** Gets the ingest URL provided by the live event. */
    ingestUrl?: string;

    /** Gets the type of the track (Audio / Video). */
    trackType?: string;

    /** Gets the track name. */
    trackName?: string;

    /** Gets the bitrate of the track. */
    bitrate?: int64;

    /** Gets the remote IP. */
    encoderIp?: string;

    /** Gets the remote port. */
    encoderPort?: string;

    /** Gets the first timestamp of the data chunk received. */
    timestamp?: string;

    /** Gets the duration of the first data chunk. */
    duration?: string;

    /** Gets the timescale in which timestamp is represented. */
    timescale?: string;
  }

  /** Incoming streams out of sync event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingStreamsOutOfSync event. */
  model MediaLiveEventIncomingStreamsOutOfSyncEventData {
    /** Gets the minimum last timestamp received. */
    minLastTimestamp?: string;

    /** Gets the type of stream with minimum last timestamp. */
    typeOfStreamWithMinLastTimestamp?: string;

    /** Gets the maximum timestamp among all the tracks (audio or video). */
    maxLastTimestamp?: string;

    /** Gets the type of stream with maximum last timestamp. */
    typeOfStreamWithMaxLastTimestamp?: string;

    /** Gets the timescale in which \"MinLastTimestamp\" is represented. */
    timescaleOfMinLastTimestamp?: string;

    /** Gets the timescale in which \"MaxLastTimestamp\" is represented. */
    timescaleOfMaxLastTimestamp?: string;
  }

  /** Incoming video stream out of sync event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingVideoStreamsOutOfSync event. */
  model MediaLiveEventIncomingVideoStreamsOutOfSyncEventData {
    /** Gets the first timestamp received for one of the quality levels. */
    firstTimestamp?: string;

    /** Gets the duration of the data chunk with first timestamp. */
    firstDuration?: string;

    /** Gets the timestamp received for some other quality levels. */
    secondTimestamp?: string;

    /** Gets the duration of the data chunk with second timestamp. */
    secondDuration?: string;

    /** Gets the timescale in which both the timestamps and durations are represented. */
    timescale?: string;
  }

  /** Ingest fragment dropped event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingDataChunkDropped event. */
  model MediaLiveEventIncomingDataChunkDroppedEventData {
    /** Gets the timestamp of the data chunk dropped. */
    timestamp?: string;

    /** Gets the type of the track (Audio / Video). */
    trackType?: string;

    /** Gets the bitrate of the track. */
    bitrate?: int64;

    /** Gets the timescale of the Timestamp. */
    @visibility
    timescale?: string;

    /** Gets the result code for fragment drop operation. */
    resultCode?: string;

    /** Gets the name of the track for which fragment is dropped. */
    trackName?: string;
  }

  /** Ingest heartbeat event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIngestHeartbeat event. */
  model MediaLiveEventIngestHeartbeatEventData {
    /** Gets the type of the track (Audio / Video). */
    trackType?: string;

    /** Gets the track name. */
    trackName?: string;

    /** Gets the Live Transcription language. */
    transcriptionLanguage?: string;

    /** Gets the Live Transcription state. */
    transcriptionState?: string;

    /** Gets the bitrate of the track. */
    bitrate?: int64;

    /** Gets the incoming bitrate. */
    incomingBitrate?: int64;

    /** Gets the track ingest drift value. */
    ingestDriftValue?: string;

    /** Gets the arrival UTC time of the last fragment. */
    lastFragmentArrivalTime?: string;

    /** Gets the last timestamp. */
    lastTimestamp?: string;

    /** Gets the timescale of the last timestamp. */
    timescale?: string;

    /** Gets the fragment Overlap count. */
    overlapCount?: int64;

    /** Gets the fragment Discontinuity count. */
    discontinuityCount?: int64;

    /** Gets Non increasing count. */
    nonincreasingCount?: int64;

    /** Gets a value indicating whether unexpected bitrate is present or not. */
    unexpectedBitrate?: boolean;

    /** Gets the state of the live event. */
    state?: string;

    /** Gets a value indicating whether preview is healthy or not. */
    healthy?: boolean;
  }

  /** Ingest track discontinuity detected event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventTrackDiscontinuityDetected event. */
  model MediaLiveEventTrackDiscontinuityDetectedEventData {
    /** Gets the type of the track (Audio / Video). */
    trackType?: string;

    /** Gets the track name. */
    trackName?: string;

    /** Gets the bitrate. */
    bitrate?: int64;

    /** Gets the timestamp of the previous fragment. */
    previousTimestamp?: string;

    /** Gets the timestamp of the current fragment. */
    newTimestamp?: string;

    /** Gets the timescale in which both timestamps and discontinuity gap are represented. */
    timescale?: string;

    /** Gets the discontinuity gap between PreviousTimestamp and NewTimestamp. */
    discontinuityGap?: string;
  }

  /** Channel Archive heartbeat event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventChannelArchiveHeartbeat event. */
  model MediaLiveEventChannelArchiveHeartbeatEventData {
    /** Gets the channel latency in ms. */
    channelLatencyMs: string;

    /** Gets the latency result code. */
    latencyResultCode: string;
  }

  alias MediaLiveEventConnectionBaseData = {
    /** Gets the ingest URL provided by the live event. */
    ingestUrl?: string;

    /** Gets the stream Id. */
    streamId?: string;

    /** Gets the remote IP. */
    encoderIp?: string;

    /** Gets the remote port. */
    encoderPort?: string;
  };
}
