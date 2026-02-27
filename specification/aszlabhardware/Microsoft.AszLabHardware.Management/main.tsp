import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./ApiVersion.tsp";
import "./Operations.tsp";
import "./Resources/LabServerV1.tsp";
import "./Resources/Server.tsp";
import "./Resources/Reservation.tsp";
import "./Resources/Pool.tsp";
import "./Resources/Lab.tsp";
import "./Resources/Lab/LabServer.tsp";
import "./Resources/Pool/PoolServer.tsp";
import "./Resources/Reservation/ReservationServer.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "AszLabHardware Resource Provider" })
@versioned(AszLabHardwareCurrentVersion)
namespace Microsoft.AszLabHardware;
