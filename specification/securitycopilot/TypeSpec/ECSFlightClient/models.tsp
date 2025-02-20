import "@typespec/rest";
import "@typespec/http";
import "../SharedModels.tsp";
import "../SharedEnums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace ECSFlightClient
{
    @doc("ECSFlightIdentity object containing properties for ECSFlight.")
	model ECSFlightIdentity {
        @doc("Tenant id of the ECSFlight.")
		tenantId: string;
        @doc("User id of the ECSFlight.")
        userId: string;
        @doc("workspace of the ecs flight")
        workspace: string;
        @doc("Geography of the ECSFlight.")
        geo: string
        @doc("GPU geograpthy of the ECSFlight")
        gpuGeo: string
        @doc("Region of the ECSFlight.")
        region: string;
        @doc("Ring of the ECSFlight.")
        ring: string;
    }
}
