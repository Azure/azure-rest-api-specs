// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;


namespace Microsoft.DevHub;



#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@summary("Generate preview dockerfile and manifests.")
/**
* Generate preview dockerfile and manifests.
*/
@autoRoute
generatePreviewArtifacts is ArmProviderActionSync<Request = ArtifactGenerationProperties,Response = GeneratePreviewArtifactsResponse,Scope = SubscriptionActionScope,Parameters = LocationParameter>