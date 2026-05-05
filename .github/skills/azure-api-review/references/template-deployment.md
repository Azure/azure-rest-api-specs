<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     Derived from:
       - ARM Wiki: api_contracts/guidelines/templatedeployment.md
       - Azure Resource Provider Contract (RPC) v1.0 — PUT Resource
     The upstream documents always take precedence if there is a conflict. -->

# ARM Template Deployment Compatibility Rules (TD001–TD003)

These rules ensure ARM resource APIs are compatible with the ARM
Template Deployment engine used by ARM Templates, Bicep, and Terraform
AzAPI. The deployment engine calls resource provider APIs on behalf of
customers — API designs that violate these rules will break template
deployments.

**Authoritative references:**

- [ARM Wiki — Template Deployment Guidelines](https://armwiki.azurewebsites.net/api_contracts/guidelines/templatedeployment.html)
- [Azure Resource Provider Contract — PUT Resource](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/put-resource.md)

---

## TD001: Use PUT for Resource Provisioning

Resources **MUST** be created via PUT. The ARM Template Deployment
engine provisions resources using PUT. POST-based resource creation
is **not supported** by the template engine and will make the resource
un-deployable via ARM Templates, Bicep, or Terraform AzAPI.

**Exception:** POST may create proxy resources only when the service
generates the resource name. This exception does not apply to tracked
resources.

**Severity:** Required

---

## TD002: PUT Must Be Idempotent

PUT operations **MUST** be idempotent. Sending the same PUT request
multiple times **MUST** produce the same result and **MUST NOT** fail.

**Why:** The ARM Template Deployment engine retries failed PUT requests
and re-executes deployments. A non-idempotent PUT causes deployment
failures on retry, breaks incremental deployments, and makes
What-If predictions inaccurate.

A "re-PUT" — a PUT to an existing resource with the same request
body — **MUST NOT** fail. ARM expects PUT to be usable for both create
and full-resource replacement.

**Severity:** Required

---

## TD003: Preflight Validation Must Be Supported

Resource providers **MUST** support the Preflight API, which the ARM
Template Deployment engine calls **before** executing a deployment. The
Preflight API validates resource PUT payloads and detects errors early
(syntax errors, invalid resource names, quota/capacity issues, SKU
availability, region restrictions, and property validation).

> **Full preflight contract:** See
> [what-if-preflight-compliance.md](what-if-preflight-compliance.md)
> for the complete preflight validation rules (PREFLIGHT-001 through
> PREFLIGHT-005), including response format, error structure, TLE
> handling, and ARM-enforced static validations.

**Severity:** Required
