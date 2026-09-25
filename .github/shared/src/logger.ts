export interface ILogger {
  debug: (message: string) => void;
  error: (message: string) => void;
  info: (message: string) => void;
  warning: (message: string) => void;
  isDebug: () => boolean;
}

export class ConsoleLogger implements ILogger {
  #isDebug: boolean;

  /**
   * @param isDebug - If true, debug logs will be printed.  Default: false.
   */
  constructor(isDebug: boolean = false) {
    this.#isDebug = isDebug;
  }

  debug(message: string) {
    if (this.isDebug()) {
      console.debug(message);
    }
  }

  error(message: string) {
    console.error(message);
  }

  info(message: string) {
    console.log(message);
  }

  isDebug(): boolean {
    return this.#isDebug;
  }

  warning(message: string) {
    console.warn(message);
  }
}

// Singleton loggers
export const defaultLogger = new ConsoleLogger();
export const debugLogger = new ConsoleLogger(/*isDebug*/ true);
