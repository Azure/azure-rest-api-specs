import "./Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Private link resource.")
@parentResource(AssessmentProject)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
    @doc("Private link resource ARM name")
    @key("privateLinkResourceName")
    @segment("privateLinkResources")
    @path
    name: string;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties extends AzureResourceProperties {
    @doc("The private link resource required member names.")
    @visibility("read")
    requiredMembers?: string[];

    @doc("Required DNS zone names of the the private link resource.")
    @visibility("read")
    requiredZoneNames?: string[];

    @doc("The private link resource group id.")
    @visibility("read")
    groupId?: string;
}
