import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.IoTFirmwareDefense, "IoTFirmwareDefenseMgmt", "python");

@@clientName(Microsoft.IoTFirmwareDefense,
  "IoTFirmwareDefenseMgmtClient",
  "java"
);

// flatten
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.TrackedResource.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ProxyResourceUpdateModel.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.BinaryHardeningResource.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.CryptoCertificateResource.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.CryptoKeyResource.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.CveResource.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.Firmware.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.PasswordHashResource.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.SbomComponentResource.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.UsageMetric.properties,
  "java,python"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Microsoft.IoTFirmwareDefense.FirmwareUpdateDefinition.properties,
  "java,python"
);
