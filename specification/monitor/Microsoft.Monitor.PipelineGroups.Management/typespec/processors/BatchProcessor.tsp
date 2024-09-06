/*
  Definitions of elements defined for Batch processor.
*/

namespace Microsoft.Monitor;

@doc("Batch processor.")
model BatchProcessor {
  @doc("Size of the batch.")
  @minValue(10)
  @maxValue(100000)
  batchSize?: int32 = 8192;

  @doc("Timeout in milliseconds.")
  @minValue(10)
  @maxValue(60000)
  timeout?: int32 = 200;
}
