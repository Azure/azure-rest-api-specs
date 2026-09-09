---
# No `on:` here. This is a shared component meant to be imported.
description: Canonical model configuration for the ARM API Reviewer workflow
env:
  ARM_API_REVIEWER_MODEL: &arm-api-reviewer-model gpt-5.6-sol?effort=high
engine:
  model: *arm-api-reviewer-model
safe-outputs:
  threat-detection:
    engine:
      id: copilot
      model: *arm-api-reviewer-model
---
