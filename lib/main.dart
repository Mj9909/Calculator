import 'package:calculator/colours.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main()
{
  runApp(const MaterialApp(
    home: CalculatorApp(),
  ));

}
class CalculatorApp extends StatefulWidget
{
  const CalculatorApp({Key? key}): super (key:key);
  @override
  State<CalculatorApp> createState()=> _CalculatorAppState();
}
class _CalculatorAppState extends State<CalculatorApp>
{
  double firstNum=0.0;
  double secondNum=0.0;
  var input='';
  var output='';
  var opertion ='';
  var hideInput = false;
  var outputSize=34.0;
  OnButtonClick(value)
  {
   if(value=="AC"){
     input='';
    output='';
   }
   else if (value=="<"){
     if(input.isNotEmpty) {
       input = input.substring(0, input.length - 1);
     }
   }
   else if (value =="="){
     if(input.isNotEmpty) {
       var userInput = input;
       userInput = input.replaceAll("x", "*");
       Parser p = Parser();
       Expression expression = p.parse(userInput);
       ContextModel cm = ContextModel();
       var finalValue = expression.evaluate(EvaluationType.REAL, cm);
       output = finalValue.toString();
      if(output.endsWith(".0"))
        {
          output = output.substring(0,output.length-2);
        }
      input=output;
      hideInput=true;
      outputSize=45;
     }

     }
   else{
     hideInput=false;
     outputSize=34;
     input=input+value;
   }
   setState(() {});
  }




  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body:Column(
        children:[

          //Output Area
          Expanded(
              child: 
              Container(
                width: double.infinity,
                  padding: const EdgeInsets.all(12),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ?'':input,

                    style:TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                  )
                  ,SizedBox(
                    height: 30,
                  )
                  ,Text(
                    output,
                    style:TextStyle(
                      fontSize:outputSize,

                      color: Colors.white.withOpacity(0.7),
                    ),
                  )
                  ,SizedBox(
                    height: 40,
                  )
                ],
              ),
              ),
          ),





          //Buttons Area
          Row(
            children: [
              button(text: "AC",
              buttonBgColor: operatorColor,
              tColor: orangeColor),
              button(text: "<",buttonBgColor: operatorColor,
                  tColor: orangeColor
              ),
              button(text: "",buttonBgColor: Colors.transparent),
              button(text: "/",buttonBgColor: operatorColor),
         ],
          )
          ,Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x",buttonBgColor: operatorColor),
            ],
          )
         , Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-",buttonBgColor: operatorColor),
            ],
          )
          ,Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+",buttonBgColor: operatorColor),
            ],
          )
          ,Row(
            children: [
              button(text: "%",buttonBgColor: operatorColor),
              button(text: "0",buttonBgColor: operatorColor),
              button(text: ".",buttonBgColor: operatorColor),
              button(text: "=",
                  buttonBgColor: Colors.orange,
                  ),
            ],
          )
    ],
      ),
    );
  }
  Widget button({
    text,tColor=Colors.white,buttonBgColor =buttonColor
})
  {
    return  Expanded(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(22),
                primary: buttonBgColor

            ),
            onPressed: ()=> OnButtonClick(text),
            child: Text(text , style: TextStyle(
                fontSize: 18,
                color: tColor,
                fontWeight: FontWeight.bold

            ),
            ),
          ),
        ));

  }
}