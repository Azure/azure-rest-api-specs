@doc("Describes the schema of the Azure Media Services events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace Microsoft.EventGrid {
  @doc("State of a Media Job.")
  enum MediaJobState {
    @doc("The job was canceled. This is a final state for the job.")
    Canceled,

    @doc("The job is in the process of being canceled. This is a transient state for the job.")
    Canceling,

    @doc("The job has encountered an error. This is a final state for the job.")
    Error,

    @doc("The job is finished. This is a final state for the job.")
    Finished,

    @doc("The job is processing. This is a transient state for the job.")
    Processing,

    @doc("The job is in a queued state, waiting for resources to become available. This is a transient state.")
    Queued,

    @doc("The job is being scheduled to run on an available resource. This is a transient state, between queued and processing states.")
    Scheduled,
  }

  @doc("Media Job Error Codes.")
  enum MediaJobErrorCode {
    @doc("Fatal service error, please contact support.")
    ServiceError,

    @doc("Transient error, please retry, if retry is unsuccessful, please contact support.")
    ServiceTransientError,

    @doc("While trying to download the input files, the files were not accessible, please check the availability of the source.")
    DownloadNotAccessible,

    @doc("While trying to download the input files, there was an issue during transfer (storage service, network errors), see details and check your source.")
    DownloadTransientError,

    @doc("While trying to upload the output files, the destination was not reachable, please check the availability of the destination.")
    UploadNotAccessible,

    @doc("While trying to upload the output files, there was an issue during transfer (storage service, network errors), see details and check your destination.")
    UploadTransientError,

    @doc("There was a problem with the combination of input files and the configuration settings applied, fix the configuration settings and retry with the same input, or change input to match the configuration.")
    ConfigurationUnsupported,

    @doc("There was a problem with the input content (for example: zero byte files, or corrupt/non-decodable files), check the input files.")
    ContentMalformed,

    @doc("There was a problem with the format of the input (not valid media file, or an unsupported file/codec), check the validity of the input files.")
    ContentUnsupported,

    @doc("There is an error verifying to the account identity. Check and fix the identity configurations and retry. If unsuccessful, please contact support.")
    IdentityUnsupported,
  }

  @doc("Error categories for Media Job Errors.")
  enum MediaJobErrorCategory {
    @doc("The error is service related.")
    Service,

    @doc("The error is download related.")
    Download,

    @doc("The error is upload related.")
    Upload,

    @doc("The error is configuration related.")
    Configuration,

    @doc("The error is related to data in the input files.")
    Content,

    @doc("The error is related to account information.")
    Account,
  }

  @doc("Media Job Retry Options.")
  enum MediaJobRetry {
    @doc("Issue needs to be investigated and then the job resubmitted with corrections or retried once the underlying issue has been corrected.")
    DoNotRetry,

    @doc("Issue may be resolved after waiting for a period of time and resubmitting the same Job.")
    MayRetry,
  }

  @doc("""
  Schema of the Data property of an EventGridEvent for a
  Microsoft.Media.JobStateChange event.
  """)
  model MediaJobStateChangeEventData {
    @doc("The previous state of the Job.")
    @visibility("read")
    previousState?: MediaJobState;

    @doc("The new state of the Job.")
    @visibility("read")
    state?: MediaJobState;

    @doc("Gets the Job correlation data.")
    correlationData?: Record<string>;
  }

  @doc("Details of JobOutput errors.")
  model MediaJobError {
    @visibility("read")
    @doc("Error code describing the error.")
    code?: MediaJobErrorCode;

    @visibility("read")
    @doc("A human-readable language-dependent representation of the error.")
    message?: string;

    @visibility("read")
    @doc("Helps with categorization of errors.")
    category?: MediaJobErrorCategory;

    @visibility("read")
    @doc("Indicates that it may be possible to retry the Job. If retry is unsuccessful, please contact Azure support via Azure Portal.")
    retry?: MediaJobRetry;

    @visibility("read")
    @doc("An array of details about specific errors that led to this reported error.")
    details?: MediaJobErrorDetail[];
  }

  @doc("Details of JobOutput errors.")
  model MediaJobErrorDetail {
    @visibility("read")
    @doc("Code describing the error detail.")
    code?: string;

    @visibility("read")
    @doc("A human-readable representation of the error.")
    message?: string;
  }

  @doc("The event data for a Job output.")
  @discriminator("oDataType")
  model MediaJobOutput {
    @doc("Gets the Job output error.")
    error?: MediaJobError;

    @doc("Gets the Job output label.")
    label?: string;

    @doc("Gets the Job output progress.")
    progress: int64;

    @doc("Gets the Job output state.")
    state: MediaJobState;
  }

  @doc("The event data for a Job output asset.")
  model MediaJobOutputAsset extends MediaJobOutput {
    @doc("Gets the Job output asset name.")
    assetName?: string;

    @doc("The discriminator for derived types.")
    oDataType: "#Microsoft.Media.JobOutputAsset";
  }

  @doc("""
  Job Output Progress Event Data. Schema of the Data property of an
  EventGridEvent for a Microsoft.Media.JobOutputProgress event.
  """)
  model MediaJobOutputProgressEventData {
    @doc("Gets the Job output label.")
    label?: string;

    @doc("Gets the Job output progress.")
    progress?: int64;

    @doc("Gets the Job correlation data.")
    jobCorrelationData?: Record<string>;
  }

  @doc("""
  Schema of the Data property of an EventGridEvent for a
  Microsoft.Media.JobOutputStateChange event.
  """)
  model MediaJobOutputStateChangeEventData {
    @doc("The previous state of the Job.")
    @visibility("read")
    previousState?: MediaJobState;

    @doc("Gets the output.")
    output?: MediaJobOutput;

    @doc("Gets the Job correlation data.")
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
    @doc("Gets the Job outputs.")
    outputs?: MediaJobOutput[];
  }

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job canceled event data. Schema of the data property of an EventGridEvent for a
Microsoft.Media.JobCanceled event.
""")
  model MediaJobCanceledEventData extends MediaJobStateChangeEventData {
    @doc("Gets the Job outputs.")
    outputs?: MediaJobOutput[];
  }

  #suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
  @doc("""
Job error state event data. Schema of the data property of an EventGridEvent
for a Microsoft.Media.JobErrored event.
""")
  model MediaJobErroredEventData extends MediaJobStateChangeEventData {
    @doc("Gets the Job outputs.")
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

  @doc("Encoder connect event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventEncoderConnected event.")
  model MediaLiveEventEncoderConnectedEventData {
    ...MediaLiveEventConnectionBaseData;
  }

  @doc("Encoder connection rejected event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventConnectionRejected event.")
  model MediaLiveEventConnectionRejectedEventData {
    ...MediaLiveEventConnectionBaseData;

    @doc("Gets the result code.")
    resultCode?: string;
  }

  @doc("Encoder disconnected event data. Schema of the Data property of an EventGridEvent for a Microsoft.Media.LiveEventEncoderDisconnected event.")
  model MediaLiveEventEncoderDisconnectedEventData {
    ...MediaLiveEventConnectionBaseData;

    @doc("Gets the result code.")
    resultCode?: string;
  }

  @doc("Encoder connect event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingStreamReceived event.")
  model MediaLiveEventIncomingStreamReceivedEventData {
    @visibility("read")
    @doc("Gets the ingest URL provided by the live event.")
    ingestUrl?: string;

    @visibility("read")
    @doc("Gets the type of the track (Audio / Video).")
    trackType?: string;

    @visibility("read")
    @doc("Gets the track name.")
    trackName?: string;

    @visibility("read")
    @doc("Gets the bitrate of the track.")
    bitrate?: int64;

    @visibility("read")
    @doc("Gets the remote IP.")
    encoderIp?: string;

    @visibility("read")
    @doc("Gets the remote port.")
    encoderPort?: string;

    @visibility("read")
    @doc("Gets the first timestamp of the data chunk received.")
    timestamp?: string;

    @visibility("read")
    @doc("Gets the duration of the first data chunk.")
    duration?: string;

    @visibility("read")
    @doc("Gets the timescale in which timestamp is represented.")
    timescale?: string;
  }

  @doc("Incoming streams out of sync event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingStreamsOutOfSync event.")
  model MediaLiveEventIncomingStreamsOutOfSyncEventData {
    @visibility("read")
    @doc("Gets the minimum last timestamp received.")
    minLastTimestamp?: string;

    @visibility("read")
    @doc("Gets the type of stream with minimum last timestamp.")
    typeOfStreamWithMinLastTimestamp?: string;

    @visibility("read")
    @doc("Gets the maximum timestamp among all the tracks (audio or video).")
    maxLastTimestamp?: string;

    @visibility("read")
    @doc("Gets the type of stream with maximum last timestamp.")
    typeOfStreamWithMaxLastTimestamp?: string;

    @visibility("read")
    @doc("Gets the timescale in which \"MinLastTimestamp\" is represented.")
    timescaleOfMinLastTimestamp?: string;

    @visibility("read")
    @doc("Gets the timescale in which \"MaxLastTimestamp\" is represented.")
    timescaleOfMaxLastTimestamp?: string;
  }

  @doc("Incoming video stream out of sync event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingVideoStreamsOutOfSync event.")
  model MediaLiveEventIncomingVideoStreamsOutOfSyncEventData {
    @visibility("read")
    @doc("Gets the first timestamp received for one of the quality levels.")
    firstTimestamp?: string;

    @visibility("read")
    @doc("Gets the duration of the data chunk with first timestamp.")
    firstDuration?: string;

    @visibility("read")
    @doc("Gets the timestamp received for some other quality levels.")
    secondTimestamp?: string;

    @visibility("read")
    @doc("Gets the duration of the data chunk with second timestamp.")
    secondDuration?: string;

    @visibility("read")
    @doc("Gets the timescale in which both the timestamps and durations are represented.")
    timescale?: string;
  }

  @doc("Ingest fragment dropped event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingDataChunkDropped event.")
  model MediaLiveEventIncomingDataChunkDroppedEventData {
    @visibility("read")
    @doc("Gets the timestamp of the data chunk dropped.")
    timestamp?: string;

    @visibility("read")
    @doc("Gets the type of the track (Audio / Video).")
    trackType?: string;

    @visibility("read")
    @doc("Gets the bitrate of the track.")
    bitrate?: int64;

    @visibility
    @doc("Gets the timescale of the Timestamp.")
    timescale?: string;

    @visibility("read")
    @doc("Gets the result code for fragment drop operation.")
    resultCode?: string;

    @visibility("read")
    @doc("Gets the name of the track for which fragment is dropped.")
    trackName?: string;
  }

  @doc("Ingest heartbeat event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIngestHeartbeat event.")
  model MediaLiveEventIngestHeartbeatEventData {
    @visibility("read")
    @doc("Gets the type of the track (Audio / Video).")
    trackType?: string;

    @visibility("read")
    @doc("Gets the track name.")
    trackName?: string;

    @visibility("read")
    @doc("Gets the Live Transcription language.")
    transcriptionLanguage?: string;

    @visibility("read")
    @doc("Gets the Live Transcription state.")
    transcriptionState?: string;

    @visibility("read")
    @doc("Gets the bitrate of the track.")
    bitrate?: int64;

    @visibility("read")
    @doc("Gets the incoming bitrate.")
    incomingBitrate?: int64;

    @visibility("read")
    @doc("Gets the track ingest drift value.")
    ingestDriftValue?: string;

    @visibility("read")
    @doc("Gets the arrival UTC time of the last fragment.")
    lastFragmentArrivalTime?: string;

    @visibility("read")
    @doc("Gets the last timestamp.")
    lastTimestamp?: string;

    @visibility("read")
    @doc("Gets the timescale of the last timestamp.")
    timescale?: string;

    @visibility("read")
    @doc("Gets the fragment Overlap count.")
    overlapCount?: int64;

    @visibility("read")
    @doc("Gets the fragment Discontinuity count.")
    discontinuityCount?: int64;

    @visibility("read")
    @doc("Gets Non increasing count.")
    nonincreasingCount?: int64;

    @visibility("read")
    @doc("Gets a value indicating whether unexpected bitrate is present or not.")
    unexpectedBitrate?: boolean;

    @visibility("read")
    @doc("Gets the state of the live event.")
    state?: string;

    @visibility("read")
    @doc("Gets a value indicating whether preview is healthy or not.")
    healthy?: boolean;
  }

  @doc("Ingest track discontinuity detected event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventTrackDiscontinuityDetected event.")
  model MediaLiveEventTrackDiscontinuityDetectedEventData {
    @visibility("read")
    @doc("Gets the type of the track (Audio / Video).")
    trackType?: string;

    @visibility("read")
    @doc("Gets the track name.")
    trackName?: string;

    @visibility("read")
    @doc("Gets the bitrate.")
    bitrate?: int64;

    @visibility("read")
    @doc("Gets the timestamp of the previous fragment.")
    previousTimestamp?: string;

    @visibility("read")
    @doc("Gets the timestamp of the current fragment.")
    newTimestamp?: string;

    @visibility("read")
    @doc("Gets the timescale in which both timestamps and discontinuity gap are represented.")
    timescale?: string;

    @visibility("read")
    @doc("Gets the discontinuity gap between PreviousTimestamp and NewTimestamp.")
    discontinuityGap?: string;
  }

  @doc("Channel Archive heartbeat event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventChannelArchiveHeartbeat event.")
  model MediaLiveEventChannelArchiveHeartbeatEventData {
    @visibility("read")
    @doc("Gets the channel latency in ms.")
    channelLatencyMs: string;

    @visibility("read")
    @doc("Gets the latency result code.")
    latencyResultCode: string;
  }

  alias MediaLiveEventConnectionBaseData = {
    @visibility("read")
    @doc("Gets the ingest URL provided by the live event.")
    ingestUrl?: string;

    @visibility("read")
    @doc("Gets the stream Id.")
    streamId?: string;

    @visibility("read")
    @doc("Gets the remote IP.")
    encoderIp?: string;

    @visibility("read")
    @doc("Gets the remote port.")
    encoderPort?: string;
  };
}
