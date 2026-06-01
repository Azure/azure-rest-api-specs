# Foundry Route Documentation Rules

Detailed definitions for each documentation rule applied to TypeSpec route operations
in the AI Foundry data-plane (Foundry) area.

> **Conservative Change Policy:** Only fix operations with explicit, significant rule
> violations. Do not rewrite text that is already substantially correct. If a doc comment
> or summary merely uses slightly different wording but satisfies all rules, leave it alone.

---

## FDOC-001 — Operation Documentation Comment

**Requirement:** Every operation in an `interface` block must have either a TSDoc block
comment (`/** ... */`) immediately preceding it, or a `@doc("...")` decorator.

**Why:** Documentation comments flow into the generated OpenAPI `description` field and
are consumed by SDK generators, API reference docs, and developer portals. Missing
descriptions produce empty documentation in all downstream artifacts.

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

Add a `/** ... */` comment block directly above the first decorator of the operation,
or add a `@doc("...")` decorator. Use **third-person indicative** voice (see FDOC-003).

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

## FDOC-003 — Documentation Voice: Third-Person Indicative

**Requirement:** The TSDoc comment or `@doc()` value must use **third-person indicative**
voice. The description should read as a statement of what the operation does, not as a
command to the caller.

**Voice pattern:** "Creates …", "Retrieves …", "Deletes …", "Lists …", "Updates …"

### ✅ Good

```typespec
/** Creates an agent with the specified configuration. */

@doc("Retrieves the agent by its unique name.")

/** Lists all connections in the project. */
```

### ❌ Bad — imperative voice in doc comment

```typespec
/** Create an agent with the specified configuration. */

@doc("Retrieve the agent by its unique name.")

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

## FDOC-004 — @summary Voice: Imperative

**Requirement:** The `@summary()` value must be a concise, single-line phrase in
**imperative (vocative) voice**. It reads as a command or action label.

**Voice pattern:** "Create an agent", "List connections", "Delete a dataset"

### ✅ Good

```typespec
@summary("Create an agent")
@summary("List all connections in the project")
@summary("Delete a dataset version")
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
- Keep under ~60 characters
- Move detailed information into the `@doc()` or TSDoc comment

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
