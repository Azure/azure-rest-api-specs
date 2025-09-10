// Map Legends interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

using TypeSpec.Http;

/**
 * Interval legends element used to define a color map
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" ""
union IntervalLegendsElement {
  Interval,
  Record<string>,
}

/**
 * Interval legend response model.
 *
 * Represents a color map for intervals, where each interval is defined by:
 * - A numeric range `[min, max]` representing the interval boundaries.
 * - An RGBA color `[red, green, blue, alpha]` associated with the interval.
 *
 * The response is a 2D array of interval definitions, where each element is a pair:
 * - The first element is an array of two numbers `[min, max]` defining the interval.
 * - The second element is an array of four numbers `[red, green, blue, alpha]` defining the RGBA color.
 *
 * Example:
 * ```json
 * [
 *   [
 *     [-2, 0], [0, 0, 0, 0]
 *   ],
 *   [
 *     [1, 32], [255, 255, 178, 255]
 *   ]
 * ]
 * ```
 * This example defines two intervals:
 * - The interval `[-2, 0]` is mapped to the color `[0, 0, 0, 0]` (transparent black).
 * - The interval `[1, 32]` is mapped to the color `[255, 255, 178, 255]` (opaque yellow).
 */
model IntervalLegendsResponse {
  /**
   * status code
   */
  @statusCode statusCode: 200;

  /**
   * content type
   */
  @header contentType: "application/json";

  /**
   * body
   */
  @body
  body: IntervalLegendsElement[][];
}

/**
 * Interval type alias.
 */
alias Interval = int64[];
