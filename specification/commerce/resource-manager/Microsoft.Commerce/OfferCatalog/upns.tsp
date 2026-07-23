import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Commerce;

/**
 * UPN (Unified Product Node) resource.
 *
 * A UPN is a provider-scoped, tenant-level, read-only proxy resource that
 * represents one transactable value-exchange in the Microsoft commercial
 * catalog. It is addressed at `/providers/Microsoft.Commerce/upns/{upnGuid}`.
 */
@tenantResource
model Upn is Azure.ResourceManager.ProxyResource<UpnProperties> {
  ...ResourceNameParameter<
    Resource = Upn,
    KeyName = "upnGuid",
    SegmentName = "upns",
    NamePattern = "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
  >;
}

/** Read-only operations on UPN catalog resources. */
@armResourceOperations
interface Upns {
  /**
   * Get a single UPN resource by its GUID identifier. Returns the identity
   * envelope of the UPN.
   */
  get is Extension.Read<Extension.Tenant, Upn>;
}

@@doc(Upn.name,
  "The GUID identifier of the UPN. Corresponds to the OCP value-exchange productCode."
);
@@doc(Upn.properties, "The properties of the UPN resource.");
