import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.AppLink;

@doc("AppLink available version resource")
@parentResource(ArmLocationResource<"Subscription">)
model AvailableVersion is ProxyResource<AvailableVersionProperties> {
  ...ResourceNameParameter<AvailableVersion>;
}

@doc("AppLink available version properties")
model AvailableVersionProperties {
  @doc("Kubernetes version")
  kubernetesVersion: string;

  @doc("Fully managed versions")
  fullyManagedVersions: FullyManagedVersions;

  @doc("Self managed versions")
  selfManagedVersions: SelfManagedVersions;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Fully managed versions")
model FullyManagedVersions {
  @doc("Release channels")
  @identifiers(#["releaseChannel", "version"])
  releaseChannels: ReleaseChannelInfo[];
}

@doc("Self managed versions")
model SelfManagedVersions {
  @doc("Istio versions")
  @identifiers(#["version", "upgrades"])
  versions: VersionInfo[];
}

@doc("Release channel information")
model ReleaseChannelInfo {
  @doc("Release channel")
  releaseChannel: string;

  @doc("Istio version behind release channel")
  version: string;
}

@doc("Version information")
model VersionInfo {
  @doc("Istio version")
  version: string;

  @doc("Available upgrades")
  upgrades: string[];
}

@armResourceOperations
interface AvailableVersions {
  listByLocation is ArmResourceListByParent<
    Resource = AvailableVersion,
    Parameters = {
      @doc("Kubernetes version to filter profiles")
      @query("kubernetesVersion")
      kubernetesVersion?: string;
    }
  >;
}
