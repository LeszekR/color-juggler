# Recruitment task: color_juggler

---

## Running the project

1. Clone the repo.
2. Open terminal, go to the root directory of the project
3. Get dependencies

```
flutter pub get
```

4. Prepare platforms (here: windows, web):

```
flutter create --platforms=windows,web .
```

5. Delete `test/widget_test.dart` if created automatically.

6. Now project is ready to run

```
flutter run -d windows
flutter test
```

Generated mocks (*.mocks.dart) are committed to the repository. If you change or add
`@GenerateMocks` annotations, regenerate them with:

```
dart run build_runner build --delete-conflicting-outputs

```

---

## Implemented features

**The required functionality**

- The application displays the text "Hello there".
- The text is located in the middle of the screen.
- After tapping anywhere on the screen, the background color changes to a randomly generated color.
- The app picks from 16777216 colors using RGB - all three RGB components are randomly picked from
  0-255 ranges (256 possible values each) what gives 16777216 combinations with repetition.A

**Additional functionality**

- Since the text tends to vanish when the luminance difference is too narrow I implemented change of
  the text color as well - it is toggled between black and white. (I played with inversion of r,g,b
  first but the results of a simple algorithm were not satisfactory, the text was often not
  contrasted enough. I decided then that further tweaking of the algorithm goes beyond the scope of
  the task. Still - it is perfectly doable to invert the color and adjust luminance of the text to
  be clear too - not only just black-white.)
- Since the default font size of the `Text` widget seemed too small to be fun I used
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

## Tests

### Mocks

- Since mocks often are used in many tests I created a dedicated file that sets them for being
  generated in one place

### `testCases` in separate file

- Test data are prepared to be reused across many tests.
- When in separate file they are easier to follow in long files with many tests - toggling files
  always shows the test data without loosing track of currently read test; put in the same file with
  tests force scrolling up and down what makes it more difficult to understand what given test does.

### Comments to `color_view_test`

- The test is not fully deterministic since the color change is random. Hence I run the change 5
  times and collect the results. Test passes if only one changes the color. With 5 iterations
  the chance of picking the same color every time is negligible (~10^-36), so a failure here likely
  indicates a real issue. The test would be fully deterministic if I mocked the `ColorUtils`, but in
  this implementation I decided it was too cumbersome to DI the `ColorUtils` by passing it from the
  root of the app to the `ColorviewController`, neither wanted to hack it with static setter in
  `ColorViewController`. Hence I devised a workaround which is NOT fully deterministic but for the
  practical reasons does work. Depending on the team's policy DI might have to be introduced here.
- The tree should be rebuilt in every iteration. But checking the test correctness by breaking it I
  got it fail because of the tree lingering from previous iteration being reused by the test
  framework. So to guarantee the tree is fresh I added a line that achieves just that. I commented
  it so other devs do not remove it.

---

## Implementation decisions rationale

### Docs following `solid_lints`

All public members are documented to comply with `solid_lints`. Some comments are intentionally
minimal, since the code is otherwise self-explanatory. Depending on the team policy, some of them
may be considered redundant but for the recruitment task requirements I commented all members
required by the linter.

### Implementation of `ColorsViewData.copyWith()`

Implemented with the typical null-checking pattern to prepare for more
fields in the class and keep in line with general convention.

### Private `_nextColor()` called from `nextColor()`

The `_nextColor()` method might as well be inlined. I decided to extract it for:

- clear layering: `nextColor()` is the public API (what the View calls)
- `_nextColor()` is an inner implementation detail, easy to refactor
- separation of the “endpoint” from the algorithm
- slightly more boilerplate, but it reads cleanly.

### Separate app_runner

For such a tiny app, it could just as well be inlined in `main()`. Yet `run()` in `app_runner.dart`
creates room for future bootstrapping of common tools like:

- Logger
- Config (.env)
- Dependency injection (`GetIt`, or other)
