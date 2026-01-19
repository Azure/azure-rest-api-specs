namespace Microsoft.PlanetaryComputer;

/**
 * CQL Filter model
 */
model CqlFilter {
  /**
   * Logical operator
   */
  `op`: string;

  /**
   * Arguments for the logical operator
   */
  args: CqlArgument[];
}

/**
 * Union type for CQL arguments
 *
 * Represents an argument in CQL2 expressions, as defined in the OGC API - Features - Part 3 standard.
 *
 * - **CqlProperty**: A reference to a STAC item property.
 * - **CqlValue**: A literal value (e.g., text, number, boolean, or arrays of these) used in expressions.
 * - **CqlFilter**: A logical filter combining multiple conditions with operators like "AND" or "OR".
 *
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "Unions cannot be emitted to OpenAPI v2 unless all options are literals of the same type."
union CqlArgument {
  CqlProperty,
  CqlValue,
  CqlFilter,
}

/**
 * Model for CQL property
 */
model CqlProperty {
  /**
   * Property name
   */
  property: string;
}

/**
 * Represents a value used in CQL expressions. This value can be one of the following:
 *
 * - A single text string (e.g., "example").
 * - A 32-bit integer number (e.g., 42).
 * - A floating-point number with double precision (e.g., 3.14159).
 * - A boolean value, either true or false.
 * - An array of text strings (e.g., ["example1", "example2"]).
 * - An array of 32-bit integer numbers (e.g., [1, 2, 3]).
 * - An array of floating-point numbers with double precision (e.g., [1.1, 2.2, 3.3]).
 * - An array of boolean values (e.g., [true, false, true]).
 *
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "Unions cannot be emitted to OpenAPI v2 unless all options are literals of the same type."
union CqlValue {
  string,
  int32,
  float64,
  boolean,
  string[],
  int32[],
  float64[],
  boolean[],
}

/**
 * SortBy model
 */
model SortBy {
  /**
   * Field to sort by
   */
  field: string;

  /**
   * Sort direction
   */
  direction: string;
}

/**
 * CQL model
 */
model Cql {
  /**
   * Filter language
   */
  @encodedName("application/json", "filter-lang")
  filterLang: string;

  /**
   * Filter
   */
  filter: CqlFilter;

  /**
   * Sort by
   */
  @encodedName("application/json", "sortby")
  sortBy?: SortBy[];
}
