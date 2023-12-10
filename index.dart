import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screen/registerpage.dart';
import 'package:myapp/screen/secondscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MY FIRST PROJECT',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                
                SizedBox(height: 50),    //space
                
                Icon(Icons.lock, size: 100),  //lock icon
                
                SizedBox(height: 50),      //space
                
                Text("WELCOME BACK!"),

                const SizedBox(height:20),
                
                Text("LOG-IN",style:TextStyle(fontSize: 20)),

                const SizedBox(height:10),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height:30),

                TextField(
                  controller:passwordController,
                  obscureText: true,     //It hides the password as dotted
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height:15),
                
                Padding(padding: EdgeInsets.symmetric(horizontal: 25.0),
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.end,
                  children:[
                    Text("Forget password?",),
                    const SizedBox(height:20),
                  ]
                  
                )),

               GestureDetector(
  onTap: () 
    async {
      showDialog(context: context, builder: (context)=>const Center(
        child:CircularProgressIndicator()
      ));
    String enteredEmail = emailController.text.trim(); // Replace with your actual email input
    String enteredPassword = passwordController.text.trim(); // Replace with your actual password input
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: enteredEmail,
        password: enteredPassword,
      );
      // User successfully signed in
      print('User: ${userCredential.user}');
      // Navigate to the next screen or perform actions after login
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondScreen(home:Scaffold(appBar:AppBar(title:Text("hello"))),), // Navigate to your next screen
         
          ),
        );
      if (userCredential.user != null) {
        
        
      }
    } catch (e) {
      // Handle login errors
      showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator(),));
      Navigator.pop(context);
      showDialog(context: context, builder: (context)=>AlertDialog(title: Text("Invalid text",style: TextStyle(color: Colors.red),),));

    }
  },
  child: Container(
    height:48,
    width: 165,
    decoration: BoxDecoration(color: Colors.grey[850],borderRadius: BorderRadius.circular(10)),
    child:Column(
      children:[

      const SizedBox(height:10),
      Text("Sign in",style:TextStyle(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,)
              ]
              )
    // Your login button UI
  ),
),
       
                const SizedBox(height:25),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => register(regist: 
                          Scaffold(appBar: AppBar(title:Text("hello")),))
                    )
                    );
                  },
                  child: Column(
                    children: [
                      Text("Don't have an account"),
                      Text(
                        "Register now",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
              
            ),
            
          ),
          
        
        ),
        
      ),
      
    );
  }
}
