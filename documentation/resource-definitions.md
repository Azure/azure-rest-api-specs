# Resource definitions 

## V1 version
If V1 version of Resource is needed, please add the following in the `definitions` section of swagger spec.

```
	"Resource": {
          "properties": {
            "id": {
              "readOnly": true,
              "type": "string",
              "description": "Resource Id"
            },
            "name": {
              "readOnly": true,
              "type": "string",
              "description": "Resource name"
            },
            "type": {
              "readOnly": true,
              "type": "string",
              "description": "Resource type"
            },
            "location": {
              "type": "string",
              "description": "Resource location"
            },
            "tags": {
              "type": "object",
              "additionalProperties": {
                "type": "string"
              },
              "description": "Resource tags"
            }
          },
          "required": [
            "location"
          ],
          "x-ms-azure-resource": true
        }
```

## V2 version
If V2 version of Resource is needed, please add the following in the `definitions` section of swagger spec.

```
	"Resource": {
      "properties": {
        "id": {
          "readOnly": true,
          "type": "string",
          "description": "Resource Id"
        },
        "name": {
          "readOnly": true,
          "type": "string",
          "description": "Resource name"
        },
        "type": {
          "readOnly": true,
          "type": "string",
          "description": "Resource type"
        },
        "location": {
          "type": "string",
          "description": "Resource location"
        },
        "tags": {
          "type": "object",
          "additionalProperties": {
            "type": "string"
          },
          "description": "Resource tags"
        },
        "sku": {
          "$ref": "#/definitions/Sku",
          "description": "The sku of the created namespace"
        }
      },
	"Sku": {
      "properties": {
        "name": {
          "type": "string",
          "description": "Name of the notification hub sku",
          "enum": [
            "Free",
            "Basic",
            "Standard"
          ],
          "x-ms-enum": {
            "name": "SkuName",
            "modelAsString": true
          }
        },
        "tier": {
          "type": "string",
          "description": "The tier of particular sku"
        },
        "size": {
          "type": "string",
          "description": "The Sku size"
        },
        "family": {
          "type": "string",
          "description": "The Sku Family"
        },
        "capacity": {
          "type": "integer",
          "description": "The capacity of the resource"
        }
      },
      "required": [
        "name"
      ],
      "description": "The Sku description for a namespace"
    }
  }
```