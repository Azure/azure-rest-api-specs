import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.HealthcareInterop;

@doc("Settings used to customize how HL7 messages are read.")
model Hl7Configuration {
  @doc("Optional string representing the carriage return character used in the HL7/MLLP implementation.")
  @maxLength(4)
  carriageReturn?: string;

  @doc("Optional boolean indicating if the carriage return is optional in the HL7/MLLP implementation.")
  carriageReturnOptional?: boolean;

  @doc("Optional string representing the end block delimiter used in the HL7/MLLP implementation.")
  @maxLength(4)
  endBlockDelimiter?: string;

  @doc("Optional enum representing how HL7 message error acknowledgments are sent back to the caller")
  errorAckStrategy?: ErrorAckStrategy;

  @doc("Optional boolean indicating if no start byte is required in the HL7/MLLP implementation.")
  noStartByteRequired?: boolean;

  @doc("Optional string representing the start block delimiter used in the HL7/MLLP implementation.")
  @maxLength(4)
  startBlockDelimiter?: string;
}

@doc("Settings used to customize the newtwork listener configuration.")
model MessageListenerConfiguration {
  @doc("Optional duration in seconds to wait before an inactive connection is closed. Not used if useTransientConnection is true.")
  @minValue(10)
  inactivityTimeoutInSeconds?: int32;

  @doc("Optional size of the message buffer used when reading HL7 messages from an MLLP connection.")
  @minValue(512)
  messageBufferSize?: int32;

  @doc("The port number that will be exposed to receive HL7 messages.")
  @minValue(1)
  @maxValue(65535)
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  port: int32;

  @doc("Optional setting that will close the connection between each HL7 message received.")
  useTransientConnection?: boolean;
}

@doc("The strategy for how HL7 message error acknowledgments are sent back to the caller.")
union ErrorAckStrategy {
  string,

  /** The error acknowledgment strategy is to send a negative acknowledgment (NACK) message */
  SendNackOnError: "SendNackOnError",

  /** The error acknowledgment strategy is to never send a negative acknowledgment (NACK) message */
  NeverSendNack: "NeverSendNack",
}
