import { inspect } from "util";
import { mapAsync } from "./array.ts";
import { embedError } from "./spec-model.ts";
import { Swagger } from "./swagger.ts";

export type ErrorJSON = import("./spec-model.ts").ErrorJSON;

export type Readme = import("./readme.ts").Readme;

export type SwaggerJSON = import("./swagger.ts").SwaggerJSON;

export type ToJSONOptions = import("./spec-model.ts").ToJSONOptions;

export interface TagJSON {
  name: string;
  inputFiles: (SwaggerJSON | ErrorJSON)[];
}

export class Tag {
  #inputFiles: Map<string, Swagger>;

  #logger: import("./logger.ts").ILogger | undefined;

  #name: string;

  /**
   * Readme that contains this Tag
   */
  #readme: Readme | undefined;

  constructor(
    name: string,
    inputFilePaths: string[],
    options: { logger?: import("./logger.ts").ILogger; readme?: Readme } = {},
  ) {
    const { logger, readme } = options;

    this.#name = name;
    this.#logger = logger;
    this.#readme = readme;

    this.#inputFiles = new Map(
      inputFilePaths.map((p) => {
        const swagger = new Swagger(p, { logger: this.#logger, tag: this });
        return [swagger.path, swagger];
      }),
    );
  }

  get inputFiles(): Map<string, Swagger> {
    return this.#inputFiles;
  }

  get name(): string {
    return this.#name;
  }

  /**
   * @returns Readme that contains this Tag
   */
  get readme(): Readme | undefined {
    return this.#readme;
  }

  async toJSONAsync(options: ToJSONOptions = {}): Promise<TagJSON | ErrorJSON> {
    return await embedError(
      async () => ({
        name: this.#name,
        inputFiles: await mapAsync(
          [...this.#inputFiles.values()].sort((a, b) => a.path.localeCompare(b.path)),
          async (s) => await s.toJSONAsync(options),
        ),
      }),
      options,
    );
  }

  toString() {
    return `Tag(${this.#name}, {logger: ${inspect(this.#logger)}})`;
  }
}
