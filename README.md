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

## Two branches in the repository - versions of implementation

The same functionality is implemented in two separate branches.  
**IMPORTANT**: after every checking out the other branch `flutter pub get` **must be run
again**.

1. `master` - vanilla Flutter
2. `bloc_getit` - self explanatory

Where applicable - the below comments differentiate between the two branches.

---

## Implemented features

### The required functionality

- The application displays the text "Hello there".
- The text is located in the middle of the screen.
- After tapping anywhere on the screen, the background color changes to a randomly generated color.
- The app picks from 16777216 colors using RGB - all three RGB components are randomly picked from
  0-255 ranges (256 possible values each) what gives 16777216 combinations with repetition.

### Additional functionality

- Since the text tends to vanish when the luminance difference is too narrow I implemented change of
  the text color as well - it is toggled between black and white. (I played with inversion of r,g,b
  first but the results of a simple algorithm were not satisfactory, the text was often not
  sufficiently contrasted.)
- Since the default font size of the `Text` widget seemed too small to be fun I increased the font
  size via `Theme.textTheme`, with default to ensure safety if no theme is provided.

### Architecture

The app is created following patterns that easily scale. They patterns were chosen in an attempt to
not overly complicate the code yet allow for clear separation of concerns and build foundation of
further scaling of the app.

**BRANCH: `master`**

- MVC architecture.
- Color-changing logic is abstracted into the `ColorViewController` not to mix view and domain
  concerns.
- State is abstracted into lightweight `ColorViewData` data container allowing for future
  preservation of the app's state at minimal memory expenditure (see: branch `bloc_getit`). This can
  be particularly important in mobile apps with large states to preserve.

**BRANCH `bloc_getit`**

- `Bloc` used for `ColorView` state management.
- In any real project, `Cubit` would be more suitable here, since it’s lighter and sufficient for
  this case. For the purpose of the recruitment task I deliberately chose `Bloc` to demonstrate
  familiarity with the full event => state mechanism.
- `GetIt` used for dependency injection. This sets frame for the app to use DI anywhere without the
  boilerplate of passing dependencies via constructors chain.
- `ColorState` is simply refactored `ColorViewData` from branch `master`.
- Mocking dependencies via `GetIt` is used in `color_view_test`.

---

## Tests

### Centralised mocks generation

The same mocks are often used in multiple tests. Therefore they have been put in a single, dedicated
file. This way they are generated in one place - less boilerplate, DRY, KISS observed.

### `testCases` in separate file

- Test data ready to be reused across many tests.
- When in separate file they are easier to follow while editing long test files - toggling between
  the test and data files retains the scroll in both files. Putting them in the same file force
  scrolling up and down to see what is in the data, making it more difficult to understand what
  given test does.

### `color_view_test`

**BRANCH: `master`**

- The test is not deterministic since the color change is random. To work around the problem it runs
  the change 5 times and collects the results. It passes if only one iteration changes the color.
  With 5 iterations the chance of picking the same color every time is negligible (~10^-36), so a
  failure here likely indicates a real issue. The test would be fully deterministic if
  `ColorService` was mocked, but in this implementation introducing DI would either require passing
  it through multiple constructors - a lot of boilerplate to maintain, or to hack it with static
  setter in `ColorViewController` - ugly intrusion in release code. I did not like either
  approach hence I opted for a workaround which is NOT fully deterministic but for the practical
  reasons does work. Depending on the team's policy such approach could be rejected and DI might
  have to be introduced instead.
- The tree must be rebuilt in every iteration. Checking the test correctness by breaking it I got it
  to fail because of the old tree lingering from previous iteration- `flutter_test` was reusing it.
  To
  guarantee the tree is fresh I added a line that achieves just that. I commented it to prevent
  its possible removal by other devs.

**BRANCH: `bloc_getit`**

- Here the test is deterministic.
- I used `GetIt` to inject `MockColorService` and use full control over the colors before and after
  the tap on the screen.
- The test covers all cases of colors change.

---

## Implementation decisions rationale

### `ColorEvent` extending `Equatable`

**BRANCH: `master`**

Bloc events don’t have to extend `Equatable`. But in case where `Event` contains some data it
becomes important. Without `Equatable` Dart compares objects by reference by default. So two events
with the same data are considered different. This can cause redundant state rebuilds or make tests
awkward. I did it here to demonstrate common practice although for the purpose of this task it is
redundant.

### `ColorState` extending  `Equatable`

**BRANCH: `bloc_getit`**

Simplifies comparing emitted states in tests. Without it a comparator would have to be implemented.

### Docs following `solid_lints`

All public members are documented to comply with `solid_lints`. Some comments are intentionally
minimal, since the code is otherwise self-explanatory. Depending on the team policy, some of them
may be considered redundant but for the recruitment task requirements I commented all members
required by the linter.

### Implementation of `ColorsViewData.copyWith()`

Implemented with the typical null-checking pattern to prepare for more fields in the class.

### Private `_nextColor()` called from `nextColor()`

**BRANCH: `master`**

The `_nextColor()` method might as well be inlined. I decided to extract it for:

- separation of the “endpoint” from the algorithm: `nextColor()` is the public API (called from the
  view),  `_nextColor()` is inner implementation detail, easy to refactor.
- Slightly more boilerplate, but it reads cleanly.

### Separate app_runner

- For such a tiny app, it could just as well be inlined in `main()`.
- Yet `run()` in `app_runner.dart` leaves room for bootstrapping common tools (logger, config, DI)
  if the app grows.
- It is actually used in branch `bloc_getit` for initiating `GetIt`.