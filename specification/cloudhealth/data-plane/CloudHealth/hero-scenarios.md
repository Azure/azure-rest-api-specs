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
