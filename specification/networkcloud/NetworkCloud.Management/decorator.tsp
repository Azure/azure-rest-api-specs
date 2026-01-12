import "@typespec/compiler";
import "./decorator.js";

using Reflection;

namespace Microsoft.NetworkCloud;

/**
 * Applies audience-based filtering to a model, model property or operation. The target remains in the
 * generated program only when at least one requested audience matches the comma-delimited AUDIENCE
 * environment variable. If AUDIENCE is unset, no audiences are considered valid and the annotated
 * items are removed.
 *
 * Usage examples:
 *   @audience("internal")
 *   model InternalModel { ... }
 *
 *   @audience("internal", "external")
 *   model InternalOrExternalModel { ... }
 *
 * Environment variable settings:
 *   AUDIENCE=internal
 *   AUDIENCE=internal,external
 */
extern dec audience(
  target: Union | Model | ModelProperty | Operation,
  ...audienceTargets: valueof string[]
);
