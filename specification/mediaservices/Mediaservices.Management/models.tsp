import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Media;

/**
 * The track property type.
 */
union FilterTrackPropertyType {
  string,

  /**
   * The unknown track property type.
   */
  Unknown: "Unknown",

  /**
   * The type.
   */
  Type: "Type",

  /**
   * The name.
   */
  Name: "Name",

  /**
   * The language.
   */
  Language: "Language",

  /**
   * The fourCC.
   */
  FourCC: "FourCC",

  /**
   * The bitrate.
   */
  Bitrate: "Bitrate",
}

/**
 * The track property condition operation.
 */
union FilterTrackPropertyCompareOperation {
  string,

  /**
   * The equal operation.
   */
  Equal: "Equal",

  /**
   * The not equal operation.
   */
  NotEqual: "NotEqual",
}

/**
 * The metric unit
 */
union MetricUnit {
  string,

  /**
   * The number of bytes.
   */
  Bytes: "Bytes",

  /**
   * The count.
   */
  Count: "Count",

  /**
   * The number of milliseconds.
   */
  Milliseconds: "Milliseconds",
}

/**
 * The metric aggregation type
 */
union MetricAggregationType {
  string,

  /**
   * The average.
   */
  Average: "Average",

  /**
   * The count of a number of items, usually requests.
   */
  Count: "Count",

  /**
   * The sum.
   */
  Total: "Total",
}

/**
 * The type of the storage account.
 */
union StorageAccountType {
  string,

  /**
   * The primary storage account for the Media Services account.
   */
  Primary: "Primary",

  /**
   * A secondary storage account for the Media Services account.
   */
  Secondary: "Secondary",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union StorageAuthentication {
  string,

  /**
   * System authentication.
   */
  System: "System",

  /**
   * Managed Identity authentication.
   */
  ManagedIdentity: "ManagedIdentity",
}

/**
 * The type of key used to encrypt the Account Key.
 */
union AccountEncryptionKeyType {
  string,

  /**
   * The Account Key is encrypted with a System Key.
   */
  SystemKey: "SystemKey",

  /**
   * The Account Key is encrypted with a Customer Key.
   */
  CustomerKey: "CustomerKey",
}

/**
 * The behavior for IP access control in Key Delivery.
 */
union DefaultAction {
  string,

  /**
   * All public IP addresses are allowed.
   */
  Allow: "Allow",

  /**
   * Public IP addresses are blocked.
   */
  Deny: "Deny",
}

/**
 * Whether or not public network access is allowed for resources under the Media Services account.
 */
union PublicNetworkAccess {
  string,

  /**
   * Public network access is enabled.
   */
  Enabled: "Enabled",

  /**
   * Public network access is disabled.
   */
  Disabled: "Disabled",
}

/**
 * Provisioning state of the Media Services account.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,

  /**
   * Provisioning state failed.
   */
  Failed: "Failed",

  /**
   * Provisioning state in progress.
   */
  InProgress: "InProgress",

  /**
   * Provisioning state succeeded.
   */
  Succeeded: "Succeeded",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union PrivateEndpointConnectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * The minimum TLS version allowed for this account's requests. This is an optional property. If unspecified, a secure default value will be used.
 */
union MinimumTlsVersion {
  string,

  /**
   * Minimum TLS version is TLS 1.0.
   */
  Tls10: "Tls10",

  /**
   * Minimum TLS version is TLS 1.1.
   */
  Tls11: "Tls11",

  /**
   * Minimum TLS version is TLS 1.2.
   */
  Tls12: "Tls12",

  /**
   * Minimum TLS version is TLS 1.3.
   */
  Tls13: "Tls13",
}

/**
 * The Asset encryption format. One of None or MediaStorageEncryption.
 */
union AssetStorageEncryptionFormat {
  string,

  /**
   * The Asset does not use client-side storage encryption (this is the only allowed value for new Assets).
   */
  None: "None",

  /**
   * The Asset is encrypted with Media Services client-side encryption.
   */
  MediaStorageClientEncryption: "MediaStorageClientEncryption",
}

/**
 * The permissions to set on the SAS URL.
 */
union AssetContainerPermission {
  string,

  /**
   * The SAS URL will allow read access to the container.
   */
  Read: "Read",

  /**
   * The SAS URL will allow read and write access to the container.
   */
  ReadWrite: "ReadWrite",

  /**
   * The SAS URL will allow read, write and delete access to the container.
   */
  ReadWriteDelete: "ReadWriteDelete",
}

/**
 * A Transform can define more than one outputs. This property defines what the service should do when one output fails - either continue to produce other outputs, or, stop the other outputs. The overall Job state will not reflect failures of outputs that are specified with 'ContinueJob'. The default is 'StopProcessingJob'.
 */
union OnErrorType {
  string,

  /**
   * Tells the service that if this TransformOutput fails, then any other incomplete TransformOutputs can be stopped.
   */
  StopProcessingJob: "StopProcessingJob",

  /**
   * Tells the service that if this TransformOutput fails, then allow any other TransformOutput to continue.
   */
  ContinueJob: "ContinueJob",
}

/**
 * Sets the relative priority of the TransformOutputs within a Transform. This sets the priority that the service uses for processing TransformOutputs. The default priority is Normal.
 */
union Priority {
  string,

  /**
   * Used for TransformOutputs that can be generated after Normal and High priority TransformOutputs.
   */
  Low: "Low",

  /**
   * Used for TransformOutputs that can be generated at Normal priority.
   */
  Normal: "Normal",

  /**
   * Used for TransformOutputs that should take precedence over others.
   */
  High: "High",
}

/**
 * Describes the state of the JobOutput.
 */
union JobState {
  string,

  /**
   * The job was canceled. This is a final state for the job.
   */
  Canceled: "Canceled",

  /**
   * The job is in the process of being canceled. This is a transient state for the job.
   */
  Canceling: "Canceling",

  /**
   * The job has encountered an error. This is a final state for the job.
   */
  Error: "Error",

  /**
   * The job is finished. This is a final state for the job.
   */
  Finished: "Finished",

  /**
   * The job is processing. This is a transient state for the job.
   */
  Processing: "Processing",

  /**
   * The job is in a queued state, waiting for resources to become available. This is a transient state.
   */
  Queued: "Queued",

  /**
   * The job is being scheduled to run on an available resource. This is a transient state, between queued and processing states.
   */
  Scheduled: "Scheduled",
}

/**
 * Error code describing the error.
 */
union JobErrorCode {
  string,

  /**
   * Fatal service error, please contact support.
   */
  ServiceError: "ServiceError",

  /**
   * Transient error, please retry, if retry is unsuccessful, please contact support.
   */
  ServiceTransientError: "ServiceTransientError",

  /**
   * While trying to download the input files, the files were not accessible, please check the availability of the source.
   */
  DownloadNotAccessible: "DownloadNotAccessible",

  /**
   * While trying to download the input files, there was an issue during transfer (storage service, network errors), see details and check your source.
   */
  DownloadTransientError: "DownloadTransientError",

  /**
   * While trying to upload the output files, the destination was not reachable, please check the availability of the destination.
   */
  UploadNotAccessible: "UploadNotAccessible",

  /**
   * While trying to upload the output files, there was an issue during transfer (storage service, network errors), see details and check your destination.
   */
  UploadTransientError: "UploadTransientError",

  /**
   * There was a problem with the combination of input files and the configuration settings applied, fix the configuration settings and retry with the same input, or change input to match the configuration.
   */
  ConfigurationUnsupported: "ConfigurationUnsupported",

  /**
   * There was a problem with the input content (for example: zero byte files, or corrupt/non-decodable files), check the input files.
   */
  ContentMalformed: "ContentMalformed",

  /**
   * There was a problem with the format of the input (not valid media file, or an unsupported file/codec), check the validity of the input files.
   */
  ContentUnsupported: "ContentUnsupported",

  /**
   * There was an error verifying to the account identity. Check and fix the identity configurations and retry. If unsuccessful, please contact support.
   */
  IdentityUnsupported: "IdentityUnsupported",
}

/**
 * Helps with categorization of errors.
 */
union JobErrorCategory {
  string,

  /**
   * The error is service related.
   */
  Service: "Service",

  /**
   * The error is download related.
   */
  Download: "Download",

  /**
   * The error is upload related.
   */
  Upload: "Upload",

  /**
   * The error is configuration related.
   */
  Configuration: "Configuration",

  /**
   * The error is related to data in the input files.
   */
  Content: "Content",

  /**
   * The error is related to account information.
   */
  Account: "Account",
}

/**
 * Indicates that it may be possible to retry the Job. If retry is unsuccessful, please contact Azure support via Azure Portal.
 */
union JobRetry {
  string,

  /**
   * Issue needs to be investigated and then the job resubmitted with corrections or retried once the underlying issue has been corrected.
   */
  DoNotRetry: "DoNotRetry",

  /**
   * Issue may be resolved after waiting for a period of time and resubmitting the same Job.
   */
  MayRetry: "MayRetry",
}

/**
 * Track property type
 */
union TrackPropertyType {
  string,

  /**
   * Unknown track property
   */
  Unknown: "Unknown",

  /**
   * Track FourCC
   */
  FourCC: "FourCC",
}

/**
 * Track property condition operation
 */
union TrackPropertyCompareOperation {
  string,

  /**
   * Unknown track property compare operation
   */
  Unknown: "Unknown",

  /**
   * Equal operation
   */
  Equal: "Equal",
}

/**
 * Encryption type of Content Key
 */
union StreamingLocatorContentKeyType {
  string,

  /**
   * Common Encryption using CENC
   */
  CommonEncryptionCenc: "CommonEncryptionCenc",

  /**
   * Common Encryption using CBCS
   */
  CommonEncryptionCbcs: "CommonEncryptionCbcs",

  /**
   * Envelope Encryption
   */
  EnvelopeEncryption: "EnvelopeEncryption",
}

/**
 * Streaming protocol
 */
union StreamingPolicyStreamingProtocol {
  string,

  /**
   * HLS protocol
   */
  Hls: "Hls",

  /**
   * DASH protocol
   */
  Dash: "Dash",

  /**
   * SmoothStreaming protocol
   */
  SmoothStreaming: "SmoothStreaming",

  /**
   * Download protocol
   */
  Download: "Download",
}

/**
 * Encryption scheme
 */
union EncryptionScheme {
  string,

  /**
   * NoEncryption scheme
   */
  NoEncryption: "NoEncryption",

  /**
   * EnvelopeEncryption scheme
   */
  EnvelopeEncryption: "EnvelopeEncryption",

  /**
   * CommonEncryptionCenc scheme
   */
  CommonEncryptionCenc: "CommonEncryptionCenc",

  /**
   * CommonEncryptionCbcs scheme
   */
  CommonEncryptionCbcs: "CommonEncryptionCbcs",
}

/**
 * The input protocol for the live event. This is specified at creation time and cannot be updated.
 */
union LiveEventInputProtocol {
  string,

  /**
   * Smooth Streaming input will be sent by the contribution encoder to the live event.
   */
  FragmentedMP4: "FragmentedMP4",

  /**
   * RTMP input will be sent by the contribution encoder to the live event.
   */
  RTMP: "RTMP",
}

/**
 * Live event type. When encodingType is set to PassthroughBasic or PassthroughStandard, the service simply passes through the incoming video and audio layer(s) to the output. When encodingType is set to Standard or Premium1080p, a live encoder transcodes the incoming stream into multiple bitrates or layers. See https://go.microsoft.com/fwlink/?linkid=2095101 for more information. This property cannot be modified after the live event is created.
 */
union LiveEventEncodingType {
  string,

  /**
   * This is the same as PassthroughStandard, please see description below. This enumeration value is being deprecated.
   */
  None: "None",

  /**
   * A contribution live encoder sends a single bitrate stream to the live event and Media Services creates multiple bitrate streams. The output cannot exceed 720p in resolution.
   */
  Standard: "Standard",

  /**
   * A contribution live encoder sends a single bitrate stream to the live event and Media Services creates multiple bitrate streams. The output cannot exceed 1080p in resolution.
   */
  Premium1080p: "Premium1080p",

  /**
   * The ingested stream passes through the live event from the contribution encoder without any further processing. In the PassthroughBasic mode, ingestion is limited to up to 5Mbps and only 1 concurrent live output is allowed. Live transcription is not available.
   */
  PassthroughBasic: "PassthroughBasic",

  /**
   * The ingested stream passes through the live event from the contribution encoder without any further processing. Live transcription is available. Ingestion bitrate limits are much higher and up to 3 concurrent live outputs are allowed.
   */
  PassthroughStandard: "PassthroughStandard",
}

/**
 * The resizing mode - how the input video will be resized to fit the desired output resolution(s). Default is AutoSize
 */
union StretchMode {
  string,

  /**
   * Strictly respect the output resolution without considering the pixel aspect ratio or display aspect ratio of the input video.
   */
  None: "None",

  /**
   * Override the output resolution, and change it to match the display aspect ratio of the input, without padding. For example, if the input is 1920x1080 and the encoding preset asks for 1280x1280, then the value in the preset is overridden, and the output will be at 1280x720, which maintains the input aspect ratio of 16:9.
   */
  AutoSize: "AutoSize",

  /**
   * Pad the output (with either letterbox or pillar box) to honor the output resolution, while ensuring that the active video region in the output has the same aspect ratio as the input. For example, if the input is 1920x1080 and the encoding preset asks for 1280x1280, then the output will be at 1280x1280, which contains an inner rectangle of 1280x720 at aspect ratio of 16:9, and pillar box regions 280 pixels wide at the left and right.
   */
  AutoFit: "AutoFit",
}

/**
 * The resource state of the live event. See https://go.microsoft.com/fwlink/?linkid=2139012 for more information.
 */
union LiveEventResourceState {
  string,

  /**
   * This is the initial state of the live event after creation (unless autostart was set to true.) No billing occurs in this state. In this state, the live event properties can be updated but streaming is not allowed.
   */
  Stopped: "Stopped",

  /**
   * Allocate action was called on the live event and resources are being provisioned for this live event. Once allocation completes successfully, the live event will transition to StandBy state.
   */
  Allocating: "Allocating",

  /**
   * Live event resources have been provisioned and is ready to start. Billing occurs in this state. Most properties can still be updated, however ingest or streaming is not allowed during this state.
   */
  StandBy: "StandBy",

  /**
   * The live event is being started and resources are being allocated. No billing occurs in this state. Updates or streaming are not allowed during this state. If an error occurs, the live event returns to the Stopped state.
   */
  Starting: "Starting",

  /**
   * The live event resources have been allocated, ingest and preview URLs have been generated, and it is capable of receiving live streams. At this point, billing is active. You must explicitly call Stop on the live event resource to halt further billing.
   */
  Running: "Running",

  /**
   * The live event is being stopped and resources are being de-provisioned. No billing occurs in this transient state. Updates or streaming are not allowed during this state.
   */
  Stopping: "Stopping",

  /**
   * The live event is being deleted. No billing occurs in this transient state. Updates or streaming are not allowed during this state.
   */
  Deleting: "Deleting",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union StreamOptionsFlag {
  string,

  /**
   * Live streaming with no special latency optimizations.
   */
  Default: "Default",

  /**
   * The live event provides lower end to end latency by reducing its internal buffers.
   */
  LowLatency: "LowLatency",

  /**
   * The live event is optimized for end to end latency. This option is only available for encoding live events with RTMP input. The outputs can be streamed using HLS or DASH formats. The outputs' archive or DVR rewind length is limited to 6 hours. Use "LowLatency" stream option for all other scenarios.
   */
  LowLatencyV2: "LowLatencyV2",
}

/**
 * Current state of the live event. See https://go.microsoft.com/fwlink/?linkid=2139012 for more information.
 */
union LiveEventState {
  string,

  /**
   * This is the initial state of the live event after creation (unless autostart was set to true.) No billing occurs in this state. In this state, the live event properties can be updated but streaming is not allowed.
   */
  Stopped: "Stopped",

  /**
   * The live event resources have been allocated, ingest and preview URLs have been generated, and it is capable of receiving live streams. At this point, billing is active. You must explicitly call Stop on the live event resource to halt further billing.
   */
  Running: "Running",
}

/**
 * Health status of last 20 seconds.
 */
union LiveEventHealthStatus {
  string,

  /**
   * Incoming bitrate >= 75% of target bitrate AND no Ingest warning and error AND ABS(IngestDrift) is equal to 0.
   */
  Excellent: "Excellent",

  /**
   * Incoming bitrate >= 20% AND no Ingest Error or warning exception discontinuities which gap < 10 seconds.
   */
  Good: "Good",

  /**
   * Otherwise.
   */
  Poor: "Poor",
}

/**
 * The type of the stream event. Format: StreamEvent/{eventType}
 */
union LiveEventStreamEventType {
  string,

  /**
   * Ingest session begins.
   */
  `StreamEvent/BeginIngest`: "StreamEvent/BeginIngest",

  /**
   * Ingest session ends.
   */
  `StreamEvent/EndIngest`: "StreamEvent/EndIngest",

  /**
   * First fragment received on ingest media track.
   */
  `StreamEvent/FirstChunkReceived`: "StreamEvent/FirstChunkReceived",

  /**
   * Fragment dropped.
   */
  `StreamEvent/ChunkDropped`: "StreamEvent/ChunkDropped",

  /**
   * Unaligned video keyframes detected.
   */
  `StreamEvent/UnalignedKeyFrames`: "StreamEvent/UnalignedKeyFrames",

  /**
   * Unaligned presentation detected, meaning two fragments across two quality levels are not time aligned.
   */
  `StreamEvent/UnalignedPresentation`: "StreamEvent/UnalignedPresentation",

  /**
   * Timestamp discontinuity detected.
   */
  `StreamEvent/Discontinuity`: "StreamEvent/Discontinuity",

  /**
   * Ingest session denied.
   */
  `StreamEvent/InvalidConnection`: "StreamEvent/InvalidConnection",
}

/**
 * Event level.
 */
union LiveEventStreamEventLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Critical: "Critical",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Information: "Information",
}

/**
 * Type of the track.
 */
union LiveEventStreamEventMediaType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  audio: "audio",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  video: "video",
}

/**
 * The media type of the smaller timestamp of two fragments compared.
 */
union LiveEventStreamEventMinTimeMediaType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Audio: "Audio",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Video: "Video",
}

/**
 * The media type of the larger timestamp of two fragments compared.
 */
union LiveEventStreamEventMaxTimeMediaType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Audio: "Audio",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Video: "Video",
}

/**
 * The type of the track event.
 */
union LiveEventTrackEventType {
  string,

  /**
   * Track heartbeat received.
   */
  `TrackEvent/IngestHeartbeat`: "TrackEvent/IngestHeartbeat",
}

/**
 * Type of the track.
 */
union LiveEventTrackEventTrackType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  audio: "audio",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  video: "video",
}

/**
 * Operation status of the async operation.
 */
union AsyncOperationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
}

/**
 * The resource state of the live output.
 */
union LiveOutputResourceState {
  string,

  /**
   * Live output is being created. No content is archived in the asset until the live output is in running state.
   */
  Creating: "Creating",

  /**
   * Live output is running and archiving live streaming content to the asset if there is valid input from a contribution encoder.
   */
  Running: "Running",

  /**
   * Live output is being deleted. The live asset is being converted from live to on-demand asset. Any streaming URLs created on the live output asset continue to work.
   */
  Deleting: "Deleting",
}

/**
 * The resource state of the streaming endpoint.
 */
union StreamingEndpointResourceState {
  string,

  /**
   * The initial state of a streaming endpoint after creation. Content is not ready to be streamed from this endpoint.
   */
  Stopped: "Stopped",

  /**
   * The streaming endpoint is transitioning to the running state.
   */
  Starting: "Starting",

  /**
   * The streaming endpoint is running. It is able to stream content to clients
   */
  Running: "Running",

  /**
   * The streaming endpoint is transitioning to the stopped state.
   */
  Stopping: "Stopping",

  /**
   * The streaming endpoint is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The streaming endpoint is increasing or decreasing scale units.
   */
  Scaling: "Scaling",
}

/**
 * When PlayerVisibility is set to "Visible", the text track will be present in the DASH manifest or HLS playlist when requested by a client. When the PlayerVisibility is set to "Hidden", the text will not be available to the client. The default value is "Visible".
 */
union Visibility {
  string,

  /**
   * The track is hidden to video player.
   */
  Hidden: "Hidden",

  /**
   * The track is visible to video player.
   */
  Visible: "Visible",
}

/**
 * Configures Unknown output handling settings of the license.
 */
union ContentKeyPolicyPlayReadyUnknownOutputPassingOption {
  string,

  /**
   * Represents a ContentKeyPolicyPlayReadyUnknownOutputPassingOption that is unavailable in current API version.
   */
  Unknown: "Unknown",

  /**
   * Passing the video portion of protected content to an Unknown Output is not allowed.
   */
  NotAllowed: "NotAllowed",

  /**
   * Passing the video portion of protected content to an Unknown Output is allowed.
   */
  Allowed: "Allowed",

  /**
   * Passing the video portion of protected content to an Unknown Output is allowed but with constrained resolution.
   */
  AllowedWithVideoConstriction: "AllowedWithVideoConstriction",
}

/**
 * The security level.
 */
union SecurityLevel {
  string,

  /**
   * Represents a SecurityLevel that is unavailable in current API version.
   */
  Unknown: "Unknown",

  /**
   * For clients under development or test. No protection against unauthorized use.
   */
  SL150: "SL150",

  /**
   * For hardened devices and applications consuming commercial content. Software or hardware protection.
   */
  SL2000: "SL2000",

  /**
   * For hardened devices only. Hardware protection.
   */
  SL3000: "SL3000",
}

/**
 * The license type.
 */
union ContentKeyPolicyPlayReadyLicenseType {
  string,

  /**
   * Represents a ContentKeyPolicyPlayReadyLicenseType that is unavailable in current API version.
   */
  Unknown: "Unknown",

  /**
   * Non persistent license.
   */
  NonPersistent: "NonPersistent",

  /**
   * Persistent license. Allows offline playback.
   */
  Persistent: "Persistent",
}

/**
 * The PlayReady content type.
 */
union ContentKeyPolicyPlayReadyContentType {
  string,

  /**
   * Represents a ContentKeyPolicyPlayReadyContentType that is unavailable in current API version.
   */
  Unknown: "Unknown",

  /**
   * Unspecified content type.
   */
  Unspecified: "Unspecified",

  /**
   * Ultraviolet download content type.
   */
  UltraVioletDownload: "UltraVioletDownload",

  /**
   * Ultraviolet streaming content type.
   */
  UltraVioletStreaming: "UltraVioletStreaming",
}

/**
 * The type of token.
 */
union ContentKeyPolicyRestrictionTokenType {
  string,

  /**
   * Represents a ContentKeyPolicyRestrictionTokenType that is unavailable in current API version.
   */
  Unknown: "Unknown",

  /**
   * Simple Web Token.
   */
  Swt: "Swt",

  /**
   * JSON Web Token.
   */
  Jwt: "Jwt",
}

/**
 * The rental and lease key type.
 */
union ContentKeyPolicyFairPlayRentalAndLeaseKeyType {
  string,

  /**
   * Represents a ContentKeyPolicyFairPlayRentalAndLeaseKeyType that is unavailable in current API version.
   */
  Unknown: "Unknown",

  /**
   * Key duration is not specified.
   */
  Undefined: "Undefined",

  /**
   * Dual expiry for offline rental.
   */
  DualExpiry: "DualExpiry",

  /**
   * Content key can be persisted with an unlimited duration
   */
  PersistentUnlimited: "PersistentUnlimited",

  /**
   * Content key can be persisted and the valid duration is limited by the Rental Duration value
   */
  PersistentLimited: "PersistentLimited",
}

/**
 * The encoding profile to be used when encoding audio with AAC.
 */
union AacAudioProfile {
  string,

  /**
   * Specifies that the output audio is to be encoded into AAC Low Complexity profile (AAC-LC).
   */
  AacLc: "AacLc",

  /**
   * Specifies that the output audio is to be encoded into HE-AAC v1 profile.
   */
  HeAacV1: "HeAacV1",

  /**
   * Specifies that the output audio is to be encoded into HE-AAC v2 profile.
   */
  HeAacV2: "HeAacV2",
}

/**
 * We currently support Main. Default is Auto.
 */
union H265VideoProfile {
  string,

  /**
   * Tells the encoder to automatically determine the appropriate H.265 profile.
   */
  Auto: "Auto",

  /**
   * Main profile (https://x265.readthedocs.io/en/default/cli.html?highlight=profile#profile-level-tier)
   */
  Main: "Main",

  /**
   * Main 10 profile (https://en.wikipedia.org/wiki/High_Efficiency_Video_Coding#Main_10)
   */
  Main10: "Main10",
}

/**
 * The Video Sync Mode
 */
union VideoSyncMode {
  string,

  /**
   * This is the default method. Chooses between Cfr and Vfr depending on muxer capabilities. For output format MP4, the default mode is Cfr.
   */
  Auto: "Auto",

  /**
   * The presentation timestamps on frames are passed through from the input file to the output file writer. Recommended when the input source has variable frame rate, and are attempting to produce multiple layers for adaptive streaming in the output which have aligned GOP boundaries. Note: if two or more frames in the input have duplicate timestamps, then the output will also have the same behavior
   */
  Passthrough: "Passthrough",

  /**
   * Input frames will be repeated and/or dropped as needed to achieve exactly the requested constant frame rate. Recommended when the output frame rate is explicitly set at a specified value
   */
  Cfr: "Cfr",

  /**
   * Similar to the Passthrough mode, but if the input has frames that have duplicate timestamps, then only one frame is passed through to the output, and others are dropped. Recommended when the number of output frames is expected to be equal to the number of input frames. For example, the output is used to calculate a quality metric like PSNR against the input
   */
  Vfr: "Vfr",
}

/**
 * Tells the encoder how to choose its encoding settings.  Quality will provide for a higher compression ratio but at a higher cost and longer compute time.  Speed will produce a relatively larger file but is faster and more economical. The default value is Balanced.
 */
union H265Complexity {
  string,

  /**
   * Tells the encoder to use settings that are optimized for faster encoding. Quality is sacrificed to decrease encoding time.
   */
  Speed: "Speed",

  /**
   * Tells the encoder to use settings that achieve a balance between speed and quality.
   */
  Balanced: "Balanced",

  /**
   * Tells the encoder to use settings that are optimized to produce higher quality output at the expense of slower overall encode time.
   */
  Quality: "Quality",
}

/**
 * Optional designation for single channel audio tracks.  Can be used to combine the tracks into stereo or multi-channel audio tracks.
 */
union ChannelMapping {
  string,

  /**
   * The Front Left Channel.
   */
  FrontLeft: "FrontLeft",

  /**
   * The Front Right Channel.
   */
  FrontRight: "FrontRight",

  /**
   * The Center Channel.
   */
  Center: "Center",

  /**
   * Low Frequency Effects Channel.  Sometimes referred to as the subwoofer.
   */
  LowFrequencyEffects: "LowFrequencyEffects",

  /**
   * The Back Left Channel.  Sometimes referred to as the Left Surround Channel.
   */
  BackLeft: "BackLeft",

  /**
   * The Back Right Channel.  Sometimes referred to as the Right Surround Channel.
   */
  BackRight: "BackRight",

  /**
   * The Left Stereo channel.  Sometimes referred to as Down Mix Left.
   */
  StereoLeft: "StereoLeft",

  /**
   * The Right Stereo channel.  Sometimes referred to as Down Mix Right.
   */
  StereoRight: "StereoRight",
}

/**
 * The TrackAttribute to filter the tracks by.
 */
union TrackAttribute {
  string,

  /**
   * The bitrate of the track.
   */
  Bitrate: "Bitrate",

  /**
   * The language of the track.
   */
  Language: "Language",
}

/**
 * The type of AttributeFilter to apply to the TrackAttribute in order to select the tracks.
 */
union AttributeFilter {
  string,

  /**
   * All tracks will be included.
   */
  All: "All",

  /**
   * The first track will be included when the attribute is sorted in descending order.  Generally used to select the largest bitrate.
   */
  Top: "Top",

  /**
   * The first track will be included when the attribute is sorted in ascending order.  Generally used to select the smallest bitrate.
   */
  Bottom: "Bottom",

  /**
   * Any tracks that have an attribute equal to the value given will be included.
   */
  ValueEquals: "ValueEquals",
}

/**
 * Specifies the maximum resolution at which your video is analyzed. The default behavior is "SourceResolution," which will keep the input video at its original resolution when analyzed. Using "StandardDefinition" will resize input videos to standard definition while preserving the appropriate aspect ratio. It will only resize if the video is of higher resolution. For example, a 1920x1080 input would be scaled to 640x360 before processing. Switching to "StandardDefinition" will reduce the time it takes to process high resolution video. It may also reduce the cost of using this component (see https://azure.microsoft.com/en-us/pricing/details/media-services/#analytics for details). However, faces that end up being too small in the resized video may not be detected.
 */
union AnalysisResolution {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SourceResolution: "SourceResolution",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StandardDefinition: "StandardDefinition",
}

/**
 * This mode provides the ability to choose between the following settings: 1) Analyze - For detection only.This mode generates a metadata JSON file marking appearances of faces throughout the video.Where possible, appearances of the same person are assigned the same ID. 2) Combined - Additionally redacts(blurs) detected faces. 3) Redact - This enables a 2-pass process, allowing for selective redaction of a subset of detected faces.It takes in the metadata file from a prior analyze pass, along with the source video, and a user-selected subset of IDs that require redaction.
 */
union FaceRedactorMode {
  string,

  /**
   * Analyze mode detects faces and outputs a metadata file with the results. Allows editing of the metadata file before faces are blurred with Redact mode.
   */
  Analyze: "Analyze",

  /**
   * Redact mode consumes the metadata file from Analyze mode and redacts the faces found.
   */
  Redact: "Redact",

  /**
   * Combined mode does the Analyze and Redact steps in one pass when editing the analyzed faces is not desired.
   */
  Combined: "Combined",
}

/**
 * Blur type
 */
union BlurType {
  string,

  /**
   * Box: debug filter, bounding box only
   */
  Box: "Box",

  /**
   * Low: box-car blur filter
   */
  Low: "Low",

  /**
   * Med: Gaussian blur filter
   */
  Med: "Med",

  /**
   * High: Confuse blur filter
   */
  High: "High",

  /**
   * Black: Black out filter
   */
  Black: "Black",
}

/**
 * Determines the set of audio analysis operations to be performed. If unspecified, the Standard AudioAnalysisMode would be chosen.
 */
union AudioAnalysisMode {
  string,

  /**
   * Performs all operations included in the Basic mode, additionally performing language detection and speaker diarization.
   */
  Standard: "Standard",

  /**
   * This mode performs speech-to-text transcription and generation of a VTT subtitle/caption file. The output of this mode includes an Insights JSON file including only the keywords, transcription,and timing information. Automatic language detection and speaker diarization are not included in this mode.
   */
  Basic: "Basic",
}

/**
 * The field parity for de-interlacing, defaults to Auto.
 */
union DeinterlaceParity {
  string,

  /**
   * Automatically detect the order of fields
   */
  Auto: "Auto",

  /**
   * Apply top field first processing of input video.
   */
  TopFieldFirst: "TopFieldFirst",

  /**
   * Apply bottom field first processing of input video.
   */
  BottomFieldFirst: "BottomFieldFirst",
}

/**
 * The deinterlacing mode. Defaults to AutoPixelAdaptive.
 */
union DeinterlaceMode {
  string,

  /**
   * Disables de-interlacing of the source video.
   */
  Off: "Off",

  /**
   * Apply automatic pixel adaptive de-interlacing on each frame in the input video.
   */
  AutoPixelAdaptive: "AutoPixelAdaptive",
}

/**
 * The rotation, if any, to be applied to the input video, before it is encoded. Default is Auto
 */
union Rotation {
  string,

  /**
   * Automatically detect and rotate as needed.
   */
  Auto: "Auto",

  /**
   * Do not rotate the video.  If the output format supports it, any metadata about rotation is kept intact.
   */
  None: "None",

  /**
   * Do not rotate the video but remove any metadata about the rotation.
   */
  Rotate0: "Rotate0",

  /**
   * Rotate 90 degrees clockwise.
   */
  Rotate90: "Rotate90",

  /**
   * Rotate 180 degrees clockwise.
   */
  Rotate180: "Rotate180",

  /**
   * Rotate 270 degrees clockwise.
   */
  Rotate270: "Rotate270",
}

/**
 * We currently support Baseline, Main, High, High422, High444. Default is Auto.
 */
union H264VideoProfile {
  string,

  /**
   * Tells the encoder to automatically determine the appropriate H.264 profile.
   */
  Auto: "Auto",

  /**
   * Baseline profile
   */
  Baseline: "Baseline",

  /**
   * Main profile
   */
  Main: "Main",

  /**
   * High profile.
   */
  High: "High",

  /**
   * High 4:2:2 profile.
   */
  High422: "High422",

  /**
   * High 4:4:4 predictive profile.
   */
  High444: "High444",
}

/**
 * The entropy mode to be used for this layer. If not specified, the encoder chooses the mode that is appropriate for the profile and level.
 */
union EntropyMode {
  string,

  /**
   * Context Adaptive Binary Arithmetic Coder (CABAC) entropy encoding.
   */
  Cabac: "Cabac",

  /**
   * Context Adaptive Variable Length Coder (CAVLC) entropy encoding.
   */
  Cavlc: "Cavlc",
}

/**
 * Tells the encoder how to choose its encoding settings. The default value is Balanced.
 */
union H264Complexity {
  string,

  /**
   * Tells the encoder to use settings that are optimized for faster encoding. Quality is sacrificed to decrease encoding time.
   */
  Speed: "Speed",

  /**
   * Tells the encoder to use settings that achieve a balance between speed and quality.
   */
  Balanced: "Balanced",

  /**
   * Tells the encoder to use settings that are optimized to produce higher quality output at the expense of slower overall encode time.
   */
  Quality: "Quality",
}

/**
 * The video rate control mode
 */
union H264RateControlMode {
  string,

  /**
   * Average Bitrate (ABR) mode that hits the target bitrate: Default mode.
   */
  ABR: "ABR",

  /**
   * Constant Bitrate (CBR) mode that tightens bitrate variations around target bitrate.
   */
  CBR: "CBR",

  /**
   * Constant Rate Factor (CRF) mode that targets at constant subjective quality.
   */
  CRF: "CRF",
}

/**
 * Allows you to configure the encoder settings to control the balance between speed and quality. Example: set Complexity as Speed for faster encoding but less compression efficiency.
 */
union Complexity {
  string,

  /**
   * Configures the encoder to use settings optimized for faster encoding. Quality is sacrificed to decrease encoding time.
   */
  Speed: "Speed",

  /**
   * Configures the encoder to use settings that achieve a balance between speed and quality.
   */
  Balanced: "Balanced",

  /**
   * Configures the encoder to use settings optimized to produce higher quality output at the expense of slower overall encode time.
   */
  Quality: "Quality",
}

/**
 * Sets the interleave mode of the output to control how audio and video are stored in the container format. Example: set InterleavedOutput as NonInterleavedOutput to produce audio-only and video-only outputs in separate MP4 files.
 */
union InterleaveOutput {
  string,

  /**
   * The output is video-only or audio-only.
   */
  NonInterleavedOutput: "NonInterleavedOutput",

  /**
   * The output includes both audio and video.
   */
  InterleavedOutput: "InterleavedOutput",
}

/**
 * The built-in preset to be used for encoding videos.
 */
union EncoderNamedPreset {
  string,

  /**
   * Produces an MP4 file where the video is encoded with H.264 codec at 2200 kbps and a picture height of 480 pixels, and the stereo audio is encoded with AAC-LC codec at 128 kbps.
   */
  H264SingleBitrateSD: "H264SingleBitrateSD",

  /**
   * Produces an MP4 file where the video is encoded with H.264 codec at 4500 kbps and a picture height of 720 pixels, and the stereo audio is encoded with AAC-LC codec at 128 kbps.
   */
  H264SingleBitrate720p: "H264SingleBitrate720p",

  /**
   * Produces an MP4 file where the video is encoded with H.264 codec at 6750 kbps and a picture height of 1080 pixels, and the stereo audio is encoded with AAC-LC codec at 128 kbps.
   */
  H264SingleBitrate1080p: "H264SingleBitrate1080p",

  /**
   * Produces a set of GOP aligned MP4 files with H.264 video and stereo AAC audio. Auto-generates a bitrate ladder based on the input resolution, bitrate and frame rate. The auto-generated preset will never exceed the input resolution. For example, if the input is 720p, output will remain 720p at best.
   */
  AdaptiveStreaming: "AdaptiveStreaming",

  /**
   * Produces a single MP4 file containing only AAC stereo audio encoded at 192 kbps.
   */
  AACGoodQualityAudio: "AACGoodQualityAudio",

  /**
   * Produces a single MP4 file containing only DD(Digital Dolby) stereo audio encoded at 192 kbps.
   */
  DDGoodQualityAudio: "DDGoodQualityAudio",

  /**
   * Exposes an experimental preset for content-aware encoding. Given any input content, the service attempts to automatically determine the optimal number of layers, appropriate bitrate and resolution settings for delivery by adaptive streaming. The underlying algorithms will continue to evolve over time. The output will contain MP4 files with video and audio interleaved.
   */
  ContentAwareEncodingExperimental: "ContentAwareEncodingExperimental",

  /**
   * Produces a set of GOP-aligned MP4s by using content-aware encoding. Given any input content, the service performs an initial lightweight analysis of the input content, and uses the results to determine the optimal number of layers, appropriate bitrate and resolution settings for delivery by adaptive streaming. This preset is particularly effective for low and medium complexity videos, where the output files will be at lower bitrates but at a quality that still delivers a good experience to viewers. The output will contain MP4 files with video and audio interleaved.
   */
  ContentAwareEncoding: "ContentAwareEncoding",

  /**
   * Copy all video and audio streams from the input asset as non-interleaved video and audio output files. This preset can be used to clip an existing asset or convert a group of key frame (GOP) aligned MP4 files as an asset that can be streamed.
   */
  CopyAllBitrateNonInterleaved: "CopyAllBitrateNonInterleaved",

  /**
   * Produces a set of 8 GOP-aligned MP4 files, ranging from 6000 kbps to 400 kbps, and stereo AAC audio. Resolution starts at 1080p and goes down to 180p.
   */
  H264MultipleBitrate1080p: "H264MultipleBitrate1080p",

  /**
   * Produces a set of 6 GOP-aligned MP4 files, ranging from 3400 kbps to 400 kbps, and stereo AAC audio. Resolution starts at 720p and goes down to 180p.
   */
  H264MultipleBitrate720p: "H264MultipleBitrate720p",

  /**
   * Produces a set of 5 GOP-aligned MP4 files, ranging from 1900kbps to 400 kbps, and stereo AAC audio. Resolution starts at 480p and goes down to 240p.
   */
  H264MultipleBitrateSD: "H264MultipleBitrateSD",

  /**
   * Produces a set of GOP-aligned MP4s by using content-aware encoding. Given any input content, the service performs an initial lightweight analysis of the input content, and uses the results to determine the optimal number of layers, appropriate bitrate and resolution settings for delivery by adaptive streaming. This preset is particularly effective for low and medium complexity videos, where the output files will be at lower bitrates but at a quality that still delivers a good experience to viewers. The output will contain MP4 files with video and audio interleaved.
   */
  H265ContentAwareEncoding: "H265ContentAwareEncoding",

  /**
   * Produces a set of GOP aligned MP4 files with H.265 video and stereo AAC audio. Auto-generates a bitrate ladder based on the input resolution, bitrate and frame rate. The auto-generated preset will never exceed the input resolution. For example, if the input is 720p, output will remain 720p at best.
   */
  H265AdaptiveStreaming: "H265AdaptiveStreaming",

  /**
   * Produces an MP4 file where the video is encoded with H.265 codec at 1800 kbps and a picture height of 720 pixels, and the stereo audio is encoded with AAC-LC codec at 128 kbps.
   */
  H265SingleBitrate720p: "H265SingleBitrate720p",

  /**
   * Produces an MP4 file where the video is encoded with H.265 codec at 3500 kbps and a picture height of 1080 pixels, and the stereo audio is encoded with AAC-LC codec at 128 kbps.
   */
  H265SingleBitrate1080p: "H265SingleBitrate1080p",

  /**
   * Produces an MP4 file where the video is encoded with H.265 codec at 9500 kbps and a picture height of 2160 pixels, and the stereo audio is encoded with AAC-LC codec at 128 kbps.
   */
  H265SingleBitrate4K: "H265SingleBitrate4K",
}

/**
 * Defines the type of insights that you want the service to generate. The allowed values are 'AudioInsightsOnly', 'VideoInsightsOnly', and 'AllInsights'. The default is AllInsights. If you set this to AllInsights and the input is audio only, then only audio insights are generated. Similarly if the input is video only, then only video insights are generated. It is recommended that you not use AudioInsightsOnly if you expect some of your inputs to be video only; or use VideoInsightsOnly if you expect some of your inputs to be audio only. Your Jobs in such conditions would error out.
 */
union InsightsType {
  string,

  /**
   * Generate audio only insights. Ignore video even if present. Fails if no audio is present.
   */
  AudioInsightsOnly: "AudioInsightsOnly",

  /**
   * Generate video only insights. Ignore audio if present. Fails if no video is present.
   */
  VideoInsightsOnly: "VideoInsightsOnly",

  /**
   * Generate both audio and video insights. Fails if either audio or video Insights fail.
   */
  AllInsights: "AllInsights",
}

/**
 * A collection of AccountFilter items.
 */
@pagedResult
model AccountFilterCollection {
  /**
   * A collection of AccountFilter items.
   */
  @items
  value?: AccountFilter[];

  /**
   * A link to the next page of the collection (when the collection contains too many results to return in one response).
   */
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * The Media Filter properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model MediaFilterProperties {
  /**
   * The presentation time range.
   */
  presentationTimeRange?: PresentationTimeRange;

  /**
   * The first quality.
   */
  firstQuality?: FirstQuality;

  /**
   * The tracks selection conditions.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  tracks?: FilterTrackSelection[];
}

/**
 * The presentation time range, this is asset related and not recommended for Account Filter.
 */
model PresentationTimeRange {
  /**
   * The absolute start time boundary.
   */
  startTimestamp?: int64;

  /**
   * The absolute end time boundary.
   */
  endTimestamp?: int64;

  /**
   * The relative to end sliding window.
   */
  presentationWindowDuration?: int64;

  /**
   * The relative to end right edge.
   */
  liveBackoffDuration?: int64;

  /**
   * The time scale of time stamps.
   */
  timescale?: int64;

  /**
   * The indicator of forcing existing of end time stamp.
   */
  forceEndTimestamp?: boolean;
}

/**
 * Filter First Quality
 */
model FirstQuality {
  /**
   * The first quality bitrate.
   */
  bitrate: int32;
}

/**
 * Representing a list of FilterTrackPropertyConditions to select a track.  The filters are combined using a logical AND operation.
 */
model FilterTrackSelection {
  /**
   * The track selections.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  trackSelections: FilterTrackPropertyCondition[];
}

/**
 * The class to specify one track property condition.
 */
model FilterTrackPropertyCondition {
  /**
   * The track property type.
   */
  property: FilterTrackPropertyType;

  /**
   * The track property value.
   */
  value: string;

  /**
   * The track property condition operation.
   */
  operation: FilterTrackPropertyCompareOperation;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The service specification property.
 */
model Properties {
  /**
   * The service specifications.
   */
  @visibility(Lifecycle.Read)
  serviceSpecification?: ServiceSpecification;
}

/**
 * The service metric specifications.
 */
model ServiceSpecification {
  /**
   * List of log specifications.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  logSpecifications?: LogSpecification[];

  /**
   * List of metric specifications.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  metricSpecifications?: MetricSpecification[];
}

/**
 * A diagnostic log emitted by service.
 */
model LogSpecification {
  /**
   * The diagnostic log category name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The diagnostic log category display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The time range for requests in each blob.
   */
  @visibility(Lifecycle.Read)
  blobDuration?: string;
}

/**
 * A metric emitted by service.
 */
model MetricSpecification {
  /**
   * The metric name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The metric display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The metric display description.
   */
  @visibility(Lifecycle.Read)
  displayDescription?: string;

  /**
   * The metric unit
   */
  @visibility(Lifecycle.Read)
  unit?: MetricUnit;

  /**
   * The metric aggregation type
   */
  @visibility(Lifecycle.Read)
  aggregationType?: MetricAggregationType;

  /**
   * The metric lock aggregation type
   */
  @visibility(Lifecycle.Read)
  lockAggregationType?: MetricAggregationType;

  /**
   * Supported aggregation types.
   */
  supportedAggregationTypes?: string[];

  /**
   * The metric dimensions.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  dimensions?: MetricDimension[];

  /**
   * Indicates whether regional MDM account is enabled.
   */
  @visibility(Lifecycle.Read)
  enableRegionalMdmAccount?: boolean;

  /**
   * The source MDM account.
   */
  @visibility(Lifecycle.Read)
  sourceMdmAccount?: string;

  /**
   * The source MDM namespace.
   */
  @visibility(Lifecycle.Read)
  sourceMdmNamespace?: string;

  /**
   * The supported time grain types.
   */
  @visibility(Lifecycle.Read)
  supportedTimeGrainTypes?: string[];
}

/**
 * A metric dimension.
 */
model MetricDimension {
  /**
   * The metric dimension name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The display name for the dimension.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Whether to export metric to shoebox.
   */
  @visibility(Lifecycle.Read)
  toBeExportedForShoebox?: boolean;
}

/**
 * A collection of MediaService items.
 */
@pagedResult
model MediaServiceCollection {
  /**
   * A collection of MediaService items.
   */
  @items
  value?: MediaService[];

  /**
   * A link to the next page of the collection (when the collection contains too many results to return in one response).
   */
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * Properties of the Media Services account.
 */
model MediaServiceProperties {
  /**
   * The Media Services account ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  mediaServiceId?: string;

  /**
   * The storage accounts for this resource.
   */
  storageAccounts?: StorageAccount[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  storageAuthentication?: StorageAuthentication;

  /**
   * The account encryption properties.
   */
  encryption?: AccountEncryption;

  /**
   * The Key Delivery properties for Media Services account.
   */
  keyDelivery?: KeyDelivery;

  /**
   * Whether or not public network access is allowed for resources under the Media Services account.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Provisioning state of the Media Services account.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The Private Endpoint Connections created for the Media Service account.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The minimum TLS version allowed for this account's requests. This is an optional property. If unspecified, a secure default value will be used.
   */
  minimumTlsVersion?: MinimumTlsVersion = MinimumTlsVersion.Tls12;
}

/**
 * The storage account details.
 */
model StorageAccount {
  /**
   * The ID of the storage account resource. Media Services relies on tables and queues as well as blobs, so the primary storage account must be a Standard Storage account (either Microsoft.ClassicStorage or Microsoft.Storage). Blob only storage accounts can be added as secondary storage accounts.
   */
  id?: string;

  /**
   * The type of the storage account.
   */
  type: StorageAccountType;

  /**
   * The storage account identity.
   */
  identity?: ResourceIdentity;

  /**
   * The current status of the storage account mapping.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceIdentity {
  /**
   * The user assigned managed identity's ARM ID to use when accessing a resource.
   */
  userAssignedIdentity?: string;

  /**
   * Indicates whether to use System Assigned Managed Identity. Mutual exclusive with User Assigned Managed Identity.
   */
  useSystemAssignedIdentity: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AccountEncryption {
  /**
   * The type of key used to encrypt the Account Key.
   */
  type: AccountEncryptionKeyType;

  /**
   * The properties of the key used to encrypt the account.
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * The Key Vault identity.
   */
  identity?: ResourceIdentity;

  /**
   * The current status of the Key Vault mapping.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model KeyVaultProperties {
  /**
   * The URL of the Key Vault key used to encrypt the account. The key may either be versioned (for example https://vault/keys/mykey/version1) or reference a key without a version (for example https://vault/keys/mykey).
   */
  keyIdentifier?: string;

  /**
   * The current key used to encrypt the Media Services account, including the key version.
   */
  @visibility(Lifecycle.Read)
  currentKeyIdentifier?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model KeyDelivery {
  /**
   * The access control properties for Key Delivery.
   */
  accessControl?: AccessControl;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AccessControl {
  /**
   * The behavior for IP access control in Key Delivery.
   */
  defaultAction?: DefaultAction;

  /**
   * The IP allow list for access control in Key Delivery. If the default action is set to 'Allow', the IP allow list must be empty.
   */
  ipAllowList?: string[];
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model MediaServiceIdentity {
  /**
   * The identity type.
   */
  type: string;

  /**
   * The Principal ID of the identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The Tenant ID of the identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * The user assigned managed identities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedManagedIdentity>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UserAssignedManagedIdentity {
  /**
   * The client ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  clientId?: string;

  /**
   * The principal ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;
}

/**
 * A Media Services account update.
 */
model MediaServiceUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: MediaServiceProperties;

  /**
   * The Managed Identity for the Media Services account.
   */
  identity?: MediaServiceIdentity;
}

/**
 * The input to the sync storage keys request.
 */
model SyncStorageKeysInput {
  /**
   * The ID of the storage account resource.
   */
  id?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ListEdgePoliciesInput {
  /**
   * Unique identifier of the edge device.
   */
  deviceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model EdgePolicies {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  usageDataCollectionPolicy?: EdgeUsageDataCollectionPolicy;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model EdgeUsageDataCollectionPolicy {
  /**
   * Usage data collection frequency in ISO 8601 duration format e.g. PT10M , PT5H.
   */
  dataCollectionFrequency?: string;

  /**
   * Usage data reporting frequency in ISO 8601 duration format e.g. PT10M , PT5H.
   */
  dataReportingFrequency?: string;

  /**
   * Maximum time for which the functionality of the device will not be hampered for not reporting the usage data.
   */
  maxAllowedUnreportedUsageDuration?: string;

  /**
   * Details of Event Hub where the usage will be reported.
   */
  eventHubDetails?: EdgeUsageDataEventHub;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model EdgeUsageDataEventHub {
  /**
   * Name of the Event Hub where usage will be reported.
   */
  name?: string;

  /**
   * Namespace of the Event Hub where usage will be reported.
   */
  `namespace`?: string;

  /**
   * SAS token needed to interact with Event Hub.
   */
  token?: string;
}

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  value?: PrivateLinkResource[];
}

/**
 * Properties of a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * List of private endpoint connection associated with the specified storage account
 */
model PrivateEndpointConnectionListResult {
  /**
   * Array of private endpoint connections
   */
  value?: PrivateEndpointConnection[];
}

/**
 * The input to the check name availability request.
 */
model CheckNameAvailabilityInput {
  /**
   * The account name.
   */
  name?: string;

  /**
   * The account type. For a Media Services account, this should be 'MediaServices'.
   */
  type?: string;
}

/**
 * The response from the check name availability request.
 */
model EntityNameAvailabilityCheckOutput {
  /**
   * Specifies if the name is available.
   */
  nameAvailable: boolean;

  /**
   * Specifies the reason if the name is not available.
   */
  reason?: string;

  /**
   * Specifies the detailed reason if the name is not available.
   */
  message?: string;
}

/**
 * Status of media service operation.
 */
model MediaServiceOperationStatus {
  /**
   * Operation identifier.
   */
  name: string;

  /**
   * Operation resource ID.
   */
  id?: string;

  /**
   * Operation start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Operation end time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Operation status.
   */
  status: string;

  /**
   * The error detail.
   */
  error?: ErrorDetail;
}

/**
 * A collection of Asset items.
 */
@pagedResult
model AssetCollection {
  /**
   * A collection of Asset items.
   */
  @items
  value?: Asset[];

  /**
   * A link to the next page of the collection (when the collection contains too many results to return in one response).
   */
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * The Asset properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AssetProperties {
  /**
   * The Asset ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  assetId?: string;

  /**
   * The creation date of the Asset.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The last modified date of the Asset.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * The alternate ID of the Asset.
   */
  alternateId?: string;

  /**
   * The Asset description.
   */
  description?: string;

  /**
   * The name of the asset blob container.
   */
  container?: string;

  /**
   * The name of the storage account.
   */
  storageAccountName?: string;

  /**
   * The Asset encryption format. One of None or MediaStorageEncryption.
   */
  @visibility(Lifecycle.Read)
  storageEncryptionFormat?: AssetStorageEncryptionFormat;

  /**
   * The Asset container encryption scope in the storage account.
   */
  encryptionScope?: string;
}

/**
 * The parameters to the list SAS request.
 */
model ListContainerSasInput {
  /**
   * The permissions to set on the SAS URL.
   */
  permissions?: AssetContainerPermission;

  /**
   * The SAS URL expiration time.  This must be less than 24 hours from the current time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;
}

/**
 * The Asset Storage container SAS URLs.
 */
model AssetContainerSas {
  /**
   * The list of Asset container SAS URLs.
   */
  assetContainerSasUrls?: string[];
}

/**
 * Data needed to decrypt asset files encrypted with legacy storage encryption.
 */
model StorageEncryptedAssetDecryptionData {
  /**
   * The Asset File storage encryption key.
   */
  key?: bytes;

  /**
   * Asset File encryption metadata.
   */
  @OpenAPI.extension("x-ms-identifiers", #["assetFileId"])
  assetFileEncryptionMetadata?: AssetFileEncryptionMetadata[];
}

/**
 * The Asset File Storage encryption metadata.
 */
model AssetFileEncryptionMetadata {
  /**
   * The Asset File initialization vector.
   */
  initializationVector?: string;

  /**
   * The Asset File name.
   */
  assetFileName?: string;

  /**
   * The Asset File Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  assetFileId: string;
}

/**
 * The Streaming Locators associated with this Asset.
 */
model ListStreamingLocatorsResponse {
  /**
   * The list of Streaming Locators.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  streamingLocators?: AssetStreamingLocator[];
}

/**
 * Properties of the Streaming Locator.
 */
model AssetStreamingLocator {
  /**
   * Streaming Locator name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Asset Name.
   */
  @visibility(Lifecycle.Read)
  assetName?: string;

  /**
   * The creation time of the Streaming Locator.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The start time of the Streaming Locator.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the Streaming Locator.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * StreamingLocatorId of the Streaming Locator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  streamingLocatorId?: string;

  /**
   * Name of the Streaming Policy used by this Streaming Locator.
   */
  @visibility(Lifecycle.Read)
  streamingPolicyName?: string;

  /**
   * Name of the default ContentKeyPolicy used by this Streaming Locator.
   */
  @visibility(Lifecycle.Read)
  defaultContentKeyPolicyName?: string;
}

/**
 * A collection of AssetFilter items.
 */
@pagedResult
model AssetFilterCollection {
  /**
   * A collection of AssetFilter items.
   */
  @items
  value?: AssetFilter[];

  /**
   * A link to the next page of the collection (when the collection contains too many results to return in one response).
   */
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * A collection of AssetTrack items.
 */
@pagedResult
model AssetTrackCollection {
  /**
   * A collection of AssetTrack items.
   */
  @items
  value?: AssetTrack[];
}

/**
 * Properties of a video, audio or text track in the asset.
 */
model AssetTrackProperties {
  /**
   * Detailed information about a track in the asset.
   */
  track?: TrackBase;

  /**
   * Provisioning state of the asset track.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Base type for concrete track types. A derived type must be used to represent the Track.
 */
@discriminator("@odata.type")
model TrackBase {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;
}

/**
 * Status of asset track operation.
 */
model AssetTrackOperationStatus {
  /**
   * Operation identifier.
   */
  name: string;

  /**
   * Operation resource ID.
   */
  id?: string;

  /**
   * Operation start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Operation end time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Operation status.
   */
  status: string;

  /**
   * The error detail.
   */
  error?: ErrorDetail;
}

/**
 * A collection of ContentKeyPolicy items.
 */
@pagedResult
model ContentKeyPolicyCollection {
  /**
   * A collection of ContentKeyPolicy items.
   */
  @items
  value?: ContentKeyPolicy[];

  /**
   * A link to the next page of the collection (when the collection contains too many results to return in one response).
   */
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * The properties of the Content Key Policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ContentKeyPolicyProperties {
  /**
   * The legacy Policy ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  policyId?: string;

  /**
   * The creation date of the Policy
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The last modified date of the Policy
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * A description for the Policy.
   */
  description?: string;

  /**
   * The Key Policy options.
   */
  @OpenAPI.extension("x-ms-identifiers", #["policyOptionId"])
  options: ContentKeyPolicyOption[];
}

/**
 * Represents a policy option.
 */
model ContentKeyPolicyOption {
  /**
   * The legacy Policy Option ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  policyOptionId?: string;

  /**
   * The Policy Option description.
   */
  name?: string;

  /**
   * The key delivery configuration.
   */
  configuration: ContentKeyPolicyConfiguration;

  /**
   * The requirements that must be met to deliver keys with this configuration
   */
  restriction: ContentKeyPolicyRestriction;
}

/**
 * Base class for Content Key Policy configuration. A derived class must be used to create a configuration.
 */
@discriminator("@odata.type")
model ContentKeyPolicyConfiguration {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;
}

/**
 * Base class for Content Key Policy restrictions. A derived class must be used to create a restriction.
 */
@discriminator("@odata.type")
model ContentKeyPolicyRestriction {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;
}

/**
 * A collection of Transform items.
 */
@pagedResult
model TransformCollection {
  /**
   * A collection of Transform items.
   */
  @items
  value?: Transform[];

  /**
   * A link to the next page of the collection (when the collection contains too many results to return in one response).
   */
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * A Transform.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model TransformProperties {
  /**
   * The UTC date and time when the Transform was created, in 'YYYY-MM-DDThh:mm:ssZ' format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * An optional verbose description of the Transform.
   */
  description?: string;

  /**
   * The UTC date and time when the Transform was last updated, in 'YYYY-MM-DDThh:mm:ssZ' format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * An array of one or more TransformOutputs that the Transform should generate.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  outputs: TransformOutput[];
}

/**
 * Describes the properties of a TransformOutput, which are the rules to be applied while generating the desired output.
 */
model TransformOutput {
  /**
   * A Transform can define more than one outputs. This property defines what the service should do when one output fails - either continue to produce other outputs, or, stop the other outputs. The overall Job state will not reflect failures of outputs that are specified with 'ContinueJob'. The default is 'StopProcessingJob'.
   */
  onError?: OnErrorType;

  /**
   * Sets the relative priority of the TransformOutputs within a Transform. This sets the priority that the service uses for processing TransformOutputs. The default priority is Normal.
   */
  relativePriority?: Priority;

  /**
   * Preset that describes the operations that will be used to modify, transcode, or extract insights from the source file to generate the output.
   */
  preset: Preset;
}

/**
 * Base type for all Presets, which define the recipe or instructions on how the input media files should be processed.
 */
@discriminator("@odata.type")
model Preset {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;
}

/**
 * A collection of Job items.
 */
@pagedResult
model JobCollection {
  /**
   * A collection of Job items.
   */
  @items
  value?: Job[];

  /**
   * A link to the next page of the collection (when the collection contains too many results to return in one response).
   */
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * Properties of the Job.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model JobProperties {
  /**
   * The UTC date and time when the customer has created the Job, in 'YYYY-MM-DDThh:mm:ssZ' format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The current state of the job.
   */
  @visibility(Lifecycle.Read)
  state?: JobState;

  /**
   * Optional customer supplied description of the Job.
   */
  description?: string;

  /**
   * The inputs for the Job.
   */
  input: JobInput;

  /**
   * The UTC date and time when the customer has last updated the Job, in 'YYYY-MM-DDThh:mm:ssZ' format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * The outputs for the Job.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  outputs: JobOutput[];

  /**
   * Priority with which the job should be processed. Higher priority jobs are processed before lower priority jobs. If not set, the default is normal.
   */
  priority?: Priority;

  /**
   * Customer provided key, value pairs that will be returned in Job and JobOutput state events.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  correlationData?: Record<string>;

  /**
   * The UTC date and time at which this Job began processing.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The UTC date and time at which this Job finished processing.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;
}

/**
 * Base class for inputs to a Job.
 */
@discriminator("@odata.type")
model JobInput {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;
}

/**
 * Describes all the properties of a JobOutput.
 */
@discriminator("@odata.type")
model JobOutput {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;

  /**
   * If the JobOutput is in the Error state, it contains the details of the error.
   */
  @visibility(Lifecycle.Read)
  error?: JobError;

  /**
   * A preset used to override the preset in the corresponding transform output.
   */
  presetOverride?: Preset;

  /**
   * Describes the state of the JobOutput.
   */
  @visibility(Lifecycle.Read)
  state?: JobState;

  /**
   * If the JobOutput is in a Processing state, this contains the Job completion percentage. The value is an estimate and not intended to be used to predict Job completion times. To determine if the JobOutput is complete, use the State property.
   */
  @visibility(Lifecycle.Read)
  progress?: int32;

  /**
   * A label that is assigned to a JobOutput in order to help uniquely identify it. This is useful when your Transform has more than one TransformOutput, whereby your Job has more than one JobOutput. In such cases, when you submit the Job, you will add two or more JobOutputs, in the same order as TransformOutputs in the Transform. Subsequently, when you retrieve the Job, either through events or on a GET request, you can use the label to easily identify the JobOutput. If a label is not provided, a default value of '{presetName}_{outputIndex}' will be used, where the preset name is the name of the preset in the corresponding TransformOutput and the output index is the relative index of the this JobOutput within the Job. Note that this index is the same as the relative index of the corresponding TransformOutput within its Transform.
   */
  label?: string;

  /**
   * The UTC date and time at which this Job Output began processing.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The UTC date and time at which this Job Output finished processing.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;
}

/**
 * Details of JobOutput errors.
 */
model JobError {
  /**
   * Error code describing the error.
   */
  @visibility(Lifecycle.Read)
  code?: JobErrorCode;

  /**
   * A human-readable language-dependent representation of the error.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Helps with categorization of errors.
   */
  @visibility(Lifecycle.Read)
  category?: JobErrorCategory;

  /**
   * Indicates that it may be possible to retry the Job. If retry is unsuccessful, please contact Azure support via Azure Portal.
   */
  @visibility(Lifecycle.Read)
  retry?: JobRetry;

  /**
   * An array of details about specific errors that led to this reported error.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["code"])
  details?: JobErrorDetail[];
}

/**
 * Details of JobOutput errors.
 */
model JobErrorDetail {
  /**
   * Code describing the error detail.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * A human-readable representation of the error.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * A collection of StreamingPolicy items.
 */
@pagedResult
model StreamingPolicyCollection {
  /**
   * A collection of StreamingPolicy items.
   */
  @items
  value?: StreamingPolicy[];

  /**
   * A link to the next page of the collection (when the collection contains too many results to return in one response).
   */
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * Class to specify properties of Streaming Policy
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model StreamingPolicyProperties {
  /**
   * Creation time of Streaming Policy
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * Default ContentKey used by current Streaming Policy
   */
  defaultContentKeyPolicyName?: string;

  /**
   * Configuration of EnvelopeEncryption
   */
  envelopeEncryption?: EnvelopeEncryption;

  /**
   * Configuration of CommonEncryptionCenc
   */
  commonEncryptionCenc?: CommonEncryptionCenc;

  /**
   * Configuration of CommonEncryptionCbcs
   */
  commonEncryptionCbcs?: CommonEncryptionCbcs;

  /**
   * Configurations of NoEncryption
   */
  noEncryption?: NoEncryption;
}

/**
 * Class for EnvelopeEncryption encryption scheme
 */
model EnvelopeEncryption {
  /**
   * Representing supported protocols
   */
  enabledProtocols?: EnabledProtocols;

  /**
   * Representing which tracks should not be encrypted
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  clearTracks?: TrackSelection[];

  /**
   * Representing default content key for each encryption scheme and separate content keys for specific tracks
   */
  contentKeys?: StreamingPolicyContentKeys;

  /**
   * Template for the URL of the custom service delivering keys to end user players.  Not required when using Azure Media Services for issuing keys.  The template supports replaceable tokens that the service will update at runtime with the value specific to the request.  The currently supported token values are {AlternativeMediaId}, which is replaced with the value of StreamingLocatorId.AlternativeMediaId, and {ContentKeyId}, which is replaced with the value of identifier of the key being requested.
   */
  customKeyAcquisitionUrlTemplate?: string;
}

/**
 * Class to specify which protocols are enabled
 */
model EnabledProtocols {
  /**
   * Enable Download protocol or not
   */
  download: boolean;

  /**
   * Enable DASH protocol or not
   */
  dash: boolean;

  /**
   * Enable HLS protocol or not
   */
  hls: boolean;

  /**
   * Enable SmoothStreaming protocol or not
   */
  smoothStreaming: boolean;
}

/**
 * Class to select a track
 */
model TrackSelection {
  /**
   * TrackSelections is a track property condition list which can specify track(s)
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  trackSelections?: TrackPropertyCondition[];
}

/**
 * Class to specify one track property condition
 */
model TrackPropertyCondition {
  /**
   * Track property type
   */
  property: TrackPropertyType;

  /**
   * Track property condition operation
   */
  operation: TrackPropertyCompareOperation;

  /**
   * Track property value
   */
  value?: string;
}

/**
 * Class to specify properties of all content keys in Streaming Policy
 */
model StreamingPolicyContentKeys {
  /**
   * Default content key for an encryption scheme
   */
  defaultKey?: DefaultKey;

  /**
   * Representing tracks needs separate content key
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  keyToTrackMappings?: StreamingPolicyContentKey[];
}

/**
 * Class to specify properties of default content key for each encryption scheme
 */
model DefaultKey {
  /**
   * Label can be used to specify Content Key when creating a Streaming Locator
   */
  label?: string;

  /**
   * Policy used by Default Key
   */
  policyName?: string;
}

/**
 * Class to specify properties of content key
 */
model StreamingPolicyContentKey {
  /**
   * Label can be used to specify Content Key when creating a Streaming Locator
   */
  label?: string;

  /**
   * Policy used by Content Key
   */
  policyName?: string;

  /**
   * Tracks which use this content key
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  tracks?: TrackSelection[];
}

/**
 * Class for envelope encryption scheme
 */
model CommonEncryptionCenc {
  /**
   * Representing supported protocols
   */
  enabledProtocols?: EnabledProtocols;

  /**
   * Representing which tracks should not be encrypted
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  clearTracks?: TrackSelection[];

  /**
   * Representing default content key for each encryption scheme and separate content keys for specific tracks
   */
  contentKeys?: StreamingPolicyContentKeys;

  /**
   * Configuration of DRMs for CommonEncryptionCenc encryption scheme
   */
  drm?: CencDrmConfiguration;

  /**
   * Optional configuration supporting ClearKey in CommonEncryptionCenc encryption scheme.
   */
  clearKeyEncryptionConfiguration?: ClearKeyEncryptionConfiguration;
}

/**
 * Class to specify DRM configurations of CommonEncryptionCenc scheme in Streaming Policy
 */
model CencDrmConfiguration {
  /**
   * PlayReady configurations
   */
  playReady?: StreamingPolicyPlayReadyConfiguration;

  /**
   * Widevine configurations
   */
  widevine?: StreamingPolicyWidevineConfiguration;
}

/**
 * Class to specify configurations of PlayReady in Streaming Policy
 */
model StreamingPolicyPlayReadyConfiguration {
  /**
   * Template for the URL of the custom service delivering licenses to end user players.  Not required when using Azure Media Services for issuing licenses.  The template supports replaceable tokens that the service will update at runtime with the value specific to the request.  The currently supported token values are {AlternativeMediaId}, which is replaced with the value of StreamingLocatorId.AlternativeMediaId, and {ContentKeyId}, which is replaced with the value of identifier of the key being requested.
   */
  customLicenseAcquisitionUrlTemplate?: string;

  /**
   * Custom attributes for PlayReady
   */
  playReadyCustomAttributes?: string;
}

/**
 * Class to specify configurations of Widevine in Streaming Policy
 */
model StreamingPolicyWidevineConfiguration {
  /**
   * Template for the URL of the custom service delivering licenses to end user players.  Not required when using Azure Media Services for issuing licenses.  The template supports replaceable tokens that the service will update at runtime with the value specific to the request.  The currently supported token values are {AlternativeMediaId}, which is replaced with the value of StreamingLocatorId.AlternativeMediaId, and {ContentKeyId}, which is replaced with the value of identifier of the key being requested.
   */
  customLicenseAcquisitionUrlTemplate?: string;
}

/**
 * Class to specify ClearKey configuration of common encryption schemes in Streaming Policy
 */
model ClearKeyEncryptionConfiguration {
  /**
   * Template for the URL of the custom service delivering content keys to end user players. Not required when using Azure Media Services for issuing licenses. The template supports replaceable tokens that the service will update at runtime with the value specific to the request.  The currently supported token value is {AlternativeMediaId}, which is replaced with the value of StreamingLocatorId.AlternativeMediaId.
   */
  customKeysAcquisitionUrlTemplate?: string;
}

/**
 * Class for CommonEncryptionCbcs encryption scheme
 */
model CommonEncryptionCbcs {
  /**
   * Representing supported protocols
   */
  enabledProtocols?: EnabledProtocols;

  /**
   * Representing which tracks should not be encrypted
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  clearTracks?: TrackSelection[];

  /**
   * Representing default content key for each encryption scheme and separate content keys for specific tracks
   */
  contentKeys?: StreamingPolicyContentKeys;

  /**
   * Configuration of DRMs for current encryption scheme
   */
  drm?: CbcsDrmConfiguration;

  /**
   * Optional configuration supporting ClearKey in CommonEncryptionCbcs encryption scheme.
   */
  clearKeyEncryptionConfiguration?: ClearKeyEncryptionConfiguration;
}

/**
 * Class to specify DRM configurations of CommonEncryptionCbcs scheme in Streaming Policy
 */
model CbcsDrmConfiguration {
  /**
   * FairPlay configurations
   */
  fairPlay?: StreamingPolicyFairPlayConfiguration;

  /**
   * PlayReady configurations
   */
  playReady?: StreamingPolicyPlayReadyConfiguration;

  /**
   * Widevine configurations
   */
  widevine?: StreamingPolicyWidevineConfiguration;
}

/**
 * Class to specify configurations of FairPlay in Streaming Policy
 */
model StreamingPolicyFairPlayConfiguration {
  /**
   * Template for the URL of the custom service delivering licenses to end user players.  Not required when using Azure Media Services for issuing licenses.  The template supports replaceable tokens that the service will update at runtime with the value specific to the request.  The currently supported token values are {AlternativeMediaId}, which is replaced with the value of StreamingLocatorId.AlternativeMediaId, and {ContentKeyId}, which is replaced with the value of identifier of the key being requested.
   */
  customLicenseAcquisitionUrlTemplate?: string;

  /**
   * All license to be persistent or not
   */
  allowPersistentLicense: boolean;
}

/**
 * Class for NoEncryption scheme
 */
model NoEncryption {
  /**
   * Representing supported protocols
   */
  enabledProtocols?: EnabledProtocols;
}

/**
 * A collection of StreamingLocator items.
 */
@pagedResult
model StreamingLocatorCollection {
  /**
   * A collection of StreamingLocator items.
   */
  @items
  value?: StreamingLocator[];

  /**
   * A link to the next page of the collection (when the collection contains too many results to return in one response).
   */
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * Properties of the Streaming Locator.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model StreamingLocatorProperties {
  /**
   * Asset Name
   */
  assetName: string;

  /**
   * The creation time of the Streaming Locator.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The start time of the Streaming Locator.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the Streaming Locator.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The StreamingLocatorId of the Streaming Locator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  streamingLocatorId?: string;

  /**
   * Name of the Streaming Policy used by this Streaming Locator. Either specify the name of Streaming Policy you created or use one of the predefined Streaming Policies. The predefined Streaming Policies available are: 'Predefined_DownloadOnly', 'Predefined_ClearStreamingOnly', 'Predefined_DownloadAndClearStreaming', 'Predefined_ClearKey', 'Predefined_MultiDrmCencStreaming' and 'Predefined_MultiDrmStreaming'
   */
  streamingPolicyName: string;

  /**
   * Name of the default ContentKeyPolicy used by this Streaming Locator.
   */
  defaultContentKeyPolicyName?: string;

  /**
   * The ContentKeys used by this Streaming Locator.
   */
  contentKeys?: StreamingLocatorContentKey[];

  /**
   * Alternative Media ID of this Streaming Locator
   */
  alternativeMediaId?: string;

  /**
   * A list of asset or account filters which apply to this streaming locator
   */
  filters?: string[];
}

/**
 * Class for content key in Streaming Locator
 */
model StreamingLocatorContentKey {
  /**
   * ID of Content Key
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  id: string;

  /**
   * Encryption type of Content Key
   */
  @visibility(Lifecycle.Read)
  type?: StreamingLocatorContentKeyType;

  /**
   * Label of Content Key as specified in the Streaming Policy
   */
  labelReferenceInStreamingPolicy?: string;

  /**
   * Value of Content Key
   */
  value?: string;

  /**
   * ContentKeyPolicy used by Content Key
   */
  @visibility(Lifecycle.Read)
  policyName?: string;

  /**
   * Tracks which use this Content Key
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  tracks?: TrackSelection[];
}

/**
 * Class of response for listContentKeys action
 */
model ListContentKeysResponse {
  /**
   * ContentKeys used by current Streaming Locator
   */
  contentKeys?: StreamingLocatorContentKey[];
}

/**
 * Class of response for listPaths action
 */
model ListPathsResponse {
  /**
   * Streaming Paths supported by current Streaming Locator
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  streamingPaths?: StreamingPath[];

  /**
   * Download Paths supported by current Streaming Locator
   */
  downloadPaths?: string[];
}

/**
 * Class of paths for streaming
 */
model StreamingPath {
  /**
   * Streaming protocol
   */
  streamingProtocol: StreamingPolicyStreamingProtocol;

  /**
   * Encryption scheme
   */
  encryptionScheme: EncryptionScheme;

  /**
   * Streaming paths for each protocol and encryptionScheme pair
   */
  paths?: string[];
}

/**
 * The LiveEvent list result.
 */
@pagedResult
model LiveEventListResult {
  /**
   * The result of the List Live Event operation.
   */
  @items
  value?: LiveEvent[];

  /**
   * The number of result.
   */
  `@odata.count`?: int32;

  /**
   * The link to the next set of results. Not empty if value contains incomplete list of live outputs.
   */
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * The live event properties.
 */
model LiveEventProperties {
  /**
   * A description for the live event.
   */
  description?: string;

  /**
   * Live event input settings. It defines how the live event receives input from a contribution encoder.
   */
  input: LiveEventInput;

  /**
   * Live event preview settings. Preview allows live event producers to preview the live streaming content without creating any live output.
   */
  preview?: LiveEventPreview;

  /**
   * Encoding settings for the live event. It configures whether a live encoder is used for the live event and settings for the live encoder if it is used.
   */
  encoding?: LiveEventEncoding;

  /**
   * Live transcription settings for the live event. See https://go.microsoft.com/fwlink/?linkid=2133742 for more information about the live transcription feature.
   */
  @OpenAPI.extension("x-ms-identifiers", #["language"])
  transcriptions?: LiveEventTranscription[];

  /**
   * The provisioning state of the live event.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The resource state of the live event. See https://go.microsoft.com/fwlink/?linkid=2139012 for more information.
   */
  @visibility(Lifecycle.Read)
  resourceState?: LiveEventResourceState;

  /**
   * Live event cross site access policies.
   */
  crossSiteAccessPolicies?: CrossSiteAccessPolicies;

  /**
   * Specifies whether a static hostname would be assigned to the live event preview and ingest endpoints. This value can only be updated if the live event is in Standby state
   */
  useStaticHostname?: boolean;

  /**
   * When useStaticHostname is set to true, the hostnamePrefix specifies the first part of the hostname assigned to the live event preview and ingest endpoints. The final hostname would be a combination of this prefix, the media service account name and a short code for the Azure Media Services data center.
   */
  hostnamePrefix?: string;

  /**
   * The options to use for the LiveEvent. This value is specified at creation time and cannot be updated. The valid values for the array entry values are 'Default' and 'LowLatency'.
   */
  streamOptions?: StreamOptionsFlag[];

  /**
   * The creation time for the live event
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The last modified time of the live event.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;
}

/**
 * The live event input.
 */
model LiveEventInput {
  /**
   * The input protocol for the live event. This is specified at creation time and cannot be updated.
   */
  streamingProtocol: LiveEventInputProtocol;

  /**
   * Access control for live event input.
   */
  accessControl?: LiveEventInputAccessControl;

  /**
   * ISO 8601 time duration of the key frame interval duration of the input. This value sets the EXT-X-TARGETDURATION property in the HLS output. For example, use PT2S to indicate 2 seconds. Leave the value empty for encoding live events.
   */
  keyFrameIntervalDuration?: string;

  /**
   * A UUID in string form to uniquely identify the stream. This can be specified at creation time but cannot be updated. If omitted, the service will generate a unique value.
   */
  accessToken?: string;

  /**
   * The input endpoints for the live event.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  endpoints?: LiveEventEndpoint[];

  /**
   * The metadata endpoints for the live event.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  timedMetadataEndpoints?: LiveEventTimedMetadataEndpoint[];
}

/**
 * The IP access control for live event input.
 */
model LiveEventInputAccessControl {
  /**
   * The IP access control properties.
   */
  ip?: IPAccessControl;
}

/**
 * The IP access control.
 */
model IPAccessControl {
  /**
   * The IP allow list.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  allow?: IPRange[];
}

/**
 * The IP address range in the CIDR scheme.
 */
model IPRange {
  /**
   * The friendly name for the IP address range.
   */
  name?: string;

  /**
   * The IP address.
   */
  address?: string;

  /**
   * The subnet mask prefix length (see CIDR notation).
   */
  subnetPrefixLength?: int32;
}

/**
 * The live event endpoint.
 */
model LiveEventEndpoint {
  /**
   * The endpoint protocol.
   */
  protocol?: string;

  /**
   * The endpoint URL.
   */
  url?: string;
}

/**
 * The live event metadata insertion endpoint.
 */
model LiveEventTimedMetadataEndpoint {
  /**
   * The metadata endpoint URL.
   */
  url?: string;
}

/**
 * Live event preview settings.
 */
model LiveEventPreview {
  /**
   * The endpoints for preview. Do not share the preview URL with the live event audience.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  endpoints?: LiveEventEndpoint[];

  /**
   * The access control for live event preview.
   */
  accessControl?: LiveEventPreviewAccessControl;

  /**
   * The identifier of the preview locator in Guid format. Specifying this at creation time allows the caller to know the preview locator url before the event is created. If omitted, the service will generate a random identifier. This value cannot be updated once the live event is created.
   */
  previewLocator?: string;

  /**
   * The name of streaming policy used for the live event preview. This value is specified at creation time and cannot be updated.
   */
  streamingPolicyName?: string;

  /**
   * An alternative media identifier associated with the streaming locator created for the preview. This value is specified at creation time and cannot be updated. The identifier can be used in the CustomLicenseAcquisitionUrlTemplate or the CustomKeyAcquisitionUrlTemplate of the StreamingPolicy specified in the StreamingPolicyName field.
   */
  alternativeMediaId?: string;
}

/**
 * The IP access control for the live event preview endpoint.
 */
model LiveEventPreviewAccessControl {
  /**
   * The IP access control properties.
   */
  ip?: IPAccessControl;
}

/**
 * Specifies the live event type and optional encoding settings for encoding live events.
 */
model LiveEventEncoding {
  /**
   * Live event type. When encodingType is set to PassthroughBasic or PassthroughStandard, the service simply passes through the incoming video and audio layer(s) to the output. When encodingType is set to Standard or Premium1080p, a live encoder transcodes the incoming stream into multiple bitrates or layers. See https://go.microsoft.com/fwlink/?linkid=2095101 for more information. This property cannot be modified after the live event is created.
   */
  encodingType?: LiveEventEncodingType;

  /**
   * The optional encoding preset name, used when encodingType is not None. This value is specified at creation time and cannot be updated. If the encodingType is set to Standard, then the default preset name is ‘Default720p’. Else if the encodingType is set to Premium1080p, the default preset is ‘Default1080p’.
   */
  presetName?: string;

  /**
   * Specifies how the input video will be resized to fit the desired output resolution(s). Default is None
   */
  stretchMode?: StretchMode;

  /**
   * Use an ISO 8601 time value between 0.5 to 20 seconds to specify the output fragment length for the video and audio tracks of an encoding live event. For example, use PT2S to indicate 2 seconds. For the video track it also defines the key frame interval, or the length of a GoP (group of pictures).   If this value is not set for an encoding live event, the fragment duration defaults to 2 seconds. The value cannot be set for pass-through live events.
   */
  keyFrameInterval?: duration;
}

/**
 * Describes the transcription tracks in the output of a live event, generated using speech-to-text transcription. This property is reserved for future use, any value set on this property will be ignored.
 */
model LiveEventTranscription {
  /**
   * Specifies the language (locale) to be used for speech-to-text transcription – it should match the spoken language in the audio track. The value should be in BCP-47 format (e.g: 'en-US'). See https://go.microsoft.com/fwlink/?linkid=2133742 for more information about the live transcription feature and the list of supported languages.
   */
  language?: string;

  /**
   * Provides a mechanism to select the audio track in the input live feed, to which speech-to-text transcription is applied. This property is reserved for future use, any value set on this property will be ignored.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  inputTrackSelection?: LiveEventInputTrackSelection[];

  /**
   * Describes a transcription track in the output of a live event, generated using speech-to-text transcription. This property is reserved for future use, any value set on this property will be ignored.
   */
  outputTranscriptionTrack?: LiveEventOutputTranscriptionTrack;
}

/**
 * A track selection condition. This property is reserved for future use, any value set on this property will be ignored.
 */
model LiveEventInputTrackSelection {
  /**
   * Property name to select. This property is reserved for future use, any value set on this property will be ignored.
   */
  property?: string;

  /**
   * Comparing operation. This property is reserved for future use, any value set on this property will be ignored.
   */
  operation?: string;

  /**
   * Property value to select. This property is reserved for future use, any value set on this property will be ignored.
   */
  value?: string;
}

/**
 * Describes a transcription track in the output of a live event, generated using speech-to-text transcription. This property is reserved for future use, any value set on this property will be ignored.
 */
model LiveEventOutputTranscriptionTrack {
  /**
   * The output track name. This property is reserved for future use, any value set on this property will be ignored.
   */
  trackName: string;
}

/**
 * The client access policy.
 */
model CrossSiteAccessPolicies {
  /**
   * The content of clientaccesspolicy.xml used by Silverlight.
   */
  clientAccessPolicy?: string;

  /**
   * The content of crossdomain.xml used by Silverlight.
   */
  crossDomainPolicy?: string;
}

/**
 * The LiveEvent action input parameter definition.
 */
model LiveEventActionInput {
  /**
   * The flag indicates whether live outputs are automatically deleted when live event is being stopped. Deleting live outputs do not delete the underlying assets.
   */
  removeOutputsOnStop?: boolean;
}

/**
 * Get live event status result.
 */
@pagedResult
model LiveEventGetStatusResult {
  /**
   * The result of the get live event status.
   */
  @items
  @OpenAPI.extension("x-ms-identifiers", #[])
  value?: LiveEventStatus[];
}

/**
 * The live event status.
 */
model LiveEventStatus {
  /**
   * Current state of the live event. See https://go.microsoft.com/fwlink/?linkid=2139012 for more information.
   */
  state?: LiveEventState;

  /**
   * Health status of last 20 seconds.
   */
  healthStatus?: LiveEventHealthStatus;

  /**
   * List of strings justifying the health status.
   */
  healthDescriptions?: string[];

  /**
   * Last updated UTC time of this status.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * Live event ingestion entry.
   */
  ingestion?: LiveEventIngestion;

  /**
   * Track entry list.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  trackStatus?: LiveEventTrackStatus[];
}

/**
 * The live event ingestion telemetry data.
 */
model LiveEventIngestion {
  /**
   * Ingestion stream name.
   */
  streamName?: string;

  /**
   * Ingestion begin time in UTC.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  begin?: utcDateTime;

  /**
   * Ingestion end time in UTC. Empty if it's not stopped yet.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  end?: utcDateTime;

  /**
   * Reason why ingestion stops. Empty if it's not stopped yet. E.g) Service Stopped. No Ingestion.
   */
  endReason?: string;

  /**
   * IngestInterruption entry list.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  ingestInterruptions?: LiveEventIngestInterruption[];
}

/**
 * The live event ingest interruption data.
 */
model LiveEventIngestInterruption {
  /**
   * UTC time of interruption start, encoder disconnected.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  begin?: utcDateTime;

  /**
   * UTC time of interruption end, encoder re-connected.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  end?: utcDateTime;

  /**
   * Duration of interruption in ISO 8601 time. For example, use PT1H30M to indicate 1 hour and 30 minutes.
   */
  duration?: duration;

  /**
   * Interruption reason.
   */
  reason?: string;
}

/**
 * The live event track status.
 */
model LiveEventTrackStatus {
  /**
   * Track Id.
   */
  trackId?: string;

  /**
   * Expected bitrate for this track.
   */
  expectedBitrate?: int64;

  /**
   * Average incoming bitrate for last 20 seconds when live event is running.
   */
  incomingBitrate?: int64;

  /**
   * Current ingest drift value in seconds for last 1 minute.
   */
  ingestDrift?: string;

  /**
   * Total number of timed metadata request received.
   */
  requestReceived?: int64;

  /**
   * Total number of successful timed metadata request received.
   */
  requestSucceeded?: int64;
}

/**
 * Get live event stream events result.
 */
@pagedResult
model LiveEventGetStreamEventsResult {
  /**
   * The result of the get live event stream events.
   */
  @items
  @OpenAPI.extension("x-ms-identifiers", #[])
  value?: LiveEventStreamEvent[];
}

/**
 * The live event stream event.
 */
model LiveEventStreamEvent {
  /**
   * The type of the stream event. Format: StreamEvent/{eventType}
   */
  eventType?: LiveEventStreamEventType;

  /**
   * The time event raised.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  /**
   * Event level.
   */
  eventLevel?: LiveEventStreamEventLevel;

  /**
   * Event data based on event type.
   */
  data?: LiveEventStreamEventData;
}

/**
 * The live event stream event data.
 */
model LiveEventStreamEventData {
  /**
   * Name of the track.
   */
  trackName?: string;

  /**
   * Stream ID in the format "trackName_bitrate"
   */
  streamId?: string;

  /**
   * Track index.
   */
  trackId?: int32;

  /**
   * Type of the track.
   */
  mediaType?: LiveEventStreamEventMediaType;

  /**
   * Bitrate of the track.
   */
  bitrate?: int64;

  /**
   * Fragment timestamp in timescale.
   */
  mediaTimestamp?: string;

  /**
   * Timescale in which timestamps are expressed.
   */
  timescale?: string;

  /**
   * Previous fragment timestamp in timescale.
   */
  previousFragmentTimestamp?: string;

  /**
   * Previous fragment duration in timescale.
   */
  previousFragmentDuration?: string;

  /**
   * Current fragment timestamp in timescale.
   */
  currentFragmentTimestamp?: string;

  /**
   * Timestamp of first fragment used to make a comparison, in timescale.
   */
  fragmentOneTimestamp?: string;

  /**
   * Duration of first fragment used to make a comparison, in timescale.
   */
  fragmentOneDuration?: string;

  /**
   * Timestamp of second fragment used to make a comparison, in timescale.
   */
  fragmentTwoTimestamp?: string;

  /**
   * Duration of second fragment used to make a comparison, in timescale.
   */
  fragmentTwoDuration?: string;

  /**
   * Reason the fragment was dropped.
   */
  fragmentDropReason?: string;

  /**
   * Length of the discontinuity gap in timescale.
   */
  discontinuityGap?: int64;

  /**
   * Identifier of the stream or connection. Encoder or customer is responsible to add this ID in the ingest URL.
   */
  streamName?: string;

  /**
   * Result code.
   */
  resultCode?: string;

  /**
   * Result message.
   */
  resultMessage?: string;

  /**
   * Fragment duration.
   */
  duration?: string;

  /**
   * Width x Height for video, null otherwise.
   */
  resolution?: string;

  /**
   * The smaller timestamp of the two fragments compared.
   */
  minTime?: string;

  /**
   * The media type of the smaller timestamp of two fragments compared.
   */
  minTimeMediaType?: LiveEventStreamEventMinTimeMediaType;

  /**
   * The larger timestamp of the two fragments compared.
   */
  maxTime?: string;

  /**
   * The media type of the larger timestamp of two fragments compared.
   */
  maxTimeMediaType?: LiveEventStreamEventMaxTimeMediaType;

  /**
   * Timescale of the fragment with the smaller timestamp.
   */
  timescaleOfMinTime?: string;

  /**
   * Timescale of the fragment with the larger timestamp.
   */
  timescaleOfMaxTime?: string;

  /**
   * Truncated IP of the encoder.
   */
  remoteIp?: string;

  /**
   * Port of the encoder.
   */
  remotePort?: string;
}

/**
 * Get live event track ingest heart beats result.
 */
@pagedResult
model LiveEventGetTrackIngestHeartbeatsResult {
  /**
   * The result of the get live event track events.
   */
  @items
  @OpenAPI.extension("x-ms-identifiers", #[])
  value?: LiveEventTrackEvent[];
}

/**
 * The live event track event.
 */
model LiveEventTrackEvent {
  /**
   * The type of the track event.
   */
  eventType?: LiveEventTrackEventType;

  /**
   * The time event raised.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  /**
   * Event data.
   */
  data?: LiveEventTrackEventData;
}

/**
 * The live event track ingest heart beat event data.
 */
model LiveEventTrackEventData {
  /**
   * Name of the track.
   */
  trackName?: string;

  /**
   * Type of the track.
   */
  trackType?: LiveEventTrackEventTrackType;

  /**
   * Bitrate of the track.
   */
  bitrate?: int64;

  /**
   * Calculated bitrate based on data chunks coming from encoder.
   */
  incomingBitrate?: int64;

  /**
   * Latest timestamp received for a track in last 20 seconds.
   */
  lastTimestamp?: string;

  /**
   * Timescale in which timestamps are expressed.
   */
  timescale?: string;

  /**
   * Number of data chunks that had overlapped timestamps in last 20 seconds.
   */
  overlapCount?: int64;

  /**
   * Number of discontinuities detected in the last 20 seconds.
   */
  discontinuityCount?: int64;

  /**
   * Number of data chunks with timestamps in the past that were received in last 20 seconds.
   */
  nonincreasingCount?: int64;

  /**
   * If expected and actual bitrates differ by more than allowed limit in last 20 seconds.
   */
  unexpectedBitrate?: boolean;

  /**
   * State of the live event.
   */
  state?: string;

  /**
   * Indicates whether ingest is healthy.
   */
  healthy?: boolean;

  /**
   * The last timestamp in UTC that a fragment arrived at the ingest endpoint.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastFragmentArrivalTime?: utcDateTime;

  /**
   * Indicates the speed of delay, in seconds-per-minute, of the incoming audio or video data during the last minute. The value is greater than zero if data is arriving to the live event slower than expected in the last minute; zero if data arrived with no delay; and "n/a" if no audio or video data was received. For example, if you have a contribution encoder sending in live content, and it is slowing down due to processing issues, or network latency, it may be only able to deliver a total of 58 seconds of audio or video in a one-minute period. This would be reported as two seconds-per-minute of drift. If the encoder is able to catch up and send all 60 seconds or more of data every minute, you will see this value reported as 0. If there was a disconnection or discontinuity from the encoder, this value may still display as 0, as it does not account for breaks in the data - only data that is delayed in timestamps.
   */
  ingestDriftValue?: string;

  /**
   * This value is "On" for audio track heartbeats if live transcription is turned on, otherwise you will see an empty string. This state is only applicable to track type of "audio" for Live transcription. All other tracks will have an empty value.
   */
  transcriptionState?: string;

  /**
   * The language code (in BCP-47 format) of the transcription language. For example, "de-de" indicates German (Germany). The value is empty for the video track heartbeats, or when live transcription is turned off.
   */
  transcriptionLanguage?: string;
}

/**
 * The status of an async operation.
 */
model AsyncOperationResult {
  /**
   * The error object
   */
  error?: ErrorDetail;

  /**
   * Operation Id of the async operation.
   */
  name?: string;

  /**
   * Operation status of the async operation.
   */
  status?: AsyncOperationStatus;
}

/**
 * The LiveOutput list result.
 */
@pagedResult
model LiveOutputListResult {
  /**
   * The result of the List LiveOutput operation.
   */
  @items
  value?: LiveOutput[];

  /**
   * The number of result.
   */
  `@odata.count`?: int32;

  /**
   * The link to the next set of results. Not empty if value contains incomplete list of live outputs.
   */
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * The JSON object that contains the properties required to create a live output.
 */
model LiveOutputProperties {
  /**
   * The description of the live output.
   */
  description?: string;

  /**
   * The asset that the live output will write to.
   */
  assetName: string;

  /**
   * ISO 8601 time between 1 minute to 25 hours to indicate the maximum content length that can be archived in the asset for this live output. This also sets the maximum content length for the rewind window. For example, use PT1H30M to indicate 1 hour and 30 minutes of archive window.
   */
  archiveWindowLength: duration;

  /**
   * ISO 8601 time between 1 minute to the duration of archiveWindowLength to control seek-able window length during Live. The service won't use this property once LiveOutput stops. The archived VOD will have full content with original ArchiveWindowLength. For example, use PT1H30M to indicate 1 hour and 30 minutes of rewind window length. Service will use implicit default value 30m only if Live Event enables LL.
   */
  rewindWindowLength?: duration;

  /**
   * The manifest file name. If not provided, the service will generate one automatically.
   */
  manifestName?: string;

  /**
   * HTTP Live Streaming (HLS) packing setting for the live output.
   */
  hls?: Hls;

  /**
   * The initial timestamp that the live output will start at, any content before this value will not be archived.
   */
  outputSnapTime?: int64;

  /**
   * The creation time the live output.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The time the live output was last modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * The provisioning state of the live output.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The resource state of the live output.
   */
  @visibility(Lifecycle.Read)
  resourceState?: LiveOutputResourceState;
}

/**
 * HTTP Live Streaming (HLS) packing setting for the live output.
 */
model Hls {
  /**
   * The number of fragments in an HTTP Live Streaming (HLS) TS segment in the output of the live event. This value does not affect the packing ratio for HLS CMAF output.
   */
  fragmentsPerTsSegment?: int32;
}

/**
 * The streaming endpoint list result.
 */
@pagedResult
model StreamingEndpointListResult {
  /**
   * The result of the List StreamingEndpoint operation.
   */
  @items
  value?: StreamingEndpoint[];

  /**
   * The number of result.
   */
  `@odata.count`?: int32;

  /**
   * The link to the next set of results. Not empty if value contains incomplete list of streaming endpoints.
   */
  @nextLink
  `@odata.nextLink`?: string;
}

/**
 * The streaming endpoint properties.
 */
model StreamingEndpointProperties {
  /**
   * The streaming endpoint description.
   */
  description?: string;

  /**
   * The number of scale units. Use the Scale operation to adjust this value.
   */
  scaleUnits: int32;

  /**
   * This feature is deprecated, do not set a value for this property.
   */
  availabilitySetName?: string;

  /**
   * The access control definition of the streaming endpoint.
   */
  accessControl?: StreamingEndpointAccessControl;

  /**
   * Max cache age
   */
  maxCacheAge?: int64;

  /**
   * The custom host names of the streaming endpoint
   */
  customHostNames?: string[];

  /**
   * The streaming endpoint host name.
   */
  @visibility(Lifecycle.Read)
  hostName?: string;

  /**
   * The CDN enabled flag.
   */
  cdnEnabled?: boolean;

  /**
   * The CDN provider name.
   */
  cdnProvider?: string;

  /**
   * The CDN profile name.
   */
  cdnProfile?: string;

  /**
   * The provisioning state of the streaming endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The resource state of the streaming endpoint.
   */
  @visibility(Lifecycle.Read)
  resourceState?: StreamingEndpointResourceState;

  /**
   * The streaming endpoint access policies.
   */
  crossSiteAccessPolicies?: CrossSiteAccessPolicies;

  /**
   * The free trial expiration time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  freeTrialEndTime?: utcDateTime;

  /**
   * The exact time the streaming endpoint was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The exact time the streaming endpoint was last modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;
}

/**
 * Streaming endpoint access control definition.
 */
model StreamingEndpointAccessControl {
  /**
   * The access control of Akamai
   */
  akamai?: AkamaiAccessControl;

  /**
   * The IP access control of the streaming endpoint.
   */
  ip?: IPAccessControl;
}

/**
 * Akamai access control
 */
model AkamaiAccessControl {
  /**
   * authentication key list
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  akamaiSignatureHeaderAuthenticationKeyList?: AkamaiSignatureHeaderAuthenticationKey[];
}

/**
 * Akamai Signature Header authentication key.
 */
model AkamaiSignatureHeaderAuthenticationKey {
  /**
   * identifier of the key
   */
  identifier?: string;

  /**
   * authentication key
   */
  base64Key?: string;

  /**
   * The expiration time of the authentication key.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration?: utcDateTime;
}

/**
 * The streaming endpoint current sku.
 */
model ArmStreamingEndpointCurrentSku {
  /**
   * The streaming endpoint sku name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The streaming endpoint sku capacity.
   */
  capacity?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model StreamingEndpointSkuInfoListResult {
  /**
   * The result of the List StreamingEndpoint skus.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  value?: ArmStreamingEndpointSkuInfo[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ArmStreamingEndpointSkuInfo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  resourceType?: string;

  /**
   * The streaming endpoint sku capacity.
   */
  capacity?: ArmStreamingEndpointCapacity;

  /**
   * The streaming endpoint sku.
   */
  sku?: ArmStreamingEndpointSku;
}

/**
 * The streaming endpoint sku capacity.
 */
model ArmStreamingEndpointCapacity {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  scaleType?: string;

  /**
   * The streaming endpoint default capacity.
   */
  default?: int32;

  /**
   * The streaming endpoint minimum capacity.
   */
  minimum?: int32;

  /**
   * The streaming endpoint maximum capacity.
   */
  maximum?: int32;
}

/**
 * The streaming endpoint sku.
 */
model ArmStreamingEndpointSku {
  /**
   * The streaming endpoint sku name.
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * scale units definition
 */
model StreamingEntityScaleUnit {
  /**
   * The scale unit number of the streaming endpoint.
   */
  scaleUnit?: int32;
}

/**
 * The HLS setting for a track.
 */
model HlsSettings {
  /**
   * The default for the HLS setting.
   */
  default?: boolean;

  /**
   * The forced for the HLS setting.
   */
  forced?: boolean;

  /**
   * The characteristics for the HLS setting.
   */
  characteristics?: string;
}

/**
 * The DASH setting for a track.
 */
model DashSettings {
  /**
   * The role for the DASH setting.
   */
  role?: string;
}

/**
 * Represents an audio track in the asset.
 */
model AudioTrack extends TrackBase {
  /**
   * The file name to the source file. This file is located in the storage container of the asset.
   */
  fileName?: string;

  /**
   * The display name of the audio track on a video player. In HLS, this maps to the NAME attribute of EXT-X-MEDIA.
   */
  displayName?: string;

  /**
   * The RFC5646 language code for the audio track.
   */
  languageCode?: string;

  /**
   * The HLS specific setting for the audio track.
   */
  hlsSettings?: HlsSettings;

  /**
   * The DASH specific setting for the audio track.
   */
  dashSettings?: DashSettings;

  /**
   * The MPEG-4 audio track ID for the audio track.
   */
  mpeg4TrackId?: int32;

  /**
   * The stream bit rate for the audio track.
   */
  @visibility(Lifecycle.Read)
  bitRate?: int32;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.AudioTrack";
}

/**
 * Represents a video track in the asset.
 */
model VideoTrack extends TrackBase {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.VideoTrack";
}

/**
 * Represents a text track in an asset. A text track is usually used for sparse data related to the audio or video tracks.
 */
model TextTrack extends TrackBase {
  /**
   * The file name to the source file. This file is located in the storage container of the asset.
   */
  fileName?: string;

  /**
   * The display name of the text track on a video player. In HLS, this maps to the NAME attribute of EXT-X-MEDIA.
   */
  displayName?: string;

  /**
   * The RFC5646 language code for the text track.
   */
  @visibility(Lifecycle.Read)
  languageCode?: string;

  /**
   * When PlayerVisibility is set to "Visible", the text track will be present in the DASH manifest or HLS playlist when requested by a client. When the PlayerVisibility is set to "Hidden", the text will not be available to the client. The default value is "Visible".
   */
  playerVisibility?: Visibility;

  /**
   * The HLS specific setting for the text track.
   */
  hlsSettings?: HlsSettings;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.TextTrack";
}

/**
 * Configures the Explicit Analog Television Output Restriction control bits. For further details see the PlayReady Compliance Rules.
 */
model ContentKeyPolicyPlayReadyExplicitAnalogTelevisionRestriction {
  /**
   * Indicates whether this restriction is enforced on a Best Effort basis.
   */
  bestEffort: boolean;

  /**
   * Configures the restriction control bits. Must be between 0 and 3 inclusive.
   */
  configurationData: int32;
}

/**
 * Base class for content key ID location. A derived class must be used to represent the location.
 */
@discriminator("@odata.type")
model ContentKeyPolicyPlayReadyContentKeyLocation {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;
}

/**
 * Specifies that the content key ID is in the PlayReady header.
 */
model ContentKeyPolicyPlayReadyContentEncryptionKeyFromHeader
  extends ContentKeyPolicyPlayReadyContentKeyLocation {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicyPlayReadyContentEncryptionKeyFromHeader";
}

/**
 * Specifies that the content key ID is specified in the PlayReady configuration.
 */
model ContentKeyPolicyPlayReadyContentEncryptionKeyFromKeyIdentifier
  extends ContentKeyPolicyPlayReadyContentKeyLocation {
  /**
   * The content key ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  keyId: string;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicyPlayReadyContentEncryptionKeyFromKeyIdentifier";
}

/**
 * Configures the Play Right in the PlayReady license.
 */
model ContentKeyPolicyPlayReadyPlayRight {
  /**
   * The amount of time that the license is valid after the license is first used to play content.
   */
  firstPlayExpiration?: duration;

  /**
   * Configures the Serial Copy Management System (SCMS) in the license. Must be between 0 and 3 inclusive.
   */
  scmsRestriction?: int32;

  /**
   * Configures Automatic Gain Control (AGC) and Color Stripe in the license. Must be between 0 and 3 inclusive.
   */
  agcAndColorStripeRestriction?: int32;

  /**
   * Configures the Explicit Analog Television Output Restriction in the license. Configuration data must be between 0 and 3 inclusive.
   */
  explicitAnalogTelevisionOutputRestriction?: ContentKeyPolicyPlayReadyExplicitAnalogTelevisionRestriction;

  /**
   * Enables the Image Constraint For Analog Component Video Restriction in the license.
   */
  digitalVideoOnlyContentRestriction: boolean;

  /**
   * Enables the Image Constraint For Analog Component Video Restriction in the license.
   */
  imageConstraintForAnalogComponentVideoRestriction: boolean;

  /**
   * Enables the Image Constraint For Analog Component Video Restriction in the license.
   */
  imageConstraintForAnalogComputerMonitorRestriction: boolean;

  /**
   * Configures Unknown output handling settings of the license.
   */
  allowPassingVideoContentToUnknownOutput: ContentKeyPolicyPlayReadyUnknownOutputPassingOption;

  /**
   * Specifies the output protection level for uncompressed digital video.
   */
  uncompressedDigitalVideoOpl?: int32;

  /**
   * Specifies the output protection level for compressed digital video.
   */
  compressedDigitalVideoOpl?: int32;

  /**
   * Specifies the output protection level for compressed digital audio.
   */
  analogVideoOpl?: int32;

  /**
   * Specifies the output protection level for compressed digital audio.
   */
  compressedDigitalAudioOpl?: int32;

  /**
   * Specifies the output protection level for uncompressed digital audio.
   */
  uncompressedDigitalAudioOpl?: int32;
}

/**
 * Represents a token claim.
 */
model ContentKeyPolicyTokenClaim {
  /**
   * Token claim type.
   */
  claimType?: string;

  /**
   * Token claim value.
   */
  claimValue?: string;
}

/**
 * The PlayReady license
 */
model ContentKeyPolicyPlayReadyLicense {
  /**
   * A flag indicating whether test devices can use the license.
   */
  allowTestDevices: boolean;

  /**
   * The security level.
   */
  securityLevel?: SecurityLevel;

  /**
   * The begin date of license
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  beginDate?: utcDateTime;

  /**
   * The expiration date of license.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * The relative begin date of license.
   */
  relativeBeginDate?: duration;

  /**
   * The relative expiration date of license.
   */
  relativeExpirationDate?: duration;

  /**
   * The grace period of license.
   */
  gracePeriod?: duration;

  /**
   * The license PlayRight
   */
  playRight?: ContentKeyPolicyPlayReadyPlayRight;

  /**
   * The license type.
   */
  licenseType: ContentKeyPolicyPlayReadyLicenseType;

  /**
   * The content key location.
   */
  contentKeyLocation: ContentKeyPolicyPlayReadyContentKeyLocation;

  /**
   * The PlayReady content type.
   */
  contentType: ContentKeyPolicyPlayReadyContentType;
}

/**
 * Represents an open restriction. License or key will be delivered on every request.
 */
model ContentKeyPolicyOpenRestriction extends ContentKeyPolicyRestriction {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicyOpenRestriction";
}

/**
 * Represents a ContentKeyPolicyRestriction that is unavailable in the current API version.
 */
model ContentKeyPolicyUnknownRestriction extends ContentKeyPolicyRestriction {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicyUnknownRestriction";
}

/**
 * Base class for Content Key Policy key for token validation. A derived class must be used to create a token key.
 */
@discriminator("@odata.type")
model ContentKeyPolicyRestrictionTokenKey {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;
}

/**
 * Specifies a symmetric key for token validation.
 */
model ContentKeyPolicySymmetricTokenKey
  extends ContentKeyPolicyRestrictionTokenKey {
  /**
   * The key value of the key
   */
  keyValue: bytes;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicySymmetricTokenKey";
}

/**
 * Specifies a RSA key for token validation
 */
model ContentKeyPolicyRsaTokenKey extends ContentKeyPolicyRestrictionTokenKey {
  /**
   * The RSA Parameter exponent
   */
  exponent: bytes;

  /**
   * The RSA Parameter modulus
   */
  modulus: bytes;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicyRsaTokenKey";
}

/**
 * Specifies a certificate for token validation.
 */
model ContentKeyPolicyX509CertificateTokenKey
  extends ContentKeyPolicyRestrictionTokenKey {
  /**
   * The raw data field of a certificate in PKCS 12 format (X509Certificate2 in .NET)
   */
  rawBody: bytes;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicyX509CertificateTokenKey";
}

/**
 * Represents a token restriction. Provided token must match these requirements for successful license or key delivery.
 */
model ContentKeyPolicyTokenRestriction extends ContentKeyPolicyRestriction {
  /**
   * The token issuer.
   */
  issuer: string;

  /**
   * The audience for the token.
   */
  audience: string;

  /**
   * The primary verification key.
   */
  primaryVerificationKey: ContentKeyPolicyRestrictionTokenKey;

  /**
   * A list of alternative verification keys.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  alternateVerificationKeys?: ContentKeyPolicyRestrictionTokenKey[];

  /**
   * A list of required token claims.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  requiredClaims?: ContentKeyPolicyTokenClaim[];

  /**
   * The type of token.
   */
  restrictionTokenType: ContentKeyPolicyRestrictionTokenType;

  /**
   * The OpenID connect discovery document.
   */
  openIdConnectDiscoveryDocument?: string;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicyTokenRestriction";
}

/**
 * Represents a configuration for non-DRM keys.
 */
model ContentKeyPolicyClearKeyConfiguration
  extends ContentKeyPolicyConfiguration {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicyClearKeyConfiguration";
}

/**
 * Represents a ContentKeyPolicyConfiguration that is unavailable in the current API version.
 */
model ContentKeyPolicyUnknownConfiguration
  extends ContentKeyPolicyConfiguration {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicyUnknownConfiguration";
}

/**
 * Specifies a configuration for Widevine licenses.
 */
model ContentKeyPolicyWidevineConfiguration
  extends ContentKeyPolicyConfiguration {
  /**
   * The Widevine template.
   */
  widevineTemplate: string;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicyWidevineConfiguration";
}

/**
 * Specifies a configuration for PlayReady licenses.
 */
model ContentKeyPolicyPlayReadyConfiguration
  extends ContentKeyPolicyConfiguration {
  /**
   * The PlayReady licenses.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  licenses: ContentKeyPolicyPlayReadyLicense[];

  /**
   * The custom response data.
   */
  responseCustomData?: string;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicyPlayReadyConfiguration";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ContentKeyPolicyFairPlayOfflineRentalConfiguration {
  /**
   * Playback duration
   */
  playbackDurationSeconds: int64;

  /**
   * Storage duration
   */
  storageDurationSeconds: int64;
}

/**
 * Specifies a configuration for FairPlay licenses.
 */
model ContentKeyPolicyFairPlayConfiguration
  extends ContentKeyPolicyConfiguration {
  /**
   * The key that must be used as FairPlay Application Secret key. This needs to be base64 encoded.
   */
  ask: bytes;

  /**
   * The password encrypting FairPlay certificate in PKCS 12 (pfx) format.
   */
  fairPlayPfxPassword: string;

  /**
   * The Base64 representation of FairPlay certificate in PKCS 12 (pfx) format (including private key).
   */
  fairPlayPfx: string;

  /**
   * The rental and lease key type.
   */
  rentalAndLeaseKeyType: ContentKeyPolicyFairPlayRentalAndLeaseKeyType;

  /**
   * The rental duration. Must be greater than or equal to 0.
   */
  rentalDuration: int64;

  /**
   * Offline rental policy
   */
  offlineRentalConfiguration?: ContentKeyPolicyFairPlayOfflineRentalConfiguration;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.ContentKeyPolicyFairPlayConfiguration";
}

/**
 * Describes the basic properties of all codecs.
 */
@discriminator("@odata.type")
model Codec {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;

  /**
   * An optional label for the codec. The label can be used to control muxing behavior.
   */
  label?: string;
}

/**
 * Defines the common properties for all audio codecs.
 */
@discriminator("@odata.type")
model Audio extends Codec {
  /**
   * The number of channels in the audio.
   */
  channels?: int32;

  /**
   * The sampling rate to use for encoding in hertz.
   */
  samplingRate?: int32;

  /**
   * The bitrate, in bits per second, of the output encoded audio.
   */
  bitrate?: int32;
}

/**
 * Describes Advanced Audio Codec (AAC) audio encoding settings.
 */
model AacAudio extends Audio {
  /**
   * The encoding profile to be used when encoding audio with AAC.
   */
  profile?: AacAudioProfile;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.AacAudio";
}

/**
 * Describes Dolby Digital Audio Codec (AC3) audio encoding settings. The current implementation for Dolby Digital Audio support are: Audio channel numbers at 1((mono), 2(stereo), 6(5.1side); Audio sampling frequency rates at: 32K/44.1K/48K Hz; Audio bitrate values as AC3 specification supports: 32000, 40000, 48000, 56000, 64000, 80000, 96000, 112000, 128000, 160000, 192000, 224000, 256000, 320000, 384000, 448000, 512000, 576000, 640000 bps.
 */
model DDAudio extends Audio {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.DDAudio";
}

/**
 * Describes the properties of a Fade effect applied to the input media.
 */
model Fade {
  /**
   * The Duration of the fade effect in the video. The value can be in ISO 8601 format (For example, PT05S to fade In/Out a color during 5 seconds), or a frame count (For example, 10 to fade 10 frames from the start time), or a relative value to stream duration (For example, 10% to fade 10% of stream duration)
   */
  duration: duration;

  /**
   * The Color for the fade In/Out. it can be on the CSS Level1 colors https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/color_keywords or an RGB/hex value: e.g: rgb(255,0,0), 0xFF0000 or #FF0000
   */
  fadeColor: string;

  /**
   * The position in the input video from where to start fade. The value can be in ISO 8601 format (For example, PT05S to start at 5 seconds), or a frame count (For example, 10 to start at the 10th frame), or a relative value to stream duration (For example, 10% to start at 10% of stream duration). Default is 0
   */
  start?: string;
}

/**
 * The encoder can be configured to produce video and/or images (thumbnails) at different resolutions, by specifying a layer for each desired resolution. A layer represents the properties for the video or image at a resolution.
 */
model Layer {
  /**
   * The width of the output video for this layer. The value can be absolute (in pixels) or relative (in percentage). For example 50% means the output video has half as many pixels in width as the input.
   */
  width?: string;

  /**
   * The height of the output video for this layer. The value can be absolute (in pixels) or relative (in percentage). For example 50% means the output video has half as many pixels in height as the input.
   */
  height?: string;

  /**
   * The alphanumeric label for this layer, which can be used in multiplexing different video and audio layers, or in naming the output file.
   */
  label?: string;
}

/**
 * Describes the settings to be used when encoding the input video into a desired output bitrate layer.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model H265VideoLayer extends Layer {
  /**
   * The average bitrate in bits per second at which to encode the input video when generating this layer. For example: a target bitrate of 3000Kbps or 3Mbps means this value should be 3000000 This is a required field.
   */
  bitrate: int32;

  /**
   * The maximum bitrate (in bits per second), at which the VBV buffer should be assumed to refill. If not specified, defaults to the same value as bitrate.
   */
  maxBitrate?: int32;

  /**
   * The number of B-frames to be used when encoding this layer.  If not specified, the encoder chooses an appropriate number based on the video profile and level.
   */
  bFrames?: int32;

  /**
   * The frame rate (in frames per second) at which to encode this layer. The value can be in the form of M/N where M and N are integers (For example, 30000/1001), or in the form of a number (For example, 30, or 29.97). The encoder enforces constraints on allowed frame rates based on the profile and level. If it is not specified, the encoder will use the same frame rate as the input video.
   */
  frameRate?: string;

  /**
   * The number of slices to be used when encoding this layer. If not specified, default is zero, which means that encoder will use a single slice for each frame.
   */
  slices?: int32;

  /**
   * Specifies whether or not adaptive B-frames are to be used when encoding this layer. If not specified, the encoder will turn it on whenever the video profile permits its use.
   */
  adaptiveBFrame?: boolean;
}

/**
 * Describes the settings to be used when encoding the input video into a desired output bitrate layer with the H.265 video codec.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model H265Layer extends H265VideoLayer {
  /**
   * We currently support Main. Default is Auto.
   */
  profile?: H265VideoProfile;

  /**
   * We currently support Level up to 6.2. The value can be Auto, or a number that matches the H.265 profile. If not specified, the default is Auto, which lets the encoder choose the Level that is appropriate for this layer.
   */
  level?: string;

  /**
   * The VBV buffer window length. The value should be in ISO 8601 format. The value should be in the range [0.1-100] seconds. The default is 5 seconds (for example, PT5S).
   */
  bufferWindow?: duration;

  /**
   * The value of CRF to be used when encoding this layer. This setting takes effect when RateControlMode of video codec is set at CRF mode. The range of CRF value is between 0 and 51, where lower values would result in better quality, at the expense of higher file sizes. Higher values mean more compression, but at some point quality degradation will be noticed. Default value is 28.
   */
  crf?: float32;

  /**
   * The number of reference frames to be used when encoding this layer. If not specified, the encoder determines an appropriate number based on the encoder complexity setting.
   */
  referenceFrames?: int32;
}

/**
 * Describes the basic properties for encoding the input video.
 */
@discriminator("@odata.type")
model Video extends Codec {
  /**
   * The distance between two key frames. The value should be non-zero in the range [0.5, 20] seconds, specified in ISO 8601 format. The default is 2 seconds(PT2S). Note that this setting is ignored if VideoSyncMode.Passthrough is set, where the KeyFrameInterval value will follow the input source setting.
   */
  keyFrameInterval?: duration;

  /**
   * The resizing mode - how the input video will be resized to fit the desired output resolution(s). Default is AutoSize
   */
  stretchMode?: StretchMode;

  /**
   * The Video Sync Mode
   */
  syncMode?: VideoSyncMode;
}

/**
 * Describes all the properties for encoding a video with the H.265 codec.
 */
model H265Video extends Video {
  /**
   * Specifies whether or not the encoder should insert key frames at scene changes. If not specified, the default is false. This flag should be set to true only when the encoder is being configured to produce a single output video.
   */
  sceneChangeDetection?: boolean;

  /**
   * Tells the encoder how to choose its encoding settings.  Quality will provide for a higher compression ratio but at a higher cost and longer compute time.  Speed will produce a relatively larger file but is faster and more economical. The default value is Balanced.
   */
  complexity?: H265Complexity;

  /**
   * The collection of output H.265 layers to be produced by the encoder.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  layers?: H265Layer[];

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.H265Video";
}

/**
 * Base type for all TrackDescriptor types, which define the metadata and selection for tracks that should be processed by a Job
 */
@discriminator("@odata.type")
model TrackDescriptor {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;
}

/**
 * A TrackSelection to select audio tracks.
 */
@discriminator("@odata.type")
model AudioTrackDescriptor extends TrackDescriptor {
  /**
   * Optional designation for single channel audio tracks.  Can be used to combine the tracks into stereo or multi-channel audio tracks.
   */
  channelMapping?: ChannelMapping;
}

/**
 * Select audio tracks from the input by specifying an attribute and an attribute filter.
 */
model SelectAudioTrackByAttribute extends AudioTrackDescriptor {
  /**
   * The TrackAttribute to filter the tracks by.
   */
  attribute: TrackAttribute;

  /**
   * The type of AttributeFilter to apply to the TrackAttribute in order to select the tracks.
   */
  filter: AttributeFilter;

  /**
   * The value to filter the tracks by.  Only used when AttributeFilter.ValueEquals is specified for the Filter property.
   */
  filterValue?: string;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.SelectAudioTrackByAttribute";
}

/**
 * Select audio tracks from the input by specifying a track identifier.
 */
model SelectAudioTrackById extends AudioTrackDescriptor {
  /**
   * Track identifier to select
   */
  trackId: int64;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.SelectAudioTrackById";
}

/**
 * Base class for defining an input. Use sub classes of this class to specify tracks selections and related metadata.
 */
@discriminator("@odata.type")
model InputDefinition {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;

  /**
   * The list of TrackDescriptors which define the metadata and selection of tracks in the input.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  includedTracks?: TrackDescriptor[];
}

/**
 * An InputDefinition that looks across all of the files provided to select tracks specified by the IncludedTracks property. Generally used with the AudioTrackByAttribute and VideoTrackByAttribute to allow selection of a single track across a set of input files.
 */
model FromAllInputFile extends InputDefinition {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.FromAllInputFile";
}

/**
 * An InputDefinition that looks at each input file provided to select tracks specified by the IncludedTracks property. Generally used with the AudioTrackByAttribute and VideoTrackByAttribute to select tracks from each file given.
 */
model FromEachInputFile extends InputDefinition {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.FromEachInputFile";
}

/**
 * An InputDefinition for a single file.  TrackSelections are scoped to the file specified.
 */
model InputFile extends InputDefinition {
  /**
   * Name of the file that this input definition applies to.
   */
  filename?: string;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.InputFile";
}

/**
 * Describes all the settings to be used when analyzing a video in order to detect (and optionally redact) all the faces present.
 */
model FaceDetectorPreset extends Preset {
  /**
   * Specifies the maximum resolution at which your video is analyzed. The default behavior is "SourceResolution," which will keep the input video at its original resolution when analyzed. Using "StandardDefinition" will resize input videos to standard definition while preserving the appropriate aspect ratio. It will only resize if the video is of higher resolution. For example, a 1920x1080 input would be scaled to 640x360 before processing. Switching to "StandardDefinition" will reduce the time it takes to process high resolution video. It may also reduce the cost of using this component (see https://azure.microsoft.com/en-us/pricing/details/media-services/#analytics for details). However, faces that end up being too small in the resized video may not be detected.
   */
  resolution?: AnalysisResolution;

  /**
   * This mode provides the ability to choose between the following settings: 1) Analyze - For detection only.This mode generates a metadata JSON file marking appearances of faces throughout the video.Where possible, appearances of the same person are assigned the same ID. 2) Combined - Additionally redacts(blurs) detected faces. 3) Redact - This enables a 2-pass process, allowing for selective redaction of a subset of detected faces.It takes in the metadata file from a prior analyze pass, along with the source video, and a user-selected subset of IDs that require redaction.
   */
  mode?: FaceRedactorMode;

  /**
   * Blur type
   */
  blurType?: BlurType;

  /**
   * Dictionary containing key value pairs for parameters not exposed in the preset itself
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  experimentalOptions?: Record<string>;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.FaceDetectorPreset";
}

/**
 * The Audio Analyzer preset applies a pre-defined set of AI-based analysis operations, including speech transcription. Currently, the preset supports processing of content with a single audio track.
 */
@discriminator("@odata.type")
model AudioAnalyzerPreset extends Preset {
  /**
   * The language for the audio payload in the input using the BCP-47 format of 'language tag-region' (e.g: 'en-US').  If you know the language of your content, it is recommended that you specify it. The language must be specified explicitly for AudioAnalysisMode::Basic, since automatic language detection is not included in basic mode. If the language isn't specified or set to null, automatic language detection will choose the first language detected and process with the selected language for the duration of the file. It does not currently support dynamically switching between languages after the first language is detected. The automatic detection works best with audio recordings with clearly discernable speech. If automatic detection fails to find the language, transcription would fallback to 'en-US'." The list of supported languages is available here: https://go.microsoft.com/fwlink/?linkid=2109463
   */
  audioLanguage?: string;

  /**
   * Determines the set of audio analysis operations to be performed. If unspecified, the Standard AudioAnalysisMode would be chosen.
   */
  mode?: AudioAnalysisMode;

  /**
   * Dictionary containing key value pairs for parameters not exposed in the preset itself
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  experimentalOptions?: Record<string>;
}

/**
 * Base type for all overlays - image, audio or video.
 */
@discriminator("@odata.type")
model Overlay {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;

  /**
   * The label of the job input which is to be used as an overlay. The Input must specify exactly one file. You can specify an image file in JPG, PNG, GIF or BMP format, or an audio file (such as a WAV, MP3, WMA or M4A file), or a video file. See https://aka.ms/mesformats for the complete list of supported audio and video file formats.
   */
  inputLabel: string;

  /**
   * The start position, with reference to the input video, at which the overlay starts. The value should be in ISO 8601 format. For example, PT05S to start the overlay at 5 seconds into the input video. If not specified the overlay starts from the beginning of the input video.
   */
  start?: duration;

  /**
   * The end position, with reference to the input video, at which the overlay ends. The value should be in ISO 8601 format. For example, PT30S to end the overlay at 30 seconds into the input video. If not specified or the value is greater than the input video duration, the overlay will be applied until the end of the input video if the overlay media duration is greater than the input video duration, else the overlay will last as long as the overlay media duration.
   */
  end?: duration;

  /**
   * The duration over which the overlay fades in onto the input video. The value should be in ISO 8601 duration format. If not specified the default behavior is to have no fade in (same as PT0S).
   */
  fadeInDuration?: duration;

  /**
   * The duration over which the overlay fades out of the input video. The value should be in ISO 8601 duration format. If not specified the default behavior is to have no fade out (same as PT0S).
   */
  fadeOutDuration?: duration;

  /**
   * The gain level of audio in the overlay. The value should be in the range [0, 1.0]. The default is 1.0.
   */
  audioGainLevel?: float64;
}

/**
 * Describes the properties of an audio overlay.
 */
model AudioOverlay extends Overlay {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.AudioOverlay";
}

/**
 * A codec flag, which tells the encoder to copy the input video bitstream without re-encoding.
 */
model CopyVideo extends Codec {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.CopyVideo";
}

/**
 * Describes the basic properties for generating thumbnails from the input video
 */
@discriminator("@odata.type")
model Image extends Video {
  /**
   * The position in the input video from where to start generating thumbnails. The value can be in ISO 8601 format (For example, PT05S to start at 5 seconds), or a frame count (For example, 10 to start at the 10th frame), or a relative value to stream duration (For example, 10% to start at 10% of stream duration). Also supports a macro {Best}, which tells the encoder to select the best thumbnail from the first few seconds of the video and will only produce one thumbnail, no matter what other settings are for Step and Range. The default value is macro {Best}.
   */
  start: string;

  /**
   * The intervals at which thumbnails are generated. The value can be in ISO 8601 format (For example, PT05S for one image every 5 seconds), or a frame count (For example, 30 for one image every 30 frames), or a relative value to stream duration (For example, 10% for one image every 10% of stream duration). Note: Step value will affect the first generated thumbnail, which may not be exactly the one specified at transform preset start time. This is due to the encoder, which tries to select the best thumbnail between start time and Step position from start time as the first output. As the default value is 10%, it means if stream has long duration, the first generated thumbnail might be far away from the one specified at start time. Try to select reasonable value for Step if the first thumbnail is expected close to start time, or set Range value at 1 if only one thumbnail is needed at start time.
   */
  step?: string;

  /**
   * The position relative to transform preset start time in the input video at which to stop generating thumbnails. The value can be in ISO 8601 format (For example, PT5M30S to stop at 5 minutes and 30 seconds from start time), or a frame count (For example, 300 to stop at the 300th frame from the frame at start time. If this value is 1, it means only producing one thumbnail at start time), or a relative value to the stream duration (For example, 50% to stop at half of stream duration from start time). The default value is 100%, which means to stop at the end of the stream.
   */
  range?: string;
}

/**
 * Base class for output.
 */
@discriminator("@odata.type")
model Format {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;

  /**
   * The file naming pattern used for the creation of output files. The following macros are supported in the file name: {Basename} - An expansion macro that will use the name of the input video file. If the base name(the file suffix is not included) of the input video file is less than 32 characters long, the base name of input video files will be used. If the length of base name of the input video file exceeds 32 characters, the base name is truncated to the first 32 characters in total length. {Extension} - The appropriate extension for this format. {Label} - The label assigned to the codec/layer. {Index} - A unique index for thumbnails. Only applicable to thumbnails. {AudioStream} - string "Audio" plus audio stream number(start from 1). {Bitrate} - The audio/video bitrate in kbps. Not applicable to thumbnails. {Codec} - The type of the audio/video codec. {Resolution} - The video resolution. Any unsubstituted macros will be collapsed and removed from the filename.
   */
  filenamePattern: string;
}

/**
 * Describes the properties for an output image file.
 */
@discriminator("@odata.type")
model ImageFormat extends Format {}

/**
 * Describes the settings for producing JPEG thumbnails.
 */
model JpgFormat extends ImageFormat {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.JpgFormat";
}

/**
 * Describes the settings for producing PNG thumbnails.
 */
model PngFormat extends ImageFormat {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.PngFormat";
}

/**
 * A codec flag, which tells the encoder to copy the input audio bitstream.
 */
model CopyAudio extends Codec {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.CopyAudio";
}

/**
 * Describes the de-interlacing settings.
 */
model Deinterlace {
  /**
   * The field parity for de-interlacing, defaults to Auto.
   */
  parity?: DeinterlaceParity;

  /**
   * The deinterlacing mode. Defaults to AutoPixelAdaptive.
   */
  mode?: DeinterlaceMode;
}

/**
 * Describes the properties of a rectangular window applied to the input media before processing it.
 */
model Rectangle {
  /**
   * The number of pixels from the left-margin. This can be absolute pixel value (e.g 100), or relative to the size of the video (For example, 50%).
   */
  left?: string;

  /**
   * The number of pixels from the top-margin. This can be absolute pixel value (e.g 100), or relative to the size of the video (For example, 50%).
   */
  top?: string;

  /**
   * The width of the rectangular region in pixels. This can be absolute pixel value (e.g 100), or relative to the size of the video (For example, 50%).
   */
  width?: string;

  /**
   * The height of the rectangular region in pixels. This can be absolute pixel value (e.g 100), or relative to the size of the video (For example, 50%).
   */
  height?: string;
}

/**
 * Describes all the filtering operations, such as de-interlacing, rotation etc. that are to be applied to the input media before encoding.
 */
model Filters {
  /**
   * The de-interlacing settings.
   */
  deinterlace?: Deinterlace;

  /**
   * The rotation, if any, to be applied to the input video, before it is encoded. Default is Auto
   */
  rotation?: Rotation;

  /**
   * The parameters for the rectangular window with which to crop the input video.
   */
  crop?: Rectangle;

  /**
   * Describes the properties of a Fade effect applied to the input media.
   */
  fadeIn?: Fade;

  /**
   * Describes the properties of a Fade effect applied to the input media.
   */
  fadeOut?: Fade;

  /**
   * The properties of overlays to be applied to the input video. These could be audio, image or video overlays.
   */
  @OpenAPI.extension("x-ms-identifiers", #["inputLabel"])
  overlays?: Overlay[];
}

/**
 * Describes the settings to be used when encoding the input video into a desired output bitrate layer.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model VideoLayer extends Layer {
  /**
   * The average bitrate in bits per second at which to encode the input video when generating this layer. This is a required field.
   */
  bitrate: int32;

  /**
   * The maximum bitrate (in bits per second), at which the VBV buffer should be assumed to refill. If not specified, defaults to the same value as bitrate.
   */
  maxBitrate?: int32;

  /**
   * The number of B-frames to be used when encoding this layer.  If not specified, the encoder chooses an appropriate number based on the video profile and level.
   */
  bFrames?: int32;

  /**
   * The frame rate (in frames per second) at which to encode this layer. The value can be in the form of M/N where M and N are integers (For example, 30000/1001), or in the form of a number (For example, 30, or 29.97). The encoder enforces constraints on allowed frame rates based on the profile and level. If it is not specified, the encoder will use the same frame rate as the input video.
   */
  frameRate?: string;

  /**
   * The number of slices to be used when encoding this layer. If not specified, default is zero, which means that encoder will use a single slice for each frame.
   */
  slices?: int32;

  /**
   * Whether or not adaptive B-frames are to be used when encoding this layer. If not specified, the encoder will turn it on whenever the video profile permits its use.
   */
  adaptiveBFrame?: boolean;
}

/**
 * Describes the settings to be used when encoding the input video into a desired output bitrate layer with the H.264 video codec.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model H264Layer extends VideoLayer {
  /**
   * We currently support Baseline, Main, High, High422, High444. Default is Auto.
   */
  profile?: H264VideoProfile;

  /**
   * We currently support Level up to 6.2. The value can be Auto, or a number that matches the H.264 profile. If not specified, the default is Auto, which lets the encoder choose the Level that is appropriate for this layer.
   */
  level?: string;

  /**
   * The VBV buffer window length. The value should be in ISO 8601 format. The value should be in the range [0.1-100] seconds. The default is 5 seconds (for example, PT5S).
   */
  bufferWindow?: duration;

  /**
   * The value of CRF to be used when encoding this layer. This setting takes effect when RateControlMode of video codec is set at CRF mode. The range of CRF value is between 0 and 51, where lower values would result in better quality, at the expense of higher file sizes. Higher values mean more compression, but at some point quality degradation will be noticed. Default value is 23.
   */
  crf?: float32;

  /**
   * The number of reference frames to be used when encoding this layer. If not specified, the encoder determines an appropriate number based on the encoder complexity setting.
   */
  referenceFrames?: int32;

  /**
   * The entropy mode to be used for this layer. If not specified, the encoder chooses the mode that is appropriate for the profile and level.
   */
  entropyMode?: EntropyMode;
}

/**
 * Describes all the properties for encoding a video with the H.264 codec.
 */
model H264Video extends Video {
  /**
   * Tells the encoder how to choose its encoding settings. The default value is Balanced.
   */
  complexity?: H264Complexity;

  /**
   * The collection of output H.264 layers to be produced by the encoder.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  layers?: H264Layer[];

  /**
   * The video rate control mode
   */
  rateControlMode?: H264RateControlMode;

  /**
   * Whether or not the encoder should insert key frames at scene changes. If not specified, the default is false. This flag should be set to true only when the encoder is being configured to produce a single output video.
   */
  sceneChangeDetection?: boolean;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.H264Video";
}

/**
 * Describes the properties for producing a series of JPEG images from the input video.
 */
model JpgImage extends Image {
  /**
   * A collection of output JPEG image layers to be produced by the encoder.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  layers?: JpgLayer[];

  /**
   * Sets the number of columns used in thumbnail sprite image.  The number of rows are automatically calculated and a VTT file is generated with the coordinate mappings for each thumbnail in the sprite. Note: this value should be a positive integer and a proper value is recommended so that the output image resolution will not go beyond JPEG maximum pixel resolution limit 65535x65535.
   */
  spriteColumn?: int32;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.JpgImage";
}

/**
 * Describes the settings to produce a JPEG image from the input video.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model JpgLayer extends Layer {
  /**
   * The compression quality of the JPEG output. Range is from 0-100 and the default is 70.
   */
  quality?: int32;
}

/**
 * Describes the properties for producing a collection of GOP aligned multi-bitrate files. The default behavior is to produce one output file for each video layer which is muxed together with all the audios. The exact output files produced can be controlled by specifying the outputFiles collection.
 */
@discriminator("@odata.type")
model MultiBitrateFormat extends Format {
  /**
   * The list of output files to produce.  Each entry in the list is a set of audio and video layer labels to be muxed together .
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  outputFiles?: OutputFile[];
}

/**
 * Represents an output file produced.
 */
model OutputFile {
  /**
   * The list of labels that describe how the encoder should multiplex video and audio into an output file. For example, if the encoder is producing two video layers with labels v1 and v2, and one audio layer with label a1, then an array like '[v1, a1]' tells the encoder to produce an output file with the video track represented by v1 and the audio track represented by a1.
   */
  labels: string[];
}

/**
 * Describes the properties for an output ISO MP4 file.
 */
model Mp4Format extends MultiBitrateFormat {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.Mp4Format";
}

/**
 * Describes the properties for producing a series of PNG images from the input video.
 */
model PngImage extends Image {
  /**
   * A collection of output PNG image layers to be produced by the encoder.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  layers?: PngLayer[];

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.PngImage";
}

/**
 * Describes the settings to produce a PNG image from the input video.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PngLayer extends Layer {}

/**
 * Describes a built-in preset for encoding the input video with the Standard Encoder.
 */
model BuiltInStandardEncoderPreset extends Preset {
  /**
   * Optional configuration settings for encoder. Configurations is only supported for ContentAwareEncoding and H265ContentAwareEncoding BuiltInStandardEncoderPreset.
   */
  configurations?: PresetConfigurations;

  /**
   * The built-in preset to be used for encoding videos.
   */
  presetName: EncoderNamedPreset;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.BuiltInStandardEncoderPreset";
}

/**
 * An object of optional configuration settings for encoder.
 */
model PresetConfigurations {
  /**
   * Allows you to configure the encoder settings to control the balance between speed and quality. Example: set Complexity as Speed for faster encoding but less compression efficiency.
   */
  complexity?: Complexity;

  /**
   * Sets the interleave mode of the output to control how audio and video are stored in the container format. Example: set InterleavedOutput as NonInterleavedOutput to produce audio-only and video-only outputs in separate MP4 files.
   */
  interleaveOutput?: InterleaveOutput;

  /**
   * The key frame interval in seconds. Example: set KeyFrameIntervalInSeconds as 2 to reduce the playback buffering for some players.
   */
  keyFrameIntervalInSeconds?: float32;

  /**
   * The maximum bitrate in bits per second (threshold for the top video layer). Example: set MaxBitrateBps as 6000000 to avoid producing very high bitrate outputs for contents with high complexity.
   */
  maxBitrateBps?: int32;

  /**
   * The maximum height of output video layers. Example: set MaxHeight as 720 to produce output layers up to 720P even if the input is 4K.
   */
  maxHeight?: int32;

  /**
   * The maximum number of output video layers. Example: set MaxLayers as 4 to make sure at most 4 output layers are produced to control the overall cost of the encoding job.
   */
  maxLayers?: int32;

  /**
   * The minimum bitrate in bits per second (threshold for the bottom video layer). Example: set MinBitrateBps as 200000 to have a bottom layer that covers users with low network bandwidth.
   */
  minBitrateBps?: int32;

  /**
   * The minimum height of output video layers. Example: set MinHeight as 360 to avoid output layers of smaller resolutions like 180P.
   */
  minHeight?: int32;
}

/**
 * Describes all the settings to be used when encoding the input video with the Standard Encoder.
 */
model StandardEncoderPreset extends Preset {
  /**
   * Dictionary containing key value pairs for parameters not exposed in the preset itself
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  experimentalOptions?: Record<string>;

  /**
   * One or more filtering operations that are applied to the input media before encoding.
   */
  filters?: Filters;

  /**
   * The list of codecs to be used when encoding the input video.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  codecs: Codec[];

  /**
   * The list of outputs to be produced by the encoder.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  formats: Format[];

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.StandardEncoderPreset";
}

/**
 * A video analyzer preset that extracts insights (rich metadata) from both audio and video, and outputs a JSON format file.
 */
model VideoAnalyzerPreset extends AudioAnalyzerPreset {
  /**
   * Defines the type of insights that you want the service to generate. The allowed values are 'AudioInsightsOnly', 'VideoInsightsOnly', and 'AllInsights'. The default is AllInsights. If you set this to AllInsights and the input is audio only, then only audio insights are generated. Similarly if the input is video only, then only video insights are generated. It is recommended that you not use AudioInsightsOnly if you expect some of your inputs to be video only; or use VideoInsightsOnly if you expect some of your inputs to be audio only. Your Jobs in such conditions would error out.
   */
  insightsToExtract?: InsightsType;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.VideoAnalyzerPreset";
}

/**
 * Describes the properties for generating an MPEG-2 Transport Stream (ISO/IEC 13818-1) output video file(s).
 */
model TransportStreamFormat extends MultiBitrateFormat {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.TransportStreamFormat";
}

/**
 * Describes the properties of a video overlay.
 */
model VideoOverlay extends Overlay {
  /**
   * The location in the input video where the overlay is applied.
   */
  position?: Rectangle;

  /**
   * The opacity of the overlay. This is a value in the range [0 - 1.0]. Default is 1.0 which mean the overlay is opaque.
   */
  opacity?: float64;

  /**
   * An optional rectangular window used to crop the overlay image or video.
   */
  cropRectangle?: Rectangle;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.VideoOverlay";
}

/**
 * A TrackSelection to select video tracks.
 */
@discriminator("@odata.type")
model VideoTrackDescriptor extends TrackDescriptor {}

/**
 * Select video tracks from the input by specifying an attribute and an attribute filter.
 */
model SelectVideoTrackByAttribute extends VideoTrackDescriptor {
  /**
   * The TrackAttribute to filter the tracks by.
   */
  attribute: TrackAttribute;

  /**
   * The type of AttributeFilter to apply to the TrackAttribute in order to select the tracks.
   */
  filter: AttributeFilter;

  /**
   * The value to filter the tracks by.  Only used when AttributeFilter.ValueEquals is specified for the Filter property. For TrackAttribute.Bitrate, this should be an integer value in bits per second (e.g: '1500000').  The TrackAttribute.Language is not supported for video tracks.
   */
  filterValue?: string;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.SelectVideoTrackByAttribute";
}

/**
 * Select video tracks from the input by specifying a track identifier.
 */
model SelectVideoTrackById extends VideoTrackDescriptor {
  /**
   * Track identifier to select
   */
  trackId: int64;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.SelectVideoTrackById";
}

/**
 * Represents input files for a Job.
 */
@discriminator("@odata.type")
model JobInputClip extends JobInput {
  /**
   * List of files. Required for JobInputHttp. Maximum of 4000 characters each. Query strings will not be returned in service responses to prevent sensitive data exposure.
   */
  files?: string[];

  /**
   * Defines a point on the timeline of the input media at which processing will start. Defaults to the beginning of the input media.
   */
  start?: ClipTime;

  /**
   * Defines a point on the timeline of the input media at which processing will end. Defaults to the end of the input media.
   */
  end?: ClipTime;

  /**
   * A label that is assigned to a JobInputClip, that is used to satisfy a reference used in the Transform. For example, a Transform can be authored so as to take an image file with the label 'xyz' and apply it as an overlay onto the input video before it is encoded. When submitting a Job, exactly one of the JobInputs should be the image file, and it should have the label 'xyz'.
   */
  label?: string;

  /**
   * Defines a list of InputDefinitions. For each InputDefinition, it defines a list of track selections and related metadata.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  inputDefinitions?: InputDefinition[];
}

/**
 * Base class for specifying a clip time. Use sub classes of this class to specify the time position in the media.
 */
@discriminator("@odata.type")
model ClipTime {
  /**
   * The discriminator for derived types.
   */
  `@odata.type`: string;
}

/**
 * Specifies the clip time as an absolute time position in the media file.  The absolute time can point to a different position depending on whether the media file starts from a timestamp of zero or not.
 */
model AbsoluteClipTime extends ClipTime {
  /**
   * The time position on the timeline of the input media. It is usually specified as an ISO8601 period. e.g PT30S for 30 seconds.
   */
  time: duration;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.AbsoluteClipTime";
}

/**
 * Specifies the clip time as a Utc time position in the media file.  The Utc time can point to a different position depending on whether the media file starts from a timestamp of zero or not.
 */
model UtcClipTime extends ClipTime {
  /**
   * The time position on the timeline of the input media based on Utc time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time: utcDateTime;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.UtcClipTime";
}

/**
 * Describes a list of inputs to a Job.
 */
model JobInputs extends JobInput {
  /**
   * List of inputs to a Job.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  inputs?: JobInput[];

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.JobInputs";
}

/**
 * Represents an Asset for input into a Job.
 */
model JobInputAsset extends JobInputClip {
  /**
   * The name of the input Asset.
   */
  assetName: string;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.JobInputAsset";
}

/**
 * Represents HTTPS job input.
 */
model JobInputHttp extends JobInputClip {
  /**
   * Base URI for HTTPS job input. It will be concatenated with provided file names. If no base uri is given, then the provided file list is assumed to be fully qualified uris. Maximum length of 4000 characters. The query strings will not be returned in service responses to prevent sensitive data exposure.
   */
  baseUri?: string;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.JobInputHttp";
}

/**
 * Represents an Asset used as a JobOutput.
 */
model JobOutputAsset extends JobOutput {
  /**
   * The name of the output Asset.
   */
  assetName: string;

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.JobOutputAsset";
}

/**
 * A Sequence contains an ordered list of Clips where each clip is a JobInput.  The Sequence will be treated as a single input.
 */
model JobInputSequence extends JobInput {
  /**
   * JobInputs that make up the timeline.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  inputs?: JobInputClip[];

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.JobInputSequence";
}
