/*
 * Vendored from: specification/ai/Azure.AI.Projects/.external-readonly/openai.external.typespec/specialized-types/models.tsp
 * Original commit: 81687c58ac963af5c35cbfcf87c09481109723ec
 */

using TypeSpec.OpenAPI;

namespace OpenAI;

/** A filter used to compare a specified attribute key to a given value using a defined comparison operation. */
model ComparisonFilter {
  @doc("""
    Specifies the comparison operator:
    `eq` (equal), `ne` (not equal), `gt` (greater than), `gte` (greater than or equal), `lt` (less than), `lte` (less than or equal).
    """)
  type: "eq" | "ne" | "gt" | "gte" | "lt" | "lte" = "eq";

  /** The key to compare against the value. */
  key: string;

  /** The value to compare against the attribute key; supports string, number, or boolean types. */
  value: string | float32 | boolean;
}

@doc("""
  Combine multiple filters using `and` or `or`.
  """)
model CompoundFilter {
  @doc("""
    Type of operation: `and` or `or`.
    """)
  type: "and" | "or";

  @doc("""
    Array of filters to combine. Items can be `ComparisonFilter` or `CompoundFilter`.
    """)
  filters: (ComparisonFilter | CompoundFilter)[];
}

// Tool customization: Replace with more detailed representation
/**
 * Set of 16 key-value pairs that can be attached to an object. This can be
 * useful for storing additional information about the object in a structured
 * format, and querying for objects via API or the dashboard. Keys are strings
 * with a maximum length of 64 characters. Values are strings with a maximum
 * length of 512 characters, booleans, or numbers.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
@extension("x-oaiTypeLabel", "map")
model VectorStoreFileAttributes is Record<string | boolean | int32 | float32>;
