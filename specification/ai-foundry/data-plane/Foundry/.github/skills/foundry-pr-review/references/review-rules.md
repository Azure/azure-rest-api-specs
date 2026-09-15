# Foundry Review Rules

Apply these checks to additions and material modifications in the PR. Existing patterns are
evidence, not automatic precedent: distinguish intentional compatibility from newly introduced
inconsistency.

## Routes And Names

- Use lowercase route literals with `_` between words: `/widget_export_jobs`.
- Use plural resource nouns. In compounds, pluralize the head noun only.
- Keep routes flat. Do not add consecutive noun segments without an identifier between them.
- A singleton child beneath a parent identifier may use a singular noun, such as
  `/agents/{name}/endpoint`.
- Express actions with `:`, such as `/widgets/{id}:cancel`.
- Name long-running job collections `<attributive_noun>_jobs`.
- Use `snake_case` for new JSON property names. Do not flag an established external schema,
  imported OpenAI contract, SDK-only customization, or compatibility-preserving wire name.

## Operations

- Build GA operations on `FoundryDataPlaneOperation` rather than duplicating its response,
  API-version, and error plumbing.
- Build preview operations on `FoundryDataPlanePreviewOperation` with the appropriate
  `FoundryFeaturesOptInKeys` member. An established required-preview template is valid when the
  opt-in must be required.
- HTTP decorators such as `@get` and `@post` may still decorate operations that use these
  templates; the problem is bypassing the shared operation infrastructure.
- Do not invent or enforce a versioned-resource CRUD pattern. That pattern is being revised.

## Pagination

- Cursor-paginated list operations spread `CommonPageQueryParameters`.
- They return `AgentsPagedResult<T>` unless an established external wire contract requires a
  different envelope.
- Check that examples and generated output expose the same cursor fields and item envelope.

## Long-Running Jobs

- Prefer a job when the documented 99th-percentile response time exceeds one second or the
  operation orchestrates multiple resources. Comment on a synchronous design only when the PR
  provides evidence for one of those conditions.
- Model a job as `JobLike<TResult, TInputs>` with explicit input and result models.
- Provide create, get-status, list, cancel, and delete operations. Accept an omission only when
  the PR documents a concrete reason.
- Use `postJob`, `queryJobStatus`, `listJobs`, `cancelJob`, and `deleteJob` for GA jobs.
- Use all five corresponding `*Preview` templates with the same feature key for preview jobs.
- Add custom list filters through a filter model or alias passed as the list template's filter
  type parameter. Do not reimplement the shared pagination parameters.

## Defaults

- When an optional request property has a fixed service default, express the default in TypeSpec
  and state it in the property's documentation.
- When the default is conditional, document each possible default and the condition selecting it.
- Do not infer a default from an example alone.

## Unions And Discriminators

- When a literal selects an existing named union variant, reference the member, such as
  `RoutineTriggerType.timer`, instead of repeating `"timer"`.
- Do not add an `object` property that only repeats the model type as a string.
- Allow an established discriminator or `object` property when the wire contract needs it for
  polymorphic selection or compatibility. Imported OpenAI contracts commonly require one.

## Timestamps

- Use `FoundryTimestamp` for new Foundry-owned date/time fields. It represents Unix epoch
  `int32` values.
- Do not request this change when an established external contract or compatibility requirement
  explicitly uses `utcDateTime`, an ISO string, or another representation.

## Pull Request Readiness

- Foundry release PRs target `feature/foundry-release`.
- A PR presented as ready for review should be non-draft and carry the `In-Review` label.
- Treat base-branch, draft-state, and label findings as PR-level workflow comments, not inline
  code comments.
- Do not claim that a feature spec is approved or that a service is deployed and testable unless
  the PR provides verifiable evidence.
- Do not merge or complete the PR as part of review.

## General Contract Checks

- Look for accidental breaking changes to routes, requiredness, types, enum values, defaults,
  status codes, headers, pagination, and operation IDs.
- Check that examples agree with the TypeSpec request and response shapes.
- When generated OpenAPI changes are present, verify that they match the controlling TypeSpec
  intent. Report the source defect rather than each generated symptom.
- Check that preview gating is consistent across all operations that expose the same preview
  resource.
- Prefer one root-cause finding over a cluster of derivative comments.
