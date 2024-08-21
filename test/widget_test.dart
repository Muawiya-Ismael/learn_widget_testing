import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_widget_testing/main.dart';
import 'package:learn_widget_testing/main2.dart';

void main() {
  testWidgets('MyWidget has a title and a message', (tester) async {
    await tester.pumpWidget( MyWidget(title: "TEST", message: "Test message.",items: List<String>.generate(10000, (i) => 'Item $i')));

    final titleFinder = find.text('TEST');
    final messageFinder = find.text('Test message.');
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);

    final myWidgetFinder = find.byType(MyWidget);expect(myWidgetFinder, findsOneWidget);
    final myWidget = tester.widget<MyWidget>(myWidgetFinder);
    expect(myWidget.items.length, 10000);
    expect(myWidget.items[0], 'Item 0');
    expect(myWidget.items[8888], 'Item 8888');

  });

  testWidgets('Find MyWidget with specific Key', (WidgetTester tester) async {
    final uniqueKey = UniqueKey();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MyWidget(
          key: uniqueKey,
          title: 'TEST',
          message: 'Test message.',
          items: List<String>.generate(10000, (i) => 'Item $i'),
        ),
      ),
    ));

    final myWidgetFinder = find.byKey(uniqueKey);

    expect(myWidgetFinder, findsOneWidget);
  });

  testWidgets('Finds a specific MyWidget instance', (WidgetTester tester) async {
    await tester.pumpWidget(MyWidget(title: "TEST", message: "Test message.",items: List<String>.generate(10000, (i) => 'Item $i')));

    final myWidgetFinder = find.byType(MyWidget);

    expect(myWidgetFinder, findsOneWidget);

    final myWidget = tester.widget<MyWidget>(myWidgetFinder);

    expect(myWidget.title, 'TEST');
    expect(myWidget.message, 'Test message.');
  });


  testWidgets('Finds a specific MyWidget instance and verifies list items', (WidgetTester tester) async {
    await tester.pumpWidget(MyWidget(
        title: "TEST",
        message: "Test message.",
        items: List<String>.generate(10, (i) => 'Item $i') // Reduced item count
    ));

    final myWidgetFinder = find.byType(MyWidget);
    expect(myWidgetFinder, findsOneWidget);

    expect(find.byKey(const Key('long_list')), findsOneWidget); // Find the ListView
    expect(find.byKey(const Key('item_0_text')), findsOneWidget); // Find the first item
    expect(find.byKey(const Key('item_9_text')), findsOneWidget); // Find the last item
  });

  testWidgets('finds a deep item in a long list', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyWidget(
      title: 'TEST',
      message: 'Test message.',
      items: List<String>.generate(10000, (i) => 'Item $i'),
    ));

    final listFinder = find.byType(Scrollable);
    final itemFinder = find.byKey(const ValueKey('item_88_text'));

    await tester.scrollUntilVisible(
      itemFinder,
      500.0,
      scrollable: listFinder,
    );

    expect(itemFinder, findsOneWidget);
  });

  testWidgets('Add and remove a todo', (tester) async {

    await tester.pumpWidget(const TodoList());

    await tester.enterText(find.byType(TextField), 'hi');

    await tester.tap(find.byType(FloatingActionButton));

    await tester.pump();

    expect(find.text('hi'), findsOneWidget);

    await tester.drag(find.byType(Dismissible), const Offset(500, 0));

    await tester.pumpAndSettle();

    expect(find.text('hi'), findsNothing);
  });

}

