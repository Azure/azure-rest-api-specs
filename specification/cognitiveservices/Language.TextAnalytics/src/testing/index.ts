import { resolvePath } from "@cadl-lang/compiler";
import { CadlTestLibrary } from "@cadl-lang/compiler/testing";
import { fileURLToPath } from "url";

export const AzureLanguageTestLibrary: CadlTestLibrary = {
  name: "@azure-tools/cadl-azure-language",
  packageRoot: resolvePath(fileURLToPath(import.meta.url), "../../../../"),
  files: [
    {
      realDir: "",
      pattern: "package.json",
      virtualPath: "./node_modules/@azure-tools/cadl-azure-language",
    },
    {
      realDir: "dist/src",
      pattern: "*.js",
      virtualPath: "./node_modules/@azure-tools/cadl-azure-language/dist/src",
    },
    {
      realDir: "lib",
      pattern: "*.cadl",
      virtualPath: "./node_modules/@azure-tools/cadl-azure-language/lib",
    },
  ],
};
