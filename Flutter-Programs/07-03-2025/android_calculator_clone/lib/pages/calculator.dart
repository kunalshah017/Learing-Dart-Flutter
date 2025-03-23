import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String currentInput = '0'; // Tracks what's being entered
  String expression = ''; // Stores the full expression
  String result = ''; // Stores calculated result

  void onDigitPressed(String digit) {
    setState(() {
      if (currentInput == '0') {
        currentInput = digit;
      } else {
        currentInput += digit;
      }

      evaluateExpression();
    });
  }

  void onDecimalPressed() {
    setState(() {
      if (!currentInput.contains('.')) {
        currentInput += '.';
      }
    });
  }

  void onClearPressed() {
    setState(() {
      currentInput = '0';
      expression = '';
      result = '';
    });
  }

  void onBackspacePressed() {
    setState(() {
      if (currentInput.length > 1) {
        currentInput = currentInput.substring(0, currentInput.length - 1);
        evaluateExpression();
      } else {
        currentInput = '0';
        result = '';
      }
    });
  }

  void onOperatorPressed(String op) {
    setState(() {
      // If the last character is already an operator, replace it
      final operatorSet = {'+', '-', '×', '÷', '%'};
      if (currentInput.isNotEmpty &&
          operatorSet.contains(currentInput[currentInput.length - 1])) {
        currentInput = currentInput.substring(0, currentInput.length - 1) + op;
      } else {
        currentInput += op;
      }

      evaluateExpression();
    });
  }

  void onEqualsPressed() {
    if (currentInput == '0') return;

    setState(() {
      evaluateExpression();
      if (result.isNotEmpty) {
        expression = currentInput;
        currentInput = result;
        result = '';
      }
    });
  }

  void evaluateExpression() {
    try {
      String expressionToEval = currentInput;

      // Insert multiplication after % for evaluation
      expressionToEval = expressionToEval.replaceAllMapped(
        RegExp(r'%([0-9])'),
        (match) => '/100*${match.group(1)}',
      );

      // Also handle other % cases
      expressionToEval = expressionToEval.replaceAll(r'%', r'/100');

      // Standard operator replacements
      expressionToEval = expressionToEval
          .replaceAll('×', '*')
          .replaceAll('÷', '/');

      Parser p = Parser();
      Expression exp = p.parse(expressionToEval);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      // Format result
      if (evalResult == evalResult.toInt()) {
        result = evalResult.toInt().toString();
      } else {
        // Limit decimal places for cleaner display
        result = evalResult
            .toStringAsFixed(8)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      }

      // Don't show result if it's the same as current input
      if (result == currentInput) {
        result = '';
      }
    } catch (e) {
      result = ''; // Clear result on error
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceTint,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Current calculation (larger text)
                    Expanded(
                      flex: 2,
                      child: SelectableText(
                        currentInput,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                        showCursor: false,
                        enableInteractiveSelection: true,
                        toolbarOptions: const ToolbarOptions(
                          copy: true,
                          selectAll: true,
                          cut: false,
                          paste: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Temporary Solution (smaller text)
                    Expanded(
                      child: SelectableText(
                        result,
                        style: TextStyle(
                          fontSize: 35,
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                        showCursor: false,
                        enableInteractiveSelection: true,
                        toolbarOptions: const ToolbarOptions(
                          copy: true,
                          selectAll: true,
                          cut: false,
                          paste: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.65,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Row 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.surfaceTint,
                          ),
                          child: Text(
                            "√",
                            style: TextStyle(
                              fontSize: 30,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.surfaceTint,
                          ),
                          child: Text(
                            "𝝿",
                            style: TextStyle(
                              fontSize: 30,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.surfaceTint,
                          ),
                          child: Text(
                            "^",
                            style: TextStyle(
                              fontSize: 30,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.surfaceTint,
                          ),
                          child: Text(
                            "!",
                            style: TextStyle(
                              fontSize: 30,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Row 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: onClearPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 121, 82, 54),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "AC",
                              style: TextStyle(
                                fontSize: 30,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 112, 73, 46),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "( )",
                              style: TextStyle(
                                fontSize: 30,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => onOperatorPressed('%'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 112, 73, 46),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "%",
                              style: TextStyle(
                                fontSize: 40,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => onOperatorPressed('÷'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 112, 73, 46),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "÷",
                              style: TextStyle(
                                fontSize: 50,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Row 3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => onDigitPressed('7'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 56, 36, 22),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "7",
                              style: TextStyle(
                                fontSize: 30,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => onDigitPressed('8'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 56, 36, 22),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "8",
                              style: TextStyle(
                                fontSize: 30,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => onDigitPressed('9'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 56, 36, 22),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "9",
                              style: TextStyle(
                                fontSize: 30,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => onOperatorPressed('×'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 112, 73, 46),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "×",
                              style: TextStyle(
                                fontSize: 50,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Row 4
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => onDigitPressed('4'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 56, 36, 22),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "4",
                              style: TextStyle(
                                fontSize: 30,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => onDigitPressed('5'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 56, 36, 22),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "5",
                              style: TextStyle(
                                fontSize: 30,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => onDigitPressed('6'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 56, 36, 22),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "6",
                              style: TextStyle(
                                fontSize: 30,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => onOperatorPressed('-'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 112, 73, 46),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "-",
                              style: TextStyle(
                                fontSize: 50,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Row 5
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => onDigitPressed('1'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 56, 36, 22),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "1",
                              style: TextStyle(
                                fontSize: 30,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => onDigitPressed('2'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 56, 36, 22),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "2",
                              style: TextStyle(
                                fontSize: 30,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => onDigitPressed('3'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 56, 36, 22),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "3",
                              style: TextStyle(
                                fontSize: 30,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => onOperatorPressed('+'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 112, 73, 46),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontSize: 50,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Row 6
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => onDigitPressed('0'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 56, 36, 22),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "0",
                              style: TextStyle(
                                fontSize: 30,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: onDecimalPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 56, 36, 22),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.topCenter,
                            child: Text(
                              ".",
                              style: TextStyle(
                                fontSize: 50,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: onBackspacePressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 56, 36, 22),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.backspace,
                              color: colorScheme.onSurface,
                              size: 30,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => onEqualsPressed(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 168, 72, 17),
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(85, 85),
                          ),
                          child: Container(
                            width: 85,
                            height: 85,
                            alignment: Alignment.center,
                            child: Text(
                              "=",
                              style: TextStyle(
                                fontSize: 50,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
