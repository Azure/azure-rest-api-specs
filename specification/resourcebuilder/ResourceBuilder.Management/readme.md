## Build Process

Run the build script to generate Swagger:

```powershell
# From repo root
.\specification\resourcebuilder\ResourceBuilder.Management\build.ps1

# Or from ResourceBuilder.Management
cd .\specification\resourcebuilder\ResourceBuilder.Management
.\build.ps1
```

## Helpful tips

typescript installation guide: https://www.typescripttutorial.net/typescript-tutorial/setup-typescript/

- Helpful: global installs sometimes go to `C:\ProgramData\global-npm` (add to path if `tsp --version` fails)
- Remember to close and re-open VS Code or command line to pick up changes in the ENVIRONMENT VARIABLES

Failed installations

```
main.tsp:1:1 - error import-not-found: Couldn't resolve import "@typespec/http"
> 1 | import "@typespec/http";
    | ^^^^^^^^^^^^^^^^^^^^^^^^
```

- `npm i -D @typespec/compiler` - installs @typespec/compiler and all its dependencies.
- `npm ls` - lists the typespec libraries that are already installed.
