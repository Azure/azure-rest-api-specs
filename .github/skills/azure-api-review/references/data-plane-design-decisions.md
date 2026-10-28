<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-07-24
     Derived from:
       - Azure REST API Guidelines (vNext)
         https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
     Data-plane counterpart to design-decisions.md. The register is identical;
     the factors are not -- ARM resource IDs, ARG queries, and RBAC-per-resource
     do not exist on the data plane. -->

# Data-Plane API Design Decision Frameworks

Structured frameworks for data-plane design trade-offs that do **not** have a
single correct answer.

> **Authoritative upstream context:** [performing an action](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#actions),
> [collections](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections),
> [query options](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections-query-options),
> and
> [long-running operation response time](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#lro-response-time)
> in the Azure REST API Guidelines. The matrices below are reviewer synthesis
> for choices where upstream intentionally does not prescribe one answer; they
> must not be presented as new upstream requirements.

**How the agent must use this file:**

- When a pattern triggers one of these trade-offs, produce a `💡 Suggestion`
  finding -- **never** `🔴 Blocking`.
- Present the relevant factors and the trade-off table.
- Ask the clarifying questions; do not answer them on the author's behalf.
- The human reviewer makes the final call.

If the agent cannot say which side of a matrix a spec falls on, it should ask
rather than pick. A confidently wrong verdict in a grey area costs more trust
than saying nothing.

---

## DDP-001: Inline Collection vs. Sub-Resource

A collection of sub-items can be an inline array property on the parent, or its
own addressable sub-resource path.

| Factor                     | Favors inline                       | Favors sub-resource                 |
| -------------------------- | ----------------------------------- | ----------------------------------- |
| Collection size            | Bounded, ≤20 items                  | Unbounded or customer-populated     |
| Growth trajectory          | Stable, known maximum               | Expected to grow                    |
| Independent lifecycle      | Always written with the parent      | Created/deleted individually        |
| Concurrency                | Whole-parent updates are acceptable | Concurrent per-item writes expected |
| Payload size               | <10 KB total                        | Could exceed 100 KB                 |
| Needs its own URL          | No                                  | Yes -- callers link to items        |
| Needs its own paging       | No                                  | Yes                                 |
| Partial update granularity | Replace the whole array is fine     | Per-item PATCH needed               |

**Recommendation:** inline if bounded, small, and written atomically with the
parent; sub-resource if unbounded, individually addressable, or independently
mutated. Discuss in between.

**Questions to ask:** What is the maximum size? Are items ever created or
deleted independently of the parent? Do two callers ever mutate different items
concurrently? Does anything need to link to a single item?

**Anti-pattern:** an unbounded inline array that forces read-modify-write of the
entire parent to add one item, with a lost-update race between concurrent
callers.

---

## DDP-002: Action vs. Resource

Some capabilities can be modelled either as a POST action or as a resource with
standard verbs.

| Factor                    | Favors action               | Favors resource                    |
| ------------------------- | --------------------------- | ---------------------------------- |
| Result persists           | No -- computed and returned | Yes -- retrievable later           |
| Result has identity       | No                          | Yes -- callers refer back to it    |
| Repeatability             | Naturally idempotent-ish    | Needs create/read/delete lifecycle |
| Caller wants history      | No                          | Yes -- list past instances         |
| Long-running              | Either                      | Strongly favors resource (job)     |
| Cancellable / inspectable | No                          | Yes                                |

**Recommendation:** if the output is durable, addressable, or enumerable, model
it as a resource -- typically a **job** resource for long-running work. If it is
a pure computation whose result the caller consumes and discards, an action is
right.

**Questions to ask:** Can a caller retrieve this result tomorrow? Can they list
what they have run before? Can they cancel it?

**Cross-reference:** if the answer lands on "resource" _and_ the action is
already named like a CRUD verb, this is
[`data-plane-resource-modeling.md`](data-plane-resource-modeling.md)
`DP-MODEL-01` (Blocking-eligible), not a suggestion. Do not soften a
CRUD-in-disguise finding into this matrix.

---

## DDP-003: Synchronous vs. Long-Running

| Factor                           | Favors synchronous | Favors LRO                    |
| -------------------------------- | ------------------ | ----------------------------- |
| p99 latency                      | < 1 s              | > 10 s                        |
| Bounded by caller-supplied input | Yes                | No -- scales with data volume |
| Progress reporting valuable      | No                 | Yes                           |
| Cancellation valuable            | No                 | Yes                           |
| Gateway/proxy timeouts a risk    | No                 | Yes                           |

**Recommendation:** synchronous under ~1 s and bounded; LRO when duration scales
with input or can exceed gateway timeouts. Between those, ask -- and note that
converting sync → LRO later is a **breaking change**, so when uncertain the LRO
shape is the safer default for anything data-volume-dependent.

**Questions to ask:** What is p99 today, and what is the worst case with the
largest input you accept? Does that change as the service scales?

---

## DDP-004: Singleton vs. Collection

| Factor                 | Favors singleton     | Favors collection              |
| ---------------------- | -------------------- | ------------------------------ |
| Can there ever be two? | Provably no          | Plausibly yes                  |
| Named by the caller    | No                   | Yes                            |
| Scoped per-something   | Global to the parent | Per user/region/tenant/purpose |

**Recommendation:** collection unless multiplicity is genuinely impossible.
Singleton → collection is a breaking change; the reverse is not needed.

**Questions to ask:** Could a customer want a second one, for a different
environment or purpose? Is this global to the parent, or scoped to something?

---

## DDP-005: Discriminated Union vs. Flat Model with Optional Properties

| Factor                        | Favors discriminated union | Favors flat + optional |
| ----------------------------- | -------------------------- | ---------------------- |
| Variants share few properties | Yes                        | No                     |
| New variants expected         | Yes                        | No                     |
| Callers switch on kind        | Yes                        | No                     |
| Cross-property validity rules | Many                       | Few                    |
| Number of variants            | ≥3                         | 2                      |

**Recommendation:** discriminated union when variants are meaningfully different
and the set will grow. Flat + optional when there are two near-identical shapes
-- a union there is ceremony without benefit.

**Questions to ask:** How many variants at GA, and how many in a year? What
fraction of properties are shared? Are there invalid combinations expressible in
the flat model?

---

## DDP-006: Filter Expression vs. Typed Query Parameters

| Factor                      | Favors typed parameters | Favors filter expression |
| --------------------------- | ----------------------- | ------------------------ |
| Number of filterable fields | ≤4                      | Many                     |
| Predicate complexity        | Equality only           | Ranges, AND/OR, nesting  |
| Discoverability in SDKs     | Strong                  | Weak (opaque string)     |
| Server-side validation cost | Low                     | Higher, and error-prone  |

**Recommendation:** typed parameters for a small, stable set -- they are
self-documenting, type-checked in SDKs, and produce good error messages. A
filter expression is a parser and a grammar the service must version and
document; only take it on when typed parameters genuinely cannot express the
need.

**Questions to ask:** Which fields are filterable? Do callers need OR / ranges?
If a filter string is used, where is its grammar documented, and what error code
does a malformed filter return?

**Anti-pattern:** `filter: string` with no documented grammar, no examples, and
no documented error code for a parse failure. That is three findings at once
(`DP-DOC-03`, `DP-ERR-01`, and this).
