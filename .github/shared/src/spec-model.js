// @ts-check
import $RefParser from "@apidevtools/json-schema-ref-parser";
import { readFile, readdir } from "fs/promises";
import yaml from "js-yaml";
import { marked } from "marked";
import { dirname, join, relative, resolve } from "path";
import { fileURLToPath } from "url";
import { mapAsync } from "./array.js";
import { example, readme } from "./changed-files.js";
import { ConsoleLogger } from "./logger.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

/**
 * @typedef {Object} SpecModel
 * @prop {string} repoRoot
 * @prop {Object<string, Readme>} readmes
 */

/**
 * @typedef {Object} Readme
 * @prop {string} path
 * @prop {Object} globalConfig
 * @prop {Object<string, Swagger[]>} tags
 */

/**
 * @typedef {Object} Swagger
 * @prop {string} path
 * @prop {Object<string, string[]>} refs
 */

/**
 * @param {string} folder
 * @param {Object} [options]
 * @param {import('./logger.js').ILogger} [options.logger]
 * @param {string} [options.repoRoot]
 * @param {boolean} [options.debug]
 * @returns {Promise<SpecModel>} All input files for all tags
 */
export async function getSpecModel(folder, options = {}) {
  const debug = options.debug || false;
  const logger = options.logger || new ConsoleLogger(debug);
  const repoRoot = options.repoRoot || resolve(__dirname, "..", "..", "..");

  logger.debug(`getSpecModel: ${folder}, options: ${JSON.stringify(options)}`);

  const files = await readdir(join(repoRoot, folder), {
    recursive: true,
  });
  const readmes = files.filter(readme);
  logger.debug(`Found ${readmes.length} readme files`);

  return {
    repoRoot,
    readmes: Object.fromEntries(
      await mapAsync(readmes, async (r) => {
        const readmePath = join(folder, r);
        return [readmePath, await getReadme(readmePath, repoRoot, logger)];
      }),
    ),
  };
}

/**
 * @param {string} readmePath
 * @param {string} repoRoot
 * @param {import('./logger.js').ILogger} [logger]
 * @returns {Promise<Readme>}
 */
async function getReadme(readmePath, repoRoot, logger) {
  const content = await readFile(join(repoRoot, readmePath), {
    encoding: "utf8",
  });

  logger?.debug(`getReadme: ${readmePath}`);

  const tokens = marked.lexer(content);

  /** @type import("marked").Tokens.Code[] */
  const yamlBlocks = tokens
    .filter((token) => token.type === "code")
    .map((token) => /** @type import("marked").Tokens.Code */ (token))
    // Include default block and tagged blocks (```yaml $(tag) == 'package-2021-11-01')
    .filter((token) => token.lang?.toLowerCase().startsWith("yaml"));

  const globalConfigYamlBlocks = yamlBlocks.filter(
    (token) => token.lang === "yaml",
  );

  const globalConfig = globalConfigYamlBlocks.reduce(
    (obj, token) => Object.assign(obj, yaml.load(token.text)),
    {},
  );

  /** @type {Object<string, Swagger[]>} */
  const tags = {};
  for (const block of yamlBlocks) {
    const tagName =
      block.lang?.match(/yaml.*\$\(tag\) ?== ?'([^']*)'/)?.[1] || "default";

    if (tagName === "default" || tagName === "all-api-versions") {
      // Skip yaml blocks where this is no tag or tag is all-api-versions
      continue;
    }

    const obj = /** @type {any} */ (yaml.load(block.text));

    if (!obj) {
      logger?.debug(`No yaml object found for tag ${tagName} in ${readmePath}`);
      continue;
    }

    if (!obj["input-file"]) {
      // The yaml block does not contain an input-file key
      continue;
    }

    // This heuristic assumes that a previous definition of the tag with no
    // swaggers means that the previous definition did not have an input-file
    // key. It's possible that the previous defintion had an `input-file: []`
    // or something like it.
    if (tags[tagName]?.length > 0) {
      // The tag already exists and has a swagger file. This is an error as
      // there should only be one definition of input-files per tag.
      const message = `Multiple input-file definitions for tag ${tagName} in ${readmePath}`;
      logger?.error(message);
      throw new Error(message);
    }

    /** @type Swagger[] */
    const swaggers = [];

    // It's possible for input-file to be a string or an array
    const inputFiles = Array.isArray(obj["input-file"])
      ? obj["input-file"]
      : [obj["input-file"]];
    for (const swaggerPath of inputFiles) {
      const swagger = await getSwagger(
        swaggerPath,
        dirname(readmePath),
        repoRoot,
        logger,
      );
      swaggers.push(swagger);
    }

    tags[tagName] = swaggers;
  }

  const readme = {
    path: readmePath,
    globalConfig,
    tags,
  };

  return readme;
}

/**
 * @param {string} swaggerPath
 * @param {string} readmeFolder
 * @param {string} repoRoot
 * @param {import('./logger.js').ILogger} [logger]
 * @returns {Promise<Swagger>}
 */
async function getSwagger(swaggerPath, readmeFolder, repoRoot, logger) {
  logger?.debug(`getSwagger: ${swaggerPath}, ${readmeFolder}, ${repoRoot}`);

  let normalizedSwaggerPath = swaggerPath;
  // Ignore uses of "$(this-folder)" in the swagger path. It refers to the
  // current folder anyway and can be substituted with "."
  if (swaggerPath.includes("$(this-folder)")) {
    normalizedSwaggerPath = swaggerPath.replaceAll("$(this-folder)", ".");
  }

  // Some swagger paths contain backslashes. These should be normalized when
  // encountered though the expected format for input-files is forward slashes.
  if (normalizedSwaggerPath.includes("\\")) {
    logger?.info(
      `Found backslash (\\) in swagger path ${swaggerPath}. Replacing with forward slash (/)`,
    );
    normalizedSwaggerPath = normalizedSwaggerPath.replaceAll("\\", "/");
  }
  const fullPath = resolve(repoRoot, readmeFolder, normalizedSwaggerPath);
  const content = await readFile(fullPath, { encoding: "utf8" });

  return {
    path: join(readmeFolder, normalizedSwaggerPath),
    refs: await getExternalFileRefs(
      normalizedSwaggerPath,
      readmeFolder,
      repoRoot,
    ),
  };
}

/**
 * Reads all levels of external file references in a swagger file and returns a
 * map where the key is the referenced swagger file and the value is a set of
 * all references that the file depends on, including transitive dependencies.
 * @param {string} swaggerPath,
 * @param {string} readmePath
 * @param {string} repoRoot
 * @returns {Promise<Object<string, string[]>>}
 */
async function getExternalFileRefs(swaggerPath, readmePath, repoRoot) {
  const initialSwagger = join(readmePath, swaggerPath);
  const visited = new Set();
  const toVisit = new Set([initialSwagger]);

  /** @type {Object<string, Set<string>>} */
  const externalFileRefs = {};

  while (toVisit.size > 0) {
    const currentSwagger = /** @type {string} */ (
      toVisit.values().next().value
    );

    toVisit.delete(currentSwagger);
    visited.add(currentSwagger);

    const currentSchema = await $RefParser.resolve(
      resolve(repoRoot, currentSwagger),
      { resolve: { http: false } },
    );
    const currentRefs = currentSchema
      .paths("file")
      .map((p) => relative(repoRoot, p))
      .filter((p) => !visited.has(p) && !example(p));

    // Add the ref to the dependency map for the current path
    if (currentSwagger !== initialSwagger) {
      if (!externalFileRefs[currentSwagger]) {
        externalFileRefs[currentSwagger] = new Set();
      }
    }

    for (const ref of currentRefs) {
      if (currentSwagger !== initialSwagger) {
        externalFileRefs[currentSwagger].add(ref);
      }

      if (!visited.has(ref)) {
        toVisit.add(ref);
      }
    }
  }

  return Object.fromEntries(
    Object.entries(externalFileRefs).map((e) => [e[0], Array.from(e[1])]),
  );
}

/**
 * Given a swagger file, return the readme files and tags that reference that
 * swagger file.
 * @param {string} swaggerFile
 * @param {SpecModel} specModel
 * @returns {Object<string, string[]>}
 */
export function getAffectedReadmeTags(swaggerFile, specModel) {
  /** @type Object<string, Set<string>> */
  const affectedReadmes = {};

  for (const [readmePath, readme] of Object.entries(specModel.readmes)) {
    for (const [tag, swaggers] of Object.entries(readme.tags)) {
      for (const swagger of swaggers) {
        if (swagger.path === swaggerFile) {
          if (!affectedReadmes[readmePath]) {
            affectedReadmes[readmePath] = new Set();
          }
          affectedReadmes[readmePath].add(tag);
          // No need to check refs if the swagger file is directly referenced
          continue;
        }

        // Because refs contains the full set of transitive dependencies, only
        // check if the swagger file is in the map keys.
        if (swagger.refs[swaggerFile]) {
          if (!affectedReadmes[readmePath]) {
            affectedReadmes[readmePath] = new Set();
          }
          affectedReadmes[readmePath].add(tag);
        }
      }
    }
  }
  return Object.fromEntries(
    Object.entries(affectedReadmes).map((e) => [e[0], Array.from(e[1])]),
  );
}

/**
 * Given a swagger file, return the swagger files that are affected by the
 * changes in the given swagger file.
 * @param {string} swaggerFile
 * @param {SpecModel} specModel
 * @returns {string[]}
 */
export function getAffectedSwaggers(swaggerFile, specModel) {
  const affectedSwaggers = new Set();
  for (const [, readme] of Object.entries(specModel.readmes)) {
    for (const [, swaggers] of Object.entries(readme.tags)) {
      for (const swagger of swaggers) {
        // The readme.md file directly references the given swaggerFile
        if (swagger.path === swaggerFile) {
          affectedSwaggers.add(swaggerFile);
        }

        // Some swagger file has a ref to the given swaggerFile.
        if (swagger.refs[swaggerFile]) {
          affectedSwaggers.add(swagger.path);
          affectedSwaggers.add(swaggerFile);
        }

        // Check the swagger file's refs and add any which depend on the given
        // swaggerFile.
        // For example "->" means "depends on", given:
        // Tag 1 directly references a with a relationship of:
        // a -> b -> c
        // If c is changed, then a and b are affected, but since b is not
        // directly referenced in the readme, it can only be discovered by
        // evaluating a's dependencies.
        for (const [ref, dependsOn] of Object.entries(swagger.refs)) {
          if (dependsOn.includes(swaggerFile)) {
            affectedSwaggers.add(ref);
            affectedSwaggers.add(swaggerFile);
          }
        }
      }
    }
  }

  // The swagger file supplied does not exist in the given specModel
  if (affectedSwaggers.size === 0) {
    throw new Error(
      `No affected swaggers found in specModel for ${swaggerFile}`,
    );
  }

  return Array.from(affectedSwaggers);
}
