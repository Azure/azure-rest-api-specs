import { $alternateType, $scope } from "@azure-tools/typespec-client-generator-core";

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

/**
 * @param {import("@typespec/compiler").DecoratorContext} context
 * @param {import("@typespec/compiler").Operation} operation
 */
function omitContinuationToken(context, operation) {
  // Resolve template-expanded parameters, which cannot be referenced with ::parameters.
  const token = operation.parameters.properties.get("continuationToken");
  if (!token) {
    context.program.reportDiagnostic({
      code: "webpubsub-chat/missing-continuation-token-parameter",
      severity: "error",
      message: `Operation ${operation.name} has no continuationToken parameter.`,
      target: context.decoratorTarget,
    });
    return;
  }
  context.call($scope, token, "!python");
}

export const $decorators = {
  "WebPubSubChat.PythonCustomizations": { requestModel, omitContinuationToken },
};
