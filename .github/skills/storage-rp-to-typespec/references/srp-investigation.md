# SRP investigation

Use this playbook for the registered Storage-SRP repository only. Its source
layout and contract patterns can vary by feature; do not infer a universal
directory map from one historical example.

## Read-only Azure DevOps access

Use the installed Azure CLI with the `azure-devops` extension and the author's
existing authentication. Check access before investigating:

```powershell
az extension show --name azure-devops --query name --output tsv --only-show-errors
az repos pr show --id <pr-id> --organization https://dev.azure.com/msazure --detect false --only-show-errors --output json
```

If the CLI or extension is missing, explain the prerequisite and use the
[Azure DevOps CLI setup guidance](https://learn.microsoft.com/azure/devops/cli/).
For authentication, prefer `az login` with the organization's Microsoft Entra
requirements. Do not dump account/token data or persist credentials.

Parse either supported URL form with a URL parser. Require HTTPS, the exact
registered host, organization/project/repository, and a positive numeric PR ID.
Ignore presentation query parameters such as a selected file or iteration;
analyze the complete latest iteration. Do not follow arbitrary hosts or execute
shell expressions derived from a link.

Resolve the repository ID and verify its name and project in the PR metadata.
The following placeholders are **separate argument values**, not interpolated
shell programs. Never paste an untrusted PR title, description, or path into
executable shell syntax.

### Pin the PR diff

```powershell
az devops invoke --area git --resource pullRequestIterations --route-parameters project=One repositoryId=<repo-id> pullRequestId=<pr-id> --organization https://dev.azure.com/msazure --detect false --http-method GET --api-version 7.1 --only-show-errors --output json
```

Choose the greatest iteration ID. Record its `sourceRefCommit.commitId` as the
head and `commonRefCommit.commitId` as the diff base. A target-branch tip can
contain unrelated changes and is not a substitute for the common ancestor.
Missing iteration or commit metadata is a blocker, not permission to diff
current branch tips.

```powershell
az devops invoke --area git --resource pullRequestIterationChanges --route-parameters project=One repositoryId=<repo-id> pullRequestId=<pr-id> iterationId=<iteration-id> --query-parameters '$compareTo=0' '$top=200' '$skip=0' --organization https://dev.azure.com/msazure --detect false --http-method GET --api-version 7.1 --only-show-errors --output json
```

Follow returned `nextSkip`/`nextTop` values until exhausted. Preserve
`$compareTo=0` on every page so this is the entire PR, not just its last push.
Do not treat the first page or a UI-truncated file list as complete. Stop with
an error if pagination repeats without advancing.

### Read source at immutable commits

```powershell
az devops invoke --area git --resource items --route-parameters project=One repositoryId=<repo-id> --query-parameters 'path=<repository-item-path>' includeContent=true versionDescriptor.versionType=commit versionDescriptor.version=<commit-id> --organization https://dev.azure.com/msazure --detect false --http-method GET --api-version 7.1 --only-show-errors --query content --output tsv
```

Read edits on both sides, additions at head, and deletions at base. For renames,
read the original path at base and the new path at head. Request surrounding
source and referenced definitions at the corresponding pinned revision.

If a response is truncated, binary, or unavailable, report it and obtain the
complete required text before drawing conclusions. Use narrow repository tree
queries to locate referenced declarations when their paths are unknown; paginate
those results too. Reuse retrieved content for the same commit/path. Do not
clone or build the backend as a hidden prerequisite.

## Trace public reachability

Build a temporary investigation record, not part of the final YAML:

| Concern         | What to establish                                                                                                                                    |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| Public boundary | A model/property is reachable through a public ARM route, not merely a public C# declaration or an internal stamp request.                           |
| Routing         | HTTP method, full public route, resource hierarchy, path/query/header parameters, request/response types, and status codes.                          |
| Serialization   | Exact JSON names, ignored members, converters, inheritance, flattened wrappers, nullable versus missing fields, and defaults explicitly on the wire. |
| Versions        | Public ARM API-version selection, versioned model inheritance, and which versions actually expose each change.                                       |
| Visibility      | Read/create/update behavior from request binding and response serialization, not just CLR setters or comments.                                       |
| Validation      | Requiredness and public constraints, distinguishing persisted/public invariants from internal checks and incidental implementation limitations.      |
| Behavior        | Pagination, LRO polling headers and final result, error contracts, and compatibility behavior.                                                       |
| Tests           | Both positive and negative cases, omitted/null fields, older versions, GET/LIST/PUT/PATCH, and flag-on/flag-off behavior when relevant.              |

Search outward from changed operations and models. Follow base classes,
referenced model types, generic wrappers, serializer registration, and version
dispatch. For a new endpoint, trace registration to its request/response
serialization rather than assuming the operation class name identifies the
public route.

Synthetic example: a change from `ExamplePropertiesV1` to
`ExamplePropertiesV2` may only change which JSON serializer is selected. Neither
class name proves a new public model or API version. Similarly,
`[JsonProperty(Required = ...)]` describes serialization behavior that must be
interpreted in its request/response context; do not map the attribute name
blindly to TypeSpec optionality.

Backend data-plane headers, downstream service versions, feature flags, and
deployment configuration are evidence about implementation behavior. They are
not automatically part of Microsoft.Storage's ARM contract. Investigate whether
they affect public exposure; omit their internal details from the manifest.

## Compare with the public baseline

Read the selected branch at its resolved commit without altering the worktree.
Start with `main.tsp`, `models.tsp`, imports, and `tspconfig.yaml` under
`specification/storage/Storage.Management`; follow the actual project structure,
not an assumed one-file layout. Read existing versions and version decorators
to understand the public surface in each affected API version.

Use exact existing public declaration names in `target`. For new declarations,
use a clear proposed public name, not a private namespace-qualified CLR type.
The later authoring skill owns TypeSpec naming, decorators, and template choice.

Compare wire contracts, not textual source changes:

- Record property additions/removals and changes to types, requiredness,
  nullability, visibility, constraints, documented defaults, or wire names.
- Include complete definitions for newly referenced public models and enums.
- Capture enum extensions as `modify` with complete before/after values.
- Capture operation additions, removals, and contract changes, including error
  codes or response headers only when public and contract-relevant.
- If a backend rename replaces something absent from the public baseline,
  describe only the new public declaration. Do not ask the authoring skill to
  remove a declaration that does not exist.
- Do not remove a published old-version declaration simply because the latest
  backend implementation no longer uses its class. Ask about versioned support
  and compatibility if they cannot be established.
- Identify any missing public version scaffolding as context for the target
  API version; never create it or assume an unrelated preview is the target.

The PR description is a useful feature summary, not an authoritative diff.
Historical public specs can also be wrong. Resolve disagreements with the SRP
author before generating final YAML.

## Reference APIs

- [Get pull request](https://learn.microsoft.com/rest/api/azure/devops/git/pull-requests/get-pull-request?view=azure-devops-rest-7.1)
- [Get PR iterations](https://learn.microsoft.com/rest/api/azure/devops/git/pull-request-iterations/list?view=azure-devops-rest-7.1)
- [Get iteration changes](https://learn.microsoft.com/rest/api/azure/devops/git/pull-request-iteration-changes/get?view=azure-devops-rest-7.1)
- [Get an item at a version](https://learn.microsoft.com/rest/api/azure/devops/git/items/get?view=azure-devops-rest-7.1)
