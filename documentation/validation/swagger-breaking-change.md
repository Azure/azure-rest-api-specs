# Table of Contents
- [AutoRest Exceptions](#autorest-exceptions)

# AutoRest Exceptions
If `Swagger BreakingChange` fails with `AutoRest threw a runtime error`, the root cause is likely a problem in your spec causing AutoRest to crash. Complete the Node.js and pnpm setup in [Contributing](../contributing/toolchain-setup.md), then debug with all commands run from the repository root:

1. Determine if the problem is "before" or "after" your PR (or both)
   1. Checkout the target branch of your PR (likely `main` or `RPSaaSMaster`)
   2. `pnpm ci`
   3. Run `@azure/oad` against the copy of your spec in the target branch.  Specify the same path twice, which should always pass unless AutoRest crashes.
    ```sh
    $ pnpm oad compare \
        specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json \
        specification/contosowidgetmanager/resource-manager/Microsoft.Contoso/stable/2021-11-01/contoso.json
    ```
   4. If your spec is valid, this should return `"code":"NoVersionChange"`, since you are comparing the spec to itself.  If your spec is invalid, this will fail with `AutoRest threw a runtime error`, and the stack trace should include `path` properties pointing to the error.  For instance, here's a failure caused by example with a disallowed property:

    ```
    code: 'OBJECT-ADDITIONAL-PROPERTIES'
    params: [ [Array] ]
    message: 'Additional properties not allowed: headers'
    path: '#/paths/~1executions/post/x-ms-examples/CodeExecution-Execute-Async-Running'
    ```

   5. If `pnpm oad compare` passed on the copy of your spec in the target branch, repeat these steps on the copy of your spec in the source branch.
2. If the problem is "before" your PR, open another PR dedicated to fixing just this problem.  BreakingChanges may fail in this fixup PR, but should pass going forward.
3. If the problem is "after" your PR, just fix the problem in your PR.
