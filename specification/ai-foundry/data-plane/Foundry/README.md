# Foundry data-plane TypeSpec

This folder contains the TypeSpec for all data-plane REST APIs of the Foundry service.

## Microsoft 365 unpublish permissions

`POST /agents/{agent_name}/microsoft365/unpublish` requires permission to unpublish the
agent in its Foundry project. Authorization to the Foundry agent and authorization
to remove the Microsoft 365 title are separate checks. In delegated-user cleanup
flows, the caller must also be authorized to remove that title; agent write access
alone does not allow a different user to remove a title owned by its publisher.
Automation must use a service-supported application-identity cleanup flow rather
than assume that permission to publish also grants permission to unpublish.

## Contributing

### Adding preview features

Make sure that all preview features (routes and TypeSpec models) that are not associated with the `/openai` routes are marked with
both the `@added` decorator for the target preview version, and the `@removed`
decorator for the GA `v1` version. If you don't add the `@removed` decorator, your preview
features will incorrectly appear in the GA `v1` swagger in
(file `..\data-plane\Azure.AI.Projects\stable\v1\azure-ai-projects.json`).

For example:

```txt
@removed(Versions.v1)
model MyNewPreviewModel {
...
}
```

The models.tsp files associated with OpenAI routes `openai/responses`, `"openai/conversations` and `openai/evals` should not have
these decorators. The interfaces using those will have the appropriate decorators.

### Compiling and sending a PR

Before you send a PR for changes in this folder, do the following:

Change to folder

```cmd
cd specification\ai\Azure.AI.Projects
```

Make sure you have latest tools by running:

```cmd
npm ci
```

Create an empty folder named "examples", if one does not already exist

```cmd
mkdir examples
```

Compile, validate and re-format by running:

```cmd
npx tsv .
```

Fix any errors you see. This command may also update the format
of some files to make sure all files use a common format.

The above will also automatically create or edit swagger (OpenAPI) files in the
`..\data-plane\Azure.AI.Projects` folder. Review the changes there to make
sure they make sense to you. Then add them to your PR.

The `npx tsv .` has a console spew that shows the diff between current and staged
changes. Once you `git add` all the changed files and run `npx tsv .` again, there should
no longer be any diffs to show.

## Emitting Python code

Please do not emit SDKs in the public Python repo. SDK originated from TypeSpec that is private should not be pushed into a branch in a public GitHub repo.

If you want to emit Python SDK from latest TypeSpec in this folder do the following:

- In repo `azure-sdk-for-python-pr`, create a topic branch off branch `feature/azure-ai-projects/2.0.0b1`. This means you get the changes to emitter tool files that define additional dependency on a package that contains new TypeSpec decorators. You will also get all the added hand-written code (in `_patch.py` files).
- cd `sdk\ai\azure-ai-projects`
- Emit using
  - `tsp-client update --local-spec-repo <path>` where "path" is your local path to the private TypeSpec project folder, or
  - `tsp-client update` to use the TypeSpec commit mentioned in the local tsp-location.yaml file
- After the code was emitted, run the script `post-emitter-fixes.cmd`
- To review your changes, send a PR for merging your topic branch into branch `feature/azure-ai-projects/2.0.0b1`
