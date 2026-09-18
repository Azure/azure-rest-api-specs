# Foundry Route Documentation Rules

Detailed definitions for each documentation rule applied to TypeSpec route operations
in the AI Foundry data-plane (Foundry) area.

> **Conservative Change Policy:** Only fix operations with explicit, significant rule
> violations. Do not rewrite text that is already substantially correct. If a doc comment
> or summary merely uses slightly different wording but satisfies all rules, leave it alone.

---

## FDOC-001 — Operation Documentation Comment

**Requirement:** Every operation in an `interface` block must have a TSDoc block
comment (`/** ... */`) immediately preceding its decorators. Prefer TSDoc comments over
`@doc("...")` decorators — if an operation currently uses `@doc()`, convert it to a
TSDoc comment.

**Why:** Documentation comments flow into the generated OpenAPI `description` field and
are consumed by SDK generators, API reference docs, and developer portals. Missing
descriptions produce empty documentation in all downstream artifacts. TSDoc comments
are the idiomatic TypeSpec documentation style and are easier to read inline.

### ✅ Good

```typespec
/** Creates an agent with the specified configuration. */
@post
@route("/agents")
createAgent is FoundryDataPlaneOperation<...>;
```

```typespec
@doc("Creates an agent with the specified configuration.")
@post
@route("/agents")
createAgent is FoundryDataPlaneOperation<...>;
```

### ❌ Bad

```typespec
@post
@route("/agents")
createAgent is FoundryDataPlaneOperation<...>;
```

### Remediation

Add a `/** ... */` comment block directly above the first decorator of the operation.
Use **third-person indicative** voice (see FDOC-003). If an existing `@doc("...")`
decorator is present, convert it to a `/** ... */` TSDoc comment instead.

---

## FDOC-002 — @summary Decorator

**Requirement:** Every operation must have a `@summary("...")` decorator.

**Why:** The `@summary` decorator populates the OpenAPI `summary` field, which is
displayed as the operation title in API portals, SDK method documentation, and tooling.
Unlike `description`, `summary` should be a short, human-scannable label.

### ✅ Good

```typespec
@summary("Create an agent")
/** Creates an agent with the specified configuration. */
@post
@route("/agents")
createAgent is FoundryDataPlaneOperation<...>;
```

### ❌ Bad — missing @summary

```typespec
/** Creates an agent with the specified configuration. */
@post
@route("/agents")
createAgent is FoundryDataPlaneOperation<...>;
```

### Remediation

Add `@summary("Concise imperative phrase")` above the operation. The summary must:

- Use **imperative (vocative) voice**: "Create an agent", "List connections", "Delete a dataset"
- Not use third-person: ~~"Creates an agent"~~, ~~"Lists connections"~~
- Not exceed ~60 characters
- Not duplicate the full `@doc` / TSDoc description verbatim
- **Not be truncated** — the text must form a complete, grammatically valid phrase.
  Truncated summaries (ending mid-word or mid-sentence, e.g. `"Create a fine-tuning job which begins the process of creating a new"`)
  are a violation. If the intended summary exceeds ~60 characters, shorten it to a complete
  phrase rather than cutting it off (e.g. `"Create a fine-tuning job"`).

---

## FDOC-003 — Documentation Voice and Content

**Requirement:** The TSDoc comment must use **third-person indicative** voice and must
provide meaningful additional detail relative to the `@summary`. The description should
not be near-identical to the summary — it should expand on it with specifics such as
what the operation returns, what identifiers it uses, side effects, or other relevant
context. Slightly vary word choice so the description doesn't read as a near-copy of
the summary (e.g. if the summary says "Get", the description might say "Retrieves";
if the summary says "Delete", the description might say "Removes" or "Permanently deletes").

**Voice pattern:** "Creates …", "Retrieves …", "Deletes …", "Lists …", "Updates …"

### ✅ Good

```typespec
// Summary: "Get a response" — description adds detail and varies wording
@summary("Get a response")
/** Retrieves a model response by its unique identifier. */

// Summary: "List connections" — description adds scope detail
@summary("List connections")
/** Returns the available connections configured in the current project. */

// Summary: "Create an agent" — description explains what happens
@summary("Create an agent")
/** Creates a new agent with the specified configuration and returns the created resource. */
```

### ❌ Bad — near-identical to summary

```typespec
// Summary and description say essentially the same thing
@summary("Create an agent")
/** Creates an agent. */

@summary("Delete a session")
/** Deletes a session. */
```

### ❌ Bad — imperative voice in doc comment

```typespec
/** Create an agent with the specified configuration. */

/** List all connections in the project. */
```

### ❌ Bad — empty or placeholder

```typespec
/** */

@doc("")

@doc("TODO")
```

### Remediation

Rewrite the first word to third-person indicative form:

| Imperative (wrong for doc) | Third-person indicative (correct for doc) |
| -------------------------- | ----------------------------------------- |
| Create                     | Creates                                   |
| Get / Retrieve             | Gets / Retrieves                          |
| List                       | Lists                                     |
| Delete / Remove            | Deletes / Removes                         |
| Update                     | Updates                                   |
| Start / Begin              | Starts / Begins                           |
| Cancel / Stop              | Cancels / Stops                           |
| Upload                     | Uploads                                   |

---

## FDOC-004 — @summary Voice and Conciseness

**Requirement:** The `@summary()` value must be a maximally concise, single-line phrase
in **imperative (vocative) voice**. It is a terse label, not a sentence.

Summaries must follow all of these constraints:
- **No trailing period.** Summaries are phrases, not sentences: `"Create an agent"`,
  not `"Create an agent."`.
- **Omit filler words** like "all" in "List all X" — just "List X" is sufficient.
- **Omit indirect phrasing** like "Get info about X" or "Retrieve details of X" —
  just "Get an X" is sufficient. The verb already implies retrieval of the resource.
- **Omit qualifiers** like "by ID" or "by name" unless needed to disambiguate from
  another operation on the same resource (e.g. two different get operations).
- **Always include articles** for grammatical completeness — "Create a response",
  not "Create response"; "Get an agent", not "Get agent".
- **Never truncate** — the text must be a complete, self-contained phrase.
- **Use a single-line string literal** — do not use multiline triple-quoted
  summaries. If the source summary is a paragraph, move the detail into the
  TSDoc operation description and replace the summary with a short phrase.
- **Prefer the shortest correct phrasing.** The summary should name the verb and
  the resource, plus just enough context to distinguish it from sibling operations.
  Move any additional detail into the TSDoc description.

**Voice pattern:** "Create an agent", "List connections", "Delete a dataset"

### ✅ Good

```typespec
@summary("Create an agent")
@summary("List connections")
@summary("Delete a dataset version")
@summary("Get a response")
```

### ❌ Bad — unnecessary filler

```typespec
@summary("List all connections in the project")  // "List connections" suffices
@summary("Retrieve a session by ID")             // "Get a session" suffices unless disambiguating
```

### ❌ Bad — trailing period

```typespec
@summary("Create a data generation job.")   // no period — use "Create a data generation job"
@summary("Cancel a fine-tuning job.")       // no period — use "Cancel a fine-tuning job"
```

Summaries are phrases, not sentences. Never end with a period.

### ❌ Bad — indirect phrasing

```typespec
@summary("Get info about a fine-tuning job")          // just "Get a fine-tuning job"
@summary("Get info about an evaluator generation job") // just "Get an evaluator generation job"
```

The verb "Get" already implies retrieving the resource. Do not pad with
"info about", "details of", "the status of", or similar indirection.

### ❌ Bad — missing article

```typespec
@summary("Create response")     // should be "Create a response"
@summary("Delete agent")        // should be "Delete an agent"
```

### ❌ Bad — third-person voice in summary

```typespec
@summary("Creates an agent")
@summary("Lists all connections in the project")
@summary("Deletes a dataset version")
```

### ❌ Bad — too long

```typespec
@summary("This operation lists all connections that are currently available in the project, including those that are pending and those that are active, and returns them as a paginated list")
```

### ❌ Bad — multiline paragraph

```typespec
@summary("""
  Create a Realtime client secret with an associated session configuration.

  Client secrets are short-lived tokens that can be passed to a client app.
  """)
```

Use `@summary("Create a Realtime client secret")` and move the paragraph
details into the operation TSDoc description.

### ❌ Bad — truncated

```typespec
@summary("Create a fine-tuning job which begins the process of creating a new")
@summary("Update the agent by adding a new version if there are any changes t")
```

Summaries must be complete phrases. If the intended text exceeds ~60 characters, shorten
it to a self-contained imperative phrase (e.g. `"Create a fine-tuning job"`,
`"Update an agent"`).

### ❌ Bad — malformed / duplicate verb

```typespec
@summary("List Returns a list of sessions for the specified agent")
```

Do not repeat the verb or splice in the doc-comment text. Use a clean imperative phrase
(e.g. `"List sessions for an agent"`).

### Remediation

- Use imperative voice: "Create", "Get", "List", "Delete", "Update" (not "Creates", "Gets", etc.)
- **No trailing period** — summaries are phrases, not sentences
- Use a single-line string literal, not a multiline triple-quoted string
- Keep under ~60 characters
- Remove filler words ("all", "by ID", "info about") unless needed for disambiguation
- Always include articles ("a", "an", "the") for grammatical completeness
- Prefer the shortest correct phrasing — verb + resource + minimal disambiguation
- Move detailed information into the TSDoc `/** ... */` comment
- If the intended text exceeds ~60 characters, shorten to a complete phrase

---

## FDOC-005 — Parameter Documentation

**Requirement:** Every parameter decorated with `@path`, `@query`, `@header`, or
`@body` must have a TSDoc inline comment (`/** ... */`) or `@doc()` decorator.

**Why:** Parameter descriptions flow into OpenAPI parameter `description` fields and
SDK method parameter documentation. Missing descriptions force developers to guess
at parameter semantics.

### ✅ Good

```typespec
getAgent is FoundryDataPlaneOperation<
  {
    /** The name of the agent to retrieve. */
    @path agent_name: string;
  },
  AgentObject
>;
```

### ❌ Bad

```typespec
getAgent is FoundryDataPlaneOperation<
  {
    @path agent_name: string;
  },
  AgentObject
>;
```

### Remediation

Add a `/** ... */` comment immediately before the parameter declaration, or add a
`@doc("...")` decorator to the parameter.

---

## FDOC-006 — No Adjacent TSDoc Blocks

**Requirement:** Do not place multiple TSDoc block comments next to each other when
they apply to the same operation or parameter.

**Why:** TypeSpec concatenates adjacent documentation blocks into a single OpenAPI
`description`. This can produce malformed output such as:

```json
"description": "Must not exceed 63 characters.The agent name path parameter."
```

### ✅ Good

```typespec
/**
 * The unique name that identifies the agent.
 * - Must start and end with alphanumeric characters.
 * - Can contain hyphens in the middle.
 */
@path
agent_name: string;
```

### ❌ Bad

```typespec
/**
 * The unique name that identifies the agent.
 * - Must start and end with alphanumeric characters.
 */
/** The agent name path parameter. */
@path
agent_name: string;
```

### Remediation

Merge the comments into a single TSDoc block, or remove the redundant generic
comment when a more specific description already exists. Prefer preserving the
more specific, customer-facing documentation.

---

## FDOC-007 — Remove Documentation Suppressions

**Requirement:** Do not keep suppressions for
`@azure-tools/typespec-azure-core/documentation-required` in scoped route files.
When the skill encounters a suppression for missing documentation, it must
remove the suppression and add the missing TSDoc documentation instead.

This includes auto-generated import suppressions such as:

```typespec
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
```

**Why:** Documentation suppressions hide gaps that flow into generated OpenAPI,
SDK documentation, and developer portals. Missing route and parameter
descriptions should be fixed at the TypeSpec source level so downstream
artifacts remain complete without relying on linter exceptions.

### ✅ Good

```typespec
/** Retrieves the requested response by its unique identifier. */
@summary("Get a response")
@get
@route("/responses/{response_id}")
getResponse is FoundryDataPlaneOperation<
  {
    /** The unique identifier of the response to retrieve. */
    @path response_id: string;
  },
  ResponseObject
>;
```

### ❌ Bad

```typespec
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
@get
@route("/responses/{response_id}")
getResponse is FoundryDataPlaneOperation<
  {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
    @path response_id: string;
  },
  ResponseObject
>;
```

### Remediation

Remove each `documentation-required` suppression and add the relevant TSDoc
comment:

- For operations, add an operation TSDoc comment and `@summary()` per
  `FDOC-001` through `FDOC-004`.
- For `@path`, `@query`, `@header`, and `@body` parameters, add a parameter
  TSDoc comment or `@doc()` per `FDOC-005`.
- Preserve unrelated suppressions and suppressions for rules other than
  `documentation-required`.

Do not leave a scoped route file in a state where the
`documentation-required` warning still needs to be suppressed.

---

## FDOC-008 — Description Override for Concatenated Descriptions

**Requirement:** When TypeSpec would concatenate multiple operation summaries,
operation descriptions, request body descriptions, or parameter descriptions
into noisy OpenAPI output, keep concise source documentation and add the
appropriate override extension with the intended final OpenAPI text.

This commonly happens for shared routes that support multiple content types
or for imported generated route parameters that already carry a generic
description. Without an override, OpenAPI can contain descriptions such as:

```yaml
summary: Create a video edit multipart Create a video edit json
description: Creates a video edit multipart from the supplied request. Creates a video edit json from the supplied request.
description: The request body.The request body.
description: The file id path parameter.The ID of the file.
```

**Why:** TypeSpec source still needs documentation to satisfy
`documentation-required`, but adjacent or merged documentation can produce
repetitive downstream descriptions. The Foundry OpenAPI post-processing
understands description override extensions, so use them to declare the clean
final description instead of stacking TSDoc comments.

### ✅ Good — shared route operation summary and description

```typespec
/** Creates a video edit from the supplied request. */
@summary("Create a video edit")
@extension("x-ms-summary-override", "Create a video edit")
@extension("x-ms-description-override", "Creates a video edit from the supplied request.")
@sharedRoute
@route("edits")
@post
createVideoEditMultipart is OpenAIOperation<...>;

/** Creates a video edit from the supplied request. */
@summary("Create a video edit")
@extension("x-ms-summary-override", "Create a video edit")
@extension("x-ms-description-override", "Creates a video edit from the supplied request.")
@sharedRoute
@route("edits")
@post
createVideoEditJson is OpenAIOperation<...>;
```

Add the same operation-level summary and description overrides to every variant
that TypeSpec merges into a single OpenAPI operation.

### ✅ Good — shared route request body

```typespec
@extension("x-ms-request-body-description-override", "The request body.")
@sharedRoute
@post
createContainerFileJson is OpenAIOperation<
  {
    /** The request body. */
    @body
    body: OpenAI.CreateContainerFileBody;
  },
  OpenAI.ContainerFileResource
>;
```

Use the operation-level `x-ms-request-body-description-override` extension for
`@body` and `@multipartBody` because TypeSpec does not emit parameter-level
extensions onto OpenAPI `requestBody`.

### ✅ Good — route parameter

```typespec
/** The file ID path parameter. */
@extension("x-ms-description-override", "The ID of the file.")
@path
file_id: string;
```

### ✅ Good — imported/generated parameter with existing generic text

```typespec
/** The file ID path parameter. */
@extension("x-ms-description-override", "The ID of the file.")
@path
file_id: string;
```

### ❌ Bad — adjacent TSDoc blocks

```typespec
/** The file id path parameter. */
/** The ID of the file. */
@path
file_id: string;
```

### ❌ Bad — repeated request body docs

```typespec
/** The request body. */
/** The request body. */
@body
body: OpenAI.ModifyAssistantRequest;
```

### Remediation

1. Remove adjacent duplicate or competing TSDoc blocks.
2. Keep a single TSDoc comment so the declaration remains documented.
3. For shared-route operation variants that emit concatenated operation
   summaries or descriptions, add the same `x-ms-summary-override` and
   `x-ms-description-override` to each variant.
4. For `@path`, `@query`, and real `@header` parameters, add
   `@extension("x-ms-description-override", "...")` immediately before the
   parameter decorator.
5. For `@body` and `@multipartBody`, add
   `@extension("x-ms-request-body-description-override", "...")` to the
   operation decorators, not to the body declaration.
6. Use the clean, customer-facing final description as the override value.
7. If the file does not already import and use OpenAPI decorators, add:

   ```typespec
   import "@typespec/openapi";
   using TypeSpec.OpenAPI;
   ```

Do not use adjacent TSDoc comments to combine generic and specific
documentation.

---

## Post-Edit: Format and Regenerate

After making any documentation fixes, **always** run these two steps:

### 1. Format

```shell
npx tsp format <modified-file-paths>
```

This prevents formatting-only diffs in subsequent PRs and keeps the codebase consistent.

### 2. Regenerate OpenAPI artifacts

```shell
cd specification/ai-foundry/data-plane/Foundry
npx tsp compile .
```

This reemits both JSON and YAML OpenAPI specs under `openapi3/`. The `tspconfig.yaml`
already configures `file-type: [yaml, json]` — do **not** change that setting.
Verify the regenerated files reflect your documentation updates.
