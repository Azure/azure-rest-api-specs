import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureSphereMgmt;

namespace ClientCustomizations;

@@clientName(Catalogs.uploadImage::parameters.body,
    "upload_image_request",
    "python"
);
