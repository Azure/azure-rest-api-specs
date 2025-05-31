import "../../models/exadata/systemVersions.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@armResourceOperations
interface SystemVersions extends OracleLocationBasedResource<SystemVersion> {}
