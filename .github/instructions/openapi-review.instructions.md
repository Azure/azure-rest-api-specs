---
applyTo: "**/*.json"
---

# Copilot Review Instructions for reviewing OpenAPI v2

Please review OpenAPI v2 (Swagger) definition files with the following in mind:

## API Guidelines Alignment

- Ensure the API follows https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md.
- Validate naming conventions for paths, parameters, and schemas.
- Confirm consistent use of `x-ms-*` extensions where applicable.
- Check for proper use of `operationId`, `description`, and `summary` fields.

## Versioning

- Ensure the API version is clearly defined and follows the `YYYY-MM-DD` format.
- Confirm that breaking changes are not introduced in minor version updates.

## Security

- Validate that security definitions (e.g., OAuth2 scopes) are present and correctly applied.
- Ensure no unsecured endpoints are exposed unless explicitly documented.

## Documentation

- Flag missing or vague descriptions for operations, parameters, and responses.
- Recommend examples for request/response bodies where missing.

## Style

- Prefer camelCase for property names.
- Avoid abbreviations unless industry-standard.

Respond in markdown format with clear suggestions and highlight any violations of the guidelines.
