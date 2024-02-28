const fs = require("fs");
const path = require("path");

// Function to merge OpenAPI specifications
function mergeOpenAPISpecs(filePaths, basePath = ".") {
  let mergedSpec = {};

  filePaths.forEach((filePath) => {
    let rawData = fs.readFileSync(path.resolve(basePath, filePath));
    let spec = JSON.parse(rawData);

    mergedSpec = mergeObjects(mergedSpec, spec);
  });

  return mergedSpec;
}

// Utility function to merge two objects
function mergeObjects(obj1, obj2) {
  for (let key in obj2) {
    if (obj2.hasOwnProperty(key)) {
      if (
        typeof obj2[key] === "object" &&
        obj2[key] !== null &&
        !(obj2[key] instanceof Array)
      ) {
        if (!obj1[key]) {
          obj1[key] = {};
        }
        mergeObjects(obj1[key], obj2[key]);
      } else {
        obj1[key] = obj2[key];
      }
    }
  }
  return obj1;
}

function formatKey(key) {
  // This is necessary to deal with nonstandard casing in the original specs
  return key.charAt(0).toLowerCase() + key.slice(1);
}

// Function to sort components of the OpenAPI specification
function sortObjectByKeys(obj) {
  if (Array.isArray(obj)) {
    // Sort arrays directly
    obj.sort();
  } else if (typeof obj === "object" && obj !== null) {
    // Sort other objects
    let sortedObj = {};
    Object.keys(obj)
      .sort(function (a, b) {
        return a.toLowerCase().localeCompare(b.toLowerCase());
      })
      .forEach((key) => {
        sortedObj[formatKey(key)] = sortObjectByKeys(obj[key]);
      });

    return sortedObj;
  }

  return obj;
}

const basePath = "./resource-manager/Microsoft.Chaos/stable/2024-01-01";

// Example usage
let mergedSpec = mergeOpenAPISpecs(
  [
    "capabilities.json",
    "capabilityTypes.json",
    "experiments.json",
    "operationStatuses.json",
    "operations.json",
    "targetTypes.json",
    "targets.json",
    "types/capabilities.json",
    "types/capabilityTypes.json",
    "types/common.json",
    "types/experiments.json",
    "types/targetTypes.json",
    "types/targets.json",
  ],
  basePath,
);

let sortedSpec = sortObjectByKeys(mergedSpec);
fs.writeFileSync(
  path.resolve("./", "openapi-merged.json"),
  JSON.stringify(sortedSpec, null, 2),
);

let rawData = fs.readFileSync(path.resolve(basePath, "openapi.json"));
let newSpec = JSON.parse(rawData);
let newSortedSpec = sortObjectByKeys(newSpec);
fs.writeFileSync(
  path.resolve("./", "openapi-sorted.json"),
  JSON.stringify(newSortedSpec, null, 2),
);
