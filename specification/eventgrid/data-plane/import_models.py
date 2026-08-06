import json
import sys

def _extract_description(data):
    desc = data.get("description", None)
    desc = desc.replace('"', '\\"') if desc else desc
    return desc


class CadlEnum:
    def __init__(self, ctx, data, name=None):
        self._ctx = ctx
        enum = data.get("enum", None)
        enum_ext = data.get("x-ms-enum", None)
        self.name = enum_ext["name"] if enum_ext else name
        self.model_as_string = enum_ext.get("modelAsString", False) if enum_ext else False
        self.values = enum

    def to_cadl(self):
        lines = []
        if self.model_as_string:
            lines.append(f"@knownValues({self.name}KV)")
            lines.append(f"model {self.name} is string \x7b\x7d")
            lines.append(f"enum {self.name}KV \x7b")
            for val in self.values:
                lines.append(f"\t{val},")
            lines.append("}")
        else:
            lines.append(f"enum {self.name} \x7b")
            for val in self.values:
                lines.append(f"\t{val},")
            lines.append("}")
        return "\n".join(lines)


class CadlProperty:
    def __init__(self, ctx, name, data, required):
        self._ctx = ctx
        self.name = name
        self.required = required
        self.description = _extract_description(data)
        self.type = self._parse_type(data)

    _STRING_MAP = {
        "date-time": "zonedDateTime",
        "date": "plainDate",
        "time": "plainTime",
        "uuid": "string",  # No uuid type in CADL
    }

    _NUMBER_MAP = {
        "float": "float64",
        "double": "float64"
    }

    _INTEGER_MAP = {
        "int16": "int16",
        "int32": "int32",
        "int64": "int64"
    }

    def _parse_type_format(self, data):
        type = data["type"]
        format = data.get("format", None)
        if type == "string":
            return CadlProperty._STRING_MAP[format] if format else type
        elif type == "number":
            return CadlProperty._NUMBER_MAP[format] if format else type
        elif type == "integer":
            return CadlProperty._INTEGER_MAP[format] if format else type
        elif type == "boolean":
            assert format == None
            return type
        elif type == "object":
            return "Map<string, string>"
        raise TypeError(f"Unexpected type: {type}")

    def _parse_type(self, data):
        ref = data.get("$ref", None)
        enum = data.get("enum", None)
        type = data.get("type", None)
        if ref:
            return ref.rsplit("/", 1)[-1]
        elif enum:
            enum_ext = data.get("x-ms-enum", None)
            self._ctx._models.append(CadlEnum(self._ctx, data))                
            return enum_ext["name"]
        elif type == "array":
            item_data = data["items"]
            item_type = self._parse_type(item_data)
            return f"{item_type}[]"
        else:
            return self._parse_type_format(data)

    def to_cadl(self):
        lines = []
        if self.description:
            lines.append(f'\t@doc("{self.description}")')
        lines.append(f"\t{self.name}{':' if self.required else '?:'} {self.type};")
        return lines


class CadlModel:
    def __init__(self, ctx, name, data):
        self._ctx = ctx
        self.name = name
        self.description = _extract_description(data)
        self.type = data.get("type", None)
        self.properties = []
        required = data.get("required", [])
        properties = data.get("properties", [])
        if properties:
            for name, data in properties.items():
                self.properties.append(CadlProperty(ctx, name, data, name in required))

    def to_cadl(self):
        lines = []
        if self.description:
            lines.append(f'@doc("{self.description}")')
        lines.append(f"model {self.name} \x7b")
        for property in self.properties:
            lines += property.to_cadl()
        lines.append("}")
        return "\n".join(lines)

class SwaggerImport:

    def __init__(self):
        self._models = []

        # args = sys.argv[1:]
        # if len(args) != 2:
        #     print("usage: import_models.py SRC DST")
        #     sys.exit(1)

        base_path = "C:/Users/Administrator/Documents/Workspace/azure-rest-api-specs/specification/eventgrid/data-plane/"
        src = base_path + "Microsoft." + sys.argv[1] + "/stable/2018-01-01/" + sys.argv[-1] + ".json"
        self._dest = base_path + "cadl/" + sys.argv[-1] + ".cadl"
        with open(src, "r") as infile:
            swagger = json.loads(infile.read())

        models = swagger.get('parameters', {})
        models.update(swagger["definitions"])
        self._process_models(models)

    def _process_models(self, data):
        for key, value in data.items():
            enum = value.get("enum", None)
            if enum:
                self._models.append(CadlEnum(self, value, key))
            else:
                self._models.append(CadlModel(self, key, value))

    def save(self):
        dest = self._dest
        dest = f"{dest}.cadl" if not dest.endswith(".cadl") else dest
        with open(self._dest, "w") as outfile:
            for model in self._models:
                outfile.write(model.to_cadl())
                outfile.write("\n\n")

model = SwaggerImport()
model.save()
