import { inspect } from "util";

/**
 * @param {string} path
 * @returns {boolean}
 */
export function isTypeSpecPath(path) {
  return path.endsWith(".tsp") || path.endsWith("tspconfig.yaml");
}

/**
 * @param {import('@actions/github-script').AsyncFunctionArguments} AsyncFunctionArguments
 */
export default async function typespecRequirement({ github, context, core }) {
  await Promise.resolve();
  core.info(inspect(github));
  core.info(inspect(context));
}
