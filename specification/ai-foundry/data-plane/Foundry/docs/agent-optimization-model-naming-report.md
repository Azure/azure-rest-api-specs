# Agent Optimization Model Naming Report

This report records the rename of the `Optimization*` unions and models associated with the Agent Optimization operations in [`src/agents-optimization/routes.tsp`](../src/agents-optimization/routes.tsp). It distinguishes types that are transitively reachable from an operation schema from similarly named declarations that were removed because they were unused.

## Summary

- The interface defines five operations: `create`, `get`, `list`, `cancel`, and `delete`.
- Four operations reference an Agent Optimization schema directly. `delete` has no Agent Optimization model in its signature.
- Fifteen operation-reachable `Optimization*` declarations were renamed: fourteen to `AgentOptimization*` and `OptimizationAgentIdentifier` to `OptimizedAgentIdentifier`.
- Three additional unreferenced `Optimization*` declarations were removed from the feature's model file.
- The singular `AgentOptimization*` prefix matches the existing `AgentOptimizationJobs` interface and `AgentOptimizationRequiredPreviews` constant.

## Operation Entry Points

| Operation | Route | Direct Agent Optimization type | Association |
| --- | --- | --- | --- |
| `create` | `POST /agent_optimization_jobs` | `AgentOptimizationJob` | Request and response job schema through `postJobPreview` |
| `get` | `GET /agent_optimization_jobs/{jobId}` | `AgentOptimizationJob` | Response job schema through `queryJobStatusPreview` |
| `list` | `GET /agent_optimization_jobs` | `AgentOptimizationJobListItem` | List item schema through `listJobsPreview` |
| `cancel` | `POST /agent_optimization_jobs/{jobId}:cancel` | `AgentOptimizationJob` | Response job schema through `cancelJobPreview` |
| `delete` | `DELETE /agent_optimization_jobs/{jobId}` | None | Uses `deleteJobPreview` without an Agent Optimization model argument |

## Operation-Reachable Renames

The implemented names generally apply the rule `OptimizationX` to `AgentOptimizationX`; `OptimizationAgentIdentifier` uses `OptimizedAgentIdentifier` to avoid a repeated `Agent`.

| Kind | Previous name | Current name | How it is associated |
| --- | --- | --- | --- |
| Model | `OptimizationJob` | `AgentOptimizationJob` | Direct type for `create`, `get`, and `cancel`; base of the list item |
| Model | `OptimizationJobListItem` | `AgentOptimizationJobListItem` | Direct item type for `list` |
| Model | `OptimizationJobInputs` | `AgentOptimizationJobInputs` | `OptimizationJob` input type through `JobLike` |
| Model | `OptimizationJobResult` | `AgentOptimizationJobResult` | `OptimizationJob` result type through `JobLike` |
| Model | `OptimizationJobProgress` | `AgentOptimizationJobProgress` | `OptimizationJob.progress` |
| Model | `OptimizationCandidate` | `AgentOptimizationCandidate` | Element of `OptimizationJobResult.candidates` |
| Model | `OptimizationAgentIdentifier` | `OptimizedAgentIdentifier` | `OptimizationJobInputs.agent` and `OptimizationJobListItem.agent` |
| Model | `OptimizationOptions` | `AgentOptimizationOptions` | `OptimizationJobInputs.options` |
| Model | `OptimizationEvaluatorRef` | `AgentOptimizationEvaluatorRef` | Element of `OptimizationJobInputs.evaluators` |
| Model | `OptimizationDatasetInput` | `AgentOptimizationDatasetInput` | Base type of the training and validation datasets |
| Union | `OptimizationDatasetInputType` | `AgentOptimizationDatasetInputType` | Discriminator type for `OptimizationDatasetInput` and its variants |
| Model | `OptimizationInlineDatasetInput` | `AgentOptimizationInlineDatasetInput` | Inline variant of `OptimizationDatasetInput` |
| Model | `OptimizationReferenceDatasetInput` | `AgentOptimizationReferenceDatasetInput` | Registered-dataset variant of `OptimizationDatasetInput` |
| Model | `OptimizationDatasetItem` | `AgentOptimizationDatasetItem` | Element of `OptimizationInlineDatasetInput.items` |
| Model | `OptimizationDatasetCriterion` | `AgentOptimizationDatasetCriterion` | Element of `OptimizationDatasetItem.criteria` |

The main dependency paths are:

```text
AgentOptimizationJob
|- JobLike<AgentOptimizationJobResult, AgentOptimizationJobInputs>
|- AgentOptimizationJobProgress
`- AgentOptimizationJobListItem

AgentOptimizationJobResult
`- AgentOptimizationCandidate
   `- PromotionInfo

AgentOptimizationJobInputs
|- OptimizedAgentIdentifier
|- AgentOptimizationDatasetInput
|  |- AgentOptimizationDatasetInputType
|  |- AgentOptimizationInlineDatasetInput
|  |  `- AgentOptimizationDatasetItem
|  |     `- AgentOptimizationDatasetCriterion
|  `- AgentOptimizationReferenceDatasetInput
|- AgentOptimizationEvaluatorRef
`- AgentOptimizationOptions
```

`PromotionInfo` is shown for completeness but is not a rename candidate because it does not start with `Optimization`.

## Removed Unreferenced Types

These declarations matched the naming pattern, but no route or model referenced them. They were removed instead of renamed and are excluded from the fifteen operation-reachable renames.

| Kind | Removed name | Previous references |
| --- | --- | --- |
| Union | `OptimizationMode` | Declaration only |
| Model | `OptimizationAgentDefinition` | Declaration only |
| Model | `OptimizationTaskResult` | Declaration only |

## Rename Impact

All declarations and their TypeSpec references are in [`src/agents-optimization/models.tsp`](../src/agents-optimization/models.tsp) and [`src/agents-optimization/routes.tsp`](../src/agents-optimization/routes.tsp), except for these SDK customization references:

| Current type | SDK customization |
| --- | --- |
| `AgentOptimizationDatasetItem` | [`src/sdk-csharp-azure-ai-projects-agents/client.tsp`](../src/sdk-csharp-azure-ai-projects-agents/client.tsp) customizes `desired_num_turns` |
| `AgentOptimizationCandidate` | [`src/sdk-java-azure-ai-agents/client.tsp`](../src/sdk-java-azure-ai-agents/client.tsp) customizes four property names |
| `AgentOptimizationInlineDatasetInput` | [`src/sdk-python-js-azure-ai-projects/client.tsp`](../src/sdk-python-js-azure-ai-projects/client.tsp) customizes `items` for Python |

The rename changes generated schema names and therefore SDK public type names unless client-name overrides preserve the old names. The OpenAPI outputs must be regenerated with the TypeSpec declarations.

## Implementation Notes

Fourteen operation-reachable declarations use singular `AgentOptimization*`, matching the existing `AgentOptimizationJobs` interface and `AgentOptimizationRequiredPreviews` constant.

`OptimizationAgentIdentifier` became `OptimizedAgentIdentifier` to avoid the mechanically awkward repeated `Agent` in `AgentOptimizationAgentIdentifier`.

The three unused declarations were removed so the feature no longer carries dead or future-only schema.