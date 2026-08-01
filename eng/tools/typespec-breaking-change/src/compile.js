import { compile, NodeHost } from "@typespec/compiler";
import { fileURLToPath } from "url";
import { dirname, resolve } from "path";
/** Resolve the path to this package's lib/main.tsp for auto-injection. */
function getLibraryPath() {
    const thisFile = fileURLToPath(import.meta.url);
    return resolve(dirname(thisFile), "..", "lib", "main.tsp");
}
/**
 * Compile a TypeSpec entry point and return the Program.
 * Wraps the compiler's `compile()` with sensible defaults for analysis (no emit).
 * Automatically injects the breaking-change library so @approvedBreakingChange
 * is available without specs needing to explicitly depend on this package.
 *
 * @param mainFile - Path to the TypeSpec entry point (e.g., "main.tsp")
 * @param options - Compilation options
 * @returns The compiled Program
 * @throws If the program has errors (diagnostics with severity "error")
 */
export async function compileService(mainFile, options = {}) {
    const host = options.host ?? NodeHost;
    const program = await compile(host, mainFile, {
        noEmit: options.noEmit ?? true,
        additionalImports: [getLibraryPath()],
    });
    return program;
}
//# sourceMappingURL=compile.js.map