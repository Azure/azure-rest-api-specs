namespace Microsoft.Foundry.Core;

/** A Unix timestamp (seconds since epoch) used throughout Foundry wire contracts. */
@encode(DateTimeKnownEncoding.unixTimestamp, int32)
scalar FoundryTimestamp extends utcDateTime;

/** A duration encoded as an integer number of seconds. */
@encode(DurationKnownEncoding.seconds, int32)
scalar FoundryDurationSeconds extends duration;

/** A duration encoded as an integer number of milliseconds. */
#suppress "@azure-tools/typespec-azure-core/known-encoding" "Foundry wire contracts encode duration values as integer milliseconds."
@encode(DurationKnownEncoding.milliseconds, int32)
scalar FoundryDurationMilliseconds extends duration;
