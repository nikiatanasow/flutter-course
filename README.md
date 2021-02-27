# flutter-course
Tracking progress of the flutter course

## Course Agenda

- [x] Theme 1 - Getting started: What is Flutter,  Create first Flutter app,  Material and Cupertino Widgets
- [x] [Theme 2 - Layout Widgets, Testing framework](https://drive.google.com/file/d/1XgJwNkbfGM3qir8mxYRNvOA2Zuc_GRMQ/view?usp=sharing)
- [x] [Theme 3 - Build simple ToDo application: **Part 1**](https://drive.google.com/file/d/1QbnhDAxxGRh_gvp-K-M7LEfe-o51yjVC/view?usp=sharing)
- [x] [Theme 4 - Build simple ToDo application: **Part 2**](https://drive.google.com/file/d/1F_hCl19Eokwx5TkqWLp7g_ujdTCUZtBi/view?usp=sharing)
- [x] [Theme 5 - Build simple ToDo application: **Part 3**](https://drive.google.com/file/d/1cTw7gAX927jCMVZ57m0MmQGWDJkel9JZ/view?usp=sharing)
- [x] [Theme 6 - Rewrite the ToDo business logic with BloC: **Part 1**](https://viskosoft-my.sharepoint.com/:v:/g/personal/admin_viskosoft_onmicrosoft_com/EVH_rftDouhHvAwfQEWlj1IBrNGNTr6DC5yk1Aw1FjJeOw?e=UaXjNw)
- [x] [Theme 7 - Rewrite the ToDo business logic with BloC: **Part 2**](https://viskosoft-my.sharepoint.com/:v:/g/personal/admin_viskosoft_onmicrosoft_com/EeVjOu4Ago5DgPDrxRMW4O4BJRhCQrABaQi1kXomXvuIyQ?e=G1c8oI)
- [x] [Theme 8 - Rewrite the ToDo business logic with BloC: **Part 3**](https://drive.google.com/file/d/1BlVBSLnjzl8dJBjYZP-hvomz9XFl8FfI/view?usp=sharing)
- [x] [Theme 9 - Web services intro](presentations/web-services-intro.md)
- [ ] Theme 10 - Connect the ToDo application to a service
- [ ] Theme 11 - Animations - implicit and explicit. Add animations into the ToDo application
- [ ] Theme 12 - How to write platform specific code in Android and Objective-c. When it is needed?
- [ ] Theme 13 - Flutter Architecture: How Flutter works under the hood and makes it different than Xamarin and React Native
- [ ] Theme 14 - Flutter Architecture: Part 2 - CustomPaint, CustomMultiChildLayout, CustomSingleChildLayout

## ToDo Application Design
![ToDo](https://bloclibrary.dev/assets/gifs/flutter_todos.gif)

## Homeworks

#### Theme 1

- Setup your development environment - [Flutter docs](https://flutter.dev/docs/get-started/install)
  - install flutter
  - install android studion and setup a emulator
  - [MAC ONLY] install xccode and setup a simulator
  - install your IDE of choicec - [VSCode](https://code.visualstudio.com/), [Android studio](https://developer.android.com/studio), [IntelliJ](https://www.jetbrains.com/idea/)
- Create and run your first flutter app
- Change the text of the default label - `You have pushed the button this many times:` - to be `Click count`
- *Add one more label below the counter label that is showing the clicked count multiplied by 10 (e.g. if you clicked the button 2 times the new label should show 20)

#### Theme 2
- Create a flutter application
- Modify the application - preserve the idea of a Counter app and simply use a different layout. It is all up to you - you can also use different widgets (not only Text).
- Write 2-3 Widget tests for your Counter app. If you are intereseted you can try to write some integration tests (driver) as well.
#### Theme 3
Try to recrate the ToDo application from the session.
#### Theme 4
Try to recrate the ToDo application from the session or improve it.
#### Theme 5
Improve the logic of the two buttons that are part of the AppBar on the main page. Currently their logic is not working accurately. For example if you have an applied filtering and only completed items are visualized when you mark all the thems as active filtering should be re-applied as well.
#### Theme 6
Create a counter app with BLoC on your own.
#### Theme 7
Finish the BLoC migration by invoking the events.
#### Theme 8
Refactor the application:
- prevent BlocConsumers from being invoked if not needed.
- try to separate the add/edit page.
- overall code refactoring
