export class SpecModelError extends Error {
  /**
   * Path to file that caused the error
   */
  #source: string | undefined;

  /**
   * Path to readme that caused the error (if known)
   */
  #readme: string | undefined;

  /**
   * Name of tag that caused the error (if known)
   */
  #tag: string | undefined;

  constructor(
    message: string,
    options: { cause?: Error; source?: string; readme?: string; tag?: string } = {},
  ) {
    const { cause, source, readme, tag } = options;

    const fullMessage =
      message +
      (source ? `\n  Problem File: ${source}` : "") +
      (readme ? `\n  Readme: ${readme}` : "") +
      (tag ? `\n  Tag: ${tag}` : "") +
      (cause ? `\n  Cause: ${cause}` : "");

    super(fullMessage, { cause });

    this.name = this.constructor.name;

    this.#source = source;
    this.#readme = readme;
    this.#tag = tag;
  }

  get source() {
    return this.#source;
  }

  get readme() {
    return this.#readme;
  }

  get tag() {
    return this.#tag;
  }
}
