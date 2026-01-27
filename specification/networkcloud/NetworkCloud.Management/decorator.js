import { setTypeSpecNamespace } from "@typespec/compiler";

const requestedAudiences = process.env.AUDIENCE
  ? process.env.AUDIENCE.split(",").map((a) => a.trim())
  : [];

// Store the audience targets and filter based on AUDIENCE environment variable.
export function $audience(context, target, ...audienceTargets) {
  const program = context.program ?? context;
  program.stateMap("audience").set(target, audienceTargets);

  // Check if any requested audience matches the target audiences
  const hasMatchingAudience = audienceTargets.some((audience) =>
    requestedAudiences.includes(audience)
  );

  if (hasMatchingAudience) return; // keep the target if audience matches

  // Remove the target if no matching audience found
  if (target.kind === "ModelProperty") {
    // Guard against missing model (defensive in case of malformed targets)
    target.model?.properties?.delete(target.name);
  } else if (target.kind === "Model") {
    // Remove model from its namespace and scrub references
    target.namespace?.models?.delete(target.name);
    for (const model of program.checker.getGlobalNamespaceType().models.values()) {
      for (const prop of model.properties.values()) {
        if (prop.type === target) {
          model.properties.delete(prop.name);
        }
      }
    }
  } else if (target.kind === "Union") {
    // Remove union from its namespace
    target.namespace?.unions?.delete(target.name);
  } else if (target.kind === "Operation") {
    // Remove operation from its interface or namespace
    if (target.interface) {
      target.interface.operations?.delete(target.name);
    } else if (target.namespace) {
      target.namespace.operations?.delete(target.name);
    }
  }
};

setTypeSpecNamespace("Microsoft.NetworkCloud", $audience);