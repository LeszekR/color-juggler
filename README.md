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
  first but the results of a simple algorithm were not satisfactory, the text was often lacked
  sufficient contrast.)
- Since the default font size of the `Text` widget seemed too small to be fun I increased the font
  size via `Theme.textTheme`, with default to ensure safety if no theme is provided.

**Architecture**

- I created the app following patterns that easily scale. In this branch I used BLoC. Obviously it
  is just one of possible patterns, yet the choice seemed practical for the purpose - not overly
  complicated yet allowing for clear separation of concerns.
- In a real project, I would use `Cubit` here, since it’s lighter and sufficient for this case. For
  the purpose of the recruitment task I deliberately chose `Bloc` to demonstrate my familiarity with
  the full event => state mechanism.
- I introduced `GetIt`. This prepares the app for DI anywhere without the boilerplate of passing
  dependencies via constructors chain and makes it easy to mock dependencies in tests.

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
  indicates a real issue. The test would be fully deterministic if I mocked the `ColorService`, but
  in this implementation introducing DI here would either require passing it through multiple
  constructors, which felt disproportionate for this task, or to hack it with static setter in
  `ColorViewController`. I did not like either approach hence I opted for a workaround which is NOT
  fully deterministic but for the practical reasons does work. Depending on the team's policy DI
  might have to be introduced here.
- The tree should be rebuilt in every iteration. But checking the test correctness by breaking it I
  got it fail because of the tree lingering from previous iteration being reused by the test
  framework. So to guarantee the tree is fresh I added a line that achieves just that. I commented
  it so other devs do not remove it.

---

## Implementation decisions rationale

### `ColorEvent` extending `Equatable`

Bloc events don’t have to extend Equatable. But in case where `Event` contains some data it becames
important. Without `Equatable` Dart compares objects by reference by default. So two events with the
same data are considered different. This can cause redundant state rebuilds or make tests awkward.
I did it here to demonstrate common practice although for the purpose of this task it is redundant.

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

- separation of the “endpoint” from the algorithm: `nextColor()` is the public API (what the View
  calls), - `_nextColor()` is an inner implementation detail, easy to refactor
- slightly more boilerplate, but it reads cleanly.

### Separate app_runner

For such a tiny app, it could just as well be inlined in `main()`. Yet `run()` in `app_runner.dart`
leaves room for bootstrapping common tools (logger, config, DI) if the app grows.