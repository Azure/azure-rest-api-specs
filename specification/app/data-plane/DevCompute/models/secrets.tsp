using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

/**
 * Represents a validated secret identifier.
 * Must be 3-64 characters, containing only ASCII letters (upper/lower), digits, and hyphens.
 */
scalar SecretId;

model SecretKeysResponse {
  keys: string[];
}

model SecretListResponse {
  secrets: SecretResponseView[];
}

model SecretPeekResponse {
  @secret
  values: Record<string>;
}

model SecretResponseView {
  id: SecretId;
  createdAt?: utcDateTime;
  updatedAt?: utcDateTime;
}

model SecretUpsertRequest {
  @secret
  values: Record<string>;
}
