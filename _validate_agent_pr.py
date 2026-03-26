#!/usr/bin/env python3
"""
Compare PR #41800 (swagger agent) vs PR #41797 (manually validated) for correctness.
Both target MLS stable 2026-03-01. Same base commit.

Strategy: For every file changed in either PR, compare the final file content at
each PR's head commit. If both PRs produce identical file contents, the agent is correct.
"""
import subprocess, json, sys, os
from collections import defaultdict

BASE = "b933c3c08256462df23adace3993e79310f2cdc6"
AGENT_HEAD = "9b599843d4610209e892121b5aabdee2346feb60"  # PR #41800
MINE_HEAD = "da79be4669a8837d75bbd6d6fe05d9973e42bff2"   # PR #41797

MLS_TSP = "specification/machinelearningservices/MachineLearningServices.Management"
MLS_RM = "specification/machinelearningservices/resource-manager"

def git_show(commit, path):
    """Get file content at a specific commit. Returns None if file doesn't exist."""
    r = subprocess.run(["git", "show", f"{commit}:{path}"], capture_output=True, text=True)
    if r.returncode != 0:
        return None
    return r.stdout

def git_diff_names(base, head, path_filter=""):
    """Get list of changed files between two commits."""
    cmd = ["git", "diff", "--name-only", base, head]
    if path_filter:
        cmd.append("--")
        cmd.append(path_filter)
    r = subprocess.run(cmd, capture_output=True, text=True)
    return [f for f in r.stdout.strip().split("\n") if f]

# ============================================================
# 1. Compare .tsp file changes
# ============================================================
print("=" * 80)
print("1. TypeSpec (.tsp) FILE COMPARISON")
print("=" * 80)

agent_tsp = git_diff_names(BASE, AGENT_HEAD, f"{MLS_TSP}/*.tsp")
mine_tsp = git_diff_names(BASE, MINE_HEAD, f"{MLS_TSP}/*.tsp")

agent_tsp_set = set(agent_tsp)
mine_tsp_set = set(mine_tsp)

print(f"  Agent PR #41800: {len(agent_tsp)} .tsp files modified")
print(f"  My PR #41797:    {len(mine_tsp)} .tsp files modified")

only_agent = agent_tsp_set - mine_tsp_set
only_mine = mine_tsp_set - agent_tsp_set
both = agent_tsp_set & mine_tsp_set

if only_agent:
    print(f"\n  ⚠️  Only in Agent PR: {len(only_agent)}")
    for f in sorted(only_agent):
        print(f"    {f.split('/')[-1]}")
if only_mine:
    print(f"\n  ⚠️  Only in My PR: {len(only_mine)}")
    for f in sorted(only_mine):
        print(f"    {f.split('/')[-1]}")

# For shared files, compare the final content
print(f"\n  Comparing final content of {len(both)} shared .tsp files...")
tsp_identical = 0
tsp_different = []
for f in sorted(both):
    agent_content = git_show(AGENT_HEAD, f)
    mine_content = git_show(MINE_HEAD, f)
    if agent_content == mine_content:
        tsp_identical += 1
    else:
        tsp_different.append(f)

print(f"  ✅ Identical: {tsp_identical}")
if tsp_different:
    print(f"  ❌ Different: {len(tsp_different)}")
    for f in tsp_different:
        print(f"    {f.split('/')[-1]}")

# For files only in one PR, check if they differ from base
if only_agent:
    print(f"\n  Checking files only in Agent PR against base...")
    for f in sorted(only_agent):
        agent_content = git_show(AGENT_HEAD, f)
        base_content = git_show(BASE, f)
        if agent_content == base_content:
            print(f"    {f.split('/')[-1]}: same as base (no-op change?)")
        else:
            print(f"    {f.split('/')[-1]}: DIFFERS from base (unexpected change)")

if only_mine:
    print(f"\n  Checking files only in My PR against base...")
    for f in sorted(only_mine):
        mine_content = git_show(MINE_HEAD, f)
        base_content = git_show(BASE, f)
        if mine_content == base_content:
            print(f"    {f.split('/')[-1]}: same as base (no-op)")
        else:
            print(f"    {f.split('/')[-1]}: DIFFERS from base")

# ============================================================
# 2. Compare decorator counts specifically
# ============================================================
print()
print("=" * 80)
print("2. @removed(Versions.v2026_03_01) DECORATOR COUNTS")
print("=" * 80)

def count_removed_decorators(commit, path_pattern):
    r = subprocess.run(
        ["git", "diff", BASE, commit, "--", path_pattern],
        capture_output=True, text=True
    )
    count = 0
    per_file = defaultdict(int)
    current_file = ""
    for line in r.stdout.split("\n"):
        if line.startswith("diff --git"):
            parts = line.split(" b/")
            if len(parts) > 1:
                current_file = parts[1].split("/")[-1]
        if line.startswith("+") and not line.startswith("+++") and "@removed(Versions.v2026_03_01)" in line:
            count += 1
            per_file[current_file] += 1
    return count, dict(per_file)

agent_total, agent_per_file = count_removed_decorators(AGENT_HEAD, f"{MLS_TSP}/*.tsp")
mine_total, mine_per_file = count_removed_decorators(MINE_HEAD, f"{MLS_TSP}/*.tsp")

print(f"  Agent PR #41800: {agent_total} total @removed(v2026_03_01)")
print(f"  My PR #41797:    {mine_total} total @removed(v2026_03_01)")
print()

all_files = sorted(set(list(agent_per_file.keys()) + list(mine_per_file.keys())))
print(f"  {'File':<55s} {'Agent':>6s} {'Mine':>6s} {'Match':>6s}")
print(f"  {'-'*55} {'-'*6} {'-'*6} {'-'*6}")
for f in all_files:
    a = agent_per_file.get(f, 0)
    m = mine_per_file.get(f, 0)
    match = "✅" if a == m else "❌"
    print(f"  {f:<55s} {a:>6d} {m:>6d} {match:>6s}")
print(f"  {'-'*55} {'-'*6} {'-'*6} {'-'*6}")
print(f"  {'TOTAL':<55s} {agent_total:>6d} {mine_total:>6d} {'✅' if agent_total == mine_total else '❌':>6s}")

# ============================================================
# 3. Compare generated openapi.json
# ============================================================
print()
print("=" * 80)
print("3. GENERATED openapi.json COMPARISON")
print("=" * 80)

openapi_path = f"{MLS_RM}/Microsoft.MachineLearningServices/stable/2026-03-01/openapi.json"
agent_openapi = git_show(AGENT_HEAD, openapi_path)
mine_openapi = git_show(MINE_HEAD, openapi_path)

if agent_openapi is None:
    print("  ❌ Agent PR does NOT have openapi.json at expected path")
elif mine_openapi is None:
    print("  ❌ My PR does NOT have openapi.json at expected path")
elif agent_openapi == mine_openapi:
    print("  ✅ openapi.json is IDENTICAL in both PRs")
else:
    # Parse and compare structurally
    try:
        agent_spec = json.loads(agent_openapi)
        mine_spec = json.loads(mine_openapi)
        
        agent_paths = set(agent_spec.get("paths", {}).keys())
        mine_paths = set(mine_spec.get("paths", {}).keys())
        agent_defs = set(agent_spec.get("definitions", {}).keys())
        mine_defs = set(mine_spec.get("definitions", {}).keys())
        
        print(f"  Paths:       Agent={len(agent_paths):4d}  Mine={len(mine_paths):4d}  {'✅' if agent_paths == mine_paths else '❌'}")
        print(f"  Definitions: Agent={len(agent_defs):4d}  Mine={len(mine_defs):4d}  {'✅' if agent_defs == mine_defs else '❌'}")
        
        if agent_paths != mine_paths:
            only_agent_p = agent_paths - mine_paths
            only_mine_p = mine_paths - agent_paths
            if only_agent_p:
                print(f"\n  Paths only in Agent: {len(only_agent_p)}")
                for p in sorted(only_agent_p)[:20]:
                    print(f"    + {p}")
            if only_mine_p:
                print(f"\n  Paths only in Mine: {len(only_mine_p)}")
                for p in sorted(only_mine_p)[:20]:
                    print(f"    + {p}")
        
        if agent_defs != mine_defs:
            only_agent_d = agent_defs - mine_defs
            only_mine_d = mine_defs - agent_defs
            if only_agent_d:
                print(f"\n  Definitions only in Agent: {len(only_agent_d)}")
                for d in sorted(only_agent_d)[:20]:
                    print(f"    + {d}")
            if only_mine_d:
                print(f"\n  Definitions only in Mine: {len(only_mine_d)}")
                for d in sorted(only_mine_d)[:20]:
                    print(f"    + {d}")
        
        # Check api-version in info
        agent_ver = agent_spec.get("info", {}).get("version", "")
        mine_ver = mine_spec.get("info", {}).get("version", "")
        print(f"\n  API version: Agent='{agent_ver}' Mine='{mine_ver}' {'✅' if agent_ver == mine_ver else '❌'}")
        
        # If paths and defs match, check for property-level differences
        if agent_paths == mine_paths and agent_defs == mine_defs:
            print("\n  Paths and definitions match. Checking for property-level differences...")
            prop_diffs = []
            for d in sorted(agent_defs):
                agent_props = set(agent_spec["definitions"][d].get("properties", {}).keys())
                mine_props = set(mine_spec["definitions"][d].get("properties", {}).keys())
                if agent_props != mine_props:
                    prop_diffs.append((d, agent_props - mine_props, mine_props - agent_props))
            if prop_diffs:
                print(f"  ❌ Property differences in {len(prop_diffs)} definitions:")
                for d, only_a, only_m in prop_diffs:
                    print(f"    {d}:")
                    if only_a:
                        print(f"      Only in Agent: {sorted(only_a)}")
                    if only_m:
                        print(f"      Only in Mine: {sorted(only_m)}")
            else:
                print("  ✅ All definition properties match")
    except json.JSONDecodeError as e:
        print(f"  ❌ JSON parse error: {e}")

# ============================================================
# 4. Compare example files
# ============================================================
print()
print("=" * 80)
print("4. EXAMPLE FILES COMPARISON")
print("=" * 80)

agent_examples_tsp = [f for f in open("/tmp/pr41800_files.txt").read().strip().split("\n") 
                       if f"{MLS_TSP}/examples/2026-03-01/" in f]
mine_examples_tsp = [f for f in open("/tmp/pr41797_files.txt").read().strip().split("\n")
                      if f"{MLS_TSP}/examples/2026-03-01/" in f]
agent_examples_rm = [f for f in open("/tmp/pr41800_files.txt").read().strip().split("\n")
                      if f"{MLS_RM}/Microsoft.MachineLearningServices/stable/2026-03-01/examples/" in f]
mine_examples_rm = [f for f in open("/tmp/pr41797_files.txt").read().strip().split("\n")
                     if f"{MLS_RM}/Microsoft.MachineLearningServices/stable/2026-03-01/examples/" in f]

print(f"  TypeSpec examples (examples/2026-03-01/):")
print(f"    Agent: {len(agent_examples_tsp)}  Mine: {len(mine_examples_tsp)}")

agent_tsp_names = set(f.split("/examples/2026-03-01/")[-1] for f in agent_examples_tsp)
mine_tsp_names = set(f.split("/examples/2026-03-01/")[-1] for f in mine_examples_tsp)

if agent_tsp_names == mine_tsp_names:
    print(f"    ✅ Same {len(agent_tsp_names)} example files")
else:
    only_a = agent_tsp_names - mine_tsp_names
    only_m = mine_tsp_names - agent_tsp_names
    if only_a:
        print(f"    Only in Agent: {len(only_a)}")
        for n in sorted(only_a)[:10]:
            print(f"      + {n}")
    if only_m:
        print(f"    Only in Mine: {len(only_m)}")
        for n in sorted(only_m)[:10]:
            print(f"      + {n}")

print(f"\n  Resource manager examples (stable/2026-03-01/examples/):")
print(f"    Agent: {len(agent_examples_rm)}  Mine: {len(mine_examples_rm)}")

agent_rm_names = set(f.split("/examples/")[-1] for f in agent_examples_rm)
mine_rm_names = set(f.split("/examples/")[-1] for f in mine_examples_rm)

if agent_rm_names == mine_rm_names:
    print(f"    ✅ Same {len(agent_rm_names)} example files")
else:
    only_a = agent_rm_names - mine_rm_names
    only_m = mine_rm_names - agent_rm_names
    if only_a:
        print(f"    Only in Agent: {len(only_a)}")
        for n in sorted(only_a)[:10]:
            print(f"      + {n}")
    if only_m:
        print(f"    Only in Mine: {len(only_m)}")
        for n in sorted(only_m)[:10]:
            print(f"      + {n}")

# Spot-check a few example files for content match
print(f"\n  Spot-checking example file contents...")
sample_examples = sorted(agent_tsp_names & mine_tsp_names)[:5]
for ex in sample_examples:
    full_path = f"{MLS_TSP}/examples/2026-03-01/{ex}"
    a = git_show(AGENT_HEAD, full_path)
    m = git_show(MINE_HEAD, full_path)
    match = "✅" if a == m else "❌"
    print(f"    {ex}: {match}")

# ============================================================
# 5. Compare readme.md
# ============================================================
print()
print("=" * 80)
print("5. readme.md COMPARISON")
print("=" * 80)

readme_path = f"{MLS_RM}/readme.md"
agent_readme = git_show(AGENT_HEAD, readme_path)
mine_readme = git_show(MINE_HEAD, readme_path)

if agent_readme == mine_readme:
    print("  ✅ readme.md is IDENTICAL")
else:
    print("  ❌ readme.md DIFFERS")
    # Show the diff
    agent_lines = agent_readme.split("\n") if agent_readme else []
    mine_lines = mine_readme.split("\n") if mine_readme else []
    print(f"    Agent: {len(agent_lines)} lines  Mine: {len(mine_lines)} lines")
    
    # Find the 2026-03-01 tag section in both
    def find_tag_section(lines, tag="package-2026-03-01"):
        start = None
        end = None
        for i, line in enumerate(lines):
            if f"tag: {tag}" in line:
                # Go back to find ### 
                for j in range(i, max(i-5, -1), -1):
                    if lines[j].startswith("### Tag:") or lines[j].startswith("```"):
                        start = j
                        break
                if start is None:
                    start = i
            if start is not None and end is None and i > start + 2 and (line.startswith("### Tag:") or line.startswith("```") and i > start + 3):
                end = i
                break
        if start is not None and end is None:
            end = min(start + 30, len(lines))
        return start, end
    
    a_start, a_end = find_tag_section(agent_lines)
    m_start, m_end = find_tag_section(mine_lines)
    
    if a_start is not None:
        print(f"\n    Agent tag section (lines {a_start}-{a_end}):")
        for line in agent_lines[a_start:a_end]:
            print(f"      {line}")
    else:
        print("    ⚠️  Agent: no package-2026-03-01 tag found!")
    
    if m_start is not None:
        print(f"\n    Mine tag section (lines {m_start}-{m_end}):")
        for line in mine_lines[m_start:m_end]:
            print(f"      {line}")
    else:
        print("    ⚠️  Mine: no package-2026-03-01 tag found!")

# ============================================================
# 6. Compare main.tsp
# ============================================================
print()
print("=" * 80)
print("6. main.tsp COMPARISON")
print("=" * 80)

main_path = f"{MLS_TSP}/main.tsp"
agent_main = git_show(AGENT_HEAD, main_path)
mine_main = git_show(MINE_HEAD, main_path)

if agent_main == mine_main:
    print("  ✅ main.tsp is IDENTICAL")
else:
    print("  ❌ main.tsp DIFFERS")
    # Show version enum from both
    for label, content in [("Agent", agent_main), ("Mine", mine_main)]:
        lines = content.split("\n")
        in_enum = False
        print(f"\n    {label} version enum:")
        for line in lines:
            if "enum Versions" in line:
                in_enum = True
            if in_enum:
                print(f"      {line}")
                if "}" in line and in_enum:
                    break

# ============================================================
# 7. Final summary
# ============================================================
print()
print("=" * 80)
print("7. FINAL VERDICT")
print("=" * 80)

issues = []

if agent_total != mine_total:
    issues.append(f"Decorator count mismatch: Agent={agent_total} vs Mine={mine_total}")
if tsp_different:
    issues.append(f"{len(tsp_different)} .tsp files have different content")
if only_agent:
    issues.append(f"Agent modified {len(only_agent)} extra .tsp files not in my PR")
if only_mine:
    issues.append(f"My PR modified {len(only_mine)} .tsp files not in agent PR")
if agent_tsp_names != mine_tsp_names:
    issues.append("Example file sets differ")

# Check openapi
if agent_openapi and mine_openapi:
    if agent_openapi != mine_openapi:
        issues.append("openapi.json content differs")
elif agent_openapi is None:
    issues.append("Agent PR missing openapi.json")

if agent_readme != mine_readme:
    issues.append("readme.md content differs")

if agent_main != mine_main:
    issues.append("main.tsp content differs")

if not issues:
    print("  ✅ AGENT PR IS CORRECT — identical to validated PR #41797")
else:
    print(f"  ⚠️  DIFFERENCES FOUND ({len(issues)}):")
    for i, issue in enumerate(issues, 1):
        print(f"    {i}. {issue}")
    print("\n  Note: Some differences may be acceptable (e.g., minor formatting).")
    print("  Review the details above to determine if they are correctness issues.")
