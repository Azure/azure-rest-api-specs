import "./main.tsp";

/**
 * A base type has the following characteristics
 * 1. A name (taken from the array of known base types)
 * 2. A version
 * 3. A set of properties that are required to be supported and have a defined type, optionality, and visibility
 * 4. A set of properties that are required to be supported and have a defined type, optionality, and user-selected visibility
 * 4. A set of properties that are optional but must have a particular type and optionality and visibility, if supported
 * 5. A set of properties that are optional but must have a particular type and optionality, if supported
 *
 * The current implementation is to have:
 * - model templates with required properties
 * - mixins for optional properties (with visibility if optional)
 * - a decorator that applies required rules (type structure, child resources, operations)
 */
using Azure.ResourceManager;

namespace Azure.ResourceManager.BaseTypes;

union BaseTypeValues {
  /** An Agent BaseType */
  Agent: "agent",

  string,
}

// need a decorator that identifies and populates the base types
/** Base type definition */
@discriminator("baseType")
model BaseTypeInfo {
  /** The base type */
  baseType: BaseTypeValues;

  /** The version */
  version: string;
}
