# Proactive Secret Detection (SEC-SECRET-DETECT)

Reviewers **MUST** proactively inspect every string property to determine whether it could contain a secret, credential, or sensitive token -- even when the property is not explicitly annotated as a secret.

**Authoritative references:**
- [Azure Resource Provider Contract -- Secret Handling](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md)
- [Azure REST API Guidelines -- Handling Secrets](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)

## Detection Signals

Flag a string property as a potential secret if **any** of the following signals are present:

### 1. Property Name Match (case-insensitive)

`key`, `token`, `secret`, `password`, `credential`, `connectionString`, `accessKey`, `sharedKey`, `masterKey`, `apiKey`, `sas`, `signature`, `cert`, `certificate`, `privateKey`, `passphrase`, `accountKey`, `ingestionKey`, `instrumentationKey`, `encryptionKey`, `symmetricKey`, `primaryKey`, `secondaryKey`, `clientSecret`.

### 2. Description / Doc Comment Content

Mentions authentication, authorization, signing, bearer, opaque credential, API token, SaaS token, ingestion key, shared access signature, or connection string.

### 3. Example Values

Resemble tokens, base64-encoded blobs, or long random strings in `x-ms-examples`, inline `example`/`default` fields, or TypeSpec example files.

### 4. Suppressed Lint Rules

`#suppress` directives (TypeSpec) or `suppress` entries (readme.md) referencing `secret-prop` or similar secret-related lint rules that are being silenced rather than addressed. Suppressing a secret lint rule is a **strong signal** that the property IS a secret and the annotation was skipped.

## Required Action

If **any** signal is present and the property lacks the appropriate secret annotation, flag it as a **blocking security issue**.

- **Rule ID:** `SEC-SECRET-DETECT`
- **Severity:** Blocking

## Fix by Format

### OpenAPI JSON (Swagger)

Add `"x-ms-secret": true` to the property definition:

```json
"administratorPassword": {
  "type": "string",
  "x-ms-secret": true,
  "description": "The administrator password for the server."
}
```

### TypeSpec

Add the `@secret` decorator to the property and remove any `#suppress` directive for `secret-prop`:

```tsp
/** The administrator password for the server. */
@secret
administratorPassword?: string;
```

**Bad** (suppressing instead of annotating):
```tsp
#suppress "@azure-tools/typespec-azure-core/secret-prop" "..."
administratorPassword?: string;
```

## Secret Handling Rules

Secrets **MUST NOT** be exposed in GET, PUT, or PATCH responses. For properties that accept a secret on write:

1. Return `null` or omit the property in GET/PUT/PATCH responses.
2. If the secret needs to be retrievable, expose it via a **POST action** (e.g., `listKeys`) for granular RBAC control.
3. POST actions named `list*` (e.g., `listKeys`, `listConnectionStrings`) are automatically exposed to ARM deployment templates via the `list()` template function.

When flagging, always explain which signal(s) triggered the detection (name match, description content, example pattern, or suppression).
