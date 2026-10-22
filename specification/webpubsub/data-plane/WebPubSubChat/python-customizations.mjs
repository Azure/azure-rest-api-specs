import { $alternateType } from "@azure-tools/typespec-client-generator-core";

/**
 * @param {import("@typespec/compiler").DecoratorContext} context
 * @param {import("@typespec/compiler").Operation} operation
 * @param {import("@typespec/compiler").Model} input
 * @param {string} [scope="python"]
 */
function requestModel(context, operation, input, scope = "python") {
  // Resolve the instantiated body; template-expanded parameters cannot be referenced with ::parameters.resource.
  const resource = operation.parameters.properties.get("resource");
  if (!resource) {
    context.program.reportDiagnostic({
      code: "webpubsub-chat/missing-resource-parameter",
      severity: "error",
      message: `Operation ${operation.name} has no resource parameter.`,
      target: context.decoratorTarget,
    });
    return;
  }
  context.call($alternateType, resource, input, scope);
}

export const $decorators = {
  "WebPubSubChat.PythonCustomizations": { requestModel },
};
