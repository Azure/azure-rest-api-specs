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

  @doc("Processor's dedicated IGPU capabilities")
  integratedGraphics?: IntegratedGraphics;
}

@doc("Integrated Graphics capability of the processor")
union IntegratedGraphics {
  @doc("Processor has integrated graphics")
  IntegratedGraphics: "IntegratedGraphics",

  @doc("Processor does not have integrated graphics")
  None: "None",

  string,
}
