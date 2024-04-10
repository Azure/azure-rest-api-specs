import "../common/CommonModels.tsp";

namespace Microsoft.MobileNetwork;

@doc("The status of the packet capture session.")
enum PacketCaptureStatus {
  @doc("Packet capture is not started.")
  NotStarted,

  @doc("Packet capture is in-progress.")
  Running,

  @doc("Packet capture has been stopped.")
  Stopped,

  @doc("Error on packet capture.")
  Error,
}

@doc("Packet capture session properties.")
model PacketCapturePropertiesFormat {
  @doc("The provisioning state of the packet capture session resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The status of the packet capture session.")
  @visibility("read")
  status?: PacketCaptureStatus;

  @doc("The reason the current packet capture session state.")
  @visibility("read")
  reason?: string;

  @doc("The start time of the packet capture session.")
  @visibility("read")
  captureStartTime?: utcDateTime;

  @doc("List of network interfaces to capture on.")
  @minItems(1)
  networkInterfaces?: string[];

  @doc("Number of bytes captured per packet, the remaining bytes are truncated. The default \"0\" means the entire packet is captured.")
  @minValue(0)
  @maxValue(4294967295)
  bytesToCapturePerPacket?: int64 = 0;

  @doc("Maximum size of the capture output.")
  @maxValue(4294967295)
  @minValue(1000)
  totalBytesPerSession?: int64 = 67108864;

  @doc("Maximum duration of the capture session in seconds.")
  @maxValue(18000)
  @minValue(5)
  timeLimitInSeconds?: int32 = 18000;

  @doc("The list of output files of a packet capture session.")
  @visibility("read")
  outputFiles?: string[];
}
