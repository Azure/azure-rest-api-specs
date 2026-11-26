// Keep helpers outside the service namespace to avoid emitting unused schemas in older APIs.
namespace Microsoft.CognitiveServicesConstraints;

/** Connection name constraint used before the September 2026 preview. */
@pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
scalar LegacyConnectionName extends string;

/** Connection name containing 3 to 128 alphanumeric, underscore, or hyphen characters, starting with an alphanumeric character. */
@pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,127}$")
@minLength(3)
@maxLength(128)
scalar ConnectionName extends string;
