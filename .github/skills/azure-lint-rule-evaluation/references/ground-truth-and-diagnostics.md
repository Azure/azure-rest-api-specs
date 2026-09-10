# Ground truth & diagnostics

You cannot classify a violation correctly unless you know **exactly what the rule
computed**. Two levels of data are needed for every violation:

1. A **stable source location** (file + line) that maps to the flagged operation.
2. The rule's **actual vs expected** values — the two things it compared.

## Parsing raw diagnostics

`tsp compile` / `tsv` print diagnostics as `path:line:col - warning <rule-id>: <message>`.
Capture stdout+stderr, strip ANSI color codes, and keep only lines matching the
rule id. This gives you the count and locations, but usually **not** the computed
values — the message is a generic template. That is why instrumentation matters.

## Instrumenting the rule for ground truth (recommended)

The rule is plain JS under
`node_modules/@azure-tools/<pkg>/dist/src/rules/<rule>.js`. Add a tiny logging
helper that runs at each point the rule decides to report, emitting a single
machine-readable line to stderr. Do **not** change any decision logic — only add
logging.

Pattern:

```js
import { getSourceLocation } from "@typespec/compiler";
// ...inside create(context), next to the existing report call:
function dbg(op, kind, actual, expected) {
  try {
    const sl = getSourceLocation(op.operation.node);
    const line = sl?.file ? sl.file.getLineAndCharacterOfPosition(sl.pos).line + 1 : "?";
    console.error(
      "RULEDBG " +
        JSON.stringify({
          file: sl?.file?.path,
          line,
          op: op.name,
          kind,
          actual: describe(actual),
          expected: describe(expected),
        }),
    );
  } catch {}
}
```

Call `dbg(...)` immediately before each `context.reportDiagnostic(...)`, passing
the variant (`kind`) and the two compared types. Then:

```powershell
npx tsp compile <dir> --no-emit 2>&1 | Select-String 'RULEDBG '
```

Collect every `RULEDBG` line across all specs into a table
(`file, line, op, kind, actual, expected`). This is the authoritative dataset for
classification and for the report's "encoded vs expected" columns.

**Remove the instrumentation before final validation** so `tsv` runs the pristine
rule. Reinstall the package or revert the added lines; the diagnostic set is
unchanged by the logging, but validate with the clean rule to be safe.

### Line semantics

`getSourceLocation(op.operation.node).pos` typically points at the operation's
**leading trivia** — i.e. the first line of its doc-comment / decorator block, not
the `op` keyword line. This is exactly where a `#suppress` should be inserted
(above the doc + decorators), so use this line directly for suppression placement.

## Storing the dataset

Keep the violations in a queryable form (a small SQLite table or CSV) with columns
for `file, line, op, kind, actual, expected, determination, evidence`. You will
sort by `(file, line)` to drive suppression insertion and group by `determination`
for the report.
