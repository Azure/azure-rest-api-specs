import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service({
    title: "Astronomer.Astro"
})
@versioned(Astronomer.Astro.Versions)
namespace Astronomer.Astro;

@doc("Supported API versions for the Astronomer.Astro resource provider.")
enum Versions {
    @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
    v1_preview: "2023-06-01-preview",
}

@doc("A string that represents a URI.")
scalar Uri extends string;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Organization Resource by Astronomer")
model OrganizationResource is TrackedResource<OrganizationProperties> {
    @key("organizationName")
    @segment("organizations")
    @minLength(4)
    @maxLength(20)
    @doc("Name of the Organizations resource")
    @path
    name: string;
    ...ManagedServiceIdentity;
}

@armResourceOperations
interface Organizations
    extends TrackedResourceOperations<
            OrganizationResource,
            OrganizationProperties
        > {}

@doc("Properties specific to the Astronomer Organization resource")
model OrganizationProperties {
    @visibility("read")
    @doc("Provisioning State of the resource")
    provisioningState?: ResourceProvisioningState;

    @doc("Astronomer Organization properties")
    astronomerOrganizationProperties?: AstronomerOrganizationProperties;
}

@doc("Properties of the Astronomer account")
model AstronomerOrganizationProperties {
    @doc("Astronomer Organization Information")
    organizationInfo?: OrganizationInfo;
}

@doc("Organization Info of the Astronomer account")
model OrganizationInfo{

  @doc("Organization id")
  organizationId?: string;

  @doc("Astronomer account region")
  regionId?: string;
}