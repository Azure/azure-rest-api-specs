import { compile, NodeHost } from "@typespec/compiler";
/**
 * Compile a TypeSpec entry point and return the Program.
 * Wraps the compiler's `compile()` with sensible defaults for analysis (no emit).
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
    });
    return program;
}
//# sourceMappingURL=compile.js.map