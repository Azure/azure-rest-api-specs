# Azure Monitor Health Models data-plane API

Azure Monitor Health Models enables platform engineering and site reliability teams to submit application-specific health signals, evaluate them within a management-plane-defined dependency model, and investigate how those signals affect service health over time.

## Detect and diagnose checkout latency after a deployment

A platform engineer connects the checkout application's telemetry emitter to Cloud Health so elevated frontend latency degrades the modeled service health. An on-call engineer then confirms that the report was processed, isolates the unhealthy signal, and focuses mitigation on the frontend rather than its healthy backend dependency.

**Prerequisites:** The Cloud Health management plane has provisioned a health model containing the `frontend-web-app` entity, its `backend-api` dependency, and the `request-latency-p95` signal. The telemetry emitter and on-call engineer have Microsoft Entra authorization for the model's data-plane endpoint.

```http
GET /api?api-version=2026-06-01-preview
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/json

{
  "rootEntityName": "frontend-web-app",
  "healthModelExists": true,
  "healthModelState": "Healthy"
}
```

```http
POST /api/entities/frontend-web-app/healthReports?api-version=2026-06-01-preview
Content-Type: application/json
Repeatability-Request-ID: 7d4f3b5c-95a1-4cf7-a03d-7fe25435b752
Repeatability-First-Sent: Wed, 02 Sep 2026 11:00:00 GMT

{
  "signalName": "request-latency-p95",
  "healthState": "Degraded",
  "value": 240,
  "evaluationRules": {
    "degradedRule": {
      "operator": "GreaterThan",
      "threshold": 200
    },
    "unhealthyRule": {
      "operator": "GreaterThanOrEqual",
      "threshold": 500
    }
  },
  "expiresInMinutes": 60,
  "additionalContext": "p95 checkout latency exceeded the degraded threshold."
}

HTTP/1.1 200 OK
Content-Type: application/json
Repeatability-Result: accepted

{
  "accepted": true
}
```

The response confirms that the report was durably accepted into the ingestion pipeline. The operation is not long-running and exposes no polling resource. If the client loses the response, it retries with the same repeatability headers to avoid duplicate ingestion.

The submitted `healthState` is the authoritative observation. The optional `value` and `evaluationRules` record the inputs and rules the telemetry producer used; the service does not recalculate the state or change management-plane signal definitions from them. If the signal name is not configured, the report creates an external signal instance. A later report replaces the signal's current observation, while earlier values and health states remain available through signal history.

```http
GET /api/entities/frontend-web-app/signals/request-latency-p95/history?api-version=2026-06-01-preview&startAt=2026-09-02T10:55:00Z&endAt=2026-09-02T11:05:00Z&maxpagesize=100
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/json

{
  "value": [
    {
      "occurredAt": "2026-09-02T11:00:00Z",
      "value": 240,
      "healthState": "Degraded",
      "additionalContext": "p95 checkout latency exceeded the degraded threshold."
    }
  ]
}
```

```http
GET /api/entities/frontend-web-app?api-version=2026-06-01-preview
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/json

{
  "entityName": "frontend-web-app",
  "healthState": "Degraded",
  "lastHealthTransitionAt": "2026-09-02T11:00:00Z",
  "lastHealthTransitionReason": "SignalTransition",
  "impact": "Limited",
  "signalInputs": [
    {
      "name": "request-latency-p95",
      "effectiveHealthState": "Degraded"
    }
  ],
  "dependencyInputs": [
    {
      "name": "backend-api",
      "effectiveHealthState": "Healthy"
    }
  ],
  "effectiveDependencyAggregation": {
    "configuration": {
      "aggregationType": "WorstOf",
      "ignoreUnknown": false
    },
    "resolution": "Configured"
  },
  "signalAggregationGroups": []
}
```

The on-call engineer now has evidence that frontend latency caused the modeled health degradation while the backend remained healthy.

## Distinguish a reported signal state from the entity's aggregated state

A signal's `healthState` is what the producer reported; an entity's `healthState` is the service's aggregation of all its signal and dependency inputs. Reporting a signal as `Healthy` therefore does not guarantee the entity becomes `Healthy`. Suppose the latency signal recovers at 11:20 UTC, but `backend-api` became `Unhealthy` at 11:10 UTC.

```http
POST /api/entities/frontend-web-app/healthReports?api-version=2026-06-01-preview
Content-Type: application/json
Repeatability-Request-ID: 0c1f6a52-3b0e-4f0a-9a58-6e2f4f7d9b11
Repeatability-First-Sent: Wed, 02 Sep 2026 11:20:00 GMT

{
  "signalName": "request-latency-p95",
  "healthState": "Healthy",
  "value": 120
}

HTTP/1.1 200 OK
Content-Type: application/json
Repeatability-Result: accepted

{
  "accepted": true
}
```

```http
GET /api/entities/frontend-web-app?api-version=2026-06-01-preview
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/json

{
  "entityName": "frontend-web-app",
  "healthState": "Unhealthy",
  "lastHealthTransitionAt": "2026-09-02T11:10:00Z",
  "lastHealthTransitionReason": "ChildEntityTransition",
  "impact": "Standard",
  "signalInputs": [
    {
      "name": "request-latency-p95",
      "effectiveHealthState": "Healthy"
    }
  ],
  "dependencyInputs": [
    {
      "name": "backend-api",
      "effectiveHealthState": "Unhealthy"
    }
  ],
  "effectiveDependencyAggregation": {
    "configuration": {
      "aggregationType": "WorstOf",
      "ignoreUnknown": false
    },
    "resolution": "Configured"
  },
  "signalAggregationGroups": []
}
```

The signal input is `Healthy`, yet the entity is `Unhealthy` because the `backend-api` entry in `dependencyInputs` contributes `Unhealthy` under `WorstOf` aggregation. The engineer should investigate `backend-api` rather than the frontend signal.

## Route an incident using a bounded, point-in-time diagnosis

An on-call engineer or an AI agent using an MCP integration needs to explain a checkout degradation and identify the responsible team. Using `2026-10-01-preview`, the caller reads the frontend at the incident time, follows contributing dependencies through a bounded diagnosis, and uses entity labels to route the investigation.

**Prerequisites:** The health model contains `frontend-web-app`, its `backend-api` and `orders-database` dependencies, and an `orders-storage` dependency beneath `orders-database`. The frontend has a `request-latency-p95` signal. The frontend and database have configured `team` labels, and the caller has Microsoft Entra authorization for the data-plane endpoint. The incident time is within the service's retained history.

```http
GET /api/entities/frontend-web-app?api-version=2026-10-01-preview&timestamp=2026-11-17T12%3A30%3A00Z
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/json

{
  "entityName": "frontend-web-app",
  "healthState": "Degraded",
  "lastHealthTransitionAt": "2026-11-17T12:00:00Z",
  "lastHealthTransitionReason": "SignalTransition",
  "impact": "Limited",
  "signalInputs": [
    {
      "name": "request-latency-p95",
      "effectiveHealthState": "Degraded"
    }
  ],
  "dependencyInputs": [
    {
      "name": "backend-api",
      "effectiveHealthState": "Healthy"
    },
    {
      "name": "orders-database",
      "effectiveHealthState": "Degraded"
    }
  ],
  "effectiveDependencyAggregation": {
    "configuration": {
      "aggregationType": "WorstOf",
      "ignoreUnknown": false
    },
    "resolution": "Configured"
  },
  "signalAggregationGroups": [],
  "tags": {
    "environment": "production",
    "team": "frontend"
  }
}
```

The caller requests one level of contributing dependencies at the same incident time. The root is depth zero; `maxDepth=1` includes child fragments but does not expand their children. If omitted, `maxDepth` defaults to 10; `maxDepth=0` returns only the root fragment with dependency summaries.

```http
GET /api/entities/frontend-web-app/diagnosis?api-version=2026-10-01-preview&maxDepth=1&timestamp=2026-11-17T12%3A30%3A00Z
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/json

{
  "requestedEntityName": "frontend-web-app",
  "observedAt": "2026-11-17T12:30:00Z",
  "status": "Complete",
  "value": [
    {
      "entityName": "frontend-web-app",
      "tags": {
        "environment": "production",
        "team": "frontend"
      },
      "nonContributingDependencyNames": ["backend-api"],
      "evidence": {
        "healthState": "Degraded",
        "outcome": "ContributingInputsAndAggregation",
        "determiningInputCategories": ["Signal", "Dependency"],
        "signals": [
          {
            "kind": "Signal",
            "signalName": "request-latency-p95",
            "healthState": "Degraded"
          }
        ],
        "dependencies": [
          {
            "entityName": "orders-database",
            "contributedHealthState": "Degraded"
          }
        ],
        "signalGroupAggregations": []
      }
    }
  ],
  "partial": [],
  "nextLink": "https://contoso-1f33ba.eastus.data.cloudhealth.azure.com/api/entities/frontend-web-app/diagnosis?api-version=2026-10-01-preview&maxDepth=1&timestamp=2026-11-17T12%3A30%3A00Z&nextMarker=eyJwYWdlIjoyfQ"
}
```

`Complete` describes the evidence quality on this page, not whether paging is finished. The caller follows `nextLink` unchanged rather than constructing a new diagnosis request. The `orders-database` dependency has no boundary merely because its fragment arrives on the next page.

```http
GET https://contoso-1f33ba.eastus.data.cloudhealth.azure.com/api/entities/frontend-web-app/diagnosis?api-version=2026-10-01-preview&maxDepth=1&timestamp=2026-11-17T12%3A30%3A00Z&nextMarker=eyJwYWdlIjoyfQ
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/json

{
  "requestedEntityName": "frontend-web-app",
  "observedAt": "2026-11-17T12:30:00Z",
  "status": "Complete",
  "value": [
    {
      "entityName": "orders-database",
      "parentEntityName": "frontend-web-app",
      "contributedHealthState": "Degraded",
      "tags": {
        "team": "data-platform"
      },
      "nonContributingDependencyNames": [],
      "evidence": {
        "healthState": "Degraded",
        "outcome": "ContributingInputsAndAggregation",
        "determiningInputCategories": ["Dependency"],
        "signals": [],
        "dependencies": [
          {
            "entityName": "orders-storage",
            "contributedHealthState": "Degraded",
            "boundary": "MaxDepth"
          }
        ],
        "signalGroupAggregations": []
      }
    }
  ],
  "partial": []
}
```

No `nextLink` means the bounded diagnosis has been delivered. Depth does not reset between pages: `orders-storage` lies beyond the requested depth and is marked `MaxDepth`, without making the result partial. The caller can route the database investigation to `data-platform` while separately investigating the frontend signal; the healthy backend is not a causal contributor.

`status` and `partial` must be inspected on every page. Genuinely unavailable or capped evidence within scope produces `Partial` and reason details, even if other pages are `Complete`; ordinary page breaks do not. For a concrete unavailable-signal response, see [the partial diagnosis example](examples/2026-10-01-preview/Entity_ListDiagnosis_Partial.json).

All pages preserve the same as-of time. When `timestamp` is omitted, the first page resolves `observedAt` and continuations preserve it. This is not an immutable snapshot: late-arriving data can still affect later reads. MCP integrations should preserve the page metadata when presenting evidence to an agent, rather than returning only the flattened fragments.

## Compare incident impact against the configured health objective

After assessing the incident, the engineer needs to distinguish a short-term objective breach from the service's longer-term health. A single health-analysis request compares the last 24 hours with the last seven days.

**Prerequisites:** The frontend entity has a configured 95% Health Objective and retained health-state history covering both windows. The caller has Microsoft Entra authorization for the data-plane endpoint. The windows are within the last 30 days.

```http
GET /api/entities/frontend-web-app/healthAnalysis?api-version=2026-10-01-preview&endAt=2026-11-18T00%3A00%3A00Z&lookbacks=PT24H&lookbacks=P7D&timestamp=2026-11-18T00%3A00%3A00Z
Accept: application/json

HTTP/1.1 200 OK
Content-Type: application/json

{
  "value": [
    {
      "lookback": "PT24H",
      "startAt": "2026-11-17T00:00:00Z",
      "endAt": "2026-11-18T00:00:00Z",
      "stateDurations": {
        "healthy": "PT22H30M",
        "degraded": "PT1H",
        "unhealthy": "PT30M",
        "unknown": "PT0S"
      },
      "objective": {
        "timestamp": "2026-11-18T00:00:00Z",
        "evaluationStatus": "Complete",
        "healthObjective": 95,
        "allowedNonHealthyPercent": 5,
        "actualNonHealthyPercent": 6.25,
        "exceededNonHealthyPercent": 25,
        "allowedNonHealthyDuration": "PT1H12M",
        "actualNonHealthyDuration": "PT1H30M",
        "exceededNonHealthyDuration": "PT18M",
        "isMet": false
      }
    },
    {
      "lookback": "P7D",
      "startAt": "2026-11-11T00:00:00Z",
      "endAt": "2026-11-18T00:00:00Z",
      "stateDurations": {
        "healthy": "P6DT22H",
        "degraded": "PT1H30M",
        "unhealthy": "PT30M",
        "unknown": "PT0S"
      },
      "objective": {
        "timestamp": "2026-11-18T00:00:00Z",
        "evaluationStatus": "Complete",
        "healthObjective": 95,
        "allowedNonHealthyPercent": 5,
        "actualNonHealthyPercent": 1.19,
        "exceededNonHealthyPercent": 0,
        "allowedNonHealthyDuration": "PT8H24M",
        "actualNonHealthyDuration": "PT2H",
        "exceededNonHealthyDuration": "PT0S",
        "isMet": true
      }
    }
  ]
}
```

Supply `lookbacks` as repeated query parameters, not a comma-separated string. A request accepts one through ten unique, positive fixed ISO 8601 durations, with each window starting within the last 30 days. Results follow the requested lookback order. `endAt` anchors the analysis windows; `timestamp` selects the entity configuration supplying the Health Objective, not a replacement end time.

The 24-hour window contains 90 minutes of Non-Healthy time against a 72-minute allowance: the objective was missed by 18 minutes, or 25% of the allowance. `exceededNonHealthyPercent` is the relative percentage above the allowance, not a percentage-point difference. The seven-day window remains within its allowance, so the engineer can prioritize the recent regression without misreporting a week-long breach. Non-Healthy time includes Degraded, Unhealthy, and Unknown.

Use the returned `isMet` rather than recomputing it from rounded percentages. If `evaluationStatus` is `InsufficientCoverage` or `NotConfigured`, the result is inconclusive and `isMet` is omitted; the caller must not interpret that omission as success.
