# Foundry data-plane TypeSpec

This folder contains the TypeSpec for all data-plane REST APIs of the Foundry service.

## Voice-agent post-call contract candidate

`VoiceAgentDefinition.post_call_config` stores optional post-call targets with an immutable agent version.
Omitting it or setting it to `null` when creating or replacing a complete definition leaves that version
unconfigured; earlier versions remain unchanged. Saving a definition does not send events or dispatch routines.

Event Grid and routines are independent targets, not mutually exclusive alternatives:

```yaml
post_call_config:
  event_grid_connection_name: post-call-events
  routine_names: [archive, analysis]
```

Event Grid alone uses `{ event_grid_connection_name: post-call-events }`; routines alone use
`{ routine_names: [archive, analysis] }`. Configure at most ten routines. The single Event Grid connection
does not count toward that limit. Each reference is a bare name in the same project, not a URL, resource path,
endpoint, or credential. Each Routine name is at most 128 characters. Routine names refer to versioned routine
definitions resolved at post-call dispatch; the voice-agent configuration does not pin a routine version or
add timeout or policy fields.

### Validation boundaries

| Input | Contract |
| ----- | -------- |
| Omitted or `null` `post_call_config` | No post-call targets for that agent version. |
| Non-null configuration | At least one valid Event Grid or Routine target is required. |
| Omitted `routine_names` or `routine_names: []` | No Routine targets; a valid Event Grid target is required. |
| `routine_names: null`, null members, or non-string members | Invalid. |
| More than ten Routine names, even with Event Grid | Invalid. |
| Empty, blank, whitespace-containing names, URLs, or resource paths | Invalid. |
| Duplicate Routine names | Rejected using ordinal, case-sensitive comparison; not silently deduplicated. `Archive` and `archive` are distinct names. |
| Unknown configuration properties, including the unpublished scalar `routine_name` or object-valued `routines` | Invalid. |

The generated schema enforces a closed configuration object, string and array types, nonempty string values,
the 128-character Routine name limit, and zero-to-ten array bounds. The service additionally enforces at least one valid target,
bare-name syntax, duplicate Routine names, target resolution and authorization, and support for post-call
processing by the selected voice-agent definition. Schema validation alone is not proof that a configuration is valid.
Neither target field accepts `null`; only the whole `post_call_config` does.
Bare Routine references reject whitespace, `/`, `\`, `:`, `?`, `#`, `%`, and the names `.` and `..`.
Unicode names are allowed; no ASCII-only name pattern is imposed.

### Delivery and snapshot quality

After an observable session end, the service attempts all configured targets independently and concurrently
on a best-effort basis. It captures once and shares that snapshot and an overall deadline across targets.
An Event Grid failure or one Routine's failure does not block attempts to the remaining targets. This does
not guarantee delivery after a hard crash or exactly-once delivery.

Consumers must distinguish `complete_observed_snapshot`, `partial`, and `unavailable`. Routine metadata uses
`snapshot_status`, `snapshot_reason`, `transcript_quality`, and `session_outcome`; Event Grid CloudEvent
extensions use `snapshotstatus`, `snapshotreason`, and `transcriptquality`. A partial snapshot or a notification
without a snapshot is not a complete transcript. `observed_not_verified_heard` does not prove the user heard
all generated speech, and a completed server outcome does not prove the client received `session.done`.

### Publication and integration gates

This is a public-contract review candidate, not a statement of deployed service, portal, or SDK availability.
It preserves the current unified `VoiceAgentDefinition`, existing API versions, and `VoiceAgents=V1Preview`
metadata. It neither introduces internal realtime/live model types nor changes the Voice Live API.
The Foundry API owner must approve the supported-definition boundary and existing preview gates before release.
The matching service implementation, SDK generation and pinning, and portal support must be aligned separately.
VM-to-cloud Routine/Hosted Agent proof is not evidence that a cloud-native `voice_post_call` provider is released.

## Contributing

### Adding preview features

Make sure that all preview features (routes and TypeSpec models) that are not associated with the `/openai` routes are marked with
both the `@added` decorator for the target preview version, and the `@removed`
decorator for the GA `v1` version. If you don't add the `@removed` decorator, your preview
features will incorrectly appear in the GA `v1` swagger in
(file `..\data-plane\Azure.AI.Projects\stable\v1\azure-ai-projects.json`).

For example:

```txt
@removed(Versions.v1)
model MyNewPreviewModel {
...
}
```

The models.tsp files associated with OpenAI routes `openai/responses`, `"openai/conversations` and `openai/evals` should not have
these decorators. The interfaces using those will have the appropriate decorators.

### Compiling and sending a PR

Before you send a PR for changes in this folder, do the following:

Change to folder

```cmd
cd specification\ai\Azure.AI.Projects
```

Make sure you have latest tools by running:

```cmd
npm ci
```

Create an empty folder named "examples", if one does not already exist

```cmd
mkdir examples
```

Compile, validate and re-format by running:

```cmd
npx tsv .
```

Fix any errors you see. This command may also update the format
of some files to make sure all files use a common format.

The above will also automatically create or edit swagger (OpenAPI) files in the
`..\data-plane\Azure.AI.Projects` folder. Review the changes there to make
sure they make sense to you. Then add them to your PR.

The `npx tsv .` has a console spew that shows the diff between current and staged
changes. Once you `git add` all the changed files and run `npx tsv .` again, there should
no longer be any diffs to show.

## Emitting Python code

Please do not emit SDKs in the public Python repo. SDK originated from TypeSpec that is private should not be pushed into a branch in a public GitHub repo.

If you want to emit Python SDK from latest TypeSpec in this folder do the following:

- In repo `azure-sdk-for-python-pr`, create a topic branch off branch `feature/azure-ai-projects/2.0.0b1`. This means you get the changes to emitter tool files that define additional dependency on a package that contains new TypeSpec decorators. You will also get all the added hand-written code (in `_patch.py` files).
- cd `sdk\ai\azure-ai-projects`
- Emit using
  - `tsp-client update --local-spec-repo <path>` where "path" is your local path to the private TypeSpec project folder, or
  - `tsp-client update` to use the TypeSpec commit mentioned in the local tsp-location.yaml file
- After the code was emitted, run the script `post-emitter-fixes.cmd`
- To review your changes, send a PR for merging your topic branch into branch `feature/azure-ai-projects/2.0.0b1`
