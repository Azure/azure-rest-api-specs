# Run SDK generation using pipeline in GitHub coding agent

Run only SDK generation using pipeline and do not run SDK generation using local SDK generation tools. This is applicable only when GitHub copilot coding agent is used to generate SDK and if a Release Plan is available in the context. Run SDK generation tool even if release plan already has SDK generation pipeline URL to support regenerating SDK. Coding agent must wait until all SDK generation pipeline are in completed status and then fetch the SDK details from pipeline run. This is applicable only when a GitHub issue is assigned to GitHub coding agent to generate SDK from a TypeSpec project. This is not applicable when running Copilot from Visual Studio and VS Code.

## Additional instructions:

- Run SDK generation pipeline for the given TypeSpec path for all languages mentioned in the description.
- Identify absolute path of TypeSpec project root path and send it to Run SDK generation MCP tool call.
- Keep checking the pipeline status every 10 minutes until pipeline is in completed or failed status.
- Find SDK pull request links from the pipeline run.
- Do not mark as language as excluded in the release plan just because SDK generation pipeline failed for that language. Inform user about the failure and suggest to check pipeline logs for more information.
- Do not run verify setup, TypeSpec validation, service label check and analyze pipeline tools when running SDK generation using GitHub coding agent.

## Constraints:

- Do not invoke other steps.
- Do not modify main.tsp file or any files in TypeSpec project.
- Do not add API version to an existing main.tsp if input API version is not present.
