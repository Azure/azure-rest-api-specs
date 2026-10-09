# Azure TypeSpec assessment eval

`assessment.eval.yaml` contains four routing checks and one hermetic capability
check:

- two prompts that must invoke `azure-typespec-assessment`;
- one authoring prompt that must invoke `azure-typespec-author`;
- one SDK generation prompt that must invoke
  `azsdk-common-generate-sdk-locally`;
- one no-changes assessment that invokes the production coordinator against a
  temporary Git repository and verifies its command, files, structured status,
  workflow state, and response.

The eval intentionally contains no assessment replay data, benchmark fixtures,
or custom eval scripts.

From `.github\skills`, run:

```powershell
vally lint azure-typespec-assessment --strict
vally eval -e azure-typespec-assessment\evals\assessment.eval.yaml `
  --skill-dir . --workers 1 --max-retries 0 `
  --output jsonl --output-dir <output-directory>
```
