# skills

## Getting Started

1. Create a new skill:

   ```bash
    waza new skill my-skill
   ```

2. Edit your skill:
   - Update `skills/my-skill/SKILL.md` with your skill definition
   - Customize eval tasks in `evals/my-skill/tasks/`
   - Add test fixtures to `evals/my-skill/fixtures/`

3. Run evaluations:

   ```bash
   waza run                    # run all evals
   waza run my-skill           # run one skill's evals
   ```

4. Check compliance:

   ```bash
   waza check                  # check all skills
   waza dev my-skill           # improve with real-time scoring
   ```

5. Push to trigger CI:
   ```bash
   git push
   ```
