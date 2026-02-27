@doc("Information regarding the processor of the server")
model Processor {
  @doc("The processor name")
  processorName?: string;

  @doc("The processor manufacturer")
  manufacturer?: string;

  @doc("The processor model")
  `model`?: string;

  @doc("The processor version")
  version?: string;

  @doc("The microcode information")
  microCodeInfo?: string;

  @doc("The max clock speed")
  maxSpeedMhz?: int64;

  @doc("The operating clock speed")
  operatingSpeedMhz?: int64;

  @doc("The number of cores")
  totalCores?: int64;

  @doc("The total number of enabled cores")
  totalEnabledCores?: int64;

  @doc("The total threads of the processor")
  totalThreads?: int64;

  @doc("The turbo state of the processor")
  turboState?: string;
}
