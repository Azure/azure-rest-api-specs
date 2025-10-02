// @ts-check

export class SpecModelError extends Error {
  /**
   * Path to file that caused the error
   *
   * @type {string|undefined}
   */
  source;

  /**
   * Path to readme that caused the error (if known)
   * @type {string|undefined}
   */
  readme;

  /**
   * Name of tag that caused the error (if known)
   * @type {string|undefined}
   */
  tag;

  /**
   * @param {string} message
   * @param {Object} [options]
   * @param {Error} [options.cause]
   * @param {string} [options.source] Path to file that caused the error
   * @param {string} [options.readme] Path to readme that caused the error (if known)
   * @param {string} [options.tag] Name of tag that caused the error (if known)
   */
  constructor(message, options) {
    super(message, { cause: options?.cause });

    this.name = this.constructor.name;

    this.source = options?.source;
    this.readme = options?.readme;
    this.tag = options?.tag;
  }

  // TODO: Move all this code into the ctor, when setting the super message, since
  // downstream tools prefer error.message to error.toString().  Even if long, best to
  // put all info (except callstacks) in message (with newlines as needed).
  toString() {
    return (
      `SpecModelError: ${this.message}` +
      `${this.source ? `\n\tProblem File: ${this.source}` : ""}` +
      `${this.readme ? `\n\tReadme: ${this.readme}` : ""}` +
      `${this.tag ? `\n\tTag: ${this.tag}` : ""}` +
      `${this.cause ? `\n\tCause: ${this.cause}` : ""}`
    );
  }
}
