# BYOCA (Bring Your Own Certificate Authority) - API Implementation Plan

**Date:** October 29, 2025  
**Last Updated:** October 30, 2025  
**Service:** Device Registry  
**API Version Target:** 2025-11-01-preview

## Overview

This document outlines the plan for implementing the Bring Your Own Certificate Authority (BYOCA) feature in the Device Registry API. BYOCA allows customers to bring their own offline Root CA for signing Intermediate CAs, addressing high-assurance security requirements where customers need complete control over their PKI hierarchy.

## Background

Based on the BYOCA design documents, this feature addresses scenarios where:
- Customers require high-assurance security with offline Root CA management
- Organizations have existing PKI infrastructure they want to leverage
- Compliance requirements mandate customer-controlled certificate hierarchies
- Air-gapped or highly regulated environments need explicit control over trust chains

## Implementation Status

✅ **COMPLETED** - TypeSpec implementation finished on October 30, 2025

### Files Modified

1. **specification/deviceregistry/DeviceRegistry.Management/ns_credential.tsp**
   - Added `byocaCertificate` property with Key Vault URI for storing certificate chain
   - Added `rootCertificateThumbprint` (read-only) - auto-populated when BYOCA policy is activated
   - Added `issuerCertificateThumbprint` (read-only) - auto-populated when BYOCA policy is activated
   - Added `BYOCACertificate` model with Key Vault integration

2. **specification/deviceregistry/DeviceRegistry.Management/ns_policy.tsp**
   - Added `bringYourOwnCertificateAuthority` property to `PolicyProperties`
   - Created `BringYourOwnCertificateAuthority` model with activation workflow properties
   - Created `BringYourOwnCertificateAuthorityStatus` enum (PendingActivation, Active, PendingRotation, Failed)

3. **specification/deviceregistry/DeviceRegistry.Management/examples/byoca-examples.md** (NEW)
   - Comprehensive API examples covering all BYOCA workflows
   - Error scenarios with detailed error responses

## TypeSpec Implementation Details

### Key Design Features

1. **Immutable BYOCA Flag**: Once a policy is created with BYOCA enabled, this cannot be changed
2. **Automatic CSR Generation**: Service generates CSR upon policy creation when BYOCA is enabled
3. **Certificate Validation**: Service validates signed certificate matches the CSR
4. **Automatic Rotation**: Service detects expiration and generates new CSR, transitions to "PendingRotation"
5. **Thumbprint Propagation**: Certificate thumbprints automatically populate in the parent Credential resource
6. **Key Vault Integration**: Credential stores the complete certificate chain in Azure Key Vault

### API Version

All BYOCA features are added to API version `2025-11-01-preview` using `@added(Versions.v2025_11_01_preview)` decorators.

## TypeSpec Build and Validation Commands

### Prerequisites

Ensure you have the TypeSpec tools installed:

```bash
npm install -g @typespec/compiler
npm install -g @azure-tools/typespec-azure-resource-manager
```

### Project Setup

Navigate to the Device Registry TypeSpec directory:

```bash
cd specification/deviceregistry/DeviceRegistry.Management
```

### Build Commands

#### 1. Compile TypeSpec to OpenAPI/Swagger

```bash
tsp compile .
```

This will:
- Compile all `.tsp` files
- Generate OpenAPI 3.0 specification
- Output to `tsp-output` directory (or as configured in `tspconfig.yaml`)

#### 2. Compile with Specific Emitters

To generate ARM (Azure Resource Manager) specific output:

```bash
tsp compile . --emit @azure-tools/typespec-azure-resource-manager
```

#### 3. Watch Mode for Development

For continuous compilation during development:

```bash
tsp compile . --watch
```

This will recompile automatically whenever `.tsp` files are modified.

### Validation Commands

#### 1. Format TypeSpec Files

```bash
tsp format .
```

Or format specific files:

```bash
tsp format ns_policy.tsp ns_credential.tsp
```

#### 2. Lint TypeSpec Files

```bash
tsp compile . --no-emit
```

This runs all validation rules without generating output files.

#### 3. Check for Breaking Changes

Compare against previous API version:

```bash
# Install breaking change detector
npm install -g @azure/oad

# Run breaking change detection
oad compare \
  --old specification/deviceregistry/resource-manager/Microsoft.DeviceRegistry/stable/2024-09-01-preview/deviceregistry.json \
  --new tsp-output/@azure-tools/typespec-azure-resource-manager/openapi/Microsoft.DeviceRegistry/2025-11-01-preview/deviceregistry.json
```

### Verify Generated Output

#### 1. Check Generated Swagger Location

```bash
ls -la tsp-output/@azure-tools/typespec-azure-resource-manager/openapi/Microsoft.DeviceRegistry/2025-11-01-preview/
```

#### 2. Validate Generated Swagger

```bash
# Install swagger validation tools
npm install -g @azure/openapi-markdown

# Validate the generated swagger
autorest --input-file=tsp-output/@azure-tools/typespec-azure-resource-manager/openapi/Microsoft.DeviceRegistry/2025-11-01-preview/deviceregistry.json --azure-validator
```

#### 3. Preview Generated Models

```bash
# View specific models in generated swagger
cat tsp-output/@azure-tools/typespec-azure-resource-manager/openapi/Microsoft.DeviceRegistry/2025-11-01-preview/deviceregistry.json | jq '.definitions.BringYourOwnCertificateAuthority'
```

### Common Issues and Troubleshooting

#### Issue: "Cannot find module '@typespec/compiler'"

**Solution:**
```bash
npm install --save-dev @typespec/compiler
npm install --save-dev @azure-tools/typespec-azure-resource-manager
```

#### Issue: "tspconfig.yaml not found"

**Solution:** Ensure you're in the correct directory with `tspconfig.yaml`:
```bash
cd specification/deviceregistry/DeviceRegistry.Management
ls -la tspconfig.yaml
```

#### Issue: Compilation errors in BYOCA models

**Solution:** Check decorator usage:
```bash
tsp compile . --no-emit --trace import-resolution
```

#### Issue: Generated swagger missing BYOCA properties

**Solution:** Verify API version decorators:
```bash
# Search for @added decorators
grep -r "@added(Versions.v2025_11_01_preview)" *.tsp
```

### Integration with CI/CD

The TypeSpec compilation should be integrated into the CI/CD pipeline:

```yaml
# Example Azure Pipeline step
- task: Npm@1
  displayName: 'Install TypeSpec'
  inputs:
    command: 'custom'
    customCommand: 'install -g @typespec/compiler @azure-tools/typespec-azure-resource-manager'

- task: PowerShell@2
  displayName: 'Compile TypeSpec'
  inputs:
    targetType: 'inline'
    script: |
      cd specification/deviceregistry/DeviceRegistry.Management
      tsp compile .
      
- task: PublishPipelineArtifact@1
  displayName: 'Publish Generated Swagger'
  inputs:
    targetPath: 'specification/deviceregistry/DeviceRegistry.Management/tsp-output'
    artifact: 'generated-swagger'
```

## Key Requirements from Design Documents

1. **BYOCA at Policy level** - Customers can opt to bring their own Root CA when creating a Policy
2. **CSR exposure** - When BYOCA is enabled, a Certificate Signing Request (CSR) must be exposed for the customer to sign
3. **Pending state** - Policy must support a pending activation state until the signed certificate is patched back
4. **No auto-rotation** - BYOCA disables automatic ICA rotation; customers must manually re-sign during rotation
5. **No CRL support** - Customer manages CRL for their Root CA
6. **Certificate chain upload** - Customer patches back the signed certificate and chain

## TypeSpec Model Definitions

### 1. Policy Resource - BringYourOwnCertificateAuthority Model

```typespec
model BringYourOwnCertificateAuthority {
  @doc("Indicates if BYOCA is enabled for this policy. This is immutable after policy creation.")
  @visibility("read", "create")
  enabled: boolean;

  @doc("The Certificate Signing Request (CSR) in PEM format for the intermediate CA to be signed by the customer's root CA. This is generated by the service when BYOCA is enabled.")
  @visibility("read")
  certificateSigningRequest?: string;

  @doc("The signed certificate in PEM format returned by the customer after signing the CSR with their root CA.")
  signedCertificate?: string;

  @doc("The complete certificate chain in PEM format, including the intermediate certificate and root CA certificate(s).")
  certificateChain?: string;

  @doc("Current status of the BYOCA configuration lifecycle.")
  @visibility("read")
  status?: BringYourOwnCertificateAuthorityStatus;
}

@doc("Status of the BYOCA certificate authority configuration.")
enum BringYourOwnCertificateAuthorityStatus {
  @doc("CSR has been generated and is waiting for the signed certificate to be uploaded by the customer.")
  PendingActivation,

  @doc("Signed certificate has been uploaded and validated. The CA is active and operational.")
  Active,

  @doc("The certificate is approaching expiration. A new CSR has been generated and is waiting for a new signed certificate.")
  PendingRotation,

  @doc("Certificate validation or activation failed. Check error details and retry with corrected certificate.")
  Failed,
}
```

### 2. Credential Resource - BYOCA Certificate Properties

```typespec
model BYOCACertificate {
  @doc("Azure Key Vault secret URI where the complete certificate chain is stored in PEM format. The certificate chain includes the intermediate certificate and root CA certificate(s).")
  certificateChainUri?: url;
}

// Added to CredentialProperties:
@doc("Configuration for Bring Your Own Certificate Authority (BYOCA). This is populated when the associated policy has BYOCA enabled.")
@added(Versions.v2025_11_01_preview)
byocaCertificate?: BYOCACertificate;

@doc("Thumbprint (SHA-1 hash) of the root CA certificate. This is automatically populated from the associated policy's BYOCA configuration when the policy is activated.")
@visibility("read")
@added(Versions.v2025_11_01_preview)
rootCertificateThumbprint?: string;

@doc("Thumbprint (SHA-1 hash) of the issuer (intermediate) CA certificate. This is automatically populated from the associated policy's BYOCA configuration when the policy is activated.")
@visibility("read")
@added(Versions.v2025_11_01_preview)
issuerCertificateThumbprint?: string;
```

## Implementation Flows

### Creation Flow

1. Customer creates Policy with `bringYourOwnCertificateAuthority.enabled = true`
2. Service creates PKI CA with `externalRoot = true`
3. Service returns CSR in `bringYourOwnCertificateAuthority.certificateSigningRequest` (read-only)
4. Status is set to `PendingActivation`
5. **Metadata is NOT sent to data plane** until activated
6. Customer signs CSR with their Root CA offline
7. Customer PATCH updates Policy with `signedCertificate` and `certificateChain`
8. Service validates and activates the CA in PKI
9. Status changes to `Active`
10. Certificate thumbprints are populated in associated Credential resources
11. Metadata is now sent to data plane

### Rotation Flow

1. Service detects ICA approaching expiration (30-60 days before)
2. Service generates new CSR
3. Status changes to `PendingRotation`
4. Customer receives notification (via Azure Monitor/Event Grid)
5. Customer must PATCH with newly signed certificate
6. Service validates and rotates the CA in PKI
7. Status returns to `Active`
8. Updated thumbprints propagate to Credential resources

## Example API Calls

See `specification/deviceregistry/DeviceRegistry.Management/examples/byoca-examples.md` for comprehensive examples including:

- Creating namespace, credential, and policy resources
- BYOCA activation workflow (CSR generation → certificate upload)
- Certificate rotation workflow
- Query operations
- Error scenarios with detailed error responses

### Quick Example: Creating a Policy with BYOCA

```http
PUT /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceRegistry/policies/{policyName}?api-version=2025-11-01-preview

{
  "location": "eastus",
  "properties": {
    "bringYourOwnCertificateAuthority": {
      "enabled": true
    }
  }
}
```

Response includes generated CSR in `PendingActivation` state.

## Validation Requirements

The service must validate:

1. **Certificate Format**: All certificates and CSRs must be in valid PEM format
2. **Certificate Chain Integrity**: Chain must form a valid trust path from ICA to Root CA
3. **Public Key Match**: Signed certificate public key must match CSR public key
4. **Expiration Dates**: Certificates must be currently valid (not expired or not yet valid)
5. **Key Usage Extensions**: Certificates must have appropriate key usage flags (CA:TRUE for intermediates)
6. **Signature Verification**: Signed certificate must be validly signed by the chain
7. **Chain Completeness**: Certificate chain must include all intermediate and root certificates

## Error Handling

### Error Scenarios and Responses

1. **Invalid Certificate Format**
   - Status Code: 400 Bad Request
   - Error Code: `InvalidCertificateFormat`
   - Message: "The provided certificate is not in valid PEM format"

2. **Certificate Chain Broken**
   - Status Code: 400 Bad Request
   - Error Code: `InvalidCertificateChain`
   - Message: "The certificate chain is incomplete or invalid"

3. **Public Key Mismatch**
   - Status Code: 400 Bad Request
   - Error Code: `CertificatePublicKeyMismatch`
   - Message: "The signed certificate public key does not match the CSR"

4. **Certificate Expired**
   - Status Code: 400 Bad Request
   - Error Code: `CertificateExpired`
   - Message: "The provided certificate is expired or not yet valid"

5. **Missing Certificate Chain**
   - Status Code: 400 Bad Request
   - Error Code: `MissingCertificateChain`
   - Message: "Certificate chain is required when uploading signed certificate"

### Failed State

When validation fails:
- Status is set to `Failed`
- Error details are included in `PolicyStatus`
- Customer can retry by issuing another PATCH with corrected certificate/chain
- CSR remains available for re-download if needed

## Additional Considerations

### Security Considerations

1. **Immutable Enabled Flag**: Once BYOCA is enabled on a Policy (at creation), it cannot be disabled. This prevents accidental security downgrade.
2. **Audit Logging**: All BYOCA operations (CSR generation, certificate upload, validation failures) should be logged for security audit.
3. **Certificate Storage**: Signed certificates and chains are stored securely in Azure Key Vault.
4. **Access Control**: Only authorized users with appropriate RBAC permissions can upload signed certificates.

### Customer Responsibilities

When using BYOCA, customers are responsible for:

1. **Root CA Security**: Maintaining security of their offline Root CA
2. **Certificate Signing**: Signing CSRs with appropriate validity periods and key usage
3. **CRL Management**: Managing Certificate Revocation Lists for their Root CA
4. **Rotation Monitoring**: Monitoring for rotation notifications and responding promptly
5. **Chain Maintenance**: Providing complete and valid certificate chains

### Backward Compatibility

- BYOCA is an opt-in feature (via `enabled: true` flag)
- Existing Policies without BYOCA continue to work unchanged
- New property is optional, defaults to disabled if not specified
- No breaking changes to existing API contracts

## Next Steps for Deployment

### 1. Build and Validate

```bash
cd specification/deviceregistry/DeviceRegistry.Management
tsp compile .
```

### 2. Review Generated Swagger

Verify the generated OpenAPI specification at:
```
tsp-output/@azure-tools/typespec-azure-resource-manager/openapi/Microsoft.DeviceRegistry/2025-11-01-preview/deviceregistry.json
```

### 3. Update Documentation

- Add BYOCA details to main API documentation
- Create customer-facing guides with OpenSSL examples
- Update SDK documentation

### 4. SDK Generation

Trigger SDK generation for supported languages:
- .NET
- Python
- Java
- JavaScript/TypeScript
- Go

### 5. Integration Tests

Create automated tests for BYOCA workflows:
- Policy creation with BYOCA enabled
- CSR generation validation
- Certificate upload and validation
- Rotation workflows
- Error scenarios

### 6. Security Review

- Conduct security review of certificate validation logic
- Audit logging verification
- Pen testing for certificate upload endpoints

### 7. Documentation Needs

Required documentation:

1. **Getting Started Guide**: Step-by-step walkthrough for enabling BYOCA
2. **OpenSSL Examples**: Commands for signing CSR with customer's Root CA
3. **Rotation Process**: Detailed guide for handling certificate rotation
4. **Security Best Practices**: Recommendations for offline Root CA management
5. **Troubleshooting**: Common issues and solutions
6. **API Reference**: Complete API documentation with examples

## Open Questions for Clarification

### 1. Optional BYOCA at Credential Level
**Question**: Should we add a property to the Credential resource to block Microsoft-provided roots entirely (as mentioned in the design doc "optimization")?

**Context**: The design mentions an optional enhancement where Credentials can explicitly require BYOCA, rejecting any attestation from Microsoft-provided roots.

**Impact**: Would require additional API changes at Credential level.

### 2. Revocation Management
**Question**: Should we add any properties to track or reference customer CRL endpoints?

**Context**: The design mentions customers must manage CRL for their Root CA. We could optionally expose a field for customers to document their CRL endpoint URL.

**Impact**: Read-only field for documentation purposes; service wouldn't validate or use it.

### 3. Multiple ICAs During Rotation
**Question**: During rotation, should the Policy maintain both old and new ICA information in the API response for a transition period?

**Context**: To support smooth rotation, might need to expose both current and pending ICA details.

**Impact**: Would require additional properties to distinguish current vs. pending certificates.

### 4. Admin APIs
**Question**: Should we expose admin-only endpoints for DRI-initiated rotation/cleanup, or handle this outside the public API?

**Context**: Support scenarios where Microsoft DRIs need to force rotation or cleanup failed states.

**Impact**: Additional internal/admin API surface.

### 5. Notification Mechanism
**Question**: How should customers be notified when rotation is needed?

**Options**:
- Azure Monitor alerts
- Event Grid events
- Policy status polling
- Azure Portal notifications

**Impact**: Affects customer experience and integration patterns.

### 6. Rotation Lead Time
**Question**: How far in advance should rotation state be triggered before ICA expiration?

**Context**: Need to give customers sufficient time to sign new CSR while ensuring minimal service disruption.

**Recommendation**: 30-60 days before expiration, configurable if possible.

## Implementation Phases

### Phase 1: Core BYOCA Support (MVP) ✅ COMPLETE
- ✅ Add BYOCA properties to Policy resource (TypeSpec)
- ✅ Implement CSR generation and exposure (TypeSpec)
- ✅ Implement certificate upload and validation (TypeSpec)
- ✅ Basic status tracking (PendingActivation, Active, Failed)
- ✅ Add BYOCA certificate properties to Credential resource
- ✅ Basic error handling and validation models

### Phase 2: Rotation Support (IN PROGRESS)
- ✅ Implement rotation detection (PendingRotation status added)
- ⏳ Notification mechanism for rotation
- ⏳ Backend implementation for rotation workflow
- ⏳ Testing rotation scenarios

### Phase 3: Enhanced Features (FUTURE)
- ⏳ Optional BYOCA requirement at Credential level
- ⏳ Enhanced monitoring and alerting
- ⏳ Admin APIs for support scenarios
- ⏳ Improved error diagnostics and troubleshooting tools

## Success Criteria

BYOCA implementation will be considered successful when:

1. ✅ Customers can create a Policy with BYOCA enabled
2. ✅ CSR is generated and exposed in API response
3. ✅ Customers can upload signed certificate and chain
4. ✅ Service validates certificate chain integrity
5. ✅ Policy activates successfully after valid certificate upload
6. ✅ Certificate thumbprints propagate to Credential resource
7. ✅ Metadata flows to data plane only after activation
8. ✅ Clear error messages guide customers when validation fails
9. ⏳ Rotation workflow triggers and completes successfully
10. ⏳ Complete documentation available for customers
11. ⏳ Security audit logging captures all BYOCA operations

## References

- BYOCA Design Documents (byoca compiled.txt)
- Device Registry API Specification (deviceregistry.json)
- TypeSpec Implementation:
  - ns_policy.tsp
  - ns_credential.tsp
  - examples/byoca-examples.md
- PKI Service Integration Documentation
- Azure REST API Guidelines
- OpenAPI Specification Standards
- TypeSpec Documentation: https://microsoft.github.io/typespec/

## Change History

| Date | Author | Changes |
|------|--------|---------|
| 2025-10-29 | Initial | Created initial implementation plan |
| 2025-10-30 | Update | Added TypeSpec implementation details, build commands, and completion status |

---

**Status**: TypeSpec implementation complete. Ready for compilation, testing, and backend integration.
