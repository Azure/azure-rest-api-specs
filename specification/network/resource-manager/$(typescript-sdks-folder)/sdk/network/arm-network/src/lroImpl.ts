import { LongRunningOperation, LroResponse } from "@azure/core-lro";

export class LroImpl<T> implements LongRunningOperation<T> {
  constructor(
    private sendOperationFn: (args: any, spec: any) => Promise<LroResponse<T>>,
    private args: Record<string, unknown>,
    private spec: {
      readonly requestBody?: unknown;
      readonly path?: string;
      readonly httpMethod: string;
    } & Record<string, any>,
    public requestPath: string = spec.path!,
    public requestMethod: string = spec.httpMethod
  ) {}
  public async sendInitialRequest(): Promise<LroResponse<T>> {
    return this.sendOperationFn(this.args, this.spec);
  }
  public async sendPollRequest(path: string): Promise<LroResponse<T>> {
    const { requestBody, ...restSpec } = this.spec;
    return this.sendOperationFn(this.args, {
      ...restSpec,
      path,
      httpMethod: "GET"
    });
  }
}
