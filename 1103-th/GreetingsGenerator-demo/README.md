# GreetingsGenerator-demo

Let's build a small, one-viewcontroller app that let's us generate and display a greeting for a person that is composed of

1. either a _custom greeting_ or a _predefined greeting_ 
2. the _name of that person_


The UI is composed of the following elements:

1. `greetingLabel`:
The `greetingLabel` contains the result of the greeting, e.g. `Hello, John`. The string is composed of the greeting and the name of the person to greet. The greeting can be either a custom greeting that the user types into the `greetingTextField` or one of the predefined greetings that the user can select by tapping on one of the buttons. The person's name needs to be typed in the `nameTextField`. 

2. `stateSegmentedControl`:
This segmented control indicates whether the greeting text on the `greetingLabel` should use the predefined greetings from the buttons or the custom greeting text that is inside the `greetingTextField`. Note that when switching between the two states, either the `greetingTextField` or the four greeting buttons should be _disabled_ (i.e. the `isEnabled` property needs to be set to `false`). 

3. `greetingTextField`:
The user can type a greeting into this text field. Note that the `greetingLabel` should be updated on every key stroke! This text field needs to be disabled when the user selects `Use buttons` in the `stateSegmentedControl`.

4. `greetingButtons`:
These are four buttons that each represent a predefined greeting. When tapping one of the buttons, the text on the `greetingLabel` should be updated accordingly. These buttons need to be disabled when the user selects `Use text field` in the `stateSegmentedControl`. For your implemenation, note that multiple `UIButton`s can be connected to only one `IBAction` and they can be contained in one `IBOutletCollection` (which is basically just an array of `IBOutlet`s).

5. `nameTextField`:
This text field is always enabled and contains the name of the person to greet. The `greetingLabel` should be updated on every keystroke in this text field.



