import { $alternateType, $scope } from "@azure-tools/typespec-client-generator-core";

/**
 * @param {import("@typespec/compiler").DecoratorContext} context
 * @param {import("@typespec/compiler").Operation} operation
 * @param {import("@typespec/compiler").Model} input
 * @param {string} scope
 */
function requestModel(context, operation, input, scope) {
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
 * @param {string} scope
 */
function omitContinuationToken(context, operation, scope) {
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
  context.call($scope, token, scope);
}

export const $decorators = {
  ClientCustomizations: { requestModel, omitContinuationToken },
};
