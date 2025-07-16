// Cleaned TypeSpec file aligned with Python model definitions
// Removed models not defined or needed based on your Python code baseline

import "./custom.tsp";

using TypeSpec.OpenAPI;

namespace VoiceLive;

model Error {
  code: string | null;
  message: string;
  param: string | null;
  type: string;
}

@error
model ErrorResponse {
  error: Error;
}

model MetadataPropertyForRequest {
  @extension("x-oaiTypeLabel", "map")
  metadata?: Record<string>;
}

model MetadataPropertyForResponse {
  @extension("x-oaiTypeLabel", "map")
  metadata: Record<string> | null;
}

union VoiceIdsShared {
  string,
  "alloy",
  "ash",
  "ballad",
  "coral",
  "echo",
  "sage",
  "shimmer",
  "verse",
}

union ServiceTier {
  "auto",
  "default",
  "flex",
  "scale",
  "priority",
}
