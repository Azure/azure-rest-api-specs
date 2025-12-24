import json
import re
from collections import defaultdict

with open(r'diff-output/oldNormalizedSwagger.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

inheritance_map = defaultdict(list)

for model_name, model_def in data.get('definitions', {}).items():
    if 'allOf' in model_def:
        for ref in model_def['allOf']:
            if '$ref' in ref:
                match = re.search(r'#/definitions/(.+)$', ref['$ref'])
                if match:
                    base_class = match.group(1)
                    inheritance_map[base_class].append(model_name)

print('\n========== 继承关系统计 ==========\n')
for base_class in sorted(inheritance_map.keys()):
    children = sorted(inheritance_map[base_class])
    print(f'【{base_class}】 ({len(children)} 个模型):')
    for child in children:
        print(f'  - {child}')
    print()
