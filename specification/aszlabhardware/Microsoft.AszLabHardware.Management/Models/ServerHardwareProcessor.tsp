@doc("Information about the processor")
model ServerHardwareProcessor {
  @doc("The manufacturer of the processor")
  manufacturer?: string;

  @doc("The model of the processor")
  `model`?: string;

  @doc("The number of cores")
  cores?: int32;

  @doc("The number of threads")
  threads?: int32;

  @doc("Whether processor has dedicated IGPU")
  integratedGraphics?: boolean;
}
