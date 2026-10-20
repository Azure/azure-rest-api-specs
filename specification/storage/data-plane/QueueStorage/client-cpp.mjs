// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

import { $alternateType } from "@azure-tools/typespec-client-generator-core";

export const $decorators = {
  Customizations: {
    alternateCppParameterType(context, operation, name, type) {
      const parameter = operation.parameters.properties.get(name);
      if (!parameter) {
        context.program.reportDiagnostic({
          code: "queue-cpp-parameter-not-found",
          severity: "error",
          message: `Operation ${operation.name} has no parameter ${name}.`,
          target: context.decoratorTarget,
        });
        return;
      }
      $alternateType(context, parameter, type, "cpp");
    },
  },
};
