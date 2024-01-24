import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Media;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The track property type.
 */
enum FilterTrackPropertyType {
  /**
   * The unknown track property type.
   */
  Unknown,

  /**
   * The type.
   */
  Type,

  /**
   * The name.
   */
  Name,

  /**
   * The language.
   */
  Language,

  /**
   * The fourCC.
   */
  FourCC,

  /**
   * The bitrate.
   */
  Bitrate,
}

/**
 * The track property condition operation.
 */
enum FilterTrackPropertyCompareOperation {
  /**
   * The equal operation.
   */
  Equal,

  /**
   * The not equal operation.
   */
  NotEqual,
}

/**
 * The metric unit
 */
enum MetricUnit {
  /**
   * The number of bytes.
   */
  Bytes,

  /**
   * The count.
   */
  Count,

  /**
   * The number of milliseconds.
   */
  Milliseconds,
}

/**
 * The metric aggregation type
 */
enum MetricAggregationType {
  /**
   * The average.
   */
  Average,

  /**
   * The count of a number of items, usually requests.
   */
  Count,

  /**
   * The sum.
   */
  Total,
}

/**
 * The type of the storage account.
 */
enum StorageAccountType {
  /**
   * The primary storage account for the Media Services account.
   */
  Primary,

  /**
   * A secondary storage account for the Media Services account.
   */
  Secondary,
}

enum StorageAuthentication {
  /**
   * System authentication.
   */
  System,

  /**
   * Managed Identity authentication.
   */
  ManagedIdentity,
}

/**
 * The type of key used to encrypt the Account Key.
 */
enum AccountEncryptionKeyType {
  /**
   * The Account Key is encrypted with a System Key.
   */
  SystemKey,

  /**
   * The Account Key is encrypted with a Customer Key.
   */
  CustomerKey,
}

/**
 * The behavior for IP access control in Key Delivery.
 */
enum DefaultAction {
  /**
   * All public IP addresses are allowed.
   */
  Allow,

  /**
   * Public IP addresses are blocked.
   */
  Deny,
}

/**
 * Whether or not public network access is allowed for resources under the Media Services account.
 */
enum PublicNetworkAccess {
  /**
   * Public network access is enabled.
   */
  Enabled,

  /**
   * Public network access is disabled.
   */
  Disabled,
}

/**
 * Provisioning state of the Media Services account.
 */
enum ProvisioningState {
  /**
   * Provisioning state failed.
   */
  Failed,

  /**
   * Provisioning state in progress.
   */
  InProgress,

  /**
   * Provisioning state succeeded.
   */
  Succeeded,
}

/**
 * The private endpoint connection status.
 */
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

/**
 * The current provisioning state.
 */
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

/**
 * The minimum TLS version allowed for this account's requests. This is an optional property. If unspecified, a secure default value will be used.
 */
enum MinimumTlsVersion {
  /**
   * Minimum TLS version is TLS 1.0.
   */
  Tls10,

  /**
   * Minimum TLS version is TLS 1.1.
   */
  Tls11,

  /**
   * Minimum TLS version is TLS 1.2.
   */
  Tls12,

  /**
   * Minimum TLS version is TLS 1.3.
   */
  Tls13,
}

/**
 * The Asset encryption format. One of None or MediaStorageEncryption.
 */
enum AssetStorageEncryptionFormat {
  /**
   * The Asset does not use client-side storage encryption (this is the only allowed value for new Assets).
   */
  None,

  /**
   * The Asset is encrypted with Media Services client-side encryption.
   */
  MediaStorageClientEncryption,
}

/**
 * The permissions to set on the SAS URL.
 */
enum AssetContainerPermission {
  /**
   * The SAS URL will allow read access to the container.
   */
  Read,

  /**
   * The SAS URL will allow read and write access to the container.
   */
  ReadWrite,

  /**
   * The SAS URL will allow read, write and delete access to the container.
   */
  ReadWriteDelete,
}

/**
 * A Transform can define more than one outputs. This property defines what the service should do when one output fails - either continue to produce other outputs, or, stop the other outputs. The overall Job state will not reflect failures of outputs that are specified with 'ContinueJob'. The default is 'StopProcessingJob'.
 */
enum OnErrorType {
  /**
   * Tells the service that if this TransformOutput fails, then any other incomplete TransformOutputs can be stopped.
   */
  StopProcessingJob,

  /**
   * Tells the service that if this TransformOutput fails, then allow any other TransformOutput to continue.
   */
  ContinueJob,
}

/**
 * Sets the relative priority of the TransformOutputs within a Transform. This sets the priority that the service uses for processing TransformOutputs. The default priority is Normal.
 */
enum Priority {
  /**
   * Used for TransformOutputs that can be generated after Normal and High priority TransformOutputs.
   */
  Low,

  /**
   * Used for TransformOutputs that can be generated at Normal priority.
   */
  Normal,

  /**
   * Used for TransformOutputs that should take precedence over others.
   */
  High,
}

/**
 * Describes the state of the JobOutput.
 */
enum JobState {
  /**
   * The job was canceled. This is a final state for the job.
   */
  Canceled,

  /**
   * The job is in the process of being canceled. This is a transient state for the job.
   */
  Canceling,

  /**
   * The job has encountered an error. This is a final state for the job.
   */
  Error,

  /**
   * The job is finished. This is a final state for the job.
   */
  Finished,

  /**
   * The job is processing. This is a transient state for the job.
   */
  Processing,

  /**
   * The job is in a queued state, waiting for resources to become available. This is a transient state.
   */
  Queued,

  /**
   * The job is being scheduled to run on an available resource. This is a transient state, between queued and processing states.
   */
  Scheduled,
}

/**
 * Error code describing the error.
 */
enum JobErrorCode {
  /**
   * Fatal service error, please contact support.
   */
  ServiceError,

  /**
   * Transient error, please retry, if retry is unsuccessful, please contact support.
   */
  ServiceTransientError,

  /**
   * While trying to download the input files, the files were not accessible, please check the availability of the source.
   */
  DownloadNotAccessible,

  /**
   * While trying to download the input files, there was an issue during transfer (storage service, network errors), see details and check your source.
   */
  DownloadTransientError,

  /**
   * While trying to upload the output files, the destination was not reachable, please check the availability of the destination.
   */
  UploadNotAccessible,

  /**
   * While trying to upload the output files, there was an issue during transfer (storage service, network errors), see details and check your destination.
   */
  UploadTransientError,

  /**
   * There was a problem with the combination of input files and the configuration settings applied, fix the configuration settings and retry with the same input, or change input to match the configuration.
   */
  ConfigurationUnsupported,

  /**
   * There was a problem with the input content (for example: zero byte files, or corrupt/non-decodable files), check the input files.
   */
  ContentMalformed,

  /**
   * There was a problem with the format of the input (not valid media file, or an unsupported file/codec), check the validity of the input files.
   */
  ContentUnsupported,

  /**
   * There was an error verifying to the account identity. Check and fix the identity configurations and retry. If unsuccessful, please contact support.
   */
  IdentityUnsupported,
}

/**
 * Helps with categorization of errors.
 */
enum JobErrorCategory {
  /**
   * The error is service related.
   */
  Service,

  /**
   * The error is download related.
   */
  Download,

  /**
   * The error is upload related.
   */
  Upload,

  /**
   * The error is configuration related.
   */
  Configuration,

  /**
   * The error is related to data in the input files.
   */
  Content,

  /**
   * The error is related to account information.
   */
  Account,
}

/**
 * Indicates that it may be possible to retry the Job. If retry is unsuccessful, please contact Azure support via Azure Portal.
 */
enum JobRetry {
  /**
   * Issue needs to be investigated and then the job resubmitted with corrections or retried once the underlying issue has been corrected.
   */
  DoNotRetry,

  /**
   * Issue may be resolved after waiting for a period of time and resubmitting the same Job.
   */
  MayRetry,
}

/**
 * Track property type
 */
enum TrackPropertyType {
  /**
   * Unknown track property
   */
  Unknown,

  /**
   * Track FourCC
   */
  FourCC,
}

/**
 * Track property condition operation
 */
enum TrackPropertyCompareOperation {
  /**
   * Unknown track property compare operation
   */
  Unknown,

  /**
   * Equal operation
   */
  Equal,
}

/**
 * Encryption type of Content Key
 */
enum StreamingLocatorContentKeyType {
  /**
   * Common Encryption using CENC
   */
  CommonEncryptionCenc,

  /**
   * Common Encryption using CBCS
   */
  CommonEncryptionCbcs,

  /**
   * Envelope Encryption
   */
  EnvelopeEncryption,
}

/**
 * Streaming protocol
 */
enum StreamingPolicyStreamingProtocol {
  /**
   * HLS protocol
   */
  Hls,

  /**
   * DASH protocol
   */
  Dash,

  /**
   * SmoothStreaming protocol
   */
  SmoothStreaming,

  /**
   * Download protocol
   */
  Download,
}

/**
 * Encryption scheme
 */
enum EncryptionScheme {
  /**
   * NoEncryption scheme
   */
  NoEncryption,

  /**
   * EnvelopeEncryption scheme
   */
  EnvelopeEncryption,

  /**
   * CommonEncryptionCenc scheme
   */
  CommonEncryptionCenc,

  /**
   * CommonEncryptionCbcs scheme
   */
  CommonEncryptionCbcs,
}

/**
 * The input protocol for the live event. This is specified at creation time and cannot be updated.
 */
enum LiveEventInputProtocol {
  /**
   * Smooth Streaming input will be sent by the contribution encoder to the live event.
   */
  FragmentedMP4,

  /**
   * RTMP input will be sent by the contribution encoder to the live event.
   */
  RTMP,
}

/**
 * Live event type. When encodingType is set to PassthroughBasic or PassthroughStandard, the service simply passes through the incoming video and audio layer(s) to the output. When encodingType is set to Standard or Premium1080p, a live encoder transcodes the incoming stream into multiple bitrates or layers. See https://go.microsoft.com/fwlink/?linkid=2095101 for more information. This property cannot be modified after the live event is created.
 */
enum LiveEventEncodingType {
  /**
   * This is the same as PassthroughStandard, please see description below. This enumeration value is being deprecated.
   */
  None,

  /**
   * A contribution live encoder sends a single bitrate stream to the live event and Media Services creates multiple bitrate streams. The output cannot exceed 720p in resolution.
   */
  Standard,

  /**
   * A contribution live encoder sends a single bitrate stream to the live event and Media Services creates multiple bitrate streams. The output cannot exceed 1080p in resolution.
   */
  Premium1080p,

  /**
   * The ingested stream passes through the live event from the contribution encoder without any further processing. In the PassthroughBasic mode, ingestion is limited to up to 5Mbps and only 1 concurrent live output is allowed. Live transcription is not available.
   */
  PassthroughBasic,

  /**
   * The ingested stream passes through the live event from the contribution encoder without any further processing. Live transcription is available. Ingestion bitrate limits are much higher and up to 3 concurrent live outputs are allowed.
   */
  PassthroughStandard,
}

/**
 * The resizing mode - how the input video will be resized to fit the desired output resolution(s). Default is AutoSize
 */
enum StretchMode {
  /**
   * Strictly respect the output resolution without considering the pixel aspect ratio or display aspect ratio of the input video.
   */
  None,

  /**
   * Override the output resolution, and change it to match the display aspect ratio of the input, without padding. For example, if the input is 1920x1080 and the encoding preset asks for 1280x1280, then the value in the preset is overridden, and the output will be at 1280x720, which maintains the input aspect ratio of 16:9.
   */
  AutoSize,

  /**
   * Pad the output (with either letterbox or pillar box) to honor the output resolution, while ensuring that the active video region in the output has the same aspect ratio as the input. For example, if the input is 1920x1080 and the encoding preset asks for 1280x1280, then the output will be at 1280x1280, which contains an inner rectangle of 1280x720 at aspect ratio of 16:9, and pillar box regions 280 pixels wide at the left and right.
   */
  AutoFit,
}

/**
 * The resource state of the live event. See https://go.microsoft.com/fwlink/?linkid=2139012 for more information.
 */
enum LiveEventResourceState {
  /**
   * This is the initial state of the live event after creation (unless autostart was set to true.) No billing occurs in this state. In this state, the live event properties can be updated but streaming is not allowed.
   */
  Stopped,

  /**
   * Allocate action was called on the live event and resources are being provisioned for this live event. Once allocation completes successfully, the live event will transition to StandBy state.
   */
  Allocating,

  /**
   * Live event resources have been provisioned and is ready to start. Billing occurs in this state. Most properties can still be updated, however ingest or streaming is not allowed during this state.
   */
  StandBy,

  /**
   * The live event is being started and resources are being allocated. No billing occurs in this state. Updates or streaming are not allowed during this state. If an error occurs, the live event returns to the Stopped state.
   */
  Starting,

  /**
   * The live event resources have been allocated, ingest and preview URLs have been generated, and it is capable of receiving live streams. At this point, billing is active. You must explicitly call Stop on the live event resource to halt further billing.
   */
  Running,

  /**
   * The live event is being stopped and resources are being de-provisioned. No billing occurs in this transient state. Updates or streaming are not allowed during this state.
   */
  Stopping,

  /**
   * The live event is being deleted. No billing occurs in this transient state. Updates or streaming are not allowed during this state.
   */
  Deleting,
}

enum StreamOptionsFlag {
  /**
   * Live streaming with no special latency optimizations.
   */
  Default,

  /**
   * The live event provides lower end to end latency by reducing its internal buffers.
   */
  LowLatency,

  /**
   * The live event is optimized for end to end latency. This option is only available for encoding live events with RTMP input. The outputs can be streamed using HLS or DASH formats. The outputs' archive or DVR rewind length is limited to 6 hours. Use "LowLatency" stream option for all other scenarios.
   */
  LowLatencyV2,
}

/**
 * The resource state of the live output.
 */
enum LiveOutputResourceState {
  /**
   * Live output is being created. No content is archived in the asset until the live output is in running state.
   */
  Creating,

  /**
   * Live output is running and archiving live streaming content to the asset if there is valid input from a contribution encoder.
   */
  Running,

  /**
   * Live output is being deleted. The live asset is being converted from live to on-demand asset. Any streaming URLs created on the live output asset continue to work.
   */
  Deleting,
}

/**
 * The resource state of the streaming endpoint.
 */
enum StreamingEndpointResourceState {
  /**
   * The initial state of a streaming endpoint after creation. Content is not ready to be streamed from this endpoint.
   */
  Stopped,

  /**
   * The streaming endpoint is transitioning to the running state.
   */
  Starting,

  /**
   * The streaming endpoint is running. It is able to stream content to clients
   */
  Running,

  /**
   * The streaming endpoint is transitioning to the stopped state.
   */
  Stopping,

  /**
   * The streaming endpoint is being deleted.
   */
  Deleting,

  /**
   * The streaming endpoint is increasing or decreasing scale units.
   */
  Scaling,
}

/**
 * When PlayerVisibility is set to "Visible", the text track will be present in the DASH manifest or HLS playlist when requested by a client. When the PlayerVisibility is set to "Hidden", the text will not be available to the client. The default value is "Visible".
 */
enum Visibility {
  /**
   * The track is hidden to video player.
   */
  Hidden,

  /**
   * The track is visible to video player.
   */
  Visible,
}

/**
 * Configures Unknown output handling settings of the license.
 */
enum ContentKeyPolicyPlayReadyUnknownOutputPassingOption {
  /**
   * Represents a ContentKeyPolicyPlayReadyUnknownOutputPassingOption that is unavailable in current API version.
   */
  Unknown,

  /**
   * Passing the video portion of protected content to an Unknown Output is not allowed.
   */
  NotAllowed,

  /**
   * Passing the video portion of protected content to an Unknown Output is allowed.
   */
  Allowed,

  /**
   * Passing the video portion of protected content to an Unknown Output is allowed but with constrained resolution.
   */
  AllowedWithVideoConstriction,
}

/**
 * The security level.
 */
enum SecurityLevel {
  /**
   * Represents a SecurityLevel that is unavailable in current API version.
   */
  Unknown,

  /**
   * For clients under development or test. No protection against unauthorized use.
   */
  SL150,

  /**
   * For hardened devices and applications consuming commercial content. Software or hardware protection.
   */
  SL2000,

  /**
   * For hardened devices only. Hardware protection.
   */
  SL3000,
}

/**
 * The license type.
 */
enum ContentKeyPolicyPlayReadyLicenseType {
  /**
   * Represents a ContentKeyPolicyPlayReadyLicenseType that is unavailable in current API version.
   */
  Unknown,

  /**
   * Non persistent license.
   */
  NonPersistent,

  /**
   * Persistent license. Allows offline playback.
   */
  Persistent,
}

/**
 * The PlayReady content type.
 */
enum ContentKeyPolicyPlayReadyContentType {
  /**
   * Represents a ContentKeyPolicyPlayReadyContentType that is unavailable in current API version.
   */
  Unknown,

  /**
   * Unspecified content type.
   */
  Unspecified,

  /**
   * Ultraviolet download content type.
   */
  UltraVioletDownload,

  /**
   * Ultraviolet streaming content type.
   */
  UltraVioletStreaming,
}

/**
 * The type of token.
 */
enum ContentKeyPolicyRestrictionTokenType {
  /**
   * Represents a ContentKeyPolicyRestrictionTokenType that is unavailable in current API version.
   */
  Unknown,

  /**
   * Simple Web Token.
   */
  Swt,

  /**
   * JSON Web Token.
   */
  Jwt,
}

/**
 * The rental and lease key type.
 */
enum ContentKeyPolicyFairPlayRentalAndLeaseKeyType {
  /**
   * Represents a ContentKeyPolicyFairPlayRentalAndLeaseKeyType that is unavailable in current API version.
   */
  Unknown,

  /**
   * Key duration is not specified.
   */
  Undefined,

  /**
   * Dual expiry for offline rental.
   */
  DualExpiry,

  /**
   * Content key can be persisted with an unlimited duration
   */
  PersistentUnlimited,

  /**
   * Content key can be persisted and the valid duration is limited by the Rental Duration value
   */
  PersistentLimited,
}

/**
 * The encoding profile to be used when encoding audio with AAC.
 */
enum AacAudioProfile {
  /**
   * Specifies that the output audio is to be encoded into AAC Low Complexity profile (AAC-LC).
   */
  AacLc,

  /**
   * Specifies that the output audio is to be encoded into HE-AAC v1 profile.
   */
  HeAacV1,

  /**
   * Specifies that the output audio is to be encoded into HE-AAC v2 profile.
   */
  HeAacV2,
}

/**
 * We currently support Main. Default is Auto.
 */
enum H265VideoProfile {
  /**
   * Tells the encoder to automatically determine the appropriate H.265 profile.
   */
  Auto,

  /**
   * Main profile (https://x265.readthedocs.io/en/default/cli.html?highlight=profile#profile-level-tier)
   */
  Main,

  /**
   * Main 10 profile (https://en.wikipedia.org/wiki/High_Efficiency_Video_Coding#Main_10)
   */
  Main10,
}

/**
 * The Video Sync Mode
 */
enum VideoSyncMode {
  /**
   * This is the default method. Chooses between Cfr and Vfr depending on muxer capabilities. For output format MP4, the default mode is Cfr.
   */
  Auto,

  /**
   * The presentation timestamps on frames are passed through from the input file to the output file writer. Recommended when the input source has variable frame rate, and are attempting to produce multiple layers for adaptive streaming in the output which have aligned GOP boundaries. Note: if two or more frames in the input have duplicate timestamps, then the output will also have the same behavior
   */
  Passthrough,

  /**
   * Input frames will be repeated and/or dropped as needed to achieve exactly the requested constant frame rate. Recommended when the output frame rate is explicitly set at a specified value
   */
  Cfr,

  /**
   * Similar to the Passthrough mode, but if the input has frames that have duplicate timestamps, then only one frame is passed through to the output, and others are dropped. Recommended when the number of output frames is expected to be equal to the number of input frames. For example, the output is used to calculate a quality metric like PSNR against the input
   */
  Vfr,
}

/**
 * Tells the encoder how to choose its encoding settings.  Quality will provide for a higher compression ratio but at a higher cost and longer compute time.  Speed will produce a relatively larger file but is faster and more economical. The default value is Balanced.
 */
enum H265Complexity {
  /**
   * Tells the encoder to use settings that are optimized for faster encoding. Quality is sacrificed to decrease encoding time.
   */
  Speed,

  /**
   * Tells the encoder to use settings that achieve a balance between speed and quality.
   */
  Balanced,

  /**
   * Tells the encoder to use settings that are optimized to produce higher quality output at the expense of slower overall encode time.
   */
  Quality,
}

/**
 * Optional designation for single channel audio tracks.  Can be used to combine the tracks into stereo or multi-channel audio tracks.
 */
enum ChannelMapping {
  /**
   * The Front Left Channel.
   */
  FrontLeft,

  /**
   * The Front Right Channel.
   */
  FrontRight,

  /**
   * The Center Channel.
   */
  Center,

  /**
   * Low Frequency Effects Channel.  Sometimes referred to as the subwoofer.
   */
  LowFrequencyEffects,

  /**
   * The Back Left Channel.  Sometimes referred to as the Left Surround Channel.
   */
  BackLeft,

  /**
   * The Back Right Channel.  Sometimes referred to as the Right Surround Channel.
   */
  BackRight,

  /**
   * The Left Stereo channel.  Sometimes referred to as Down Mix Left.
   */
  StereoLeft,

  /**
   * The Right Stereo channel.  Sometimes referred to as Down Mix Right.
   */
  StereoRight,
}

/**
 * The TrackAttribute to filter the tracks by.
 */
enum TrackAttribute {
  /**
   * The bitrate of the track.
   */
  Bitrate,

  /**
   * The language of the track.
   */
  Language,
}

/**
 * The type of AttributeFilter to apply to the TrackAttribute in order to select the tracks.
 */
enum AttributeFilter {
  /**
   * All tracks will be included.
   */
  All,

  /**
   * The first track will be included when the attribute is sorted in descending order.  Generally used to select the largest bitrate.
   */
  Top,

  /**
   * The first track will be included when the attribute is sorted in ascending order.  Generally used to select the smallest bitrate.
   */
  Bottom,

  /**
   * Any tracks that have an attribute equal to the value given will be included.
   */
  ValueEquals,
}

/**
 * Determines the set of audio analysis operations to be performed. If unspecified, the Standard AudioAnalysisMode would be chosen.
 */
enum AudioAnalysisMode {
  /**
   * Performs all operations included in the Basic mode, additionally performing language detection and speaker diarization.
   */
  Standard,

  /**
   * This mode performs speech-to-text transcription and generation of a VTT subtitle/caption file. The output of this mode includes an Insights JSON file including only the keywords, transcription,and timing information. Automatic language detection and speaker diarization are not included in this mode.
   */
  Basic,
}

/**
 * The field parity for de-interlacing, defaults to Auto.
 */
enum DeinterlaceParity {
  /**
   * Automatically detect the order of fields
   */
  Auto,

  /**
   * Apply top field first processing of input video.
   */
  TopFieldFirst,

  /**
   * Apply bottom field first processing of input video.
   */
  BottomFieldFirst,
}

/**
 * The deinterlacing mode. Defaults to AutoPixelAdaptive.
 */
enum DeinterlaceMode {
  /**
   * Disables de-interlacing of the source video.
   */
  Off,

  /**
   * Apply automatic pixel adaptive de-interlacing on each frame in the input video.
   */
  AutoPixelAdaptive,
}

/**
 * The rotation, if any, to be applied to the input video, before it is encoded. Default is Auto
 */
enum Rotation {
  /**
   * Automatically detect and rotate as needed.
   */
  Auto,

  /**
   * Do not rotate the video.  If the output format supports it, any metadata about rotation is kept intact.
   */
  None,

  /**
   * Do not rotate the video but remove any metadata about the rotation.
   */
  Rotate0,

  /**
   * Rotate 90 degrees clockwise.
   */
  Rotate90,

  /**
   * Rotate 180 degrees clockwise.
   */
  Rotate180,

  /**
   * Rotate 270 degrees clockwise.
   */
  Rotate270,
}

/**
 * We currently support Baseline, Main, High, High422, High444. Default is Auto.
 */
enum H264VideoProfile {
  /**
   * Tells the encoder to automatically determine the appropriate H.264 profile.
   */
  Auto,

  /**
   * Baseline profile
   */
  Baseline,

  /**
   * Main profile
   */
  Main,

  /**
   * High profile.
   */
  High,

  /**
   * High 4:2:2 profile.
   */
  High422,

  /**
   * High 4:4:4 predictive profile.
   */
  High444,
}

/**
 * The entropy mode to be used for this layer. If not specified, the encoder chooses the mode that is appropriate for the profile and level.
 */
enum EntropyMode {
  /**
   * Context Adaptive Binary Arithmetic Coder (CABAC) entropy encoding.
   */
  Cabac,

  /**
   * Context Adaptive Variable Length Coder (CAVLC) entropy encoding.
   */
  Cavlc,
}

/**
 * Tells the encoder how to choose its encoding settings. The default value is Balanced.
 */
enum H264Complexity {
  /**
   * Tells the encoder to use settings that are optimized for faster encoding. Quality is sacrificed to decrease encoding time.
   */
  Speed,

  /**
   * Tells the encoder to use settings that achieve a balance between speed and quality.
   */
  Balanced,

  /**
   * Tells the encoder to use settings that are optimized to produce higher quality output at the expense of slower overall encode time.
   */
  Quality,
}

/**
 * The video rate control mode
 */
enum H264RateControlMode {
  /**
   * Average Bitrate (ABR) mode that hits the target bitrate: Default mode.
   */
  ABR,

  /**
   * Constant Bitrate (CBR) mode that tightens bitrate variations around target bitrate.
   */
  CBR,

  /**
   * Constant Rate Factor (CRF) mode that targets at constant subjective quality.
   */
  CRF,
}

/**
 * Allows you to configure the encoder settings to control the balance between speed and quality. Example: set Complexity as Speed for faster encoding but less compression efficiency.
 */
enum Complexity {
  /**
   * Configures the encoder to use settings optimized for faster encoding. Quality is sacrificed to decrease encoding time.
   */
  Speed,

  /**
   * Configures the encoder to use settings that achieve a balance between speed and quality.
   */
  Balanced,

  /**
   * Configures the encoder to use settings optimized to produce higher quality output at the expense of slower overall encode time.
   */
  Quality,
}

/**
 * Sets the interleave mode of the output to control how audio and video are stored in the container format. Example: set InterleavedOutput as NonInterleavedOutput to produce audio-only and video-only outputs in separate MP4 files.
 */
enum InterleaveOutput {
  /**
   * The output is video-only or audio-only.
   */
  NonInterleavedOutput,

  /**
   * The output includes both audio and video.
   */
  InterleavedOutput,
}

/**
 * The built-in preset to be used for encoding videos.
 */
enum EncoderNamedPreset {
  /**
   * Produces an MP4 file where the video is encoded with H.264 codec at 2200 kbps and a picture height of 480 pixels, and the stereo audio is encoded with AAC-LC codec at 128 kbps.
   */
  H264SingleBitrateSD,

  /**
   * Produces an MP4 file where the video is encoded with H.264 codec at 4500 kbps and a picture height of 720 pixels, and the stereo audio is encoded with AAC-LC codec at 128 kbps.
   */
  H264SingleBitrate720p,

  /**
   * Produces an MP4 file where the video is encoded with H.264 codec at 6750 kbps and a picture height of 1080 pixels, and the stereo audio is encoded with AAC-LC codec at 128 kbps.
   */
  H264SingleBitrate1080p,

  /**
   * Produces a set of GOP aligned MP4 files with H.264 video and stereo AAC audio. Auto-generates a bitrate ladder based on the input resolution, bitrate and frame rate. The auto-generated preset will never exceed the input resolution. For example, if the input is 720p, output will remain 720p at best.
   */
  AdaptiveStreaming,

  /**
   * Produces a single MP4 file containing only AAC stereo audio encoded at 192 kbps.
   */
  AACGoodQualityAudio,

  /**
   * Produces a single MP4 file containing only DD(Digital Dolby) stereo audio encoded at 192 kbps.
   */
  DDGoodQualityAudio,

  /**
   * Exposes an experimental preset for content-aware encoding. Given any input content, the service attempts to automatically determine the optimal number of layers, appropriate bitrate and resolution settings for delivery by adaptive streaming. The underlying algorithms will continue to evolve over time. The output will contain MP4 files with video and audio interleaved.
   */
  ContentAwareEncodingExperimental,

  /**
   * Produces a set of GOP-aligned MP4s by using content-aware encoding. Given any input content, the service performs an initial lightweight analysis of the input content, and uses the results to determine the optimal number of layers, appropriate bitrate and resolution settings for delivery by adaptive streaming. This preset is particularly effective for low and medium complexity videos, where the output files will be at lower bitrates but at a quality that still delivers a good experience to viewers. The output will contain MP4 files with video and audio interleaved.
   */
  ContentAwareEncoding,

  /**
   * Copy all video and audio streams from the input asset as non-interleaved video and audio output files. This preset can be used to clip an existing asset or convert a group of key frame (GOP) aligned MP4 files as an asset that can be streamed.
   */
  CopyAllBitrateNonInterleaved,

  /**
   * Produces a set of 8 GOP-aligned MP4 files, ranging from 6000 kbps to 400 kbps, and stereo AAC audio. Resolution starts at 1080p and goes down to 180p.
   */
  H264MultipleBitrate1080p,

  /**
   * Produces a set of 6 GOP-aligned MP4 files, ranging from 3400 kbps to 400 kbps, and stereo AAC audio. Resolution starts at 720p and goes down to 180p.
   */
  H264MultipleBitrate720p,

  /**
   * Produces a set of 5 GOP-aligned MP4 files, ranging from 1900kbps to 400 kbps, and stereo AAC audio. Resolution starts at 480p and goes down to 240p.
   */
  H264MultipleBitrateSD,

  /**
   * Produces a set of GOP-aligned MP4s by using content-aware encoding. Given any input content, the service performs an initial lightweight analysis of the input content, and uses the results to determine the optimal number of layers, appropriate bitrate and resolution settings for delivery by adaptive streaming. This preset is particularly effective for low and medium complexity videos, where the output files will be at lower bitrates but at a quality that still delivers a good experience to viewers. The output will contain MP4 files with video and audio interleaved.
   */
  H265ContentAwareEncoding,

  /**
   * Produces a set of GOP aligned MP4 files with H.265 video and stereo AAC audio. Auto-generates a bitrate ladder based on the input resolution, bitrate and frame rate. The auto-generated preset will never exceed the input resolution. For example, if the input is 720p, output will remain 720p at best.
   */
  H265AdaptiveStreaming,

  /**
   * Produces an MP4 file where the video is encoded with H.265 codec at 1800 kbps and a picture height of 720 pixels, and the stereo audio is encoded with AAC-LC codec at 128 kbps.
   */
  H265SingleBitrate720p,

  /**
   * Produces an MP4 file where the video is encoded with H.265 codec at 3500 kbps and a picture height of 1080 pixels, and the stereo audio is encoded with AAC-LC codec at 128 kbps.
   */
  H265SingleBitrate1080p,

  /**
   * Produces an MP4 file where the video is encoded with H.265 codec at 9500 kbps and a picture height of 2160 pixels, and the stereo audio is encoded with AAC-LC codec at 128 kbps.
   */
  H265SingleBitrate4K,
}

/**
 * Defines the type of insights that you want the service to generate. The allowed values are 'AudioInsightsOnly', 'VideoInsightsOnly', and 'AllInsights'. The default is AllInsights. If you set this to AllInsights and the input is audio only, then only audio insights are generated. Similarly if the input is video only, then only video insights are generated. It is recommended that you not use AudioInsightsOnly if you expect some of your inputs to be video only; or use VideoInsightsOnly if you expect some of your inputs to be audio only. Your Jobs in such conditions would error out.
 */
enum InsightsType {
  /**
   * Generate audio only insights. Ignore video even if present. Fails if no audio is present.
   */
  AudioInsightsOnly,

  /**
   * Generate video only insights. Ignore audio if present. Fails if no video is present.
   */
  VideoInsightsOnly,

  /**
   * Generate both audio and video insights. Fails if either audio or video Insights fail.
   */
  AllInsights,
}

/**
 * Operation status of the async operation.
 */
enum AsyncOperationStatus {
  Succeeded,
  Failed,
  InProgress,
}

/**
 * The Media Filter properties.
 */
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
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * The service specification property.
 */
model Properties {
  /**
   * The service specifications.
   */
  @visibility("read")
  serviceSpecification?: ServiceSpecification;
}

/**
 * The service metric specifications.
 */
model ServiceSpecification {
  /**
   * List of log specifications.
   */
  @visibility("read")
  logSpecifications?: LogSpecification[];

  /**
   * List of metric specifications.
   */
  @visibility("read")
  metricSpecifications?: MetricSpecification[];
}

/**
 * A diagnostic log emitted by service.
 */
model LogSpecification {
  /**
   * The diagnostic log category name.
   */
  @visibility("read")
  name?: string;

  /**
   * The diagnostic log category display name.
   */
  @visibility("read")
  displayName?: string;

  /**
   * The time range for requests in each blob.
   */
  @visibility("read")
  blobDuration?: string;
}

/**
 * A metric emitted by service.
 */
model MetricSpecification {
  /**
   * The metric name.
   */
  @visibility("read")
  name?: string;

  /**
   * The metric display name.
   */
  @visibility("read")
  displayName?: string;

  /**
   * The metric display description.
   */
  @visibility("read")
  displayDescription?: string;

  /**
   * The metric unit
   */
  @visibility("read")
  unit?: MetricUnit;

  /**
   * The metric aggregation type
   */
  @visibility("read")
  aggregationType?: MetricAggregationType;

  /**
   * The metric lock aggregation type
   */
  @visibility("read")
  lockAggregationType?: MetricAggregationType;

  /**
   * Supported aggregation types.
   */
  supportedAggregationTypes?: string[];

  /**
   * The metric dimensions.
   */
  @visibility("read")
  dimensions?: MetricDimension[];

  /**
   * Indicates whether regional MDM account is enabled.
   */
  @visibility("read")
  enableRegionalMdmAccount?: boolean;

  /**
   * The source MDM account.
   */
  @visibility("read")
  sourceMdmAccount?: string;

  /**
   * The source MDM namespace.
   */
  @visibility("read")
  sourceMdmNamespace?: string;

  /**
   * The supported time grain types.
   */
  @visibility("read")
  supportedTimeGrainTypes?: string[];
}

/**
 * A metric dimension.
 */
model MetricDimension {
  /**
   * The metric dimension name.
   */
  @visibility("read")
  name?: string;

  /**
   * The display name for the dimension.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Whether to export metric to shoebox.
   */
  @visibility("read")
  toBeExportedForShoebox?: boolean;
}

/**
 * Properties of the Media Services account.
 */
model MediaServiceProperties {
  /**
   * The Media Services account ID.
   */
  @visibility("read")
  mediaServiceId?: string;

  /**
   * The storage accounts for this resource.
   */
  storageAccounts?: StorageAccount[];

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
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The Private Endpoint Connections created for the Media Service account.
   */
  @visibility("read")
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
  @visibility("read")
  status?: string;
}

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
  @visibility("read")
  status?: string;
}

model KeyVaultProperties {
  /**
   * The URL of the Key Vault key used to encrypt the account. The key may either be versioned (for example https://vault/keys/mykey/version1) or reference a key without a version (for example https://vault/keys/mykey).
   */
  keyIdentifier?: string;

  /**
   * The current key used to encrypt the Media Services account, including the key version.
   */
  @visibility("read")
  currentKeyIdentifier?: string;
}

model KeyDelivery {
  /**
   * The access control properties for Key Delivery.
   */
  accessControl?: AccessControl;
}

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
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility("read")
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

model MediaServiceIdentity {
  /**
   * The identity type.
   */
  type: string;

  /**
   * The Principal ID of the identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The Tenant ID of the identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The user assigned managed identities.
   */
  userAssignedIdentities?: Record<UserAssignedManagedIdentity>;
}

model UserAssignedManagedIdentity {
  /**
   * The client ID.
   */
  @visibility("read")
  clientId?: string;

  /**
   * The principal ID.
   */
  @visibility("read")
  principalId?: string;
}

/**
 * A Media Services account update.
 */
model MediaServiceUpdate {
  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * The resource properties.
   */
  @extension("x-ms-client-flatten", true)
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

model ListEdgePoliciesInput {
  /**
   * Unique identifier of the edge device.
   */
  deviceId?: string;
}

model EdgePolicies {
  usageDataCollectionPolicy?: EdgeUsageDataCollectionPolicy;
}

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
  maxAllowedUnreportedUsageDuration?: duration;

  /**
   * Details of Event Hub where the usage will be reported.
   */
  eventHubDetails?: EdgeUsageDataEventHub;
}

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
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
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
 * The Asset properties.
 */
model AssetProperties {
  /**
   * The Asset ID.
   */
  @visibility("read")
  assetId?: string;

  /**
   * The creation date of the Asset.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The last modified date of the Asset.
   */
  @visibility("read")
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
  @visibility("read")
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
@pagedResult
model AssetContainerSas {
  /**
   * The list of Asset container SAS URLs.
   */
  @items
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
  assetFileId: string;
}

/**
 * The Streaming Locators associated with this Asset.
 */
@pagedResult
model ListStreamingLocatorsResponse {
  /**
   * The list of Streaming Locators.
   */
  @visibility("read")
  @items
  streamingLocators?: AssetStreamingLocator[];
}

/**
 * Properties of the Streaming Locator.
 */
model AssetStreamingLocator {
  /**
   * Streaming Locator name.
   */
  @visibility("read")
  name?: string;

  /**
   * Asset Name.
   */
  @visibility("read")
  assetName?: string;

  /**
   * The creation time of the Streaming Locator.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The start time of the Streaming Locator.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the Streaming Locator.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * StreamingLocatorId of the Streaming Locator.
   */
  @visibility("read")
  streamingLocatorId?: string;

  /**
   * Name of the Streaming Policy used by this Streaming Locator.
   */
  @visibility("read")
  streamingPolicyName?: string;

  /**
   * Name of the default ContentKeyPolicy used by this Streaming Locator.
   */
  @visibility("read")
  defaultContentKeyPolicyName?: string;
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
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Base type for concrete track types. A derived type must be used to represent the Track.
 */
@discriminator("@odata.type")
model TrackBase {}

/**
 * The properties of the Content Key Policy.
 */
model ContentKeyPolicyProperties {
  /**
   * The legacy Policy ID.
   */
  @visibility("read")
  policyId?: string;

  /**
   * The creation date of the Policy
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The last modified date of the Policy
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * A description for the Policy.
   */
  description?: string;

  /**
   * The Key Policy options.
   */
  options: ContentKeyPolicyOption[];
}

/**
 * Represents a policy option.
 */
model ContentKeyPolicyOption {
  /**
   * The legacy Policy Option ID.
   */
  @visibility("read")
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
model ContentKeyPolicyConfiguration {}

/**
 * Base class for Content Key Policy restrictions. A derived class must be used to create a restriction.
 */
@discriminator("@odata.type")
model ContentKeyPolicyRestriction {}

/**
 * A Transform.
 */
model TransformProperties {
  /**
   * The UTC date and time when the Transform was created, in 'YYYY-MM-DDThh:mm:ssZ' format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * An optional verbose description of the Transform.
   */
  description?: string;

  /**
   * The UTC date and time when the Transform was last updated, in 'YYYY-MM-DDThh:mm:ssZ' format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * An array of one or more TransformOutputs that the Transform should generate.
   */
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
model Preset {}

/**
 * Properties of the Job.
 */
model JobProperties {
  /**
   * The UTC date and time when the customer has created the Job, in 'YYYY-MM-DDThh:mm:ssZ' format.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The current state of the job.
   */
  @visibility("read")
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
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * The outputs for the Job.
   */
  outputs: JobOutput[];

  /**
   * Priority with which the job should be processed. Higher priority jobs are processed before lower priority jobs. If not set, the default is normal.
   */
  priority?: Priority;

  /**
   * Customer provided key, value pairs that will be returned in Job and JobOutput state events.
   */
  correlationData?: Record<string>;

  /**
   * The UTC date and time at which this Job began processing.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The UTC date and time at which this Job finished processing.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;
}

/**
 * Base class for inputs to a Job.
 */
@discriminator("@odata.type")
model JobInput {}

/**
 * Describes all the properties of a JobOutput.
 */
@discriminator("@odata.type")
model JobOutput {
  /**
   * If the JobOutput is in the Error state, it contains the details of the error.
   */
  @visibility("read")
  error?: JobError;

  /**
   * A preset used to override the preset in the corresponding transform output.
   */
  presetOverride?: Preset;

  /**
   * Describes the state of the JobOutput.
   */
  @visibility("read")
  state?: JobState;

  /**
   * If the JobOutput is in a Processing state, this contains the Job completion percentage. The value is an estimate and not intended to be used to predict Job completion times. To determine if the JobOutput is complete, use the State property.
   */
  @visibility("read")
  progress?: int32;

  /**
   * A label that is assigned to a JobOutput in order to help uniquely identify it. This is useful when your Transform has more than one TransformOutput, whereby your Job has more than one JobOutput. In such cases, when you submit the Job, you will add two or more JobOutputs, in the same order as TransformOutputs in the Transform. Subsequently, when you retrieve the Job, either through events or on a GET request, you can use the label to easily identify the JobOutput. If a label is not provided, a default value of '{presetName}_{outputIndex}' will be used, where the preset name is the name of the preset in the corresponding TransformOutput and the output index is the relative index of the this JobOutput within the Job. Note that this index is the same as the relative index of the corresponding TransformOutput within its Transform.
   */
  label?: string;

  /**
   * The UTC date and time at which this Job Output began processing.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The UTC date and time at which this Job Output finished processing.
   */
  @visibility("read")
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
  @visibility("read")
  code?: JobErrorCode;

  /**
   * A human-readable language-dependent representation of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * Helps with categorization of errors.
   */
  @visibility("read")
  category?: JobErrorCategory;

  /**
   * Indicates that it may be possible to retry the Job. If retry is unsuccessful, please contact Azure support via Azure Portal.
   */
  @visibility("read")
  retry?: JobRetry;

  /**
   * An array of details about specific errors that led to this reported error.
   */
  @visibility("read")
  details?: JobErrorDetail[];
}

/**
 * Details of JobOutput errors.
 */
model JobErrorDetail {
  /**
   * Code describing the error detail.
   */
  @visibility("read")
  code?: string;

  /**
   * A human-readable representation of the error.
   */
  @visibility("read")
  message?: string;
}

/**
 * Class to specify properties of Streaming Policy
 */
model StreamingPolicyProperties {
  /**
   * Creation time of Streaming Policy
   */
  @visibility("read")
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
 * Properties of the Streaming Locator.
 */
model StreamingLocatorProperties {
  /**
   * Asset Name
   */
  assetName: string;

  /**
   * The creation time of the Streaming Locator.
   */
  @visibility("read")
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
  id: string;

  /**
   * Encryption type of Content Key
   */
  @visibility("read")
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
  @visibility("read")
  policyName?: string;

  /**
   * Tracks which use this Content Key
   */
  @visibility("read")
  tracks?: TrackSelection[];
}

/**
 * Class of response for listContentKeys action
 */
@pagedResult
model ListContentKeysResponse {
  /**
   * ContentKeys used by current Streaming Locator
   */
  @items
  contentKeys?: StreamingLocatorContentKey[];
}

/**
 * Class of response for listPaths action
 */
model ListPathsResponse {
  /**
   * Streaming Paths supported by current Streaming Locator
   */
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
  transcriptions?: LiveEventTranscription[];

  /**
   * The provisioning state of the live event.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The resource state of the live event. See https://go.microsoft.com/fwlink/?linkid=2139012 for more information.
   */
  @visibility("read")
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
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The last modified time of the live event.
   */
  @visibility("read")
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
  keyFrameIntervalDuration?: duration;

  /**
   * A UUID in string form to uniquely identify the stream. This can be specified at creation time but cannot be updated. If omitted, the service will generate a unique value.
   */
  accessToken?: string;

  /**
   * The input endpoints for the live event.
   */
  endpoints?: LiveEventEndpoint[];
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
 * Live event preview settings.
 */
model LiveEventPreview {
  /**
   * The endpoints for preview. Do not share the preview URL with the live event audience.
   */
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
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The time the live output was last modified.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModified?: utcDateTime;

  /**
   * The provisioning state of the live output.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The resource state of the live output.
   */
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
  provisioningState?: string;

  /**
   * The resource state of the streaming endpoint.
   */
  @visibility("read")
  resourceState?: StreamingEndpointResourceState;

  /**
   * The streaming endpoint access policies.
   */
  crossSiteAccessPolicies?: CrossSiteAccessPolicies;

  /**
   * The free trial expiration time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  freeTrialEndTime?: utcDateTime;

  /**
   * The exact time the streaming endpoint was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  created?: utcDateTime;

  /**
   * The exact time the streaming endpoint was last modified.
   */
  @visibility("read")
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
  @visibility("read")
  name?: string;

  /**
   * The streaming endpoint sku capacity.
   */
  capacity?: int32;
}

model StreamingEndpointSkuInfoListResult {
  /**
   * The result of the List StreamingEndpoint skus.
   */
  value?: ArmStreamingEndpointSkuInfo[];
}

model ArmStreamingEndpointSkuInfo {
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
model ContentKeyPolicyPlayReadyContentKeyLocation {}

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
model ContentKeyPolicyRestrictionTokenKey {}

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
  alternateVerificationKeys?: ContentKeyPolicyRestrictionTokenKey[];

  /**
   * A list of required token claims.
   */
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
model TrackDescriptor {}

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
   * The list of TrackDescriptors which define the metadata and selection of tracks in the input.
   */
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
  experimentalOptions?: Record<string>;
}

/**
 * Base type for all overlays - image, audio or video.
 */
@discriminator("@odata.type")
model Overlay {
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
  overlays?: Overlay[];
}

/**
 * Describes the settings to be used when encoding the input video into a desired output bitrate layer.
 */
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
  layers?: PngLayer[];

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.PngImage";
}

/**
 * Describes the settings to produce a PNG image from the input video.
 */
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
  experimentalOptions?: Record<string>;

  /**
   * One or more filtering operations that are applied to the input media before encoding.
   */
  filters?: Filters;

  /**
   * The list of codecs to be used when encoding the input video.
   */
  codecs: Codec[];

  /**
   * The list of outputs to be produced by the encoder.
   */
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
  inputDefinitions?: InputDefinition[];
}

/**
 * Base class for specifying a clip time. Use sub classes of this class to specify the time position in the media.
 */
@discriminator("@odata.type")
model ClipTime {}

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
  inputs?: JobInputClip[];

  /**
   * The discriminator for derived types.
   */
  `@odata.type`: "#Microsoft.Media.JobInputSequence";
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
