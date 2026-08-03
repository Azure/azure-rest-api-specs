/*
  Definitions of elements defined for Batch processor.
*/

using TypeSpec.Versioning;

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
  @renamedFrom(Microsoft.Monitor.Versions.v2025_03_01_preview, "timeout")
  @removed(Microsoft.Monitor.Versions.v2025_03_01_preview)
  timeoutv20241001preview?: int32 = 200;

  @doc("Timeout in milliseconds.")
  @minValue(10)
  @maxValue(300000)
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  timeout?: int32 = 200;
}
