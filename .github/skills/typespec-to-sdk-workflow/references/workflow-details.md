# TypeSpec to SDK Workflow Details

## Resumable Workflow Support

The workflow detects current state and resumes appropriately:

| Scenario | Resume Point |
|----------|-------------|
| Release plan + API spec PR exist | Step 6 (SDK Generation) |
| API spec PR exists, no release plan | Create plan, then Step 6 |
| Pipeline SDK generation failed | Switch to local generation |
| SDK generated, needs package prep | Step 9 (Release) |

## SDK Languages by Service Type

| Service Type | Required Languages |
|-------------|-------------------|
| Management Plane | .NET, Java, JavaScript, Python, Go |
| Data Plane | .NET, Java, JavaScript, Python |

## SDK Generation Methods

**Local generation:**
- Use skill: `generate-sdk-locally`
- Faster iteration, debug locally

**Pipeline generation:**
- Run `azsdk_run_generate_sdk` for each language
- Monitor pipeline status (~15-20 minutes)
- PRs created automatically

## Release Process

1. Verify all SDK PRs are merged
2. Check release readiness for each language
3. Trigger release pipeline
4. User approves release in pipeline
5. Packages published to registries
6. Release plan auto-completes
