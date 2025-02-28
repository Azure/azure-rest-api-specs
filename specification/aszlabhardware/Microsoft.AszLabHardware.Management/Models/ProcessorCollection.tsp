import "./Processor.tsp";

using OpenAPI;

@doc("Information regarding the processors of the server")
model ProcessorCollection {
  @doc("Processor count total")
  processorCount: int32;

  @doc("Logical core count")
  logicalProcessorCount: int32;

  @doc("The processors of the server")
  @extension("x-ms-identifiers", ["processorName"])
  processors: Processor[];
}
