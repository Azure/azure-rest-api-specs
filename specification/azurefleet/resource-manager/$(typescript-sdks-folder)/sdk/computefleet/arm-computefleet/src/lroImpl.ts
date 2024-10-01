// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

import { AbortSignalLike } from "@azure/abort-controller";
import { LongRunningOperation, LroResponse } from "@azure/core-lro";

export function createLroSpec<T>(inputs: {
  sendOperationFn: (args: any, spec: any) => Promise<LroResponse<T>>;
  args: Record<string, unknown>;
  spec: {
    readonly requestBody?: unknown;
    readonly path?: string;
    readonly httpMethod: string;
  } & Record<string, any>;
}): LongRunningOperation<T> {
  const { args, spec, sendOperationFn } = inputs;
  return {
    requestMethod: spec.httpMethod,
    requestPath: spec.path!,
    sendInitialRequest: () => sendOperationFn(args, spec),
    sendPollRequest: (
      path: string,
      options?: { abortSignal?: AbortSignalLike },
    ) => {
      const { requestBody, ...restSpec } = spec;
      return sendOperationFn(args, {
        ...restSpec,
        httpMethod: "GET",
        path,
        abortSignal: options?.abortSignal,
      });
    },
  };
}
