# Optional Client Configuration

Run this step after the TypeSpec source plan and before applying changes. It is
separate from the source plan because `client.tsp` affects generated clients,
not the REST contract.

## Decide

Skip this step without prompting when the request cannot affect the generated
client surface, such as documentation-only edits. For SDK-visible source
changes, client configuration analysis is recommended and included by default.
Proceed without a blocking confirmation unless the user explicitly opts out.
When presenting a plan or interim update, explain:

> Client configuration analysis is included by default for SDK-visible changes.
> You can opt out for this authoring request and run the analysis later when
> entering the Azure SDK release workflow using AzSDKToolsAgent:
> <https://aka.ms/azsdk/agent>.

Absence of an opt-out keeps the recommended default. Do not pause source
authoring to ask the user to confirm the default. When the user opts out, do not
invoke `azsdk-common-typespec-naming` or create or edit `client.tsp`.

Keep the source and client configuration plans visibly separate so the user can
approve the source changes while declining the client configuration portion.

## Build the Client Configuration Plan

1. Identify confirmed SDK languages, ARM/data-plane context, changed
   declarations, and release compatibility evidence.
2. When a project is available, read the existing `client.tsp` and generation
   entrypoint **without editing** them. Record existing
   `@clientName`/`@@clientName` overrides, whether the customization file is
   loaded, and whether proposed targets resolve. For planning from supplied
   facts only, use that evidence and leave project-dependent checks unverified;
   do not block recommendations for confirmed new, unshipped names on the
   absence of project files.
3. Invoke `azsdk-common-typespec-naming` in guidance mode, then read its naming
   dispatcher and matching profile references. Invocation alone is not naming
   analysis. Apply those rules to the proposed SDK names even when client
   configuration was included by default rather than explicitly requested.
4. Produce a distinct client configuration plan containing targets, current and
   proposed SDK names, language scopes, compatibility evidence, exceptions,
   uncovered targets, and blockers. Preserve shipped SDK names, wire contracts,
   and other-language overrides.

Naming-only requests route directly to `azsdk-common-typespec-naming`; they do
not need the full authoring workflow.

## Apply

After authorization, invoke `azsdk-common-typespec-naming` in apply mode. Follow
its scoped direct-edit workflow for SDK-only naming overrides, including its
evidence, preservation and validation requirements. Do not call
`azsdk_customized_code_update` for naming-only changes, even when available.
Other SDK customizations remain with their existing workflows.
