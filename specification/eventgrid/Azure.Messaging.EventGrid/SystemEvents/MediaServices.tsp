@doc("Describes the schema of the Azure Media Services events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace EventGrid.MediaServices {
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

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Media.JobStateChange event.")
  model MediaJobStateChangeEventData {
    @doc("The previous state of the Job.")
    previousState?: MediaJobState;

    @doc("The new state of the Job.")
    state?: MediaJobState;

    @doc("Gets the Job correlation data.")
    correlationData?: Record<string>;
  }

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

  enum MediaJobRetry {
    @doc("Issue needs to be investigated and then the job resubmitted with corrections or retried once the underlying issue has been corrected.")
    DoNotRetry,

    @doc("Issue may be resolved after waiting for a period of time and resubmitting the same Job.")
    MayRetry,
  }

  @doc("Details of JobOutput errors.")
  model MediaJobError {
    @doc("Error code describing the error.")
    code?: MediaJobErrorCode;

    @doc("A human-readable language-dependent representation of the error.")
    message?: string;

    @doc("Helps with categorization of errors.")
    category?: MediaJobErrorCategory;

    @doc("Indicates that it may be possible to retry the Job. If retry is unsuccessful, please contact Azure support via Azure Portal.")
    retry?: MediaJobRetry;

    @doc("An array of details about specific errors that led to this reported error.")
    details?: MediaJobErrorDetail[];
  }

  @doc("Details of JobOutput errors.")
  model MediaJobErrorDetail {
    @doc("Code describing the error detail.")
    code?: string;

    @doc("A human-readable representation of the error.")
    message?: string;
  }

  @doc("The event data for a Job output.")
  @discriminator("@odata.type")
  model MediaJobOutput {
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
    @doc("The discriminator for derived types.")
    @projectedName("json", "@odata.type")
    OdataType?: string;

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
  @discriminator("#Microsoft.Media.JobOutputAsset")
  model MediaJobOutputAsset {
    @doc("Gets the Job output asset name.")
    assetName?: string;
  }

  @doc("Job Output Progress Event Data. Schema of the Data property of an EventGridEvent for a Microsoft.Media.JobOutputProgress event.")
  @discriminator("#Microsoft.Media.JobOutputProgress")
  model MediaJobOutputProgressEventData {
    @doc("Gets the Job output label.")
    label?: string;

    @doc("Gets the Job output progress.")
    progress?: int64;

    @doc("Gets the Job correlation data.")
    jobCorrelationData?: Record<string>;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Media.JobOutputStateChange event.")
  model MediaJobOutputStateChangeEventData {
    @doc("The previous state of the Job.")
    previousState?: MediaJobState;

    @doc("Gets the output.")
    output?: MediaJobOutput;

    @doc("Gets the Job correlation data.")
    jobCorrelationData?: Record<string>;
  }

  @doc("Job scheduled event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.JobScheduled event.")
  @discriminator("#Microsoft.Media.JobScheduled")
  model MediaJobScheduledEventData extends MediaJobStateChangeEventData {}

  @doc("Job processing event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.JobProcessing event.")
  @discriminator("#Microsoft.Media.JobProcessing")
  model MediaJobProcessingEventData extends MediaJobStateChangeEventData {}

  @doc("Job canceling event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.JobCanceling event.")
  @discriminator("#Microsoft.Media.JobCanceling")
  model MediaJobCancelingEventData extends MediaJobStateChangeEventData {}

  @doc("Job finished event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.JobFinished event.")
  @discriminator("#Microsoft.Media.JobFinished")
  model MediaJobFinishedEventData extends MediaJobStateChangeEventData {
    @doc("Gets the Job outputs.")
    outputs?: MediaJobOutput[];
  }

  @doc("Job canceled event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.JobCanceled event.")
  @discriminator("#Microsoft.Media.JobCanceled")
  model MediaJobCanceledEventData extends MediaJobStateChangeEventData {
    @doc("Gets the Job outputs.")
    outputs?: MediaJobOutput[];
  }

  @doc("Job error state event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.JobErrored event.")
  @discriminator("#Microsoft.Media.JobErrored")
  model MediaJobErroredEventData extends MediaJobStateChangeEventData {
    @doc("Gets the Job outputs.")
    outputs?: MediaJobOutput[];
  }

  @doc("Job output canceled event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.JobOutputCanceled event.")
  @discriminator("#Microsoft.Media.JobOutputCanceled")
  model MediaJobOutputCanceledEventData
    extends MediaJobOutputStateChangeEventData {}

  @doc("Job output canceling event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.JobOutputCanceling event.")
  @discriminator("#Microsoft.Media.JobOutputCanceling")
  model MediaJobOutputCancelingEventData
    extends MediaJobOutputStateChangeEventData {}

  @doc("Job output error event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.JobOutputErrored event.")
  @discriminator("#Microsoft.Media.JobOutputErrored")
  model MediaJobOutputErroredEventData
    extends MediaJobOutputStateChangeEventData {}

  @doc("Job output finished event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.JobOutputFinished event.")
  @discriminator("#Microsoft.Media.JobOutputFinished")
  model MediaJobOutputFinishedEventData
    extends MediaJobOutputStateChangeEventData {}

  @doc("Job output processing event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.JobOutputProcessing event.")
  @discriminator("#Microsoft.Media.JobOutputProcessing")
  model MediaJobOutputProcessingEventData
    extends MediaJobOutputStateChangeEventData {}

  @doc("Job output scheduled event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.JobOutputScheduled event.")
  @discriminator("#Microsoft.Media.JobOutputCanceled")
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
    @doc("Gets the ingest URL provided by the live event.")
    ingestUrl?: string;

    @doc("Gets the type of the track (Audio / Video).")
    trackType?: string;

    @doc("Gets the track name.")
    trackName?: string;

    @doc("Gets the bitrate of the track.")
    bitrate?: int64;

    @doc("Gets the remote IP.")
    encoderIp?: string;

    @doc("Gets the remote port.")
    encoderPort?: string;

    @doc("Gets the first timestamp of the data chunk received.")
    timestamp?: string;

    @doc("Gets the duration of the first data chunk.")
    duration?: string;

    @doc("Gets the timescale in which timestamp is represented.")
    timescale?: string;
  }

  @doc("Incoming streams out of sync event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingStreamsOutOfSync event.")
  model MediaLiveEventIncomingStreamsOutOfSyncEventData {
    @doc("Gets the minimum last timestamp received.")
    minLastTimestamp?: string;

    @doc("Gets the type of stream with minimum last timestamp.")
    typeOfStreamWithMinLastTimestamp?: string;

    @doc("Gets the maximum timestamp among all the tracks (audio or video).")
    maxLastTimestamp?: string;

    @doc("Gets the type of stream with maximum last timestamp.")
    typeOfStreamWithMaxLastTimestamp?: string;

    @doc("Gets the timescale in which \"MinLastTimestamp\" is represented.")
    timescaleOfMinLastTimestamp?: string;

    @doc("Gets the timescale in which \"MaxLastTimestamp\" is represented.")
    timescaleOfMaxLastTimestamp?: string;
  }

  @doc("Incoming video stream out of sync event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingVideoStreamsOutOfSync event.")
  model MediaLiveEventIncomingVideoStreamsOutOfSyncEventData {
    @doc("Gets the first timestamp received for one of the quality levels.")
    firstTimestamp?: string;

    @doc("Gets the duration of the data chunk with first timestamp.")
    firstDuration?: string;

    @doc("Gets the timestamp received for some other quality levels.")
    secondTimestamp?: string;

    @doc("Gets the duration of the data chunk with second timestamp.")
    secondDuration?: string;

    @doc("Gets the timescale in which both the timestamps and durations are represented.")
    timescale?: string;
  }

  @doc("Ingest fragment dropped event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIncomingDataChunkDropped event.")
  model MediaLiveEventIncomingDataChunkDroppedEventData {
    @doc("Gets the timestamp of the data chunk dropped.")
    timestamp?: string;

    @doc("Gets the type of the track (Audio / Video).")
    trackType?: string;

    @doc("Gets the bitrate of the track.")
    bitrate?: int64;

    @doc("Gets the timescale of the Timestamp.")
    timescale?: string;

    @doc("Gets the result code for fragment drop operation.")
    resultCode?: string;

    @doc("Gets the name of the track for which fragment is dropped.")
    trackName?: string;
  }

  @doc("Ingest heartbeat event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventIngestHeartbeat event.")
  model MediaLiveEventIngestHeartbeatEventData {
    @doc("Gets the type of the track (Audio / Video).")
    trackType?: string;

    @doc("Gets the track name.")
    trackName?: string;

    @doc("Gets the Live Transcription language.")
    transcriptionLanguage?: string;

    @doc("Gets the Live Transcription state.")
    transcriptionState?: string;

    @doc("Gets the bitrate of the track.")
    bitrate?: int64;

    @doc("Gets the incoming bitrate.")
    incomingBitrate?: int64;

    @doc("Gets the track ingest drift value.")
    ingestDriftValue?: string;

    @doc("Gets the arrival UTC time of the last fragment.")
    lastFragmentArrivalTime?: string;

    @doc("Gets the last timestamp.")
    lastTimestamp?: string;

    @doc("Gets the timescale of the last timestamp.")
    timescale?: string;

    @doc("Gets the fragment Overlap count.")
    overlapCount?: int64;

    @doc("Gets the fragment Discontinuity count.")
    discontinuityCount?: int64;

    @doc("Gets Non increasing count.")
    nonincreasingCount?: int64;

    @doc("Gets a value indicating whether unexpected bitrate is present or not.")
    unexpectedBitrate?: boolean;

    @doc("Gets the state of the live event.")
    state?: string;

    @doc("Gets a value indicating whether preview is healthy or not.")
    healthy?: boolean;
  }

  @doc("Ingest track discontinuity detected event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventTrackDiscontinuityDetected event.")
  model MediaLiveEventTrackDiscontinuityDetectedEventData {
    @doc("Gets the type of the track (Audio / Video).")
    trackType?: string;

    @doc("Gets the track name.")
    trackName?: string;

    @doc("Gets the bitrate.")
    bitrate?: int64;

    @doc("Gets the timestamp of the previous fragment.")
    previousTimestamp?: string;

    @doc("Gets the timestamp of the current fragment.")
    newTimestamp?: string;

    @doc("Gets the timescale in which both timestamps and discontinuity gap are represented.")
    timescale?: string;

    @doc("Gets the discontinuity gap between PreviousTimestamp and NewTimestamp.")
    discontinuityGap?: string;
  }

  @doc("Channel Archive heartbeat event data. Schema of the data property of an EventGridEvent for a Microsoft.Media.LiveEventChannelArchiveHeartbeat event.")
  model MediaLiveEventChannelArchiveHeartbeatEventData {
    @doc("Gets the channel latency in ms.")
    channelLatencyMs: string;

    @doc("Gets the latency result code.")
    latencyResultCode: string;
  }

  alias MediaLiveEventConnectionBaseData = {
    @doc("Gets the ingest URL provided by the live event.")
    ingestUrl?: string;

    @doc("Gets the stream Id.")
    streamId?: string;

    @doc("Gets the remote IP.")
    encoderIp?: string;

    @doc("Gets the remote port.")
    encoderPort?: string;
  };
}
