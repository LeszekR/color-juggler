# Recruitment task: color_juggler

---

### Implemented features

**The required functionality**

- The application displays the text "Hello there".
- The text is located in the middle of the screen.
- After tapping anywhere on the screen, the background color changes to a randomly generated color.
- The app picks from 16777216 colors using RGB - all three RGB components are randomly picked from
  0-255 ranges (256 possible values each) what gives 16777216 combinations with repetition.

**Additional functionality**

- Since the text tends to vainsh when the luminance difference is too narrow I implemented change of
  the text color as well - it is toggled between black and white. (I played with inversion of r,g,b
  first but the results of a simple algorithm were not satisfactory, the text was often not
  contrasted enough. I decided then that further tweaking of the algorithm goes beyond the scope of
  the task. Still - it is perfectly doable to invert and adjust luminance of the text to be clear
  too and yet not just black-white.)
- Since default font size of the `Text` widget seemed too small to be fun I used
  global `Theme.textTheme` to define bigger font, guarding against possible absence of the param in
  the `Theme` with default value

**Architecture**

- I created the app following patterns that easily scale. They may be an overkill for this exercise
  but I believe the few extra packages or classes do little harm while creating foundation for any
  growth in the future.
- I chose MVN architecture and created the first feature of the app following this pattern. It can
  be now easily scaled. Obviously it is just one of possible patterns, yet the choice seemed
  practical for the purpose - not overly complicated yet allowing for clear separation of concerns.
- I separated color-changing logic in the `ColorViewController` not to mix view and domain concerns.
- I followed the pattern of keeping state in cheapest possible data-container allowing for future
  preservation of the app's state at minimal memory expenditure. I created `ColorViewData` class for
  this purpose. This can be particularly important in mobile apps with large states to preserve.

---

### Docs following solid_lints

All public members are documented to comply with solid_lints. Some comments are intentionally
minimal, since the code is otherwise self-explanatory. Depending on the team policy, some of them
may be considered redundant but for the recruitment task requirements I commented all members
required by the linter.

### Implementation of `ColorsViewData.copyWith()`

Could be simplified but is implemented with the typical null-checking pattern to prepare for more
fields in the class and keep in line with general convention.

### Private `_nextColor()` called from `nextColor()`

Why not inline `_nextColor()`?

- Clear layering: `nextColor()` is the public API (what the View calls).
- `_nextColor()` is an inner implementation detail, easy to refactor.
- Separates the “endpoint” from the algorithm.
- Easier to extend later if more generation modes (e.g. pastel colors, dark palette) are needed.
- Slightly more boilerplate, but it reads cleanly.

### Separate app_runner

For such a tiny app, it could just as well be inlined in `main()`. Yet `run()` in `app_runner.dart`
creates room for future bootstrapping of common tools like:

- Logger
- Config (.env)
- Dependency injection (`GetIt`, or other)

### Global `Utils`

Utility class now only needed by `ColorViewController`. But its static method allows for testing
`Color` objects by their r,g,b,o values.

### Tests

- Since mocks often are used in many tests I created a dedicated file that sets them for being
  generated in one place