# Recruitment task: color_juggler

A little app to juggle colors – tap anywhere to change the mood, as many times as you like.  
You will always see a new color. A simple way to stop overthinking if you need to decompress...

---

### `ColorsViewData.copyWith()`

Could be simplified here but is implemented with the typical null-checking pattern to prepare for
more fields in the class and keep in line with general convention.

### Private `_generateNextColor()` called from `nextColor()`

Why not inline `_generateNextColor()`?

- Clear layering: `nextColor()` is the public API (what the View calls).
- `_generateNextColor()` is an implementation detail, easy to test in isolation or replace later.
- Separates the “endpoint” from the algorithm.
- Easier to extend later if more generation modes (e.g. pastel colors, dark palette) are needed.
- Slightly more boilerplate, but it reads cleanly.

### Separate app_runner

For such a tiny app, it could just as well be inlined in `main()`. Yet `run()` in `app_runner.dart`
creates room for future bootstrapping of common tools:

- Logger
- Config (.env)
- Dependency injection (`GetIt`, or other)

### Docs following solid_lints

All public members are documented to comply with solid_lints. Some comments are intentionally
minimal, since the code is otherwise self-explanatory. Depending on the team policy, some of them
may be considered redundant.
