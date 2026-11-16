import { resolve } from "pathe";

export function getFormatScope(folder: string) {
  return {
    patterns: [resolve(folder, "../**/*.tsp"), resolve(folder, "tspconfig.yaml")],
    exclude: [resolve(folder, "../**/node_modules")],
  };
}
