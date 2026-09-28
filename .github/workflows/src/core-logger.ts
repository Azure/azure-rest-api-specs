import type { Core } from "./github.ts";
export type ILogger = import("../../shared/src/logger.ts").ILogger;

export class CoreLogger implements ILogger {
  #core: Core;

  constructor(core: Core) {
    this.#core = core;
  }

  debug(message: string) {
    this.#core.debug(message);
  }

  error(message: string) {
    this.#core.error(message);
  }

  info(message: string) {
    this.#core.info(message);
  }

  isDebug(): boolean {
    return this.#core.isDebug();
  }

  warning(message: string) {
    this.#core.warning(message);
  }
}
