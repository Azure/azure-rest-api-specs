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
shadowed members, overridden serialization attributes, referenced model types,
generic wrappers, serializer registration, and version dispatch. A C# `new`
member without an inherited read-only attribute can make the same JSON field
writable only in newer versions. Verify which member the serializer actually
uses for each version; do not assume base-class attributes apply unchanged.
For a new endpoint, trace registration to its request/response
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

Distinguish private-preview availability from the requested publication scope.
A feature can be accessible to registered callers in an earlier management API
version and published generally in a later one. Obtain the author's intended
public version set rather than copying every backend version gate into
`apiVersions`.

Trace defaults and validation through operation helpers and tests, not just
model initializers. Check omitted, explicit null, empty collections, duplicate
items, and PATCH merge behavior separately. A default selected from a rule type
or applied only in a particular state belongs in `description`, not an
unconditional `default`. Record confirmed array constraints such as `minItems`
and `uniqueItems`; describe cross-property allowed-value rules in prose.

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
- Treat a new-version visibility change on the same JSON name as a property
  modification. Keep old-version behavior intact; internal helper declaration
  names used to preserve old versions are not additional wire properties.
- Map each backend field to every affected public create-request,
  update-request, and response declaration. Check the baseline for separate
  models, inherited properties, and spreads; do not assume one backend model
  maps to one public model or redeclare a property already inherited correctly.
  Check visibility, requiredness, and nullability independently in each context.
- Include complete definitions for newly referenced public models and enums.
- Capture enum extensions as `modify` with complete before/after values.
  A CLR enum does not by itself establish whether the public enum is extensible.
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

## Reference cases

These are sanitized reasoning cases motivated by public PRs
[#45965](https://github.com/Azure/azure-rest-api-specs/pull/45965),
[#45825](https://github.com/Azure/azure-rest-api-specs/pull/45825), and
[#46118](https://github.com/Azure/azure-rest-api-specs/pull/46118). Names and
contracts below are synthetic, not a reproduction of private source. The cases
are manual extraction/review references; schema checks do not test whether an
agent investigates correctly or asks a blocking question.

### Same wire property, new-version visibility

Suppose an older version exposes `ExampleRuleProperties.metrics` as read-only.
A new version selects a derived backend model whose shadowed `metrics` member
is writable. The author confirms that only `2027-02-01` gains write access;
the old version and JSON name remain unchanged.

Expected result: one property `modify`, with the same wire name/type and the
old/new visibility states. Do not add a second property or change the older
version. If omission selects all metrics supported by the rule type, describe
that condition rather than inventing one fixed default list. See the
[versioned visibility manifest](../examples/versioned-visibility.yaml).

### One backend feature, several public model targets

Suppose a shared backend `placement` field is reachable from account creation,
PATCH, and GET. The public project has separate create-parameter,
update-parameter, and returned-resource models. The author confirms publication
in `2027-02-01`, despite registered preview callers using an earlier version.

Expected result: cover all three public targets, plus any new shared model and
extensible enum. An omitted PATCH property can preserve state while explicit
null clears it; that does not imply the create or response property is nullable.
Record a state-dependent numeric default in the shared model's description.
See the [multi-model manifest](../examples/multi-model-property.yaml).

### Blocking disagreement: do not produce YAML

Assume branch selection and source comparison are complete, but the available
records disagree:

| Record                              | Synthetic contract                                                           |
| ----------------------------------- | ---------------------------------------------------------------------------- |
| Pinned backend model and validation | `placement.mode` is required and accepts `Automatic`.                        |
| Backend PATCH test                  | Explicit `placement: null` clears the feature.                               |
| Historical public spec and example  | `mode` is optional with `On`/`Off` values; `mode: Off` disables the feature. |

Expected result: ask the author to establish the intended wire values,
requiredness, and disable/clear behavior for the target public versions.
Investigate any relevant translation layer; the records may describe different
snapshots or an intentional translation rather than equivalent contracts.
Do not assume the merged public example wins, copy the backend enum blindly,
combine the incompatible alternatives, or silently omit the disputed feature.

Until those decisions are resolved, **do not write a manifest**, including an
empty or partial one. This is an expected clarification outcome, not a failed
schema check or a new manifest status. After clarification, resume extraction
using the author's decisions and the pinned public baseline.

## Reference APIs

- [Get pull request](https://learn.microsoft.com/rest/api/azure/devops/git/pull-requests/get-pull-request?view=azure-devops-rest-7.1)
- [Get PR iterations](https://learn.microsoft.com/rest/api/azure/devops/git/pull-request-iterations/list?view=azure-devops-rest-7.1)
- [Get iteration changes](https://learn.microsoft.com/rest/api/azure/devops/git/pull-request-iteration-changes/get?view=azure-devops-rest-7.1)
- [Get an item at a version](https://learn.microsoft.com/rest/api/azure/devops/git/items/get?view=azure-devops-rest-7.1)
