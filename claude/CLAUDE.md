# Global instructions

## Model delegation for coding tasks

For all coding tasks, use your judgment to pick an appropriate lower-power model and run the work in a subagent (Agent tool with a `model` override) rather than coding directly in the main loop:

- Default to `sonnet` for typical implementation work (features, bug fixes, refactors)
- Use `haiku` for simple mechanical edits
- Keep planning, judgment calls, and final review in the main loop

This applies to coding tasks generally, not one-off questions or trivial single-line answers.
