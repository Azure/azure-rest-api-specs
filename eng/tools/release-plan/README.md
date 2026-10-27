# Release-plan automation

The pipeline uses the triggering commit to find its merged PR, identify one
TypeSpec project and resolve its SDK API version. It looks up existing plans before
creating one. Creation still requires the normal new-API-version label or TypeSpec
configuration-change signal; rerunning does not override release eligibility.

## Replay a historical specification

Run the release-plan pipeline from a revision containing the fixed tooling and the
replay helper. Set `SpecCommitSha` to the original full 40-character merged commit
SHA. Omit it for normal runs, and do not combine it with `ReleasePlanId`.

The historical commit must be in the selected branch's history. The pipeline
fetches that history, refuses a dirty specification directory and restores only
the historical specification tree. The tooling, dependency lockfile and true
checkout revision remain current. The original SHA is passed to the release-plan
CLI for merged-PR selection and recorded in its result details; the preparation
step logs both tooling and specification revisions.

Metadata compilation or version-resolution failures are CLI errors, not successful
no-change skips. The pipeline's existing `continueOnError` policy is unchanged, so
verify the task logs and release-plan artifact rather than treating pipeline color
alone as proof that a plan was created. A `not_found` result or fallback artifact
is not a recovered plan.

After deploying the replay support, verify one eligible historical case's artifact,
saved plan, API version and PR linkage before replaying more. Recheck existing plans
before each batch. The private specification repository remains excluded from
automatic SDK generation. Missing SDK package identities or an undecided release
scope must be resolved by the service owner; this input does not force creation.
