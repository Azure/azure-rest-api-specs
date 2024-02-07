/** Describes the schema of the Azure Media Services events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  /** State of a Media Job. */
  enum MediaJobState {
    /** The job was canceled. This is a final state for the job. */
    Canceled,

    /** The job is in the process of being canceled. This is a transient state for the job. */
    Canceling,

    /** The job has encountered an error. This is a final state for the job. */
    Error,

    /** The job is finished. This is a final state for the job. */
    Finished,

    /** The job is processing. This is a transient state for the job. */
    Processing,

    /** The job is in a queued state, waiting for resources to become available. This is a transient state. */
    Queued,

    /** The job is being scheduled to run on an available resource. This is a transient state, between queued and processing states. */
    Scheduled,
  }

  /** Media Job Error Codes. */
  enum MediaJobErrorCode {
    /** Fatal service error, please contact support. */
    ServiceError,

    /** Transient error, please retry, if retry is unsuccessful, please contact support. */
    ServiceTransientError,

    /** While trying to download the input files, the files were not accessible, please check the availability of the source. */
    DownloadNotAccessible,

    /** While trying to download the input files, there was an issue during transfer (storage service, network errors), see details and check your source. */
    DownloadTransientError,

    /** While trying to upload the output files, the destination was not reachable, please check the availability of the destination. */
    UploadNotAccessible,

    /** While trying to upload the output files, there was an issue during transfer (storage service, network errors), see details and check your destination. */
    UploadTransientError,

    /** There was a problem with the combination of input files and the configuration settings applied, fix the configuration settings and retry with the same input, or change input to match the configuration. */
    ConfigurationUnsupported,

    /** There was a problem with the input content (for example: zero byte files, or corrupt/non-decodable files), check the input files. */
    ContentMalformed,

    /** There was a problem with the format of the input (not valid media file, or an unsupported file/codec), check the validity of the input files. */
    ContentUnsupported,

    /** There is an error verifying to the account identity. Check and fix the identity configurations and retry. If unsuccessful, please contact support. */
    IdentityUnsupported,
  }

  /** Error categories for Media Job Errors. */
  enum MediaJobErrorCategory {
    /** The error is service related. */
    Service,

    /** The error is download related. */
    Download,

    /** The error is upload related. */
    Upload,

    /** The error is configuration related. */
    Configuration,

    /** The error is related to data in the input files. */
    Content,

    /** The error is related to account information. */
    Account,
  }

  /** Media Job Retry Options. */
  enum MediaJobRetry {
    /** Issue needs to be investigated and then the job resubmitted with corrections or retried once the underlying issue has been corrected. */
    DoNotRetry,

    /** Issue may be resolved after waiting for a period of time and resubmitting the same Job. */
    MayRetry,
  }

  @doc("""
  Schema of the Data property of an EventGridEvent for a
  Microsoft.Media.JobStateChange event.
  """)
  model MediaJobStateChangeEventData {
    /** The previous state of the Job. */
    @visibility("read")
    previousState?: MediaJobState;

    /** The new state of the Job. */
    @visibility("read")
    state?: MediaJobState;

    /** Gets the Job correlation data. */
    correlationData?: Record<string>;
  }

  /** Details of JobOutput errors. */
  model MediaJobError {
    @visibility("read")
    /** Error code describing the error. */
    code?: MediaJobErrorCode;

    @visibility("read")
    /** A human-readable language-dependent representation of the error. */
    message?: string;

    @visibility("read")
    /** Helps with categorization of errors. */
    category?: MediaJobErrorCategory;

    @visibility("read")
    /** Indicates that it may be possible to retry the Job. If retry is unsuccessful, please contact Azure support via Azure Portal. */
    retry?: MediaJobRetry;

    @visibility("read")
    /** An array of details about specific errors that led to this reported error. */
    details?: MediaJobErrorDetail[];
  }

  /** Details of JobOutput errors. */
  model MediaJobErrorDetail {
    @visibility("read")
    /** Code describing the error detail. */
    code?: string;

    @visibility("read")
    /** A human-readable representation of the error. */
    message?: string;
  }

  /** The event data for a Job output. */
  @discriminator("oDataType")
  model MediaJobOutput {
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
    oDataType: "#Microsoft.Media.JobOutputAsset";
  }

  @doc("""
  Job Output Progress Event Data. Schema of the Data property of an
  EventGridEvent for a Microsoft.Media.JobOutputProgress event.
  """)
  model MediaJobOutputProgressEventData {
    /** Gets the Job output label. */
    label?: string;

    /** Gets the Job output progress. */
    progress?: int64;

    /** Gets the Job correlation data. */
    jobCorrelationData?: Record<string>;
  }

  @doc("""
  Schema of the Data property of an EventGridEvent for a
  Microsoft.Media.JobOutputStateChange event.
  """)
  model MediaJobOutputStateChangeEventData {
    /** The previous state of the Job. */
    @visibility("read")
    previousState?: MediaJobState;

    /** Gets the output. */
    output?: MediaJobOutput;

    /** Gets the Job correlation data. */
    jobCorrelationData?: Record<string>;
  }

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job scheduled event data. Schema of the data property of an EventGridEvent for
a Microsoft.Media.JobScheduled event.
""")
  model MediaJobScheduledEventData extends MediaJobStateChangeEventData {}

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job processing event data. Schema of the data property of an EventGridEvent for
a Microsoft.Media.JobProcessing event.
""")
  model MediaJobProcessingEventData extends MediaJobStateChangeEventData {}

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job canceling event data. Schema of the data property of an EventGridEvent for
a Microsoft.Media.JobCanceling event.
""")
  model MediaJobCancelingEventData extends MediaJobStateChangeEventData {}

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job finished event data. Schema of the data property of an EventGridEvent for a
Microsoft.Media.JobFinished event.
""")
  model MediaJobFinishedEventData extends MediaJobStateChangeEventData {
    /** Gets the Job outputs. */
    outputs?: MediaJobOutput[];
  }

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job canceled event data. Schema of the data property of an EventGridEvent for a
Microsoft.Media.JobCanceled event.
""")
  model MediaJobCanceledEventData extends MediaJobStateChangeEventData {
    /** Gets the Job outputs. */
    outputs?: MediaJobOutput[];
  }

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job error state event data. Schema of the data property of an EventGridEvent
for a Microsoft.Media.JobErrored event.
""")
  model MediaJobErroredEventData extends MediaJobStateChangeEventData {
    /** Gets the Job outputs. */
    outputs?: MediaJobOutput[];
  }

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job output canceled event data. Schema of the data property of an
EventGridEvent for a Microsoft.Media.JobOutputCanceled event.
""")
  model MediaJobOutputCanceledEventData
    extends MediaJobOutputStateChangeEventData {}

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job output canceling event data. Schema of the data property of an
EventGridEvent for a Microsoft.Media.JobOutputCanceling event.
""")
  model MediaJobOutputCancelingEventData
    extends MediaJobOutputStateChangeEventData {}

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job output error event data. Schema of the data property of an EventGridEvent
for a Microsoft.Media.JobOutputErrored event.
""")
  model MediaJobOutputErroredEventData
    extends MediaJobOutputStateChangeEventData {}

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job output finished event data. Schema of the data property of an
EventGridEvent for a Microsoft.Media.JobOutputFinished event.
""")
  model MediaJobOutputFinishedEventData
    extends MediaJobOutputStateChangeEventData {}

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job output processing event data. Schema of the data property of an
EventGridEvent for a Microsoft.Media.JobOutputProcessing event.
""")
  model MediaJobOutputProcessingEventData
    extends MediaJobOutputStateChangeEventData {}

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job output scheduled event data. Schema of the data property of an
EventGridEvent for a Microsoft.Media.JobOutputScheduled event.
""")
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
    @visibility("read")
    /** Gets the ingest URL provided by the live event. */
    ingestUrl?: string;

    @visibility("read")
    /** Gets the type of the track (Audio / Video). */
    trackType?: string;

    @visibility("read")
    /** Gets the track name. */
    trackName?: string;

    @visibility("read")
    /** Gets the bitrate of the track. */
    bitrate?: int64;

    @visibility("read")
    /** Gets the remote IP. */
    encoderIp?: string;

    @visibility("read")
    /** Gets the remote port. */
    encoderPort?: string;

    @visibility("read")
    /** Gets the first timestamp of the data chunk received. */
    timestamp?: string;

    @visibility("read")
    /** Gets the duration of the first data chunk. */
    duration?: string;

    @visibility("read")
    /** Gets the timescale in which timestamp is represented. */
    timescale?: string;
  }

  /** Incoming streams out of sync event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingStreamsOutOfSync event. */
  model MediaLiveEventIncomingStreamsOutOfSyncEventData {
    @visibility("read")
    /** Gets the minimum last timestamp received. */
    minLastTimestamp?: string;

    @visibility("read")
    /** Gets the type of stream with minimum last timestamp. */
    typeOfStreamWithMinLastTimestamp?: string;

    @visibility("read")
    /** Gets the maximum timestamp among all the tracks (audio or video). */
    maxLastTimestamp?: string;

    @visibility("read")
    /** Gets the type of stream with maximum last timestamp. */
    typeOfStreamWithMaxLastTimestamp?: string;

    @visibility("read")
    /** Gets the timescale in which \"MinLastTimestamp\" is represented. */
    timescaleOfMinLastTimestamp?: string;

    @visibility("read")
    /** Gets the timescale in which \"MaxLastTimestamp\" is represented. */
    timescaleOfMaxLastTimestamp?: string;
  }

  /** Incoming video stream out of sync event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingVideoStreamsOutOfSync event. */
  model MediaLiveEventIncomingVideoStreamsOutOfSyncEventData {
    @visibility("read")
    /** Gets the first timestamp received for one of the quality levels. */
    firstTimestamp?: string;

    @visibility("read")
    /** Gets the duration of the data chunk with first timestamp. */
    firstDuration?: string;

    @visibility("read")
    /** Gets the timestamp received for some other quality levels. */
    secondTimestamp?: string;

    @visibility("read")
    /** Gets the duration of the data chunk with second timestamp. */
    secondDuration?: string;

    @visibility("read")
    /** Gets the timescale in which both the timestamps and durations are represented. */
    timescale?: string;
  }

  /** Ingest fragment dropped event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingDataChunkDropped event. */
  model MediaLiveEventIncomingDataChunkDroppedEventData {
    @visibility("read")
    /** Gets the timestamp of the data chunk dropped. */
    timestamp?: string;

    @visibility("read")
    /** Gets the type of the track (Audio / Video). */
    trackType?: string;

    @visibility("read")
    /** Gets the bitrate of the track. */
    bitrate?: int64;

    @visibility
    /** Gets the timescale of the Timestamp. */
    timescale?: string;

    @visibility("read")
    /** Gets the result code for fragment drop operation. */
    resultCode?: string;

    @visibility("read")
    /** Gets the name of the track for which fragment is dropped. */
    trackName?: string;
  }

  /** Ingest heartbeat event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIngestHeartbeat event. */
  model MediaLiveEventIngestHeartbeatEventData {
    @visibility("read")
    /** Gets the type of the track (Audio / Video). */
    trackType?: string;

    @visibility("read")
    /** Gets the track name. */
    trackName?: string;

    @visibility("read")
    /** Gets the Live Transcription language. */
    transcriptionLanguage?: string;

    @visibility("read")
    /** Gets the Live Transcription state. */
    transcriptionState?: string;

    @visibility("read")
    /** Gets the bitrate of the track. */
    bitrate?: int64;

    @visibility("read")
    /** Gets the incoming bitrate. */
    incomingBitrate?: int64;

    @visibility("read")
    /** Gets the track ingest drift value. */
    ingestDriftValue?: string;

    @visibility("read")
    /** Gets the arrival UTC time of the last fragment. */
    lastFragmentArrivalTime?: string;

    @visibility("read")
    /** Gets the last timestamp. */
    lastTimestamp?: string;

    @visibility("read")
    /** Gets the timescale of the last timestamp. */
    timescale?: string;

    @visibility("read")
    /** Gets the fragment Overlap count. */
    overlapCount?: int64;

    @visibility("read")
    /** Gets the fragment Discontinuity count. */
    discontinuityCount?: int64;

    @visibility("read")
    /** Gets Non increasing count. */
    nonincreasingCount?: int64;

    @visibility("read")
    /** Gets a value indicating whether unexpected bitrate is present or not. */
    unexpectedBitrate?: boolean;

    @visibility("read")
    /** Gets the state of the live event. */
    state?: string;

    @visibility("read")
    /** Gets a value indicating whether preview is healthy or not. */
    healthy?: boolean;
  }

  /** Ingest track discontinuity detected event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventTrackDiscontinuityDetected event. */
  model MediaLiveEventTrackDiscontinuityDetectedEventData {
    @visibility("read")
    /** Gets the type of the track (Audio / Video). */
    trackType?: string;

    @visibility("read")
    /** Gets the track name. */
    trackName?: string;

    @visibility("read")
    /** Gets the bitrate. */
    bitrate?: int64;

    @visibility("read")
    /** Gets the timestamp of the previous fragment. */
    previousTimestamp?: string;

    @visibility("read")
    /** Gets the timestamp of the current fragment. */
    newTimestamp?: string;

    @visibility("read")
    /** Gets the timescale in which both timestamps and discontinuity gap are represented. */
    timescale?: string;

    @visibility("read")
    /** Gets the discontinuity gap between PreviousTimestamp and NewTimestamp. */
    discontinuityGap?: string;
  }

  /** Channel Archive heartbeat event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventChannelArchiveHeartbeat event. */
  model MediaLiveEventChannelArchiveHeartbeatEventData {
    @visibility("read")
    /** Gets the channel latency in ms. */
    channelLatencyMs: string;

    @visibility("read")
    /** Gets the latency result code. */
    latencyResultCode: string;
  }

  alias MediaLiveEventConnectionBaseData = {
    @visibility("read")
    /** Gets the ingest URL provided by the live event. */
    ingestUrl?: string;

    @visibility("read")
    /** Gets the stream Id. */
    streamId?: string;

    @visibility("read")
    /** Gets the remote IP. */
    encoderIp?: string;

    @visibility("read")
    /** Gets the remote port. */
    encoderPort?: string;
  };
}
